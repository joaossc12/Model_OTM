function dados = trajetoriaModelo(constantes,U,tempos,X0)

[A_taum,V_TRACO,B_taum,M_TRACOi, R, L, F_s, F_k, alpha_s,alpha_k,k_i,k_p] = calculaMatrizesModelo(constantes);
X = X0;
i=1;
%periodo = tempos(5)-tempos(4);
dados = zeros(size(tempos,1),7);

Intervalos = tempos(2:end)-tempos(1:end-1);
Tmed = sum(Intervalos)/size(Intervalos,1);
Tint = [tempos;tempos(end)+Tmed];
warning("");


while(i<=size(tempos,1))
    u = U(i,:)';
    [~,X] = integracaoNumerica_mex(X,u,Tint(i),Tint(i+1),A_taum,V_TRACO,B_taum,M_TRACOi, R, L, F_s, F_k, alpha_s,alpha_k,k_i,k_p);
    dados(i,:) = X;
    %disp("OLHA O X")
    %disp(X)
    i = i+1;
end
dados = [dados,tempos];
end

