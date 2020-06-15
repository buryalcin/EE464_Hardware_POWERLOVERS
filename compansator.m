%% compansator*

syms s
s = tf('s');

Vosc = 1.8;
L = 10e-6;
C = 100e-6;
Vin = 3;
F0 = 7500;
Vref = 1.2;
Cf3 = 2.2e-9;
Fp2 = 42525;
Fz1 = 425;
Fp3 = 250e3;
Rf3 = 1 / ( 2* pi * Cf3 * Fp2);
Fz2 = 850;
Rf1 = 1 / ( 2*pi*Cf3*Fz2) - Rf3;
Rc1 = 2*pi*F0*L*C*Vosc/Vin/Cf3;
Cc1 = 1 / (2*pi*Rc1*Fz1);
Cc2 = 1 / ( 2*pi*Rc1*Fp3);

B  = ( 1 + s*Rc1*Cc1)*(1 + s*Cf3*(Rf1+Rf3));
A  = s*Rf1*(Cc1 + Cc2)*(1 + s*Rc1*(Cc1*Cc2 / (Cc1 + Cc2))*(1 + s*Rf3*Cf3));

H = B/A;

bode(H)