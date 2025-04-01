function fCusto = otmModelo(x,saidas,U,tempos,X0,constantes,on)

constantes = attConstantes(constantes,x);

try
    dados = trajetoriaModelo(constantes,U,tempos,X0);
    eX = rescale(( saidas(:,1)-dados(:,1) ).^2,0,1);
    eY = rescale(( saidas(:,2)-dados(:,2) ).^2,0,1);
    eT = rescale(( saidas(:,3)-dados(:,3) ).^2,0,1);
    eR = [eX,eY,eT];
    fCusto = sqrt( sum(eR, 'all')/size(tempos,1) );
catch
    fCusto = Inf;
end


if ~on
    % clf
    if ~isinf(fCusto)
        % plotDadosModelo(dados,saidas,tempos)
    end
    disp(fCusto);
    %fprintf('%9.5g,   ', x);
end

