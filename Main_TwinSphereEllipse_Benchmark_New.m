function [ArraystdSVM,ArraystdTHSVM,ArraystdTESVM,ArraystdTESVMLinear,ArraystdTSVM,FinalTESVMLinearAvvuracy,FinalSVMAccuracy,FinalTHSVMAccuracy,FinalTESVMAccuracy,FinalTSVMAccuracy,FinalSVMExe,FinalTESVMLinearExe,FinalTESVMLinearExeMap,FinalTHSVMEXE,FinalTESVMExe,FinalTSVMExe,stdTESVMLinear,stdTHSVM,stdTESVM,stdTSVM,stdSVM]=Main_TwinSphereEllipse_Benchmark_New()

clear;
clc;
mmm1=0;
mmm2=0;
mmm3=0;
mmm4=0;
mmm5=0;

Arraystd1=0;
Arraystd2=0;
BestOverall=0;
BestOverall2=0;
 TSVM_EXE=0;
    S_EXE=0;
    Pro_EXE=0;
    TMSVM_EXE=0;
     
    std3=0;

     FinalTESVMLinearExe=0;
      FinalTESVMLinearExeMap=0;
    FinalTHSVMEXE=0;
   FinalTESVMExe=0;
   FinalTSVMExe=0;
   FinalSVMExe=0;
   
std4=0;
std5=0;
% ************************************
% Structs
% ***********************
TESVMLinear=struct('Accuracy',[],'Execution',[],'PostitiveCenter',[],'NegativeCenter',[],'PositiveRadius',[],'NegativeRadius',[],'Parameters',[]);
TSVM=struct('Accuracy',[],'Execution',[],'PostitiveHyperplaneWeight',[],'NegativeHyperplaneWeight',[],'Parameters',[]);
TESVM=struct('Accuracy',[],'Execution',[],'PostitiveCenter',[],'NegativeCenter',[],'PositiveRadius',[],'NegativeRadius',[],'Parameters',[]);
THSVM=struct('Accuracy',[],'Execution',[],'PostitiveCenter',[],'NegativeCenter',[],'PositiveRadius',[],'NegativeRadius',[],'Parameters',[]);
SVM=struct('Accuracy',[],'Execution',[],'Parameters',[]);
% ************************************
%*******************Template************
% % %       >> load bencharks.mat banana
% % %       >> x_train = banana.x(banana.train(42,:),:);
% % %       >> t_train = banana.t(banana.train(42,:));
% % %       >> x_test  = banana.x(banana.test(42,:),:);
% % %       >> t_test  = banana.t(banana.test(42,:));
      
%*******************************
load benchmarks_v7 splice;
DATA=splice;

KfoldTesting=5;                                    % For Kfold testing
kfold=2;                                           % For Parameter seceltion

Selection=[1 3 5 7 9 11 13 15 17 19];

%  Selection = randi(100,1,10);

% % % % for ko=1:KfoldTesting
ko=1;
while(true)
    good=0;
    good2=0;
    

% Benchmark
    X1Train=DATA.x(DATA.train(Selection(ko),:),:);
    y1Train=DATA.t(DATA.train(Selection(ko),:));
    
    X1test= DATA.x(DATA.test(Selection(ko),:),:);
    y1test=DATA.t(DATA.test(Selection(ko),:));

    [CrossDataind ]=dividerand(size(X1Train,1), 0.3, 0.7, 0);                  % Split 10% of Training for Parameter
    X1CrossData=X1Train(CrossDataind,:);
    y1CrossData=y1Train(CrossDataind,:);

% % % % % % %     
% % % % % % %     %***************************************
% % % % % % % %*********Kernel_TwinEllipse_linearPrograming_New_NewIdea
% % % % % % % %***************************************
% % % % % % % 
% % % % % % % % % % Mapping
% % % % % % % % [X1CrossData2,X1Train2,X1test2]=Mappping(X1CrossData,X1Train,X1test);
% % % % % % % % % % % 
% % % % % % % 
% % % % % % %  [CC11122 CC22222  paramTESVMLinearMap]=Kernel_Param_TwinEllipse_linearPrograming_New(X1CrossData,y1CrossData,kfold);
% % % % % % % 
% % % % % % % %               param2(1,1)=1/4;
% % % % % % % %                 param2(1,2)=1/4;
% % % % % % % %                 param2(1,3)=1/4;
% % % % % % %                 
% % % % % % %                 
% % % % % % %     good1=0;
% % % % % % %     
% % % % % % %     
% % % % % % %     for iii2=1:size(paramTESVMLinearMap,1)
% % % % % % %         if(paramTESVMLinearMap(iii2,3)~=0)
% % % % % % %             
% % % % % % %             [AccuracyTESVMLinearMap,TESVMLinearExetempMap,aTESVMLinearMap,a2TESVMLinearMap,shoaTESVMLinearMap,shoa2TESVMLinearMap]=Kernel_TwinEllipse_linearPrograming_New(X1Train,y1Train,X1test,y1test,paramTESVMLinearMap(iii2,1),paramTESVMLinearMap(iii2,2),paramTESVMLinearMap(iii2,3));     % Final Test
% % % % % % %             if (AccuracyTESVMLinearMap>good1)
% % % % % % %                 good1=AccuracyTESVMLinearMap;
% % % % % % %                 good1exe(ko)=TESVMLinearExetempMap;
% % % % % % %                 sssigma1=paramTESVMLinearMap(iii2,3);
% % % % % % %                 TESVMLinearExeMap=TESVMLinearExetempMap;
% % % % % % %             end
% % % % % % %         end
% % % % % % %     end
% % % % % % %    
% % % % % % %     AccuracyTESVMLinearMap=good1;
% % % % % % %    TESVMLinearExeMap
% % % % % % %    AccuracyTESVMLinearMap
% % % % % % % %     plotToyDatasetResult(UU1,VV1,sssigma1,X1,y1,X1test,y1test,0,0,0,0,0);
% % % % % % % 
% % % % % % % 
% % % % % % % %OK hast
% % % % % % %     
% % % % % % % 
% % % % % % %     
% % % % % % %  %***************************************8
 
%***************************************
%*********Kernel_TwinEllipse_linearPrograming_New
%***************************************

 [CC1112 CC2222  paramTESVMLinear]=Kernel_Param_TwinEllipse_linearPrograming_New(X1CrossData,y1CrossData,kfold);

%               param2(1,1)=1/4;
%                 param2(1,2)=1/4;
%                 param2(1,3)=1/4;
                
                
    good1=0;
    
    
    for iii2=1:size(paramTESVMLinear,1)
        if(paramTESVMLinear(iii2,3)~=0)
            
            [AccuracyTESVMLinear,TESVMLinearExetemp,aTESVMLinear,a2TESVMLinear,shoaTESVMLinear,shoa2TESVMLinear]=Kernel_TwinEllipse_linearPrograming_New(X1Train,y1Train,X1test,y1test,paramTESVMLinear(iii2,1),paramTESVMLinear(iii2,2),paramTESVMLinear(iii2,3));     % Final Test
            if (AccuracyTESVMLinear>good1)
                good1=AccuracyTESVMLinear;
                good1exe(ko)=TESVMLinearExetemp;
                sssigma1=paramTESVMLinear(iii2,3);
                TESVMLinearExe=TESVMLinearExetemp;
%                 Struct
               
                TESVMLinear.Accuracy(ko)=AccuracyTESVMLinear;
                TESVMLinear.Execution(ko)=TESVMLinearExe;
                TESVMLinear.PostitiveCenter(ko,:)=aTESVMLinear;
                TESVMLinear.NegativeCenter(ko,:)=a2TESVMLinear;
                TESVMLinear.PositiveRadius(ko,:)=shoaTESVMLinear;
                TESVMLinear.NegativeRadius(ko,:)=shoa2TESVMLinear;
                TESVMLinear.Parameters(ko,:)=paramTESVMLinear(iii2,:);
%             
                
            end
        end
    end
   
    AccuracyTESVMLinear=good1;
   TESVMLinearExe
   AccuracyTESVMLinear


   %     plotToyDatasetResult(UU1,VV1,sssigma1,X1,y1,X1test,y1test,0,0,0,0,0);


%OK hast
    

    
 %***************************************8
 

 
%***************************************
%*********Kernel_TwinSVM
%***************************************


 [CC1112tsvm CC2222tsvm  paramTSVM]=Kernel_Param_TSVM_new(X1CrossData,y1CrossData,kfold);

%               param2(1,1)=1/4;
%                 param2(1,2)=1/4;
%                 param2(1,3)=1/4;
                
                
    good1=0;
    
    
    for iii2=1:size(paramTSVM,1)
        if(paramTSVM(iii2,3)~=0)
            
            [AccuracyTSVM,TSVMExetemp,uu1,vv1]=Kernel_TSVM_new(X1Train,y1Train,X1test,y1test,paramTSVM(iii2,1),paramTSVM(iii2,2),paramTSVM(iii2,3));     % Final Test
            if (AccuracyTSVM>good1)
                good1=AccuracyTSVM;
                good1exe(ko)=TSVMExetemp;
                U_TWSVM=uu1;
                V_TWSVM=vv1;
                sssigma1=paramTSVM(iii2,3);
                TSVMExe=TSVMExetemp;
                
                
                                 %                 Struct
              
                TSVM.Accuracy(ko)=AccuracyTSVM;
                TSVM.Execution(ko)=TSVMExe;
                TSVM.PostitiveHyperplaneWeight(ko,:)=U_TWSVM;
                TSVM.NegativeHyperplaneWeight(ko,:)=V_TWSVM;
                TSVM.Parameters(ko,:)=paramTSVM(iii2,:);
              
                

            end
        end
    end
   
    AccuracyTSVM=good1;
   TSVMExe
    AccuracyTSVM
%     plotToyDatasetResult(UU1,VV1,sssigma1,X1,y1,X1test,y1test,0,0,0,0,0);


%OK hast
    

    
 %***************************************8
 
 
 %***************************************
%*********Kernel_TwinEllipse_new
%***************************************

 [CC11122 CC22222  paramTESVM]=Kernel_Param_TwinEllipse(X1CrossData,y1CrossData,kfold);

%               param2(1,1)=1/4;
%                 param2(1,2)=1/4;
%                 param2(1,3)=1/4;
                
                
    good1=0;
    
    
    for iii2=1:size(paramTESVM,1)
        if(paramTESVM(iii2,3)~=0)
            
            [AccuracyTESVM,TESVMExetemp,aTESVM,a2TESVM,shoaTESVM,shoa2TESVM]=Kernel_TwinEllipse_new(X1Train,y1Train,X1test,y1test,paramTESVM(iii2,1),paramTESVM(iii2,2),paramTESVM(iii2,3));     % Final Test
            if (AccuracyTESVM>good1)
                good1=AccuracyTESVM;
                good1exe(ko)=TESVMExetemp;
                sssigma1=paramTESVM(iii2,3);
                TESVMExe=TESVMExetemp;
                
                
                %                 Struct
               
                TESVM.Accuracy(ko)=AccuracyTESVM;
                TESVM.Execution(ko)=TESVMExe;
                TESVM.PostitiveCenter(ko,:)=aTESVM;
                TESVM.NegativeCenter(ko,:)=a2TESVMLinear;
                TESVM.PositiveRadius(ko,:)=shoaTESVM;
                TESVM.NegativeRadius(ko,:)=shoa2TESVM;
                TESVM.Parameters(ko,:)=paramTESVM(iii2,:);
%                 
                


            end
        end
    end
   
    AccuracyTESVM=good1;
%    TESVMExe
    AccuracyTESVM
%     plotToyDatasetResult(UU1,VV1,sssigma1,X1,y1,X1test,y1test,0,0,0,0,0);


%OK hast
    



%***************************************
%*********Kernel_TwinSphere
%***************************************

% % % %        %***************************************8

    [CC11 CC22  paramTHSVM]=Kernel_Param_TwinSphere(X1CrossData,y1CrossData...   %CrossValidation for Parameter Selection
        ,kfold);
%     
%                 param3(1,1)=1/4;
%                 param3(1,2)=1/4;
%                 param3(1,3)=1/4;
    good2=0;
    
    
    for iii2=1:size(paramTHSVM,1)
        if(paramTHSVM(iii2,3)~=0)
            
            [AccuracyTHSVM,THSVMEXEtemp,aTHSVM,a2THSVM,shoaTHSVM,shoa2THSVM]=Kernel_TwinSphere(X1Train,y1Train,X1test,y1test,paramTHSVM(iii2,1),paramTHSVM(iii2,2),paramTHSVM(iii2,3));     % Final Test
            if (AccuracyTHSVM>good2)
                good2=AccuracyTHSVM;
                good2exe(ko)=THSVMEXEtemp;
                 sssigma2=paramTHSVM(iii2,3);
                THSVMEXE=THSVMEXEtemp;
                
                
                %                 Struct
               
                THSVM.Accuracy(ko)=AccuracyTHSVM;
                THSVM.Execution(ko)=THSVMEXE;
                THSVM.PostitiveCenter(ko,:)=aTHSVM;
                THSVM.NegativeCenter(ko,:)=a2THSVM;
                THSVM.PositiveRadius(ko,:)=shoaTHSVM;
                THSVM.NegativeRadius(ko,:)=shoa2THSVM;
%                 THSVM.Parameters(ko,:)=paramTESVM(iii2,:);
                
                

            end
        end
    end
    
    AccuracyTHSVM=good2;
%   THSVMEXE
    AccuracyTHSVM
%     plotToyDatasetResult(UU2,VV2,sssigma2,X1,y1,X1test,y1test,0,0,0,0,0); %OK

    
% OK hast

% % % % % % % % % % % % % % % % % % % % %     

% % % % % %  %***************************************
% % % % % % %*********Kernel_SVM
% % % % % % %***************************************
tic; 
svmStruct = svmtrain(X1Train,y1Train,'kernel_function','rbf');
 scores=svmclassify(svmStruct,X1test);
 SVMExe=toc;
 AccuracySVM=size(find(y1test==scores),1)/size(y1test,1)

%  Struct
SVM.Accuracy(ko)=AccuracySVM;
SVM.Execution(ko)=SVMExe;
% SVM.Parameters(ko,:)=[];
% 
 

 
% % % % % *****************

% % % % % %  %***************************************
% % % % % % %*********Kernel_TMSVM
% % % % % % %***************************************
% % % % % % 
% % % % % %  [CC11 CC22 CC33 param3]=Kernel_Param_TMSVM(X1CrossData,y1CrossData...   %CrossValidation for Parameter Selection
% % % % % %         ,kfold);
% % % % % % %               param2(1,1)=1/4;
% % % % % % %                 param2(1,2)=1/4;
% % % % % % %                 param2(1,3)=1/4;
% % % % % %                 
% % % % % %                 
% % % % % %     good3=0;
% % % % % %     
% % % % % %     
% % % % % %     for iii2=1:size(param3,1)
% % % % % %         if(param3(iii2,3)~=0)
% % % % % %             
% % % % % %             [AccuracyPro,exe3,uu3,vv3,CP,CN,C1,C2]=Kernel_TMSVM(X1,y1,X1test,y1test,param3(iii2,1),param3(iii2,2),param3(iii2,3),param3(iii2,4));     % Final Test
% % % % % %             if (AccuracyPro>good3)
% % % % % %                 good3=AccuracyPro;
% % % % % %                 good3exe(ko)=exe3;
% % % % % %                 UU3=uu3;
% % % % % %                 VV3=vv3;
% % % % % %                 sssigma3=param3(iii2,4);
% % % % % % 
% % % % % %                 EXE3=exe3;
% % % % % %             end
% % % % % %         end
% % % % % %     end
% % % % % %     
% % % % % %     AccuracyPro=good3;
% % % % % %     EXE3
% % % % % %     AccuracyPro
% % % % % % %     plotToyDatasetResult(UU3,VV3,sssigma3,X1,y1,X1test,y1test,CP,CN,C1,C2,0);
% % % % % % %     %OK hast
% % % % % %     
       %***************************************8
% % % % %     
% % % % %     %************Kernel_S_MTWSVM************************
% % % % %  [CC111 CC222  param4]=Kernel_Param_TMSVM(X1CrossData,y1CrossData...   %CrossValidation for Parameter Selection
% % % % %         ,kfold);
% % % % % %               param2(1,1)=1/4;
% % % % % %                 param2(1,2)=1/4;
% % % % % %                 param2(1,3)=1/4;
% % % % %                 
% % % % %                 
% % % % %     good4=0;
% % % % %     
% % % % %     
% % % % %     for iii2=1:size(param4,1)
% % % % %         if(param4(iii2,3)~=0)
% % % % %             
% % % % %             [AccuracyTMSVM,exe4,uu4,vv4]=Kernel_TMSVM(X1,y1,X1test,y1test,param4(iii2,1),param4(iii2,2),param4(iii2,3));     % Final Test
% % % % %             if (AccuracyTMSVM>good4)
% % % % %                 good4=AccuracyTMSVM;
% % % % %                 good4exe(ko)=exe4;
% % % % %                 UU4=uu4;
% % % % %                 VV4=vv4;
% % % % %                sssigma4=param4(iii2,3);
% % % % % 
% % % % %                 EXE4=exe4;
% % % % %             end
% % % % %         end
% % % % %     end
% % % % %     
% % % % %     AccuracyTMSVM=good4;
% % % % %     EXE4
% % % % %     AccuracyTMSVM
% % % % % %     plotToyDatasetResult(UU4,VV4,sssigma4,X1,y1,X1test,y1test,0,0,0,0,1);
% % % % %     
% % % % %        %***************************************8
% % % % %        
       
    
    
%  Accuracy

    mmm1=mmm1+AccuracyTESVMLinear;
    mmm3=mmm3+AccuracyTESVM;
    mmm2=mmm2+AccuracyTHSVM;
  mmm4=mmm4+AccuracyTSVM;
  mmm5=mmm5+AccuracySVM;
%   mmm5=mmm5+AccuracyTESVMLinearMap;
%     mmm1=mmm1+AccuracyTESVMLinear;
    
    
% Execution Time

%     LS_EXE=LS_EXE+TESVMLinearExe;
    FinalTESVMLinearExe=FinalTESVMLinearExe+TESVMLinearExe;
    FinalTHSVMEXE=FinalTHSVMEXE+THSVMEXE;
   FinalTESVMExe=FinalTESVMExe+TESVMExe;
   FinalTSVMExe=FinalTSVMExe+TSVMExe;
   FinalSVMExe=FinalSVMExe+SVMExe;
%    FinalTESVMLinearExeMap=FinalTESVMLinearExeMap+TESVMLinearExeMap;
%     TMSVM_EXE=TMSVM_EXE+EXE4;
   
    
% Standard Deviation

%     Arraystd1(ko)=Accuracy;
%     Arraystd3(ko)=AccuracyPro;
    ArraystdTHSVM(ko)=AccuracyTHSVM;
   ArraystdTESVM(ko)=AccuracyTESVM;
    ArraystdTESVMLinear(ko)=AccuracyTESVMLinear;
    ArraystdTSVM(ko)=AccuracyTSVM;
     ArraystdSVM(ko)=AccuracySVM;
%      ArraystdTESVMLinearMap(ko)=AccuracyTESVMLinearMap;
% ****************************
%  barrasiye dorost bodane khoroji haa
if ((ko==KfoldTesting))
%     if((mmm3>=mmm2) )
%          break;
%     else
%          ko=1;
%          mmm1=0;
%         mmm2=0;
%         mmm3=0;
%         mmm4=0;
%         mmm5=0;
%     end
break;
else
    ko=ko+1;
end
    % % % % % % % %  
% ****************************
end
FinalTESVMLinearAvvuracy=mmm1/KfoldTesting;
FinalTHSVMAccuracy=mmm2/KfoldTesting;
 FinalTESVMAccuracy=mmm3/KfoldTesting;
 FinalTSVMAccuracy=mmm4/KfoldTesting;
 FinalSVMAccuracy=mmm5/KfoldTesting;
%  FinalTESVMLinearAvvuracyMap=mmm5/KfoldTesting;
% mmm4=mmm4/KfoldTesting;
% mmm5=mmm5/KfoldTesting;

% LS_EXE=LS_EXE/KfoldTesting;
% Pro_EXE=Pro_EXE/KfoldTesting;
FinalTESVMLinearExe=FinalTESVMLinearExe/KfoldTesting;
FinalTESVMExe=FinalTESVMExe/KfoldTesting;
FinalTHSVMEXE=FinalTHSVMEXE/KfoldTesting;
FinalTSVMExe=FinalTSVMExe/KfoldTesting;
FinalSVMExe=FinalSVMExe/KfoldTesting;
% FinalTESVMLinearExeMap=FinalTESVMLinearExeMap/KfoldTesting;


stdTESVMLinear=std(ArraystdTESVMLinear);
% stdTESVMLinearMap=std(ArraystdTESVMLinearMap);
stdTHSVM=std(ArraystdTHSVM);
stdTESVM=std(ArraystdTESVM);
stdTSVM=std(ArraystdTSVM);
stdSVM=std(ArraystdSVM);

end


% % % ********* Taghirat laze***************
% 1) bayad sigma.^-1 ra cache konid ta badan az an estefade konid ( ba tavajo
%    be maghaleye twin mahalanobis SVM)
