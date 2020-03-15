
function [Accuracy,execution3,u,v,scores]=Kernel_TSVM_new(X1,y1,X1test,y1test,c1,c2,ssigma)
% OK hast
% % **********************
% % % tic;
execution3=0;
%****************************************************

c4=c1;
c5=c2;
% c6=c3;

%******************************************
% % % 
% % % % % % %        %****Normalizatiosn****************
% % % for i=1:size(X1,2)
% % %     if max(X1(:,i))==0
% % %         continue;
% % %     else
% % %         X1(:,i)=X1(:,i)/max(X1(:,i));
% % %     end
% % %     
% % % end
% % % % % % % % % % % %           %*******************************************
% % % 
% % % %      %****Normalizatiosn****************
% % % for i=1:size(X1test,2)
% % %     if max(X1test(:,i))==0
% % %         continue;
% % %     else
% % %         X1test(:,i)=X1test(:,i)/max(X1test(:,i));
% % %     end
% % %     
% % % end
% % % % % % % % % % % % % % %
% % % 

Class1_Index=find(y1==1);
Class2_Index=find(y1==-1);

Class1_Data=X1(Class1_Index,:);
Class2_Data=X1(Class2_Index,:);
% % % % % 
% % % % % % % % % 
% % % % % z1 = linkage(X1(Class1_Index,:),'ward','euclidean');
% % % % % z2 = linkage(X1(Class2_Index,:),'ward','euclidean');
% % % % % 
% % % % % CP=FindKneePoint(z1);
% % % % % CN=FindKneePoint(z2);
% % % % % 
% % % % % C1=cluster(z1,'maxclust',CP);
% % % % % C2=cluster(z2,'maxclust',CN);
% % % % % % % % % % % % % % % 
% 
% C1=clusterdata(X1(Class1_Index,:),'linkage','ward','maxclust',5);
% C2=clusterdata(X1(Class2_Index,:),'linkage','ward','maxclust',5);
% CP=5;
% CN=5;
% % % % % % % % % % % % 
e1=ones(size(Class1_Data,1),1);
e2=ones(size(Class2_Data,1),1);

%****************************

C=[Class1_Data;Class2_Data];
S=[K(Class1_Data,C,ssigma,'gaussian') e1]';
R=[K(Class2_Data,C,ssigma,'gaussian') e2]';
L=[K(Class1_Data,C,ssigma,'gaussian') e1]';
N=[K(Class2_Data,C,ssigma,'gaussian') e2]';
% % % [Z1,sigma1]=Sigma1(C,Class1_Data,Class1_Data,Class2_Data,CP,CN,ssigma,C1,C2);
% % % [Z2,sigma2]=Sigma2(C,Class2_Data,Class1_Data,Class2_Data,CP,CN,ssigma,C1,C2);

%****************************


%*****************************************

I1=eye(size(S*S',1));

c2I=c2*I1;
% c3J=c3*Z1;

% SS=S*S';
inverseQQc5Ic6F=inv(S*S'+c2I);
PinverseQQc5Ic6F=R'*inverseQQc5Ic6F;
PinverseQQc5Ic6FP=PinverseQQc5Ic6F*R;



c1e2=c1*e2;

tic;
alpha1 = qpSOR(PinverseQQc5Ic6FP,0.5,c1,0.05);
execution3=toc;
% [nsv1, alpha1, b01 , executiontime1] = svcS_TWSVM(X1(Class2_Index,:),y1(Class2_Index,:),'linear',c1e2,PinverseQQc5Ic6FP);
% [nsv, alpha, b0 ,executiontime1] = svcS_TWSVM(X1(Class2_Index,:),y1(Class2_Index,:),'linear',c1e2,GinverseHHc2Ic3JG);

%***********************************************
I5=eye(size(N*N',1));
c5I=c5*I5;
% % % c6F=c6*Z2;

% SS=N*N';
inverseSSc4Ic5F=inv(N*N'+c5I);
MinverseSSc4Ic5F=L'*inverseSSc4Ic5F;
MinverseSSc4Ic5FM=MinverseSSc4Ic5F*L;

c4e1=c4*e1;

tic;
alpha2 = qpSOR(MinverseSSc4Ic5FM,0.5,c4,0.05);
execution3=execution3+toc;
% [nsv2, alpha2, b02 , executiontime2] = svcS_TWSVM(X1(Class1_Index,:),y1(Class1_Index,:),'linear',c4e1,MinverseSSc4Ic5FM);
% [nsv, alpha, b0 ,executiontime1] = svcS_TWSVM(X1(Class2_Index,:),y1(Class2_Index,:),'linear',c1e2,GinverseHHc2Ic3JG);


%***********************************************



%****************************
%Find Twin StructuralSVMs
%*****************
u=-(S*S'+c2I)\R*alpha1;

% STWSVM1=X1(:,:)*u(1:size(X1,2),1)+u(size(X1,2)+1,1);


v=(N*N'+c5I)\(L*alpha2);

% STWSVM2=X1(:,:)*v(1:size(X1,2),1)+v(size(X1,2)+1,1);


%***************************


% % % % execution3=toc;

%***************************
% Test
%*******************************

TedadDataTest=size(X1test,1);

error=0;
Class1=0;
Class2=0;
% for ii=1:TedadDataTest
    
    
% % %     t1=u(1:size(X1,2),1)'*inv(Covariance1Final+c1*II)*X1test(i,:)'+u(size(X1,2)+1,1);
% % %     t2=v(1:size(X1,2),1)'*inv(Covariance2Final+c2*II)*X1test(i,:)'+v(size(X1,2)+1,1);

%  t1=K1(u(1:size(X1,1),1)',X1test(ii,:),Class1_Data,Class2_Data,CP,CN,2,C1,C2)+u(size(X1,1)+1,1);

% % % %     t1=u(1:size(X1,1),1)'*K(C,X1test(ii,:),ssigma)+u(size(X1,1)+1,1);
% % % %     t2=v(1:size(X1,1),1)'*K(C,X1test(ii,:),ssigma)+v(size(X1,1)+1,1);



%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %     t1=u(1:size(X1,1),1)'*K(C,X1test,ssigma)+u(size(X1,1)+1,1);
% % %     t2=v(1:size(X1,1),1)'*K(C,X1test,ssigma)+v(size(X1,1)+1,1);

    t1=u(1:size(X1,1),1)'*K(C,X1test,ssigma,'gaussian')+u(size(X1,1)+1,1);
    t2=v(1:size(X1,1),1)'*K(C,X1test,ssigma,'gaussian')+v(size(X1,1)+1,1);
% %%%%%%%%%%%%%%%%%%%%%%%
% % % % % % %     t1=u(1:size(X1,1),1)'*K1(C,X1test(ii,:),Class1_Data,Class2_Data,CP,CN,2,C1,C2)+u(size(X1,1)+1,1);
% % % % % % %     t2=v(1:size(X1,1),1)'*K2(C,X1test(ii,:),Class1_Data,Class2_Data,CP,CN,2,C1,C2)+v(size(X1,1)+1,1);
% % %     
   
%     PrenDistance1=abs(t1)/sqrt(u(1:size(X1,1),1)'*u(1:size(X1,1),1));
%     PrenDistance2=abs(t2)/sqrt(v(1:size(X1,1),1)'*v(1:size(X1,1),1));
% 
% l1=size(Class1_Data,1);
% e=ones(size(Class1_Data,1),1);
% Jp=(1/l1)*(eye(size(Class1_Data,1))-((1/l1)*(e*e')));

% % 
% % l2=size(Class2_Data,1);
% % e=ones(size(Class2_Data,1),1);
% % Jn=(1/l2)*(eye(size(Class2_Data,1))-((1/l2)*(e*e')));
A=Class1_Data;
B=Class2_Data;
% % % sigma1=K(C,A,ssigma)*Jp*K(A,C,ssigma);
% % % 
% % % sigma2=K(C,B,ssigma)*Jn*K(B,C,ssigma);

    PrenDistance1=abs(t1)/sqrt(u(1:size(X1,1),1)'*u(1:size(X1,1),1));
    PrenDistance2=abs(t2)/sqrt(v(1:size(X1,1),1)'*v(1:size(X1,1),1));
%         PrenDistance1=abs(t1)/sqrt(u(1:size(X1,1),1)'*inv(sigma1)*u(1:size(X1,1),1));
%         PrenDistance2=abs(t2)/sqrt(v(1:size(X1,1),1)'*inv(sigma2)*v(1:size(X1,1),1));;


%     PrenDistance1=abs(t1)/sqrt(u(1:size(X1,2),1)'*inv(Covariance1Final+c1*II)*u(1:size(X1,2),1));
%     PrenDistance2=abs(t2)/sqrt(v(1:size(X1,2),1)'*inv(Covariance2Final+c2*II)*v(1:size(X1,2),1));
%     
    
%%%%%%%%%%%%%%%%%%%
for ii=1:TedadDataTest
     if (y1test(ii,1)==-1) &&  (min(PrenDistance1(ii),PrenDistance2(ii))==PrenDistance1(ii))
        
        error=error+1;
        
    end
    
    
    if (y1test(ii,1)==1) && (min(PrenDistance1(ii),PrenDistance2(ii))==PrenDistance2(ii))
        
        
        error=error+1;
    end
end
%%%%%%%%%%%%%%
   
    
% end
Accuracy=0;
execution=0;
Accuracy=(size(y1test,1)-error)/size(y1test,1);
% execution=executiontime1+executiontime2;
% execution3=cputime-st;



%  SCores for AUC
scores=zeros(size(y1test,1),1);
scores(find (PrenDistance1<=PrenDistance2))=1;
scores(find(PrenDistance1>PrenDistance2))=-1;

% % % % 



end
