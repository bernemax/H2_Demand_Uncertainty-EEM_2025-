Set
t /t1*t4380/             
n                       nodes
l                       electricity lines
p_H2                    Hydrogen Pipes                      
res                     renewable energy resources (wind and pv)
h                       hydrogen set
b                       battery set
ship                    hydrogen ship set           
g
hs
rail
s /s1*s5/

c /c3,c4/
d /D1,D2,D3/
r /r_pv, r_wind_onshore/
;

Alias
(n,nn)
;

Sets
EU(n)
Mena(n)
Continent(h)
EU_h(h)
Export_Res(res)
Exporting_Pipe_countries(h)

PCI_Pipe(p_H2)
Import_Pipe(p_H2)
Import_countries(n)
Export_countries(n)

ex_lines(l)             existing electricity lines
props_lines(l)          prospective electricity lines

solar_pv(res)           Subset solar PV
wind(res)               Subset all wind technologies
Wind_on(res)            Subset Onshore Wind
Wind_off(res)           Subset Offshore Wind
biomass(g)              Subset Biomass Generator
nuclear(g)              Subset Nuclear 
ror(g)                  Subset Run of River
PSP(hs)                 Subset pumping storage plant
Reservoir(hs)           Subset Hydro dam power plant

solar_pv_EU(res)
wind_EU(res)
solar_pv_export(res)           Subset solar PV ship export country
wind_export(res)               Subset all wind technologies ship export country


Map_Nodes_res(n,res)
Map_Nodes_h(n,h)
Map_Nodes_b(n,b)
Map_Nodes_g(n,g)
Map_Nodes_HS(n,HS)

Map_send_line(n,l)
Map_res_line(n,l)

Map_send_rail(n,rail)
Map_res_rail(n,rail)

Map_send_H2_pipe(n,p_H2)
Map_res_H2_pipe(n,p_H2)

Map_Ex_Im(nn,n)  

;

$include Input_det_EEM.gms
*execute_unload "check_input.gdx";
*$stop
;
Variables
OBjective
Flow_H2(t,p_h2)           Flow of H2 via Pipeline
Flow_EL(t,l)              Flow of Electricity via Transmissionline
;
Positive Variables
Cap_ELEC_h2(h)              Capacity Electrolyzer
CAP_OCGT_EL(h)              Capacity H2 fired Open Cycle Gas Turbine
Cap_Stor_h2(h)              Capacity Hydrogen Storage
Cap_battery_M(b)            Capacity Battery Storage
Cap_import_terminal_I(n)    Capacity Hydrogen Import Terminal first level decision
Cap_import_terminal_II(n) Capacity Hydrogen Import Terminal second level decision
Cap_res(res)                Capacity Renewable Generators
Cap_pipe_H2(p_h2)           Capacity Hydrogen pipeline
Cap_line_EL(l)              Capacity Transmission line
Cap_ship(ship)              capacity Transport Ship


shed_h2(n,t)
Shed_H2_Ammonia(t,n)
Shed_H2_Fuel(t,n)
Shed_H2_Steel(t,n)
Shed_H2_Heat(t,n)
Shed_H2_other(t,n)
Shed_EL(t,n)
Gen_Elec_h2(t,h)            Generation of H2 by Electrolyzer
Dis_Stor_h2(t,h)            Discharging of H2 from H2 Storage to H2 Balance
Gen_OCGT(t,h)               Discharging of H2 from H2 Storage to EL Balance
Charge_Stor_h2(t,h)         Charging of H2 by Storage from H2 Balance
Charge_Stor_h2_EL(t,h)      Charging of H2 by Storage from EL Balance
Level_Stor_h2(t,h)          Fillinglevel of H2 Storage
Gen_Res(t,res)              Generation of Renewables
Gen_Conv(t,g)               Generation of conventional power plants
Gen_hydro(t,hs)             Generation of hydro storage
Charge_hydro(t,hs)          Charge of hydro storage
Level_Stor_hS(t,hs)         Fillinglevel of Hydro Storage
Battery_lvl(t,b)
PG_Battery(t,b)
Battery_charge(t,b)
H2_prod_mena(t,n)
export_I(t,nn,n,r,c,d)
import_H2_I(t,n)
export_II(t,nn,n,r,c,d)
import_H2_II(t,n)
Transport_rail(t,rail)
Cap_rail(rail)
;

Equations
Objective_function
Balance_H2
Balance_EL

Production_H2_Cap_limit
Storage_Gen_OCGT_H2
EU_H2_goal

Storage_Cap_h2
Storage_Dis_cap_H2
Storage_Charge_cap_H2
Storage_level_h2
Storage_level_h2_start

Flow_H2_UP
FLow_H2_low

Import_h2_Import_Terminal_I
H2_export_potential
H2_export_balance_I

Production_EL_PV
Production_EL_Wind
Production_EL_Conventional
Production_EL_ROR

DIS_Battery
C_Battery
Cap_Battery
Stor_Battery_lvl_start
Stor_Battery_lvl

EL_HS_Storage_Cap
EL_HS_Storage_Dis_cap
EL_HS_Storage_Charge_cap
EL_HS_Storage_level
EL_HS_Storage_level_start

EL_Reservoir_Cap
EL_Reservoir_Gen_cap
EL_Reservoir_level

Flow_EL_UP
Flow_EL_low
;
*################################################Master Problem#################################################
********************************************Minimizing Total Costs**********************************************

Objective_function..                  OBjective =e= 
                                                  sum(h,Cap_ELEC_H2(h) * IC_ELEC_H2(h))
                                                + sum(h,Cap_Stor_h2(h) * EtP_H2_Stor * IC_Stor_tank_H2(h))
                                                + sum(h,CAP_OCGT_EL(h) * IC_OCGT_H2(h))
                                                + sum(res,Cap_res(res) * IC_Renewables(res))
                                                + sum(b,Cap_battery_M(b) * IC_Battery_INV(b))
                                                + sum(b,Cap_battery_M(b) * EtP_Battery * IC_Battery_STOR(b))
                                                + sum(n,Cap_import_terminal_I(n) * IC_Import_Terminal_H2(n) * scale)
                                                
                                                + sum((n,t), H2_prod_mena(t,n) * H2_prod_cost_mena * scale)
                                                   
                                                + sum((t,g),Gen_Conv(t,g) * Var_cost(g) * scale)
                                                
                                                + sum(p_h2,Cap_pipe_H2(p_h2) * IC_pipe_H2(p_H2))
                                                + sum(l,Cap_line_EL(l) * IC_line(l))
                                                
                                                + sum((t,nn,n,r,c,d), export_I(t,nn,n,r,c,d) * H2_export_prices(nn,n,r,c,d)* scale )

                                                + sum((t,n), Shed_EL(t,n) * EL_load_shed_costs * scale)
                                                                                            
;
********************************************Nodal Balance H2**********************************************

Balance_H2(t,n)..                     H2_demand(t,n) *100 =e= (
                                                              sum(h$Map_Nodes_h(n,h), Gen_Elec_h2(t,h)  * eff_elec(h))
                                                            - sum(h$Map_Nodes_h(n,h), Gen_OCGT(t,h))
                                                       
                                                            + sum(h$Map_Nodes_h(n,h), Dis_Stor_h2(t,h) - Charge_Stor_h2(t,h))
* Transport losses - 10% auf 1000 km                                                       
                                                            + sum((p_h2)$Map_res_H2_pipe(n,p_H2), Flow_H2(t,p_h2) - (Flow_H2(t,p_h2) * loss_pipe * H2_pipe_lengh(p_H2)))
                                                            - sum((p_h2)$Map_send_H2_pipe(n,p_H2), Flow_H2(t,p_h2)- (Flow_H2(t,p_h2) * loss_pipe * H2_pipe_lengh(p_H2)))
                                                            + import_H2_I(t,n)$Import_countries(n) * Eff_regas
                                                            + H2_prod_mena(t,n)$Mena(n)

                                                            ) * 100
                                                       
;
********************************************Nodal Balance EL**********************************************

Balance_EL(t,n)..                   EL_Demand_country(t,n) *100  =e= (
                                                            sum(res$Map_Nodes_res(n,res), Gen_Res(t,res))
                                                            + sum(g$Map_Nodes_g(n,g), Gen_Conv(t,g))
                                          
                                                            - sum(h$Map_Nodes_h(n,h), Gen_Elec_h2(t,h))
                                                            + sum(h$Map_Nodes_h(n,h), Gen_OCGT(t,h) * Eff_OCGT_H2)
                                                            + sum(b$Map_Nodes_b(n,b), PG_Battery(t,b) - Battery_charge(t,b))
                                           
                                                            + sum(PSP$Map_Nodes_HS(n,PSP), Gen_hydro(t,PSP)  -  Charge_hydro(t,PSP))
                                                            + sum(reservoir$Map_Nodes_HS(n,Reservoir), Gen_hydro(t,Reservoir))
                                          
                                                            + sum(l$Map_res_line(n,l),Flow_EL(t,l))
                                                            - sum(l$Map_send_line(n,l),Flow_EL(t,l))
                                                            - Cap_import_terminal_I(n) * El_demand_Import_Terminal(n)
                                                                                  
                                                            + Shed_EL(t,n)
                                                            ) *100
                                                                                   
                                        
;
********************************************H2 to EL Link************************************************

Production_H2_Cap_limit(t,h)..        Gen_Elec_h2(t,h)  =l= Cap_ELEC_H2(h) 
;
Storage_Gen_OCGT_H2(t,h)..            Gen_OCGT(t,h) =l= CAP_OCGT_EL(h) 
;
EU_H2_goal..                          sum((t,h)$EU_h(h),  Gen_Elec_h2(t,h)) =g= H2_EU_production_goal / scale
;

********************************************H2 Storage****************************************************

Storage_Cap_h2(t,h)..                 Level_Stor_h2(t,h) =l= (Cap_Stor_h2(h) * EtP_H2_Stor)/ scale
;
Storage_Dis_cap_H2(t,h)..             Dis_Stor_h2(t,h)  =l= Cap_Stor_h2(h) 
;
Storage_Charge_cap_H2(t,h)..          Charge_Stor_h2(t,h) =l= Cap_Stor_h2(h)   
;
Storage_level_h2(t,h)..               Level_Stor_h2(t,h) =e= Level_Stor_h2(t-1,h) + Charge_Stor_h2(t,h) * Eff_H2_Storage  - Dis_Stor_h2(t,h) 
;
Storage_level_h2_start(h)..           Level_Stor_h2('t1',h) =e= 0 + Charge_Stor_h2('t1',h) * Eff_H2_Storage  - Dis_Stor_h2('t1',h) 
;

********************************************H2 FLow*******************************************************

Flow_H2_UP(t,p_h2)..                  Flow_H2(t,p_h2) *100 =l= Cap_pipe_H2(p_h2) *100 
;
Flow_H2_low(t,p_h2)..                 Flow_H2(t,p_h2) *100 =g= - Cap_pipe_H2(p_h2) *100 
;

*********************************************H2 Import******************************************

Import_h2_Import_Terminal_I(t,n)$Import_countries(n)..        import_H2_I(t,n)  =l=  Cap_import_terminal_I(n) 
;

H2_export_potential(nn,r,c,d)..            sum((t,n), export_I(t,nn,n,r,c,d)$Map_Ex_Im(nn,n)) *10
                                              =l= (H2_export_potentials(nn,r,c,d)/ scale) * 10 
;
H2_export_balance_I(t,n)..                   sum((nn,r,c,d), export_I(t,nn,n,r,c,d)$Map_Ex_Im(nn,n)) =e= import_H2_I(t,n) 
;

********************************************EL RES & Biomass & ROR Production*************************************************

Production_EL_PV(t,solar_pv)..            Gen_Res(t,solar_pv) =l= Cap_res(solar_PV) * af_solar_PV(t,solar_PV) 
;
Production_EL_Wind(t,wind)..              Gen_Res(t,wind) =l= Cap_res(wind) * af_Wind(t,wind) 
;

Production_EL_Conventional(t,g)..         Gen_Conv(t,g) * 100 =l= Ex_gen_cap(g) * 100
;
Production_EL_ROR(t,ror)..                Gen_Conv(t,ror) * 1000 =l= (Ex_gen_cap(ror) * Cap_Factor_ROR(t,ror)) * 1000
;

********************************************EL Battery Storage*************************************************

Dis_Battery(t,b)..                         PG_Battery(t,b)        =l= Cap_battery_M(b) 
;
C_Battery(t,b)..                           Battery_charge(t,b)    =l= Cap_battery_M(b) 
;
Cap_Battery(t,b)..                         Battery_lvl(t,b)        =l= (Cap_battery_M(b) *6) / scale
;

Stor_Battery_lvl_start(b)..                Battery_lvl('t1',b)       =e= 0 + Battery_charge('t1',b) * 0.96 - PG_Battery('t1',b) 
;
Stor_Battery_lvl(t,b)$(ord(t) gt 1)..      Battery_lvl(t,b)        =e= Battery_lvl(t-1,b) + Battery_charge(t,b) * 0.96  -  PG_Battery(t,b) 
;

********************************************EL Hydro PSP & Reservoir *************************************************

EL_HS_Storage_Cap(t,PSP)..                Level_Stor_hS(t,PSP) =l= Ex_Hydro_Store_cap(PSP) * HS_hours(PSP) / scale
;
EL_HS_Storage_Dis_cap(t,PSP)..            Gen_hydro(t,PSP) * 100    =l= Ex_Hydro_Store_cap(PSP) * 100
;
EL_HS_Storage_Charge_cap(t,PSP)..         Charge_hydro(t,PSP) * 100  =l= Ex_Hydro_Store_cap(PSP) * 100 
;
EL_HS_Storage_level(t,PSP)..              Level_Stor_hS(t,PSP) =e= Level_Stor_hS(t-1,PSP) + Charge_hydro(t,PSP)* Hs_Efficiency(PSP) - Gen_hydro(t,PSP)
;
EL_HS_Storage_level_start(PSP)..          Level_Stor_hS('t1',PSP) =e=  Charge_hydro('t1',PSP)* Hs_Efficiency(PSP) - Gen_hydro('t1',PSP)
;

EL_Reservoir_Cap(t,Reservoir)..           Gen_hydro(t,Reservoir) * 100 =l= (Ex_Hydro_Store_cap(Reservoir)/ scale) * 100 
;
EL_Reservoir_Gen_Cap(t,Reservoir)..       Gen_hydro(t,Reservoir)  =l= Level_Stor_hS(t,Reservoir)
;
EL_Reservoir_level(t,Reservoir)..         Level_Stor_hS(t,Reservoir) * 100 =e= (Level_Stor_hS(t-1,Reservoir) + Inflow_reservoir(t,Reservoir) - Gen_hydro(t,Reservoir)) *100
;

********************************************EL Flow*******************************************************

Flow_EL_UP(t,l)..                         Flow_EL(t,l) * 100  =l= (Ex_line_cap(l) + Cap_line_EL(l)) *100
;
Flow_EL_low(t,l)..                        Flow_EL(t,l) * 100 =g= - (Ex_line_cap(l) - Cap_line_EL(l)) *100
;

********************************************Model definition**********************************************
model Loop_Det_EEM
/
Objective_function
Balance_H2
Balance_EL

Production_H2_Cap_limit
Storage_Gen_OCGT_H2
EU_H2_goal

Storage_Cap_h2
Storage_Dis_cap_H2
Storage_Charge_cap_H2
Storage_level_h2
Storage_level_h2_start

Flow_H2_UP
FLow_H2_low

Import_h2_Import_Terminal_I
H2_export_potential
H2_export_balance_I

Production_EL_PV
Production_EL_Wind
Production_EL_Conventional
Production_EL_ROR

DIS_Battery
C_Battery
Cap_Battery
Stor_Battery_lvl_start
Stor_Battery_lvl

EL_HS_Storage_Cap
EL_HS_Storage_Dis_cap
EL_HS_Storage_Charge_cap
EL_HS_Storage_level
EL_HS_Storage_level_start

EL_Reservoir_Cap
EL_Reservoir_Gen_cap
EL_Reservoir_level

Flow_EL_UP
Flow_EL_low
/

;

Parameter
Report_total_invest(*,*)
Report_total_capacity(*,*)
Report_total_Gen(*,*)
Report_total_Gen_cost(*,*)
Report_inv_share(*,*)
Report_scenarios(*,*,*)
Saldo_H2_Stor(*,*)
Gen_H2_Stor(*,*)
Report_costs(*)
Report_total_IM(s,*)
Report_total_Ex_IM(s,nn,n)
;


loop(s,

Cap_pipe_H2.up(p_h2) = Max_cap_H2_pipe_ENTSOG(p_h2)
;
H2_demand(t,n)  =Scenario_H2_demand(n,s) /  8760
;

Option LP = Gurobi
;

Loop_Det_EEM.optfile = 1
;
$onecho > Gurobi.opt
BarHomogeneous = 1
ScaleFlag=1
NumericFocus = 1
$offEcho

solve Loop_Det_EEM using LP minimizing OBjective

;
*########################################Master Report##########################################################
Report_scenarios(s,p_h2,'H2 Pipe Expansion in GWh')= Cap_pipe_H2.l(p_h2) * 1000  
;
Report_scenarios(s,n,'Long Terminal in GWh')$Import_countries(n) = (Cap_import_terminal_I.l(n))  * 1000 
;
Report_scenarios(s,h,'Electrolyzer Cap in GW') = Cap_ELEC_H2.l(h) * 1000 
;
Report_total_Gen(s,'ROR in TWh') = round(sum((t,ror), Gen_Conv.l(t,ror)),3) * scale
;
Report_total_Gen(s,'Reservoir in TWh') = round(sum((t,reservoir),Gen_hydro.l(t,Reservoir)),3) * scale
;
Report_total_Gen(s,'Biomass in TWh') = round(sum((t,biomass), Gen_Conv.l(t,biomass)),3) * scale
;
Report_total_Gen(s,'Nuclear in TWh') = round(sum((t,nuclear), Gen_Conv.l(t,nuclear)),3) * scale
;
Report_total_Gen(s,'solar PV in TWh') = round(sum((t, solar_pv), Gen_Res.l(t,solar_pv)),3) * scale
;
Report_total_Gen(s,'wind onshore in TWh') = round(sum((t, wind_on), Gen_Res.l(t,wind_on)),3) * scale
;
Report_total_Gen(s,'wind offshore in TWh') =  round(sum((t, wind_off), Gen_Res.l(t,wind_off)),3) * scale
;
Report_total_Gen(s,'OCGT in TWh') = round(sum((t,h), Gen_OCGT.l(t,h)),3) * scale
;
Report_total_Gen(s,'Total Electricity in TWh') = Report_total_Gen(s,'ROR in TWh') +Report_total_Gen(s,'Reservoir in TWh') +Report_total_Gen(s,'Biomass in TWh')
                                        + Report_total_Gen(s,'Nuclear in TWh') + Report_total_Gen(s,'solar PV in TWh') + Report_total_Gen(s,'wind onshore in TWh')
                                        + Report_total_Gen(s,'wind offshore in TWh') + Report_total_Gen(s,'OCGT in TWh') * scale
;
Report_total_Gen(s,'H2 from Electrolyzer in TWh') = round(sum((t,h)$EU_h(h),  Gen_Elec_h2.l(t,h)),3) * scale
;
Report_total_Gen(s,'H2 from Mena in TWh') = round(sum((t,n)$Mena(n),  H2_prod_mena.l(t,n)),3) * scale
;
Report_inv_share(s,'Share Electrolyzer on Electricity costs') = (Report_total_Gen(s,'OCGT in TWh')/ Eff_OCGT_H2) / Report_total_Gen(s,'H2 from Electrolyzer in TWh') 
;

Saldo_H2_Stor(s,t) =  sum(h, Dis_Stor_h2.l(t,h) - Charge_Stor_h2.l(t,h))
;
Gen_H2_Stor(s,t) = Saldo_H2_Stor(s,t)$(Saldo_H2_Stor(s,t) gt 0)
;
Report_inv_share(s,'Share H2 Storage on Electricity costs') = sum(t, Gen_H2_Stor(s,t))/(Report_total_Gen(s,'OCGT in TWh')/ Eff_OCGT_H2) 
;

Report_total_capacity(s,'ELEC in GW') =round(sum(h, Cap_ELEC_H2.l(h) * 1000),3)
;
Report_total_capacity(s,'OCGT in GW') = round(sum(h, CAP_OCGT_EL.l(h) * 1000 ),3)
;
Report_total_capacity(s,'H2 Storage Cap in GWh') = round(sum(h, Cap_Stor_h2.l(h) * 168 * 1000),3)
;
Report_total_capacity(s,'Solar PV in GW') = round(sum(solar_pv, Cap_res.l(solar_PV) * 1000),3)
;
Report_total_capacity(s,'Wind Onshore in GW') = round(sum(wind$Wind_on(wind), Cap_res.l(wind) * 1000 ) ,3)
;
Report_total_capacity(s,'Wind Offshore in GW') = round(sum(wind$Wind_off(wind), Cap_res.l(wind) * 1000) ,3)
;
Report_total_capacity(s,'Import Terminal Capacity in GWh/d') = round(sum(n,Cap_import_terminal_I.l(n)  * 1000 * (24/scale)),3)
;
Report_total_capacity(s,'Battery Storage in GWh') = round(sum(b,Cap_battery_M.l(b) * 6 * 1000 ),3)
;
Report_total_capacity(s,'Battery Inverter in GW') = round(sum(b,Cap_battery_M.l(b) * 1000 ),3)
;
                                                                                     

Report_total_invest(s,'Solar in Mrd. EUR') = sum(solar_pv, Cap_res.l(solar_PV) * IC_Renewables(solar_PV))
;
Report_total_invest(s,'Wind On in Mrd. EUR') = sum(wind$Wind_on(wind), Cap_res.l(wind) * IC_Renewables(wind))
;
Report_total_invest(s,'Wind Off in Mrd. EUR') = sum(wind$Wind_off(wind), Cap_res.l(wind) * IC_Renewables(wind))
;
Report_total_invest(s,'Battery Stor in Mrd. EUR') = sum(b, Cap_battery_M.l(b) * EtP_Battery * IC_Battery_STOR(b))
;
Report_total_invest(s,'Battery INV in Mrd. EUR') = sum(b, Cap_battery_M.l(b) * IC_Battery_INV(b))
;
Report_total_invest(s,'EL HV Line in Mrd. EUR') = sum(l,Cap_line_EL.l(l) * IC_line(l))
;

Report_total_invest(s,'ELEC in Mrd. EUR') = sum(h, Cap_ELEC_H2.l(h) * IC_ELEC_H2(h))
;
Report_total_invest(s,'H2 Storage in Mrd. EUR') = sum(h, Cap_Stor_h2.l(h) * EtP_H2_Stor * IC_Stor_tank_H2(h))
;
Report_total_invest(s,'H2 OCGT in Mrd. EUR') = sum(h, CAP_OCGT_EL.l(h) * IC_OCGT_H2(h))
;
Report_total_invest(s,'Terminals in Mrd. EUR') = sum(n, Cap_import_terminal_I.l(n) * IC_Import_Terminal_H2(n) * scale)
;
Report_total_invest(s,'Pipeline in Mrd. EUR') = sum(p_h2, Cap_pipe_H2.l(p_h2) * IC_pipe_H2(p_H2))
;

Report_total_invest(s,'ELEC EL share in Mrd. EUR') = sum(h, Cap_ELEC_H2.l(h) * IC_ELEC_H2(h)) * Report_inv_share(s,'Share Electrolyzer on Electricity costs')
;
Report_total_invest(s,'ELEC H2 share in Mrd. EUR') = sum(h, Cap_ELEC_H2.l(h) * IC_ELEC_H2(h)) * (1- Report_inv_share(s,'Share Electrolyzer on Electricity costs'))
;
Report_total_invest(s,'H2 Stor EL share in Mrd. EUR') = sum(h, Cap_ELEC_H2.l(h) * IC_ELEC_H2(h)) * Report_inv_share(s,'Share H2 Storage on Electricity costs')
;
Report_total_invest(s,'H2 Stor H2 share in Mrd. EUR') = sum(h, Cap_ELEC_H2.l(h) * IC_ELEC_H2(h)) * (1- Report_inv_share(s,'Share H2 Storage on Electricity costs'))
;


Report_total_Gen_cost(s,'Conventionals in Mrd. EUR') = sum((t,g), Gen_Conv.l(t,g) * Var_cost(g) * scale)
;
Report_total_Gen_cost(s,'Mena in Mrd. EUR') = sum((t,n), H2_prod_mena.l(t,n) * H2_prod_cost_mena * scale)
;

Report_costs(s) = OBjective.l
;
Report_total_IM(s,'gH2 in TWh') = sum((t,n), import_H2_I.l(t,n) * Eff_regas * scale)
;
Report_total_IM(s,'Import Costs in Mrd. EUR') =  sum((t,nn,n,r,c,d), export_I.l(t,nn,n,r,c,d) * H2_export_prices(nn,n,r,c,d)* scale )
;
Report_total_Ex_IM(s,nn,n) = round(sum((t,r,c,d), export_I.l(t,nn,n,r,c,d)$Map_Ex_Im(nn,n)),3) * scale
;

execute_unload "Check_loop_EEM_final.gdx";
;

)
;
execute_unload "Results_Det_EEM.gdx";
$stop


