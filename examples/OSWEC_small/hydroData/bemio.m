hydro = struct();

hydro = Read_AQWA(hydro,'oswec.AH1','oswec.LIS');
hydro = Radiation_IRF(hydro,30,[],[],[],[]);
hydro = Radiation_IRF_SS(hydro,[],[]);
hydro = Excitation_IRF(hydro,30,[],[],[],[]);
Write_H5(hydro)
Plot_BEMIO(hydro)