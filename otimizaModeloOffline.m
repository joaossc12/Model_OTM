clc,clear,close all;

cd 'C:\Users\João Vitor\Desktop\Otm_Model\Dados'

D1 = csvread('NewDataZZXduplo.csv');
D = D1(:,1:7);

N_samples = size(D,1);
Ts = 0.07;
time = (0:Ts:Ts*(N_samples-1))';
posicao0 = D(:,1:3); 
velocidade0 = D(:,6:7);
%[posicao,tempo,velocidade] = retorna_dados(Periodo,D1,D2,D3);
dados = [posicao0,velocidade0];
%[posicao,tempo,velocidade] = retorna_dados(0.115,dados);
posicao = D(:,1:2);
tempo = time;
velocidade = velocidade0;

cd 'C:\Users\João Vitor\Desktop\Otm_Model'
%%
constantes = [0.0328, 0.123/2, 0.513, 0.08, 0.01, 0.0150, 0.0150,0.0109,0.0190, 18, 23,0.0250, 0.0200,1 ,1, 0.0028]; %Parametros iniciais 
solucaoInicial = constantes;

limites(1,:) = [constantes(1)*1.10,constantes(2)*1.1, constantes(3:4)*3,constantes(5)*3,constantes(6:16)*10];
limites(2,:) = [constantes(1)*0.90,constantes(2)*0.9, constantes(3:4)*0.3,constantes(5)*0,constantes(6:16)*0.];
X0 = [0,1.4,0,0,0,0,0]';

NP = 50;
itMax = 50; 
tempoMax = inf;
info = 1;
%%
[fopt, xopt] = de(@(x) otmModelo(x,posicao,velocidade,tempo,X0,constantes,false),limites, solucaoInicial, NP, itMax, tempoMax, info);

constantes = attConstantes(constantes,xopt);

%%
disp("FINISH")
disp("[MAX  INICIAL OTIMO   MIN]");
matrizvalores = [limites(1,:)',solucaoInicial',xopt',limites(2,:)'];
disp(matrizvalores);

simul = trajetoriaModelo(constantes,velocidade,tempo,X0);
simul_init = trajetoriaModelo(solucaoInicial,velocidade,tempo,X0);
plotDadosModelo(simul,simul_init,D,tempo)
