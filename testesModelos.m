clc,clear,close all;

cd 'C:\Users\João Vitor\Desktop\UESC\IC\Rotininha\Dados'

D = csvread('NewDataZZXinvduplo.csv');

cd 'C:\Users\João Vitor\Desktop\UESC\IC\Rotininha'
%
N_s = size(D,1);
Ts = 0.07;
time = (0:Ts:Ts*(N_s-1))';

y0 = D(1,2);
posicao0 = D(:,1:3); 
velocidade0 = D(:,6:7);
%[posicao,tempo,velocidade] = retorna_dados(Periodo,D1,D2,D3);
dados = [posicao0,velocidade0];
%[posicao,tempo,velocidade] = retorna_dados(0.115,dados);
posicao = D(:,1:2);
tempo = time;
velocidade = velocidade0;
X0 =[0,y0,0,0,0,0,0]';

variaveis = csvread('50it13var.csv');
N = 50;
solucao = variaveis(N,3:15);
inicial = [0.0328, 0.123/2, 0.513, 0.08,     0.01,     0.0150,  0.109,    25,       0.0250,  0.0200,  1 ,1, 0.0028];

CustoOTM = otmModelo(solucao,D(:,1:2),velocidade,tempo,X0,solucao,1)
CustoInit = otmModelo(inicial,D(:,1:2),velocidade,tempo,X0,inicial,1)

simul = trajetoriaModelo(solucao,velocidade,tempo,X0);
simul_init = trajetoriaModelo(inicial,velocidade,tempo,X0);
plotDadosModelo(simul,simul_init,D,tempo)
