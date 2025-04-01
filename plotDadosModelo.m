function plotDadosModelo(simul,inicial,dados,tempo)


figure;
plot(simul(:,1),simul(:,2), 'r--','LineWidth', 1.5);
hold on
plot(inicial(:,1),inicial(:,2), 'b--','LineWidth', 1.5);
plot(dados(:,1),dados(:,2), 'y-','LineWidth', 1.5);
title("Trejetórias")
legend("Otimo","Inicial", "Real")

figure;
plot(tempo,simul(:,3), 'r--','LineWidth', 1.5);
hold on
plot(tempo,inicial(:,3), 'b--','LineWidth', 1.5);
plot(tempo,dados(:,3), 'y-','LineWidth', 1.5);
title("Angulo")
legend("Otimo","Inicial", "Real")

figure;
subplot(1,2,1)
plot(tempo,simul(:,4), 'r--','LineWidth', 1.5);
hold on
plot(tempo,inicial(:,4), 'b--','LineWidth', 1.5);
plot(tempo,dados(:,4), 'y-','LineWidth', 1.5);
subtitle("Velocidade Roda Direita")
subplot(1,2,2)
plot(tempo,simul(:,5), 'r--','LineWidth', 1.5);
hold on
plot(tempo,inicial(:,5), 'b--','LineWidth', 1.5);
plot(tempo,dados(:,5), 'y-','LineWidth', 1.5);
subtitle("Velocidade Roda Esquerda")
legend("Otimo","Inicial", "Real")


end