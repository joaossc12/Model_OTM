function dados = trajetoriaModelo(constantes,U,tempos,X0)

[A_taum,V_TRACO,B_taum,M_TRACOi, R, L, F_s, F_k, alpha_s,alpha_k,k_i,k_p] = calculaMatrizesModelo(constantes);
X = X0;
i=1;
periodo = tempos(2)-tempos(1);
dados = zeros(size(tempos,1),7);
warning("");


while(i<=size(tempos,1))

    u = U(i,:)';
    [~,X] = integracaoNumerica(X,u,tempos(i),periodo,A_taum,V_TRACO,B_taum,M_TRACOi, R, L, F_s, F_k, alpha_s,alpha_k,k_i,k_p);
    dados(i,:) = X;
    i = i+1;
end
dados = [dados,tempos];
end

