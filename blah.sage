def c(x,y):
    return (x+y)//10

def star(rho):
    def rhoStar(x,y):
        if len(x) == 1:
            return rho(x[0],y[0])
        else:
            return rho(x[-1],y[-1]) + rho((x[-1]+y[-1]) % 10, rhoStar(x[:-1], y[:-1]))

    
