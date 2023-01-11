DROP TABLE Liste_Echipe;
DROP TABLE Operatii;
DROP TABLE Diagnostice;
DROP TABLE Analize;
DROP TABLE Liste_Medicamente;
DROP TABLE Retete;
DROP TABLE Personal_Medical;
DROP TABLE Medicamente;
DROP TABLE Bilete_Trimitere;
DROP TABLE Medici_Familie;
DROP TABLE Sali;
DROP TABLE Consult;
DROP TABLE Programari;
DROP TABLE Pacienti;
DROP TABLE Cabinete;

CREATE TABLE Pacienti (
    CNP varchar(255) NOT NULL,
    Nume varchar(255) NOT NULL,
    Prenume varchar(255) NOT NULL,
    Data_nasterii DATE NOT NULL,
    Sex varchar(1) NOT NULL,
    Nr_Tel varchar(255) NOT NULL,
    Email varchar(255),
    Judet varchar(255) NOT NULL,
    Localitate varchar(255) NOT NULL,
    Strada varchar(255) NOT NULL,
    Numar varchar(255) NOT NULL,
    PRIMARY KEY (CNP)
);

CREATE TABLE Sali (
    Numar_Sala varchar(255) NOT NULL,
    PRIMARY KEY (Numar_Sala)
);

CREATE TABLE Cabinete (
    Nr_Cabinet varchar(255) NOT NULL,
    Etaj number(38) NOT NULL,
    PRIMARY KEY (Nr_Cabinet)
);

CREATE TABLE Medici_Familie (
    Cod_Parafa varchar(255) NOT NULL,
    Nume varchar(255) NOT NULL,
    Prenume varchar(255) NOT NULL,
    Nr_Tel varchar(255) NOT NULL,
    PRIMARY KEY (Cod_Parafa)
);

CREATE TABLE Bilete_Trimitere (
    Seria varchar(255) NOT NULL, 
    Numar varchar(255) NOT NULL,
    CNP varchar(255) NOT NULL,
    Cod_Parafa varchar(255) NOT NULL,
    Data DATE NOT NULL,
    Diagnostic varchar(255) NOT NULL,
    Tip_Diagnostic varchar(255) NOT NULL,
    Specialitate varchar(255) NOT NULL,
    PRIMARY KEY (Seria, Numar),
    FOREIGN KEY (CNP) REFERENCES Pacienti (CNP),
    FOREIGN KEY (Cod_Parafa) REFERENCES Medici_Familie (Cod_Parafa)
);

CREATE TABLE Medicamente (
    Cod_Medicament varchar(255) NOT NULL,
    Denumire_Medicament varchar(255) NOT NULL, 
    Denumire_Comerciala varchar(255) NOT NULL,
    Data_Expirare varchar(255) NOT NULL,
    Forma_Farmaceutica varchar(255) NOT NULL,
    Cale_Administrare varchar(255) NOT NULL,
    PRIMARY KEY (Cod_Medicament)
);

CREATE TABLE Personal_Medical (
    CNP varchar(255) NOT NULL,
    Nr_Cabinet varchar(255) NOT NULL,
    Nume varchar(255) NOT NULL,
    Prenume varchar(255) NOT NULL,
    Sex varchar(1) NOT NULL,
    Nr_telefon varchar(255) NOT NULL,
    Email varchar(255),
    Tip_cadru varchar(255) NOT NULL,
    PRIMARY KEY (CNP),
    FOREIGN KEY (Nr_Cabinet) REFERENCES Cabinete (Nr_Cabinet)
);


CREATE TABLE Retete (
    CNP_pacient varchar(255) NOT NULL,
    CNP_medic varchar(255) NOT NULL,
    Nr_Reteta varchar(255) NOT NULL,
    PRIMARY KEY (Nr_Reteta),
    FOREIGN KEY (CNP_pacient) REFERENCES Pacienti (CNP),
    FOREIGN KEY (CNP_medic) REFERENCES Personal_Medical (CNP)
);

CREATE TABLE  Liste_Medicamente (
    Nr_Reteta varchar(255) NOT NULL,
    Cod_Medicament varchar(255) NOT NULL,
    Cantitate varchar(255),
    Concentratie varchar(255),
    PRIMARY KEY (Nr_Reteta, Cod_Medicament),
    FOREIGN KEY (Nr_Reteta) REFERENCES Retete (Nr_Reteta),
    FOREIGN KEY (Cod_Medicament) REFERENCES Medicamente (Cod_Medicament)
); 
 
CREATE TABLE Programari (
    CNP varchar(255) NOT NULL,
    Nr_Programare varchar(255) NOT NULL,
    Data DATE NOT NULL,
    Ora varchar(255) NOT NULL,
    Specialitate varchar(255) NOT NULL,
    Sectie varchar(255) NOT NULL,
    PRIMARY KEY (Nr_Programare),
    FOREIGN KEY (CNP) REFERENCES Pacienti (CNP)
);


CREATE TABLE Consult (
    Nr_Programare varchar(255) NOT NULL,
    Cod_consult varchar(255) NOT NULL,
    Nr_Cabinet varchar(255) NOT NULL,
    Tip varchar(255) NOT NULL,
    Observatie varchar(255),
    PRIMARY KEY (Cod_consult),
    FOREIGN KEY (Nr_Cabinet) REFERENCES Cabinete (Nr_Cabinet),
    FOREIGN KEY (Nr_Programare) REFERENCES Programari (Nr_Programare)
);    

CREATE TABLE Analize (
    CNP varchar(255) NOT NULL,
    Nr_Programare varchar(255) NOT NULL,
    Cod_Analiza varchar(255) NOT NULL,
    Tip_analiza varchar(255) NOT NULL,
    Rezultat varchar(255) NOT NULL,
    Data_com DATE NOT NULL,
    PRIMARY KEY (Cod_Analiza),
    FOREIGN KEY (CNP) REFERENCES Pacienti (CNP),
    FOREIGN KEY (Nr_Programare) REFERENCES Programari (Nr_Programare)
);

CREATE TABLE Diagnostice (
    CNP_pacient varchar(255) NOT NULL,
    CNP_medic varchar(255) NOT NULL,
    Cod_analiza varchar(255) NOT NULL,
    Cod_consult varchar(255) NOT NULL,
    Cod_diagnostic varchar(255) NOT NULL,
    Denumire varchar(255) NOT NULL,
    Observatii varchar(255),
    PRIMARY KEY (Cod_diagnostic),
    FOREIGN KEY (CNP_pacient) REFERENCES Pacienti (CNP),
    FOREIGN KEY (Cod_analiza) REFERENCES analize (Cod_analiza),
    FOREIGN KEY (CNP_medic) REFERENCES Personal_Medical (CNP),
    FOREIGN KEY (Cod_consult) REFERENCES Consult (Cod_consult)
);    


CREATE TABLE Operatii (
    CNP varchar(255) NOT NULL,
    Numar_Sala varchar(255) NOT NULL,
    Nr_Programare varchar(255) NOT NULL,
    Nr_operatie varchar(255) NOT NULL,
    Tip_operatie varchar(255) NOT NULL,
    Cod_Diagnostic varchar(255) NOT NULL,
    PRIMARY KEY (Nr_operatie),
    FOREIGN KEY (CNP) REFERENCES Pacienti (CNP),
    FOREIGN KEY (Numar_Sala) REFERENCES Sali (Numar_Sala),
    FOREIGN KEY (Cod_Diagnostic) REFERENCES Diagnostice (Cod_Diagnostic),
    FOREIGN KEY (Nr_Programare) REFERENCES Programari (Nr_Programare)
); 

CREATE TABLE Liste_Echipe (
    Nr_operatie varchar(255) NOT NULL,
    CNP varchar(255) NOT NULL,
    Nr_index varchar(255) NOT NULL,
    PRIMARY KEY (Nr_index),
    FOREIGN KEY (Nr_operatie) REFERENCES Operatii (Nr_operatie),
    FOREIGN KEY (CNP) REFERENCES Personal_Medical (CNP)
);

INSERT INTO Pacienti
VALUES ('1800201088411', 'Stoica', 'Lucian', TO_DATE('18/3/1980', 'DD/MM/YYYY'),
'M', '0257641621', 'camil54@hotmail.com', 'Brașov', 'Mun. Mihăilești', 'P-ța Muncii',
'nr. 143'
);
INSERT INTO Pacienti
VALUES ('1900201275332', 'Rusu', 'Iulian', TO_DATE('19/4/1990', 'DD/MM/YYYY'),
'M', '0245449904', 'dan.ene@teodorescu.com', 'Neamț', 'Săveni', 'Str. Mesteacănului', 
'nr. 5, bl. A, et. 2, ap. 8'
);
INSERT INTO Pacienti
VALUES ('1850201019083', 'Niță', 'Dragoș', TO_DATE('20/5/1985', 'DD/MM/YYYY'),
'M', '0335421886', 'nita.dragos@gmail.com', 'Alba', 'Alba Iulia', 'B-dul. Mihai Viteazul',
'nr. 3B, bl. 04, sc. B, et. 6, ap. 06'
);
INSERT INTO Pacienti
VALUES ('2701023039041', 'Găbureanu', 'Mădălina', TO_DATE('21/6/1970', 'DD/MM/YYYY'),
'F', '0250494445', 'xiliescu@trandafir.com', 'Argeș', 'Adjud', 'Calea Cireșilor',
'nr. 1'
);
INSERT INTO Pacienti
VALUES ('2951023157532', 'Tomulescu', 'Adela', TO_DATE('22/7/1995', 'DD/MM/YYYY'),
'F', '0796373077', 'mara.vasilescu@tamas.net', 'Dâmbovița', 'Răcari', 'P-ța Sinaia',
'nr. 1, bl. 8, ap. 94'
);

INSERT INTO Sali
VALUES ('10'
);
INSERT INTO Sali
VALUES ('16'
);
INSERT INTO Sali
VALUES ('8'
);
INSERT INTO Sali
VALUES ('2'
);
INSERT INTO Sali
VALUES ('5'
);

INSERT INTO Cabinete
VALUES ('8', 2
);
INSERT INTO Cabinete
VALUES ('7', 1
);
INSERT INTO Cabinete
VALUES ('11', 2
);
INSERT INTO Cabinete
VALUES ('4', 0
);
INSERT INTO Cabinete
VALUES ('14', 1
);

INSERT INTO Medici_Familie
VALUES ('283959', 'Drăgan', 'Ștefania', '0785445403'
); 
INSERT INTO Medici_Familie
VALUES ('292485', 'Țuțea', 'Elvira', '0370371690'
);
INSERT INTO Medici_Familie
VALUES ('322499', 'Dinescu', 'George', '0763470451'
);
INSERT INTO Medici_Familie
VALUES ('689768', 'Pălici', 'Denisa', '0728211926'
);
INSERT INTO Medici_Familie
VALUES ('458655', 'Barbu', 'Mirel', '0754905206'
);

INSERT INTO Bilete_Trimitere
VALUES ('BTCIE', '9331903', '1900201275332', '689768', TO_DATE('13/3/2022', 'DD/MM/YYYY'),
'C16.8 - Tumora maligna leziune depasind stomacul', 'Cronic', 'Chirurgie Generala'
);
INSERT INTO Bilete_Trimitere
VALUES ('BTCID', '5443009', '2701023039041', '283959', TO_DATE('3/1/2020', 'DD/MM/YYYY'),
'K74.6 - Alta ciroza a ficatului si nespecificata', 'Cronic', 'Hepatologie'
);
INSERT INTO Bilete_Trimitere
VALUES ('BTCIA', '9912766', '2951023157532', '292485', TO_DATE('15/12/2005', 'DD/MM/YYYY'),
'K76.0 - Degenerescenta grasoasa a ficatului, neclasificata altundeva', 'Cronic', 'Medicina interna'
);
INSERT INTO Bilete_Trimitere
VALUES ('BTICD', '1023922', '1800201088411', '322499', TO_DATE('17/10/2019', 'DD/MM/YYYY'),
'K56.6 - Alte obstructii intenstinale si nespecificate', 'Acut', 'Chirurgie Generala'
);
INSERT INTO Bilete_Trimitere
VALUES ('BTICE', '9998556', '2951023157532', '458655', TO_DATE('23/11/2017', 'DD/MM/YYYY'),
'C56 - Tumora maligna a ovarului', 'Cronic', 'Ginecologie'
);

INSERT INTO Medicamente
VALUES ('342748', 'Atropina', 'Atropine Sulphate', '13.06.2023', 'Injectie I.M.', 'Injectabil'
);
INSERT INTO Medicamente
VALUES ('134247', 'Scopalamina', 'Scopantil', '24.03.2023', 'Injectie', 'Injectabil'
);
INSERT INTO Medicamente
VALUES ('420127', 'Hidramina', 'Benadryl', '28.07.2024', 'Pastile',	'Per os'	
);
INSERT INTO Medicamente
VALUES ('690420', '4-Floroamfetamina', '4-Floroamfetamina',	'19.08.2024', 'Praf', 'Per os'	
);
INSERT INTO Medicamente
VALUES ('987141', 'Vitamina D 2000 UI', 'Detrical 2000', '30.11.2023', 'Pastile', 'Per os'
);

INSERT INTO Personal_Medical
VALUES ('2940615012559', '8', 'DIACONU', 'ADRIANA', 'F', '07347123832', NULL,
'MEDIC PRIMAR SEF SECTIE'
);
INSERT INTO Personal_Medical
VALUES ('2920331109068', '7', 'SBORA', 'RODICA', 'F', '07245845734', 'sbora.rod@gmail.com',
'MEDIC PRIMAR'
);
INSERT INTO Personal_Medical
VALUES ('5030217047040', '11', 'NEAMTU', 'TUDOR', 'M', '07357457845', NULL,
'MEDIC PRIMAR'
);
INSERT INTO Personal_Medical
VALUES ('2930808039902', '4', 'NEAMTU',	'ELENA', 'F', '07589348934', NULL,
'ASISTENT MEDICAL PR.'
);
INSERT INTO Personal_Medical
VALUES ('6011213525112', '14', 'VELICU', 'CARMEN', 'F', '07685823492', NULL,
'ASISTENT MEDICAL PR.'
);

INSERT INTO Retete
VALUES ('1800201088411', '2940615012559', '3936'
);
INSERT INTO Retete
VALUES ('1800201088411', '2920331109068', '2835'
);
INSERT INTO Retete
VALUES ('1850201019083', '5030217047040', '8907'
);
INSERT INTO Retete
VALUES ('2701023039041', '2930808039902', '1253'
);
INSERT INTO Retete
VALUES ('2951023157532', '6011213525112', '2536'
);

INSERT INTO Liste_Medicamente
VALUES ('3936', '342748', '20mL', '1%' 
);
INSERT INTO Liste_Medicamente
VALUES ('2835', '134247', '0,003g', NULL
);
INSERT INTO Liste_Medicamente
VALUES ('8907', '420127', '25mg', NULL
);
INSERT INTO Liste_Medicamente
VALUES ('1253', '690420', '150g', NULL
);
INSERT INTO Liste_Medicamente
VALUES ('2536', '987141', '320mg', '0.001%'
);

INSERT INTO Programari
VALUES ('1800201088411', '41234', TO_DATE('15/03/2022', 'DD/MM/YYYY'), '15:00',
'Neurochirurgie', 'Neurochirurgie'
);
INSERT INTO Programari
VALUES ('1900201275332', '54235', TO_DATE('17/03/2022', 'DD/MM/YYYY'), '13:00',
'O.R.L', 'O.R.L'	
);
INSERT INTO Programari
VALUES ('1850201019083', '77645', TO_DATE('22/03/2022', 'DD/MM/YYYY'), '16:00',
'Radiologie', 'Radiologie'
);
INSERT INTO Programari
VALUES ('2701023039041', '34245', TO_DATE('29/03/2022', 'DD/MM/YYYY'), '12:00',
'Dermato-Venerologie', 'Dermato-Venerologie'
);
INSERT INTO Programari
VALUES ('2951023157532', '23473',	TO_DATE('31/03/2022', 'DD/MM/YYYY'), '14:00',
'Reumatologie',	'Medicina Interna'
);

INSERT INTO Consult
VALUES ('41234', '145345', '8', 'Oftalmologie', NULL
);
INSERT INTO Consult
VALUES ('54235', '245235', '7', 'Ginecologie', NULL
);
INSERT INTO Consult
VALUES ('77645', '756743', '11', 'Dermato-Venerologie', NULL
);
INSERT INTO Consult
VALUES ('34245', '234146', '4', 'Reumatologie', NULL
);
INSERT INTO Consult
VALUES ('23473', '653424', '14', 'O.R.L', NULL
);

INSERT INTO Analize
VALUES ('1800201088411', '41234', '34799', 'RMN Cranio-cerebral',
'Boli si tulburari ale sistemului nervos', TO_DATE('28.03.2022', 'DD.MM.YYYY')
);
INSERT INTO Analize
VALUES ('1900201275332', '54235', '35734', 'Electroencefalograma (EEG)',
'Boli si tulburari mentale', TO_DATE('02.04.2022', 'DD.MM.YYYY')
);
INSERT INTO Analize
VALUES ('1850201019083', '77645', '25843', 'Computer tomografie glob ocular',
'Boala retiniana', TO_DATE('05.04.2022', 'DD.MM.YYYY')
);
INSERT INTO Analize
VALUES ('2701023039041', '34245', '34235', 'Spirometrie',
'BPOC (boala pulmonara obstructiva cronica)', TO_DATE('08.04.2022', 'DD.MM.YYYY')
);
INSERT INTO Analize
VALUES ('2951023157532', '23473', '23723', 'Endoscopie digestiva superioara',
'Ulcer duodenal hemoragic',	TO_DATE('09.04.2022', 'DD.MM.YYYY')
);

INSERT INTO Diagnostice
VALUES ('1800201088411', '2940615012559', '34799', '145345', '46121',
'Scleroza multipla', NULL
);
INSERT INTO Diagnostice
VALUES ('1900201275332', '2920331109068', '35734', '245235', '84578',
'Epilepsie grand mal', NULL
);
INSERT INTO Diagnostice
VALUES ('1850201019083', '5030217047040', '25843', '756743', '27382',
'Degenerescenta maculara', NULL
);
INSERT INTO Diagnostice
VALUES ('2701023039041', '2930808039902', '34235', '234146', '77583',
'Astm bronsic', NULL
);
INSERT INTO Diagnostice
VALUES ('2951023157532', '6011213525112', '23723', '653424', '34234',
'Ulcer duodenal complicat', NULL 
);

INSERT INTO Operatii
VALUES ('1800201088411', '10', '41234', '52342', 'Amputatie de rect clasica', '46121'
);
INSERT INTO Operatii
VALUES ('1800201088411', '16', '54235', '23412', 'Chist renal laparoscopic', '84578'
);
INSERT INTO Operatii
VALUES ('1850201019083', '8', '77645', '34253', 'Excizie granulom de fir', '27382'
);
INSERT INTO Operatii
VALUES ('2701023039041', '2', '34245', '12353', 'Gastroenteroanastomoze', '77583'
);
INSERT INTO Operatii
VALUES ('2951023157532', '5', '23473', '46234', 'Laparotomie exploratorie', '34234'
);

INSERT INTO Liste_Echipe
VALUES ('52342', '2940615012559', '1'
);
INSERT INTO Liste_Echipe
VALUES ('23412', '2920331109068', '2'
);
INSERT INTO Liste_Echipe
VALUES ('34253', '5030217047040', '3'
);
INSERT INTO Liste_Echipe
VALUES ('12353', '2930808039902', '4'
);
INSERT INTO Liste_Echipe
VALUES ('46234', '6011213525112', '5'
);