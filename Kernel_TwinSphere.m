
function [Accuracy,execution3,a,a2,shoa,shoa2,scores]=Kernel_TwinSphere(X1,y1,X1test,y1test,v1,c1,ssigma)

% **********************
% Kamelan Test khat be khat shode asttttt..
% *******************



execution3=0;
u=0;
v=0;
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
% % % %     
%%%%%%%%%%%%%%%%
% POSITIVE
% % %%%%%%%%%%%%%%
temp=2*v1/size(B,1)*K(B,A,ssigma,'gaussian');
temp1=sum(temp,1)';
temp2=temp1+(1-v1)*diag(K(A,A,ssigma,'gaussian'));
f=temp2;
f=-f;
H=K(A,A,ssigma,'gaussian');
%  be khater 1/2x'Hx+...
H=2*H;  
opts = optimset('Algorithm','active-set','Display','off');
aa(1:size(f,1),1)=c1/size(A,1);

%  bayad barrasi shavad
tic;
x = quadprog(H,f,[],[],ones(size(f,1),1)',1,zeros(size(f,1),1),aa,[],opts);
execution3=toc;
% x = quadprog(H,f,[],[],ones(size(f,1),1)',1,0,c1/size(A,1),[],opts);
% x = quSOR(H,f,,ones(size(f,1),1)',1,zeros(size(f,1),1),aa,[],opts);

a=[1/(1-v1)]*[(x'*A)-(v1/size(B,1)* ones(1,size(B,1))*B)];

% yaftane shoa
ttt=find(x>0 & x<c1/size(A,1));
A1=A(ttt,:);
 % % % % % % % % % % % % % % % % % % % % 
% % % % 
A1(:,size(A1,2)+1)=ones(size(A1,1),1);
xx=eye(size(A,2));
xx(size(A,2)+1,:)=-a;
A2=A1*xx;
% % % % diag ra eshtebah hesab kardid
A3=diag(K(A2,A2,ssigma,'linear'));
% % % % A3=diag(A2*A2');
A4=sum(A3);
% % % % % % % % % % % % % % % % % % % % % % % % 
zarib=1/size(A1,1);
A5=zarib*A4;
shoa=A5;

%%%%%%%%%%%%
% NEGATIVE
%%%%%%%%%%%%
v2=v1;
c2=c1;
temp111=2*v2/size(A,1)*K(A,B,ssigma,'gaussian');
temp112=sum(temp111,1)';
temp222=temp112+(1-v2)*diag(K(B,B,ssigma,'gaussian'));
f2=temp222;
f2=-f2;
H2=K(B,B,ssigma,'gaussian');
H2=2*H2;
opts = optimset('Algorithm','active-set','Display','off');
aa2(1:size(f2,1),1)=c2/size(B,1);

% barrasi shavad
tic;
x2 = quadprog(H2,f2,[],[],ones(size(f2,1),1)',1,zeros(size(f2,1),1),aa2,[],opts);
execution3=execution3+toc;
% x2 = quadprog(H2,f2,[],[],ones(size(f2,1),1)',1,0,c1/size(B,1),[],opts);

a2=[1/(1-v2)]*[(x2'*B)-(v2/size(A,1)* ones(1,size(A,1))*A)];

%yaftane shoa
ttt2=find(x2>0 & x2<c1/size(B,1));
A11=B(ttt2,:);
% % % % % % % % % % % % % % 
A11(:,size(A11,2)+1)=ones(size(A11,1),1);
xx2=eye(size(B,2));
xx2(size(B,2)+1,:)=-a2;
A22=A11*xx2; 
% % % % % % % diag ra eshtebah kardid
A32=diag(K(A22,A22,ssigma,'linear')); 
% % % % % % A32=diag(A22*A22'); 
A42=sum(A32);
% % % % % % % % % % % % % % % % % % 
zarib2=1/size(A11,1);
A555=zarib2*A42;
shoa2=A555;

% % % % % % % % % 
%%%%%%%%%%%%
% % % Ghabl az Testing bayad Execution gerefte shavad
% % execution3=toc;

%********************
%Test
%********************
ATest=X1test;
Ytest=y1test;

% % % % % 
ATest=[K(ATest,C,ssigma,'gaussian')];
% % % % % 


% % % % % % % % % % % % % %
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

% % % % % % for i=1:size(ATest,1)
% % % % % % %      tt=ATest(i,:);
% % % % % % %      term11(i)=K(tt-a,tt-a,ssigma);
% % % % % % %      term22(i)=K(tt-a2,tt-a2,ssigma);
% % % % % % term11(i)=K(xxTestPositive1(i,:),xxTestPositive1(i,:),ssigma,'linear');
% % % % % % term22(i)=K(xxTestNegative1(i,:),xxTestNegative1(i,:),ssigma,'linear');
% % % % % % % term11(i)=xxTestPositive1(i,:)*xxTestPositive1(i,:)';
% % % % % % % term22(i)=xxTestNegative1(i,:)*xxTestNegative1(i,:)';
% % % % % % end

term11=diag(K(xxTestPositive1(:,:),xxTestPositive1(:,:),ssigma,'linear'));
term22=diag(K(xxTestNegative1(:,:),xxTestNegative1(:,:),ssigma,'linear'));



FaselePositive=term11/shoa; 
FaseleNegative=term22/shoa2;
% % % % % % % %

% % % 
% % % ATest(:,3)=ones(size(ATest,1),1);
% % % xxTestPositive=[1 0 -a(1,1); 0 1 -a(1,2)];
% % % xxTestNegative=[1 0 -a2(1,1); 0 1 -a2(1,2)];
% % % A2TestPositive=ATest*xxTestPositive';
% % % A2TestNegative=ATest*xxTestNegative';
% % % 
% % % A3TestPositive=diag(K(A2TestPositive,A2TestPositive));
% % % % A4TestPositive=sum(A3TestPositive);
% % % A3TestNegative=diag(K(A2TestNegative,A2TestNegative));
% % % % A4TestNegative=sum(A3TestNegative);
% % % FaselePositive=A3TestPositive/shoa;
% % % FaseleNegative=A3TestNegative/shoa2;
Accuracy=0;
Accuracy=Accuracy+size(find(y1test(find (FaselePositive<=FaseleNegative))==1),1);
Accuracy=Accuracy+size(find(y1test(find (FaselePositive>FaseleNegative))==-1),1);
Accuracy=Accuracy/size(y1test,1);
% % % %     k=1;
% % % %     
% % % %         for i=0:0.1:5
% % % %             for j=-6:0.1:4
% % % %                 tt=[i,j];
% % % %         fasele=K1_TMSVM((tt-a),(tt-a),Class1_Data,Class2_Data,0.1);
% % % % %         fasele=fasele+K1_TMSVM((j-a(1,2)),(j-a(1,2)),Class1_Data,Class2_Data,0.1);
% % % %         
% % % % %         fasele=(i-a(1,1)).^2+(j-a(1,2)).^2;
% % % %         if fasele<=shoa
% % % %             fff(k)=i;
% % % %             ggg(k)=j;
% % % %             k=k+1;
% % % % %             plot(i,j,'x');
% % % %             hold on;
% % % %             aaaa=23;
% % % %         end
% % % %     end
% % % % end

Accuracy;


%  SCores for AUC
scores=zeros(size(y1test,1),1);
scores(find (FaselePositive<=FaseleNegative))=1;
scores(find(FaselePositive>FaseleNegative))=-1;

% % % % 


end