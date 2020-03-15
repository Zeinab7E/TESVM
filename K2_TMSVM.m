
function [result]=K2_TMSVM(Xi,Xj,Class1_Data,Class2_Data,type,ty)
% % % A=Class1_Data;
B=Class2_Data;


sigmaa=10.^-5;





% sigmaa=type;
% sigmaa=0.1;
% % % I1=eye(CP,CP);
% % % I2=eye(CN,CN);

% % % e1=ones(CP,1);
% % % e2=ones(CN,1);
Jn(:,:)=0;
% % temp=0;
% % first=1;
% % % end1=0;
% Jp=zeros(CP,CP);
% Jn=zeros(CN,CN);
% % % 
% % % for i=1:CP
% % %     ei=ones(size(Class1_Data(find(C1==i),:),1),1);
% % %     Ii=eye(size(Class1_Data(find(C1==i),:),1),size(Class1_Data(find(C1==i),:),1));
% % %    Lpi=size(Class1_Data(find(C1==i),:),1);
% % %    Jp(first:temp+Lpi,first:temp+Lpi)=(1/Lpi)*(Ii-((1/Lpi)*(ei*ei')));
% % %    first=temp+Lpi+1;
% % %    temp=first-1;
% % % end
% JpJp'=Jp bayad 740*740 bashad... na 18*18 !!    A'*JpJp'*A ===18*18=cov
% for i=1:
temp=0;
first=1;

l2=size(Class2_Data,1);
e=ones(size(Class2_Data,1),1);
Jn=(1/l2)*(eye(size(Class2_Data,1))-((1/l2)*(e*e')));

% % % for i=1:CN
% % %      eii=ones(size(Class2_Data(find(C2==i),:),1),1);
% % %     Iii=eye(size(Class2_Data(find(C2==i),:),1),size(Class2_Data(find(C2==i),:),1));
% % %     
% % %     Lni=size(Class2_Data(find(C2==i),:),1);
% % %    Jn(first:temp+Lni,first:temp+Lni)=(1/Lni)*(Iii-((1/Lni)*(eii*eii')));
% % %       first=temp+Lni+1;
% % %    temp=first-1;
% % % end

% % I1=eye(size(Jp,1),size(Jp,1));   
I2=eye(size(Jn,1),size(Jn,1)); 

% result=[inv(sigma)*tempXiXj]-[inv(sigma)*tempKXiA*Jp*inv(sigma*I1+Jp'*tempKAA*Jp)*Jp'*K(A,Xj,type)];

% result=[inv(sigma)*K(Xi,Xj,type)]-[inv(sigma)*K(A,Xj,type)*Jp*inv(sigma*I1+Jp'*K(A,A,type)*Jp)*Jp'*K(Xi,A,type)];
% Xi=Xi';
% Xj=Xj';
% A=A';
result=[(sigmaa)\K(Xi,Xj,type,ty)]-[(sigmaa)\K(Xi,B,type,ty)*Jn/(sigmaa*I2+Jn'*K(B,B,type,ty)*Jn)*Jn'*K(B,Xj,type,ty)];

% result=[inv(sigma)*K(Xi,Xj,type)]-[inv(sigma)*K(Xi,A,type)*Jp*inv(sigma*I1+Jp'*K(A,A,type)*Jp)*Jp'*K(A,Xj,type)];
end