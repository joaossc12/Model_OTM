clear

D = csvread('Dados\NewDataZZXDuplo.csv');
%goal = csvread('variaveis_14.csv');
%
y0 = D(1,2);
N_s = size(D,1);
Ts = 0.07;
time = (0:Ts:Ts*(N_s-1))';

posicao0 = D(:,1:3); 
velocidade0 = D(:,6:7);
dados = [posicao0,velocidade0];
posicao = D(:,1:3);
tempo = time;
velocidade = velocidade0;
X0 =[0,y0,0,0,0,0,0]';
%%
constantes =  [0.0328, 0.123/2, 0.513, 0.08,     0.01,     0.0150,  0.109,    23,       0.0250,  0.0200,  1 ,1, 0.0028]; 
variaveis = csvread("savede.csv");
N = size(variaveis,1);

%%
Custo_Aux = inf;
Cont = 0;
for i=2:N
    if (variaveis(i,2) ~= variaveis(i-1,2))
    solucao = variaveis(i,3:end);
    disp(i);
    Cont = Cont + 1;
    Custo_otm = otmModelo(solucao,posicao,velocidade,time,X0,constantes,0)
        if (Custo_otm < Custo_Aux)
        Custo_Aux = Custo_otm;
        N_best = i;
        solucao_best = solucao;
        disp("Melhorou");
        end 
    end 

end 

fprintf('O melhor resultado é N = %f com Custo = %f o custo mudo %d vezes \n',N_best,Custo_Aux, Cont);

%%
trajetoria_init = trajetoriaModelo(constantes,velocidade,time,X0);
Custo_init = otmModelo(constantes,posicao,velocidade,time,X0,constantes,0)

trajetoria = trajetoriaModelo(solucao_best,velocidade,time,X0);
Custo_otm = otmModelo(solucao_best,posicao,velocidade,time,X0,constantes,0)

plotDadosModelo(trajetoria,trajetoria_init,D,tempo)