% % % % % % % % New Idea
% X1test=X1test2;
% y1test=y1test2;
% y1Train=y1Train2;
% X1Train=X1Train2;
% % % % % % % % % % % % % % % % % % % % % 

% plot(X1Train(y1Train==1,1),X1Train(y1Train==1,2),'. red',X1Train(y1Train==-1,1),X1Train(y1Train==-1,2),'x blue');

plot(X1CrossData(y1CrossData==1,1),X1CrossData(y1CrossData==1,2),'. red',X1CrossData(y1CrossData==-1,1),X1CrossData(y1CrossData==-1,2),'x blue');

% % % % % % % % % % 
% % % X1test=X1CrossData;
% % % y1test=y1CrossData;
% % % y1Train=y1CrossData;
% % % X1Train=X1CrossData;

% % % % % % % 
%  New Idea
% % % % 
X1test=X1test2;
X1Train=X1Train2;
% % % % % % % % % % 

hold on;

Class1_Index=find(y1Train==1);
Class2_Index=find(y1Train==-1);
Class1_Data=X1Train(Class1_Index,:);
Class2_Data=X1Train(Class2_Index,:);
A=Class1_Data;
B=Class2_Data;
% % % % % % % % TESVM
C=[A;B];
ATESVM=[K(A,C,paramTESVM(1,3),'gaussian')];
BTESVM=[K(B,C,paramTESVM(1,3),'gaussian')];
Class1_DataTESVM=ATESVM;
Class2_DataTESVM=BTESVM;
% % % % % % % % % % % % % % %  TESVM Linear
A=[K(A,C,paramTESVMLinear(1,3),'gaussian')];
B=[K(B,C,paramTESVMLinear(1,3),'gaussian')];
Class1_Data=A;
Class2_Data=B;

ssigma=paramTESVMLinear(1,3);


% Plot Ellipse
% 


% % % % % % % New Idea
% % % x1=[2:0.1:9];
% % % x2=[2:0.1:9];
% % % % % % % % % % % % % % % % % 



x1=[-3:0.1:3];
x2=[-3:0.1:3];
[X111 X222]=meshgrid(x1,x2);
flag=1;
flagSphere=1;
flagTWIN=1;
flagEllipse=1;
k=1;
kSphere=1;
kTWIN=1;
kEllipse=1;
m=1;
mSphere=1;
mTWIN=1;
mEllipse=1;
F1=0;
F2=0;
F1Sphere=0;
F2Sphere=0;
F1TWIN=0;
F2TWIN=0;
F1Ellipse=0;
F2Ellipse=0;
SeparatePointsContourSphere=zeros(size(x1,2),size(x1,2));
SeparatePointsContour=zeros(size(x1,2),size(x1,2));
SeparatePointsContourTWIN=zeros(size(x1,2),size(x1,2));
SeparatePointsContourEllipse=zeros(size(x1,2),size(x1,2));
for i=1:size(x1,2)
    for j=1:size(x1,2)
        %                 tt=[i,j];
 % % % % % % % % % % % % % % % % % % % % % 
% TESVM linear (Linear Ellipse)
% % % % % % % % % % % % % % % % % % % % % % 
        ATest=[K([X111(i,j),X222(i,j)],C,ssigma,'gaussian')];
   

        Fasele1=K1_TMSVM(ATest,ATest,Class1_Data,Class2_Data,paramTESVMLinear(1,3),'linear');
        Fasele2=K2_TMSVM(ATest,ATest,Class1_Data,Class2_Data,paramTESVMLinear(1,3),'linear');
        FaselePositive=Fasele1/FinalshoaTESVMLinear;
        FaseleNegative=Fasele2/Finalshoa2TESVMLinear;
        F1(m)=FaselePositive;
        F2(m)=FaseleNegative;
        m=m+1;
        temmp(i,j)=FaselePositive;
        temmp2(i,j)=FaseleNegative;
        
% % % % % % % %          jahai ke barabar ahstand Discriminant Boundary ast
% % % % % % % %  aslan mosavi dar nemiad!!!!!!!!
% % % % % % %         if (FaselePositive==FaseleNegative)
% % % % % % %             SeparatePointsContourEqual(i,j)=1;
% % % % % % %         else
% % % % % % %             SeparatePointsContourEqual(i,j)=0;
% % % % % % %         end
% % % % % % %         
        if FaselePositive<=FaseleNegative
            if (flag==0)
                SeparatePoints(k,1:2)=[X111(i,j),X222(i,j)];
                SeparatePointsContour(i,j)=1;
                k=k+1;
                flag=1;
            end
        else
            if (flag==1)
                SeparatePoints(k,1:2)=[X111(i,j),X222(i,j)];
                SeparatePointsContour(i,j)=1;
                k=k+1;
                flag=0;
            end
        end
% % % % % % % % % % % % % % % % % % % % % %  

 % % % % % % % % % % % % % % % % % % % % % 
% THSVM (Sphere)
% % % % % % % % % % % % % % % % % % % % % % 
        ATest=[K([X111(i,j),X222(i,j)],C,paramTHSVM(1,3),'gaussian')];
%         Fasele ta Shoa
        term11=zeros(size(ATest,1),1);
        term22=zeros(size(ATest,1),1);
        ATest1=ATest;
        ATest1(:,size(ATest,2)+1)=1;
        xxTestPositive=eye(size(ATest,2));
        xxTestPositive(size(ATest,2)+1,:)=-FinalaTHSVM;
        xxTestPositive1=ATest1*xxTestPositive;

        xxTestNegative=eye(size(ATest,2));
        xxTestNegative(size(ATest,2)+1,:)=-Finala2THSVM;
        xxTestNegative1=ATest1*xxTestNegative;
        % % % % % 
        Fasele1Sphere=K(xxTestPositive1,xxTestPositive1,paramTHSVM(1,3),'linear');
        Fasele2Sphere=K(xxTestNegative1,xxTestNegative1,paramTHSVM(1,3),'linear');
        FaselePositiveSphere=Fasele1Sphere/FinalshoaTHSVM;
        FaseleNegativeSphere=Fasele2Sphere/Finalshoa2THSVM; 
        F1Sphere(mSphere)=FaselePositiveSphere;
        F2Sphere(mSphere)=FaseleNegativeSphere;
        mSphere=mSphere+1;
        temmpSphere(i,j)=FaselePositiveSphere;
        temmp2Sphere(i,j)=FaseleNegativeSphere;
        if FaselePositiveSphere<=FaseleNegativeSphere
            if (flagSphere==0)
                SeparatePointsSphere(kSphere,1:2)=[X111(i,j),X222(i,j)];
                SeparatePointsContourSphere(i,j)=1;
                kSphere=kSphere+1;
                flagSphere=1;
            end
        else
            if (flagSphere==1)
                SeparatePointsSphere(kSphere,1:2)=[X111(i,j),X222(i,j)];
                SeparatePointsContourSphere(i,j)=1;
                kSphere=kSphere+1;
                flagSphere=0;
            end
        end
% % % % % % % % % % % % % % % %         
 % % % % % % % % % % % % % % % % % % % % % 
% TWSVM
% % % % % % % % % % % % % % % % % % % % % % 
AtestTwin=[X111(i,j),X222(i,j)];
    t1=U_TWSVM(1:size(X1Train,1),1)'*K(C,AtestTwin,paramTSVM(1,3),'gaussian')+U_TWSVM(size(X1Train,1)+1,1);
    t2=V_TWSVM(1:size(X1Train,1),1)'*K(C,AtestTwin,paramTSVM(1,3),'gaussian')+U_TWSVM(size(X1Train,1)+1,1);
    
    Fasele1TWIN=abs(t1)/sqrt(U_TWSVM(1:size(X1Train,1),1)'*U_TWSVM(1:size(X1Train,1),1));
    Fasele2TWIN=abs(t2)/sqrt(V_TWSVM(1:size(X1Train,1),1)'*V_TWSVM(1:size(X1Train,1),1));
    
    F1TWIN(mTWIN)=Fasele1TWIN;
    F2TWIN(mTWIN)=Fasele2TWIN;
    mTWIN=mTWIN+1;
    temmpTWIN(i,j)=Fasele1TWIN;
    temmp2TWIN(i,j)=Fasele2TWIN;
      if Fasele1TWIN<=Fasele2TWIN
            if (flagTWIN==0)
                SeparatePointsTWIN(kTWIN,1:2)=[X111(i,j),X222(i,j)];
                SeparatePointsContourTWIN(i,j)=1;
                kTWIN=kTWIN+1;
                flagTWIN=1;
            end
        else
            if (flagTWIN==1)
                SeparatePointsTWIN(kTWIN,1:2)=[X111(i,j),X222(i,j)];
                SeparatePointsContourTWIN(i,j)=1;
                kTWIN=kTWIN+1;
                flagTWIN=0;
            end
      end
        
        
% % % % % % % % % % % % % % % % % % % % % % 

 % % % % % % % % % % % % % % % % % % % % % 
% TESVM (Ellipse)
% % % % % % % % % % % % % % % % % % % % % % 
ATest=[K([X111(i,j),X222(i,j)],C,paramTESVM(1,3),'gaussian')];
%         Fasele ta Shoa
        term11=zeros(size(ATest,1),1);
        term22=zeros(size(ATest,1),1);
        ATest1=ATest;
        ATest1(:,size(ATest,2)+1)=1;
        xxTestPositive=eye(size(ATest,2));
        xxTestPositive(size(ATest,2)+1,:)=-FinalaTESVM;
        xxTestPositive1=ATest1*xxTestPositive;

        xxTestNegative=eye(size(ATest,2));
        xxTestNegative(size(ATest,2)+1,:)=-Finala2TESVM;
        xxTestNegative1=ATest1*xxTestNegative;
        % % % % % 
        Fasele1Ellipse=K1_TMSVM(xxTestPositive1,xxTestPositive1,Class1_DataTESVM,Class2_DataTESVM,paramTESVM(1,3),'linear');
        Fasele2Ellipse=K2_TMSVM(xxTestNegative1,xxTestNegative1,Class1_DataTESVM,Class2_DataTESVM,paramTESVM(1,3),'linear');
        
        FaselePositiveEllipse=Fasele1Ellipse/FinalshoaTESVM;
        FaseleNegativeEllipse=Fasele2Ellipse/Finalshoa2TESVM; 
        
        F1Ellipse(mEllipse)=FaselePositiveEllipse;
        F2Ellipse(mEllipse)=FaseleNegativeEllipse;
        mEllipse=mEllipse+1;
        
        temmpEllipse(i,j)=FaselePositiveEllipse;
        temmp2Ellipse(i,j)=FaseleNegativeEllipse;
        
        if FaselePositiveEllipse<=FaseleNegativeEllipse
            if (flagEllipse==0)
                SeparatePointsEllipse(kEllipse,1:2)=[X111(i,j),X222(i,j)];
                SeparatePointsContourEllipse(i,j)=1;
                kEllipse=kEllipse+1;
                flagEllipse=1;
            end
        else
            if (flagEllipse==1)
                SeparatePointsEllipse(kEllipse,1:2)=[X111(i,j),X222(i,j)];
                SeparatePointsContourEllipse(i,j)=1;
                kEllipse=kEllipse+1;
                flagEllipse=0;
            end
        end
% % % % % % % % % % % % % % % % % % 
    end
end



%
% % % % % % % 
%  baraye Plot kardane Distance ha az har do Hyperellipse
plot(F1(F1<=F2),F2(F1<=F2),'. red',F1(F1>F2),F2(F1>F2),'o blue');
plot(F1Sphere(F1Sphere<=F2Sphere),F2Sphere(F1Sphere<=F2Sphere),'. red',F1Sphere(F1Sphere>F2Sphere),F2Sphere(F1Sphere>F2Sphere),'o blue');
plot(F1TWIN(F1TWIN<=F2TWIN),F2TWIN(F1TWIN<=F2TWIN),'. red',F1TWIN(F1TWIN>F2TWIN),F2TWIN(F1TWIN>F2TWIN),'o blue');
plot(F1Ellipse(F1Ellipse<=F2Ellipse),F2Ellipse(F1Ellipse<=F2Ellipse),'. red',F1Ellipse(F1Ellipse>F2Ellipse),F2Ellipse(F1Ellipse>F2Ellipse),'o blue');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


% % % % % % 
%  baraye kamel kardane Separating hyperplane
for j=1:size(x1,2)
    for i=1:size(x1,2)
        %                 tt=[i,j];
        ATest=[K([X111(i,j),X222(i,j)],C,ssigma,'gaussian')];
        
        Fasele1=K1_TMSVM(ATest,ATest,Class1_Data,Class2_Data,paramTESVMLinear(1,3),'linear');
        Fasele2=K2_TMSVM(ATest,ATest,Class1_Data,Class2_Data,paramTESVMLinear(1,3),'linear');
        %                 k=k+1;
        
        FaselePositive=Fasele1/FinalshoaTESVMLinear;
        FaseleNegative=Fasele2/Finalshoa2TESVMLinear;
%         temmp(i,j)=FaselePositive;
%         temmp2(i,j)=FaseleNegative;
        


        if FaselePositive<=FaseleNegative
            if (flag==0)
                SeparatePoints(k,1:2)=[X111(i,j),X222(i,j)];
                 SeparatePointsContour(i,j)=1;

%                  plot(SeparatePoints(:,1),SeparatePoints(:,2))
                 hold on;
                k=k+1;
                flag=1;
                %                        temmp(i,j)=0;
                %                        temmp2(i,j)=0;
            end
        else
            if (flag==1)
                SeparatePoints(k,1:2)=[X111(i,j),X222(i,j)];
                 SeparatePointsContour(i,j)=1;
                k=k+1;
                flag=0;
                %                        temmp(i,j)=0;
                %                        temmp2(i,j)=0;
            end
        end
        
        
    end
end

% % % % %         
%      plot
% % % % % % % 
%  Taghriban Ok hastan  
% Ellipse Linewr
contour(X111,X222,temmp,1,'LineWidth',5,'color','blue');
hold on;
contour(X111,X222,temmp2,2,'LineWidth',5,'color','red');
contour(X111,X222,SeparatePointsContour,4,'LineWidth',0.001,'color','red','LineStyle','-')
% ***************

% Sphere
plot(X1test(y1test==1,1),X1test(y1test==1,2),'. red',X1test(y1test==-1,1),X1test(y1test==-1,2),'x blue');
hold on;
contour(X111,X222,temmpSphere,2,'LineWidth',5,'color','blue');
hold on;
contour(X111,X222,temmp2Sphere,1,'LineWidth',5,'color','red');
contour(X111,X222,SeparatePointsContourSphere,1,'LineWidth',6,'color','blue','LineStyle','-')
% % % % % % % % % % % % % % 

% TWIN
contour(X111,X222,temmpTWIN,2,'LineWidth',5,'color','blue');
hold on;
contour(X111,X222,temmp2TWIN,1,'LineWidth',5,'color','red');
contour(X111,X222,SeparatePointsContourTWIN,1,'LineWidth',6,'color','blue','LineStyle','-')


% Ellipse
plot(X1test(y1test==1,1),X1test(y1test==1,2),'. red',X1test(y1test==-1,1),X1test(y1test==-1,2),'x blue');
hold on;
contour(X111,X222,temmpEllipse,2,'LineWidth',5,'color','blue');
hold on;
contour(X111,X222,temmp2Ellipse,1,'LineWidth',5,'color','red');
contour(X111,X222,SeparatePointsContourEllipse,1,'LineWidth',6,'color','red','LineStyle','-')
% % % % % % % % % % % % % % 

% % % % % plot(SeparatePoints(:,1),SeparatePoints(:,2),'r+')
% % % % SeparatePointsContour(SeparatePointsContour(:,:)==1)=0.5
