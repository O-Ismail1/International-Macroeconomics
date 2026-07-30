function FixedEffects=FE_function(X,tfe,rfe);
%FixedEffects function
%tfe is time-fixed effect, tfe==1 control for time-fixed effect tfe=[0,1]
%rfe is region-fixed effect, rfe==1 control for region-fixed effect,
 %rfe=[0,1]
 [n,i]=size(X);
 Y=X-tfe*mean(X,2)*ones(1,i);
 Y=Y-rfe*ones(n,1)*mean(Y);
 FixedEffects=Y;
 

 
 
 
 
 

