
function [Accuracy,execution3,a,a2,shoa,shoa2,scores]=Kernel_TwinEllipse_new(X1,y1,X1test,y1test,v1,c1,ssigma)
% **********************
% Kamelan Test khat be khat shode asttttt..
% *******************

% % **********************
execution3=0;
u=0;
v=0;
% % % % % % % % % % % % % % % % % % r
y1(find(y1==2))=-1;
y1test(find(y1test==2))=-1;
Class1_Index=find(y1==1);
Class2_Index=find(y1==-1);
Class1_Data=X1(Class1_Index,:);
Class2_Data=X1(Class2_Index,:);
A=Class1_Data;
B=Class2_Data;
% % % % % % % % 
C=[A;B];
A=[K(A,C,ssigma,'gaussian')];
B=[K(B,C,ssigma,'gaussian')];
Class1_Data=A;
Class2_Data=B;
% Class1_Data=K(X1(Class1_Index,:),C,ssigma);
% Class2_Data=K(X1(Class2_Index,:),C,ssigma);
% % % %   

% % % % % % % % % % % % % % % % % % %
% POSITIVE
%%%%%%%%%%%%%%

% % % % % % % % % % % % % % % % % % % % % % % % % % % % Twin Ellipse New
temp11=K1_TMSVM(B,A,Class1_Data,Class2_Data,ssigma,'gaussian');
temp111=sum(temp11,1)';
temp111=((v1/size(B,1))*(1/(1-v1)))*temp111;

temp112=K1_TMSVM(A,B,Class1_Data,Class2_Data,ssigma,'gaussian');
temp112=sum(temp112,2);
temp112=((v1/size(B,1))*(1/(1-v1)))*temp112;

temp113=diag(K1_TMSVM(A,A,Class1_Data,Class2_Data,ssigma,'gaussian'));
temp113=(2/(1-v1))*temp113;

f=temp111+temp112-temp113;
f=-f;
H=[(-(v1/size(B,1)))*(((1/(1-v1))).^2)+((1/(1-v1)).^2)]*K1_TMSVM(A,A,Class1_Data,Class2_Data,ssigma,'gaussian');
  
H=-H;
H=(H+H')/2;
H=2*H;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % 
% % % % % temp11=((v1/size(B,1))*(1/(1-v1)))*
% % % % temp11=(-(1/(1-v1)).^2*(2*v1/size(B,1)))*K1_TMSVM(B,A,Class1_Data,Class2_Data,ssigma,'gaussian');
% % % % temp111=sum(temp11,1)';
% % % % temp2=temp111-((2/(1-v1))*diag(K1_TMSVM(A,A,Class1_Data,Class2_Data,ssigma,'gaussian')));
% % % % f=temp2;
% % % % % % % f=-f;
% % % % % % % H=((1/(1-v1)).^2)*K1_TMSVM(A,A,Class1_Data,Class2_Data,ssigma,'gaussian');
% % % 
% % % % % % barrasi shavad dobare H
% % %     H=-H;
% % %     H=(H+H')/2;
% % %     H=2*H;
% % % % % % % % % % % % % % % % % % 

opts = optimset('Algorithm','active-set','Display','off');
aa(1:size(f,1),1)=c1/size(A,1);
% for ii=1:size(f,1)
%     aa(ii,1)=c1/size(A,1);
% end
%  x = quadprog(H,f,[],[],ones(size(f,1),1)',1,zeros(size(f,1),1),aa,[],opts);
tic;
 x = quadprog(H,f,[],[],ones(size(f,1),1)',1,zeros(size(f,1),1),aa,[],opts);
execution3=toc;
%************* yaftane markaz**
a=[1/(1-v1)]*[(x'*A)-(v1/size(B,1)* ones(1,size(B,1))*B)];

%********** yaftane shoa
ttt=find(x>0 & x<c1/size(A,1));
A1=A(ttt,:);
% % % % % % % % % % % % % % % % % % % % % 
A1(:,size(A1,2)+1)=ones(size(A1,1),1);
xx=eye(size(A,2));
xx(size(A,2)+1,:)=-a;
A2=A1*xx;
% % % % diag ra eshtebah hesab kardid
A3=diag(K1_TMSVM(A2,A2,Class1_Data,Class2_Data,ssigma,'linear'));
A4=sum(A3);
% % % % % % % % % % % % % % % % % % % % % % % % 
zarib=1/size(A1,1);
A5=zarib*A4;
 shoa=A5;
%**********
%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%
% % % % % % % % % 
% NEGATIVE
%%%%%%%%%%%%
v2=v1;
c2=c1;

% % % % % % % % % % % % % % % % % % % % % % % % % % % % Twin Ellipse New
temp211=K2_TMSVM(A,B,Class1_Data,Class2_Data,ssigma,'gaussian');
temp2111=sum(temp211,1)';
temp2111=((v2/size(A,1))*(1/(1-v2)))*temp2111;

temp2112=K2_TMSVM(B,A,Class1_Data,Class2_Data,ssigma,'gaussian');
temp2112=sum(temp2112,2);
temp2112=((v2/size(A,1))*(1/(1-v2)))*temp2112;

temp2113=diag(K2_TMSVM(B,B,Class1_Data,Class2_Data,ssigma,'gaussian'));
temp2113=(2/(1-v2))*temp2113;

f2=temp2111+temp2112-temp2113;
f2=-f2;
H2=[(-(v2/size(A,1)))*(((1/(1-v2))).^2)+((1/(1-v2)).^2)]*K2_TMSVM(B,B,Class1_Data,Class2_Data,ssigma,'gaussian');
  
H2=-H2;
H2=(H2+H2')/2;
H2=2*H2;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % 
% % % % % % % % 
% % % % % % % % 
% % % % % % % % temp211=(-(1/(1-v1)).^2*(2*v1/size(A,1)))*K2_TMSVM(A,B,Class1_Data,Class2_Data,ssigma,'gaussian');
% % % % % % % % temp2111=sum(temp211,1)';
% % % % % % % % temp22=temp2111-((2/(1-v1))*diag(K2_TMSVM(B,B,Class1_Data,Class2_Data,ssigma,'gaussian')));
% % % % % % % % 
% % % % % % % % f2=temp22;
% % % % % % % % f2=-f2;
% % % % % % % % 
% % % % % % % % H2=((1/(1-v1)).^2)*K2_TMSVM(B,B,Class1_Data,Class2_Data,ssigma,'gaussian');
% % % % % % % % % % % %  bayad barrasi shavad H
% % % % % % % %         H2=-H2;
% % % % % % % %         H2=(H2+H2')/2;
% % % % % % % %         H2=2*H2;
% % % % % % % % % % % % % % % % % % % % % % % 

opts2 = optimset('Algorithm','active-set','Display','off');
aa2(1:size(f2,1),1)=c2/size(B,1);
tic;
x2 = quadprog(H2,f2,[],[],ones(size(f2,1),1)',1,zeros(size(f2,1),1),aa2,[],opts2);
execution3=execution3+toc;
a2=[1/(1-v2)]*[(x2'*B)-(v2/size(A,1)* ones(1,size(A,1))*A)];

%********** yaftane shoa
ttt2=find(x2>0 & x2<c2/size(B,1));
A12=B(ttt2,:);
% % % % % %
% % % % % % % % % % % % % % 
A12(:,size(A12,2)+1)=ones(size(A12,1),1);
xx2=eye(size(B,2));
xx2(size(B,2)+1,:)=-a2;
A22=A12*xx2; 
% % % % % % % diag ra eshtebah kardid
A32=diag(K2_TMSVM(A22,A22,Class1_Data,Class2_Data,ssigma,'linear')); 
A42=sum(A32);
% % % % % % % % % % % % % % % % % % 
zarib2=1/size(A12,1);
A52=zarib2*A42;
shoa2=A52;
%**********

% % % % % % % % % 
%%%%%%%%%%%%
% % % Ghabl az Testing bayad Execution gerefte shavad
% % execution3=toc;

%********************
%Test
%********************
ATest=X1test;
Ytest=y1test;
% % % % % barrasi shavad
 ATest=[K(ATest,C,ssigma,'gaussian')];
% % % % % 
% % % % % % % % %
term11=zeros(size(ATest,1),1);
term22=zeros(size(ATest,1),1);
ATest1=ATest;
ATest1(:,size(ATest,2)+1)=1;
xxTestPositive=eye(size(ATest,2));
xxTestPositive(size(ATest,2)+1,:)=-a;
xxTestPositive1=ATest1*xxTestPositive;

xxTestNegative=eye(size(ATest,2));
xxTestNegative(size(ATest,2)+1,:)=-a2;
xxTestNegative1=ATest1*xxTestNegative;


% % % % % for i=1:size(ATest,1)
% % % % %         term11(i)=K1_TMSVM(xxTestPositive1(i,:),xxTestPositive1(i,:),Class1_Data,Class2_Data,ssigma,'linear');
% % % % %         term22(i)=K2_TMSVM(xxTestNegative1(i,:),xxTestNegative1(i,:),Class1_Data,Class2_Data,ssigma,'linear');
% % % % %         
% % % % % % end
% % % % % end

term11=diag(K1_TMSVM(xxTestPositive1(:,:),xxTestPositive1(:,:),Class1_Data,Class2_Data,ssigma,'linear'));
term22=diag(K2_TMSVM(xxTestNegative1(:,:),xxTestNegative1(:,:),Class1_Data,Class2_Data,ssigma,'linear'));


% term=sum(term11);
 FaselePositive=term11/shoa; 
 FaseleNegative=term22/shoa2;
% % % % % % % 
Accuracy=0;
Accuracy=Accuracy+size(find(y1test(find (FaselePositive<=FaseleNegative))==1),1);
Accuracy=Accuracy+size(find(y1test(find (FaselePositive>FaseleNegative))==-1),1);
Accuracy=Accuracy/size(y1test,1);

% % % % execution3=toc;
Accuracy;

%  SCores for AUC
scores=zeros(size(y1test,1),1);
scores(find (FaselePositive<=FaseleNegative))=1;
scores(find(FaselePositive>FaseleNegative))=-1;

% % % % 


end

