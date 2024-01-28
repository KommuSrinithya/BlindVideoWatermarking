function [App, Hoz, Ver, Dia]=inwavtras(im)
sz1=size(im);
a=fix(sz1(1)/2);
b=fix(sz1(2)/2);
App=zeros(a,b);
Hoz=zeros(a,b);
Ver=zeros(a,b);
Dia=zeros(a,b);
for i=1:a
    for j=1:b
        in=2*i-1;
        jn=2*j-1;
        jn1=2*j;
        in1=2*i;
        if in<=sz1(1)&& in1<=sz1(1)&& jn<=sz1(2)&& jn1<=sz1(2)
        dum1=im(in1,jn1)+im(in,jn1);   
        LL1(i,j)=(round(dum1./2));
        LH1(i,j)=(LL1(i,j)-im(in1,jn1));
        HL1(i,j)=(im(in1,jn)-im(in1,jn1));
        HH1(i,j)=(im(in,jn)-im(in1,jn1));
        end
    end
end
App=LL1;
Hoz=LH1;
Ver=HL1;
Dia=HH1;