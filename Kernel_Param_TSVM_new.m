function [CC1 CC2  param2]=Kernel_Param_TSVM_new(X1CrossData,y1CrossData,kfold,type)


%              clearvars -except X1 y1 X1test y1test points_per_class CrossDataind  X1CrossData y1CrossData;


Observation=size(X1CrossData,1);

Max=-inf;
% cpustartTime=cputime;
pp=1;

% % %  for c1=[2.^-7 2.^-6 2.^-5 2.^-4 2.^-3 2.^-2 2.^-1 2.^0 2.^1 2.^2 2.^3 2.^4 2.^5 2.^6 2.^7]
% % %     for c2=[2.^-7 2.^-6 2.^-5 2.^-4 2.^-3 2.^-2 2.^-1 2.^0 2.^1 2.^2 2.^3 2.^4 2.^5 2.^6 2.^7]
% % %         for c3=[2.^-7 2.^-6 2.^-5 2.^-4 2.^-3 2.^-2 2.^-1 2.^0 2.^1 2.^2 2.^3 2.^4 2.^5 2.^6 2.^7]
for c1=[ 2.^7 2.^0 2.^-7  ]
    
    for c2= [  2.^7 2.^0 2.^-7   ]  % kam mikonim ta be samte DTL beravim
        %         for c3=[  2.^5 2.^0 2.^-5   ]
        for ssigma=[ 2.^7 2.^0 2.^-7  ]
            %                      for c3=[2.^-7 2.^-6 2.^-5 2.^-4 2.^-3 2.^-2 2.^-1 2.^0 2.^1 2.^2 2.^3 2.^4 2.^5 2.^6 2.^7]    % kam mikonim ta be samte DTL beravim
            
            
            indices = crossvalind('Kfold',Observation,kfold);
            for ii=1:kfold
                test = (indices == ii); train = ~test;
                points_per_class=[0 0 ];
                
                % err() dar asl Accuracy ra
                % barmigardanad.
                
                err(ii)=Kernel_TSVM_new(X1CrossData(train,:),y1CrossData(train,:),X1CrossData(test,:),y1CrossData(test,:),c1,c2,ssigma,type);
                
            end
            error(pp)=sum(err)/kfold;   % error(pp) Accuracy ra barmigardanad.
            if (Max<error(pp))
                Max=error(pp);
                %                                                       Max
                param2(:,:)=0;
                m=1;
                CC1=c1;
                CC2=c2;
                %                 CC3=c3;
                
            end
            if (Max==error(pp))
                param2(m,1)=c1;
                param2(m,2)=c2;
                %                 param2(m,3)=c3;
                param2(m,3)=ssigma;
                m=m+1;
            end
            
            pp=pp+1;
            
            
        end
    end
end
end
% cpuendTime=cputime;

% ExeTime=cpuendTime-cpustartTime;
% end






%  for i=1:c.T
%
%  StructuralSVMMultiDimensionFiunction(CrossData(,