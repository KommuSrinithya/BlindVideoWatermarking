function J=myinvinwavtras(Axp,Hoz,Ver,Dia);
sz1=size(Axp);
a=sz1(1);
b=sz1(2);
for i=1:a
    for j=1:b
        in=2*i-1;
        jn=2*j-1;
        jn1=(2*j);
        in1=(2*i);      
            Ip(in1,jn1)=Axp(i,j)-Hoz(i,j);
            Ip(in,jn1)=2*Hoz(i,j)+Ip(in1,jn1);
            Ip(in1,jn)=Ver(i,j)+Ip(in1,jn1);
            Ip(in,jn)=Dia(i,j)+Ip(in1,jn1);
    end
end
J=round(Ip);