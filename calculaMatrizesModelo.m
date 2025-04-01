function [A_taum,V_TRACO,B_taum,M_TRACOi, R, L, F_s, F_k, alpha_s,alpha_k,k_i,k_p] = calculaMatrizesModelo(constantes)
R = constantes(1); % Raio das rodas do robô (m) %OTM1
L = constantes(2); % Comprimento do semieixo das rodas do robô (m) %OTM1
m_c = constantes(3); % Massa da plataforma do robô %OTM1
m_w = constantes(4); % Massa da roda do robô %OTM1
d = constantes(5); %OTM1

N_r = 48; %Relacao de engrenagens do motor CC %OTM1
N_l = 48; %Relacao de engrenagens do motor CC %OTM1
b_r = constantes(6); % Coeficiente de atrito viscoso do motor CC %OTM1
b_l = b_r;%constantes(7); % Coeficiente de atrito viscoso do motor CC %OTM1
K_ce_r = constantes(7); % Constante de força contra-eletromotriz do motor CC %OTM1
K_ce_l = constantes(7);%constantes(9); % Constante de força contra-eletromotriz do motor CC %OTM1
K_t_l =constantes(7); %constantes(9); % Constante de torque do motor CC %OTM1
K_t_r =constantes(7); %constantes(11); % Constante de torque do motor CC %OTM1
R_a_r =constantes(8); %constantes(16);%23; % Resistencia de armadura total do robô %OTM1
R_a_l =constantes(8);  %constantes(17);%26; % Resistencia de armadura total do robô

f_s = constantes(9); % Coeficiente de atrito estático %OTM1
f_k = constantes(10); % Coeficiente de atrito cinético %OTM1

alpha_s = constantes(11); % Constante de saturação do atrito estático %OTM1
alpha_k = constantes(12); % Constantes de saturação do atrito cinético %OTM1

k_i = [60 0; 0 60]; % Ganho Ki
k_p = [9 0; 0 9]; % Ganho Kp


g = 9.81; %Aceleracao da gravidade

m = m_c + 2*m_w;
I_c = constantes(13); %OTM1
I_w = 4.3034e-05;%constantes(15); %OTM1
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
