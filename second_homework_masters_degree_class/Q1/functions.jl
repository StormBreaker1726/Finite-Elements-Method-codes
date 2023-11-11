module functions

    # Funções auxiliares

    function u(x)
        return sin(pi*x)
    end
    ;

    function du(x)
        return pi * cos(pi*x)
    end
    ;

    function trans_x(t, x1, x2)
        return t*(x2 - x1)/2 + (x1 + x2)/2
    end

    function u_correct(t, x1, x2)
        return pi^2 * sin(pi * trans_x(t, x1, x2))
    end
    ;

end #module
