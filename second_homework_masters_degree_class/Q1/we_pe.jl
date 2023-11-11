module points_and_weights
    # Define os pesos para os pontos de integração (argumentos: nint -> número de pontos de integração)

    function we(nint)
        w = zeros(nint)
        if(nint == 2)
            w[1] = 1.0
            w[2] = 1.0
        elseif(nint == 3)
            w[1] = 5/9
            w[2] = 8/9
            w[3] = 5/9
        elseif(nint == 4)
            w[1] = (18-sqrt(30.))/36;
            w[2] = (18+sqrt(30.))/36;
            w[3] = (18+sqrt(30.))/36;
            w[4] = (18-sqrt(30.))/36;
        elseif(nint == 5)
            w[1] = (322-13*sqrt(70))/900;
            w[2] = (322+13*sqrt(70))/900;
            w[3] =  128/225;
            w[4] = (322+13*sqrt(70))/900;
            w[5] = (322-13*sqrt(70))/900;
        end
        return w
    end
    ;

    # Define os pontos de integração (argumentos: nint -> número de pontos de integração)
    function pe(nint)
        pt = zeros(nint)
        if(nint == 2)
            pt[1] = -sqrt(3.)/3.;
            pt[2] = sqrt(3.)/3.;
        elseif(nint == 3)
            pt[1] = sqrt(3/5);
            pt[2] = 0;
            pt[3] = -sqrt(3/5);
        elseif(nint == 4)
            pt[1] = sqrt((3+2*sqrt(6/5))/7);
            pt[2] = sqrt((3-2*sqrt(6/5))/7);
            pt[3] = -sqrt((3-2*sqrt(6/5))/7);
            pt[4] = -sqrt((3+2*sqrt(6/5))/7);
        elseif(nint == 5)
            pt[1] = -(1/3)*sqrt((5+2*sqrt(10/7)));
            pt[2] = -(1/3)*sqrt((5-2*sqrt(10/7)));
            pt[3] =   0;
            pt[4] = +(1/3)*sqrt((5-2*sqrt(10/7)));
            pt[5] = +(1/3)*sqrt((5+2*sqrt(10/7)));
        end

        return pt
    end
    ;

end
