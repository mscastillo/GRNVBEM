

%% Initializing workspace

   close all force ;
   clear all ;
   clc ;
   addpath('FUNCTIONS') ;

%% Randomnes control

   seed = 0 ;
   RandStream.setGlobalStream( RandStream('mt19937ar','Seed',seed) ) ;
   randn( 'seed' , seed ) ;
   rand( 'seed' , seed ) ;

%% Output log

   disp( ['================================================'] ) ;
   disp( ['= Running AR1MA1-VBEM method for GRN inference ='] ) ;
   disp( ['================================================'] ) ; 
   disp(char(10)) ; disp( ['( use [Ctrl]+[C] to abort the execution )'] ) ;
 
%% Loading the data

   tic ; disp(char(10)) ;
   disp( [' # Choosing dataset...'] ) ;
   [ input_file,input_path ] = uigetfile( {'*.csv','Comma Separated Value (*.csv)'},'MultiSelect','off' ) ;
   file = strsplit( input_file,'.' ) ;
   data = dataset('file',[input_path, input_file],'delimiter',',','ReadObsNames',true) ;   
   Y = double(data) ;
   genes = get(data,'ObsNames') ; % samples = get(data(:,2:end),'VarNames') ;
   G = size(Y,1) ;
   N = size(Y,2) ;
   
%% Variables and parameters initialization

 % Performance parameters
   model = 'AR1MA1' ; % observational model
   epsilon = 1e-10 ;  % converge criteria threshold
   delta = 0.5 ;      % binary detection threshold
 % Output initialization
   X = nan(G) ;
   W = nan(G) ;
   GRN = cell(0,5) ;
 % Uninformative priors
   m_x = 0.5*ones(G,1) ;
   S_x = 0.25*eye(G) ;
   m_w = zeros(G,1) ;
   S_w = eye(G) ;
   a = 2 ;
   b = 1/a ;
 % Posterior hyperparameters initialization
   mu_x = cell(G,1) ;
   SIGMA_x = cell(G,1) ;
   mu_w = cell(G,1) ;
   SIGMA_w = cell(G,1) ;
   alpha = cell(G,1) ;
   beta = cell(G,1) ;
   
%% Hyperparameters learning

   toc ; disp(char(10)) ;
   for i = 1:G

      disp( strjoin([' - ',genes(i)],'') ) ;
      [ mu_x{i} , SIGMA_x{i} , mu_w{i} , SIGMA_w{i} , alpha{i} , beta{i} ] = HYPERPARAMETERS( model , epsilon , Y , i , m_x , S_x , m_w , S_w , a , b ) ;

   end%for
   
%% GRN inference

   toc ; disp(char(10)) ;
   for i = 1:G
      probability = POSTERIOR( mu_x{i},SIGMA_x{i} ) ;
      parents = find( probability >= delta ) ;
      if ( sum(parents) > 0 )
         X(parents,i) = 1 ;
         W(parents,i) = mu_w{i}(parents) ;
         for j = 1:numel(parents)
            if ( mu_w{i}(parents(j)) < 0 )
               GRN = [ GRN ; { genes{parents(j)} '-|' genes{i} mu_w{i}(parents(j)) probability(parents(j)) } ] ;
            else
               GRN = [ GRN ; { genes{parents(j)} '->' genes{i} mu_w{i}(parents(j)) probability(parents(j)) } ] ;
            end%if
         end%for
      end%if
   end%for
   
%% Output file (extended SIF)

   output_file = strjoin([file(1),'__AR1MA1_GRN_inference.txt'],'') ;
   fid = fopen(output_file,'w') ;
   fprintf( fid,'Parent - Child Weight Probability Score\n') ;
   for k = 1:size(GRN,1)
      GRN{k,6} = GRN{k,4}*GRN{k,5}/max(abs(prod(cell2mat(GRN(:,4:5)),2))) ;
      fprintf( fid,'%s %s %s %f %f %f\n',GRN{k,:} ) ;
   end%for
   fclose(fid) ;
  
