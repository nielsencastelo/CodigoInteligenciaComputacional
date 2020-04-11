function p = codificacao(pop,xlo,xhi,nbits,gene)
    % função que codifica a população dentro de intervalo de busca
    p = xlo + (xhi - xlo) * ([2.^(-[1:nbits])]*reshape(pop,nbits,gene));
    
%     vbit  = reshape(pop,nbits,gene);
%     
%     
%     vd1 = binario2decimal(vbit(:,1)');
%     vd2 = binario2decimal(vbit(:,2)');
%     vd3 = binario2decimal(vbit(:,3)');
%     
%     vds = 2^nbits;
%     
%     x1 = xlo + (vd1/vds) * (xhi - xlo);
%     x2 = xlo + (vd2/vds) * (xhi - xlo);
%     x3 = xlo + (vd3/vds) * (xhi - xlo);
    
    %p = [x1 x2 x3];
end