function  [Resolution Hauteur_Recepteur Largeur_Recepteur Helio CS NomHel Angle_Solaire Angle_Recepteur Distance_Hel_Rec SIGtot Puisance] = calcul_cdf (jour,heure,Resolution)
    %% R�sum� : Calcul les cartes de flux pour un champ d'h�liostat 
    x=1;y=2;z=3;

    %% Point d�tude
    lattitude=42.5; % lattitude du point d'�tude
    DNI=1000; % Direct Normal Irradiance (W/m�)
    SIGsun=2.73*10^-3; % Ecart type de distribution de la puissance de l'astre solaire (rad)

    %% Calcul du vecteur solaire
    [Vsun(x),Vsun(y),Vsun(z)]= calcul_vecteur_solaire(heure,jour,lattitude);

    %% Le recepteur
    Prec(x)=0;                          % coordonn�e x du centre du recepteur dans le rep�re global
    Prec(y)=8.4;                        % coordonn�e y du centre du recepteur dans le rep�re global
    Prec(z)=80.8;                       % coordonn�e z du centre du recepteur dans le rep�re global
    Largeur_Recepteur=5;                % largeur du recepteur (m)
    Hauteur_Recepteur=5;                % Hauteur du recepteur (m)
    Angle_Recepteur=20;                 % Angle Vrec/axe y (orient� vers le CS)
    Vrec(x)=0;                          % coordonn�e x du vecteur normal du r�cepteur dans le rep�re global
    Vrec(y)=cosd(Angle_Recepteur);  % coordonn�e y du vecteur normal du r�cepteur dans le rep�re global
    Vrec(z)=-sind(Angle_Recepteur); % coordonn�e z du vecteur normal du r�cepteur dans le rep�re global
    [Vrec(x),Vrec(y),Vrec(z)]=normalisation(Vrec(x),Vrec(y),Vrec(z));%normalisation du vecteur r�cepteur

    %% Le Champ d'h�liostat
    [CS NomHel]=definition_champ_solaire();
    Nbre_Heliostats=size(NomHel,1);% Nombre d'h�liostats dans le champs
    Vhel_rec=zeros(3,1);
    Vhel=zeros(3,1);
    Angle_Solaire=zeros(Nbre_Heliostats,1);
    Angle_Recepteur=zeros(Nbre_Heliostats,1);
    Distance_Hel_Rec=zeros(Nbre_Heliostats,1);
    Puisance=zeros(Nbre_Heliostats,1);
    SIGtot=zeros(Nbre_Heliostats,1);

    %% Le calcul du flux
    % Resolution=10; % maillage du r�cepteur
    Pvis=zeros(3,1); % Le point de vis� dans le rep�re du r�cepteur

    %% Les h�liostats
    Lhel=8;     %largeur des h�liostats (m)
    Hhel=8;     %hauteur des h�liostats (m)
    Rhel=0.9;   %ratio entre la surface r�fl�chissante et Lhel*Hhel
    SIGm=1.5*10^-3;   %erreur macro en mRad
    SIGel=0.5*10^-3;  %erreur tracking �l�vation (rad)
    SIGaz=0.5*10^-3;  %erreur tracking azimuth (rad)
    REFhel=0.95; %r�flectivit� des h�liostats

    Helio=zeros(Resolution,Resolution,Nbre_Heliostats); % Les cartes de flux

    %% Boucle de calcul du flux pour chaque h�liostat
    for H_ETUDIE=1:Nbre_Heliostats

        disp(NomHel(H_ETUDIE,:)); % Affiche l'h�liostat en cours de traitement

        %% Calcul du vecteur h�liostat-r�cepteur
        Vhel_rec(x)=Prec(x)-CS(H_ETUDIE,x);%coordonn�e x du vecteur heliostat-r�cepteur
        Vhel_rec(y)=Prec(y)-CS(H_ETUDIE,y);%coordonn�e y du vecteur h�liostat-r�cepteur
        Vhel_rec(z)=Prec(z)-CS(H_ETUDIE,z);%coordonn�e y du vecteur h�liostat-r�cepteur
        Distance_Hel_Rec(H_ETUDIE)=norme(Vhel_rec(x),Vhel_rec(y),Vhel_rec(z));%distance h�liostat-r�cepteur
        [Vhel_rec(x),Vhel_rec(y),Vhel_rec(z)]=normalisation(Vhel_rec(x),Vhel_rec(y),Vhel_rec(z));%normalisation du vecteur h�liostat-r�cepteur

        %% Calcul du vecteur normal � l'h�liostat
        Vhel(x)=Vhel_rec(x)-Vsun(x);%coordonn�e x du vecteur normal h�liostat
        Vhel(y)=Vhel_rec(y)-Vsun(y);%coordonn�e y du vecteur normal h�liostat
        Vhel(z)=Vhel_rec(z)-Vsun(z);%coordonn�e z du vecteur normal h�liostat
        [Vhel(x),Vhel(y),Vhel(z)]=normalisation(Vhel(x),Vhel(y),Vhel(z));%normalisation du vecteur h�liostat    

        %% Angle solaire & angle r�cepteur
        Angle_Solaire(H_ETUDIE)=angle_2_vecteurs(-Vsun(x),-Vsun(y),-Vsun(z),Vhel(x),Vhel(y),Vhel(z));%angle solaire en �
        Angle_Recepteur(H_ETUDIE)=angle_2_vecteurs(-Vhel_rec(x),-Vhel_rec(y),-Vhel_rec(z),Vrec(x),Vrec(y),Vrec(z));%angle r�cepteur en �   

        %% Calcul de la puissance du flux fournit par l'h�liostat au r�cepteur 
        % Pertes pat effet cosinus (inclinaison de l'h�liostat par rapport � Vsun)
        Rendement_Helio_Cosinus=cosd(Angle_Solaire(H_ETUDIE));
        % Pertes li�es attenuation atmosph�rique (distance entre l'h�liostat et le recepteur)
        Rendement_Helio_Atm=calcul_rendement_attenuation(Distance_Hel_Rec(H_ETUDIE));
        % Puissance incidente au r�cepteur
        Puisance(H_ETUDIE)=DNI*REFhel*Rhel*Hhel*Lhel*Rendement_Helio_Cosinus*Rendement_Helio_Atm; % en W

        %% Calcul de la distribution de cette puissance sur le r�cepteur

        % distribution de l'erreur li�e aux effets d'astigmatisme 
        focaleHEL=CS(H_ETUDIE,4);
        Ht=(Hhel*Lhel)^0.5*abs(Distance_Hel_Rec(H_ETUDIE)/focaleHEL-cosd(Angle_Solaire(H_ETUDIE)));
        Wt=(Hhel*Lhel)^0.5*abs(Distance_Hel_Rec(H_ETUDIE)/focaleHEL*cosd(Angle_Solaire(H_ETUDIE))-1);
        SIGast=(0.5*(Ht^2+Wt^2))^0.5/(4*Distance_Hel_Rec(H_ETUDIE));

        %distribution de l'erreur li�e aux d�fauts micros et macros de r�flexions.
        SIGbq=((2*SIGm)^2)^0.5;

        %distribution de l'erreur li�e aux d�fauts de tracking
        SIGt=2*(SIGel*SIGaz)^0.5;

        % distribution de l'erreur globale 
        SIGtot(H_ETUDIE)=(Distance_Hel_Rec(H_ETUDIE)^2*((SIGsun)^2+(SIGbq)^2+(SIGast)^2+(SIGt)^2))^0.5/((cosd(Angle_Recepteur(H_ETUDIE)))^0.5);

        %% Carte de flux de l'h�liostat en W/m�
        FluxHel=distribution_hfcal(Resolution,Largeur_Recepteur,Hauteur_Recepteur,Pvis,SIGtot(H_ETUDIE));
        FluxHel=FluxHel*Puisance(H_ETUDIE); 
        Helio(:,:,H_ETUDIE)=FluxHel(:,:);
    end

end
