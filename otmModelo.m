function fCusto = otmModelo(x,saidas,U,tempos,X0,constantes,on)

constantes = x;
betha_x = 11.4222;
betha_y = 11.6488;
betha_t = 3.5743;
N = size(tempos,1);
try
    dados = trajetoriaModelo(constantes,U,tempos,X0);
    eX = sqrt(sum((( saidas(:,1)-dados(:,1) ).^2),'all')/N) ;
    eY = sqrt(sum((( saidas(:,2)-dados(:,2) ).^2),'all')/N) ;
    eT = sqrt(sum((( saidas(:,3)-dados(:,3) ).^2),'all')/N) ;
    fCusto = betha_x * eX + betha_y * eY + betha_t * eT;
catch
    fCusto = Inf;
end


if ~on
    % clf
    if ~isinf(fCusto)
        % plotDadosModelo(dados,saidas,tempos)
    end
    fprintf("Custo = %f| eX = %f| eY = %f| eT = %f ",fCusto,eX*betha_x,eY*betha_y,eT*betha_t);
    %fprintf('%9.5g,   ', x);
end

