import pandas as pd
import numpy as np
import json
from itertools import chain

import matplotlib.pyplot as plt
import matplotlib as mpl

import seaborn as sns

import pprint
ppdict = pprint.PrettyPrinter(indent=4, sort_dicts=False)


import time

# variable:idx

with open("variables_idxs.jl",'r') as f:
    u0l = [l.rstrip('\n') for l in f.readlines()]

u0ld = {}

for l in u0l:
    idx,n = l.split("\t")
    u0ld[eval(idx)] = n

print(len(u0ld))

ub2idx = '''u_h_m_n = u[1]
u_k_m_n = u[2]
u_mg2_m_n = u[3]
u_nadh_m_n = u[4]
u_q10h2_m_n = u[5]
u_focytC_m_n = u[6]
u_o2_c_n = u[7]
u_atp_m_n = u[8]
u_adp_m_n = u[9]
u_notBigg_ATP_mx_m_n = u[10]
u_notBigg_ADP_mx_m_n = u[11]
u_pi_m_n = u[12]
u_atp_i_n = u[13]
u_adp_i_n = u[14]
u_amp_i_n = u[15]
u_notBigg_ATP_mi_i_n = u[16]
u_notBigg_ADP_mi_i_n = u[17]
u_pi_i_n = u[18]
u_notBigg_MitoMembrPotent_m_n = u[19]
u_notBigg_Ctot_m_n = u[20]
u_notBigg_Qtot_m_n = u[21]
u_h_i_n = u[22]
u_atp_c_n = u[23]
u_adp_c_n = u[24]
u_fum_m_n = u[25]
u_mal_L_m_n = u[26]
u_oaa_m_n = u[27]
u_succ_m_n = u[28]
u_succoa_m_n = u[29]
u_coa_m_n = u[30]
u_akg_m_n = u[31]
u_ca2_m_n = u[32]
u_icit_m_n = u[33]
u_cit_m_n = u[34]
u_accoa_m_n = u[35]
u_acac_c_n = u[36]
u_aacoa_m_n = u[37]
u_pyr_m_n = u[38]
u_bhb_c_n = u[39]
u_bhb_e_e = u[40]
u_bhb_c_a = u[41]
u_bhb_b_b = u[42]
u_asp_L_m_n = u[43]
u_asp_L_c_n = u[44]
u_glu_L_m_n = u[45]
u_mal_L_c_n = u[46]
u_oaa_c_n = u[47]
u_akg_c_n = u[48]
u_glu_L_c_n = u[49]
u_nadh_c_n = u[50]
u_h_m_a = u[51]
u_k_m_a = u[52]
u_mg2_m_a = u[53]
u_nadh_m_a = u[54]
u_q10h2_m_a = u[55]
u_focytC_m_a = u[56]
u_o2_c_a = u[57]
u_atp_m_a = u[58]
u_adp_m_a = u[59]
u_notBigg_ATP_mx_m_a = u[60]
u_notBigg_ADP_mx_m_a = u[61]
u_pi_m_a = u[62]
u_atp_i_a = u[63]
u_adp_i_a = u[64]
u_amp_i_a = u[65]
u_notBigg_ATP_mi_i_a = u[66]
u_notBigg_ADP_mi_i_a = u[67]
u_pi_i_a = u[68]
u_notBigg_MitoMembrPotent_m_a = u[69]
u_notBigg_Ctot_m_a = u[70]
u_notBigg_Qtot_m_a = u[71]
u_h_i_a = u[72]
u_atp_c_a = u[73]
u_adp_c_a = u[74]
u_fum_m_a = u[75]
u_mal_L_m_a = u[76]
u_oaa_m_a = u[77]
u_succ_m_a = u[78]
u_succoa_m_a = u[79]
u_coa_m_a = u[80]
u_akg_m_a = u[81]
u_ca2_m_a = u[82]
u_icit_m_a = u[83]
u_cit_m_a = u[84]
u_accoa_m_a = u[85]
u_acac_c_a = u[86]
u_aacoa_m_a = u[87]
u_pyr_m_a = u[88]
u_gln_L_c_n = u[89]
u_gln_L_e_e = u[90]
u_gln_L_c_a = u[91]
u_glu_L_c_a = u[92]
u_notBigg_Va_c_a = u[93]
u_na1_c_a = u[94]
u_k_c_a = u[95]
u_k_e_e = u[96]
u_glu_L_syn_syn = u[97]
u_notBigg_VNeu_c_n = u[98]
u_na1_c_n = u[99]
u_notBigg_hgate_c_n = u[100]
u_notBigg_ngate_c_n = u[101]
u_ca2_c_n = u[102]
u_notBigg_pgate_c_n = u[103]
u_notBigg_nBK_c_a = u[104]
u_notBigg_mGluRboundRatio_c_a = u[105]
u_notBigg_IP3_c_a = u[106]
u_notBigg_hIP3Ca_c_a = u[107]
u_ca2_c_a = u[108]
u_ca2_r_a = u[109]
u_notBigg_sTRP_c_a = u[110]
u_notBigg_vV_b_b = u[111]
u_notBigg_EET_c_a = u[112]
u_notBigg_ddHb_b_b = u[113]
u_o2_b_b = u[114]
u_glc_D_b_b = u[115]
u_glc_D_ecsEndothelium_ecsEndothelium = u[116]
u_glc_D_ecsBA_ecsBA = u[117]
u_glc_D_c_a = u[118]
u_glc_D_ecsAN_ecsAN = u[119]
u_glc_D_c_n = u[120]
u_g6p_c_n = u[121]
u_g6p_c_a = u[122]
u_f6p_c_n = u[123]
u_f6p_c_a = u[124]
u_fdp_c_n = u[125]
u_fdp_c_a = u[126]
u_f26bp_c_a = u[127]
u_glycogen_c_a = u[128]
u_amp_c_n = u[129]
u_amp_c_a = u[130]
u_g1p_c_a = u[131]
u_g3p_c_n = u[132]
u_g3p_c_a = u[133]
u_dhap_c_n = u[134]
u_dhap_c_a = u[135]
u_13dpg_c_n = u[136]
u_13dpg_c_a = u[137]
u_nadh_c_a = u[138]
u_pi_c_n = u[139]
u_pi_c_a = u[140]
u_3pg_c_n = u[141]
u_3pg_c_a = u[142]
u_2pg_c_n = u[143]
u_2pg_c_a = u[144]
u_pep_c_n = u[145]
u_pep_c_a = u[146]
u_pyr_c_n = u[147]
u_pyr_c_a = u[148]
u_lac_L_b_b = u[149]
u_lac_L_e_e = u[150]
u_lac_L_c_a = u[151]
u_lac_L_c_n = u[152]
u_nadph_c_n = u[153]
u_nadph_c_a = u[154]
u_6pgl_c_n = u[155]
u_6pgl_c_a = u[156]
u_6pgc_c_n = u[157]
u_6pgc_c_a = u[158]
u_ru5p_D_c_n = u[159]
u_ru5p_D_c_a = u[160]
u_r5p_c_n = u[161]
u_r5p_c_a = u[162]
u_xu5p_D_c_n = u[163]
u_xu5p_D_c_a = u[164]
u_s7p_c_n = u[165]
u_s7p_c_a = u[166]
u_e4p_c_n = u[167]
u_e4p_c_a = u[168]
u_gthrd_c_n = u[169]
u_gthrd_c_a = u[170]
u_gthox_c_n = u[171]
u_gthox_c_a = u[172]
u_creat_c_n = u[173]
u_pcreat_c_n = u[174]
u_creat_c_a = u[175]
u_pcreat_c_a = u[176]
u_camp_c_a = u[177]
u_nrpphr_e_e = u[178]
u_udpg_c_a = u[179]
u_utp_c_a = u[180]
u_notBigg_GS_c_a = u[181]
u_notBigg_GPa_c_a = u[182]
u_notBigg_GPb_c_a = u[183]'''

ub2idx_d = {}

for l in ub2idx.replace(" ","").split('\n'):
    lhs,rhs = l.split("=")
    ub2idx_d[eval(rhs.replace("u[","").replace("]",""))] = lhs

print(len(ub2idx_d))






# initial values

u0_ss = {}

u0_ageSpec_fn = "u0_age_young.csv" # common ini values for y and o, age-spec blood nutrients conc are overwritten below

newssfn = "data/"+u0_ageSpec_fn

u0_ssf = pd.read_csv(newssfn, sep=',',header=None)[0].to_dict()

u0_ss = {}

for k,v in u0_ssf.items():
    u0_ss[k+1] = v

u0_ss[129] = 0 # 1.0e-5
u0_ss[130] = 0; # 1.0e-5




# special param of PCm ratio of expression in n vs a for sim with PCm_n
neurastrExprRatio = 0.1

# params
T2Jcorrection = 0.2783450473253539
W_x = 0.6434999999999998

synInput = 1.0e-12
Iinj = 1.0e-12
global_par_t_0 = 200.0
global_par_t_fin = 20.0
Km_coa_scs_a = 0.056
Km_succ_scs_n = 0.836589467070621
VfAAT_n = 1.2829135841551298
VmaxSuccoaATPscs_n = 410.83664327655714
VmaxfSCOT_n = 2.6842893020795207
Vmaxpk_a = 8.88447689329492
KmdhapAld_a = 0.03
KiCoA_n = 0.02
KmnadGpdh_a = 0.0106952634603107
KiNADHKGDHKGDH_na = 0.0045
KmGSHsyn_a = 0.03
VmaxMCTbhb_n = 0.29032861767118245
KmPFKF6P_a = 0.035
TaLac = 133.75
Kmpg3pgm_n = 0.22
K_R5P_TKL1_n = 0.000585387
Km_akgmito_mkgc_n = 0.2
kmg7_GSAJay = 0.015
Km_pi_scs_na = 2.5
Km_fummito_n = 0.15102517071248805
mu_glia_ephys = 0.1
KmnadhGapdh_n = 0.00817504585255996
k_PiH = 0.00045082
TmaxGLCin = 0.4
AmaxPscs_a = 1.2
KiNADHmito_na = 0.00475
K_NADP_G6PDH_a = 0.13
KeqCAAT_n = 0.358
VmaxTKL2_a = 0.13463638716265247
npscs_a = 3.0
KmNADmito_na = 0.5033
KmGSSGRNADPH_n = 0.00852
KiAKG_AAT_n = 1.9
Km_betaHB_BHBD_n = 0.45
VmPYRCARB_a = 0.00755985436706299
K_GAP_TKL1_a = 0.049985901384741
r_DH = 4.35730398512522
KeqCKnpms = 0.04265840286184623
Km_AcAc_SCOT_n = 0.25
KmNADg_jlv = 162.04744400627905
v1TRPsinf_a = 120.0
Ki_SUC_SCOT_n = 0.54
KutpUDPGP = 0.05
KmfbpAld_n = 0.003
VmaxPFK_a = 0.15208109403904177
k1NADPHox_a = 0.005509761591955474
VmaxPFK_n = 0.3511362207540195
Km_atpmito_scs_n = 0.0156620432157514
k_mADP_a = 1.07960040439672e-5
nu_oxphos_a = 0.0615914841992225
K_RU5P_RPE_n = 0.0537179
Ca4BK = 0.00015
VmfLDH_a = 8.74949881831907
mu_oxphos_n = 0.00778541423822839
gKirV = 0.27
Kmbpg13pgk_n = 0.1
Ki_SucCoA_kgdhKGDH_n = 0.0039
k_Pi4 = 0.02531
KiHKG6P_n = 0.01021
KpCa_pump_a = 0.00019
VmaxrUDPGP = 0.017682514423336453
KiGLU_AAT_n = 10.7
Km_ADPmito_scs_n = 0.25
KmdhapTPI_n = 0.6
k1NADPHox_n = 0.0009369376443550519
glycine_a = 2.0
TMaxLACgc = 0.11045454545454546
K_DD_a = 0.000328048467890892
K_R5P_TKL1_a = 0.000585387
KmPump = 0.5
nu_oxphos_n = 0.244089708012957
K_R5P_RPI_n = 0.778461
Km_F6P_rPGI_a = 0.095
ReGee3 = 0.73
KiASP_AAT_n = 263.0
KeqRPI_a = 35.9999996723297
x_DH_a = 0.014771869267445427
KmPyrMitoPDH_n = 0.068
KeqGDH_a = 1.5
KmCoAmitoPDH_n = 0.007684422893475319
KmNADn_jlv = 2.023244602040409
KmPYR_PYRCARB_a = 0.05638211229110231
K_S7P_TKL1_n = 0.192807
K_F6P_TKL2_a = 1.99901443230202
Vmax6PGL_n = 8711.029873731239
Kmpg3pgm_a = 0.22
K_RU5P_RPI_n = 0.0537179
Kmoxacmdh_n = 0.04
TbLac = 10.90909090909091
k_Pi3 = 0.000192
Kmpg3pgk_n = 0.67
Kmatppgk_a = 0.431968764786817
x_MgA = 1.0e6
KiGLUGLS_n = 45.0
x_A = 85.0
ReGio = 1.0
K_NADP_6PGDH_n = 0.0330619252781597
K_NADPH_6PGDH_n = 5.2529395568622e-5
x_C4 = 0.00032131
VmaxrSCOT_n = 0.08787851881807955
KeqTKL2_a = 0.142052917466236
Vmax6PGDH_n = 80.41773386353813
x_F1 = 7099.66908851658
VmaxAco_a = 9.438075110105698
Ki_SucCoA_kgdhKGDH_a = 0.0039
KeqGLS_n = 25.0
KiHKG6P_a = 0.0137
Km_succoa_scs_n = 0.02852096394334664
KmNADkgdhKGDH_na = 0.021
K_GO6P_6PGL_a = 2.28618
Kg1pUDPGP = 0.1
KiADPmito_KGDH_n = 0.6
ReGio5 = 0.72
KmgapTPI_a = 0.4
ReGoi3 = 1.0
KmpiAC_a = 0.01
Km_NAD_B_HBD_n = 0.2
KmGSSGRGSSG_n = 0.0652
VKirS = 26.8
K_GL6P_G6PDH_a = 0.0180932
KiAKG_GDH_a = 0.25
VmaxTAL_a = 30.710157982217925
KmMCT1_bHB_a = 6.03
KmGLU_GDH_a = 3.5
Kmatppgk_n = 0.38728441113536
H_ast_EAAT = 6.0e-5
KmPyrCytTr_n = 0.15
KmMCT2_bHB_n = 1.2
gammaCaaTRPVsinf = 5.0e-5
gammaCapTRPVsinf = 0.32
Vmaxpgk_a = 95.5247294642638
INaKaKThr = 20.0
kL2_GS_a = 0.4502909779144298
KeGSHSyn_a = 5.6
x_C3 = 0.2241
Km_malmito_n = 0.3
Km_G6P_fPGI_n = 0.593
e2TRPVsinf = 0.046
Na_n2_baseNKA = 18.0
kgi_PHK = 10.0
KmIsoCitIDHm_a = 0.15
Ki_f6p_f_26_pase_g = 0.02
Ki_NADH_BHBD_r_n = 0.39
Km_CoA_kgdhKGDH_a = 0.005
KicAMPAC_a = 0.045
Km_LacTr_n = 0.74
kbath = 4.0
KmcAMPAC_a = 0.4
ReGee = 1.0
muGLNsynth_a = 0.01
Km_G6P_fPGI_a = 0.593
KmdhapTPI_a = 0.6
Km_oxa_mdh_n = 0.1
KmCitAco_a = 0.48
K_i = 0.12
K_GAP_TKL1_n = 0.00499217405386077
VmaxMDHmito_a = 107.964870005644
EBK = -80.0
Km_AcAcCoA_thiolase_f_n = 0.021
KmGPXGSH_a = 1.13224874593032
x_F1_a = 6306.50439347496
Km_pep_enol_a = 0.15
kPumpn = 2.2e-6
betaLacDiff = 0.0
Km_Lac_a = 3.5
Keqald_a = 0.0005
x_KH = 2.9802e7
C_O_a = 8.34
Vmaxfpglm_a = 1.8474212896979174
K_NADP_6PGDH_a = 0.200000007547866
kmind_PHK = 2.0e-6
MnCyto_jlv = 4.653e-8
Keqpgm_n = 0.1814
x_ANT_a = 0.0881948452324846
Vmaxpk_n = 7.48969758041304
Vmaxmakgc_n = 0.000262718660265385
Km_glumito_agc_n = 2.8
VmaxHK_a = 0.4129411
K_GL6P_6PGL_n = 0.0180932
KmOxaMito_n = 0.005
KiNAD_GDH_a = 1.0
Kmpg2pgm_a = 0.28
Kmpg2enol_n = 0.05
Km1KGDHKGDH_n = 0.8
KmPyrMitoPDH_a = 0.068
K_RU5P_6PGDH_a = 0.0537179
KeLDH_a = 0.046994407267851
KeG4 = 8.0
Ki_SucCoA_SCOT_n = 2.4
kg2_GSAJay = 0.5
K_DT_a = 0.00194323827864375
KmG1PPGLM_a = 0.01
Keqpgm_a = 0.1814
Vmaxenol_n = 12.0
kCKnps = 0.0214016075483191
Ki_ATP_pk_n = 1.88029571803631
Crtot = 10.0
Vmf_GSSGR_a = 0.003
VmaxRPI_n = 0.013057366069767283
VmaxRPE_n = 0.2039985464986835
kmL2_GS_a = 1.4
Kmnadcmdh_n = 0.05
Vmax_bHBDH_f_n = 0.05139599967731973
Km_adp_pk_a = 0.510068084908044
K_GAP_TKL2_a = 0.28731529730184
ImaxNaKa = 1.45
epsilon = 1.0
KmpiGpdh_a = 3.9
KeG2 = 12.5
TnNADH_jlv = 2910.22500248421
KO2b = 0.0361
KmNADmitoPDH_na = 0.036
kg7_GSAJay = 20.257289129639318
KeGSHSyn_n = 5.6
Vmax_PYRtrcyt2mito_nH = 7257.23890975437
Vmaxpgm_n = 1.0002776306165402
Km_pep_pk_a = 0.074
K_E4P_TKL2_n = 0.109681
KmOxaMito_a = 0.004
KmHK_a = 0.05
KmPyrMitoTr_n = 0.15
glycine_n = 10.0
Km_mal_mkgc_n = 0.4
KmHK_n = 0.05
kmg6_PHK = 0.005
Kmadppgk_a = 0.363316278693795
x_C1 = 1020.0
AmaxPscs_n = 1.2
Kmmalcmdh_n = 0.77
KiCitMito_a = 1.0
Vmaxagc_n = 0.0001830479496983698
KeqRPE_a = 33.0
KiATPmito_KGDH_n = 0.0108261270854904
Km_mal_mdh_n = 0.4
KmASP_AAT_n = 0.5
VmaxcMDH_n = 11.927187547739674
Kmnadhcmdh_n = 0.05
VKirAV = 31.15
VfCAAT_n = 0.6248605383756786
KIATPhex_a = 0.554
gleakA = 0.04
KeqPGLM_a = 4.9
MnMito_jlv = 366600.0
ReGio3 = 0.73
V_GPX_n = 0.001072378746836681
VmaxfAC_a = 0.003
KmGSSGRNADPH_a = 0.00852
ReGio2 = 1.0
gKirS = 1.6
kg2_PHK = 0.5
alpha_EAAT = 0.41929231117352916
KmAKG_GDH_a = 1.1
x_Pi2 = 327.0
VmaxMCTbhb_b = 0.35559905936750225
x_Hle = 149.61265600173826
C_Glc_a = 4.6
Vmax_PFKII_g = 0.0031731959656441096
VleakA = -40.0
ReGio4 = 1.36
k_Pi2 = 0.000677
K_DT = 0.00166023273526023
K_X5P_RPE_a = 0.603002
Keq6PGDH_a = 37.38848579759115
TmaxGLCeb = 20.0
Km_asp_agc_n = 0.05
K_GAP_TAL_n = 1.434093758861
Km_glycine_GSHsyn_a = 0.3
K_X5P_RPE_n = 0.603002
KiNADH_GDH_a = 0.004
Vmaxgapdh_n = 182.64561255814576
gTRP = 0.4
kCKgps = 0.00178189983486018
KmPyrCytTr_a = 0.15
KmGSHsyn_n = 0.03
Keqenol_a = 0.8
KmGP_AMP_a = 0.1
Km1KGDHKGDH_a = 0.6287013099563603
KiGLU_CAAT_n = 10.7
K_S7P_TAL_a = 0.192807
K_S7P_TKL1_a = 0.192807
K_GL6P_G6PDH_n = 0.0180932
KmASP_CAAT_n = 6.7
KeqTAL_a = 0.95
VmfLDH_n = 241.739831262545
VMaxMitoinn = 0.877982001488671
coeff_gln_ratio_n_ecs = 2.5
KmGLNGLS_n = 12.0
k_Pi1 = 0.00013413
KmgapTPI_n = 0.4
VmaxMDHmito_n = 390.370655175952
Kmpg3pgk_a = 0.67
st_GSAJay = 0.003
KmAcCoAmito_n = 0.0048
KiATPmito_KGDH_a = 0.054580855381112
KIATPhex_n = 0.554
KeqTKL1_a = 9860.43282385396
v4BK = 14.5
MgMito_jlv = 9620.0
Km_AcAc_BHBD_n = 0.2
K_G6P_G6PDH_n = 0.0109183101365999
KiPFK_ATP_na = 0.666155029035142
Kmpg2enol_a = 0.05
KtLACgc = 1.0
K_X5P_TKL1_n = 0.000173625
KeqAAT_n = 0.14
Km_AcAcCoA_SCOT_n = 0.19
gBK = 2.16
Keqcmdh_n = 3.15e-5
ReGoi5 = 1.0
KmnadhGapdh_a = 0.008659493402079
K_F6P_TAL_a = 5.00000000000008e-5
KCaactIP3_a = 0.00017
K_S7P_TAL_n = 0.192807
VmaxrAC_a = 0.0001
Keqald_n = 0.1
Kmpg2pgm_n = 0.28
glutamylCys_n = 0.021375
K_GL6P_6PGL_a = 0.0180932
Km_adp_pk_n = 0.562062013433244
KiGLU_GDH_a = 3.5
KmGapGapdh_n = 0.101
gamma = 5.99
K_X5P_TKL1_a = 0.000173625
KeG3 = 8.0
Km_NADH_BHBD_n = 0.05
KeqTKL1_n = 9860.43282385396
KiAKG_CAAT_n = 1.0
KeG5 = 2.8
INaKaNaThr = 30.0
VmaxGLNsynth_a = 0.020022679766390446
KmCO2_PYRCARB_a = 3.2
VmaxGP_a = 0.001843542832727982
VmaxHK_n = 0.51617647
KmnadGpdh_n = 0.00947604205269482
Km_atpmito_scs_a = 0.0164177843454365
VmaxKGDH_n = 28.6907036435173
KmMCT1_bHB_b = 12.5
KiNADmito_na = 0.14
s2_PHK = 0.001
K_RU5P_RPE_a = 0.0537179
Keqtpi_n = 20.0
Km_glycine_GSHsyn_n = 0.3
Vmaxpgm_a = 1.0
KeqPYRCARB_a = 1.0
KmPFKF6P_n = 0.05170785
VmaxG6PDH_a = 477.195127843729
Vmaxald_a = 3.2308258205047813
k_mADP = 1.03045032866899e-5
C_bHB_a = 0.3
Vmax_fPGI_a = 0.5408672262560398
KmfbpAld_a = 0.003
v5BK = 8.0
K_R5P_RPI_a = 0.778461
KiASP_CAAT_n = 21.0
Ki_CoA_thiolase_f_n = 0.05
HbOP = 8.6
Km_oxa_mdh_a = 0.1
K_NADP_G6PDH_n = 0.0835423944062894
K_F6P_TKL2_n = 1.38310526172865
K_RU5P_RPI_a = 0.0537179
ReGoi2 = 1.0
KeqRPI_n = 0.587090549959032
Keqtpi_a = 20.0
x_DH = 0.0478558445772299
v2TRPsinf_a = 13.0
Km_malmito_mkgc_n = 0.71
Km_glutamylCys_GSHsyn_n = 0.022
Km_aspmito_agc_n = 0.05
TmaxGLCai = 0.032
Vmaxald_n = 1.400146917265416
KmIsoCitAco_n = 0.12
Vmax6PGL_a = 8.839100733681803
Ki_ATP_pk_a = 1.76791009718649
K_G6P_G6PDH_a = 0.03
VmaxSuccoaATPscs_a = 182.496590618396
K_RU5P_6PGDH_n = 0.0537179
KmSNAT_GLN_n = 1.1
Keq6PGDH_n = 23.4988291155184
VmaxPDHCmito_a = 2.79810789599674
VmaxIDH_n = 1194.49868869589
KmG6PPGLM_a = 0.001
Km_SUC_SCOT_n = 23.0
cai0_ca_ion = 5.0e-5
Ki_NAD_B_HBD_f_n = 0.45
KmSNAT_GLN_a = 1.1
KbLac = 1.0
KmNADH_GDH_a = 0.04
TmaxSNAT_GLN_a = 0.054730164766604375
KmGSSGRGSSG_a = 0.0652
Vmax_bHBDH_r_n = 0.012848999919329931
K_DD = 0.000409766157053928
Kmbpg13pgk_a = 0.1
NADtot = 0.000726
KmgapAld_n = 0.08
KmGapGapdh_a = 0.101
ReGee4 = 1.36
Vmaxgapdh_a = 3388.635929380235
Km_succ_scs_a = 1.6
VmaxfUDPGP = 0.004420628605834113
KeqG6PDH_a = 0.008
Km_CoA_thiolase_f_n = 0.056
PScapA = 0.8736
KmAcCoAmito_a = 0.0048
K_X5P_TKL2_n = 0.603002
Km_akg_mkgc_n = 0.1
K_E4P_TKL2_a = 0.109681
V_oxphos_a = 2.45307864305658
KiCa2KGDH_n = 1.2e-5
KIIP3_a = 1.0e-5
KmIsoCitAco_a = 0.12
Keqpgk_na = 2600.0
KmF26BP_PFK_a = 0.0042
VmGLS_n = 330.14406166650446
TmaxGLCba = 8.0
Km_SucCoA_SCOT_n = 4.2
VmaxCSmito_n = 0.4689427553439143
VmaxMCTbhb_a = 0.29
KmCoAmitoPDH_a = 0.0047
KmOXA_CAAT_n = 0.11
r_DH_a = 4.51551099390501
Km_mal_mdh_a = 0.4
ReGoi4 = 1.0
KmMito = 0.04
ReGoi = 1.0
x_AK = 0.0
Km_coa_scs_n = 0.056
KiADPmito_KGDH_a = 0.5046016363070087
KeqRPE_n = 34.9820646657167
KmACATP_a = 0.8
VmaxAco_n = 25.611147830094392
Vmaxenol_a = 12.0
s1_PHK = 100.0
Keq6PGL_n = 961.0
K_NADPH_G6PDH_n = 5.7841990084678e-5
KeqAco_na = 0.11
k_O2 = 0.00012
K_GO6P_6PGDH_n = 3.23421e-5
KeqTKL2_n = 0.142052917466236
Km_glutamylCys_GSHsyn_a = 0.022
TmaxSNAT_GLN_n = 0.07614698345131839
x_Ht = 2044.5370854408536
VmaxTKL1_a = 0.004900238015784919
VmGDH_a = 0.0192685649342926
KmIsoCitIDHm_n = 0.15
pt_PHK = 0.007
Kmcamppde_a = 0.0055
KUDPglucoUDPGP_a = 0.05
Vmax_fPGI_n = 0.5109590762636075
ReGee5 = 0.72
glutamylCys_a = 0.4
Km_malmito_a = 0.3
Ki_AcAcCoA_SCOT_n = 0.033
Vmax_thiolase_f_n = 1.0
Keqfummito_na = 6.0
K_E4P_TAL_a = 0.109681
kg8_GSAJay = 5.0
Km_CoA_kgdhKGDH_n = 0.005
Vmax_PYRtrcyt2mito_aH = 7961.37240852442
KiCa2KGDH_a = 1.2e-5
Km_ADPmito_scs_a = 0.25
kPumpg = 4.5e-7
Vmaxtpi_n = 0.9842422040175792
Km_glu_agc_n = 5.6
VmaxRPE_a = 0.4272424527742825
beta_EAAT = 0.035
V_oxphos_n = 4.60513160667386
mu_oxphos_a = 0.0478833989798708
K_X5P_TKL2_a = 0.603002
Km_F6P_rPGI_n = 0.095
TgNADH_jlv = 55.0410655992489
VmaxGSHsyn_a = 1.5e-5
Vmaxpgk_n = 90.8064278816738
x_K = 0.0
Km_fummito_a = 0.14
VmaxCSmito_a = 0.7181459358580017
Km_nadh_mdh_na = 0.044
VmaxTKL1_n = 0.004950133634259906
glia_c = 30.0
VmaxPDHCmito_n = 2.67222326259307
Keqenol_n = 0.8
kg5_PHK = 1915.1920260832771
KeqG6PDH_n = 0.00674385476573124
Keqsuccoascs_na = 3.8
VmaxG6PDH_n = 2413.389592436078
VmaxTKL2_n = 0.030468555594855798
EETshift = 2000.0
KmPyrMitoTr_a = 0.15
KpiUDPGP = 0.2
KmgapAld_a = 0.08
KmatpPFKII_g = 0.0675993571084336
Keq6PGL_a = 961.0
KeqTAL_n = 3.0
KeLDH_n = 0.00329708625924639
Keqmdhmito_na = 0.025
KmGLU_CAAT_n = 5.0
Km_pep_pk_n = 0.074
ReGee2 = 1.0
VmaxRPI_a = 0.014902971468358402
Na_syn_EAAT = 150.0
VmaxPDE_a = 0.001
Vmaxfum_a = 42.24027032956515
VMaxMitoing = 34.5066477078802
K_AK = 0.0
Km_f26bp_f_26pase_g = 0.07
Vmaxtpi_a = 1.0263480086710068
K_oxphos_n = 1.0
K_E4P_TAL_n = 0.109681
Km_nad_mdh_na = 0.06
x_Pi1 = 385000.0
KmpiGpdh_n = 3.9
K_F6P_TAL_n = 0.00045967540870832
KmAKG_AAT_n = 1.3
K_GO6P_6PGDH_a = 3.23421e-5
KmdhapAld_n = 0.03
KiCitMito_n = 1.0
KmGLU_AAT_n = 3.5
MgCyto_jlv = 0.0002614
VmaxKGDH_a = 7.74815022676304
KmMito_a = 0.02
KmAKG_CAAT_n = 0.15
Kmf6pPFKII_g = 0.027
r0TRPVsinf = 0.0237
VCa_pump_a = 0.055
s1_GSAJay = 100.0
Pleak_CaER_a = 0.001
Km_pep_enol_n = 0.15
KmCitAco_n = 0.48
kGLCdiff = 0.29
C_Lac_a = 0.75
VmaxTAL_n = 77.12873595245502
KiCoA_a = 0.02
K_GO6P_6PGL_n = 2.28618
TmaxGLCce = 2.21
kmg8_GSAJay = 0.00012
kTRPVsinf = 0.101
K_NADPH_G6PDH_a = 2.0e-5
Keqgapdh_na = 0.2
Vmax6PGDH_a = 1.7337940118891872e7
Kmadppgk_n = 0.350477947537394
ImaxIP3_a = 1.0
KoPFK_f26bp_a = 0.55
VmaxIDH_a = 332.052098136637
K_GAP_TKL2_n = 0.123421366286679
V_GPX_a = 0.0011730710542436833
PScapNAratio = 1.9
K_NADPH_6PGDH_a = 4.00000000000001e-5
KmGPXGSH_n = 0.571655480073944
K_oxphos_a = 1.0
x_ANT = 0.0647001029937813
KiPFK_ATP_a = 0.666155029035142
KeqCKgpms = 0.034
KmOXA_AAT_n = 0.1
KmBPG13Gapdh_n = 0.0035
Km_act_adpPFKII_g = 0.0667721029996198
KmBPG13Gapdh_a = 0.0035
muPYRCARB_a = 0.01
Vmaxfum_n = 129.92082588239924
KmGLNsynth_a = 2.0
K_GAP_TAL_a = 1.99999999999998
Vmf_GSSGR_n = 0.006
v6BK = -13.0
Km_succoa_scs_a = 0.041
KeG = 10.3
kmg5_PHK = 0.01
VmaxGSHsyn_n = 1.5e-5
kg6_PHK = 500.0
TnLac = 53.409090909090914

###
k_dHPi = 1.7782794100389227e-7


# fixed and calc from conservation laws:

C_H_cyt_n = 3.981071705534969e-5
C_H_cyt_a = 3.981071705534969e-5
CO2_mito_n = 1.2
CO2_mito_a = 1.2
PPi_a0 = 0.0062
PHKa_a0 = 4.0e-7
PP1_a0 = 1.0e-6

u_h_c_n = 3.981071705534969e-5 #C_H_cyt_n
u_h_c_a = 3.981071705534969e-5 #C_H_cyt_a
u_co2_m_n = 1.2 #CO2_mito_n
u_co2_m_a = 1.2 #CO2_mito_a
u_ppi_c_a = 0.0062 #PPi_a0
u_notBigg_PHKa_c_a = 4.0e-7 #PHKa_a0
u_notBigg_PP1_c_a_initialValue = 1.0e-6 #PP1_a0

###

qAK = 0.92
ATDPtot_n = 1.4449961078157665
ATDPtot_a = 1.3434724532826217

Crtot = 10.0

###

Mg_tot = 0.02

###


etcF = 0.096484
etcRT = 2.5785871
RTF = 26.73
F = 96485.3
R = 8.31
T = 310.0

dG_C1o = -69.37
dG_C3o = -32.53
dG_C4o = -122.94
dG_F1o = 36.03

tau_max = 0.6
K_n_Rest = 120.0
Na_n_Rest = 8.0

gKpas = 0.04
gNan = 0.0136
Na_out = 150.0
gL = 0.02
gNa = 56.0
gK = 6.0
gCa = 0.02
ECa = 120.0
gmAHP = 6.5

KD = 0.03

g_M = 0.075

Ee = 0.0

SmVn = 25000.0
SmVg = 25000.0

glia = 50.0

gNag = 0.0061

Ca3BK = 0.0004
VTRP = 6.0
Ca_perivasc = 0.005

n_A = 3.0
nIDH = 3
npscs_n = 3

eto_b = 0.0055

global_par_F_0 = 0.012
global_par_delta_F = 0.42

global_par_t_1 = 2.0

global_par_tau_v = 35.0

param_degree_nh = 2.73

H_syn_EAAT = 4.0e-5

hGPa = 1.5
nHhexn = 4.0
nHhexa = 4.0

nPFKn = 4.0
nPFKa = 4.0
nPFKf26bp_a = 5.5

vATPasesn = 0.0
