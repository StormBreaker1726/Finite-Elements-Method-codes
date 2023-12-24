module WE
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
            w[1] = (18 - sqrt(30.0))/36.0
            w[2] = (18 + sqrt(30.0))/36.0
            w[3] = (18 + sqrt(30.0))/36.0
            w[4] = (18 - sqrt(30.0))/36.0
        elseif(nint == 5)
            w[1] = (322.0-13.0*sqrt(70.0))/900.0
            w[2] = (322.0+13.0*sqrt(70.0))/900.0
            w[3] = 128.0/225.0
            w[4] = (322.0+13.0*sqrt(70.0))/900.0
            w[5] = (322.0-13.0*sqrt(70.0))/900.0
        end
        return w
    end
    ;
end #module
