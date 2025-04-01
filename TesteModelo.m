clear

cd 'C:\Users\João Vitor\Desktop\UESC\IC\Rotininha'

%dados = [csvread('diagonal2.csv'); csvread('retax2.csv'); csvread('retay2.csv');];
Periodo = 0.115;
startDados = [0,0,0,0,0,0,0,0];
D = [startDados; csvread('TrajetoriaTeste11.csv')];


%time = (0:Periodo:(size(D,1)-1)*Periodo)';
time = D(:,8);
Intervalos = time(2:end)-time(1:end-1);
Tmed = sum(Intervalos)/size(Intervalos,1);
X0 =[0,0,0,0,0,0,0]';

posicao0 = D(:,1:3); 
velocidade0 = D(:,6:7);
%[posicao,tempo,velocidade] = retorna_dados(Periodo,D1,D2,D3);
dados = [posicao0,velocidade0];
%[posicao,tempo,velocidade] = retorna_dados(0.115,dados);
posicao = D(:,1:2);
tempo = time;
velocidade = velocidade0;
constantes = csvread('variaveis_14.csv');
%%
trajetoria = trajetoriaModelo(constantes,velocidade,time,X0);
fCusto = otmModelo(constantes,posicao,velocidade,time,X0,constantes,1)

figure;
plot(trajetoria(:,1), trajetoria(:,2),'r--','LineWidth', 1.5);
hold on
plot(posicao(:,1),posicao(:,2),'b-','LineWidth', 1.5);
legend('Modelo', 'Dados')



figure
subplot(1,2,1)
plot(time, trajetoria(:,4),'r-','LineWidth', 1.5);
hold on
plot(time,D(:,4),'b-','LineWidth', 1.5);

subplot(1,2,2)
plot(time, trajetoria(:,5),'r-','LineWidth', 1.5);
hold on
plot(time,D(:,5),'b-','LineWidth', 1.5);
