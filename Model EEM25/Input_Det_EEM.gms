Scalar
loss_ship /0.01/
loss_pipe /0.05/
Eff_liqui /0.75/
Eff_regas /0.95/
Eff_H2_Storage /0.9/
EL_Eff_H2_Storage /0.75/
Eff_OCGT_H2 /0.6/
Eff_RoR /0.9/
Max_Import_share /1/
EtP_Battery/6/
EtP_H2_Stor /168/

*in MRd EUR/ TWh
EL_load_shed_costs /12/
H2_prod_cost_mena /0.07/

H2_shed_costs /1/
H2_shed_costs_FU /0.27/
H2_shed_costs_ST /0.18/
H2_shed_costs_AM /0.15/
H2_shed_costs_HE /0.09/
H2_shed_costs_OT /0.05/

H2_import_costs /0.150/
H2_Rail_transport_cost /170/

*in TWh
H2_EU_production_goal /0/
scale
;

Parameter

upload_h2_demand                    upload table
upload_h2_elec                      upload table
Upload_OCGT
upload_h2_import_terminal           upload table
upload_h2_export_terminal           upload table
upload_h2_import                    upload table                 
upload_el_Renewable                 upload table
upload_el_Conventional
upload_el_Hydro_Storage
upload_h2_stor                      upload table
upload_el_stor                      upload table
upload_h2_network                   upload table
upload_el_network                   upload table

            
Scenario_H2_demand(n,s)
H2_yearly_demand(n)
H2_demand(t,n)
H2_export_potentials(nn,r,c,d)                     
H2_export_prices(nn,n,r,c,d)
H2_export_prices_II(nn,n,r,c,d) 

Yearly_H2_demand_Ammonia(n)
Yearly_H2_demand_Fuel(n)
Yearly_H2_demand_Steel(n)
Yearly_H2_demand_Heat(n)
Yearly_H2_demand_other(n)


probability(s)

Eff_Elec(h)
  
Ex_line_cap(l)
Ex_gen_cap(g)
Gen_Efficiency(g)
Ex_Hydro_Store_cap(hs)
HS_hours(hs)
Hs_Efficiency(hs)
Inflow_reservoir(t,hs)
Cap_Factor_ROR(t,g)
Var_cost(g)


IC_Line(l)
IC_Renewables(res)
IC_Battery_INV(b)
IC_Battery_STOR(b)

IC_Pipe_H2(p_H2)
IC_ELEC_H2(h)
IC_OCGT_H2(h)
IC_Import_Terminal_H2(n)
IC_Export_Terminal_H2(n)
IC_Stor_Tank_H2(h)
IC_Stor_Underground_H2(h)

Import_Costs_pipe(n)
Max_import_pipe(p_h2)
IC_Costs_ship(ship)
H2_pipe_lengh(p_H2)
H2_transport_costs(n)

Cap_H2_Storage_PCI(h)
Cap_ELectrolyzer_PCI(h)

Cap_H2_pipe_PCI(p_h2)
Max_cap_H2_pipe_ENTSOG(p_h2)
Pipe_Cap_up_to_Max_ENTSOG(p_H2)

Cap_H2_Terminal_PCI(n)
Max_Cap_H2_Terminal(n)
Terminal_Cap_up_to_max_ENTSOG(n)
El_demand_Import_Terminal(n)
El_demand_Export_Terminal(n)
Base_EL_Demand_country(t,n)
EL_Demand_country(t,n)
Ship_duration(ship)
Ship_distance(ship)
Ship_fuel_use(ship)

Upload_af_solar_PV(res,t)
af_solar_PV(t,res)

Upload_af_Wind(res,t)
af_Wind(t,res)
   

**********************************************input Excel table*******************************************************
;

$onecho > TEP.txt
set=n                           rng=Sets!C2                             rdim=1 cDim=0
set=EU                          rng=Sets!E2                             rdim=1 cDim=0
set=Mena                        rng=Sets!AG2                            rdim=1 cDim=0
set=l                           rng=Sets!G2                             rdim=1 cDim=0
set=p_H2                        rng=Sets!I2                             rdim=1 cDim=0
set=res                         rng=Sets!K2                             rdim=1 cDim=0
set=h                           rng=Sets!Q2                             rdim=1 cDim=0
set=b                           rng=Sets!S2                             rdim=1 cDim=0
set=g                           rng=Sets!M2                             rdim=1 cDim=0
set=hs                          rng=Sets!O2                             rdim=1 cDim=0
set=Import_countries            rng=Sets!U2                             rdim=1 cDim=0
set=Export_countries            rng=Sets!W2                             rdim=1 cDim=0
set=Exporting_Pipe_countries    rng=Sets!Y2                             rdim=1 cDim=0
set=Import_Pipe                 rng=Sets!AA2                            rdim=1 cDim=0
set=EU_h                        rng=Sets!AC2                            rdim=1 cDim=0
set=PCI_Pipe                    rng=Sets!AE2                            rdim=1 cDim=0
set=rail                        rng=Sets!AI2                            rdim=1 cDim=0

set=Map_Nodes_res               rng=Mapping!A2:B150                     rdim=2 cDim=0
set=Map_Nodes_h                 rng=Mapping!D2:E80                      rdim=2 cDim=0
set=Map_Nodes_b                 rng=Mapping!G2:H80                      rdim=2 cDim=0
set=Map_send_line               rng=Mapping!J2:K100                     rdim=2 cDim=0
set=Map_res_line                rng=Mapping!M2:N100                     rdim=2 cDim=0
set=Map_send_rail               rng=Mapping!AE2:AF100                   rdim=2 cDim=0
set=Map_res_rail                rng=Mapping!AH2:AI100                   rdim=2 cDim=0
set=Map_send_H2_pipe            rng=Mapping!P2:Q100                     rdim=2 cDim=0
set=Map_res_H2_pipe             rng=Mapping!S2:T100                     rdim=2 cDim=0
set=Map_nodes_g                 rng=Mapping!V2:W100                     rdim=2 cDim=0
set=Map_Nodes_HS                rng=Mapping!Y2:Z53                      rdim=2 cDim=0
set=Map_Ex_Im                   rng=Mapping!AB2:AC211                   rdim=2 cDim=0

par=upload_h2_demand            rng=H2_Demand!A49:D85                   rDim=1 cdim=1
par=upload_h2_elec              rng=H2_Supply!B2:I45                    rDim=1 cdim=1
par=upload_h2_import_terminal   rng=H2_Supply!A50:I72                   rDim=1 cdim=1
par=upload_el_Renewable         rng=EL_Supply!B1:F120                   rDim=1 cdim=1
par=upload_el_Conventional      rng=EL_Supply!K1:O120                   rDim=1 cdim=1
par=upload_el_Hydro_Storage     rng=EL_Supply!S1:Y120                   rDim=1 cdim=1
par=H2_export_potentials        rng=H2_Supply!L51:P109                  rDim=4 cdim=0
par=H2_export_prices            rng=H2_Supply!R51:W1289                 rDim=5 cdim=0
par=upload_h2_stor              rng=H2_Storage!B2:J45                   rDim=1 cdim=1
par=upload_el_stor              rng=EL_Storage!B2:G36                   rDim=1 cdim=1
par=upload_h2_network           rng=H2_Network!C1:J80                   rDim=1 cdim=1
par=upload_el_network           rng=EL_Network!A1:K96                   rDim=1 cdim=1
par=Upload_af_solar_PV          rng=EL_Availability!B2:LXZ41            rDim=1 cdim=1
par=Upload_af_Wind              rng=EL_Availability!B45:LXZ108          rDim=1 cdim=1
par=Base_EL_Demand_country      rng=EL_Demand!A1:AI4381                 rDim=1 cdim=1
par=Inflow_reservoir            rng=EL_Availability!E114:AD8874         rDim=1 cdim=1
par=Cap_Factor_ROR              rng=EL_Availability!AG114:BH8874        rDim=1 cdim=1
par=Upload_OCGT                 rng=EL_Supply!B131:D174                 rDim=1 cdim=1
par=Scenario_H2_demand          rng=H2_dem_Scenarios!A1:F37            rDim=1 cdim=1


$offecho    

$onUNDF
$call   gdxxrw Data.xlsx @TEP.txt
$GDXin  Data.gdx
$load   n, EU, l, p_H2, res, h, b  ,g, hs, Mena, rail
$load   Map_Nodes_res, Map_Nodes_h, Map_Nodes_HS, Map_nodes_g ,Map_Nodes_b,Map_Ex_Im
$load   Map_send_line, Map_res_line, Map_send_H2_pipe, Map_res_H2_pipe,EU_h, Map_send_rail, Map_res_rail
$load   Import_Pipe, Import_countries, Export_countries, PCI_Pipe
$load   upload_h2_demand,upload_h2_elec,upload_h2_import_terminal,upload_el_Renewable,upload_el_Conventional,upload_el_Hydro_Storage
$load   H2_export_potentials,H2_export_prices, upload_h2_stor,upload_h2_network,upload_el_network,upload_el_stor
$load   Upload_af_solar_PV, Upload_af_Wind, Base_EL_Demand_country
$load   Inflow_reservoir, Cap_Factor_ROR, Upload_OCGT
$load   Scenario_H2_demand
$GDXin
$offUNDF
;

**********************************************set declaration*******************************************************                   

solar_pv(res)   =    upload_el_Renewable(res,'tech')  = 1
;
wind_on(res)    =    upload_el_Renewable(res,'tech')  = 2
;
wind_off(res)   =    upload_el_Renewable(res,'tech')  = 3
;
wind(res)$(wind_on(res) or wind_off(res))          = yes
;           

biomass(g)      =     upload_el_Conventional(g,'tech') = 4
;                 
ror(g)          =     upload_el_Conventional(g,'tech') = 5
;
nuclear(g)      =     upload_el_Conventional(g,'tech') = 6
;                     
              
Reservoir(hs)   =     upload_el_Hydro_Storage(hs,'tech') = 7
;
PSP(hs)         =     upload_el_Hydro_Storage(hs,'tech') = 8
;

Continent(h)$(ord(h) lt 40) = yes
;
Export_Res(res)$(ord(res) ge 104 and ord(res) le 115) = yes
;
solar_pv_EU(res)$(solar_pv(res) and  ord(res) lt 104) = yes
;
wind_EU(res)$(wind(res) and ord(res) lt 104) = yes
;
solar_pv_export(res)$(solar_pv(res) and ord(res) ge 104) = yes
;
wind_export(res)$(wind(res) and  ord(res) ge 104) = yes
;
**********************************************load parameter data*******************************************************                
scale = 8760/card(t)
;
Ex_gen_cap(g)    =     upload_el_Conventional(g,'Nominal Capacity in MW')/1000000
;                 
Gen_Efficiency(g)=     upload_el_Conventional(g,'Efficiency')
;
* in Eur/TWh
Var_cost(nuclear)= 30000000
;
Var_cost(Biomass)= 45000000
;
*in Mrd EUR / TWh
Var_cost(nuclear) = Var_cost(nuclear) /1000000000
;
Var_cost(Biomass) = Var_cost(Biomass) /1000000000
;

Ex_Hydro_Store_cap(hs) =     upload_el_Hydro_Storage(hs,'Nominal Capacity in MW') /1000000
;
HS_hours(hs)           =     upload_el_Hydro_Storage(hs,'max_hours')
;
Hs_Efficiency(hs)      =     upload_el_Hydro_Storage(hs,'efficiency_dispatch') 
;
EL_Demand_country(t,n) = round((Base_EL_Demand_country(t,n) *1.6)/1000000,4)
;


*in EUR/MW to MRD. EUR/ TW = *1.000.000 / 1.000.000.000 = /1.000
IC_Renewables(res) = upload_el_Renewable(res, 'annualised_investment_costs_2050 EUR/MW') /1000
;
IC_line(l) = upload_el_network(l, 'Annualised investment costs EUR/MW') /1000
;
IC_pipe_H2(p_H2) = upload_h2_network (p_h2, 'Annualised_investment_costs_2050 EUR/MW') /1000
;
IC_ELEC_H2(h) = upload_h2_elec(h,'annualised_costs_2050 EUR/MW') /1000
;
IC_OCGT_H2(h)= Upload_OCGT(h,'annualised_costs_2050 EUR/MW') /1000
;
IC_Battery_INV(b) = upload_el_stor(b,'inverter MW 2050') /1000
;
IC_Battery_STOR(b) = upload_el_stor(b,'storage MWh 2050') /1000
;
*MRD. EUR/ TWh
IC_Import_Terminal_H2(n) = upload_h2_import_terminal(n,'annualised_costs_2050 EUR/MWh') /1000
;
IC_Stor_tank_H2(h) = upload_h2_stor(h,'annualised costs tank MWh 2050') /1000
;
IC_Stor_underground_H2(h) = upload_h2_stor(h,'annualised costs Underground MWh 2050') /1000
;
eff_elec(h)  = upload_h2_elec(h,'Efficiency 2050')
;
af_solar_PV(t,res) = round(Upload_af_solar_PV(res,t),3)
;
af_Wind(t,res) = round(Upload_af_Wind(res,t),3)
;

*from GWh/d to TWh = /24h /1000
Cap_H2_pipe_PCI(p_h2) = (upload_h2_network(p_h2,'PCI_cap_in_GWh/d') /24)/1000
;
Max_cap_H2_pipe_ENTSOG(p_h2) = (upload_h2_network(p_h2,'UB_capacity_ENTSOG_2050_in_GWh/d') /24)/1000
;
Pipe_Cap_up_to_Max_ENTSOG(p_H2) = Max_cap_H2_pipe_ENTSOG(p_h2) - Cap_H2_pipe_PCI(p_h2)
;
*in TWh
Cap_H2_Storage_PCI(h)  = upload_h2_stor(h,'Cap MWh')/ 1000000
;
*in TW
Cap_ELectrolyzer_PCI(h) = upload_h2_elec(h,'Power in MW') /1000000
;
Cap_H2_Terminal_PCI(n) = upload_h2_import_terminal(n,'Capacity in TWh/year') /card(t)
;
* from TWh in a year to TWh in time period t = / Anzahl der Zeitperioden t
Max_Cap_H2_Terminal(n) = upload_h2_import_terminal(n,'Max_cap_2040 in TWh') /card(t)
;
Terminal_Cap_up_to_max_ENTSOG(n) = Max_Cap_H2_Terminal(n) - Cap_H2_Terminal_PCI(n)
;
*From MW to TW 
Ex_line_cap(l) = upload_el_network(l,'s_nom')/1000000
;
El_demand_Import_Terminal(n) = upload_h2_import_terminal(n,'Electricity Use in MWhel/ MWh H2')
;
*El_demand_Export_Terminal(n) = upload_h2_export_terminal(n,'Electricity Use in MWhel/ MWh  h2')
*;
*from MWh to TWh
H2_export_potentials(nn,r,c,d) = H2_export_potentials(nn,r,c,d) / 1000000
;
* from EUR/MWh to Mrd Eur/ TWh
H2_transport_costs(n) = 200 / 1000
;
H2_export_prices(nn,n,r,c,d)  = H2_export_prices(nn,n,r,c,d) /1000
;
H2_export_prices_II(nn,n,r,c,d) = H2_export_prices(nn,n,r,c,d) + H2_transport_costs(n)
;


*pipeline lengh in 1000 km
H2_pipe_lengh(p_H2) = upload_h2_network (p_h2, 'lengh')/1000
;
probability(s) = 1
;
*from GWh/d in TWH/d
Inflow_reservoir(t,hs) = Inflow_reservoir(t,hs)/1000
;
*$ontext
*in MRD. EUR/ TWh = *1.000.000 / 1.000.000.000 = /1.000

*$offtext