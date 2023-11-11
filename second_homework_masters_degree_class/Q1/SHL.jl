module SHL
    include("we_pe.jl")
    using .points_and_weights

    function shl(typ, nen, nint)

        pt = points_and_weights.pe(nint)
        w = points_and_weights.we(nint)

        if(typ == 1)
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
                    sh[1,l] =  (2/3)*(t+(1/2))*t*(t-(1/2))*(t-1);
                    sh[2,l] = -(8/3)*(t+1)*t*(t-(1/2))*(t-1);
                    sh[3,l] =      4*(t+1)*(t+(1/2))*(t-(1/2))*(t-1);
                    sh[4,l] = -(8/3)*(t+1)*(t+(1/2))*t*(t-1);
                    sh[5,l] =  (2/3)*(t+1)*(t+(1/2))*t*(t-(1/2));
                end
            end
            return sh
        elseif(typ == 2)
            dsh = zeros(nen, nint)
            for l=1:nint
                t=pt[l];
                if(nen==2)
                    dsh[1,l] = (-1.0)/2.0;
                    dsh[2,l] = (1.0)/2.0;
                elseif(nen==3)
                    dsh[1,l] = (2*t + 1)/2.0;
                    dsh[2,l] = -2*t;
                    dsh[3,l] = (2*t - 1)/2.0;
                elseif(nen==4)
                    dsh[1,l] = -(27*t*t - 18*t - 1)/16;
                    dsh[2,l] = 9*(9*t*t - 2*t - 3)/16;
                    dsh[3,l] = -9*(9*t*t + 2*t - 3)/16;
                    dsh[4,l] = +(27*t*t + 18*t - 1)/16;
                elseif(nen==5)
                    dsh[1,l] = (16*(t^3) - 12*(t^2) - 2*t + 1)/6;
                    dsh[2,l] = -4*(8*(t^3) - 3*(t^2) - 4*t + 1)/3;
                    dsh[3,l] = (16*(t^3) - 10*t)
                    dsh[4,l] = -4*(8*(t^3) + 3*(t^2) - 4*t - 1)/3;
                    dsh[5,l] = (16*(t^3) + 12*(t^2) - 2*t - 1)/6;
                end
            end
            return dsh
        end
    end
    ;
end
