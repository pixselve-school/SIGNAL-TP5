%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Auteur : Sandie Cabon               
% But : Segmentation a partir de la fft
% Description : 
% Date : 13/03/2018                
% Version : 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [signal_sortie] = segmentation_fft(signal_entree,vecteur_logique,FS)
    seuil = 145;
    N = 4096;
    f =(0:N-1)*FS/N;
    num_fft=0;
    % Positions des segments
    diff_logical_vector = diff(vecteur_logique);
    fronts_montants = find(diff_logical_vector == 1);
    fronts_descendants = find(diff_logical_vector == -1);
    positions = [fronts_montants fronts_descendants];

    signal_sortie = signal_entree;
    
    for i=1:length(positions)
        segment = signal_entree(positions(i,1):positions(i,2));
        L = length(segment);
        figure()
        subplot(211)
        plot(segment)
        
        segment_fft = fftshift(fft(segment, N));
        subplot(212)
        plot(abs(segment_fft))
        
        moyenne = mean(segment_fft);
        passage = 0;
        
        % compter le nombre de fois ou le signal segment_fft passe par la
        % moyenne
            
        for j = 1 : length(segment_fft) - 1
            if segment_fft(j) > moyenne && segment_fft(j + 1) < moyenne || segment_fft(j) < moyenne && segment_fft(j + 1) > moyenne
                passage = passage + 1;
            end
        end

        title(sprintf('Segment %i ,value %i',i,passage)) 
        
        % Definir la valeur qui permet de differencier les deux classes
        %if passage < ?? 
        %   signal_sortie(positions(i,1):positions(i,2)) = 0;
        %end
    end
   
    
end