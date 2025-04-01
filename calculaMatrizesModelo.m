function [A_taum,V_TRACO,B_taum,M_TRACOi, R, L, F_s, F_k, alpha_s,alpha_k,k_i,k_p] = calculaMatrizesModelo(constantes)
R = constantes(1); % Raio das rodas do robô (m)
L = constantes(2); % Comprimento do semieixo das rodas do robô (m)
m_c = constantes(3); % Massa da plataforma do robô
m_w = constantes(4); % Massa da roda do robô
d = constantes(5); 

N_r = 48; %Relacao de engrenagens do motor CC
N_l = 48; %Relacao de engrenagens do motor CC
b_r = constantes(6); % Coeficiente de atrito viscoso do motor CC
b_l = constantes(7); % Coeficiente de atrito viscoso do motor CC
K_ce_r = constantes(8); % Constante de força contra-eletromotriz do motor CC 
K_ce_l = constantes(9); % Constante de força contra-eletromotriz do motor CC 
K_t_l = K_ce_l; % Constante de torque do motor CC 
K_t_r = K_ce_r ; % Constante de torque do motor CC 
R_a_r = constantes(10); %18 Resistencia de armadura total do robô
R_a_l = constantes(11); % Resistencia de armadura total do robô

f_s = constantes(12); % Coeficiente de atrito estático 
f_k = constantes(13); % Coeficiente de atrito cinético

alpha_s = constantes(14); % Constante de saturação do atrito estático 
alpha_k = constantes(15); % Constantes de saturação do atrito cinético

k_i = [60 0; 0 60]; % Ganho Ki
k_p = [9 0; 0 9]; % Ganho Kp


g = 9.81; %Aceleracao da gravidade

m = m_c + 2*m_w;
I_c = constantes(16);
I_w = 4.3034e-05; %m_w*R^2/2;
I_t = I_c + 2*m_w*L^2 + 2*I_w + m_c*d^2;

F_s = f_s*m*g;
F_k = f_k*m*g;

V_TRACO = R^2*d*m_c/(4*L^2)*[
    0, 1;
    -1,0];

A_taum = [
    (b_r - (K_ce_r*K_t_r)/R_a_r)/N_r, 0;
    0 ,(b_l - (K_ce_l*K_t_l)/R_a_l)/N_l];

B_taum = [
    K_t_r/R_a_r 0;
    0, K_t_l/R_a_l];

M_TRACOi = -inv([
    I_w + R^2*(m*L^2 + I_t)/(4*L^2), R^2*(m*L^2 - I_t)/(4*L^2);
    R^2*(m*L^2 - I_t)/(4*L^2), I_w + R^2*(m*L^2 + I_t)/(4*L^2)]);

end
