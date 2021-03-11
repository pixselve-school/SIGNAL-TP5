%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Auteur : Sandie Cabon               
% But : Segmentation � partir de l'energie
% Description : 
% Date : 09/03/2018                
% Version : 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [signal_sortie,vecteur_logique] = segmentation_energie_glissante(signal_entree,FS,N,seuil)

    signal_energie = zeros(length(signal_entree),1);

    % calcul de l'energie
    for n = N / 2 + 1 : length(signal_entree) - N / 2 + 1 
        carre_signal_sur_fenetre = signal_entree(n - N / 2 : n + N / 2) .^2;
        signal_energie(n) = 1/N * sum(carre_signal_sur_fenetre);
    end

    % lissage
    win=100;
    h=ones(1,win)/win;
    signal_energie_lisse=filter(h,1,signal_energie);

    % Seuiller 
    % Garder seulement les segments de signal_energie_lisse de dur�es > 100 ms -> "signal_sortie" -
    % utiliser supprInter
    % Creer le signal logique -> "vecteur_logique"
    
    seuil_signal = ones(length(signal_sortie),1) * seuil;
    figure()
    subplot(311)
    plot(signal_entree)
    title('Signal brut')
    subplot(312)
    plot(signal_energie_lisse)
    title('Energie glissante liss�e et seuil')
    hold on
    plot(seuil_signal,'r');
    subplot(313)
    plot(signal_sortie)
    title('Signal segmente')
    
end
 