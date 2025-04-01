function Xponto = modeloUnificado(~,X,u,A_taum,V_TRACO,B_taum,M_TRACOi, R, L, F_s, F_k, alpha_s,alpha_k,k_i,k_p)

A_cin = R/2*[
    cos(X(3)), cos(X(3));
    sin(X(3)), sin(X(3))];


tau_F = [
    F_s*tanh(alpha_s*X(4)) - F_k*tanh(alpha_k*X(4));
    F_s*tanh(alpha_s*X(5)) - F_k*tanh(alpha_k*X(5))];


eta = [
    X(4);
    X(5)];



epi = [
    X(6);
    X(7)];

Y_pi = min(12, max( k_i*epi + k_p*(u-eta), -12) );

theta_ponto = R*(eta(1)-eta(2))/(2*L);

Xponto = [
    A_cin*eta;
    theta_ponto;
    M_TRACOi*((A_taum+(theta_ponto*V_TRACO))*eta - B_taum*Y_pi + tau_F);
    u-eta];

end