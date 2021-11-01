hydro = struct();

hydro = Read_AQWA(hydro,'ANALYSIS.AH1','ANALYSIS.LIS');
hydro = Radiation_IRF(hydro,60,[],[],[],[]);
hydro = Radiation_IRF_SS(hydro,[],[]);
hydro = Excitation_IRF(hydro,157,[],[],[],[]);
Write_H5(hydro)
Plot_BEMIO(hydro)