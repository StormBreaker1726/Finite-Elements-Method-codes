module SHL


    function shl(nen,nint)
        pt = zeros(nint)
        w = zeros(nint)
        # print("line 3.2.1")
        if(nint == 2)
            pt[1] = -sqrt(3.)/3.;
            pt[2] = sqrt(3.)/3.;
            w[1] = 1.;
            w[2] = 1.;
        elseif(nint == 3)
            pt[1] = sqrt(3/5);
            pt[2] = 0;
            pt[3] = -sqrt(3/5);
            w[1] = 5/9;
            w[2] = 8/9;
            w[3] = 5/9;
        elseif(nint == 4)
            pt[1] = sqrt((3+2*sqrt(6/5))/7);
            pt[2] = sqrt((3-2*sqrt(6/5))/7);
            pt[3] = -sqrt((3-2*sqrt(6/5))/7);
            pt[4] = -sqrt((3+2*sqrt(6/5))/7);
            w[1] = (18-sqrt(30.))/36;
            w[2] = (18+sqrt(30.))/36;
            w[3] = (18+sqrt(30.))/36;
            w[4] = (18-sqrt(30.))/36;
        elseif(nint == 5)
            pt[1] =  (1/3)*sqrt((5+2*sqrt(10/7)));
            pt[2] =  (1/3)*sqrt((5-2*sqrt(10/7)));
            pt[3] =   0;
            pt[4] = -(1/3)*sqrt((5-2*sqrt(10/7)));
            pt[5] = -(-1/3)*sqrt((5+2*sqrt(10/7)));
            w[1] = (322-13*sqrt(70))/900;
            w[2] = (322+13*sqrt(70))/900;
            w[3] =  128/225;
            w[4] = (322+13*sqrt(70))/900;
            w[5] = (322-13*sqrt(70))/900;
        end
        sh = zeros(nen, nint)
        for l=1:nint
            t=pt[l];
            if(nen==2)
                sh[1,l] = (1.0-t)/2.0;
                sh[2,l] = (1.0+t)/2.0;
            elseif(nen==3)
                sh[1,l] = t*(t-1.0)/2.0;
                sh[2,l] = -(t-1)*(t+1);
                sh[3,l] = t*(t+1.0)/2.0;
            elseif(nen==4)
                sh[1,l] = -( 9/16)*(t+(1/3))*(t-(1/3))*(t-1);
                sh[2,l] =  (27/16)*(t+1)    *(t-(1/3))*(t-1);
                sh[3,l] = -(27/16)*(t+1)    *(t+(1/3))*(t-1);
                sh[4,l] =  ( 9/16)*(t+1)    *(t+(1/3))*(t-(1/3));
            elseif(nen==5)
                sh[1,l] =  (2/3)*(t+(1/2))*        t*(t-(1/2))*(t-1);
                sh[2,l] = -(8/3)*    (t+1)*        t*(t-(1/2))*(t-1);
                sh[3,l] =      4*    (t+1)*(t+(1/2))*(t-(1/2))*(t-1);
                sh[4,l] = -(8/3)*    (t+1)*(t+(1/2))*        t*(t-1);
                sh[5,l] =  (2/3)*    (t+1)*(t+(1/2))*        t*(t-(1/2));
            end
        end
        return sh
    end
    ;

end #module
