function [tempoFinal,X] = integracaoNumerica(X,u,t0,t1,A_taum,V_TRACO,B_taum,M_TRACOi, R, L, F_s, F_k, alpha_s,alpha_k,k_i,k_p)  %#codegen

[tempos, Xs] = ode45(@(t,X) modeloUnificado(t,X,u,A_taum,V_TRACO,B_taum,M_TRACOi, R, L, F_s, F_k, alpha_s,alpha_k,k_i,k_p), [t0,t1] , X);

X = Xs(end,:)';
tempoFinal = tempos(end);
end




