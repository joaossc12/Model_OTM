clc,clear,close all;

cd 'C:\Users\João Vitor\Desktop\Model_OTM'

D = csvread('Dados\NewDataZZXduplo.csv');

y0 = D(1,2);
N_s = size(D,1);
Ts = 0.07;
time = (0:Ts:Ts*(N_s-1))';

velocidade = D(:,6:7);
posicao = D(:,1:3);
tempo = time;

X0 =[0,y0,0,0,0,0,0]';
%{
%constantes = [0.0328, 0.099, 0.572, 0.08, 0.01, 0.0150, 0.0150, 0.0109, 0.0109,0.0109,0.0109, 0.0250, 0.0200,1 ,1]; %Parametros iniciais 
%constantes =[0.034,0.103553191325941,0.468009497423899,0.0681917308497066,0.007,0.101055013777821,0.15,0.00523459505446459,0.109,0.109,0.064941077449308
%% Problema com 17 Variaveis de Decisao3,0.0397980729179563,0.0315626342284438,0.80933609278764,9.24322684011794];%744it, 2h
constantes = [0.0328, 0.099/2, 0.513, 0.08, 0.01, 0.0150, 0.0150, 0.0109,...
0.0109,0.109,0.109, 0.0250, 0.0200,1 ,1, 0.0028, 4.3034e-05]; %Parametros iniciais 2 
solucaoInicial = constantes;

limites(1,:) = [constantes(1:2)*1.05, constantes(3:4)*1.10,constantes(5)*1.4,constantes(6:17)*1.5];
limites(2,:) = [constantes(1:2)*0.95, constantes(3:4)*0.90,constantes(5)*0.6,constantes(6:17)*0.5];
%}
%% Problema com 13 variaveis de decisao

%R, L, M_c, M_w, d, b_r,b_l, K_ce_r, K_ce_l, f_s, f_k, aplha_s, alpha_k, I_c

% R, L, M_c, M_w, d, b, Kce, R, Fs, Fk, Alpha_s, Alpha K, I_c
constantes =  [0.0328, 0.123/2, 0.513, 0.08,     0.01,     0.0150,  0.109,    23,       0.0250,  0.0200,  1 ,1, 0.0028]; 
%constantes =  [0.0341, 0.0606, 0.5607, 0.0691,     0.01,     0.0437,  4.3391,    25,       0.4664,  0.2705 ,  3.7655 ,20, 0.0003]; 
solucaoInicial = constantes;
%[3 4 6 7 8 9]
limites(1,:) = [constantes(1)*1.10,constantes(2)*1.1, constantes(3:4)*2,constantes(5)*3,constantes(6:13)*20];
limites(2,:) = [constantes(1)*0.90,constantes(2)*0.9, constantes(3:4)*0.5,constantes(5)*0,constantes(6:13)*0.05];

%%
NP = 60; 
itMax = 50; 
tempoMax = inf;
info = 1;

%%
[fopt, xopt] = de(@(x) otmModelo(x,posicao,velocidade,tempo,X0,constantes,0),limites, solucaoInicial, NP, itMax, tempoMax, info);
%lb = limites(2,:)';
%ub = limites(1,:)';
%options = optimoptions('particleswarm','SwarmSize',NP, 'MaxIterations',itMax);
%[xopt,fopt,exitflag,output,points] = particleswarm(@(x) otmModelo(x,posicao,velocidade,tempo,X0,constantes,0),13,lb,ub,options);
%%
disp("FINISH")
disp("[MAX  INICIAL OTIMO   MIN]");
matrizvalores = [limites(1,:)',solucaoInicial',xopt',limites(2,:)'];
disp(matrizvalores);
                              
%%
%constantes = attConstantes(constantes,xopt);
%writematrix(xopt,"ResultadoPSO1.csv","WriteMode","append");

simul = trajetoriaModelo(xopt,velocidade,tempo,X0);
simul_init = trajetoriaModelo(solucaoInicial,velocidade,tempo,X0);
plotDadosModelo(simul,simul_init,D,tempo)
