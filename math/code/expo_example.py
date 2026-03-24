def fast_expo_modulo(base: int, exp: int, modulo: int):
    if exp==1:
        return base%modulo
    if exp ==0:
        return 1
    if exp % 2 == 1:
        return (fast_expo_modulo(base, (exp-1)/2, modulo) %modulo* 
            fast_expo_modulo(base, (exp-1)/2, modulo) %modulo * (base%modulo))%modulo
    else:
        return (fast_expo_modulo(base, exp/2, modulo) %modulo* 
            fast_expo_modulo(base, exp/2, modulo) %modulo) %modulo

print(fast_expo_modulo(2790, 2753, 3233))