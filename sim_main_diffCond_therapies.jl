using DifferentialEquations
using ModelingToolkit, Symbolics

using DelimitedFiles
using Dates

import Random
Random.seed!(357819)

println(Dates.format(now(), "HH:MM:SS")  )

all_custom_setups = [
     "1_blood_glc_ini",
     "2_blood_lac_ini",
     "3_blood_bhb_ini",
     "4_aKG_ini",
     "5_succoa_ini",
     "6_fum_ini",
     "7_mal_ini",
     "8_oxa_ini",
     "9_glc_pls",
     "10_lac_pls",
     "11_bhb_pls",
     "12_akg_pls",
     "13_succoa_pls",
     "14_fum_pls",
     "15_mal_pls",
     "16_oxa_pls",
     "17_glclac_ini",
     "18_glcbhb_ini",
     "19_lacbhb_ini",
     "20_glclacbhb_ini",

     # glut1 def
     "g1_21_blood_glc_ini",
     "g1_22_blood_lac_ini",
     "g1_23_blood_bhb_ini",
     "g1_24_aKG_ini",
     "g1_25_succoa_ini",
     "g1_26_fum_ini",
     "g1_27_mal_ini",
     "g1_28_oxa_ini",
     "g1_29_glc_pls",
     "g1_30_lac_pls",
     "g1_31_bhb_pls",
     "g1_32_akg_pls",
     "g1_33_succoa_pls",
     "g1_34_fum_pls",
     "g1_35_mal_pls",
     "g1_36_oxa_pls",
     "g1_37_glclac_ini",
     "g1_38_glcbhb_ini",
     "g1_39_lacbhb_ini",
     "g1_40_glclacbhb_ini",


     # glut1-glut3 def
     "g13_41_blood_glc_ini",
     "g13_42_blood_lac_ini",
     "g13_43_blood_bhb_ini",
     "g13_44_aKG_ini",
     "g13_45_succoa_ini",
     "g13_46_fum_ini",
     "g13_47_mal_ini",
     "g13_48_oxa_ini",
     "g13_49_glc_pls",
     "g13_50_lac_pls",
     "g13_51_bhb_pls",
     "g13_52_akg_pls",
     "g13_53_succoa_pls",
     "g13_54_fum_pls",
     "g13_55_mal_pls",
     "g13_56_oxa_pls",
     "g13_57_glclac_ini",
     "g13_58_glcbhb_ini",
     "g13_59_lacbhb_ini",
     "g13_60_glclacbhb_ini",

    # glut1 def
    "g1_61_def",

    # glut1-glut3 def
    "g13_62_def",

    "63_AcAcCoA_ini",
    "64_Acon",
    "g1_65_PCm_keto",
    "g1_66_PCm_lac",
    "g1_67_PCm",
    "g1_68_AcAcCoA",
    "g1_69_Acon",
    "g1_70_ISOCIT",
    "g1_71_LDH_keto",
    "g1_72_LDH",
    "g1_73_PDH_keto",
    "g1_74_PDH_lac",
    "g1_75_PDH",
    "g1_76_SUCmito",
    "g13_77_AcAcCoA",
    "g13_78_LDH_keto",
    "g13_79_LDH",
    "g13_80_PDH_keto",
    "g13_81_PDH",
    "82_ISOCIT",
    "83_LDH",
    "84_PCm_bloodglc",
    "85_PCm",
    "86_PDHdef_bloodglc",
    "87_PDHdef_bloodlac",
    "88_PDHdef",
    "89_SUCmito",
    "g1_90_AcAcCoa_lac",
    "g1_91_PDH_Lac_keto",


     "g1_92_blood_glc_ini_dose1",
     "g1_93_blood_glc_ini_dose2",
     "g1_94_blood_glc_ini_dose3",
     "g1_95_blood_glc_ini_dose4",
     "g1_96_blood_glc_ini_dose5",

     "g1_97_blood_lac_ini_dose1",
     "g1_98_blood_lac_ini_dose2",
     "g1_99_blood_lac_ini_dose3",
     "g1_100_blood_lac_ini_dose4",
     "g1_101_blood_lac_ini_dose5",

     "g1_102_blood_bhb_ini_dose1",
     "g1_103_blood_bhb_ini_dose2",
     "g1_104_blood_bhb_ini_dose3",
     "g1_105_blood_bhb_ini_dose4",
     "g1_106_blood_bhb_ini_dose5",

     "g1_107_blood_lacbhb_ini_dose1",
     "g1_108_blood_lacbhb_ini_dose2",
     "g1_109_blood_lacbhb_ini_dose3",
     "g1_110_blood_lacbhb_ini_dose4",
     "g1_111_blood_lacbhb_ini_dose5",

    "g1_112_blood_lac_ini_dose6",
    "g1_113_blood_lac_ini_dose7",
    "g1_114_blood_lac_ini_dose8",
    "g1_115_blood_lacbhb_ini_dose6",
    "g1_116_blood_lacbhb_ini_dose7",
    "g1_117_blood_lacbhb_ini_dose8",

    "g1_118_keto_lac_nad",
    "g1_119_keto_lac_nad_Qtot_n",
    "g1_120_keto_lac_nad_Qtot_na",

    "121_default",


     "g1_122_AcAcCoA_ini_dose1",
     "g1_123_AcAcCoA_ini_dose2",
     "g1_124_AcAcCoA_ini_dose3",
     "g1_125_AcAcCoA_ini_dose4",
     "g1_126_AcAcCoA_ini_dose5",

     "g1_127_AcCoAmito_na_ini_dose1",
     "g1_128_AcCoAmito_na_ini_dose2",
     "g1_129_AcCoAmito_na_ini_dose3",
     "g1_130_AcCoAmito_na_ini_dose4",
     "g1_131_AcCoAmito_na_ini_dose5",

     "g1_132_SUCCOAmito_na_ini_dose1",
     "g1_133_SUCCOAmito_na_ini_dose2",
     "g1_134_SUCCOAmito_na_ini_dose3",
     "g1_135_SUCCOAmito_na_ini_dose4",
     "g1_136_SUCCOAmito_na_ini_dose5",

    # DR in control
     "137_blood_glc_ini_dose1",
     "138_blood_glc_ini_dose2",
     "139_blood_glc_ini_dose3",
     "140_blood_glc_ini_dose4",
     "141_blood_glc_ini_dose5",

     "142_blood_lac_ini_dose1",
     "143_blood_lac_ini_dose2",
     "144_blood_lac_ini_dose3",
     "145_blood_lac_ini_dose4",
     "146_blood_lac_ini_dose5",

     "147_blood_bhb_ini_dose1",
     "148_blood_bhb_ini_dose2",
     "149_blood_bhb_ini_dose3",
     "150_blood_bhb_ini_dose4",
     "151_blood_bhb_ini_dose5",

     "152_AcCoAmito_na_ini_dose1",
     "153_AcCoAmito_na_ini_dose2",
     "154_AcCoAmito_na_ini_dose3",
     "155_AcCoAmito_na_ini_dose4",
     "156_AcCoAmito_na_ini_dose5",

     "157_SUCCOAmito_na_ini_dose1",
     "158_SUCCOAmito_na_ini_dose2",
     "159_SUCCOAmito_na_ini_dose3",
     "160_SUCCOAmito_na_ini_dose4",
     "161_SUCCOAmito_na_ini_dose5",


    # DR in therapy
     "th_162_blood_glc_ini_dose1",
     "th_163_blood_glc_ini_dose2",
     "th_164_blood_glc_ini_dose3",
     "th_165_blood_glc_ini_dose4",
     "th_166_blood_glc_ini_dose5",

     "th_167_blood_lac_ini_dose1",
     "th_168_blood_lac_ini_dose2",
     "th_169_blood_lac_ini_dose3",
     "th_170_blood_lac_ini_dose4",
     "th_171_blood_lac_ini_dose5",

     "th_172_blood_bhb_ini_dose1",
     "th_173_blood_bhb_ini_dose2",
     "th_174_blood_bhb_ini_dose3",
     "th_175_blood_bhb_ini_dose4",
     "th_176_blood_bhb_ini_dose5",

     "th_177_AcCoAmito_na_ini_dose1",
     "th_178_AcCoAmito_na_ini_dose2",
     "th_179_AcCoAmito_na_ini_dose3",
     "th_180_AcCoAmito_na_ini_dose4",
     "th_181_AcCoAmito_na_ini_dose5",

     "th_182_SUCCOAmito_na_ini_dose1",
     "th_183_SUCCOAmito_na_ini_dose2",
     "th_184_SUCCOAmito_na_ini_dose3",
     "th_185_SUCCOAmito_na_ini_dose4",
     "th_186_SUCCOAmito_na_ini_dose5",

    "th_187_ATP_dose1",
    "th_188_ATP_dose2",
    "th_189_ATP_dose3",
    "th_190_ATP_dose4",
    "th_191_ATP_dose5"

    ]



println("###################### START NEW SIM ###########################")

srun_idx = all_custom_setups[191] # all_custom_setups[parse(Int,ARGS[1])] # CHOOSE HERE idx from all_custom_setups, starts from 1
println(srun_idx)

if srun_idx == "121_default"
    default_or_custom_config = "default"
else
    default_or_custom_config = "custom"
end

println(default_or_custom_config)


# special param of PCm ratio of expression in n vs a for sim with PCm_n
neurastrExprRatio = 0.1

modeldirname = "metabolism_unit_models/"
pardirname = string(modeldirname,"parameters/")

include(string(modeldirname,"u0_db_refined_selected_oct2021.jl"))

include(string(pardirname,"general_parameters.jl"))
include(string(pardirname,"ephys_parameters.jl"))
include(string(pardirname,"bf_input.jl"))
include(string(pardirname,"generalisations.jl"))
include(string(pardirname,"GLC_transport.jl"))
include(string(pardirname,"GLYCOLYSIS.jl"))
include(string(pardirname,"glycogen.jl"))
include(string(pardirname,"creatine.jl"))
include(string(pardirname,"ATDMP.jl"))
include(string(pardirname,"pyrTrCytoMito.jl"))
include(string(pardirname,"lactate.jl"))
include(string(pardirname,"TCA.jl"))
include(string(pardirname,"ETC.jl"))
include(string(pardirname,"PPP_n.jl"))
include(string(pardirname,"PPP_a.jl"))
include(string(pardirname,"gshgssg.jl"))
include(string(pardirname,"MAS.jl"))
include(string(pardirname,"gltgln.jl"))
include(string(pardirname,"pyrCarb.jl"))
include(string(pardirname,"ketones.jl"))

###########################################



u0l = ["C_H_mitomatr_n0","K_x_n0","Mg_x_n0","NADHmito_n0","QH2mito_n0","CytCredmito_n0","O2_n0",
    "ATPmito_n0","ADPmito_n0","ATP_mx_n0","ADP_mx_n0","Pimito_n0","ATP_i_n0","ADP_i_n0","AMP_i_n0","ATP_mi_n0","ADP_mi_n0","Pi_i_n0",
    "MitoMembrPotent_n0","Ctot_n0","Qtot_n0","C_H_ims_n0","ATP_n0","ADP_n0",
    "FUMmito_n0","MALmito_n0","OXAmito_n0","SUCmito_n0","SUCCOAmito_n0","CoAmito_n0","AKGmito_n0","CaMito_n0","ISOCITmito_n0","CITmito_n0","AcCoAmito_n0",
    "AcAc_n0","AcAcCoA_n0","PYRmito_n0","bHB_n0","bHB_ecs0","bHB_a0","bHB_b0","ASPmito_n0","ASP_n0","GLUmito_n0","MAL_n0","OXA_n0","AKG_n0","GLU_n0",
    "NADH_n0","C_H_mitomatr_a0","K_x_a0","Mg_x_a0","NADHmito_a0","QH2mito_a0","CytCredmito_a0","O2_a0",
    "ATPmito_a0","ADPmito_a0","ATP_mx_a0","ADP_mx_a0","Pimito_a0","ATP_i_a0","ADP_i_a0","AMP_i_a0","ATP_mi_a0","ADP_mi_a0","Pi_i_a0",
    "MitoMembrPotent_a0","Ctot_a0","Qtot_a0","C_H_ims_a0","ATP_a0","ADP_a0",
    "FUMmito_a0","MALmito_a0","OXAmito_a0","SUCmito_a0","SUCCOAmito_a0","CoAmito_a0","AKGmito_a0","CaMito_a0","ISOCITmito_a0","CITmito_a0","AcCoAmito_a0",
    "AcAc_a0","AcAcCoA_a0","PYRmito_a0","GLN_n0","GLN_out0","GLN_a0","GLUT_a0",
    "Va0","Na_a0","K_a0","K_out0","GLUT_syn0","VNeu0","Na_n0","h0","n0","Ca_n0","pgate0","nBK_a0","mGluRboundRatio_a0","IP3_a0","hIP3Ca_a0","Ca_a0","Ca_r_a0","sTRP_a0",
    "vV0","EET_a0","ddHb0","O2cap0","Glc_b0","Glc_t_t0","Glc_ecsBA0","Glc_a0","Glc_ecsAN0","Glc_n0","G6P_n0","G6P_a0","F6P_n0","F6P_a0","FBP_n0","FBP_a0","f26bp_a0","GLY_a0",
    "AMP_n0","AMP_a0","G1P_a0","GAP_n0","GAP_a0","DHAP_n0","DHAP_a0","BPG13_n0","BPG13_a0","NADH_a0","Pi_n0","Pi_a0","PG3_n0","PG3_a0","PG2_n0","PG2_a0","PEP_n0","PEP_a0","Pyr_n0","Pyr_a0",
    "Lac_b0","Lac_ecs0","Lac_a0","Lac_n0","NADPH_n0","NADPH_a0","GL6P_n0","GL6P_a0","GO6P_n0","GO6P_a0","RU5P_n0","RU5P_a0","R5P_n0","R5P_a0","X5P_n0","X5P_a0","S7P_n0","S7P_a0","E4P_n0","E4P_a0",
    "GSH_n0","GSH_a0","GSSG_n0","GSSG_a0",
    "Cr_n0","PCr_n0","Cr_a0","PCr_a0","cAMP_a0","NE_neuromod0","UDPgluco_a0","UTP_a0","GS_a0","GPa_a0","GPb_a0"];

###########################################
# HERE YOU CAN change ephys and bf stimulus onset and duration
# stimulus and bf activation
ti1 =  200.0
tf1 =  230.0 #220.0 # increased stim t for ephys and bf

global_par_t_0 = ti1
global_par_t_fin = tf1-ti1

tspanFin = tf1 + 80.

###########################################
# HERE YOU CAN choose:
age_cat = ["young","aged"][1]       #  age: 1=young, 2=old (reminder: enumeration in jl starts from 1)
ini_met = ["common","age_spec"][1]  # "common" is default and recommended for all sim (young and old)
nak_cat_or_full = ["cat","full"][1] # "cat" is default and recommended: aging Na/K ATPase catalytic, "full" is to also consider aging of non-catalytic subunits

################################
# ini metab conc common young and aged or age-spec:

if ini_met == "common"
    u0_ageSpec_fn = "u0_age_young.csv"
elseif ini_met == "age_spec"

    if age_cat == "young"
        u0_ageSpec_fn = "u0_age_young.csv"

    elseif age_cat == "aged"
        u0_ageSpec_fn = "u0_age_old.csv"
    end
end

println("For simulation: ",ini_met,"\t",age_cat,"\t",u0_ageSpec_fn)

newssfn = string(modeldirname,u0_ageSpec_fn)
u0_ssf = readdlm(newssfn, ',',Float64)
u0_ss = u0_ssf[1:size(u0_ssf)[1]]
u0_ss[129] = 0 # 1.0e-5
u0_ss[130] = 0 # 1.0e-5

cb_nonneg_idxs = @. [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92, 94,95,96,97, 99, 102, 113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176];

############################################
# ATTENTION, age-specific data here. Pay attention if you are simulating aged and want to overwrite those in your custom setup

if age_cat == "young"
    println(age_cat)

    C_Glc_a = 4.6
    u0_ss[115] = 4.555436497117541  # Glc_b
    C_Lac_a = 0.75
    u0_ss[149] = 0.6887631395085969   # Lac_b


    C_bHB_a = 0.3
    println("C_bHB_a ",C_bHB_a)
    u0_ss[42] = 0.2981203841045341  # bHB_b
    u0_ss[40] = 0.0028617229372728  # bHB_ecs

    NADtot_n = NADtot
    NADtot_a = NADtot

    NAD_aging_coeff_n = 1
    NAD_aging_coeff_a = 1

    NAD_aging_coeff_mn = 1
    NAD_aging_coeff_ma = 1

    NADHshuttle_aging_n = 1
    NADHshuttle_aging_a = 1

    syn_aging_coeff = 1

else
    println("AGED ",ageSpecSys_fn)

    C_Glc_a = 5.0
    u0_ss[115] = (C_Glc_a/4.6)*4.555436497117541   # Glc_b
    println("C_Glc_a ",C_Glc_a,"\t Glc_b ",u0_ss[115])

    C_Lac_a = (C_Glc_a/4.6)*0.75
    u0_ss[149] = (C_Glc_a/4.6)*0.6887631395085969   # Lac_b
    println("C_Lac_a ",C_Lac_a,"\t Lac_b ",u0_ss[149])

    C_bHB_a = 0.5*0.3
    println("C_bHB_a ",C_bHB_a)
    u0_ss[42] = 0.5*0.2981203841045341    # bHB_b
    u0_ss[40] = 0.5*0.0028617229372728  # bHB_ecs


    # NAD pool decline in aging https://doi.org/10.1016/j.cmet.2018.05.011 https://doi.org/10.1016/j.cels.2021.09.001
    # cyto
    NAD_aging_coeff_n = 0.65
    NAD_aging_coeff_a = 0.5
    # mito
    NAD_aging_coeff_mn = 0.65
    NAD_aging_coeff_ma = 0.5

    NADtot_n = NAD_aging_coeff_mn*0.000726
    NADtot_a = NAD_aging_coeff_ma*0.000726

    NADHshuttle_aging_n = 0.2
    NADHshuttle_aging_a = 0.2

    syn_aging_coeff = 0.5

    #####################
    # Na/K ATPase pump
    #####################

    if nak_cat_or_full == "cat"
        println(nak_cat_or_full)

        nakFCn = 0.657319693198261
        nakFCa = 1.0

        kPumpn = nakFCn * 2.2e-6
        kPumpg = nakFCa * 4.5e-7

    elseif nak_cat_or_full == "full"
        println(nak_cat_or_full," incl. effects of aging on non-catalytic subunits")

        nakFCn = 0.6105796343077594
        nakFCa = 0.8036492619959708

        kPumpn = nakFCn * 2.2e-6
        kPumpg = nakFCa * 4.5e-7

    end
end

###########################################
###########################################
###########################################


if default_or_custom_config == "custom"

    preset_for_custom = srun_idx

    extraTag = string(preset_for_custom,"_")


#     if preset_for_custom == "my_experiment"

         #  paramters and ini values you want to change
         #  u0_ss[idx] = ...
         #  param_1 = ..

#     end


    if preset_for_custom in ["g1_122_AcAcCoA_ini_dose1",
                             "g1_123_AcAcCoA_ini_dose2",
                             "g1_124_AcAcCoA_ini_dose3",
                             "g1_125_AcAcCoA_ini_dose4",
                             "g1_126_AcAcCoA_ini_dose5"]

        if preset_for_custom == "g1_122_AcAcCoA_ini_dose1"

            u0_ss[37] = 1.1*3.471725572540322e-5
            u0_ss[87] = 1.1*0.0006

        elseif preset_for_custom == "g1_123_AcAcCoA_ini_dose2"

            u0_ss[37] = 1.2*3.471725572540322e-5
            u0_ss[87] = 1.2*0.0006

        elseif preset_for_custom == "g1_124_AcAcCoA_ini_dose3"

            u0_ss[37] = 1.3*3.471725572540322e-5
            u0_ss[87] = 1.3*0.0006

        elseif preset_for_custom == "g1_125_AcAcCoA_ini_dose4"

            u0_ss[37] = 1.4*3.471725572540322e-5
            u0_ss[87] = 1.4*0.0006

        elseif preset_for_custom == "g1_126_AcAcCoA_ini_dose5"

            u0_ss[37] = 1.5*3.471725572540322e-5
            u0_ss[87] = 1.5*0.0006

        else
            println("ATTENTION, check preset_for_custom")
        end

    end

    if preset_for_custom in ["g1_127_AcCoAmito_na_ini_dose1",
                             "g1_128_AcCoAmito_na_ini_dose2",
                             "g1_129_AcCoAmito_na_ini_dose3",
                             "g1_130_AcCoAmito_na_ini_dose4",
                             "g1_131_AcCoAmito_na_ini_dose5",

        "152_AcCoAmito_na_ini_dose1","153_AcCoAmito_na_ini_dose2","154_AcCoAmito_na_ini_dose3","155_AcCoAmito_na_ini_dose4","156_AcCoAmito_na_ini_dose5",
        "th_177_AcCoAmito_na_ini_dose1","th_178_AcCoAmito_na_ini_dose2","th_179_AcCoAmito_na_ini_dose3","th_180_AcCoAmito_na_ini_dose4","th_181_AcCoAmito_na_ini_dose5"
        ]

        if preset_for_custom in ["g1_127_AcCoAmito_na_ini_dose1","152_AcCoAmito_na_ini_dose1","th_177_AcCoAmito_na_ini_dose1"]

            u0_ss[35] = 1.1*0.040486317761993
            u0_ss[85] = 1.1*0.0042886443294129

        elseif preset_for_custom in ["g1_128_AcCoAmito_na_ini_dose2","153_AcCoAmito_na_ini_dose2","th_178_AcCoAmito_na_ini_dose2"]

            u0_ss[35] = 1.2*0.040486317761993
            u0_ss[85] = 1.2*0.0042886443294129

        elseif preset_for_custom in ["g1_129_AcCoAmito_na_ini_dose3","154_AcCoAmito_na_ini_dose3","th_179_AcCoAmito_na_ini_dose3"]

            u0_ss[35] = 1.3*0.040486317761993
            u0_ss[85] = 1.3*0.0042886443294129

        elseif preset_for_custom in ["g1_130_AcCoAmito_na_ini_dose4","155_AcCoAmito_na_ini_dose4","th_180_AcCoAmito_na_ini_dose4"]

            u0_ss[35] = 1.4*0.040486317761993
            u0_ss[85] = 1.4*0.0042886443294129

        elseif preset_for_custom in ["g1_131_AcCoAmito_na_ini_dose5","156_AcCoAmito_na_ini_dose5","th_181_AcCoAmito_na_ini_dose5"]

            u0_ss[35] = 1.5*0.040486317761993
            u0_ss[85] = 1.5*0.0042886443294129

        else
            println("ATTENTION, check preset_for_custom")
        end

    end


    if preset_for_custom in ["g1_132_SUCCOAmito_na_ini_dose1",
                             "g1_133_SUCCOAmito_na_ini_dose2",
                             "g1_134_SUCCOAmito_na_ini_dose3",
                             "g1_135_SUCCOAmito_na_ini_dose4",
                             "g1_136_SUCCOAmito_na_ini_dose5",

        "157_SUCCOAmito_na_ini_dose1","158_SUCCOAmito_na_ini_dose2","159_SUCCOAmito_na_ini_dose3","160_SUCCOAmito_na_ini_dose4","161_SUCCOAmito_na_ini_dose5",
        "th_182_SUCCOAmito_na_ini_dose1","th_183_SUCCOAmito_na_ini_dose2","th_184_SUCCOAmito_na_ini_dose3","th_185_SUCCOAmito_na_ini_dose4","th_186_SUCCOAmito_na_ini_dose5"]

        if preset_for_custom in ["g1_132_SUCCOAmito_na_ini_dose1","157_SUCCOAmito_na_ini_dose1","th_182_SUCCOAmito_na_ini_dose1"]

            u0_ss[29] = 1.1*0.0027652024434962
            u0_ss[79] = 1.1*0.0016699868314113

        elseif preset_for_custom in ["g1_133_SUCCOAmito_na_ini_dose2","158_SUCCOAmito_na_ini_dose2","th_183_SUCCOAmito_na_ini_dose2"]

            u0_ss[29] = 1.2*0.0027652024434962
            u0_ss[79] = 1.2*0.0016699868314113

        elseif preset_for_custom in ["g1_134_SUCCOAmito_na_ini_dose3","159_SUCCOAmito_na_ini_dose3","th_184_SUCCOAmito_na_ini_dose3"]

            u0_ss[29] = 1.3*0.0027652024434962
            u0_ss[79] = 1.3*0.0016699868314113

        elseif preset_for_custom in ["g1_135_SUCCOAmito_na_ini_dose4","160_SUCCOAmito_na_ini_dose4","th_185_SUCCOAmito_na_ini_dose4"]

            u0_ss[29] = 1.4*0.0027652024434962
            u0_ss[79] = 1.4*0.0016699868314113

        elseif preset_for_custom in ["g1_136_SUCCOAmito_na_ini_dose5","161_SUCCOAmito_na_ini_dose5","th_186_SUCCOAmito_na_ini_dose5"]

            u0_ss[29] = 1.5*0.0027652024434962
            u0_ss[79] = 1.5*0.0016699868314113

        else
            println("ATTENTION, check preset_for_custom")
        end

    end



    if preset_for_custom in [ "1_blood_glc_ini","17_glclac_ini","18_glcbhb_ini","20_glclacbhb_ini",
                              "g1_21_blood_glc_ini","g1_37_glclac_ini","g1_38_glcbhb_ini","g1_40_glclacbhb_ini",
                              "g13_41_blood_glc_ini","g13_57_glclac_ini","g13_58_glcbhb_ini","g13_60_glclacbhb_ini",
                              "9_glc_pls","g1_29_glc_pls","g13_49_glc_pls",
                              "84_PCm_bloodglc","86_PDHdef_bloodglc",

            "g1_92_blood_glc_ini_dose1","g1_93_blood_glc_ini_dose2","g1_94_blood_glc_ini_dose3","g1_95_blood_glc_ini_dose4","g1_96_blood_glc_ini_dose5",
            "137_blood_glc_ini_dose1","138_blood_glc_ini_dose2","139_blood_glc_ini_dose3","140_blood_glc_ini_dose4","141_blood_glc_ini_dose5",
"th_162_blood_glc_ini_dose1","th_163_blood_glc_ini_dose2","th_164_blood_glc_ini_dose3","th_165_blood_glc_ini_dose4","th_166_blood_glc_ini_dose5"

                            ]

        if preset_for_custom in ["g1_92_blood_glc_ini_dose1","g1_93_blood_glc_ini_dose2","g1_94_blood_glc_ini_dose3","g1_95_blood_glc_ini_dose4","g1_96_blood_glc_ini_dose5",
            "137_blood_glc_ini_dose1","138_blood_glc_ini_dose2","139_blood_glc_ini_dose3","140_blood_glc_ini_dose4","141_blood_glc_ini_dose5",
"th_162_blood_glc_ini_dose1","th_163_blood_glc_ini_dose2","th_164_blood_glc_ini_dose3","th_165_blood_glc_ini_dose4","th_166_blood_glc_ini_dose5"]

            if preset_for_custom in ["g1_92_blood_glc_ini_dose1","137_blood_glc_ini_dose1","th_162_blood_glc_ini_dose1"]
                C_Glc_a_mod = [3.6, 5.6, 7.6, 9.6, 11.6][1]

            elseif preset_for_custom in ["g1_93_blood_glc_ini_dose2","138_blood_glc_ini_dose2","th_163_blood_glc_ini_dose2"]
                C_Glc_a_mod = [3.6, 5.6, 7.6, 9.6, 11.6][2]
            elseif preset_for_custom in ["g1_94_blood_glc_ini_dose3","139_blood_glc_ini_dose3","th_164_blood_glc_ini_dose3"]
                C_Glc_a_mod = [3.6, 5.6, 7.6, 9.6, 11.6][3]
            elseif preset_for_custom in ["g1_95_blood_glc_ini_dose4","140_blood_glc_ini_dose4","th_165_blood_glc_ini_dose4"]
                C_Glc_a_mod = [3.6, 5.6, 7.6, 9.6, 11.6][4]
            elseif preset_for_custom in ["g1_96_blood_glc_ini_dose5","141_blood_glc_ini_dose5","th_166_blood_glc_ini_dose5"]
                C_Glc_a_mod = [3.6, 5.6, 7.6, 9.6, 11.6][5]

            else
                println("CHECK preset_for_custom")
            end


        else
            C_Glc_a_mod = [1.6,2.6,3.6,4.6,5.6,6.6,7.6,8.6,9.6,10.6,11.6,12.6,13.6,14.6][6] # HERE YOU CAN CHOOSE CUSTOM
        end



        extraTag = string(preset_for_custom,"_",string(C_Glc_a_mod))


        if preset_for_custom in [ "1_blood_glc_ini","17_glclac_ini","18_glcbhb_ini","20_glclacbhb_ini",
                              "g1_21_blood_glc_ini","g1_37_glclac_ini","g1_38_glcbhb_ini","g1_40_glclacbhb_ini",
                              "g13_41_blood_glc_ini","g13_57_glclac_ini","g13_58_glcbhb_ini","g13_60_glclacbhb_ini",
                              "84_PCm_bloodglc","86_PDHdef_bloodglc",

                        "g1_92_blood_glc_ini_dose1","g1_93_blood_glc_ini_dose2","g1_94_blood_glc_ini_dose3","g1_95_blood_glc_ini_dose4","g1_96_blood_glc_ini_dose5",
                "137_blood_glc_ini_dose1","138_blood_glc_ini_dose2","139_blood_glc_ini_dose3","140_blood_glc_ini_dose4","141_blood_glc_ini_dose5",
"th_162_blood_glc_ini_dose1","th_163_blood_glc_ini_dose2","th_164_blood_glc_ini_dose3","th_165_blood_glc_ini_dose4","th_166_blood_glc_ini_dose5"

                            ]
            C_Glc_a = C_Glc_a_mod
            u0_ss[115] = (C_Glc_a/4.6)*4.555436497117541

        end

    end

    if preset_for_custom in [ "2_blood_lac_ini","17_glclac_ini","19_lacbhb_ini","20_glclacbhb_ini",
                              "g1_22_blood_lac_ini","g1_37_glclac_ini","g1_39_lacbhb_ini","g1_40_glclacbhb_ini",
                              "g13_42_blood_lac_ini","g13_57_glclac_ini","g13_59_lacbhb_ini","g13_60_glclacbhb_ini",
                              "10_lac_pls","g1_30_lac_pls","g13_50_lac_pls",
                              "g1_66_PCm_lac","g1_74_PDH_lac","87_PDHdef_bloodlac","g1_90_AcAcCoa_lac","g1_91_PDH_Lac_keto",

                        "g1_97_blood_lac_ini_dose1","g1_98_blood_lac_ini_dose2","g1_99_blood_lac_ini_dose3","g1_100_blood_lac_ini_dose4","g1_101_blood_lac_ini_dose5",
                        "g1_107_blood_lacbhb_ini_dose1", "g1_108_blood_lacbhb_ini_dose2", "g1_109_blood_lacbhb_ini_dose3", "g1_110_blood_lacbhb_ini_dose4", "g1_111_blood_lacbhb_ini_dose5",
            "g1_112_blood_lac_ini_dose6","g1_113_blood_lac_ini_dose7", "g1_114_blood_lac_ini_dose8", "g1_115_blood_lacbhb_ini_dose6","g1_116_blood_lacbhb_ini_dose7","g1_117_blood_lacbhb_ini_dose8",
            "g1_118_keto_lac_nad","g1_119_keto_lac_nad_Qtot_n", "g1_120_keto_lac_nad_Qtot_na",

     "142_blood_lac_ini_dose1","143_blood_lac_ini_dose2","144_blood_lac_ini_dose3","145_blood_lac_ini_dose4","146_blood_lac_ini_dose5",       "th_162_blood_glc_ini_dose1","th_163_blood_glc_ini_dose2","th_164_blood_glc_ini_dose3","th_165_blood_glc_ini_dose4","th_166_blood_glc_ini_dose5","th_167_blood_lac_ini_dose1","th_168_blood_lac_ini_dose2","th_169_blood_lac_ini_dose3","th_170_blood_lac_ini_dose4","th_171_blood_lac_ini_dose5","th_172_blood_bhb_ini_dose1","th_173_blood_bhb_ini_dose2","th_174_blood_bhb_ini_dose3","th_175_blood_bhb_ini_dose4","th_176_blood_bhb_ini_dose5","th_177_AcCoAmito_na_ini_dose1","th_178_AcCoAmito_na_ini_dose2","th_179_AcCoAmito_na_ini_dose3","th_180_AcCoAmito_na_ini_dose4","th_181_AcCoAmito_na_ini_dose5","th_182_SUCCOAmito_na_ini_dose1","th_183_SUCCOAmito_na_ini_dose2","th_184_SUCCOAmito_na_ini_dose3","th_185_SUCCOAmito_na_ini_dose4","th_186_SUCCOAmito_na_ini_dose5"

                            ]


        if preset_for_custom in ["g1_97_blood_lac_ini_dose1","g1_98_blood_lac_ini_dose2","g1_99_blood_lac_ini_dose3","g1_100_blood_lac_ini_dose4","g1_101_blood_lac_ini_dose5",
"g1_107_blood_lacbhb_ini_dose1", "g1_108_blood_lacbhb_ini_dose2", "g1_109_blood_lacbhb_ini_dose3", "g1_110_blood_lacbhb_ini_dose4", "g1_111_blood_lacbhb_ini_dose5",
            "g1_112_blood_lac_ini_dose6","g1_113_blood_lac_ini_dose7", "g1_114_blood_lac_ini_dose8", "g1_115_blood_lacbhb_ini_dose6","g1_116_blood_lacbhb_ini_dose7","g1_117_blood_lacbhb_ini_dose8",


"142_blood_lac_ini_dose1","143_blood_lac_ini_dose2","144_blood_lac_ini_dose3","145_blood_lac_ini_dose4","146_blood_lac_ini_dose5",
"th_167_blood_lac_ini_dose1","th_168_blood_lac_ini_dose2","th_169_blood_lac_ini_dose3","th_170_blood_lac_ini_dose4","th_171_blood_lac_ini_dose5"

            ]

            if preset_for_custom in ["g1_97_blood_lac_ini_dose1","g1_107_blood_lacbhb_ini_dose1","142_blood_lac_ini_dose1","th_167_blood_lac_ini_dose1"]
                C_Lac_a_mod = [0.5,1.0,1.5,1.75,2.25][1]
            elseif preset_for_custom in ["g1_98_blood_lac_ini_dose2","g1_108_blood_lacbhb_ini_dose2","143_blood_lac_ini_dose2","th_168_blood_lac_ini_dose2"]
                C_Lac_a_mod = [0.5,1.0,1.5,1.75,2.25][2]
            elseif preset_for_custom in ["g1_99_blood_lac_ini_dose3","g1_109_blood_lacbhb_ini_dose3","144_blood_lac_ini_dose3","th_169_blood_lac_ini_dose3"]
                C_Lac_a_mod = [0.5,1.0,1.5,1.75,2.25][3]
            elseif preset_for_custom in ["g1_100_blood_lac_ini_dose4","g1_110_blood_lacbhb_ini_dose4","145_blood_lac_ini_dose4","th_170_blood_lac_ini_dose4"]
                C_Lac_a_mod = [0.5,1.0,1.5,1.75,2.25][4]
            elseif preset_for_custom in ["g1_101_blood_lac_ini_dose5","g1_111_blood_lacbhb_ini_dose5","146_blood_lac_ini_dose5","th_171_blood_lac_ini_dose5"]
                C_Lac_a_mod = [0.5,1.0,1.5,1.75,2.25][5]


            elseif preset_for_custom in [  "g1_112_blood_lac_ini_dose6","g1_115_blood_lacbhb_ini_dose6"]
                C_Lac_a_mod = [0.5,1.5,3.0,6.0,9.0,1.125,1.25,2.125][6]
            elseif preset_for_custom in [ "g1_113_blood_lac_ini_dose7","g1_116_blood_lacbhb_ini_dose7"]
                C_Lac_a_mod = [0.5,1.5,3.0,6.0,9.0,1.125,1.25,2.125][7]
            elseif preset_for_custom in [ "g1_114_blood_lac_ini_dose8", "g1_117_blood_lacbhb_ini_dose8"]
                C_Lac_a_mod = [0.5,1.5,3.0,6.0,9.0,1.125,1.25,2.125][8]

            else
                println("CHECK preset_for_custom")
            end

        else
            C_Lac_a_mod = [0.25,0.75,1.0,1.5,2.0,3.0,4.0,5.0, 2.5,2.25][5] # HERE YOU CAN CHOOSE CUSTOM
        end

        extraTag = string(preset_for_custom,"_",string(C_Lac_a_mod))


        if preset_for_custom in [ "2_blood_lac_ini","17_glclac_ini","19_lacbhb_ini","20_glclacbhb_ini",
                              "g1_22_blood_lac_ini","g1_37_glclac_ini","g1_39_lacbhb_ini","g1_40_glclacbhb_ini",
                              "g13_42_blood_lac_ini","g13_57_glclac_ini","g13_59_lacbhb_ini","g13_60_glclacbhb_ini",
                              "g1_66_PCm_lac","g1_74_PDH_lac","87_PDHdef_bloodlac","g1_90_AcAcCoa_lac","g1_91_PDH_Lac_keto",

                        "g1_97_blood_lac_ini_dose1","g1_98_blood_lac_ini_dose2","g1_99_blood_lac_ini_dose3","g1_100_blood_lac_ini_dose4","g1_101_blood_lac_ini_dose5",
                        "g1_107_blood_lacbhb_ini_dose1", "g1_108_blood_lacbhb_ini_dose2", "g1_109_blood_lacbhb_ini_dose3", "g1_110_blood_lacbhb_ini_dose4", "g1_111_blood_lacbhb_ini_dose5",
                "g1_112_blood_lac_ini_dose6","g1_113_blood_lac_ini_dose7", "g1_114_blood_lac_ini_dose8", "g1_115_blood_lacbhb_ini_dose6","g1_116_blood_lacbhb_ini_dose7","g1_117_blood_lacbhb_ini_dose8",
                "g1_118_keto_lac_nad","g1_119_keto_lac_nad_Qtot_n", "g1_120_keto_lac_nad_Qtot_na",

    "142_blood_lac_ini_dose1","143_blood_lac_ini_dose2","144_blood_lac_ini_dose3","145_blood_lac_ini_dose4","146_blood_lac_ini_dose5",            "th_162_blood_glc_ini_dose1","th_163_blood_glc_ini_dose2","th_164_blood_glc_ini_dose3","th_165_blood_glc_ini_dose4","th_166_blood_glc_ini_dose5","th_167_blood_lac_ini_dose1","th_168_blood_lac_ini_dose2","th_169_blood_lac_ini_dose3","th_170_blood_lac_ini_dose4","th_171_blood_lac_ini_dose5","th_172_blood_bhb_ini_dose1","th_173_blood_bhb_ini_dose2","th_174_blood_bhb_ini_dose3","th_175_blood_bhb_ini_dose4","th_176_blood_bhb_ini_dose5","th_177_AcCoAmito_na_ini_dose1","th_178_AcCoAmito_na_ini_dose2","th_179_AcCoAmito_na_ini_dose3","th_180_AcCoAmito_na_ini_dose4","th_181_AcCoAmito_na_ini_dose5","th_182_SUCCOAmito_na_ini_dose1","th_183_SUCCOAmito_na_ini_dose2","th_184_SUCCOAmito_na_ini_dose3","th_185_SUCCOAmito_na_ini_dose4","th_186_SUCCOAmito_na_ini_dose5"
                            ]
            C_Lac_a = C_Lac_a_mod
            u0_ss[149] = (C_Lac_a/0.75)*0.6887631395085969  # 0.6887631395085969 # Lac_b

        end

    end

    if preset_for_custom in [ "3_blood_bhb_ini","18_glcbhb_ini","19_lacbhb_ini","20_glclacbhb_ini",
                              "g1_23_blood_bhb_ini","g1_38_glcbhb_ini","g1_39_lacbhb_ini","g1_40_glclacbhb_ini",
                              "g13_43_blood_bhb_ini","g13_58_glcbhb_ini","g13_59_lacbhb_ini","g13_60_glclacbhb_ini",
                              "11_bhb_pls","g1_31_bhb_pls","g13_51_bhb_pls",
                              "g1_65_PCm_keto","g1_71_LDH_keto","g1_73_PDH_keto","g13_78_LDH_keto",
                              "g13_80_PDH_keto","g1_91_PDH_Lac_keto",

        "g1_102_blood_bhb_ini_dose1","g1_103_blood_bhb_ini_dose2","g1_104_blood_bhb_ini_dose3","g1_105_blood_bhb_ini_dose4","g1_106_blood_bhb_ini_dose5",
       "g1_107_blood_lacbhb_ini_dose1","g1_108_blood_lacbhb_ini_dose2","g1_109_blood_lacbhb_ini_dose3","g1_110_blood_lacbhb_ini_dose4","g1_111_blood_lacbhb_ini_dose5",
            "g1_115_blood_lacbhb_ini_dose6","g1_116_blood_lacbhb_ini_dose7","g1_117_blood_lacbhb_ini_dose8",
            "g1_118_keto_lac_nad","g1_119_keto_lac_nad_Qtot_n", "g1_120_keto_lac_nad_Qtot_na",


 "147_blood_bhb_ini_dose1","148_blood_bhb_ini_dose2","149_blood_bhb_ini_dose3","150_blood_bhb_ini_dose4","151_blood_bhb_ini_dose5",
            "th_162_blood_glc_ini_dose1","th_163_blood_glc_ini_dose2","th_164_blood_glc_ini_dose3","th_165_blood_glc_ini_dose4","th_166_blood_glc_ini_dose5","th_167_blood_lac_ini_dose1","th_168_blood_lac_ini_dose2","th_169_blood_lac_ini_dose3","th_170_blood_lac_ini_dose4","th_171_blood_lac_ini_dose5","th_172_blood_bhb_ini_dose1","th_173_blood_bhb_ini_dose2","th_174_blood_bhb_ini_dose3","th_175_blood_bhb_ini_dose4","th_176_blood_bhb_ini_dose5","th_177_AcCoAmito_na_ini_dose1","th_178_AcCoAmito_na_ini_dose2","th_179_AcCoAmito_na_ini_dose3","th_180_AcCoAmito_na_ini_dose4","th_181_AcCoAmito_na_ini_dose5","th_182_SUCCOAmito_na_ini_dose1","th_183_SUCCOAmito_na_ini_dose2","th_184_SUCCOAmito_na_ini_dose3","th_185_SUCCOAmito_na_ini_dose4","th_186_SUCCOAmito_na_ini_dose5"
        ]

        if preset_for_custom in ["g1_102_blood_bhb_ini_dose1","g1_103_blood_bhb_ini_dose2","g1_104_blood_bhb_ini_dose3","g1_105_blood_bhb_ini_dose4","g1_106_blood_bhb_ini_dose5",
       "g1_107_blood_lacbhb_ini_dose1","g1_108_blood_lacbhb_ini_dose2","g1_109_blood_lacbhb_ini_dose3","g1_110_blood_lacbhb_ini_dose4","g1_111_blood_lacbhb_ini_dose5",
            "g1_115_blood_lacbhb_ini_dose6","g1_116_blood_lacbhb_ini_dose7","g1_117_blood_lacbhb_ini_dose8",

        "147_blood_bhb_ini_dose1","148_blood_bhb_ini_dose2","149_blood_bhb_ini_dose3","150_blood_bhb_ini_dose4","151_blood_bhb_ini_dose5",
"th_172_blood_bhb_ini_dose1","th_173_blood_bhb_ini_dose2","th_174_blood_bhb_ini_dose3","th_175_blood_bhb_ini_dose4","th_176_blood_bhb_ini_dose5"

            ]

            if preset_for_custom in ["g1_102_blood_bhb_ini_dose1","g1_107_blood_lacbhb_ini_dose1","147_blood_bhb_ini_dose1","th_172_blood_bhb_ini_dose1"]
                C_bHB_a_mod = [0.5, 1.0, 2.0, 4.0, 8.0][1]
            elseif preset_for_custom in ["g1_103_blood_bhb_ini_dose2","g1_108_blood_lacbhb_ini_dose2","148_blood_bhb_ini_dose2","th_173_blood_bhb_ini_dose2"]
                C_bHB_a_mod = [0.5, 1.0, 2.0, 4.0, 8.0][2]
            elseif preset_for_custom in ["g1_104_blood_bhb_ini_dose3","g1_109_blood_lacbhb_ini_dose3","g1_115_blood_lacbhb_ini_dose6","149_blood_bhb_ini_dose3","th_174_blood_bhb_ini_dose3"]
                C_bHB_a_mod = [0.5, 1.0, 2.0, 4.0, 8.0][3]
            elseif preset_for_custom in ["g1_105_blood_bhb_ini_dose4","g1_110_blood_lacbhb_ini_dose4","g1_116_blood_lacbhb_ini_dose7","150_blood_bhb_ini_dose4","th_175_blood_bhb_ini_dose4"]
                C_bHB_a_mod = [0.5, 1.0, 2.0, 4.0, 8.0][4]
            elseif preset_for_custom in ["g1_106_blood_bhb_ini_dose5","g1_111_blood_lacbhb_ini_dose5","g1_117_blood_lacbhb_ini_dose8","151_blood_bhb_ini_dose5","th_176_blood_bhb_ini_dose5"]
                C_bHB_a_mod = [0.5, 1.0, 2.0, 4.0, 8.0][5]
            else
                println("CHECK preset_for_custom")
            end

        else
            #For ref: "A well-formulated ketogenic diet maintains blood BHB levels ~ 0.5–3 mM" https://link.springer.com/article/10.1007/s11357-020-00277-y
            C_bHB_a_mod = [0.3, 1.3, 2.3, 3.3][4]
        end


        extraTag = string(preset_for_custom,"_",string(C_bHB_a_mod))

        if preset_for_custom in [ "3_blood_bhb_ini","18_glcbhb_ini","19_lacbhb_ini","20_glclacbhb_ini",
                              "g1_23_blood_bhb_ini","g1_38_glcbhb_ini","g1_39_lacbhb_ini","g1_40_glclacbhb_ini",
                              "g13_43_blood_bhb_ini","g13_58_glcbhb_ini","g13_59_lacbhb_ini","g13_60_glclacbhb_ini",
                              "g1_65_PCm_keto","g1_71_LDH_keto","g1_73_PDH_keto","g13_78_LDH_keto",
                              "g13_80_PDH_keto","g1_91_PDH_Lac_keto",

        "g1_102_blood_bhb_ini_dose1","g1_103_blood_bhb_ini_dose2","g1_104_blood_bhb_ini_dose3","g1_105_blood_bhb_ini_dose4","g1_106_blood_bhb_ini_dose5",
       "g1_107_blood_lacbhb_ini_dose1","g1_108_blood_lacbhb_ini_dose2","g1_109_blood_lacbhb_ini_dose3","g1_110_blood_lacbhb_ini_dose4","g1_111_blood_lacbhb_ini_dose5",
                "g1_115_blood_lacbhb_ini_dose6","g1_116_blood_lacbhb_ini_dose7","g1_117_blood_lacbhb_ini_dose8",
                "g1_118_keto_lac_nad","g1_119_keto_lac_nad_Qtot_n", "g1_120_keto_lac_nad_Qtot_na",

        "147_blood_bhb_ini_dose1","148_blood_bhb_ini_dose2","149_blood_bhb_ini_dose3","150_blood_bhb_ini_dose4","151_blood_bhb_ini_dose5",
                "th_162_blood_glc_ini_dose1","th_163_blood_glc_ini_dose2","th_164_blood_glc_ini_dose3","th_165_blood_glc_ini_dose4","th_166_blood_glc_ini_dose5","th_167_blood_lac_ini_dose1","th_168_blood_lac_ini_dose2","th_169_blood_lac_ini_dose3","th_170_blood_lac_ini_dose4","th_171_blood_lac_ini_dose5","th_172_blood_bhb_ini_dose1","th_173_blood_bhb_ini_dose2","th_174_blood_bhb_ini_dose3","th_175_blood_bhb_ini_dose4","th_176_blood_bhb_ini_dose5","th_177_AcCoAmito_na_ini_dose1","th_178_AcCoAmito_na_ini_dose2","th_179_AcCoAmito_na_ini_dose3","th_180_AcCoAmito_na_ini_dose4","th_181_AcCoAmito_na_ini_dose5","th_182_SUCCOAmito_na_ini_dose1","th_183_SUCCOAmito_na_ini_dose2","th_184_SUCCOAmito_na_ini_dose3","th_185_SUCCOAmito_na_ini_dose4","th_186_SUCCOAmito_na_ini_dose5"
        ]

            C_bHB_a = C_bHB_a_mod

            u0_ss[42] = (C_bHB_a/0.3)*0.2981203841045341 # default control: 0.2981203841045341  # bHB_b
            u0_ss[41] = (C_bHB_a/0.3)*0.002235 # default control: 0.002235 # bHB_a
            u0_ss[40] = (C_bHB_a/0.3)*0.0028617229372728 # default control: 0.0028617229372728 # bHB_ecs

        end

    end


    if preset_for_custom in ["4_aKG_ini","g1_24_aKG_ini","g13_44_aKG_ini"]

        u0_ss[31] = 3.0*0.0730279198447203 # default: 0.0730279198447203 # 31	AKGmito_n
        u0_ss[48] = 3.0*0.2 # default: 0.2 # 48	AKG_n
        u0_ss[81] = 3.0*0.0151591579926322 # default: 0.0151591579926322 # 81	AKGmito_a

        extraTag = string(preset_for_custom,"_",string(u0_ss[31]))

    end

    if preset_for_custom in ["5_succoa_ini","g1_25_succoa_ini","g13_45_succoa_ini"]
        u0_ss[29] = 3.0*0.0027652024434962
        u0_ss[79] = 3.0*0.0016699868314113

        extraTag = string(preset_for_custom,"_",string(u0_ss[29]))
    end

    if preset_for_custom in ["6_fum_ini","g1_26_fum_ini","g13_46_fum_ini"]
        u0_ss[25] = 3.0*0.0703303834778912
        u0_ss[75] = 3.0*0.0500591772559637

        extraTag = string(preset_for_custom,"_",string(u0_ss[25]))
    end

    if preset_for_custom in ["7_mal_ini","g1_27_mal_ini","g13_47_mal_ini"]
        u0_ss[26] = 3.0*0.3877284278881228
        u0_ss[46] = 3.0*0.45
        u0_ss[76] = 3.0*0.2552499695609829

        extraTag = string(preset_for_custom,"_",string(u0_ss[26]))
    end

    if preset_for_custom in ["8_oxa_ini","g1_28_oxa_ini","g13_48_oxa_ini"]
        u0_ss[27] = 3.0*0.0113308326310003
        u0_ss[47] = 3.0*0.01
        u0_ss[77] = 3.0*0.0044682268709836

        extraTag = string(preset_for_custom,"_",string(u0_ss[27]))
    end




    if preset_for_custom in [ "g1_21_blood_glc_ini", "g1_22_blood_lac_ini", "g1_23_blood_bhb_ini",
                              "g1_24_aKG_ini", "g1_25_succoa_ini", "g1_26_fum_ini", "g1_27_mal_ini", "g1_28_oxa_ini",
                              "g1_29_glc_pls", "g1_30_lac_pls", "g1_31_bhb_pls",
                              "g1_32_akg_pls", "g1_33_succoa_pls","g1_34_fum_pls", "g1_35_mal_pls", "g1_36_oxa_pls",
                              "g1_37_glclac_ini", "g1_38_glcbhb_ini","g1_39_lacbhb_ini","g1_40_glclacbhb_ini",
                              "g1_61_def",
                                  "g13_41_blood_glc_ini", "g13_42_blood_lac_ini", "g13_43_blood_bhb_ini",
                                  "g13_44_aKG_ini", "g13_45_succoa_ini", "g13_46_fum_ini", "g13_47_mal_ini","g13_48_oxa_ini",
                                  "g13_49_glc_pls", "g13_50_lac_pls", "g13_51_bhb_pls",
                                  "g13_52_akg_pls", "g13_53_succoa_pls", "g13_54_fum_pls", "g13_55_mal_pls", "g13_56_oxa_pls",
                                  "g13_57_glclac_ini", "g13_58_glcbhb_ini", "g13_59_lacbhb_ini", "g13_60_glclacbhb_ini",
                                  "g13_62_def",

                              "g1_65_PCm_keto","g1_66_PCm_lac","g1_67_PCm","g1_68_AcAcCoA",
                              "g1_69_Acon","g1_70_ISOCIT","g1_71_LDH_keto","g1_72_LDH",
                              "g1_73_PDH_keto","g1_74_PDH_lac","g1_75_PDH","g1_76_SUCmito",
                              "g13_77_AcAcCoA","g13_78_LDH_keto","g13_79_LDH",
                              "g13_80_PDH_keto","g13_81_PDH","g1_90_AcAcCoa_lac","g1_91_PDH_Lac_keto",

                    "g1_92_blood_glc_ini_dose1", "g1_93_blood_glc_ini_dose2", "g1_94_blood_glc_ini_dose3", "g1_95_blood_glc_ini_dose4","g1_96_blood_glc_ini_dose5",

                    "g1_97_blood_lac_ini_dose1", "g1_98_blood_lac_ini_dose2", "g1_99_blood_lac_ini_dose3", "g1_100_blood_lac_ini_dose4", "g1_101_blood_lac_ini_dose5",

                    "g1_102_blood_bhb_ini_dose1", "g1_103_blood_bhb_ini_dose2", "g1_104_blood_bhb_ini_dose3", "g1_105_blood_bhb_ini_dose4","g1_106_blood_bhb_ini_dose5",

                    "g1_107_blood_lacbhb_ini_dose1", "g1_108_blood_lacbhb_ini_dose2","g1_109_blood_lacbhb_ini_dose3","g1_110_blood_lacbhb_ini_dose4", "g1_111_blood_lacbhb_ini_dose5",

             "g1_112_blood_lac_ini_dose6",
    "g1_113_blood_lac_ini_dose7",
    "g1_114_blood_lac_ini_dose8",
    "g1_115_blood_lacbhb_ini_dose6",
    "g1_116_blood_lacbhb_ini_dose7",
    "g1_117_blood_lacbhb_ini_dose8",

            "g1_118_keto_lac_nad","g1_119_keto_lac_nad_Qtot_n", "g1_120_keto_lac_nad_Qtot_na",

     "g1_122_AcAcCoA_ini_dose1",
     "g1_123_AcAcCoA_ini_dose2",
     "g1_124_AcAcCoA_ini_dose3",
     "g1_125_AcAcCoA_ini_dose4",
     "g1_126_AcAcCoA_ini_dose5",

     "g1_127_AcCoAmito_na_ini_dose1",
     "g1_128_AcCoAmito_na_ini_dose2",
     "g1_129_AcCoAmito_na_ini_dose3",
     "g1_130_AcCoAmito_na_ini_dose4",
     "g1_131_AcCoAmito_na_ini_dose5",

     "g1_132_SUCCOAmito_na_ini_dose1",
     "g1_133_SUCCOAmito_na_ini_dose2",
     "g1_134_SUCCOAmito_na_ini_dose3",
     "g1_135_SUCCOAmito_na_ini_dose4",
     "g1_136_SUCCOAmito_na_ini_dose5",

            "th_162_blood_glc_ini_dose1","th_163_blood_glc_ini_dose2","th_164_blood_glc_ini_dose3","th_165_blood_glc_ini_dose4","th_166_blood_glc_ini_dose5","th_167_blood_lac_ini_dose1","th_168_blood_lac_ini_dose2","th_169_blood_lac_ini_dose3","th_170_blood_lac_ini_dose4","th_171_blood_lac_ini_dose5","th_172_blood_bhb_ini_dose1","th_173_blood_bhb_ini_dose2","th_174_blood_bhb_ini_dose3","th_175_blood_bhb_ini_dose4","th_176_blood_bhb_ini_dose5","th_177_AcCoAmito_na_ini_dose1","th_178_AcCoAmito_na_ini_dose2","th_179_AcCoAmito_na_ini_dose3","th_180_AcCoAmito_na_ini_dose4","th_181_AcCoAmito_na_ini_dose5","th_182_SUCCOAmito_na_ini_dose1","th_183_SUCCOAmito_na_ini_dose2","th_184_SUCCOAmito_na_ini_dose3","th_185_SUCCOAmito_na_ini_dose4","th_186_SUCCOAmito_na_ini_dose5",

            "th_187_ATP_dose1","th_188_ATP_dose2","th_189_ATP_dose3","th_190_ATP_dose4","th_191_ATP_dose5"

                            ]

        # HERE YOU CAN CHOOSE CUSTOM


        # For approx how conc are diff in GLUT1 from control: GLUT1-DS is diagnosed when glucose concentrations in the cerebrospinal fluid are lower than 40 mg/dl. The cerebrospinal fluid glucose/blood glucose concentration ratios in GLUT1-DS patients are about 0.45 (normal ratio: 0.65 ± 0.01). [https://www.sciencedirect.com/topics/biochemistry-genetics-and-molecular-biology/glut1#:~:text=GLUT1%2DDS%20is%20diagnosed%20when,feeding%20patients%20a%20ketogenic%20diet.]


        # Standard reference texts cite the normal CSF glucose level as 2.5–4.4 mmol/L [PMID: 37181574]


        u0_ss[116] = 1.4036921120261527 # Glc_t_t  # import is almost unaffected
        u0_ss[117] = 0.69*1.302331013714969 # Glc_ecsBA # 0.45/0.65 ~ 0.69

        u0_ss[118] = 0.69*1.2215129412034005 # Glc_a # import is almost unaffected, but Glc_ecsBA is already affected by export from Glc_t_t
        u0_ss[119] = 0.69*0.69*1.0034276408975709 # Glc_ecsAN  # 0.69**2 because GLC-export from endothelium and GLC-export from astrocyte are both affected


        # Kinetics of GLUT1:
        # Under zero-trans influx conditions, the T295M Vmax (590 pmol/min/oocyte) was 79% of the WT value and the Km (14.3 mM) was increased compared with WT (9.6 mM).
        # Under zero-trans efflux conditions, both the Vmax (1216 pmol/min/oocyte) and Km (8.8 mM) in T295M mutant Glut1 were markedly decreased in comparison to the WT values (7443 pmol/min/oocyte and 90.8 mM).
        # [ https://www.nature.com/articles/pr2008239]

        # blood -> endoth # influx
        TmaxGLCce = 0.79*2.21  #default control: 2.21

        # endoth -> ecsBA # efflux
        TmaxGLCeb = 0.16*20.0 #default control: 20.0

        # ecsBA -> a # influx
        TmaxGLCba = 0.79*8.0 #default control: 8.0

        # a -> ecsAN # efflux
        TmaxGLCai = 0.16*0.032  #GLUT1


        KeG =  (14.3/9.6)*10.3 # influx
        KeG2 = (8.8/90.8)*12.5 # efflux
        KeG3 = (14.3/9.6)*8.0 # influx
        KeG4 = (8.8/90.8)*8.0 # efflux

        # low to low-normal CSF Lac: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7469861/
        u0_ss[150] = 0.9*0.6223377821910432 # Lac_ecs


        # reduced glycogen: DOI: 10.1126/scitranslmed.abn2956 (significantly decreased total brain glycogen concentration (control, 1.44 ± 0.3 mol glycogen/g tissue, n = 4; G1D, 0.65 ± 0.2 mol glycogen/g tissue, n = 4; P = 0.008).)

        u0_ss[128] = (0.65/1.44)*13.99969995417289


        extraTag = string(preset_for_custom,"_",string(TmaxGLCce),"_",string(TmaxGLCeb),"_",string(TmaxGLCba),"_",string(TmaxGLCai))

        if preset_for_custom in [ "g13_41_blood_glc_ini", "g13_42_blood_lac_ini", "g13_43_blood_bhb_ini",
                                  "g13_44_aKG_ini", "g13_45_succoa_ini", "g13_46_fum_ini", "g13_47_mal_ini","g13_48_oxa_ini",
                                  "g13_49_glc_pls", "g13_50_lac_pls", "g13_51_bhb_pls",
                                  "g13_52_akg_pls", "g13_53_succoa_pls", "g13_54_fum_pls", "g13_55_mal_pls", "g13_56_oxa_pls",
                                  "g13_57_glclac_ini", "g13_58_glcbhb_ini", "g13_59_lacbhb_ini", "g13_60_glclacbhb_ini",
                                  "g13_62_def",
                                  "g13_77_AcAcCoA","g13_78_LDH_keto","g13_79_LDH",
                                  "g13_80_PDH_keto","g13_81_PDH"
                            ]

            TmaxGLCin = 0.79*0.4    #GLUT3

            extraTag = string(preset_for_custom,"_",string(TmaxGLCce),"_",string(TmaxGLCeb),"_",string(TmaxGLCba),"_",string(TmaxGLCai),"_",string(TmaxGLCin))

        end
    end


    if preset_for_custom in ["63_AcAcCoA_ini","g1_68_AcAcCoA","g13_77_AcAcCoA","g1_90_AcAcCoa_lac"]

        u0_ss[37] = 3.0*3.471725572540322e-5 # AcAcCoA_n
        u0_ss[87] = 3.0*0.0006 # AcAcCoA_a

    end

    if preset_for_custom in ["64_Acon","g1_69_Acon"]
        VmaxAco_n = 0.5*25.611147830094392
        VmaxAco_a = 0.5*9.438075110105698
    end

    if preset_for_custom in ["g1_65_PCm_keto","g1_66_PCm_lac","g1_67_PCm","84_PCm_bloodglc","85_PCm"]
        VmPYRCARB_a =  3.0*0.00755985436706299  # this change affects both n and a, because the parameter is shared
    end

    if preset_for_custom in ["g1_70_ISOCIT","82_ISOCIT"]

        u0_ss[33] = 3.0*0.0331278125743512 # 3.0 is a scaling factor consistent with other conditions
        u0_ss[83] = 3.0*0.0360692382798456 # 3.0 is a scaling factor consistent with other conditions

    end

    if preset_for_custom in ["g1_71_LDH_keto","g1_72_LDH","g13_78_LDH_keto","g13_79_LDH","83_LDH"]

        VmfLDH_a = 0.5*8.74949881831907
        VmfLDH_n = 0.5*241.739831262545 # 0.2 is a scaling factor consistent with other conditions

    end

    if preset_for_custom in ["g1_73_PDH_keto","g1_74_PDH_lac","g1_75_PDH",
                             "g13_80_PDH_keto","g13_81_PDH","86_PDHdef_bloodglc","87_PDHdef_bloodlac","88_PDHdef","g1_91_PDH_Lac_keto"]

        VmaxPDHCmito_n = 0.5*2.67222326259307
        VmaxPDHCmito_a = 0.5*2.79810789599674

    end

    if preset_for_custom in ["g1_76_SUCmito","89_SUCmito"]

        u0_ss[28] =  3.0*0.3913984292428137
        u0_ss[78] =  3.0*0.5865999694835419

    end





    if preset_for_custom in ["g1_118_keto_lac_nad","g1_119_keto_lac_nad_Qtot_n", "g1_120_keto_lac_nad_Qtot_na", "th_162_blood_glc_ini_dose1","th_163_blood_glc_ini_dose2","th_164_blood_glc_ini_dose3","th_165_blood_glc_ini_dose4","th_166_blood_glc_ini_dose5","th_167_blood_lac_ini_dose1","th_168_blood_lac_ini_dose2","th_169_blood_lac_ini_dose3","th_170_blood_lac_ini_dose4","th_171_blood_lac_ini_dose5","th_172_blood_bhb_ini_dose1","th_173_blood_bhb_ini_dose2","th_174_blood_bhb_ini_dose3","th_175_blood_bhb_ini_dose4","th_176_blood_bhb_ini_dose5","th_177_AcCoAmito_na_ini_dose1","th_178_AcCoAmito_na_ini_dose2","th_179_AcCoAmito_na_ini_dose3","th_180_AcCoAmito_na_ini_dose4","th_181_AcCoAmito_na_ini_dose5","th_182_SUCCOAmito_na_ini_dose1","th_183_SUCCOAmito_na_ini_dose2","th_184_SUCCOAmito_na_ini_dose3","th_185_SUCCOAmito_na_ini_dose4","th_186_SUCCOAmito_na_ini_dose5"]

        NADtot = 1.1*0.000726 # mito n,a
        NADtot_n = 1.1*0.000726 # mito n
        NADtot_a = 1.1*0.000726 # mito a


    end

    if preset_for_custom in ["g1_119_keto_lac_nad_Qtot_n", "g1_120_keto_lac_nad_Qtot_na", "th_162_blood_glc_ini_dose1","th_163_blood_glc_ini_dose2","th_164_blood_glc_ini_dose3","th_165_blood_glc_ini_dose4","th_166_blood_glc_ini_dose5","th_167_blood_lac_ini_dose1","th_168_blood_lac_ini_dose2","th_169_blood_lac_ini_dose3","th_170_blood_lac_ini_dose4","th_171_blood_lac_ini_dose5","th_172_blood_bhb_ini_dose1","th_173_blood_bhb_ini_dose2","th_174_blood_bhb_ini_dose3","th_175_blood_bhb_ini_dose4","th_176_blood_bhb_ini_dose5","th_177_AcCoAmito_na_ini_dose1","th_178_AcCoAmito_na_ini_dose2","th_179_AcCoAmito_na_ini_dose3","th_180_AcCoAmito_na_ini_dose4","th_181_AcCoAmito_na_ini_dose5","th_182_SUCCOAmito_na_ini_dose1","th_183_SUCCOAmito_na_ini_dose2","th_184_SUCCOAmito_na_ini_dose3","th_185_SUCCOAmito_na_ini_dose4","th_186_SUCCOAmito_na_ini_dose5"]

        u0_ss[21] = 1.1*1.35

        if preset_for_custom in ["g1_120_keto_lac_nad_Qtot_na", "th_162_blood_glc_ini_dose1","th_163_blood_glc_ini_dose2","th_164_blood_glc_ini_dose3","th_165_blood_glc_ini_dose4","th_166_blood_glc_ini_dose5","th_167_blood_lac_ini_dose1","th_168_blood_lac_ini_dose2","th_169_blood_lac_ini_dose3","th_170_blood_lac_ini_dose4","th_171_blood_lac_ini_dose5","th_172_blood_bhb_ini_dose1","th_173_blood_bhb_ini_dose2","th_174_blood_bhb_ini_dose3","th_175_blood_bhb_ini_dose4","th_176_blood_bhb_ini_dose5","th_177_AcCoAmito_na_ini_dose1","th_178_AcCoAmito_na_ini_dose2","th_179_AcCoAmito_na_ini_dose3","th_180_AcCoAmito_na_ini_dose4","th_181_AcCoAmito_na_ini_dose5","th_182_SUCCOAmito_na_ini_dose1","th_183_SUCCOAmito_na_ini_dose2","th_184_SUCCOAmito_na_ini_dose3","th_185_SUCCOAmito_na_ini_dose4","th_186_SUCCOAmito_na_ini_dose5"]

            u0_ss[71] = 1.1*1.35

        end

    end


    if preset_for_custom == "th_187_ATP_dose1"

        ATDPtot_n = 1.5 #1.4449961078157665 # cyto

        u0_ss[23] = 1.4 # 1.3846374147608125 # ATP_n0


        u0_ss[13] = 1.4 #1.385172099080793  #ATP_i_n0

    end

    if preset_for_custom == "th_188_ATP_dose2"
        ATDPtot_n = 1.525 #1.4449961078157665 # cyto

        u0_ss[23] = 1.425 # 1.3846374147608125 # ATP_n0


        u0_ss[13] = 1.425 #1.385172099080793  #ATP_i_n0


    end

    if preset_for_custom == "th_189_ATP_dose3"
        # V7:
        ATDPtot_n = 1.55 #1.4449961078157665 # cyto

        u0_ss[23] = 1.45 # 1.3846374147608125 # ATP_n0


        u0_ss[13] = 1.45 #1.385172099080793  #ATP_i_n0

    end

    if preset_for_custom == "th_190_ATP_dose4"
        # V8:
        ATDPtot_n = 1.575 #1.4449961078157665 # cyto

        u0_ss[23] = 1.475 # 1.3846374147608125 # ATP_n0


        u0_ss[13] = 1.475 #1.385172099080793  #ATP_i_n0


    end

    if preset_for_custom == "th_191_ATP_dose5"
        # V5 - good:
        ATDPtot_n = 1.6 #1.4449961078157665 # cyto

        u0_ss[23] = 1.5 # 1.3846374147608125 # ATP_n0


        u0_ss[13] = 1.5 #1.385172099080793  #ATP_i_n0


    end


    # HERE YOU CAN add:
    # if preset_for_custom in ["your condition"]
        # your changes


elseif default_or_custom_config == "default"
    extraTag = string(default_or_custom_config,"_")
else
    println("UNEXPECTED/UNDEFINED default_or_custom_config")
end


###########################################
# HERE YOU CAN CHOOSE SIM SETUP DEPENDING ON STIMULUS TYPE AND DURATION:
# TO HAVE BOTH SYN ACT AND NEmode SET to stim_choice = "NEmodAndSyn"
# OTHERWISE USE stim_choice = "mainSyn" FOR ONLY SYN ACT. "mainSyn_x2" is to simulate 2 intervals of mainSyn separated by rest state.
# OTHER STIM ARE ALSO AVAILABLE, SEE CODE FOR THE DETAILS

stim_choice = ["mainSyn","mainSyn_x2", "NEmodAndSyn", "NEmodOnly", "longNoStim", "1AP", "train_inj"][7]

if stim_choice == "train_inj"

    IinjAmpl = [1.198,2.5,3.0][2]

else
    println("Using ",stim_choice)
end

# For "NEmodAndSyn", "NEmodOnly"
xNEmod = [0.025,0.05,0.1][1]

# path to the output files:
outresdirname = "output"  #"output_1e4" #"output"



################################################
# HERE YOU CAN change saveat_dt to 1e-4 seconds below to have high resolution and see individual spikes in time series plots, but
# ATTENTION: output file size will be several Gb in case of saveat_dt == 1e-4,
# so use it only when need such resolution for the figures and delete the output data once it isn't needed

saveat_dt = 1 #1 # 1e-4 # seconds  # 1e-4 only with  --exclusive --mem=0

println("CONFIG: ",age_cat,"\t",ini_met,"\t",default_or_custom_config,"\t",stim_choice,"\n",
    "OUTPUT PATH:","\t",outresdirname)

# to save output:
outfid = string("sim_",srun_idx,"_extraTag_",extraTag,"_",Dates.format(now(), "mmdd_HHMM"))




# THESE TWO ARE PARAMS FOR SYN ACT AND BF IN CB:
global_par_vn_2_tp = 3. #10. #1.44 # 25.
metglobal_par_t_stim_tp = 2.0

# these are just for initialisation, don't change them here
synInput = 1.0E-12 # ~0.0 but 1e-12 instead for numerical reasons in opt
Iinj0 = 1.0E-12 # ~0.0 but 1e-12 instead for numerical reasons in opt



if age_cat == "young"

    function metabolism!(du,u,p,t)
        u_h_m_n = u[1]
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
        u_adp_c_n = u[23]/2*(-qAK+sqrt(qAK*qAK+4*qAK*(ATDPtot_n/u[23]-1)))
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
        u_adp_c_a = u[73]/2*(-qAK+sqrt(qAK*qAK+4*qAK*(ATDPtot_a/u[73]-1)))
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
        u_notBigg_GPb_c_a = u[183]
        u_h_c_n = C_H_cyt_n
        u_h_c_a = C_H_cyt_a
        u_co2_m_n = CO2_mito_n
        u_co2_m_a = CO2_mito_a
        u_ppi_c_a = PPi_a0
        u_notBigg_PHKa_c_a = PHKa_a0
        u_notBigg_PP1_c_a_initialValue = PP1_a0
        H2PIi_n = (1e-3*u_pi_i_n)*(1e-3*u_h_i_n)/((1e-3*u_h_i_n)+k_dHPi)
        H2PIx_n = (1e-3*u_pi_m_n)*(1e-3*u_h_m_n)/((1e-3*u_h_m_n)+k_dHPi)
        H2PIi_a = (1e-3*u_pi_i_a)*(1e-3*u_h_i_a)/((1e-3*u_h_i_a)+k_dHPi)
        H2PIx_a = (1e-3*u_pi_m_a)*(1e-3*u_h_m_a)/((1e-3*u_h_m_a)+k_dHPi)
        synInput=p[1]
        Iinj=p[2]


        global_par_t_0 = p[3]
        global_par_t_fin = p[4]

        C_Glc_a = p[5]
        C_Lac_a = p[6]
        C_bHB_a = p[7]


        Pi_n=u[139]
        Pi_a=u[140]
        C_H_mitomatr_nM=1e-3*u[1];
        K_x_nM=1e-3*u[2];
        Mg_x_nM=1e-3*u[3];
        NADHmito_nM=1e-3*u[4];
        QH2mito_nM=1e-3*u[5];
        CytCredmito_nM=1e-3*u[6];
        O2_nM=1e-3*u[7];
        ATPmito_nM=1e-3*u[8];
        ADPmito_nM=1e-3*u[9]
        Cr_n=Crtot-u[174];
        Cr_a=Crtot-u[176]
        ADP_n=u[23]/2*(-qAK+sqrt(qAK*qAK+4*qAK*(ATDPtot_n/u[23]-1)))
        ADP_a=u[73]/2*(-qAK+sqrt(qAK*qAK+4*qAK*(ATDPtot_a/u[73]-1)))
        j_un=qAK*qAK+4*qAK*(ATDPtot_n/u[23]-1)
        j_ug=qAK*qAK+4*qAK*(ATDPtot_a/u[73]-1)
        dAMPdATPn=-1+qAK/2-0.5*sqrt(j_un)+qAK*ATDPtot_n/(u[23]*sqrt(j_un))
        dAMPdATPg=-1+qAK/2-0.5*sqrt(j_ug)+qAK*ATDPtot_a/(u[73]*sqrt(j_ug))
        ATP_nM=1e-3*u[23];
        ADP_nM=1e-3*ADP_n
        ATP_aM=1e-3*u[73];
        ADP_aM=1e-3*ADP_a
        ATP_mx_nM=1e-3*u[10];
        ADP_mx_nM=1e-3*u[11]
        Pimito_nM=1e-3*u[12]
        ATP_i_nM=1e-3*u[13];
        ADP_i_nM=1e-3*u[14];
        AMP_i_nM=1e-3*u[15]
        ATP_mi_nM=1e-3*u[16];
        ADP_mi_nM=1e-3*u[17]
        Pi_i_nM=1e-3*u[18]
        Ctot_nM=1e-3*u[20]
        Qtot_nM=1e-3*u[21]
        C_H_ims_nM=1e-3*u[22]
        AMP_nM=0
        NAD_x_n=NADtot_n-NADHmito_nM;
        u_nad_m_n=1000*NAD_x_n
        Q_n=Qtot_nM-QH2mito_nM;
        Qmito_n=1000*Q_n
        Cox_n=Ctot_nM-CytCredmito_nM;
        ATP_fx_n=ATPmito_nM-ATP_mx_nM
        ADP_fx_n=ADPmito_nM-ADP_mx_nM
        ATP_fi_n=ATP_i_nM-ATP_mi_nM
        ADP_fi_n=ADP_i_nM-ADP_mi_nM
        ADP_me_n=((K_DD+ADP_nM+Mg_tot)-sqrt((K_DD+ADP_nM+Mg_tot)^2-4*(Mg_tot*ADP_nM)))/2;
        Mg_i_n=Mg_tot-ADP_me_n;
        dG_H_n=etcF*u[19]+1*etcRT*log(C_H_ims_nM/C_H_mitomatr_nM);
        dG_C1op_n=dG_C1o-1*etcRT*log(C_H_mitomatr_nM/1e-7);
        dG_C3op_n=dG_C3o+2*etcRT*log(C_H_mitomatr_nM/1e-7);
        dG_C4op_n=dG_C4o-2*etcRT*log(C_H_mitomatr_nM/1e-7);
        dG_F1op_n=dG_F1o-1*etcRT*log(C_H_mitomatr_nM/1e-7);
        C_H_mitomatr_a=u[51];
        C_H_mitomatr_aM=1e-3*u[51]
        K_x_aM=1e-3*u[52]
        Mg_x_aM=1e-3*u[53]
        NADHmito_aM=1e-3*u[54]
        QH2mito_aM=1e-3*u[55]
        CytCredmito_aM=1e-3*u[56]
        O2_aM=1e-3*u[57]
        ATPmito_aM=1e-3*u[58]
        ADPmito_aM=1e-3*u[59]
        ATP_mx_aM=1e-3*u[60]
        ADP_mx_aM=1e-3*u[61]
        Pimito_aM=1e-3*u[62]
        ATP_i_aM=1e-3*u[63]
        ADP_i_aM=1e-3*u[64];
        AMP_i_aM=1e-3*u[65]
        ATP_mi_aM=1e-3*u[66]
        ADP_mi_aM=1e-3*u[67]
        Pi_i_aM=1e-3*u[68]
        Ctot_aM=1e-3*u[70]
        Qtot_aM=1e-3*u[71]
        C_H_ims_aM=1e-3*u[72]
        AMP_aM=0
        NAD_x_a=NADtot_a-NADHmito_aM;
        u_nad_m_a=1000*NAD_x_a
        Q_a=Qtot_aM-QH2mito_aM;
        Qmito_a=1000*Q_a
        Cox_a=Ctot_aM-CytCredmito_aM;
        ATP_fx_a=ATPmito_aM-ATP_mx_aM
        ADP_fx_a=ADPmito_aM-ADP_mx_aM
        ATP_fi_a=ATP_i_aM-ATP_mi_aM
        ADP_fi_a=ADP_i_aM-ADP_mi_aM
        ADP_me_a=((K_DD_a+ADP_aM+Mg_tot)-sqrt((K_DD_a+ADP_aM+Mg_tot)^2-4*(Mg_tot*ADP_aM)))/2;
        Mg_i_a=Mg_tot-ADP_me_a;
        dG_H_a=etcF*u[69]+1*etcRT*log(C_H_ims_aM/C_H_mitomatr_aM);
        dG_C1op_a=dG_C1o-1*etcRT*log(C_H_mitomatr_aM/1e-7);
        dG_C3op_a=dG_C3o+2*etcRT*log(C_H_mitomatr_aM/1e-7);
        dG_C4op_a=dG_C4o-2*etcRT*log(C_H_mitomatr_aM/1e-7);
        dG_F1op_a=dG_F1o-1*etcRT*log(C_H_mitomatr_aM/1e-7);
        u_nadp_c_n=0.0303-u[153];
        u_nadp_c_a=0.0303-u[154]
        u_nad_c_n=0.212-u[50];
        u_nad_c_a=0.212-u[138]
        V=u[98]
        rTRPVsinf=u[111]
        Glutamate_syn=u[97]
        alpham=-0.1*(V+33)/(exp(-0.1*(V+33))-1)
        betam=4*exp(-(V+58)/12)
        alphah=0.07*exp(-(V+50)/10)
        betah=1/(exp(-0.1*(V+20))+1)
        alphan=-0.01*(V+34)/(exp(-0.1*(V+34))-1)
        betan=0.125*exp(-(V+44)/25)
        minf=alpham/(alpham+betam);
        ninf=alphan/(alphan+betan);
        hinf=alphah/(alphah+betah);
        taun=1/(alphan+betan)*1e-03;
        tauh=1/(alphah+betah)*1e-03;
        p_inf=1.0/(1.0+exp(-(V+35.0)/10.0));
        tau_p=tau_max/(3.3*exp((V+35.0)/20.0)+exp(-(V+35.0)/20.0))
        K_n=K_n_Rest+(Na_n_Rest-u[99])
        EK=RTF*log(u[96]/K_n)
        EL=gKpas*EK/(gKpas+gNan)+gNan/(gKpas+gNan)*RTF*log(Na_out/u[99]);
        IL=gL*(V-EL);
        INa=gNa*minf^3*u[100]*(V-RTF*log(Na_out/u[99]));
        IK=gK*u[101]^4*(V-EK);
        mCa=1/(1+exp(-(V+20)/9));
        ICa=gCa*mCa^2*(V-ECa);
        ImAHP=gmAHP*u[102]/(u[102]+KD)*(V-EK);
        IM=g_M*u[103]*(V-EK)


        dIPump=(0.9117230433328604/u[120])*F*kPumpn*u[23]*(u[99]-u0_ss[99])/(1+u[23]/KmPump); # 0.9117230433328604 is u0_ss[120] in young controls
        dIPump_a=F*kPumpg*u[73]*(u[94]-u0_ss[94])/(1+u[73]/KmPump)
        Isyne=-synInput*(V-Ee);
        Isyni=0
        vnstim=SmVn/F*(2/3*Isyne-INa);
        vgstim=SmVg/F*2/3*glia*synInput;
        vLeakNan=SmVn*gNan/F*(RTF*log(Na_out/u[99])-V);
        vLeakNag=SmVg*gNag/F*(RTF*log(Na_out/u[94])-V);


        vPumpn=(0.9117230433328604/u[120])*SmVn*kPumpn*u[23]*u[99]/(1+u[23]/KmPump); # 0.9117230433328604 is u0_ss[120] in young controls
        vPumpg=SmVg*kPumpg*u[73]*u[94]/(1+u[73]/KmPump);
        JgliaK=((u[73]/ADP_a)/(mu_glia_ephys+(u[73]/ADP_a)))*(glia_c/(1+exp((Na_n2_baseNKA-u[96])/2.5)))
        JdiffK=epsilon*(u[96]-kbath)
        nBKinf=0.5*(1+tanh((u[93]+EETshift*u[112]-(-0.5*v5BK*tanh((u[108]-Ca3BK)/Ca4BK)+v6BK))/v4BK))
        IBK=gBK*u[104]*(u[93]-EBK)
        JNaK_a=(ImaxNaKa*(u[96]/(u[96]+INaKaKThr))*((u[94]^1.5)/(u[94]^1.5+INaKaNaThr^1.5)))
        IKirAS=gKirS*(u[96]^0.5)*(u[93]-VKirS*log(u[96]/u[95]))
        IKirAV=gKirV*(u[96]^0.5)*(u[93]-VKirAV*log(u[96]/u[95]))
        IleakA=gleakA*(u[93]-VleakA)
        Ileak_CaER_a=Pleak_CaER_a*(1.0-u[108]/u[109])
        ICa_pump_a=VCa_pump_a*((u[108]^2)/(u[108]^2+KpCa_pump_a^2))
        IIP3_a=ImaxIP3_a*(((u[106]/(u[106]+KIIP3_a))*(u[108]/(u[108]+KCaactIP3_a))*u[107])^3)*(1.0-u[108]/u[109])
        ITRP_a=gTRP*(u[93]-VTRP)*u[110]
        sinfTRPV=(1/(1+exp(-(((rTRPVsinf^(1/3)-r0TRPVsinf^(1/3))/r0TRPVsinf^(1/3))-e2TRPVsinf^(1/3))/kTRPVsinf)))*((1/(1+u[108]/gammaCaaTRPVsinf+Ca_perivasc/gammaCapTRPVsinf))*(u[108]/gammaCaaTRPVsinf+Ca_perivasc/gammaCapTRPVsinf+tanh((u[93]-v1TRPsinf_a)/v2TRPsinf_a)))
        r0509_n(u_nadh_m_n,u_pi_m_n) = 1*(x_DH*(r_DH*NAD_x_n-(1e-3*u_nadh_m_n))*((1+(1e-3*u_pi_m_n)/k_Pi1)/(1+(1e-3*u_pi_m_n)/k_Pi2)))
        NADH2_u10mi_n(u_nadh_m_n,u_q10h2_m_n) = 1*(x_C1*(exp(-(dG_C1op_n+4*dG_H_n)/etcRT)*(1e-3*u_nadh_m_n)*Q_n-NAD_x_n*(1e-3*u_q10h2_m_n)))
        CYOR_u10mi_n(u_focytC_m_n,u_notBigg_MitoMembrPotent_m_n,u_q10h2_m_n,u_pi_m_n) = 1*(x_C3*((1+(1e-3*u_pi_m_n)/k_Pi3)/(1+(1e-3*u_pi_m_n)/k_Pi4))*(exp(-(dG_C3op_n+4*dG_H_n-2*etcF*u_notBigg_MitoMembrPotent_m_n)/(2*etcRT))*Cox_n*(1e-3*u_q10h2_m_n)^0.5-(1e-3*u_focytC_m_n)*Q_n^0.5))
        CYOOm2i_n(u_focytC_m_n,u_notBigg_MitoMembrPotent_m_n,u_notBigg_Ctot_m_n,u_o2_c_n) = 1*(x_C4*((1e-3*u_o2_c_n)/((1e-3*u_o2_c_n)+k_O2))*((1e-3*u_focytC_m_n)/(1e-3*u_notBigg_Ctot_m_n))*(exp(-(dG_C4op_n+2*dG_H_n)/(2*etcRT))*(1e-3*u_focytC_m_n)*((1e-3*u_o2_c_n)^0.25)-Cox_n*exp(etcF*u_notBigg_MitoMembrPotent_m_n/etcRT)))
        ATPS4mi_n(u_notBigg_ATP_mx_m_n,u_notBigg_ADP_mx_m_n,u_pi_m_n) = 1*(x_F1*(exp(-(dG_F1op_n-n_A*dG_H_n)/etcRT)*(K_DD/K_DT)*(1e-3*u_notBigg_ADP_mx_m_n)*(1e-3*u_pi_m_n)-(1e-3*u_notBigg_ATP_mx_m_n)))
        ATPtm_n(u_notBigg_MitoMembrPotent_m_n) = 1*(x_ANT*(ADP_fi_n/(ADP_fi_n+ATP_fi_n*exp(-etcF*(0.35*u_notBigg_MitoMembrPotent_m_n)/etcRT))-ADP_fx_n/(ADP_fx_n+ATP_fx_n*exp(-etcF*(-0.65*u_notBigg_MitoMembrPotent_m_n)/etcRT)))*(ADP_fi_n/(ADP_fi_n+k_mADP)))
        notBigg_J_Pi1_n(u_h_m_n,u_h_i_n) = 1*(x_Pi1*((1e-3*u_h_m_n)*H2PIi_n-(1e-3*u_h_i_n)*H2PIx_n)/(H2PIi_n+k_PiH))
        notBigg_J_Hle_n(u_h_m_n,u_h_i_n,u_notBigg_MitoMembrPotent_m_n) = 1*(x_Hle*u_notBigg_MitoMembrPotent_m_n*((1e-3*u_h_i_n)*exp(etcF*u_notBigg_MitoMembrPotent_m_n/etcRT)-(1e-3*u_h_m_n))/(exp(etcF*u_notBigg_MitoMembrPotent_m_n/etcRT)-1))
        notBigg_J_KH_n(u_h_m_n,u_h_i_n,u_k_m_n) = 1*(x_KH*(K_i*(1e-3*u_h_m_n)-(1e-3*u_k_m_n)*(1e-3*u_h_i_n)))
        notBigg_J_K_n(u_k_m_n,u_notBigg_MitoMembrPotent_m_n) = 1*(x_K*u_notBigg_MitoMembrPotent_m_n*(K_i*exp(etcF*u_notBigg_MitoMembrPotent_m_n/etcRT)-(1e-3*u_k_m_n))/(exp(etcF*u_notBigg_MitoMembrPotent_m_n/etcRT)-1))
        ADK1m_n(u_amp_i_n,u_atp_i_n,u_adp_i_n) = 1*(x_AK*(K_AK*(1e-3*u_adp_i_n)*(1e-3*u_adp_i_n)-(1e-3*u_amp_i_n)*(1e-3*u_atp_i_n)))
        notBigg_J_AMP_n(u_amp_i_n,u_amp_c_n) = 1*(gamma*x_A*((1e-3*u_amp_c_n)-(1e-3*u_amp_i_n)))
        notBigg_J_ADP_n(u_adp_i_n,u_adp_c_n) = 1*(gamma*x_A*((1e-3*u_adp_c_n)-(1e-3*u_adp_i_n)))
        notBigg_J_ATP_n(u_atp_c_n,u_atp_i_n) = 1*(gamma*x_A*((1e-3*u_atp_c_n)-(1e-3*u_atp_i_n)))
        notBigg_J_Pi2_n(u_pi_i_n,u_pi_c_n) = 1*(gamma*x_Pi2*(1e-3*u_pi_c_n-(1e-3*u_pi_i_n)))
        notBigg_J_Ht_n(u_h_i_n,u_h_c_n) = 1*(gamma*x_Ht*(1e-3*u_h_c_n-(1e-3*u_h_i_n)))
        notBigg_J_MgATPx_n(u_notBigg_ATP_mx_m_n,u_mg2_m_n) = 1*(x_MgA*(ATP_fx_n*(1e-3*u_mg2_m_n)-K_DT*(1e-3*u_notBigg_ATP_mx_m_n)))
        notBigg_J_MgADPx_n(u_mg2_m_n,u_notBigg_ADP_mx_m_n) = 1*(x_MgA*(ADP_fx_n*(1e-3*u_mg2_m_n)-K_DD*(1e-3*u_notBigg_ADP_mx_m_n)))
        notBigg_J_MgATPi_n(u_notBigg_ATP_mi_i_n) = 1*(x_MgA*(ATP_fi_n*Mg_i_n-K_DT*(1e-3*u_notBigg_ATP_mi_i_n)))
        notBigg_J_MgADPi_n(u_notBigg_ADP_mi_i_n) = 1*(x_MgA*(ADP_fi_n*Mg_i_n-K_DD*(1e-3*u_notBigg_ADP_mi_i_n)))
        PDHm_n(u_pyr_m_n,u_coa_m_n,u_nad_m_n) = 1*(VmaxPDHCmito_n*(u_pyr_m_n/(u_pyr_m_n+KmPyrMitoPDH_n))*(u_nad_m_n/(u_nad_m_n+KmNADmitoPDH_na))*(u_coa_m_n/(u_coa_m_n+KmCoAmitoPDH_n)))
        CSm_n(u_accoa_m_n,u_oaa_m_n,u_cit_m_n,u_coa_m_n) = 1*(VmaxCSmito_n*(u_oaa_m_n/(u_oaa_m_n+KmOxaMito_n*(1.0+u_cit_m_n/KiCitMito_n)))*(u_accoa_m_n/(u_accoa_m_n+KmAcCoAmito_n*(1.0+u_coa_m_n/KiCoA_n))))
        ACONTm_n(u_icit_m_n,u_cit_m_n) = 1*(VmaxAco_n*(u_cit_m_n-u_icit_m_n/KeqAco_na)/(1.0+u_cit_m_n/KmCitAco_n+u_icit_m_n/KmIsoCitAco_n))
        ICDHxm_n(u_nadh_m_n,u_icit_m_n,u_nad_m_n) = 1*(VmaxIDH_n*(u_nad_m_n/KiNADmito_na)*((u_icit_m_n/KmIsoCitIDHm_n)^nIDH)/(1.0+u_nad_m_n/KiNADmito_na+(KmNADmito_na/KiNADmito_na)*((u_icit_m_n/KmIsoCitIDHm_n)^nIDH)+u_nadh_m_n/KiNADHmito_na+(u_nad_m_n/KiNADmito_na)*((u_icit_m_n/KmIsoCitIDHm_n)^nIDH)+((KmNADmito_na*u_nadh_m_n)/(KiNADmito_na*KiNADHmito_na))*((u_icit_m_n/KmIsoCitIDHm_n)^nIDH)))
        AKGDm_n(u_coa_m_n,u_nadh_m_n,u_ca2_m_n,u_adp_m_n,u_succoa_m_n,u_nad_m_n,u_atp_m_n,u_akg_m_n) = 1*((VmaxKGDH_n*(1+u_adp_m_n/KiADPmito_KGDH_n)*(u_akg_m_n/Km1KGDHKGDH_n)*(u_coa_m_n/Km_CoA_kgdhKGDH_n)*(u_nad_m_n/KmNADkgdhKGDH_na))/(((u_coa_m_n/Km_CoA_kgdhKGDH_n)*(u_nad_m_n/KmNADkgdhKGDH_na)*(u_akg_m_n/Km1KGDHKGDH_n+(1+u_atp_m_n/KiATPmito_KGDH_n)/(1+u_ca2_m_n/KiCa2KGDH_n)))+((u_akg_m_n/Km1KGDHKGDH_n)*(u_coa_m_n/Km_CoA_kgdhKGDH_n+u_nad_m_n/KmNADkgdhKGDH_na)*(1+u_nadh_m_n/KiNADHKGDHKGDH_na+u_succoa_m_n/Ki_SucCoA_kgdhKGDH_n))))
        SUCOASm_n(u_coa_m_n,u_succ_m_n,u_pi_m_n,u_adp_m_n,u_succoa_m_n,u_atp_m_n) = 1*(VmaxSuccoaATPscs_n*(1+AmaxPscs_n*((u_pi_m_n^npscs_n)/((u_pi_m_n^npscs_n)+(Km_pi_scs_na^npscs_n))))*(u_succoa_m_n*u_adp_m_n*u_pi_m_n-u_succ_m_n*u_coa_m_n*u_atp_m_n/Keqsuccoascs_na)/((1+u_succoa_m_n/Km_succoa_scs_n)*(1+u_adp_m_n/Km_ADPmito_scs_n)*(1+u_pi_m_n/Km_pi_scs_na)+(1+u_succ_m_n/Km_succ_scs_n)*(1+u_coa_m_n/Km_coa_scs_n)*(1+u_atp_m_n/Km_atpmito_scs_n)))
        FUMm_n(u_fum_m_n,u_mal_L_m_n) = 1*(Vmaxfum_n*(u_fum_m_n-u_mal_L_m_n/Keqfummito_na)/(1.0+u_fum_m_n/Km_fummito_n+u_mal_L_m_n/Km_malmito_n))
        MDHm_n(u_nadh_m_n,u_oaa_m_n,u_nad_m_n,u_mal_L_m_n) = 1*(VmaxMDHmito_n*(u_mal_L_m_n*u_nad_m_n-u_oaa_m_n*u_nadh_m_n/Keqmdhmito_na)/((1.0+u_mal_L_m_n/Km_mal_mdh_n)*(1.0+u_nad_m_n/Km_nad_mdh_na)+(1.0+u_oaa_m_n/Km_oxa_mdh_n)*(1.0+u_nadh_m_n/Km_nadh_mdh_na)))
        OCOAT1m_n(u_acac_c_n,u_aacoa_m_n,u_succoa_m_n,u_succ_m_n) = 1*((VmaxfSCOT_n*u_succoa_m_n*u_acac_c_n/(Ki_SucCoA_SCOT_n*Km_AcAc_SCOT_n*(u_succoa_m_n/Ki_SucCoA_SCOT_n+Km_SucCoA_SCOT_n*u_acac_c_n/(Ki_SucCoA_SCOT_n*Km_AcAc_SCOT_n)+u_aacoa_m_n/Ki_AcAcCoA_SCOT_n+Km_AcAcCoA_SCOT_n*u_succ_m_n/(Ki_AcAcCoA_SCOT_n*Km_SUC_SCOT_n)+u_succoa_m_n*u_acac_c_n/(Ki_SucCoA_SCOT_n*Km_AcAc_SCOT_n)+u_succoa_m_n*u_aacoa_m_n/(Ki_SucCoA_SCOT_n*Ki_AcAcCoA_SCOT_n)+Km_SucCoA_SCOT_n*u_acac_c_n*u_succ_m_n/(Ki_SucCoA_SCOT_n*Km_AcAc_SCOT_n*Ki_SUC_SCOT_n)+u_aacoa_m_n*u_succ_m_n/(Ki_AcAcCoA_SCOT_n*Km_SUC_SCOT_n))))-(VmaxrSCOT_n*u_aacoa_m_n*u_succ_m_n/(Ki_AcAcCoA_SCOT_n*Km_SUC_SCOT_n*(u_succoa_m_n/Ki_SucCoA_SCOT_n+Km_SucCoA_SCOT_n*u_acac_c_n/(Ki_SucCoA_SCOT_n*Km_AcAc_SCOT_n)+u_aacoa_m_n/Ki_AcAcCoA_SCOT_n+Km_AcAcCoA_SCOT_n*u_succ_m_n/(Ki_AcAcCoA_SCOT_n*Km_SUC_SCOT_n)+u_succoa_m_n*u_acac_c_n/(Ki_SucCoA_SCOT_n*Km_AcAc_SCOT_n)+u_succoa_m_n*u_aacoa_m_n/(Ki_SucCoA_SCOT_n*Ki_AcAcCoA_SCOT_n)+Km_SucCoA_SCOT_n*u_acac_c_n*u_succ_m_n/(Ki_SucCoA_SCOT_n*Km_AcAc_SCOT_n*Ki_SUC_SCOT_n)+u_aacoa_m_n*u_succ_m_n/(Ki_AcAcCoA_SCOT_n*Km_SUC_SCOT_n)))))
        ACACT1rm_n(u_aacoa_m_n,u_coa_m_n) = 1*(Vmax_thiolase_f_n*u_coa_m_n*u_aacoa_m_n/(Ki_CoA_thiolase_f_n*Km_AcAcCoA_thiolase_f_n+Km_AcAcCoA_thiolase_f_n*u_coa_m_n+Km_CoA_thiolase_f_n*u_aacoa_m_n+u_coa_m_n*u_aacoa_m_n))
        notBigg_JbHBTrArtCap(t,u_bhb_b_b) = 1*((2*(C_bHB_a-u_bhb_b_b)/eto_b)*(global_par_F_0*(1+global_par_delta_F*(1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1-3))))-1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1+global_par_t_fin+3))))))))
        notBigg_MCT1_bHB_b(u_bhb_e_e,u_bhb_b_b) = 1*(VmaxMCTbhb_b*(u_bhb_b_b/(u_bhb_b_b+KmMCT1_bHB_b)-u_bhb_e_e/(u_bhb_e_e+KmMCT1_bHB_b)))
        BHBt_n(u_bhb_c_n,u_bhb_e_e) = 1*(VmaxMCTbhb_n*(u_bhb_e_e/(u_bhb_e_e+KmMCT2_bHB_n)-u_bhb_c_n/(u_bhb_c_n+KmMCT2_bHB_n)))
        BHBt_a(u_bhb_c_a,u_bhb_e_e) = 1*(VmaxMCTbhb_a*(u_bhb_e_e/(u_bhb_e_e+KmMCT1_bHB_a)-u_bhb_c_a/(u_bhb_c_a+KmMCT1_bHB_a)))
        BDHm_n(u_acac_c_n,u_bhb_c_n,u_nadh_m_n,u_nad_m_n) = 1*(Vmax_bHBDH_f_n*u_nad_m_n*u_bhb_c_n/(Ki_NAD_B_HBD_f_n*Km_betaHB_BHBD_n+Km_betaHB_BHBD_n*u_nad_m_n+Km_NAD_B_HBD_n*u_bhb_c_n+u_nad_m_n*u_bhb_c_n)-(Vmax_bHBDH_r_n*u_nadh_m_n*u_acac_c_n/(Ki_NADH_BHBD_r_n*Km_AcAc_BHBD_n+Km_AcAc_BHBD_n*u_nadh_m_n+Km_NADH_BHBD_n*u_acac_c_n+u_nadh_m_n*u_acac_c_n)))

        # BDHm_a(u_bhb_c_a,u_acac_c_a,u_nad_m_a,u_nadh_m_a) = 1*(Vmax_bHBDH_f_n*u_nad_m_a*u_bhb_c_a/(Ki_NAD_B_HBD_f_n*Km_betaHB_BHBD_n+Km_betaHB_BHBD_n*u_nad_m_a+Km_NAD_B_HBD_n*u_bhb_c_a+u_nad_m_a*u_bhb_c_a)-(Vmax_bHBDH_r_n*u_nadh_m_a*u_acac_c_a/(Ki_NADH_BHBD_r_n*Km_AcAc_BHBD_n+Km_AcAc_BHBD_n*u_nadh_m_a+Km_NADH_BHBD_n*u_acac_c_a+u_nadh_m_a*u_acac_c_a)))


        ASPTAm_n(u_oaa_m_n,u_akg_m_n,u_glu_L_m_n,u_asp_L_m_n) = 1*(VfAAT_n*(u_asp_L_m_n*u_akg_m_n-u_oaa_m_n*u_glu_L_m_n/KeqAAT_n)/(KmAKG_AAT_n*u_asp_L_m_n+KmASP_AAT_n*(1.0+u_akg_m_n/KiAKG_AAT_n)*u_akg_m_n+u_asp_L_m_n*u_akg_m_n+KmASP_AAT_n*u_akg_m_n*u_glu_L_m_n/KiGLU_AAT_n+(KiASP_AAT_n*KmAKG_AAT_n/(KmOXA_AAT_n*KiGLU_AAT_n))*(KmGLU_AAT_n*u_asp_L_m_n*u_oaa_m_n/KiASP_AAT_n+u_oaa_m_n*u_glu_L_m_n+KmGLU_AAT_n*(1.0+u_akg_m_n/KiAKG_AAT_n)*u_oaa_m_n+KmOXA_AAT_n*u_glu_L_m_n)))
        MDH_n(u_nadh_c_n,u_mal_L_c_n,u_oaa_c_n,u_nad_c_n) = 1*(VmaxcMDH_n*(u_mal_L_c_n*u_nad_c_n-u_oaa_c_n*u_nadh_c_n/Keqcmdh_n)/((1+u_mal_L_c_n/Kmmalcmdh_n)*(1+u_nad_c_n/Kmnadcmdh_n)+(1+u_oaa_c_n/Kmoxacmdh_n)*(1+u_nadh_c_n/Kmnadhcmdh_n)-1))
        ASPTA_n(u_glu_L_c_n,u_asp_L_c_n,u_oaa_c_n,u_akg_c_n) = 1*(VfCAAT_n*(u_asp_L_c_n*u_akg_c_n-u_oaa_c_n*u_glu_L_c_n/KeqCAAT_n)/(KmAKG_CAAT_n*u_asp_L_c_n+KmASP_CAAT_n*(1.0+u_akg_c_n/KiAKG_CAAT_n)*u_akg_c_n+u_asp_L_c_n*u_akg_c_n+KmASP_CAAT_n*u_akg_c_n*u_glu_L_c_n/KiGLU_CAAT_n+(KiASP_CAAT_n*KmAKG_CAAT_n/(KmOXA_CAAT_n*KiGLU_CAAT_n))*(KmGLU_CAAT_n*u_asp_L_c_n*u_oaa_c_n/KiASP_CAAT_n+u_oaa_c_n*u_glu_L_c_n+KmGLU_CAAT_n*(1.0+u_akg_c_n/KiAKG_CAAT_n)*u_oaa_c_n+KmOXA_CAAT_n*u_glu_L_c_n)))
        ASPGLUm_n(u_h_c_n,u_glu_L_c_n,u_asp_L_m_n,u_asp_L_c_n,u_notBigg_MitoMembrPotent_m_n,u_glu_L_m_n,u_h_m_n) = 1*(Vmaxagc_n*(u_asp_L_m_n*u_glu_L_c_n-u_asp_L_c_n*u_glu_L_m_n/((exp(u_notBigg_MitoMembrPotent_m_n)^(F/(R*T)))*(u_h_c_n/u_h_m_n)))/((u_asp_L_m_n+Km_aspmito_agc_n)*(u_glu_L_c_n+Km_glu_agc_n)+(u_asp_L_c_n+Km_asp_agc_n)*(u_glu_L_m_n+Km_glumito_agc_n)))
        AKGMALtm_n(u_mal_L_c_n,u_akg_m_n,u_akg_c_n,u_mal_L_m_n) = 1*(Vmaxmakgc_n*(u_mal_L_c_n*u_akg_m_n-u_mal_L_m_n*u_akg_c_n)/((u_mal_L_c_n+Km_mal_mkgc_n)*(u_akg_m_n+Km_akgmito_mkgc_n)+(u_mal_L_m_n+Km_malmito_mkgc_n)*(u_akg_c_n+Km_akg_mkgc_n)))
        r0509_a(u_nadh_m_a,u_pi_m_a) = 1*(x_DH_a*(r_DH_a*NAD_x_a-(1e-3*u_nadh_m_a))*((1+(1e-3*u_pi_m_a)/k_Pi1)/(1+(1e-3*u_pi_m_a)/k_Pi2)))
        NADH2_u10mi_a(u_nadh_m_a,u_q10h2_m_a) = 1*(x_C1*(exp(-(dG_C1op_a+4*dG_H_a)/etcRT)*(1e-3*u_nadh_m_a)*Q_a-NAD_x_a*(1e-3*u_q10h2_m_a)))
        CYOR_u10mi_a(u_focytC_m_a,u_q10h2_m_a,u_pi_m_a,u_notBigg_MitoMembrPotent_m_a) = 1*(x_C3*((1+(1e-3*u_pi_m_a)/k_Pi3)/(1+(1e-3*u_pi_m_a)/k_Pi4))*(exp(-(dG_C3op_a+4*dG_H_a-2*etcF*u_notBigg_MitoMembrPotent_m_a)/(2*etcRT))*Cox_a*(1e-3*u_q10h2_m_a)^0.5-(1e-3*u_focytC_m_a)*Q_a^0.5))
        CYOOm2i_a(u_notBigg_Ctot_m_a,u_focytC_m_a,u_notBigg_MitoMembrPotent_m_a,u_o2_c_a) = 1*(x_C4*((1e-3*u_o2_c_a)/((1e-3*u_o2_c_a)+k_O2))*((1e-3*u_focytC_m_a)/(1e-3*u_notBigg_Ctot_m_a))*(exp(-(dG_C4op_a+2*dG_H_a)/(2*etcRT))*(1e-3*u_focytC_m_a)*((1e-3*u_o2_c_a)^0.25)-Cox_a*exp(etcF*u_notBigg_MitoMembrPotent_m_a/etcRT)))
        ATPS4mi_a(u_notBigg_ATP_mx_m_a,u_pi_m_a,u_notBigg_ADP_mx_m_a) = 1*(x_F1_a*(exp(-(dG_F1op_a-n_A*dG_H_a)/etcRT)*(K_DD_a/K_DT_a)*(1e-3*u_notBigg_ADP_mx_m_a)*(1e-3*u_pi_m_a)-(1e-3*u_notBigg_ATP_mx_m_a)))
        ATPtm_a(u_notBigg_MitoMembrPotent_m_a) = 1*(x_ANT_a*(ADP_fi_a/(ADP_fi_a+ATP_fi_a*exp(-etcF*(0.35*u_notBigg_MitoMembrPotent_m_a)/etcRT))-ADP_fx_a/(ADP_fx_a+ATP_fx_a*exp(-etcF*(-0.65*u_notBigg_MitoMembrPotent_m_a)/etcRT)))*(ADP_fi_a/(ADP_fi_a+k_mADP_a)))
        notBigg_J_Pi1_a(u_h_i_a,u_h_m_a) = 1*(x_Pi1*((1e-3*u_h_m_a)*H2PIi_a-(1e-3*u_h_i_a)*H2PIx_a)/(H2PIi_a+k_PiH))
        notBigg_J_Hle_a(u_h_i_a,u_h_m_a,u_notBigg_MitoMembrPotent_m_a) = 1*(x_Hle*u_notBigg_MitoMembrPotent_m_a*((1e-3*u_h_i_a)*exp(etcF*u_notBigg_MitoMembrPotent_m_a/etcRT)-(1e-3*u_h_m_a))/(exp(etcF*u_notBigg_MitoMembrPotent_m_a/etcRT)-1))
        notBigg_J_KH_a(u_h_i_a,u_h_m_a,u_k_m_a) = 1*(x_KH*(K_i*(1e-3*u_h_m_a)-(1e-3*u_k_m_a)*(1e-3*u_h_i_a)))
        notBigg_J_K_a(u_k_m_a,u_notBigg_MitoMembrPotent_m_a) = 1*(x_K*u_notBigg_MitoMembrPotent_m_a*(K_i*exp(etcF*u_notBigg_MitoMembrPotent_m_a/etcRT)-(1e-3*u_k_m_a))/(exp(etcF*u_notBigg_MitoMembrPotent_m_a/etcRT)-1))
        ADK1m_a(u_atp_i_a,u_adp_i_a,u_amp_i_a) = 1*(x_AK*(K_AK*(1e-3*u_adp_i_a)*(1e-3*u_adp_i_a)-(1e-3*u_amp_i_a)*(1e-3*u_atp_i_a)))
        notBigg_J_AMP_a(u_amp_i_a,u_amp_c_a) = 1*(gamma*x_A*((1e-3*u_amp_c_a)-(1e-3*u_amp_i_a)))
        notBigg_J_ADP_a(u_adp_c_a,u_adp_i_a) = 1*(gamma*x_A*((1e-3*u_adp_c_a)-(1e-3*u_adp_i_a)))
        notBigg_J_ATP_a(u_atp_i_a,u_atp_c_a) = 1*(gamma*x_A*((1e-3*u_atp_c_a)-(1e-3*u_atp_i_a)))
        notBigg_J_Pi2_a(u_pi_i_a,u_pi_c_a) = 1*(gamma*x_Pi2*(1e-3*u_pi_c_a-(1e-3*u_pi_i_a)))
        notBigg_J_Ht_a(u_h_i_a,u_h_c_a) = 1*(gamma*x_Ht*(1e-3*u_h_c_a-(1e-3*u_h_i_a)))
        notBigg_J_MgATPx_a(u_notBigg_ATP_mx_m_a,u_mg2_m_a) = 1*(x_MgA*(ATP_fx_a*(1e-3*u_mg2_m_a)-K_DT_a*(1e-3*u_notBigg_ATP_mx_m_a)))
        notBigg_J_MgADPx_a(u_notBigg_ADP_mx_m_a,u_mg2_m_a) = 1*(x_MgA*(ADP_fx_a*(1e-3*u_mg2_m_a)-K_DD_a*(1e-3*u_notBigg_ADP_mx_m_a)))
        notBigg_J_MgATPi_a(u_notBigg_ATP_mi_i_a) = 1*(x_MgA*(ATP_fi_a*Mg_i_a-K_DT_a*(1e-3*u_notBigg_ATP_mi_i_a)))
        notBigg_J_MgADPi_a(u_notBigg_ADP_mi_i_a) = 1*(x_MgA*(ADP_fi_a*Mg_i_a-K_DD_a*(1e-3*u_notBigg_ADP_mi_i_a)))
        PDHm_a(u_nad_m_a,u_pyr_m_a,u_coa_m_a) = 1*(VmaxPDHCmito_a*(u_pyr_m_a/(u_pyr_m_a+KmPyrMitoPDH_a))*(u_nad_m_a/(u_nad_m_a+KmNADmitoPDH_na))*(u_coa_m_a/(u_coa_m_a+KmCoAmitoPDH_a)))
        CSm_a(u_oaa_m_a,u_cit_m_a,u_accoa_m_a,u_coa_m_a) = 1*(VmaxCSmito_a*(u_oaa_m_a/(u_oaa_m_a+KmOxaMito_a*(1.0+u_cit_m_a/KiCitMito_a)))*(u_accoa_m_a/(u_accoa_m_a+KmAcCoAmito_a*(1.0+u_coa_m_a/KiCoA_a))))
        ACONTm_a(u_cit_m_a,u_icit_m_a) = 1*(VmaxAco_a*(u_cit_m_a-u_icit_m_a/KeqAco_na)/(1.0+u_cit_m_a/KmCitAco_a+u_icit_m_a/KmIsoCitAco_a))
        ICDHxm_a(u_nad_m_a,u_nadh_m_a,u_icit_m_a) = 1*(VmaxIDH_a*(u_nad_m_a/KiNADmito_na)*((u_icit_m_a/KmIsoCitIDHm_a)^nIDH)/(1.0+u_nad_m_a/KiNADmito_na+(KmNADmito_na/KiNADmito_na)*((u_icit_m_a/KmIsoCitIDHm_a)^nIDH)+u_nadh_m_a/KiNADHmito_na+(u_nad_m_a/KiNADmito_na)*((u_icit_m_a/KmIsoCitIDHm_a)^nIDH)+((KmNADmito_na*u_nadh_m_a)/(KiNADmito_na*KiNADHmito_na))*((u_icit_m_a/KmIsoCitIDHm_a)^nIDH)))
        AKGDm_a(u_coa_m_a,u_nadh_m_a,u_akg_m_a,u_ca2_m_a,u_nad_m_a,u_succoa_m_a,u_atp_m_a,u_adp_m_a) = 1*((VmaxKGDH_a*(1+u_adp_m_a/KiADPmito_KGDH_a)*(u_akg_m_a/Km1KGDHKGDH_a)*(u_coa_m_a/Km_CoA_kgdhKGDH_a)*(u_nad_m_a/KmNADkgdhKGDH_na))/(((u_coa_m_a/Km_CoA_kgdhKGDH_a)*(u_nad_m_a/KmNADkgdhKGDH_na)*(u_akg_m_a/Km1KGDHKGDH_a+(1+u_atp_m_a/KiATPmito_KGDH_a)/(1+u_ca2_m_a/KiCa2KGDH_a)))+((u_akg_m_a/Km1KGDHKGDH_a)*(u_coa_m_a/Km_CoA_kgdhKGDH_a+u_nad_m_a/KmNADkgdhKGDH_na)*(1+u_nadh_m_a/KiNADHKGDHKGDH_na+u_succoa_m_a/Ki_SucCoA_kgdhKGDH_a))))
        SUCOASm_a(u_coa_m_a,u_succoa_m_a,u_atp_m_a,u_succ_m_a,u_pi_m_a,u_adp_m_a) = 1*(VmaxSuccoaATPscs_a*(1+AmaxPscs_a*((u_pi_m_a^npscs_a)/((u_pi_m_a^npscs_a)+(Km_pi_scs_na^npscs_a))))*(u_succoa_m_a*u_adp_m_a*u_pi_m_a-u_succ_m_a*u_coa_m_a*u_atp_m_a/Keqsuccoascs_na)/((1+u_succoa_m_a/Km_succoa_scs_a)*(1+u_adp_m_a/Km_ADPmito_scs_a)*(1+u_pi_m_a/Km_pi_scs_na)+(1+u_succ_m_a/Km_succ_scs_a)*(1+u_coa_m_a/Km_coa_scs_a)*(1+u_atp_m_a/Km_atpmito_scs_a)))
        FUMm_a(u_mal_L_m_a,u_fum_m_a) = 1*(Vmaxfum_a*(u_fum_m_a-u_mal_L_m_a/Keqfummito_na)/(1.0+u_fum_m_a/Km_fummito_a+u_mal_L_m_a/Km_malmito_a))
        MDHm_a(u_nad_m_a,u_oaa_m_a,u_mal_L_m_a,u_nadh_m_a) = 1*(VmaxMDHmito_a*(u_mal_L_m_a*u_nad_m_a-u_oaa_m_a*u_nadh_m_a/Keqmdhmito_na)/((1.0+u_mal_L_m_a/Km_mal_mdh_a)*(1.0+u_nad_m_a/Km_nad_mdh_na)+(1.0+u_oaa_m_a/Km_oxa_mdh_a)*(1.0+u_nadh_m_a/Km_nadh_mdh_na)))

        PCm_a(u_co2_m_a,u_oaa_m_a,u_pyr_m_a,u_atp_m_a,u_adp_m_a) = 1*(((u_atp_m_a/u_adp_m_a)/(muPYRCARB_a+(u_atp_m_a/u_adp_m_a)))*VmPYRCARB_a*(u_pyr_m_a*u_co2_m_a-u_oaa_m_a/KeqPYRCARB_a)/(KmPYR_PYRCARB_a*KmCO2_PYRCARB_a+KmPYR_PYRCARB_a*u_co2_m_a+KmCO2_PYRCARB_a*u_pyr_m_a+u_co2_m_a*u_pyr_m_a))

        PCm_n(u_co2_m_n,u_oaa_m_n,u_pyr_m_n,u_atp_m_n,u_adp_m_n) = neurastrExprRatio*(((u_atp_m_n/u_adp_m_n)/(muPYRCARB_a+(u_atp_m_n/u_adp_m_n)))*VmPYRCARB_a*(u_pyr_m_n*u_co2_m_n-u_oaa_m_n/KeqPYRCARB_a)/(KmPYR_PYRCARB_a*KmCO2_PYRCARB_a+KmPYR_PYRCARB_a*u_co2_m_n+KmCO2_PYRCARB_a*u_pyr_m_n+u_co2_m_n*u_pyr_m_n))

        GLNt4_n(u_gln_L_c_n,u_gln_L_e_e) = 1*(TmaxSNAT_GLN_n*(u_gln_L_e_e-u_gln_L_c_n/coeff_gln_ratio_n_ecs)/(KmSNAT_GLN_n+u_gln_L_c_n))
        GLUNm_n(u_gln_L_c_n,u_glu_L_m_n) = 1*(VmGLS_n*(u_gln_L_c_n-u_glu_L_m_n/KeqGLS_n)/(KmGLNGLS_n*(1.0+u_glu_L_m_n/KiGLUGLS_n)+u_gln_L_c_n))
        GLUt6_a(u_na1_c_a,u_notBigg_Va_c_a,u_k_e_e,u_glu_L_syn_syn,u_k_c_a,u_glu_L_c_a) = 1*(-((1/(2*F*1e-3))*(-alpha_EAAT*exp(-beta_EAAT*(u_notBigg_Va_c_a-((R*T/(2*F*1e-3))*log(((Na_syn_EAAT/u_na1_c_a)^3)*(H_syn_EAAT/H_ast_EAAT)*(u_glu_L_syn_syn/u_glu_L_c_a)*(u_k_c_a/u_k_e_e))))))))
        GLUDxm_a(u_nad_m_a,u_nadh_m_a,u_glu_L_c_a,u_akg_m_a) = 1*(VmGDH_a*(u_nad_m_a*u_glu_L_c_a-u_nadh_m_a*u_akg_m_a/KeqGDH_a)/(KiNAD_GDH_a*KmGLU_GDH_a+KmGLU_GDH_a*u_nad_m_a+KiNAD_GDH_a*u_glu_L_c_a+u_glu_L_c_a*u_nad_m_a+u_glu_L_c_a*u_nad_m_a/KiAKG_GDH_a+KiNAD_GDH_a*KmGLU_GDH_a*u_nadh_m_a/KiNADH_GDH_a+KiNAD_GDH_a*KmGLU_GDH_a*KmNADH_GDH_a*u_akg_m_a/(KiAKG_GDH_a*KiNADH_GDH_a)+KmNADH_GDH_a*u_glu_L_c_a*u_nadh_m_a/KiNADH_GDH_a+KiNAD_GDH_a*KmGLU_GDH_a*KmAKG_GDH_a*u_nadh_m_a/(KiAKG_GDH_a*KiNADH_GDH_a)+KiNAD_GDH_a*KmGLU_GDH_a*KmAKG_GDH_a*u_akg_m_a*u_nadh_m_a/(KiAKG_GDH_a*KiNADH_GDH_a)+u_glu_L_c_a*u_nad_m_a*u_akg_m_a/KiAKG_GDH_a+KiNAD_GDH_a*KmGLU_GDH_a*KmAKG_GDH_a/KiAKG_GDH_a+KiNAD_GDH_a*KmGLU_GDH_a*u_glu_L_c_a*u_nadh_m_a*u_akg_m_a/(KiGLU_GDH_a*KiAKG_GDH_a*KiNADH_GDH_a)+KiNAD_GDH_a*KmGLU_GDH_a*u_akg_m_a*u_nadh_m_a/(KiAKG_GDH_a*KiNADH_GDH_a)+KmNADH_GDH_a*KmGLU_GDH_a*u_akg_m_a*u_nad_m_a/(KiAKG_GDH_a*KiNADH_GDH_a)))
        GLNS_a(u_adp_c_a,u_atp_c_a,u_glu_L_c_a) = 1*(VmaxGLNsynth_a*(u_glu_L_c_a/(KmGLNsynth_a+u_glu_L_c_a))*((1/(u_atp_c_a/u_adp_c_a))/(muGLNsynth_a+(1/(u_atp_c_a/u_adp_c_a)))))
        GLNt4_a(u_gln_L_c_a,u_gln_L_e_e) = 1*(TmaxSNAT_GLN_a*(u_gln_L_c_a-u_gln_L_e_e)/(KmSNAT_GLN_a+u_gln_L_c_a))
        notBigg_FinDyn_W2017(t) = 1*(global_par_F_0*(1+global_par_delta_F*(1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1-3))))-1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1+global_par_t_fin+3)))))))
        notBigg_Fout_W2017(t,u_notBigg_vV_b_b) = 1*(global_par_F_0*((u_notBigg_vV_b_b/u0_ss[111])^2+(u_notBigg_vV_b_b/u0_ss[111])^(-0.5)*global_par_tau_v/u0_ss[111]*(global_par_F_0*(1+global_par_delta_F*(1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1-3))))-1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1+global_par_t_fin+3))))))))/(1+global_par_F_0*(u_notBigg_vV_b_b/u0_ss[111])^(-0.5)*global_par_tau_v/u0_ss[111]))
        notBigg_JdHbin(t,u_o2_b_b) = 1*(2*(C_O_a-u_o2_b_b)*(global_par_F_0*(1+global_par_delta_F*(1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1-3))))-1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1+global_par_t_fin+3))))))))
        notBigg_JdHbout(t,u_notBigg_ddHb_b_b,u_notBigg_vV_b_b) = 1*((u_notBigg_ddHb_b_b/u_notBigg_vV_b_b)*(global_par_F_0*((u_notBigg_vV_b_b/u0_ss[111])^2+(u_notBigg_vV_b_b/u0_ss[111])^(-0.5)*global_par_tau_v/u0_ss[111]*(global_par_F_0*(1+global_par_delta_F*(1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1-3))))-1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1+global_par_t_fin+3))))))))/(1+global_par_F_0*(u_notBigg_vV_b_b/u0_ss[111])^(-0.5)*global_par_tau_v/u0_ss[111])))
        notBigg_JO2art2cap(t,u_o2_b_b) = 1*((1/eto_b)*2*(C_O_a-u_o2_b_b)*(global_par_F_0*(1+global_par_delta_F*(1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1-3))))-1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1+global_par_t_fin+3))))))))
        notBigg_JO2fromCap2a(u_o2_b_b,u_o2_c_a) = 1*((PScapA*(KO2b*(HbOP/u_o2_b_b-1.)^(-1/param_degree_nh)-u_o2_c_a)))
        notBigg_JO2fromCap2n(u_o2_b_b,u_o2_c_n) = 1*((PScapNAratio*PScapA*(KO2b*(HbOP/u_o2_b_b-1.)^(-1/param_degree_nh)-u_o2_c_n)))
        notBigg_trGLC_art_cap(t,u_glc_D_b_b) = 1*((1/eto_b)*(2*(C_Glc_a-u_glc_D_b_b))*(global_par_F_0*(1+global_par_delta_F*(1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1-3))))-1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1+global_par_t_fin+3))))))))
        notBigg_JGlc_be(u_glc_D_ecsEndothelium_ecsEndothelium,u_glc_D_b_b) = 1*(TmaxGLCce*(u_glc_D_b_b*(KeG+u_glc_D_ecsEndothelium_ecsEndothelium)-u_glc_D_ecsEndothelium_ecsEndothelium*(KeG+u_glc_D_b_b))/(KeG^2+KeG*ReGoi*u_glc_D_b_b+KeG*ReGio*u_glc_D_ecsEndothelium_ecsEndothelium+ReGee*u_glc_D_b_b*u_glc_D_ecsEndothelium_ecsEndothelium))
        notBigg_JGlc_e2ecsBA(u_glc_D_ecsBA_ecsBA,u_glc_D_ecsEndothelium_ecsEndothelium) = 1*(TmaxGLCeb*(u_glc_D_ecsEndothelium_ecsEndothelium*(KeG2+u_glc_D_ecsBA_ecsBA)-u_glc_D_ecsBA_ecsBA*(KeG2+u_glc_D_ecsEndothelium_ecsEndothelium))/(KeG2^2+KeG2*ReGoi2*u_glc_D_ecsEndothelium_ecsEndothelium+KeG2*ReGio2*u_glc_D_ecsBA_ecsBA+ReGee2*u_glc_D_ecsEndothelium_ecsEndothelium*u_glc_D_ecsBA_ecsBA))
        notBigg_JGlc_ecsBA2a(u_glc_D_ecsBA_ecsBA,u_glc_D_c_a) = 1*(TmaxGLCba*(u_glc_D_ecsBA_ecsBA*(KeG3+u_glc_D_c_a)-u_glc_D_c_a*(KeG3+u_glc_D_ecsBA_ecsBA))/(KeG3^2+KeG3*ReGoi3*u_glc_D_ecsBA_ecsBA+KeG3*ReGio3*u_glc_D_c_a+ReGee3*u_glc_D_ecsBA_ecsBA*u_glc_D_c_a))
        notBigg_JGlc_a2ecsAN(u_glc_D_ecsAN_ecsAN,u_glc_D_c_a) = 1*(TmaxGLCai*(u_glc_D_c_a*(KeG4+u_glc_D_ecsAN_ecsAN)-u_glc_D_ecsAN_ecsAN*(KeG4+u_glc_D_c_a))/(KeG4^2+KeG4*ReGoi4*u_glc_D_c_a+KeG4*ReGio4*u_glc_D_ecsAN_ecsAN+ReGee4*u_glc_D_c_a*u_glc_D_ecsAN_ecsAN))
        notBigg_JGlc_ecsAN2n(u_glc_D_c_n,u_glc_D_ecsAN_ecsAN) = 1*(TmaxGLCin*(u_glc_D_ecsAN_ecsAN*(KeG5+u_glc_D_c_n)-u_glc_D_c_n*(KeG5+u_glc_D_ecsAN_ecsAN))/(KeG5^2+KeG5*ReGoi5*u_glc_D_ecsAN_ecsAN+KeG5*ReGio5*u_glc_D_c_n+ReGee5*u_glc_D_ecsAN_ecsAN*u_glc_D_c_n))
        notBigg_JGlc_diffEcs(u_glc_D_ecsBA_ecsBA,u_glc_D_ecsAN_ecsAN) = 1*(kGLCdiff*(u_glc_D_ecsBA_ecsBA-u_glc_D_ecsAN_ecsAN))
        GLCS2_a(u_notBigg_GS_c_a,u_udpg_c_a) = 1*(kL2_GS_a*u_notBigg_GS_c_a*u_udpg_c_a/(kmL2_GS_a+u_udpg_c_a))
        GLCP_a(u_glycogen_c_a,u_notBigg_GPa_c_a,u_camp_c_a,u_notBigg_GPb_c_a) = 1*((u_notBigg_GPa_c_a/(u_notBigg_GPa_c_a+u_notBigg_GPb_c_a))*VmaxGP_a*u_glycogen_c_a*(1/(1+(KmGP_AMP_a^hGPa)/(u_camp_c_a^hGPa))))
        PGMT_a(u_g1p_c_a,u_g6p_c_a) = 1*((Vmaxfpglm_a*u_g1p_c_a/KmG1PPGLM_a-((Vmaxfpglm_a*KmG6PPGLM_a)/(KmG1PPGLM_a*KeqPGLM_a))*u_g6p_c_a/KmG6PPGLM_a)/(1.0+u_g1p_c_a/KmG1PPGLM_a+u_g6p_c_a/KmG6PPGLM_a))
        PDE1_a(u_camp_c_a) = 1*(VmaxPDE_a*u_camp_c_a/(Kmcamppde_a+u_camp_c_a))
        GALUi_a(u_ppi_c_a,u_g1p_c_a,u_udpg_c_a,u_utp_c_a) = 1*((VmaxfUDPGP*u_utp_c_a*u_g1p_c_a/(KutpUDPGP*Kg1pUDPGP)-VmaxrUDPGP*u_ppi_c_a*u_udpg_c_a/(KpiUDPGP*KUDPglucoUDPGP_a))/(1.0+u_g1p_c_a/Kg1pUDPGP+u_utp_c_a/KutpUDPGP+(u_g1p_c_a*u_utp_c_a)/(Kg1pUDPGP*KutpUDPGP)+u_udpg_c_a/KUDPglucoUDPGP_a+u_ppi_c_a/KpiUDPGP+(u_ppi_c_a*u_udpg_c_a)/(KpiUDPGP*KUDPglucoUDPGP_a)))
        notBigg_psiGSAJay_a(u_notBigg_GS_c_a,u_udpg_c_a,u_notBigg_PHKa_c_a,u_notBigg_PKAa_c_a) = 1*(((kg8_GSAJay*PP1_a0*(st_GSAJay-u_notBigg_GS_c_a))/((kmg8_GSAJay/(1.0+s1_GSAJay*u_udpg_c_a/kg2_GSAJay))+(st_GSAJay-u_notBigg_GS_c_a)))-((kg7_GSAJay*(u_notBigg_PHKa_c_a+u_notBigg_PKAa_c_a)*u_notBigg_GS_c_a)/(kmg7_GSAJay*(1+s1_GSAJay*u_udpg_c_a/kg2_GSAJay)+u_notBigg_GS_c_a)))
        notBigg_psiPHK_a(u_ca2_c_a,u_glycogen_c_a,u_g1p_c_a,u_notBigg_PHKa_c_a,u_notBigg_GPa_c_a,u_udpg_c_a) = 1*((u_ca2_c_a/cai0_ca_ion)*(((kg5_PHK*u_notBigg_PHKa_c_a*(pt_PHK-u_notBigg_GPa_c_a))/(kmg5_PHK*(1.0+s1_PHK*u_g1p_c_a/kg2_PHK)+(pt_PHK-u_notBigg_GPa_c_a)))-((kg6_PHK*PP1_a0*u_notBigg_GPa_c_a)/(kmg6_PHK/(1+s2_PHK*u_udpg_c_a/kgi_PHK)+u_notBigg_GPa_c_a))-((0.003198/(1+u_glycogen_c_a)+kmind_PHK)*PP1_a0*u_notBigg_GPa_c_a)))
        HEX1_n(u_glc_D_c_n,u_atp_c_n,u_g6p_c_n) = 1*((VmaxHK_n*u_glc_D_c_n/(u_glc_D_c_n+KmHK_n))*(u_atp_c_n/(1+(u_atp_c_n/KIATPhex_n)^nHhexn))*(1/(1+u_g6p_c_n/KiHKG6P_n)))
        HEX1_a(u_atp_c_a,u_g6p_c_a,u_glc_D_c_a) = 1*((VmaxHK_a*u_glc_D_c_a/(u_glc_D_c_a+KmHK_a))*(u_atp_c_a/(1+(u_atp_c_a/KIATPhex_a)^nHhexa))*(1/(1+u_g6p_c_a/KiHKG6P_a)))
        PGI_n(u_f6p_c_n,u_g6p_c_n) = 1*((Vmax_fPGI_n*(u_g6p_c_n/Km_G6P_fPGI_n-0.9*u_f6p_c_n/Km_F6P_rPGI_n))/(1.0+u_g6p_c_n/Km_G6P_fPGI_n+u_f6p_c_n/Km_F6P_rPGI_n))
        PGI_a(u_g6p_c_a,u_f6p_c_a) = 1*((Vmax_fPGI_a*(u_g6p_c_a/Km_G6P_fPGI_a-0.9*u_f6p_c_a/Km_F6P_rPGI_a))/(1.0+u_g6p_c_a/Km_G6P_fPGI_a+u_f6p_c_a/Km_F6P_rPGI_a))
        PFK_n(u_f6p_c_n,u_atp_c_n) = 1*(VmaxPFK_n*(u_atp_c_n/(1+(u_atp_c_n/KiPFK_ATP_na)^nPFKn))*(u_f6p_c_n/(u_f6p_c_n+KmPFKF6P_n)))
        PFK_a(u_atp_c_a,u_f26bp_c_a,u_f6p_c_a) = 1*(VmaxPFK_a*(u_atp_c_a/(1+(u_atp_c_a/KiPFK_ATP_a)^nPFKa))*(u_f6p_c_a/(u_f6p_c_a+KmPFKF6P_a*(1-KoPFK_f26bp_a*((u_f26bp_c_a^nPFKf26bp_a)/(KmF26BP_PFK_a^nPFKf26bp_a+u_f26bp_c_a^nPFKf26bp_a)))))*(u_f26bp_c_a/(KmF26BP_PFK_a+u_f26bp_c_a)))
        PFK26_a(u_adp_c_a,u_atp_c_a,u_f26bp_c_a,u_f6p_c_a) = 1*(Vmax_PFKII_g*u_f6p_c_a*u_atp_c_a*u_adp_c_a/((u_f6p_c_a+Kmf6pPFKII_g)*(u_atp_c_a+KmatpPFKII_g)*(u_adp_c_a+Km_act_adpPFKII_g))-(Vmax_PFKII_g*u_f26bp_c_a/(u_f26bp_c_a+Km_f26bp_f_26pase_g*(1+u_f6p_c_a/Ki_f6p_f_26_pase_g))))
        FBA_n(u_fdp_c_n,u_dhap_c_n,u_g3p_c_n) = 1*(Vmaxald_n*(u_fdp_c_n-u_g3p_c_n*u_dhap_c_n/Keqald_n)/((1+u_fdp_c_n/KmfbpAld_n)+(1+u_g3p_c_n/KmgapAld_n)*(1+u_dhap_c_n/KmdhapAld_n)-1))
        FBA_a(u_g3p_c_a,u_fdp_c_a,u_dhap_c_a) = 1*(Vmaxald_a*(u_fdp_c_a-u_g3p_c_a*u_dhap_c_a/Keqald_a)/((1+u_fdp_c_a/KmfbpAld_a)+(1+u_g3p_c_a/KmgapAld_a)*(1+u_dhap_c_a/KmdhapAld_a)-1))
        TPI_n(u_dhap_c_n,u_g3p_c_n) = 1*(Vmaxtpi_n*(u_dhap_c_n-u_g3p_c_n/Keqtpi_n)/(1+u_dhap_c_n/KmdhapTPI_n+u_g3p_c_n/KmgapTPI_n))
        TPI_a(u_g3p_c_a,u_dhap_c_a) = 1*(Vmaxtpi_a*(u_dhap_c_a-u_g3p_c_a/Keqtpi_a)/(1+u_dhap_c_a/KmdhapTPI_a+u_g3p_c_a/KmgapTPI_a))
        GAPD_n(u_nadh_c_n,u_nad_c_n,u_g3p_c_n,u_pi_c_n,u_13dpg_c_n) = 1*(Vmaxgapdh_n*(u_nad_c_n*u_g3p_c_n*u_pi_c_n-u_13dpg_c_n*u_nadh_c_n/Keqgapdh_na)/((1+u_nad_c_n/KmnadGpdh_n)*(1+u_g3p_c_n/KmGapGapdh_n)*(1+u_pi_c_n/KmpiGpdh_n)+(1+u_nadh_c_n/KmnadhGapdh_n)*(1+u_13dpg_c_n/KmBPG13Gapdh_n)-1))
        GAPD_a(u_nadh_c_a,u_nad_c_a,u_pi_c_a,u_13dpg_c_a,u_g3p_c_a) = 1*(Vmaxgapdh_a*(u_nad_c_a*u_g3p_c_a*u_pi_c_a-u_13dpg_c_a*u_nadh_c_a/Keqgapdh_na)/((1+u_nad_c_a/KmnadGpdh_a)*(1+u_g3p_c_a/KmGapGapdh_a)*(1+u_pi_c_a/KmpiGpdh_a)+(1+u_nadh_c_a/KmnadhGapdh_a)*(1+u_13dpg_c_a/KmBPG13Gapdh_a)-1))
        PGK_n(u_13dpg_c_n,u_3pg_c_n,u_atp_c_n,u_adp_c_n) = 1*(Vmaxpgk_n*(u_13dpg_c_n*u_adp_c_n-u_3pg_c_n*u_atp_c_n/Keqpgk_na)/((1+u_13dpg_c_n/Kmbpg13pgk_n)*(1+u_adp_c_n/Kmadppgk_n)+(1+u_3pg_c_n/Kmpg3pgk_n)*(1+u_atp_c_n/Kmatppgk_n)-1))
        PGK_a(u_adp_c_a,u_atp_c_a,u_3pg_c_a,u_13dpg_c_a) = 1*(Vmaxpgk_a*(u_13dpg_c_a*u_adp_c_a-u_3pg_c_a*u_atp_c_a/Keqpgk_na)/((1+u_13dpg_c_a/Kmbpg13pgk_a)*(1+u_adp_c_a/Kmadppgk_a)+(1+u_3pg_c_a/Kmpg3pgk_a)*(1+u_atp_c_a/Kmatppgk_a)-1))
        PGM_n(u_2pg_c_n,u_3pg_c_n) = 1*(Vmaxpgm_n*(u_3pg_c_n-u_2pg_c_n/Keqpgm_n)/((1+u_3pg_c_n/Kmpg3pgm_n)+(1+u_2pg_c_n/Kmpg2pgm_n)-1))
        PGM_a(u_2pg_c_a,u_3pg_c_a) = 1*(Vmaxpgm_a*(u_3pg_c_a-u_2pg_c_a/Keqpgm_a)/((1+u_3pg_c_a/Kmpg3pgm_a)+(1+u_2pg_c_a/Kmpg2pgm_a)-1))
        ENO_n(u_pep_c_n,u_2pg_c_n) = 1*(Vmaxenol_n*(u_2pg_c_n-u_pep_c_n/Keqenol_n)/((1+u_2pg_c_n/Kmpg2enol_n)+(1+u_pep_c_n/Km_pep_enol_n)-1))
        ENO_a(u_2pg_c_a,u_pep_c_a) = 1*(Vmaxenol_a*(u_2pg_c_a-u_pep_c_a/Keqenol_a)/((1+u_2pg_c_a/Kmpg2enol_a)+(1+u_pep_c_a/Km_pep_enol_a)-1))
        PYK_n(u_pep_c_n,u_atp_c_n,u_adp_c_n) = 1*(Vmaxpk_n*u_pep_c_n*u_adp_c_n/((u_pep_c_n+Km_pep_pk_n)*(u_adp_c_n+Km_adp_pk_n*(1+u_atp_c_n/Ki_ATP_pk_n))))
        PYK_a(u_adp_c_a,u_atp_c_a,u_pep_c_a) = 1*(Vmaxpk_a*u_pep_c_a*u_adp_c_a/((u_pep_c_a+Km_pep_pk_a)*(u_adp_c_a+Km_adp_pk_a*(1+u_atp_c_a/Ki_ATP_pk_a))))
        notBigg_JLacTr_b(u_lac_L_b_b,t) = 1*((2*(C_Lac_a-u_lac_L_b_b)/eto_b)*(global_par_F_0*(1+global_par_delta_F*(1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1-3))))-1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1+global_par_t_fin+3))))))))
        notBigg_MCT1_LAC_b(u_lac_L_b_b,u_lac_L_e_e) = 1*(TbLac*(u_lac_L_b_b/(u_lac_L_b_b+KbLac)-u_lac_L_e_e/(u_lac_L_e_e+KbLac)))
        L_LACt2r_a(u_lac_L_e_e,u_lac_L_c_a) = 1*(TaLac*(u_lac_L_e_e/(u_lac_L_e_e+Km_Lac_a)-u_lac_L_c_a/(u_lac_L_c_a+Km_Lac_a)))
        L_LACt2r_n(u_lac_L_e_e,u_lac_L_c_n) = 1*(TnLac*(u_lac_L_e_e/(u_lac_L_e_e+Km_LacTr_n)-u_lac_L_c_n/(u_lac_L_c_n+Km_LacTr_n)))
        notBigg_jLacDiff_e(u_lac_L_e_e) = 1*(betaLacDiff*(u0_ss[150]-u_lac_L_e_e))
        notBigg_vLACgc(u_lac_L_b_b,u_lac_L_c_a) = 1*(TMaxLACgc*(u_lac_L_b_b/(u_lac_L_b_b+KtLACgc)-u_lac_L_c_a/(u_lac_L_c_a+KtLACgc)))
        LDH_L_a(u_nad_c_a,u_nadh_c_a,u_lac_L_c_a,u_pyr_c_a) = 1*(VmfLDH_a*u_pyr_c_a*u_nadh_c_a-KeLDH_a*VmfLDH_a*u_lac_L_c_a*u_nad_c_a)
        LDH_L_n(u_nad_c_n,u_lac_L_c_n,u_nadh_c_n,u_pyr_c_n) = 1*(VmfLDH_n*u_pyr_c_n*u_nadh_c_n-KeLDH_n*VmfLDH_n*u_lac_L_c_n*u_nad_c_n)
        G6PDH2r_n(u_g6p_c_n,u_nadph_c_n,u_nadp_c_n,u_6pgl_c_n) = 1*(VmaxG6PDH_n*(1/(K_G6P_G6PDH_n*K_NADP_G6PDH_n))*((u_g6p_c_n*u_nadp_c_n-u_6pgl_c_n*u_nadph_c_n/KeqG6PDH_n)/((1+u_g6p_c_n/K_G6P_G6PDH_n)*(1+u_nadp_c_n/K_NADP_G6PDH_n)+(1+u_6pgl_c_n/K_GL6P_G6PDH_n)*(1+u_nadph_c_n/K_NADPH_G6PDH_n)-1)))
        G6PDH2r_a(u_6pgl_c_a,u_nadp_c_a,u_g6p_c_a,u_nadph_c_a) = 1*(VmaxG6PDH_a*(1/(K_G6P_G6PDH_a*K_NADP_G6PDH_a))*((u_g6p_c_a*u_nadp_c_a-u_6pgl_c_a*u_nadph_c_a/KeqG6PDH_a)/((1+u_g6p_c_a/K_G6P_G6PDH_a)*(1+u_nadp_c_a/K_NADP_G6PDH_a)+(1+u_6pgl_c_a/K_GL6P_G6PDH_a)*(1+u_nadph_c_a/K_NADPH_G6PDH_a)-1)))
        PGL_n(u_6pgc_c_n,u_6pgl_c_n) = 1*(Vmax6PGL_n*(1/K_GL6P_6PGL_n)*((u_6pgl_c_n-u_6pgc_c_n/Keq6PGL_n)/((1+u_6pgl_c_n/K_GL6P_6PGL_n)+(1+u_6pgc_c_n/K_GO6P_6PGL_n)-1)))
        PGL_a(u_6pgc_c_a,u_6pgl_c_a) = 1*(Vmax6PGL_a*(1/K_GL6P_6PGL_a)*((u_6pgl_c_a-u_6pgc_c_a/Keq6PGL_a)/((1+u_6pgl_c_a/K_GL6P_6PGL_a)+(1+u_6pgc_c_a/K_GO6P_6PGL_a)-1)))
        GND_n(u_6pgc_c_n,u_nadph_c_n,u_nadp_c_n,u_ru5p_D_c_n) = 1*(Vmax6PGDH_n*(1/(K_GO6P_6PGDH_n*K_NADP_6PGDH_n))*(u_6pgc_c_n*u_nadp_c_n-u_ru5p_D_c_n*u_nadph_c_n/Keq6PGDH_n)/((1+u_6pgc_c_n/K_GO6P_6PGDH_n)*(1+u_nadp_c_n/K_NADP_6PGDH_n)+(1+u_ru5p_D_c_n/K_RU5P_6PGDH_n)*(1+u_nadph_c_n/K_NADPH_6PGDH_n)-1))
        GND_a(u_6pgc_c_a,u_nadp_c_a,u_ru5p_D_c_a,u_nadph_c_a) = 1*(Vmax6PGDH_a*(1/(K_GO6P_6PGDH_a*K_NADP_6PGDH_a))*(u_6pgc_c_a*u_nadp_c_a-u_ru5p_D_c_a*u_nadph_c_a/Keq6PGDH_a)/((1+u_6pgc_c_a/K_GO6P_6PGDH_a)*(1+u_nadp_c_a/K_NADP_6PGDH_a)+(1+u_ru5p_D_c_a/K_RU5P_6PGDH_a)*(1+u_nadph_c_a/K_NADPH_6PGDH_a)-1))
        RPI_n(u_r5p_c_n,u_ru5p_D_c_n) = 1*(VmaxRPI_n*(1/K_RU5P_RPI_n)*(u_ru5p_D_c_n-u_r5p_c_n/KeqRPI_n)/((1+u_ru5p_D_c_n/K_RU5P_RPI_n)+(1+u_r5p_c_n/K_R5P_RPI_n)-1))
        RPI_a(u_r5p_c_a,u_ru5p_D_c_a) = 1*(VmaxRPI_a*(1/K_RU5P_RPI_a)*(u_ru5p_D_c_a-u_r5p_c_a/KeqRPI_a)/((1+u_ru5p_D_c_a/K_RU5P_RPI_a)+(1+u_r5p_c_a/K_R5P_RPI_a)-1))
        RPE_n(u_xu5p_D_c_n,u_ru5p_D_c_n) = 1*(VmaxRPE_n*(1/K_RU5P_RPE_n)*(u_ru5p_D_c_n-u_xu5p_D_c_n/KeqRPE_n)/((1+u_ru5p_D_c_n/K_RU5P_RPE_n)+(1+u_xu5p_D_c_n/K_X5P_RPE_n)-1))
        RPE_a(u_ru5p_D_c_a,u_xu5p_D_c_a) = 1*(VmaxRPE_a*(1/K_RU5P_RPE_a)*(u_ru5p_D_c_a-u_xu5p_D_c_a/KeqRPE_a)/((1+u_ru5p_D_c_a/K_RU5P_RPE_a)+(1+u_xu5p_D_c_a/K_X5P_RPE_a)-1))
        TKT1_n(u_s7p_c_n,u_r5p_c_n,u_xu5p_D_c_n,u_g3p_c_n) = 1*(VmaxTKL1_n*(1/(K_X5P_TKL1_n*K_R5P_TKL1_n))*(u_xu5p_D_c_n*u_r5p_c_n-u_g3p_c_n*u_s7p_c_n/KeqTKL1_n)/((1+u_xu5p_D_c_n/K_X5P_TKL1_n)*(1+u_r5p_c_n/K_R5P_TKL1_n)+(1+u_g3p_c_n/K_GAP_TKL1_n)*(1+u_s7p_c_n/K_S7P_TKL1_n)-1))
        TKT1_a(u_r5p_c_a,u_g3p_c_a,u_s7p_c_a,u_xu5p_D_c_a) = 1*(VmaxTKL1_a*(1/(K_X5P_TKL1_a*K_R5P_TKL1_a))*(u_xu5p_D_c_a*u_r5p_c_a-u_g3p_c_a*u_s7p_c_a/KeqTKL1_a)/((1+u_xu5p_D_c_a/K_X5P_TKL1_a)*(1+u_r5p_c_a/K_R5P_TKL1_a)+(1+u_g3p_c_a/K_GAP_TKL1_a)*(1+u_s7p_c_a/K_S7P_TKL1_a)-1))
        TKT2_n(u_f6p_c_n,u_e4p_c_n,u_xu5p_D_c_n,u_g3p_c_n) = 1*(VmaxTKL2_n*(1/(K_F6P_TKL2_n*K_GAP_TKL2_n))*(u_f6p_c_n*u_g3p_c_n-u_xu5p_D_c_n*u_e4p_c_n/KeqTKL2_n)/((1+u_f6p_c_n/K_F6P_TKL2_n)*(1+u_g3p_c_n/K_GAP_TKL2_n)+(1+u_xu5p_D_c_n/K_X5P_TKL2_n)*(1+u_e4p_c_n/K_E4P_TKL2_n)-1))
        TKT2_a(u_g3p_c_a,u_e4p_c_a,u_xu5p_D_c_a,u_f6p_c_a) = 1*(VmaxTKL2_a*(1/(K_F6P_TKL2_a*K_GAP_TKL2_a))*(u_f6p_c_a*u_g3p_c_a-u_xu5p_D_c_a*u_e4p_c_a/KeqTKL2_a)/((1+u_f6p_c_a/K_F6P_TKL2_a)*(1+u_g3p_c_a/K_GAP_TKL2_a)+(1+u_xu5p_D_c_a/K_X5P_TKL2_a)*(1+u_e4p_c_a/K_E4P_TKL2_a)-1))
        TALA_n(u_f6p_c_n,u_e4p_c_n,u_g3p_c_n,u_s7p_c_n) = 1*(VmaxTAL_n*(1/(K_GAP_TAL_n*K_S7P_TAL_n))*(u_g3p_c_n*u_s7p_c_n-u_f6p_c_n*u_e4p_c_n/KeqTAL_n)/((1+u_g3p_c_n/K_GAP_TAL_n)*(1+u_s7p_c_n/K_S7P_TAL_n)+(1+u_f6p_c_n/K_F6P_TAL_n)*(1+u_e4p_c_n/K_E4P_TAL_n)-1))
        TALA_a(u_g3p_c_a,u_e4p_c_a,u_s7p_c_a,u_f6p_c_a) = 1*(VmaxTAL_a*(1/(K_GAP_TAL_a*K_S7P_TAL_a))*(u_g3p_c_a*u_s7p_c_a-u_f6p_c_a*u_e4p_c_a/KeqTAL_a)/((1+u_g3p_c_a/K_GAP_TAL_a)*(1+u_s7p_c_a/K_S7P_TAL_a)+(1+u_f6p_c_a/K_F6P_TAL_a)*(1+u_e4p_c_a/K_E4P_TAL_a)-1))
        notBigg_psiNADPHox_n(u_nadph_c_n) = 1*(k1NADPHox_n*u_nadph_c_n)
        notBigg_psiNADPHox_a(u_nadph_c_a) = 1*(k1NADPHox_a*u_nadph_c_a)
        GTHO_n(u_nadph_c_n,u_gthox_c_n) = 1*((Vmf_GSSGR_n*u_gthox_c_n*u_nadph_c_n)/((KmGSSGRGSSG_n+u_gthox_c_n)*(KmGSSGRNADPH_n+u_nadph_c_n)))
        GTHO_a(u_gthox_c_a,u_nadph_c_a) = 1*((Vmf_GSSGR_a*u_gthox_c_a*u_nadph_c_a)/((KmGSSGRGSSG_a+u_gthox_c_a)*(KmGSSGRNADPH_a+u_nadph_c_a)))
        GTHP_n(u_gthrd_c_n) = 1*(V_GPX_n*u_gthrd_c_n/(u_gthrd_c_n+KmGPXGSH_n))
        GTHP_a(u_gthrd_c_a) = 1*(V_GPX_a*u_gthrd_c_a/(u_gthrd_c_a+KmGPXGSH_a))
        GTHS_n(u_gthrd_c_n) = 1*(VmaxGSHsyn_n*(glycine_n*glutamylCys_n-u_gthrd_c_n/KeGSHSyn_n)/(Km_glutamylCys_GSHsyn_n*Km_glycine_GSHsyn_n+glutamylCys_n*Km_glutamylCys_GSHsyn_n+glycine_n*Km_glycine_GSHsyn_n*(1+glutamylCys_n/Km_glutamylCys_GSHsyn_n)+u_gthrd_c_n/KmGSHsyn_n))
        GTHS_a(u_gthrd_c_a) = 1*(VmaxGSHsyn_a*(glycine_a*glutamylCys_a-u_gthrd_c_a/KeGSHSyn_a)/(Km_glutamylCys_GSHsyn_a*Km_glycine_GSHsyn_a+glutamylCys_a*Km_glutamylCys_GSHsyn_a+glycine_a*Km_glycine_GSHsyn_a*(1+glutamylCys_a/Km_glutamylCys_GSHsyn_a)+u_gthrd_c_a/KmGSHsyn_a))
        ADNCYC_a(u_camp_c_a,u_atp_c_a) = 1*(((VmaxfAC_a*u_atp_c_a/(KmACATP_a*(1+u_camp_c_a/KicAMPAC_a))-VmaxrAC_a*u_camp_c_a/(KmpiAC_a*KmcAMPAC_a))/(1+u_atp_c_a/(KmACATP_a*(1+u_camp_c_a/KicAMPAC_a))+u_camp_c_a/KmcAMPAC_a)))
        CKc_n(u_pcreat_c_n,u_atp_c_n,u_adp_c_n) = 1*(kCKnps*u_pcreat_c_n*u_adp_c_n-KeqCKnpms*kCKnps*(Crtot-u_pcreat_c_n)*u_atp_c_n)
        CKc_a(u_adp_c_a,u_atp_c_a,u_pcreat_c_a) = 1*(kCKgps*u_pcreat_c_a*u_adp_c_a-KeqCKgpms*kCKgps*(Crtot-u_pcreat_c_a)*u_atp_c_a)
        PYRt2m_n(u_h_m_n,u_pyr_m_n,u_h_c_n,u_pyr_c_n) = 1*(Vmax_PYRtrcyt2mito_nH*(u_pyr_c_n*u_h_c_n-u_pyr_m_n*u_h_m_n)/((1.0+u_pyr_c_n/KmPyrCytTr_n)*(1.0+u_pyr_m_n/KmPyrMitoTr_n)))
        PYRt2m_a(u_h_m_a,u_pyr_c_a,u_h_c_a,u_pyr_m_a) = 1*(Vmax_PYRtrcyt2mito_aH*(u_pyr_c_a*u_h_c_a-u_pyr_m_a*u_h_m_a)/((1.0+u_pyr_c_a/KmPyrCytTr_a)*(1.0+u_pyr_m_a/KmPyrMitoTr_a)))
        notBigg_vShuttlen(u_nadh_m_n,u_nadh_c_n) = 1*(TnNADH_jlv*(u_nadh_c_n/(0.212-u_nadh_c_n))/(MnCyto_jlv+(u_nadh_c_n/(0.212-u_nadh_c_n)))*((1000*NADtot-u_nadh_m_n)/u_nadh_m_n)/(MnMito_jlv+((1000*NADtot-u_nadh_m_n)/u_nadh_m_n)))
        notBigg_vShuttleg(u_nadh_c_a,u_nadh_m_a) = 1*(TgNADH_jlv*(u_nadh_c_a/(0.212-u_nadh_c_a))/(MgCyto_jlv+(u_nadh_c_a/(0.212-u_nadh_c_a)))*((1000*NADtot-u_nadh_m_a)/u_nadh_m_a)/(MgMito_jlv+((1000*NADtot-u_nadh_m_a)/u_nadh_m_a)))
        notBigg_vMitooutn_n(u_nadh_m_n,u_nad_m_n,u_o2_c_n,u_adp_i_n,u_atp_i_n) = 1*(V_oxphos_n*((1/(u_atp_i_n/u_adp_i_n))/(mu_oxphos_n+(1/(u_atp_i_n/u_adp_i_n))))*((u_nadh_m_n/u_nad_m_n)/(nu_oxphos_n+(u_nadh_m_n/u_nad_m_n)))*(u_o2_c_n/(u_o2_c_n+K_oxphos_n)))
        notBigg_vMitooutg_a(u_atp_i_a,u_nadh_m_a,u_nad_m_a,u_o2_c_a,u_adp_i_a) = 1*(V_oxphos_a*((1/(u_atp_i_a/u_adp_i_a))/(mu_oxphos_a+(1/(u_atp_i_a/u_adp_i_a))))*((u_nadh_m_a/u_nad_m_a)/(nu_oxphos_a+(u_nadh_m_a/u_nad_m_a)))*(u_o2_c_a/(u_o2_c_a+K_oxphos_a)))
        notBigg_vMitoinn(u_pyr_m_n,u_nadh_m_n) = 1*(VMaxMitoinn*u_pyr_m_n/(u_pyr_m_n+KmMito)*(1000*NADtot-u_nadh_m_n)/(1000*NADtot-u_nadh_m_n+KmNADn_jlv))
        notBigg_vMitoing(u_nadh_m_a,u_pyr_m_a) = 1*(VMaxMitoing*u_pyr_m_a/(u_pyr_m_a+KmMito_a)*(1000*NADtot-u_nadh_m_a)/(1000*NADtot-u_nadh_m_a+KmNADg_jlv))
        du[1] = 0
        du[2] = 0.5*T2Jcorrection*(1000*(notBigg_J_KH_n(u_h_m_n,u_h_i_n,u_k_m_n)+notBigg_J_K_n(u_k_m_n,u_notBigg_MitoMembrPotent_m_n))/W_x)
        du[3] = 0.5*T2Jcorrection*(1000*(-notBigg_J_MgATPx_n(u_notBigg_ATP_mx_m_n,u_mg2_m_n)-notBigg_J_MgADPx_n(u_mg2_m_n,u_notBigg_ADP_mx_m_n))/W_x)
        du[4] = 6.96*(notBigg_vMitoinn(u_pyr_m_n,u_nadh_m_n)+notBigg_vShuttlen(u_nadh_m_n,u_nadh_c_n)-notBigg_vMitooutn_n(u_nadh_m_n,u_nad_m_n,u_o2_c_n,u_adp_i_n,u_atp_i_n))
        du[5] = 0.5*T2Jcorrection*(1000*(+NADH2_u10mi_n(u_nadh_m_n,u_q10h2_m_n)-CYOR_u10mi_n(u_focytC_m_n,u_notBigg_MitoMembrPotent_m_n,u_q10h2_m_n,u_pi_m_n))/W_x)
        du[6] = 0.5*T2Jcorrection*(1000*(+2*CYOR_u10mi_n(u_focytC_m_n,u_notBigg_MitoMembrPotent_m_n,u_q10h2_m_n,u_pi_m_n)-2*CYOOm2i_n(u_focytC_m_n,u_notBigg_MitoMembrPotent_m_n,u_notBigg_Ctot_m_n,u_o2_c_n))/W_i)
        du[7] = notBigg_JO2fromCap2n(u_o2_b_b,u_o2_c_n)-0.6*notBigg_vMitooutn_n(u_nadh_m_n,u_nad_m_n,u_o2_c_n,u_adp_i_n,u_atp_i_n)
        du[8] = 0.5*T2Jcorrection*(1000*(+ATPS4mi_n(u_notBigg_ATP_mx_m_n,u_notBigg_ADP_mx_m_n,u_pi_m_n)-ATPtm_n(u_notBigg_MitoMembrPotent_m_n))/W_x)
        du[9] = 0.5*T2Jcorrection*(1000*(-ATPS4mi_n(u_notBigg_ATP_mx_m_n,u_notBigg_ADP_mx_m_n,u_pi_m_n)+ATPtm_n(u_notBigg_MitoMembrPotent_m_n))/W_x)
        du[10] = 0.5*T2Jcorrection*(1000*(notBigg_J_MgATPx_n(u_notBigg_ATP_mx_m_n,u_mg2_m_n))/W_x)
        du[11] = 0.5*T2Jcorrection*(1000*(notBigg_J_MgADPx_n(u_mg2_m_n,u_notBigg_ADP_mx_m_n))/W_x)
        du[12] = 0.5*T2Jcorrection*(1000*(-ATPS4mi_n(u_notBigg_ATP_mx_m_n,u_notBigg_ADP_mx_m_n,u_pi_m_n)+notBigg_J_Pi1_n(u_h_m_n,u_h_i_n))/W_x)
        du[13] = 0.5*T2Jcorrection*(1000*(+notBigg_J_ATP_n(u_atp_c_n,u_atp_i_n)+ATPtm_n(u_notBigg_MitoMembrPotent_m_n)+ADK1m_n(u_amp_i_n,u_atp_i_n,u_adp_i_n))/W_i)
        du[14] = 0.5*T2Jcorrection*(1000*(+notBigg_J_ADP_n(u_adp_i_n,u_adp_c_n)-ATPtm_n(u_notBigg_MitoMembrPotent_m_n)-2*ADK1m_n(u_amp_i_n,u_atp_i_n,u_adp_i_n))/W_i)
        du[15] = 0.5*T2Jcorrection*(1000*(+notBigg_J_AMP_n(u_amp_i_n,u_amp_c_n)+ADK1m_n(u_amp_i_n,u_atp_i_n,u_adp_i_n))/W_i)
        du[16] = 0.5*T2Jcorrection*(1000*(notBigg_J_MgATPi_n(u_notBigg_ATP_mi_i_n))/W_i)
        du[17] = 0.5*T2Jcorrection*(1000*(notBigg_J_MgADPi_n(u_notBigg_ADP_mi_i_n))/W_i)
        du[18] = 0.5*T2Jcorrection*(1000*(-notBigg_J_Pi1_n(u_h_m_n,u_h_i_n)+notBigg_J_Pi2_n(u_pi_i_n,u_pi_c_n))/W_i)
        du[19] = 0.5*T2Jcorrection*(4*NADH2_u10mi_n(u_nadh_m_n,u_q10h2_m_n)+2*CYOR_u10mi_n(u_focytC_m_n,u_notBigg_MitoMembrPotent_m_n,u_q10h2_m_n,u_pi_m_n)+4*CYOOm2i_n(u_focytC_m_n,u_notBigg_MitoMembrPotent_m_n,u_notBigg_Ctot_m_n,u_o2_c_n)-n_A*ATPS4mi_n(u_notBigg_ATP_mx_m_n,u_notBigg_ADP_mx_m_n,u_pi_m_n)-ATPtm_n(u_notBigg_MitoMembrPotent_m_n)-notBigg_J_Hle_n(u_h_m_n,u_h_i_n,u_notBigg_MitoMembrPotent_m_n)-notBigg_J_K_n(u_k_m_n,u_notBigg_MitoMembrPotent_m_n))/CIM
        du[20] = 0
        du[21] = 0
        du[22] = 0
        du[23] = (CKc_n(u_pcreat_c_n,u_atp_c_n,u_adp_c_n)+0.5*(1/6.96)*1000*(-notBigg_J_ATP_n(u_atp_c_n,u_atp_i_n))-HEX1_n(u_glc_D_c_n,u_atp_c_n,u_g6p_c_n)-PFK_n(u_f6p_c_n,u_atp_c_n)+PGK_n(u_13dpg_c_n,u_3pg_c_n,u_atp_c_n,u_adp_c_n)+PYK_n(u_pep_c_n,u_atp_c_n,u_adp_c_n)-0.15*vPumpn-vATPasesn)/(1-dAMPdATPn)
        du[24] = 0
        du[25] = T2Jcorrection*(0.5*1000*r0509_n(u_nadh_m_n,u_pi_m_n)/W_x-FUMm_n(u_fum_m_n,u_mal_L_m_n))
        du[26] = T2Jcorrection*(FUMm_n(u_fum_m_n,u_mal_L_m_n)-MDHm_n(u_nadh_m_n,u_oaa_m_n,u_nad_m_n,u_mal_L_m_n))+6.96*AKGMALtm_n(u_mal_L_c_n,u_akg_m_n,u_akg_c_n,u_mal_L_m_n)

        du[27] = T2Jcorrection*(MDHm_n(u_nadh_m_n,u_oaa_m_n,u_nad_m_n,u_mal_L_m_n)-CSm_n(u_accoa_m_n,u_oaa_m_n,u_cit_m_n,u_coa_m_n) + PCm_n(u_co2_m_n,u_oaa_m_n,u_pyr_m_n,u_atp_m_n,u_adp_m_n)) +ASPTAm_n(u_oaa_m_n,u_akg_m_n,u_glu_L_m_n,u_asp_L_m_n)

        du[28] = T2Jcorrection*(0.5*SUCOASm_n(u_coa_m_n,u_succ_m_n,u_pi_m_n,u_adp_m_n,u_succoa_m_n,u_atp_m_n)-0.5*1000*r0509_n(u_nadh_m_n,u_pi_m_n)/W_x)+0.5*T2Jcorrection*OCOAT1m_n(u_acac_c_n,u_aacoa_m_n,u_succoa_m_n,u_succ_m_n)
        du[29] = 0.5*T2Jcorrection*(AKGDm_n(u_coa_m_n,u_nadh_m_n,u_ca2_m_n,u_adp_m_n,u_succoa_m_n,u_nad_m_n,u_atp_m_n,u_akg_m_n)-SUCOASm_n(u_coa_m_n,u_succ_m_n,u_pi_m_n,u_adp_m_n,u_succoa_m_n,u_atp_m_n))-0.5*T2Jcorrection*OCOAT1m_n(u_acac_c_n,u_aacoa_m_n,u_succoa_m_n,u_succ_m_n)
        du[30] = T2Jcorrection*(CSm_n(u_accoa_m_n,u_oaa_m_n,u_cit_m_n,u_coa_m_n)-PDHm_n(u_pyr_m_n,u_coa_m_n,u_nad_m_n)-0.5*AKGDm_n(u_coa_m_n,u_nadh_m_n,u_ca2_m_n,u_adp_m_n,u_succoa_m_n,u_nad_m_n,u_atp_m_n,u_akg_m_n)+0.5*SUCOASm_n(u_coa_m_n,u_succ_m_n,u_pi_m_n,u_adp_m_n,u_succoa_m_n,u_atp_m_n)-0.5*ACACT1rm_n(u_aacoa_m_n,u_coa_m_n))
        du[31] = 0.5*T2Jcorrection*(ICDHxm_n(u_nadh_m_n,u_icit_m_n,u_nad_m_n)-AKGDm_n(u_coa_m_n,u_nadh_m_n,u_ca2_m_n,u_adp_m_n,u_succoa_m_n,u_nad_m_n,u_atp_m_n,u_akg_m_n))-ASPTAm_n(u_oaa_m_n,u_akg_m_n,u_glu_L_m_n,u_asp_L_m_n)-AKGMALtm_n(u_mal_L_c_n,u_akg_m_n,u_akg_c_n,u_mal_L_m_n)
        du[32] = 0
        du[33] = 0.5*T2Jcorrection*(ACONTm_n(u_icit_m_n,u_cit_m_n)-ICDHxm_n(u_nadh_m_n,u_icit_m_n,u_nad_m_n))
        du[34] = T2Jcorrection*(CSm_n(u_accoa_m_n,u_oaa_m_n,u_cit_m_n,u_coa_m_n)-0.5*ACONTm_n(u_icit_m_n,u_cit_m_n))
        du[35] = T2Jcorrection*(PDHm_n(u_pyr_m_n,u_coa_m_n,u_nad_m_n)-CSm_n(u_accoa_m_n,u_oaa_m_n,u_cit_m_n,u_coa_m_n))+T2Jcorrection*ACACT1rm_n(u_aacoa_m_n,u_coa_m_n)
        du[36] = 0.5*T2Jcorrection*(BDHm_n(u_acac_c_n,u_bhb_c_n,u_nadh_m_n,u_nad_m_n)-OCOAT1m_n(u_acac_c_n,u_aacoa_m_n,u_succoa_m_n,u_succ_m_n))
        du[37] = 0.5*T2Jcorrection*(OCOAT1m_n(u_acac_c_n,u_aacoa_m_n,u_succoa_m_n,u_succ_m_n)-ACACT1rm_n(u_aacoa_m_n,u_coa_m_n))

        du[38] = 6.96*PYRt2m_n(u_h_m_n,u_pyr_m_n,u_h_c_n,u_pyr_c_n)-T2Jcorrection*(PDHm_n(u_pyr_m_n,u_coa_m_n,u_nad_m_n) + PCm_n(u_co2_m_n,u_oaa_m_n,u_pyr_m_n,u_atp_m_n,u_adp_m_n))

        du[39] = 0.44*BHBt_n(u_bhb_c_n,u_bhb_e_e)-BDHm_n(u_acac_c_n,u_bhb_c_n,u_nadh_m_n,u_nad_m_n)
        du[40] = 0.0275*notBigg_MCT1_bHB_b(u_bhb_e_e,u_bhb_b_b)-BHBt_n(u_bhb_c_n,u_bhb_e_e)-BHBt_a(u_bhb_c_a,u_bhb_e_e)
        du[41] = 0 #0.8*BHBt_a(u_bhb_e_e,u_bhb_c_a) - BDHm_a(u_bhb_c_a,u_acac_c_a,u_nad_m_a,u_nadh_m_a) # 0
        du[42] = notBigg_JbHBTrArtCap(t,u_bhb_b_b)-notBigg_MCT1_bHB_b(u_bhb_e_e,u_bhb_b_b)
        du[43] = 0
        du[44] = 0
        du[45] = 0.5*T2Jcorrection*(ASPTAm_n(u_oaa_m_n,u_akg_m_n,u_glu_L_m_n,u_asp_L_m_n)+6.96*ASPGLUm_n(u_h_c_n,u_glu_L_c_n,u_asp_L_m_n,u_asp_L_c_n,u_notBigg_MitoMembrPotent_m_n,u_glu_L_m_n,u_h_m_n)+GLUNm_n(u_gln_L_c_n,u_glu_L_m_n))
        du[46] = 0
        du[47] = 0
        du[48] = 0
        du[49] = ASPTA_n(u_glu_L_c_n,u_asp_L_c_n,u_oaa_c_n,u_akg_c_n)-ASPGLUm_n(u_h_c_n,u_glu_L_c_n,u_asp_L_m_n,u_asp_L_c_n,u_notBigg_MitoMembrPotent_m_n,u_glu_L_m_n,u_h_m_n)
        du[50] = GAPD_n(u_nadh_c_n,u_nad_c_n,u_g3p_c_n,u_pi_c_n,u_13dpg_c_n)-LDH_L_n(u_nad_c_n,u_lac_L_c_n,u_nadh_c_n,u_pyr_c_n)-notBigg_vShuttlen(u_nadh_m_n,u_nadh_c_n)
        du[51] = 0
        du[52] = 0.5*T2Jcorrection*(1000*(notBigg_J_KH_a(u_h_i_a,u_h_m_a,u_k_m_a)+notBigg_J_K_a(u_k_m_a,u_notBigg_MitoMembrPotent_m_a))/W_x)
        du[53] = 0.5*T2Jcorrection*(1000*(-notBigg_J_MgATPx_a(u_notBigg_ATP_mx_m_a,u_mg2_m_a)-notBigg_J_MgADPx_a(u_notBigg_ADP_mx_m_a,u_mg2_m_a))/W_x)
        du[54] = 6.96*(notBigg_vMitoing(u_nadh_m_a,u_pyr_m_a)+notBigg_vShuttleg(u_nadh_c_a,u_nadh_m_a)-notBigg_vMitooutg_a(u_atp_i_a,u_nadh_m_a,u_nad_m_a,u_o2_c_a,u_adp_i_a))
        du[55] = 0.5*T2Jcorrection*(1000*(+NADH2_u10mi_a(u_nadh_m_a,u_q10h2_m_a)-CYOR_u10mi_a(u_focytC_m_a,u_q10h2_m_a,u_pi_m_a,u_notBigg_MitoMembrPotent_m_a))/W_x)
        du[56] = 0.5*T2Jcorrection*(1000*(+2*CYOR_u10mi_a(u_focytC_m_a,u_q10h2_m_a,u_pi_m_a,u_notBigg_MitoMembrPotent_m_a)-2*CYOOm2i_a(u_notBigg_Ctot_m_a,u_focytC_m_a,u_notBigg_MitoMembrPotent_m_a,u_o2_c_a))/W_i)
        du[57] = notBigg_JO2fromCap2a(u_o2_b_b,u_o2_c_a)-0.6*notBigg_vMitooutg_a(u_atp_i_a,u_nadh_m_a,u_nad_m_a,u_o2_c_a,u_adp_i_a)
        du[58] = 0.5*T2Jcorrection*(1000*(+ATPS4mi_a(u_notBigg_ATP_mx_m_a,u_pi_m_a,u_notBigg_ADP_mx_m_a)-ATPtm_a(u_notBigg_MitoMembrPotent_m_a))/W_x)
        du[59] = 0.5*T2Jcorrection*(1000*(-ATPS4mi_a(u_notBigg_ATP_mx_m_a,u_pi_m_a,u_notBigg_ADP_mx_m_a)+ATPtm_a(u_notBigg_MitoMembrPotent_m_a))/W_x)
        du[60] = 0.5*T2Jcorrection*(1000*(notBigg_J_MgATPx_a(u_notBigg_ATP_mx_m_a,u_mg2_m_a))/W_x)
        du[61] = 0.5*T2Jcorrection*(1000*(notBigg_J_MgADPx_a(u_notBigg_ADP_mx_m_a,u_mg2_m_a))/W_x)
        du[62] = 0.5*T2Jcorrection*(1000*(-ATPS4mi_a(u_notBigg_ATP_mx_m_a,u_pi_m_a,u_notBigg_ADP_mx_m_a)+notBigg_J_Pi1_a(u_h_i_a,u_h_m_a))/W_x)
        du[63] = 0.5*T2Jcorrection*(1000*(+notBigg_J_ATP_a(u_atp_i_a,u_atp_c_a)+ATPtm_a(u_notBigg_MitoMembrPotent_m_a)+ADK1m_a(u_atp_i_a,u_adp_i_a,u_amp_i_a))/W_i)
        du[64] = 0.5*T2Jcorrection*(1000*(+notBigg_J_ADP_a(u_adp_c_a,u_adp_i_a)-ATPtm_a(u_notBigg_MitoMembrPotent_m_a)-2*ADK1m_a(u_atp_i_a,u_adp_i_a,u_amp_i_a))/W_i)
        du[65] = 0.5*T2Jcorrection*(1000*(+notBigg_J_AMP_a(u_amp_i_a,u_amp_c_a)+ADK1m_a(u_atp_i_a,u_adp_i_a,u_amp_i_a))/W_i)
        du[66] = 0.5*T2Jcorrection*(1000*(notBigg_J_MgATPi_a(u_notBigg_ATP_mi_i_a))/W_i)
        du[67] = 0.5*T2Jcorrection*(1000*(notBigg_J_MgADPi_a(u_notBigg_ADP_mi_i_a))/W_i)
        du[68] = 0.5*T2Jcorrection*(1000*(-notBigg_J_Pi1_a(u_h_i_a,u_h_m_a)+notBigg_J_Pi2_a(u_pi_i_a,u_pi_c_a))/W_i)
        du[69] = 0.5*T2Jcorrection*((4*NADH2_u10mi_a(u_nadh_m_a,u_q10h2_m_a)+2*CYOR_u10mi_a(u_focytC_m_a,u_q10h2_m_a,u_pi_m_a,u_notBigg_MitoMembrPotent_m_a)+4*CYOOm2i_a(u_notBigg_Ctot_m_a,u_focytC_m_a,u_notBigg_MitoMembrPotent_m_a,u_o2_c_a)-n_A*ATPS4mi_a(u_notBigg_ATP_mx_m_a,u_pi_m_a,u_notBigg_ADP_mx_m_a)-ATPtm_a(u_notBigg_MitoMembrPotent_m_a)-notBigg_J_Hle_a(u_h_i_a,u_h_m_a,u_notBigg_MitoMembrPotent_m_a)-notBigg_J_K_a(u_k_m_a,u_notBigg_MitoMembrPotent_m_a))/CIM)
        du[70] = 0
        du[71] = 0
        du[72] = 0
        du[73] = (-(u_ca2_c_a/cai0_ca_ion)*(1+xNEmod*(u[178]/(KdNEmod+u[178])))*ADNCYC_a(u_camp_c_a,u_atp_c_a)+CKc_a(u_adp_c_a,u_atp_c_a,u_pcreat_c_a)+0.5*(1/6.96)*1000*(-notBigg_J_ATP_a(u_atp_i_a,u_atp_c_a))-HEX1_a(u_atp_c_a,u_g6p_c_a,u_glc_D_c_a)-PFK_a(u_atp_c_a,u_f26bp_c_a,u_f6p_c_a)-PFK26_a(u_adp_c_a,u_atp_c_a,u_f26bp_c_a,u_f6p_c_a)+PGK_a(u_adp_c_a,u_atp_c_a,u_3pg_c_a,u_13dpg_c_a)+PYK_a(u_adp_c_a,u_atp_c_a,u_pep_c_a)-0.15*(7/4)*vPumpg-vATPasesg)/(1-dAMPdATPg)
        du[74] = 0
        du[75] = 0.5*T2Jcorrection*(1000*r0509_a(u_nadh_m_a,u_pi_m_a)/W_x-FUMm_a(u_mal_L_m_a,u_fum_m_a))
        du[76] = 0.5*T2Jcorrection*(FUMm_a(u_mal_L_m_a,u_fum_m_a)-MDHm_a(u_nad_m_a,u_oaa_m_a,u_mal_L_m_a,u_nadh_m_a))
        du[77] = 0.5*T2Jcorrection*(MDHm_a(u_nad_m_a,u_oaa_m_a,u_mal_L_m_a,u_nadh_m_a)-CSm_a(u_oaa_m_a,u_cit_m_a,u_accoa_m_a,u_coa_m_a)+PCm_a(u_co2_m_a,u_oaa_m_a,u_pyr_m_a,u_atp_m_a,u_adp_m_a))
        du[78] = 0.5*T2Jcorrection*(SUCOASm_a(u_coa_m_a,u_succoa_m_a,u_atp_m_a,u_succ_m_a,u_pi_m_a,u_adp_m_a)-1000*r0509_a(u_nadh_m_a,u_pi_m_a)/W_x)
        du[79] = 0.5*T2Jcorrection*(AKGDm_a(u_coa_m_a,u_nadh_m_a,u_akg_m_a,u_ca2_m_a,u_nad_m_a,u_succoa_m_a,u_atp_m_a,u_adp_m_a)-SUCOASm_a(u_coa_m_a,u_succoa_m_a,u_atp_m_a,u_succ_m_a,u_pi_m_a,u_adp_m_a))
        du[80] = 0.5*T2Jcorrection*(CSm_a(u_oaa_m_a,u_cit_m_a,u_accoa_m_a,u_coa_m_a)-PDHm_a(u_nad_m_a,u_pyr_m_a,u_coa_m_a)-AKGDm_a(u_coa_m_a,u_nadh_m_a,u_akg_m_a,u_ca2_m_a,u_nad_m_a,u_succoa_m_a,u_atp_m_a,u_adp_m_a)+SUCOASm_a(u_coa_m_a,u_succoa_m_a,u_atp_m_a,u_succ_m_a,u_pi_m_a,u_adp_m_a))
        du[81] = 0.5*T2Jcorrection*(ICDHxm_a(u_nad_m_a,u_nadh_m_a,u_icit_m_a)-AKGDm_a(u_coa_m_a,u_nadh_m_a,u_akg_m_a,u_ca2_m_a,u_nad_m_a,u_succoa_m_a,u_atp_m_a,u_adp_m_a)+GLUDxm_a(u_nad_m_a,u_nadh_m_a,u_glu_L_c_a,u_akg_m_a))
        du[82] = 0
        du[83] = 0.5*T2Jcorrection*(ACONTm_a(u_cit_m_a,u_icit_m_a)-ICDHxm_a(u_nad_m_a,u_nadh_m_a,u_icit_m_a))
        du[84] = 0.5*T2Jcorrection*(CSm_a(u_oaa_m_a,u_cit_m_a,u_accoa_m_a,u_coa_m_a)-ACONTm_a(u_cit_m_a,u_icit_m_a))
        du[85] = 0.5*T2Jcorrection*(PDHm_a(u_nad_m_a,u_pyr_m_a,u_coa_m_a)-CSm_a(u_oaa_m_a,u_cit_m_a,u_accoa_m_a,u_coa_m_a))
        du[86] = 0
        du[87] = 0
        du[88] = 6.96*PYRt2m_a(u_h_m_a,u_pyr_c_a,u_h_c_a,u_pyr_m_a)-T2Jcorrection*(PDHm_a(u_nad_m_a,u_pyr_m_a,u_coa_m_a)+PCm_a(u_co2_m_a,u_oaa_m_a,u_pyr_m_a,u_atp_m_a,u_adp_m_a))
        du[89] = T2Jcorrection*(GLNt4_n(u_gln_L_c_n,u_gln_L_e_e)-GLUNm_n(u_gln_L_c_n,u_glu_L_m_n))
        du[90] = T2Jcorrection*(-GLNt4_n(u_gln_L_c_n,u_gln_L_e_e)+GLNt4_a(u_gln_L_c_a,u_gln_L_e_e))
        du[91] = T2Jcorrection*(-GLNt4_a(u_gln_L_c_a,u_gln_L_e_e)+GLNS_a(u_adp_c_a,u_atp_c_a,u_glu_L_c_a))
        du[92] = T2Jcorrection*(0.0266*GLUt6_a(u_na1_c_a,u_notBigg_Va_c_a,u_k_e_e,u_glu_L_syn_syn,u_k_c_a,u_glu_L_c_a)-GLNS_a(u_adp_c_a,u_atp_c_a,u_glu_L_c_a)-GLUDxm_a(u_nad_m_a,u_nadh_m_a,u_glu_L_c_a,u_akg_m_a))
        du[93] = (1/4e-4)*(-dIPump_a-IBK-IKirAS-IKirAV-IleakA-ITRP_a)
        du[94] = vLeakNag-3*vPumpg+vgstim
        du[95] = JNaK_a+(-IleakA-IBK-IKirAS-IKirAV)/(4e-4*843.0*1000.)-RateDecayK_a*(u_k_c_a-u0_ss[95])
        du[96] = SmVn/F*(IK+IM)*(eto_n/eto_ecs)-2*vPumpn*(eto_n/eto_ecs)-2*(eto_a/eto_ecs)*vPumpg-JdiffK-((-IleakA-IBK-IKirAS-IKirAV)/(4e-4*843.0*1000.0))
        du[97] = 0
        du[98] = 1/Cm*(-IL-INa-IK-ICa-ImAHP-dIPump+Isyne+Isyni-IM+Iinj)
        du[99] = vLeakNan-3*vPumpn+vnstim
        du[100] = phi*(hinf-u_notBigg_hgate_c_n)/tauh
        du[101] = phi*(ninf-u_notBigg_ngate_c_n)/taun
        du[102] = -SmVn/F*ICa-(u_ca2_c_n-u0_ss[102])/tauCa
        du[103] = phi*(p_inf-u_notBigg_pgate_c_n)/tau_p
        du[104] = psiBK*cosh((u_notBigg_Va_c_a-(-0.5*v5BK*tanh((u_ca2_c_a-Ca3BK)/Ca4BK)+v6BK))/(2*v4BK))*(nBKinf-u_notBigg_nBK_c_a)
        du[105] = 0
        du[106] = rhIP3a*((u_notBigg_mGluRboundRatio_c_a+deltaGlutSyn)/(KGlutSyn+u_notBigg_mGluRboundRatio_c_a+deltaGlutSyn))-kdegIP3a*u_notBigg_IP3_c_a
        du[107] = konhIP3Ca_a*(khIP3Ca_aINH-(u_ca2_c_a+khIP3Ca_aINH)*u_notBigg_hIP3Ca_c_a)
        du[108] = beta_Ca_a*(IIP3_a-ICa_pump_a+Ileak_CaER_a)-0.5*ITRP_a/(4e-4*843.0*1000.)
        du[109] = 0
        du[110] = (Ca_perivasc/tauTRPCa_perivasc)*(sinfTRPV-u_notBigg_sTRP_c_a)
        du[111] = notBigg_FinDyn_W2017(t)-notBigg_Fout_W2017(t,u_notBigg_vV_b_b)
        du[112] = VprodEET_a*(u_ca2_c_a-CaMinEET_a)-kdeg_EET_a*u_notBigg_EET_c_a
        du[113] = notBigg_JdHbin(t,u_o2_b_b)-notBigg_JdHbout(t,u_notBigg_ddHb_b_b,u_notBigg_vV_b_b)
        du[114] = notBigg_JO2art2cap(t,u_o2_b_b)-(eto_n/eto_b)*notBigg_JO2fromCap2n(u_o2_b_b,u_o2_c_n)-(eto_a/eto_b)*notBigg_JO2fromCap2a(u_o2_b_b,u_o2_c_a)
        du[115] = notBigg_trGLC_art_cap(t,u_glc_D_b_b)-notBigg_JGlc_be(u_glc_D_ecsEndothelium_ecsEndothelium,u_glc_D_b_b)
        du[116] = 0.32*notBigg_JGlc_be(u_glc_D_ecsEndothelium_ecsEndothelium,u_glc_D_b_b)-notBigg_JGlc_e2ecsBA(u_glc_D_ecsBA_ecsBA,u_glc_D_ecsEndothelium_ecsEndothelium)
        du[117] = 1.13*notBigg_JGlc_e2ecsBA(u_glc_D_ecsBA_ecsBA,u_glc_D_ecsEndothelium_ecsEndothelium)-notBigg_JGlc_ecsBA2a(u_glc_D_ecsBA_ecsBA,u_glc_D_c_a)-notBigg_JGlc_diffEcs(u_glc_D_ecsBA_ecsBA,u_glc_D_ecsAN_ecsAN)
        du[118] = 0.06*notBigg_JGlc_ecsBA2a(u_glc_D_ecsBA_ecsBA,u_glc_D_c_a)-HEX1_a(u_atp_c_a,u_g6p_c_a,u_glc_D_c_a)-notBigg_JGlc_a2ecsAN(u_glc_D_ecsAN_ecsAN,u_glc_D_c_a)
        du[119] = 1.35*notBigg_JGlc_a2ecsAN(u_glc_D_ecsAN_ecsAN,u_glc_D_c_a)-notBigg_JGlc_ecsAN2n(u_glc_D_c_n,u_glc_D_ecsAN_ecsAN)+0.08*notBigg_JGlc_diffEcs(u_glc_D_ecsBA_ecsBA,u_glc_D_ecsAN_ecsAN)
        du[120] = 0.41*notBigg_JGlc_ecsAN2n(u_glc_D_c_n,u_glc_D_ecsAN_ecsAN)-HEX1_n(u_glc_D_c_n,u_atp_c_n,u_g6p_c_n)
        du[121] = HEX1_n(u_glc_D_c_n,u_atp_c_n,u_g6p_c_n)-PGI_n(u_f6p_c_n,u_g6p_c_n)-G6PDH2r_n(u_g6p_c_n,u_nadph_c_n,u_nadp_c_n,u_6pgl_c_n)
        du[122] = HEX1_a(u_atp_c_a,u_g6p_c_a,u_glc_D_c_a)-PGI_a(u_g6p_c_a,u_f6p_c_a)-G6PDH2r_a(u_6pgl_c_a,u_nadp_c_a,u_g6p_c_a,u_nadph_c_a)+PGMT_a(u_g1p_c_a,u_g6p_c_a)
        du[123] = PGI_n(u_f6p_c_n,u_g6p_c_n)-PFK_n(u_f6p_c_n,u_atp_c_n)-TKT2_n(u_f6p_c_n,u_e4p_c_n,u_xu5p_D_c_n,u_g3p_c_n)+TALA_n(u_f6p_c_n,u_e4p_c_n,u_g3p_c_n,u_s7p_c_n)
        du[124] = PGI_a(u_g6p_c_a,u_f6p_c_a)-PFK_a(u_atp_c_a,u_f26bp_c_a,u_f6p_c_a)-PFK26_a(u_adp_c_a,u_atp_c_a,u_f26bp_c_a,u_f6p_c_a)-TKT2_a(u_g3p_c_a,u_e4p_c_a,u_xu5p_D_c_a,u_f6p_c_a)+TALA_a(u_g3p_c_a,u_e4p_c_a,u_s7p_c_a,u_f6p_c_a)
        du[125] = PFK_n(u_f6p_c_n,u_atp_c_n)-FBA_n(u_fdp_c_n,u_dhap_c_n,u_g3p_c_n)
        du[126] = PFK_a(u_atp_c_a,u_f26bp_c_a,u_f6p_c_a)-FBA_a(u_g3p_c_a,u_fdp_c_a,u_dhap_c_a)
        du[127] = PFK26_a(u_adp_c_a,u_atp_c_a,u_f26bp_c_a,u_f6p_c_a)
        du[128] = GLCS2_a(u_notBigg_GS_c_a,u_udpg_c_a)-GLCP_a(u_glycogen_c_a,u_notBigg_GPa_c_a,u_camp_c_a,u_notBigg_GPb_c_a)
        du[129] = 0
        du[130] = 0
        du[131] = 10*GLCP_a(u_glycogen_c_a,u_notBigg_GPa_c_a,u_camp_c_a,u_notBigg_GPb_c_a)-PGMT_a(u_g1p_c_a,u_g6p_c_a)-GALUi_a(u_ppi_c_a,u_g1p_c_a,u_udpg_c_a,u_utp_c_a)
        du[132] = FBA_n(u_fdp_c_n,u_dhap_c_n,u_g3p_c_n)-GAPD_n(u_nadh_c_n,u_nad_c_n,u_g3p_c_n,u_pi_c_n,u_13dpg_c_n)+TPI_n(u_dhap_c_n,u_g3p_c_n)-TKT2_n(u_f6p_c_n,u_e4p_c_n,u_xu5p_D_c_n,u_g3p_c_n)-TALA_n(u_f6p_c_n,u_e4p_c_n,u_g3p_c_n,u_s7p_c_n)+TKT1_n(u_s7p_c_n,u_r5p_c_n,u_xu5p_D_c_n,u_g3p_c_n)
        du[133] = FBA_a(u_g3p_c_a,u_fdp_c_a,u_dhap_c_a)-GAPD_a(u_nadh_c_a,u_nad_c_a,u_pi_c_a,u_13dpg_c_a,u_g3p_c_a)+TPI_a(u_g3p_c_a,u_dhap_c_a)-TKT2_a(u_g3p_c_a,u_e4p_c_a,u_xu5p_D_c_a,u_f6p_c_a)-TALA_a(u_g3p_c_a,u_e4p_c_a,u_s7p_c_a,u_f6p_c_a)+TKT1_a(u_r5p_c_a,u_g3p_c_a,u_s7p_c_a,u_xu5p_D_c_a)
        du[134] = FBA_n(u_fdp_c_n,u_dhap_c_n,u_g3p_c_n)-TPI_n(u_dhap_c_n,u_g3p_c_n)
        du[135] = FBA_a(u_g3p_c_a,u_fdp_c_a,u_dhap_c_a)-TPI_a(u_g3p_c_a,u_dhap_c_a)
        du[136] = GAPD_n(u_nadh_c_n,u_nad_c_n,u_g3p_c_n,u_pi_c_n,u_13dpg_c_n)-PGK_n(u_13dpg_c_n,u_3pg_c_n,u_atp_c_n,u_adp_c_n)
        du[137] = GAPD_a(u_nadh_c_a,u_nad_c_a,u_pi_c_a,u_13dpg_c_a,u_g3p_c_a)-PGK_a(u_adp_c_a,u_atp_c_a,u_3pg_c_a,u_13dpg_c_a)
        du[138] = GAPD_a(u_nadh_c_a,u_nad_c_a,u_pi_c_a,u_13dpg_c_a,u_g3p_c_a)-LDH_L_a(u_nad_c_a,u_nadh_c_a,u_lac_L_c_a,u_pyr_c_a)-notBigg_vShuttleg(u_nadh_c_a,u_nadh_m_a)
        du[139] = 0
        du[140] = 0
        du[141] = PGK_n(u_13dpg_c_n,u_3pg_c_n,u_atp_c_n,u_adp_c_n)-PGM_n(u_2pg_c_n,u_3pg_c_n)
        du[142] = PGK_a(u_adp_c_a,u_atp_c_a,u_3pg_c_a,u_13dpg_c_a)-PGM_a(u_2pg_c_a,u_3pg_c_a)
        du[143] = PGM_n(u_2pg_c_n,u_3pg_c_n)-ENO_n(u_pep_c_n,u_2pg_c_n)
        du[144] = PGM_a(u_2pg_c_a,u_3pg_c_a)-ENO_a(u_2pg_c_a,u_pep_c_a)
        du[145] = ENO_n(u_pep_c_n,u_2pg_c_n)-PYK_n(u_pep_c_n,u_atp_c_n,u_adp_c_n)
        du[146] = ENO_a(u_2pg_c_a,u_pep_c_a)-PYK_a(u_adp_c_a,u_atp_c_a,u_pep_c_a)
        du[147] = PYK_n(u_pep_c_n,u_atp_c_n,u_adp_c_n)-PYRt2m_n(u_h_m_n,u_pyr_m_n,u_h_c_n,u_pyr_c_n)-LDH_L_n(u_nad_c_n,u_lac_L_c_n,u_nadh_c_n,u_pyr_c_n)
        du[148] = PYK_a(u_adp_c_a,u_atp_c_a,u_pep_c_a)-PYRt2m_a(u_h_m_a,u_pyr_c_a,u_h_c_a,u_pyr_m_a)-LDH_L_a(u_nad_c_a,u_nadh_c_a,u_lac_L_c_a,u_pyr_c_a)
        du[149] = notBigg_JLacTr_b(u_lac_L_b_b,t)-notBigg_MCT1_LAC_b(u_lac_L_b_b,u_lac_L_e_e)-notBigg_vLACgc(u_lac_L_b_b,u_lac_L_c_a)
        du[150] = 0.0275*notBigg_MCT1_LAC_b(u_lac_L_b_b,u_lac_L_e_e)-L_LACt2r_a(u_lac_L_e_e,u_lac_L_c_a)-L_LACt2r_n(u_lac_L_e_e,u_lac_L_c_n)+notBigg_jLacDiff_e(u_lac_L_e_e)
        du[151] = 0.8*L_LACt2r_a(u_lac_L_e_e,u_lac_L_c_a)+0.022*notBigg_vLACgc(u_lac_L_b_b,u_lac_L_c_a)+LDH_L_a(u_nad_c_a,u_nadh_c_a,u_lac_L_c_a,u_pyr_c_a)
        du[152] = 0.44*L_LACt2r_n(u_lac_L_e_e,u_lac_L_c_n)+LDH_L_n(u_nad_c_n,u_lac_L_c_n,u_nadh_c_n,u_pyr_c_n)
        du[153] = G6PDH2r_n(u_g6p_c_n,u_nadph_c_n,u_nadp_c_n,u_6pgl_c_n)+GND_n(u_6pgc_c_n,u_nadph_c_n,u_nadp_c_n,u_ru5p_D_c_n)-notBigg_psiNADPHox_n(u_nadph_c_n)-GTHO_n(u_nadph_c_n,u_gthox_c_n)
        du[154] = G6PDH2r_a(u_6pgl_c_a,u_nadp_c_a,u_g6p_c_a,u_nadph_c_a)+GND_a(u_6pgc_c_a,u_nadp_c_a,u_ru5p_D_c_a,u_nadph_c_a)-notBigg_psiNADPHox_a(u_nadph_c_a)-GTHO_a(u_gthox_c_a,u_nadph_c_a)
        du[155] = G6PDH2r_n(u_g6p_c_n,u_nadph_c_n,u_nadp_c_n,u_6pgl_c_n)-PGL_n(u_6pgc_c_n,u_6pgl_c_n)
        du[156] = G6PDH2r_a(u_6pgl_c_a,u_nadp_c_a,u_g6p_c_a,u_nadph_c_a)-PGL_a(u_6pgc_c_a,u_6pgl_c_a)
        du[157] = PGL_n(u_6pgc_c_n,u_6pgl_c_n)-GND_n(u_6pgc_c_n,u_nadph_c_n,u_nadp_c_n,u_ru5p_D_c_n)
        du[158] = PGL_a(u_6pgc_c_a,u_6pgl_c_a)-GND_a(u_6pgc_c_a,u_nadp_c_a,u_ru5p_D_c_a,u_nadph_c_a)
        du[159] = GND_n(u_6pgc_c_n,u_nadph_c_n,u_nadp_c_n,u_ru5p_D_c_n)-RPE_n(u_xu5p_D_c_n,u_ru5p_D_c_n)-RPI_n(u_r5p_c_n,u_ru5p_D_c_n)
        du[160] = GND_a(u_6pgc_c_a,u_nadp_c_a,u_ru5p_D_c_a,u_nadph_c_a)-RPE_a(u_ru5p_D_c_a,u_xu5p_D_c_a)-RPI_a(u_r5p_c_a,u_ru5p_D_c_a)
        du[161] = RPI_n(u_r5p_c_n,u_ru5p_D_c_n)-TKT1_n(u_s7p_c_n,u_r5p_c_n,u_xu5p_D_c_n,u_g3p_c_n)
        du[162] = RPI_a(u_r5p_c_a,u_ru5p_D_c_a)-TKT1_a(u_r5p_c_a,u_g3p_c_a,u_s7p_c_a,u_xu5p_D_c_a)
        du[163] = RPE_n(u_xu5p_D_c_n,u_ru5p_D_c_n)-TKT1_n(u_s7p_c_n,u_r5p_c_n,u_xu5p_D_c_n,u_g3p_c_n)+TKT2_n(u_f6p_c_n,u_e4p_c_n,u_xu5p_D_c_n,u_g3p_c_n)
        du[164] = RPE_a(u_ru5p_D_c_a,u_xu5p_D_c_a)-TKT1_a(u_r5p_c_a,u_g3p_c_a,u_s7p_c_a,u_xu5p_D_c_a)+TKT2_a(u_g3p_c_a,u_e4p_c_a,u_xu5p_D_c_a,u_f6p_c_a)
        du[165] = TKT1_n(u_s7p_c_n,u_r5p_c_n,u_xu5p_D_c_n,u_g3p_c_n)-TALA_n(u_f6p_c_n,u_e4p_c_n,u_g3p_c_n,u_s7p_c_n)
        du[166] = TKT1_a(u_r5p_c_a,u_g3p_c_a,u_s7p_c_a,u_xu5p_D_c_a)-TALA_a(u_g3p_c_a,u_e4p_c_a,u_s7p_c_a,u_f6p_c_a)
        du[167] = TKT2_n(u_f6p_c_n,u_e4p_c_n,u_xu5p_D_c_n,u_g3p_c_n)+TALA_n(u_f6p_c_n,u_e4p_c_n,u_g3p_c_n,u_s7p_c_n)
        du[168] = TKT2_a(u_g3p_c_a,u_e4p_c_a,u_xu5p_D_c_a,u_f6p_c_a)+TALA_a(u_g3p_c_a,u_e4p_c_a,u_s7p_c_a,u_f6p_c_a)
        du[169] = 2*(GTHO_n(u_nadph_c_n,u_gthox_c_n)-GTHP_n(u_gthrd_c_n))+GTHS_n(u_gthrd_c_n)
        du[170] = 2*(GTHO_a(u_gthox_c_a,u_nadph_c_a)-GTHP_a(u_gthrd_c_a))+GTHS_a(u_gthrd_c_a)
        du[171] = -GTHO_n(u_nadph_c_n,u_gthox_c_n)+GTHP_n(u_gthrd_c_n)
        du[172] = -GTHO_a(u_gthox_c_a,u_nadph_c_a)+GTHP_a(u_gthrd_c_a)
        du[173] = 0
        du[174] = -CKc_n(u_pcreat_c_n,u_atp_c_n,u_adp_c_n)
        du[175] = 0
        du[176] = -CKc_a(u_adp_c_a,u_atp_c_a,u_pcreat_c_a)
        du[177] = (u_ca2_c_a/cai0_ca_ion)*(1+xNEmod*(u[178]/(KdNEmod+u[178])))*ADNCYC_a(u_camp_c_a,u_atp_c_a)-PDE1_a(u_camp_c_a)
        du[178] = 0
        du[179] = 0
        du[180] = 0
        du[181] = 0
        du[182] = notBigg_psiPHK_a(u_ca2_c_a,u_glycogen_c_a,u_g1p_c_a,u_notBigg_PHKa_c_a,u_notBigg_GPa_c_a,u_udpg_c_a)
        du[183] = -notBigg_psiPHK_a(u_ca2_c_a,u_glycogen_c_a,u_g1p_c_a,u_notBigg_PHKa_c_a,u_notBigg_GPa_c_a,u_udpg_c_a)

    end

else
    println("ATTENTION: age_cat is ",age_cat)


    function metabolism!(du,u,p,t)
u_h_m_n = u[1]
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
u_adp_c_n = u[23]/2*(-qAK+sqrt(qAK*qAK+4*qAK*(ATDPtot_n/u[23]-1)))
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
u_adp_c_a = u[73]/2*(-qAK+sqrt(qAK*qAK+4*qAK*(ATDPtot_a/u[73]-1)))
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
u_notBigg_GPb_c_a = u[183]
u_h_c_n = C_H_cyt_n
u_h_c_a = C_H_cyt_a
u_co2_m_n = CO2_mito_n
u_co2_m_a = CO2_mito_a
u_ppi_c_a = PPi_a0
u_notBigg_PHKa_c_a = PHKa_a0
u_notBigg_PP1_c_a_initialValue = PP1_a0
H2PIi_n = (1e-3*u_pi_i_n)*(1e-3*u_h_i_n)/((1e-3*u_h_i_n)+k_dHPi)
H2PIx_n = (1e-3*u_pi_m_n)*(1e-3*u_h_m_n)/((1e-3*u_h_m_n)+k_dHPi)
H2PIi_a = (1e-3*u_pi_i_a)*(1e-3*u_h_i_a)/((1e-3*u_h_i_a)+k_dHPi)
H2PIx_a = (1e-3*u_pi_m_a)*(1e-3*u_h_m_a)/((1e-3*u_h_m_a)+k_dHPi)
synInput=p[1]
Iinj=p[2]

global_par_t_0 = p[3]
global_par_t_fin = p[4]

C_Glc_a = p[5]
C_Lac_a = p[6]
C_bHB_a = p[7]

Pi_n=u[139]
Pi_a=u[140]
C_H_mitomatr_nM=1e-3*u[1];
K_x_nM=1e-3*u[2];
Mg_x_nM=1e-3*u[3];
NADHmito_nM=1e-3*u[4];
QH2mito_nM=1e-3*u[5];
CytCredmito_nM=1e-3*u[6];
O2_nM=1e-3*u[7];
ATPmito_nM=1e-3*u[8];
ADPmito_nM=1e-3*u[9]
Cr_n=Crtot-u[174];
Cr_a=Crtot-u[176]
ADP_n=u[23]/2*(-qAK+sqrt(qAK*qAK+4*qAK*(ATDPtot_n/u[23]-1)))
ADP_a=u[73]/2*(-qAK+sqrt(qAK*qAK+4*qAK*(ATDPtot_a/u[73]-1)))
j_un=qAK*qAK+4*qAK*(ATDPtot_n/u[23]-1)
j_ug=qAK*qAK+4*qAK*(ATDPtot_a/u[73]-1)
dAMPdATPn=-1+qAK/2-0.5*sqrt(j_un)+qAK*ATDPtot_n/(u[23]*sqrt(j_un))
dAMPdATPg=-1+qAK/2-0.5*sqrt(j_ug)+qAK*ATDPtot_a/(u[73]*sqrt(j_ug))
ATP_nM=1e-3*u[23];
ADP_nM=1e-3*ADP_n
ATP_aM=1e-3*u[73];
ADP_aM=1e-3*ADP_a
ATP_mx_nM=1e-3*u[10];
ADP_mx_nM=1e-3*u[11]
Pimito_nM=1e-3*u[12]
ATP_i_nM=1e-3*u[13];
ADP_i_nM=1e-3*u[14];
AMP_i_nM=1e-3*u[15]
ATP_mi_nM=1e-3*u[16];
ADP_mi_nM=1e-3*u[17]
Pi_i_nM=1e-3*u[18]
Ctot_nM=1e-3*u[20]
Qtot_nM=1e-3*u[21]
C_H_ims_nM=1e-3*u[22]
AMP_nM=0
NAD_x_n=NADtot_n-NADHmito_nM;
u_nad_m_n=1000*NAD_x_n
Q_n=Qtot_nM-QH2mito_nM;
Qmito_n=1000*Q_n
Cox_n=Ctot_nM-CytCredmito_nM;
ATP_fx_n=ATPmito_nM-ATP_mx_nM
ADP_fx_n=ADPmito_nM-ADP_mx_nM
ATP_fi_n=ATP_i_nM-ATP_mi_nM
ADP_fi_n=ADP_i_nM-ADP_mi_nM
ADP_me_n=((K_DD+ADP_nM+Mg_tot)-sqrt((K_DD+ADP_nM+Mg_tot)^2-4*(Mg_tot*ADP_nM)))/2;
Mg_i_n=Mg_tot-ADP_me_n;
dG_H_n=etcF*u[19]+1*etcRT*log(C_H_ims_nM/C_H_mitomatr_nM);
dG_C1op_n=dG_C1o-1*etcRT*log(C_H_mitomatr_nM/1e-7);
dG_C3op_n=dG_C3o+2*etcRT*log(C_H_mitomatr_nM/1e-7);
dG_C4op_n=dG_C4o-2*etcRT*log(C_H_mitomatr_nM/1e-7);
dG_F1op_n=dG_F1o-1*etcRT*log(C_H_mitomatr_nM/1e-7);
C_H_mitomatr_a=u[51];
C_H_mitomatr_aM=1e-3*u[51]
K_x_aM=1e-3*u[52]
Mg_x_aM=1e-3*u[53]
NADHmito_aM=1e-3*u[54]
QH2mito_aM=1e-3*u[55]
CytCredmito_aM=1e-3*u[56]
O2_aM=1e-3*u[57]
ATPmito_aM=1e-3*u[58]
ADPmito_aM=1e-3*u[59]
ATP_mx_aM=1e-3*u[60]
ADP_mx_aM=1e-3*u[61]
Pimito_aM=1e-3*u[62]
ATP_i_aM=1e-3*u[63]
ADP_i_aM=1e-3*u[64];
AMP_i_aM=1e-3*u[65]
ATP_mi_aM=1e-3*u[66]
ADP_mi_aM=1e-3*u[67]
Pi_i_aM=1e-3*u[68]
Ctot_aM=1e-3*u[70]
Qtot_aM=1e-3*u[71]
C_H_ims_aM=1e-3*u[72]
AMP_aM=0
NAD_x_a=NADtot_a-NADHmito_aM;
u_nad_m_a=1000*NAD_x_a
Q_a=Qtot_aM-QH2mito_aM;
Qmito_a=1000*Q_a
Cox_a=Ctot_aM-CytCredmito_aM;
ATP_fx_a=ATPmito_aM-ATP_mx_aM
ADP_fx_a=ADPmito_aM-ADP_mx_aM
ATP_fi_a=ATP_i_aM-ATP_mi_aM
ADP_fi_a=ADP_i_aM-ADP_mi_aM
ADP_me_a=((K_DD_a+ADP_aM+Mg_tot)-sqrt((K_DD_a+ADP_aM+Mg_tot)^2-4*(Mg_tot*ADP_aM)))/2;
Mg_i_a=Mg_tot-ADP_me_a;
dG_H_a=etcF*u[69]+1*etcRT*log(C_H_ims_aM/C_H_mitomatr_aM);
dG_C1op_a=dG_C1o-1*etcRT*log(C_H_mitomatr_aM/1e-7);
dG_C3op_a=dG_C3o+2*etcRT*log(C_H_mitomatr_aM/1e-7);
dG_C4op_a=dG_C4o-2*etcRT*log(C_H_mitomatr_aM/1e-7);
dG_F1op_a=dG_F1o-1*etcRT*log(C_H_mitomatr_aM/1e-7);
u_nadp_c_n=0.0303-u[153];
u_nadp_c_a=0.0303-u[154]
u_nad_c_n=NAD_aging_coeff_n*0.212-u[50];
u_nad_c_a=NAD_aging_coeff_a*0.212-u[138]
V=u[98]
rTRPVsinf=u[111]
Glutamate_syn=u[97]
alpham=-0.1*(V+33)/(exp(-0.1*(V+33))-1)
betam=4*exp(-(V+58)/12)
alphah=0.07*exp(-(V+50)/10)
betah=1/(exp(-0.1*(V+20))+1)
alphan=-0.01*(V+34)/(exp(-0.1*(V+34))-1)
betan=0.125*exp(-(V+44)/25)
minf=alpham/(alpham+betam);
ninf=alphan/(alphan+betan);
hinf=alphah/(alphah+betah);
taun=1/(alphan+betan)*1e-03;
tauh=1/(alphah+betah)*1e-03;
p_inf=1.0/(1.0+exp(-(V+35.0)/10.0));
tau_p=tau_max/(3.3*exp((V+35.0)/20.0)+exp(-(V+35.0)/20.0))
K_n=K_n_Rest+(Na_n_Rest-u[99])
EK=RTF*log(u[96]/K_n)
EL=gKpas*EK/(gKpas+gNan)+gNan/(gKpas+gNan)*RTF*log(Na_out/u[99]);
IL=gL*(V-EL);
INa=gNa*minf^3*u[100]*(V-RTF*log(Na_out/u[99]));
IK=gK*u[101]^4*(V-EK);
mCa=1/(1+exp(-(V+20)/9));
ICa=gCa*mCa^2*(V-ECa);
ImAHP=gmAHP*u[102]/(u[102]+KD)*(V-EK);
IM=g_M*u[103]*(V-EK)
dIPump=F*kPumpn*u[23]*(u[99]-u0_ss[99])/(1+u[23]/KmPump);
dIPump_a=F*kPumpg*u[73]*(u[94]-u0_ss[94])/(1+u[73]/KmPump)
Isyne=-synInput*(V-Ee);
Isyni=0
vnstim=SmVn/F*(2/3*Isyne-INa);
vgstim=SmVg/F*2/3*glia*synInput;
vLeakNan=SmVn*gNan/F*(RTF*log(Na_out/u[99])-V);
vLeakNag=SmVg*gNag/F*(RTF*log(Na_out/u[94])-V);
vPumpn=SmVn*kPumpn*u[23]*u[99]/(1+u[23]/KmPump);
vPumpg=SmVg*kPumpg*u[73]*u[94]/(1+u[73]/KmPump);
JgliaK=((u[73]/ADP_a)/(mu_glia_ephys+(u[73]/ADP_a)))*(glia_c/(1+exp((Na_n2_baseNKA-u[96])/2.5)))
JdiffK=epsilon*(u[96]-kbath)
nBKinf=0.5*(1+tanh((u[93]+EETshift*u[112]-(-0.5*v5BK*tanh((u[108]-Ca3BK)/Ca4BK)+v6BK))/v4BK))
IBK=gBK*u[104]*(u[93]-EBK)
JNaK_a=(ImaxNaKa*(u[96]/(u[96]+INaKaKThr))*((u[94]^1.5)/(u[94]^1.5+INaKaNaThr^1.5)))
IKirAS=gKirS*(u[96]^0.5)*(u[93]-VKirS*log(u[96]/u[95]))
IKirAV=gKirV*(u[96]^0.5)*(u[93]-VKirAV*log(u[96]/u[95]))
IleakA=gleakA*(u[93]-VleakA)
Ileak_CaER_a=Pleak_CaER_a*(1.0-u[108]/u[109])
ICa_pump_a=VCa_pump_a*((u[108]^2)/(u[108]^2+KpCa_pump_a^2))
IIP3_a=ImaxIP3_a*(((u[106]/(u[106]+KIIP3_a))*(u[108]/(u[108]+KCaactIP3_a))*u[107])^3)*(1.0-u[108]/u[109])
ITRP_a=gTRP*(u[93]-VTRP)*u[110]
sinfTRPV=(1/(1+exp(-(((rTRPVsinf^(1/3)-r0TRPVsinf^(1/3))/r0TRPVsinf^(1/3))-e2TRPVsinf^(1/3))/kTRPVsinf)))*((1/(1+u[108]/gammaCaaTRPVsinf+Ca_perivasc/gammaCapTRPVsinf))*(u[108]/gammaCaaTRPVsinf+Ca_perivasc/gammaCapTRPVsinf+tanh((u[93]-v1TRPsinf_a)/v2TRPsinf_a)))
r0509_n(u_nadh_m_n,u_pi_m_n) = 0.4393861083874181*(x_DH*(r_DH*NAD_x_n-(1e-3*u_nadh_m_n))*((1+(1e-3*u_pi_m_n)/k_Pi1)/(1+(1e-3*u_pi_m_n)/k_Pi2)))
NADH2_u10mi_n(u_nadh_m_n,u_q10h2_m_n) = 0.7759912793200542*(x_C1*(exp(-(dG_C1op_n+4*dG_H_n)/etcRT)*(1e-3*u_nadh_m_n)*Q_n-NAD_x_n*(1e-3*u_q10h2_m_n)))
CYOR_u10mi_n(u_focytC_m_n,u_notBigg_MitoMembrPotent_m_n,u_q10h2_m_n,u_pi_m_n) = 0.6869109286423211*(x_C3*((1+(1e-3*u_pi_m_n)/k_Pi3)/(1+(1e-3*u_pi_m_n)/k_Pi4))*(exp(-(dG_C3op_n+4*dG_H_n-2*etcF*u_notBigg_MitoMembrPotent_m_n)/(2*etcRT))*Cox_n*(1e-3*u_q10h2_m_n)^0.5-(1e-3*u_focytC_m_n)*Q_n^0.5))
CYOOm2i_n(u_focytC_m_n,u_notBigg_MitoMembrPotent_m_n,u_notBigg_Ctot_m_n,u_o2_c_n) = 0.6922236219048762*(x_C4*((1e-3*u_o2_c_n)/((1e-3*u_o2_c_n)+k_O2))*((1e-3*u_focytC_m_n)/(1e-3*u_notBigg_Ctot_m_n))*(exp(-(dG_C4op_n+2*dG_H_n)/(2*etcRT))*(1e-3*u_focytC_m_n)*((1e-3*u_o2_c_n)^0.25)-Cox_n*exp(etcF*u_notBigg_MitoMembrPotent_m_n/etcRT)))
ATPS4mi_n(u_notBigg_ATP_mx_m_n,u_notBigg_ADP_mx_m_n,u_pi_m_n) = 0.6503896026734852*(x_F1*(exp(-(dG_F1op_n-n_A*dG_H_n)/etcRT)*(K_DD/K_DT)*(1e-3*u_notBigg_ADP_mx_m_n)*(1e-3*u_pi_m_n)-(1e-3*u_notBigg_ATP_mx_m_n)))
ATPtm_n(u_notBigg_MitoMembrPotent_m_n) = 0.5562045860776595*(x_ANT*(ADP_fi_n/(ADP_fi_n+ATP_fi_n*exp(-etcF*(0.35*u_notBigg_MitoMembrPotent_m_n)/etcRT))-ADP_fx_n/(ADP_fx_n+ATP_fx_n*exp(-etcF*(-0.65*u_notBigg_MitoMembrPotent_m_n)/etcRT)))*(ADP_fi_n/(ADP_fi_n+k_mADP)))
notBigg_J_Pi1_n(u_h_m_n,u_h_i_n) = 1*(x_Pi1*((1e-3*u_h_m_n)*H2PIi_n-(1e-3*u_h_i_n)*H2PIx_n)/(H2PIi_n+k_PiH))
notBigg_J_Hle_n(u_h_m_n,u_h_i_n,u_notBigg_MitoMembrPotent_m_n) = 1*(x_Hle*u_notBigg_MitoMembrPotent_m_n*((1e-3*u_h_i_n)*exp(etcF*u_notBigg_MitoMembrPotent_m_n/etcRT)-(1e-3*u_h_m_n))/(exp(etcF*u_notBigg_MitoMembrPotent_m_n/etcRT)-1))
notBigg_J_KH_n(u_h_m_n,u_h_i_n,u_k_m_n) = 1*(x_KH*(K_i*(1e-3*u_h_m_n)-(1e-3*u_k_m_n)*(1e-3*u_h_i_n)))
notBigg_J_K_n(u_k_m_n,u_notBigg_MitoMembrPotent_m_n) = 1*(x_K*u_notBigg_MitoMembrPotent_m_n*(K_i*exp(etcF*u_notBigg_MitoMembrPotent_m_n/etcRT)-(1e-3*u_k_m_n))/(exp(etcF*u_notBigg_MitoMembrPotent_m_n/etcRT)-1))
ADK1m_n(u_amp_i_n,u_atp_i_n,u_adp_i_n) = 0.8372574193451378*(x_AK*(K_AK*(1e-3*u_adp_i_n)*(1e-3*u_adp_i_n)-(1e-3*u_amp_i_n)*(1e-3*u_atp_i_n)))
notBigg_J_AMP_n(u_amp_i_n,u_amp_c_n) = 1*(gamma*x_A*((1e-3*u_amp_c_n)-(1e-3*u_amp_i_n)))
notBigg_J_ADP_n(u_adp_i_n,u_adp_c_n) = 1*(gamma*x_A*((1e-3*u_adp_c_n)-(1e-3*u_adp_i_n)))
notBigg_J_ATP_n(u_atp_c_n,u_atp_i_n) = 1*(gamma*x_A*((1e-3*u_atp_c_n)-(1e-3*u_atp_i_n)))
notBigg_J_Pi2_n(u_pi_i_n,u_pi_c_n) = 1*(gamma*x_Pi2*(1e-3*u_pi_c_n-(1e-3*u_pi_i_n)))
notBigg_J_Ht_n(u_h_i_n,u_h_c_n) = 1*(gamma*x_Ht*(1e-3*u_h_c_n-(1e-3*u_h_i_n)))
notBigg_J_MgATPx_n(u_notBigg_ATP_mx_m_n,u_mg2_m_n) = 1*(x_MgA*(ATP_fx_n*(1e-3*u_mg2_m_n)-K_DT*(1e-3*u_notBigg_ATP_mx_m_n)))
notBigg_J_MgADPx_n(u_mg2_m_n,u_notBigg_ADP_mx_m_n) = 1*(x_MgA*(ADP_fx_n*(1e-3*u_mg2_m_n)-K_DD*(1e-3*u_notBigg_ADP_mx_m_n)))
notBigg_J_MgATPi_n(u_notBigg_ATP_mi_i_n) = 1*(x_MgA*(ATP_fi_n*Mg_i_n-K_DT*(1e-3*u_notBigg_ATP_mi_i_n)))
notBigg_J_MgADPi_n(u_notBigg_ADP_mi_i_n) = 1*(x_MgA*(ADP_fi_n*Mg_i_n-K_DD*(1e-3*u_notBigg_ADP_mi_i_n)))
PDHm_n(u_pyr_m_n,u_coa_m_n,u_nad_m_n) = 0.6028430831681391*(VmaxPDHCmito_n*(u_pyr_m_n/(u_pyr_m_n+KmPyrMitoPDH_n))*(u_nad_m_n/(u_nad_m_n+KmNADmitoPDH_na))*(u_coa_m_n/(u_coa_m_n+KmCoAmitoPDH_n)))
CSm_n(u_accoa_m_n,u_oaa_m_n,u_cit_m_n,u_coa_m_n) = 0.6877116657855111*(VmaxCSmito_n*(u_oaa_m_n/(u_oaa_m_n+KmOxaMito_n*(1.0+u_cit_m_n/KiCitMito_n)))*(u_accoa_m_n/(u_accoa_m_n+KmAcCoAmito_n*(1.0+u_coa_m_n/KiCoA_n))))
ACONTm_n(u_icit_m_n,u_cit_m_n) = 0.49879329872120226*(VmaxAco_n*(u_cit_m_n-u_icit_m_n/KeqAco_na)/(1.0+u_cit_m_n/KmCitAco_n+u_icit_m_n/KmIsoCitAco_n))
ICDHxm_n(u_nadh_m_n,u_icit_m_n,u_nad_m_n) = 0.5415622934096079*(VmaxIDH_n*(u_nad_m_n/KiNADmito_na)*((u_icit_m_n/KmIsoCitIDHm_n)^nIDH)/(1.0+u_nad_m_n/KiNADmito_na+(KmNADmito_na/KiNADmito_na)*((u_icit_m_n/KmIsoCitIDHm_n)^nIDH)+u_nadh_m_n/KiNADHmito_na+(u_nad_m_n/KiNADmito_na)*((u_icit_m_n/KmIsoCitIDHm_n)^nIDH)+((KmNADmito_na*u_nadh_m_n)/(KiNADmito_na*KiNADHmito_na))*((u_icit_m_n/KmIsoCitIDHm_n)^nIDH)))
AKGDm_n(u_coa_m_n,u_nadh_m_n,u_ca2_m_n,u_adp_m_n,u_succoa_m_n,u_nad_m_n,u_atp_m_n,u_akg_m_n) = 1*((VmaxKGDH_n*(1+u_adp_m_n/KiADPmito_KGDH_n)*(u_akg_m_n/Km1KGDHKGDH_n)*(u_coa_m_n/Km_CoA_kgdhKGDH_n)*(u_nad_m_n/KmNADkgdhKGDH_na))/(((u_coa_m_n/Km_CoA_kgdhKGDH_n)*(u_nad_m_n/KmNADkgdhKGDH_na)*(u_akg_m_n/Km1KGDHKGDH_n+(1+u_atp_m_n/KiATPmito_KGDH_n)/(1+u_ca2_m_n/KiCa2KGDH_n)))+((u_akg_m_n/Km1KGDHKGDH_n)*(u_coa_m_n/Km_CoA_kgdhKGDH_n+u_nad_m_n/KmNADkgdhKGDH_na)*(1+u_nadh_m_n/KiNADHKGDHKGDH_na+u_succoa_m_n/Ki_SucCoA_kgdhKGDH_n))))
SUCOASm_n(u_coa_m_n,u_succ_m_n,u_pi_m_n,u_adp_m_n,u_succoa_m_n,u_atp_m_n) = 0.5710172713175269*(VmaxSuccoaATPscs_n*(1+AmaxPscs_n*((u_pi_m_n^npscs_n)/((u_pi_m_n^npscs_n)+(Km_pi_scs_na^npscs_n))))*(u_succoa_m_n*u_adp_m_n*u_pi_m_n-u_succ_m_n*u_coa_m_n*u_atp_m_n/Keqsuccoascs_na)/((1+u_succoa_m_n/Km_succoa_scs_n)*(1+u_adp_m_n/Km_ADPmito_scs_n)*(1+u_pi_m_n/Km_pi_scs_na)+(1+u_succ_m_n/Km_succ_scs_n)*(1+u_coa_m_n/Km_coa_scs_n)*(1+u_atp_m_n/Km_atpmito_scs_n)))
FUMm_n(u_fum_m_n,u_mal_L_m_n) = 1.1636951264361657*(Vmaxfum_n*(u_fum_m_n-u_mal_L_m_n/Keqfummito_na)/(1.0+u_fum_m_n/Km_fummito_n+u_mal_L_m_n/Km_malmito_n))
MDHm_n(u_nadh_m_n,u_oaa_m_n,u_nad_m_n,u_mal_L_m_n) = 0.5096316013244485*(VmaxMDHmito_n*(u_mal_L_m_n*u_nad_m_n-u_oaa_m_n*u_nadh_m_n/Keqmdhmito_na)/((1.0+u_mal_L_m_n/Km_mal_mdh_n)*(1.0+u_nad_m_n/Km_nad_mdh_na)+(1.0+u_oaa_m_n/Km_oxa_mdh_n)*(1.0+u_nadh_m_n/Km_nadh_mdh_na)))
OCOAT1m_n(u_acac_c_n,u_aacoa_m_n,u_succoa_m_n,u_succ_m_n) = 0.655876728418445*((VmaxfSCOT_n*u_succoa_m_n*u_acac_c_n/(Ki_SucCoA_SCOT_n*Km_AcAc_SCOT_n*(u_succoa_m_n/Ki_SucCoA_SCOT_n+Km_SucCoA_SCOT_n*u_acac_c_n/(Ki_SucCoA_SCOT_n*Km_AcAc_SCOT_n)+u_aacoa_m_n/Ki_AcAcCoA_SCOT_n+Km_AcAcCoA_SCOT_n*u_succ_m_n/(Ki_AcAcCoA_SCOT_n*Km_SUC_SCOT_n)+u_succoa_m_n*u_acac_c_n/(Ki_SucCoA_SCOT_n*Km_AcAc_SCOT_n)+u_succoa_m_n*u_aacoa_m_n/(Ki_SucCoA_SCOT_n*Ki_AcAcCoA_SCOT_n)+Km_SucCoA_SCOT_n*u_acac_c_n*u_succ_m_n/(Ki_SucCoA_SCOT_n*Km_AcAc_SCOT_n*Ki_SUC_SCOT_n)+u_aacoa_m_n*u_succ_m_n/(Ki_AcAcCoA_SCOT_n*Km_SUC_SCOT_n))))-(VmaxrSCOT_n*u_aacoa_m_n*u_succ_m_n/(Ki_AcAcCoA_SCOT_n*Km_SUC_SCOT_n*(u_succoa_m_n/Ki_SucCoA_SCOT_n+Km_SucCoA_SCOT_n*u_acac_c_n/(Ki_SucCoA_SCOT_n*Km_AcAc_SCOT_n)+u_aacoa_m_n/Ki_AcAcCoA_SCOT_n+Km_AcAcCoA_SCOT_n*u_succ_m_n/(Ki_AcAcCoA_SCOT_n*Km_SUC_SCOT_n)+u_succoa_m_n*u_acac_c_n/(Ki_SucCoA_SCOT_n*Km_AcAc_SCOT_n)+u_succoa_m_n*u_aacoa_m_n/(Ki_SucCoA_SCOT_n*Ki_AcAcCoA_SCOT_n)+Km_SucCoA_SCOT_n*u_acac_c_n*u_succ_m_n/(Ki_SucCoA_SCOT_n*Km_AcAc_SCOT_n*Ki_SUC_SCOT_n)+u_aacoa_m_n*u_succ_m_n/(Ki_AcAcCoA_SCOT_n*Km_SUC_SCOT_n)))))
ACACT1rm_n(u_aacoa_m_n,u_coa_m_n) = 0.658540359451706*(Vmax_thiolase_f_n*u_coa_m_n*u_aacoa_m_n/(Ki_CoA_thiolase_f_n*Km_AcAcCoA_thiolase_f_n+Km_AcAcCoA_thiolase_f_n*u_coa_m_n+Km_CoA_thiolase_f_n*u_aacoa_m_n+u_coa_m_n*u_aacoa_m_n))
notBigg_JbHBTrArtCap(t,u_bhb_b_b) = 1*((2*(C_bHB_a-u_bhb_b_b)/eto_b)*(global_par_F_0*(1+global_par_delta_F*(1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1-3))))-1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1+global_par_t_fin+3))))))))
notBigg_MCT1_bHB_b(u_bhb_e_e,u_bhb_b_b) = 0.713341257512879*(VmaxMCTbhb_b*(u_bhb_b_b/(u_bhb_b_b+KmMCT1_bHB_b)-u_bhb_e_e/(u_bhb_e_e+KmMCT1_bHB_b)))
BHBt_n(u_bhb_c_n,u_bhb_e_e) = 0.45107525815399785*(VmaxMCTbhb_n*(u_bhb_e_e/(u_bhb_e_e+KmMCT2_bHB_n)-u_bhb_c_n/(u_bhb_c_n+KmMCT2_bHB_n)))
BHBt_a(u_bhb_c_a,u_bhb_e_e) = 0.8508140076567653*(VmaxMCTbhb_a*(u_bhb_e_e/(u_bhb_e_e+KmMCT1_bHB_a)-u_bhb_c_a/(u_bhb_c_a+KmMCT1_bHB_a)))
BDHm_n(u_acac_c_n,u_bhb_c_n,u_nadh_m_n,u_nad_m_n) = 0.782663818672594*(Vmax_bHBDH_f_n*u_nad_m_n*u_bhb_c_n/(Ki_NAD_B_HBD_f_n*Km_betaHB_BHBD_n+Km_betaHB_BHBD_n*u_nad_m_n+Km_NAD_B_HBD_n*u_bhb_c_n+u_nad_m_n*u_bhb_c_n)-(Vmax_bHBDH_r_n*u_nadh_m_n*u_acac_c_n/(Ki_NADH_BHBD_r_n*Km_AcAc_BHBD_n+Km_AcAc_BHBD_n*u_nadh_m_n+Km_NADH_BHBD_n*u_acac_c_n+u_nadh_m_n*u_acac_c_n)))


# BDHm_a(u_bhb_c_a,u_acac_c_a,u_nad_m_a,u_nadh_m_a) = 1.1988664194729508*(Vmax_bHBDH_f_n*u_nad_m_a*u_bhb_c_a/(Ki_NAD_B_HBD_f_n*Km_betaHB_BHBD_n+Km_betaHB_BHBD_n*u_nad_m_a+Km_NAD_B_HBD_n*u_bhb_c_a+u_nad_m_a*u_bhb_c_a)-(Vmax_bHBDH_r_n*u_nadh_m_a*u_acac_c_a/(Ki_NADH_BHBD_r_n*Km_AcAc_BHBD_n+Km_AcAc_BHBD_n*u_nadh_m_a+Km_NADH_BHBD_n*u_acac_c_a+u_nadh_m_a*u_acac_c_a)))


ASPTAm_n(u_oaa_m_n,u_akg_m_n,u_glu_L_m_n,u_asp_L_m_n) = 0.6386234074893378*(VfAAT_n*(u_asp_L_m_n*u_akg_m_n-u_oaa_m_n*u_glu_L_m_n/KeqAAT_n)/(KmAKG_AAT_n*u_asp_L_m_n+KmASP_AAT_n*(1.0+u_akg_m_n/KiAKG_AAT_n)*u_akg_m_n+u_asp_L_m_n*u_akg_m_n+KmASP_AAT_n*u_akg_m_n*u_glu_L_m_n/KiGLU_AAT_n+(KiASP_AAT_n*KmAKG_AAT_n/(KmOXA_AAT_n*KiGLU_AAT_n))*(KmGLU_AAT_n*u_asp_L_m_n*u_oaa_m_n/KiASP_AAT_n+u_oaa_m_n*u_glu_L_m_n+KmGLU_AAT_n*(1.0+u_akg_m_n/KiAKG_AAT_n)*u_oaa_m_n+KmOXA_AAT_n*u_glu_L_m_n)))
MDH_n(u_nadh_c_n,u_mal_L_c_n,u_oaa_c_n,u_nad_c_n) = 0.3604350854232439*(VmaxcMDH_n*(u_mal_L_c_n*u_nad_c_n-u_oaa_c_n*u_nadh_c_n/Keqcmdh_n)/((1+u_mal_L_c_n/Kmmalcmdh_n)*(1+u_nad_c_n/Kmnadcmdh_n)+(1+u_oaa_c_n/Kmoxacmdh_n)*(1+u_nadh_c_n/Kmnadhcmdh_n)-1))
ASPTA_n(u_glu_L_c_n,u_asp_L_c_n,u_oaa_c_n,u_akg_c_n) = 0.41520656916529813*(VfCAAT_n*(u_asp_L_c_n*u_akg_c_n-u_oaa_c_n*u_glu_L_c_n/KeqCAAT_n)/(KmAKG_CAAT_n*u_asp_L_c_n+KmASP_CAAT_n*(1.0+u_akg_c_n/KiAKG_CAAT_n)*u_akg_c_n+u_asp_L_c_n*u_akg_c_n+KmASP_CAAT_n*u_akg_c_n*u_glu_L_c_n/KiGLU_CAAT_n+(KiASP_CAAT_n*KmAKG_CAAT_n/(KmOXA_CAAT_n*KiGLU_CAAT_n))*(KmGLU_CAAT_n*u_asp_L_c_n*u_oaa_c_n/KiASP_CAAT_n+u_oaa_c_n*u_glu_L_c_n+KmGLU_CAAT_n*(1.0+u_akg_c_n/KiAKG_CAAT_n)*u_oaa_c_n+KmOXA_CAAT_n*u_glu_L_c_n)))
ASPGLUm_n(u_h_c_n,u_glu_L_c_n,u_asp_L_m_n,u_asp_L_c_n,u_notBigg_MitoMembrPotent_m_n,u_glu_L_m_n,u_h_m_n) = 0.4503437195810003*(Vmaxagc_n*(u_asp_L_m_n*u_glu_L_c_n-u_asp_L_c_n*u_glu_L_m_n/((exp(u_notBigg_MitoMembrPotent_m_n)^(F/(R*T)))*(u_h_c_n/u_h_m_n)))/((u_asp_L_m_n+Km_aspmito_agc_n)*(u_glu_L_c_n+Km_glu_agc_n)+(u_asp_L_c_n+Km_asp_agc_n)*(u_glu_L_m_n+Km_glumito_agc_n)))
AKGMALtm_n(u_mal_L_c_n,u_akg_m_n,u_akg_c_n,u_mal_L_m_n) = 0.5282482511021107*(Vmaxmakgc_n*(u_mal_L_c_n*u_akg_m_n-u_mal_L_m_n*u_akg_c_n)/((u_mal_L_c_n+Km_mal_mkgc_n)*(u_akg_m_n+Km_akgmito_mkgc_n)+(u_mal_L_m_n+Km_malmito_mkgc_n)*(u_akg_c_n+Km_akg_mkgc_n)))
r0509_a(u_nadh_m_a,u_pi_m_a) = 0.8263357313080135*(x_DH_a*(r_DH_a*NAD_x_a-(1e-3*u_nadh_m_a))*((1+(1e-3*u_pi_m_a)/k_Pi1)/(1+(1e-3*u_pi_m_a)/k_Pi2)))
NADH2_u10mi_a(u_nadh_m_a,u_q10h2_m_a) = 0.8604610299528399*(x_C1*(exp(-(dG_C1op_a+4*dG_H_a)/etcRT)*(1e-3*u_nadh_m_a)*Q_a-NAD_x_a*(1e-3*u_q10h2_m_a)))
CYOR_u10mi_a(u_focytC_m_a,u_q10h2_m_a,u_pi_m_a,u_notBigg_MitoMembrPotent_m_a) = 0.7720733909302896*(x_C3*((1+(1e-3*u_pi_m_a)/k_Pi3)/(1+(1e-3*u_pi_m_a)/k_Pi4))*(exp(-(dG_C3op_a+4*dG_H_a-2*etcF*u_notBigg_MitoMembrPotent_m_a)/(2*etcRT))*Cox_a*(1e-3*u_q10h2_m_a)^0.5-(1e-3*u_focytC_m_a)*Q_a^0.5))
CYOOm2i_a(u_notBigg_Ctot_m_a,u_focytC_m_a,u_notBigg_MitoMembrPotent_m_a,u_o2_c_a) = 0.8836779655353504*(x_C4*((1e-3*u_o2_c_a)/((1e-3*u_o2_c_a)+k_O2))*((1e-3*u_focytC_m_a)/(1e-3*u_notBigg_Ctot_m_a))*(exp(-(dG_C4op_a+2*dG_H_a)/(2*etcRT))*(1e-3*u_focytC_m_a)*((1e-3*u_o2_c_a)^0.25)-Cox_a*exp(etcF*u_notBigg_MitoMembrPotent_m_a/etcRT)))
ATPS4mi_a(u_notBigg_ATP_mx_m_a,u_pi_m_a,u_notBigg_ADP_mx_m_a) = 0.794495760350036*(x_F1_a*(exp(-(dG_F1op_a-n_A*dG_H_a)/etcRT)*(K_DD_a/K_DT_a)*(1e-3*u_notBigg_ADP_mx_m_a)*(1e-3*u_pi_m_a)-(1e-3*u_notBigg_ATP_mx_m_a)))
ATPtm_a(u_notBigg_MitoMembrPotent_m_a) = 1*(x_ANT_a*(ADP_fi_a/(ADP_fi_a+ATP_fi_a*exp(-etcF*(0.35*u_notBigg_MitoMembrPotent_m_a)/etcRT))-ADP_fx_a/(ADP_fx_a+ATP_fx_a*exp(-etcF*(-0.65*u_notBigg_MitoMembrPotent_m_a)/etcRT)))*(ADP_fi_a/(ADP_fi_a+k_mADP_a)))
notBigg_J_Pi1_a(u_h_i_a,u_h_m_a) = 1*(x_Pi1*((1e-3*u_h_m_a)*H2PIi_a-(1e-3*u_h_i_a)*H2PIx_a)/(H2PIi_a+k_PiH))
notBigg_J_Hle_a(u_h_i_a,u_h_m_a,u_notBigg_MitoMembrPotent_m_a) = 1*(x_Hle*u_notBigg_MitoMembrPotent_m_a*((1e-3*u_h_i_a)*exp(etcF*u_notBigg_MitoMembrPotent_m_a/etcRT)-(1e-3*u_h_m_a))/(exp(etcF*u_notBigg_MitoMembrPotent_m_a/etcRT)-1))
notBigg_J_KH_a(u_h_i_a,u_h_m_a,u_k_m_a) = 1*(x_KH*(K_i*(1e-3*u_h_m_a)-(1e-3*u_k_m_a)*(1e-3*u_h_i_a)))
notBigg_J_K_a(u_k_m_a,u_notBigg_MitoMembrPotent_m_a) = 1*(x_K*u_notBigg_MitoMembrPotent_m_a*(K_i*exp(etcF*u_notBigg_MitoMembrPotent_m_a/etcRT)-(1e-3*u_k_m_a))/(exp(etcF*u_notBigg_MitoMembrPotent_m_a/etcRT)-1))
ADK1m_a(u_atp_i_a,u_adp_i_a,u_amp_i_a) = 1*(x_AK*(K_AK*(1e-3*u_adp_i_a)*(1e-3*u_adp_i_a)-(1e-3*u_amp_i_a)*(1e-3*u_atp_i_a)))
notBigg_J_AMP_a(u_amp_i_a,u_amp_c_a) = 1*(gamma*x_A*((1e-3*u_amp_c_a)-(1e-3*u_amp_i_a)))
notBigg_J_ADP_a(u_adp_c_a,u_adp_i_a) = 1*(gamma*x_A*((1e-3*u_adp_c_a)-(1e-3*u_adp_i_a)))
notBigg_J_ATP_a(u_atp_i_a,u_atp_c_a) = 1*(gamma*x_A*((1e-3*u_atp_c_a)-(1e-3*u_atp_i_a)))
notBigg_J_Pi2_a(u_pi_i_a,u_pi_c_a) = 1*(gamma*x_Pi2*(1e-3*u_pi_c_a-(1e-3*u_pi_i_a)))
notBigg_J_Ht_a(u_h_i_a,u_h_c_a) = 1*(gamma*x_Ht*(1e-3*u_h_c_a-(1e-3*u_h_i_a)))
notBigg_J_MgATPx_a(u_notBigg_ATP_mx_m_a,u_mg2_m_a) = 1*(x_MgA*(ATP_fx_a*(1e-3*u_mg2_m_a)-K_DT_a*(1e-3*u_notBigg_ATP_mx_m_a)))
notBigg_J_MgADPx_a(u_notBigg_ADP_mx_m_a,u_mg2_m_a) = 1*(x_MgA*(ADP_fx_a*(1e-3*u_mg2_m_a)-K_DD_a*(1e-3*u_notBigg_ADP_mx_m_a)))
notBigg_J_MgATPi_a(u_notBigg_ATP_mi_i_a) = 1*(x_MgA*(ATP_fi_a*Mg_i_a-K_DT_a*(1e-3*u_notBigg_ATP_mi_i_a)))
notBigg_J_MgADPi_a(u_notBigg_ADP_mi_i_a) = 1*(x_MgA*(ADP_fi_a*Mg_i_a-K_DD_a*(1e-3*u_notBigg_ADP_mi_i_a)))
PDHm_a(u_nad_m_a,u_pyr_m_a,u_coa_m_a) = 0.6203100331393553*(VmaxPDHCmito_a*(u_pyr_m_a/(u_pyr_m_a+KmPyrMitoPDH_a))*(u_nad_m_a/(u_nad_m_a+KmNADmitoPDH_na))*(u_coa_m_a/(u_coa_m_a+KmCoAmitoPDH_a)))
CSm_a(u_oaa_m_a,u_cit_m_a,u_accoa_m_a,u_coa_m_a) = 1*(VmaxCSmito_a*(u_oaa_m_a/(u_oaa_m_a+KmOxaMito_a*(1.0+u_cit_m_a/KiCitMito_a)))*(u_accoa_m_a/(u_accoa_m_a+KmAcCoAmito_a*(1.0+u_coa_m_a/KiCoA_a))))
ACONTm_a(u_cit_m_a,u_icit_m_a) = 0.48342767640154766*(VmaxAco_a*(u_cit_m_a-u_icit_m_a/KeqAco_na)/(1.0+u_cit_m_a/KmCitAco_a+u_icit_m_a/KmIsoCitAco_a))
ICDHxm_a(u_nad_m_a,u_nadh_m_a,u_icit_m_a) = 0.7197104602792509*(VmaxIDH_a*(u_nad_m_a/KiNADmito_na)*((u_icit_m_a/KmIsoCitIDHm_a)^nIDH)/(1.0+u_nad_m_a/KiNADmito_na+(KmNADmito_na/KiNADmito_na)*((u_icit_m_a/KmIsoCitIDHm_a)^nIDH)+u_nadh_m_a/KiNADHmito_na+(u_nad_m_a/KiNADmito_na)*((u_icit_m_a/KmIsoCitIDHm_a)^nIDH)+((KmNADmito_na*u_nadh_m_a)/(KiNADmito_na*KiNADHmito_na))*((u_icit_m_a/KmIsoCitIDHm_a)^nIDH)))
AKGDm_a(u_coa_m_a,u_nadh_m_a,u_akg_m_a,u_ca2_m_a,u_nad_m_a,u_succoa_m_a,u_atp_m_a,u_adp_m_a) = 1*((VmaxKGDH_a*(1+u_adp_m_a/KiADPmito_KGDH_a)*(u_akg_m_a/Km1KGDHKGDH_a)*(u_coa_m_a/Km_CoA_kgdhKGDH_a)*(u_nad_m_a/KmNADkgdhKGDH_na))/(((u_coa_m_a/Km_CoA_kgdhKGDH_a)*(u_nad_m_a/KmNADkgdhKGDH_na)*(u_akg_m_a/Km1KGDHKGDH_a+(1+u_atp_m_a/KiATPmito_KGDH_a)/(1+u_ca2_m_a/KiCa2KGDH_a)))+((u_akg_m_a/Km1KGDHKGDH_a)*(u_coa_m_a/Km_CoA_kgdhKGDH_a+u_nad_m_a/KmNADkgdhKGDH_na)*(1+u_nadh_m_a/KiNADHKGDHKGDH_na+u_succoa_m_a/Ki_SucCoA_kgdhKGDH_a))))
SUCOASm_a(u_coa_m_a,u_succoa_m_a,u_atp_m_a,u_succ_m_a,u_pi_m_a,u_adp_m_a) = 1.3146510580492397*(VmaxSuccoaATPscs_a*(1+AmaxPscs_a*((u_pi_m_a^npscs_a)/((u_pi_m_a^npscs_a)+(Km_pi_scs_na^npscs_a))))*(u_succoa_m_a*u_adp_m_a*u_pi_m_a-u_succ_m_a*u_coa_m_a*u_atp_m_a/Keqsuccoascs_na)/((1+u_succoa_m_a/Km_succoa_scs_a)*(1+u_adp_m_a/Km_ADPmito_scs_a)*(1+u_pi_m_a/Km_pi_scs_na)+(1+u_succ_m_a/Km_succ_scs_a)*(1+u_coa_m_a/Km_coa_scs_a)*(1+u_atp_m_a/Km_atpmito_scs_a)))
FUMm_a(u_mal_L_m_a,u_fum_m_a) = 0.6995126037645376*(Vmaxfum_a*(u_fum_m_a-u_mal_L_m_a/Keqfummito_na)/(1.0+u_fum_m_a/Km_fummito_a+u_mal_L_m_a/Km_malmito_a))
MDHm_a(u_nad_m_a,u_oaa_m_a,u_mal_L_m_a,u_nadh_m_a) = 1.2266010315633475*(VmaxMDHmito_a*(u_mal_L_m_a*u_nad_m_a-u_oaa_m_a*u_nadh_m_a/Keqmdhmito_na)/((1.0+u_mal_L_m_a/Km_mal_mdh_a)*(1.0+u_nad_m_a/Km_nad_mdh_na)+(1.0+u_oaa_m_a/Km_oxa_mdh_a)*(1.0+u_nadh_m_a/Km_nadh_mdh_na)))

PCm_a(u_co2_m_a,u_oaa_m_a,u_pyr_m_a,u_atp_m_a,u_adp_m_a) = 1*(((u_atp_m_a/u_adp_m_a)/(muPYRCARB_a+(u_atp_m_a/u_adp_m_a)))*VmPYRCARB_a*(u_pyr_m_a*u_co2_m_a-u_oaa_m_a/KeqPYRCARB_a)/(KmPYR_PYRCARB_a*KmCO2_PYRCARB_a+KmPYR_PYRCARB_a*u_co2_m_a+KmCO2_PYRCARB_a*u_pyr_m_a+u_co2_m_a*u_pyr_m_a))

PCm_n(u_co2_m_n,u_oaa_m_n,u_pyr_m_n,u_atp_m_n,u_adp_m_n) = neurastrExprRatio*(((u_atp_m_n/u_adp_m_n)/(muPYRCARB_a+(u_atp_m_n/u_adp_m_n)))*VmPYRCARB_a*(u_pyr_m_n*u_co2_m_n-u_oaa_m_n/KeqPYRCARB_a)/(KmPYR_PYRCARB_a*KmCO2_PYRCARB_a+KmPYR_PYRCARB_a*u_co2_m_n+KmCO2_PYRCARB_a*u_pyr_m_n+u_co2_m_n*u_pyr_m_n))


GLNt4_n(u_gln_L_c_n,u_gln_L_e_e) = 0.5978404130935905*(TmaxSNAT_GLN_n*(u_gln_L_e_e-u_gln_L_c_n/coeff_gln_ratio_n_ecs)/(KmSNAT_GLN_n+u_gln_L_c_n))
GLUNm_n(u_gln_L_c_n,u_glu_L_m_n) = 0.8547630950925981*(VmGLS_n*(u_gln_L_c_n-u_glu_L_m_n/KeqGLS_n)/(KmGLNGLS_n*(1.0+u_glu_L_m_n/KiGLUGLS_n)+u_gln_L_c_n))

GLUt6_a(u_na1_c_a,u_notBigg_Va_c_a,u_k_e_e,u_glu_L_syn_syn,u_k_c_a,u_glu_L_c_a) = 0.6342335524337793*(-((1/(2*F*1e-3))*(-alpha_EAAT*exp(-beta_EAAT*(u_notBigg_Va_c_a-((R*T/(2*F*1e-3))*log(((Na_syn_EAAT/u_na1_c_a)^3)*(H_syn_EAAT/H_ast_EAAT)*(u_glu_L_syn_syn/u_glu_L_c_a)*(u_k_c_a/u_k_e_e))))))))
# GLUt6_n(u_na1_c_a,u_notBigg_Va_c_a,u_k_e_e,u_glu_L_syn_syn,u_k_c_a,u_glu_L_c_a) = 1.2838313926690346*(-((1/(2*F*1e-3))*(-alpha_EAAT*exp(-beta_EAAT*(u_notBigg_Va_c_a-((R*T/(2*F*1e-3))*log(((Na_syn_EAAT/u_na1_c_a)^3)*(H_syn_EAAT/H_ast_EAAT)*(u_glu_L_syn_syn/u_glu_L_c_a)*(u_k_c_a/u_k_e_e))))))))


GLUDxm_a(u_nad_m_a,u_nadh_m_a,u_glu_L_c_a,u_akg_m_a) = 0.6314857335088516*(VmGDH_a*(u_nad_m_a*u_glu_L_c_a-u_nadh_m_a*u_akg_m_a/KeqGDH_a)/(KiNAD_GDH_a*KmGLU_GDH_a+KmGLU_GDH_a*u_nad_m_a+KiNAD_GDH_a*u_glu_L_c_a+u_glu_L_c_a*u_nad_m_a+u_glu_L_c_a*u_nad_m_a/KiAKG_GDH_a+KiNAD_GDH_a*KmGLU_GDH_a*u_nadh_m_a/KiNADH_GDH_a+KiNAD_GDH_a*KmGLU_GDH_a*KmNADH_GDH_a*u_akg_m_a/(KiAKG_GDH_a*KiNADH_GDH_a)+KmNADH_GDH_a*u_glu_L_c_a*u_nadh_m_a/KiNADH_GDH_a+KiNAD_GDH_a*KmGLU_GDH_a*KmAKG_GDH_a*u_nadh_m_a/(KiAKG_GDH_a*KiNADH_GDH_a)+KiNAD_GDH_a*KmGLU_GDH_a*KmAKG_GDH_a*u_akg_m_a*u_nadh_m_a/(KiAKG_GDH_a*KiNADH_GDH_a)+u_glu_L_c_a*u_nad_m_a*u_akg_m_a/KiAKG_GDH_a+KiNAD_GDH_a*KmGLU_GDH_a*KmAKG_GDH_a/KiAKG_GDH_a+KiNAD_GDH_a*KmGLU_GDH_a*u_glu_L_c_a*u_nadh_m_a*u_akg_m_a/(KiGLU_GDH_a*KiAKG_GDH_a*KiNADH_GDH_a)+KiNAD_GDH_a*KmGLU_GDH_a*u_akg_m_a*u_nadh_m_a/(KiAKG_GDH_a*KiNADH_GDH_a)+KmNADH_GDH_a*KmGLU_GDH_a*u_akg_m_a*u_nad_m_a/(KiAKG_GDH_a*KiNADH_GDH_a)))
GLNS_a(u_adp_c_a,u_atp_c_a,u_glu_L_c_a) = 0.6746220548756291*(VmaxGLNsynth_a*(u_glu_L_c_a/(KmGLNsynth_a+u_glu_L_c_a))*((1/(u_atp_c_a/u_adp_c_a))/(muGLNsynth_a+(1/(u_atp_c_a/u_adp_c_a)))))
GLNt4_a(u_gln_L_c_a,u_gln_L_e_e) = 1*(TmaxSNAT_GLN_a*(u_gln_L_c_a-u_gln_L_e_e)/(KmSNAT_GLN_a+u_gln_L_c_a))
notBigg_FinDyn_W2017(t) = 1*(global_par_F_0*(1+global_par_delta_F*(1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1-3))))-1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1+global_par_t_fin+3)))))))
notBigg_Fout_W2017(t,u_notBigg_vV_b_b) = 1*(global_par_F_0*((u_notBigg_vV_b_b/u0_ss[111])^2+(u_notBigg_vV_b_b/u0_ss[111])^(-0.5)*global_par_tau_v/u0_ss[111]*(global_par_F_0*(1+global_par_delta_F*(1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1-3))))-1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1+global_par_t_fin+3))))))))/(1+global_par_F_0*(u_notBigg_vV_b_b/u0_ss[111])^(-0.5)*global_par_tau_v/u0_ss[111]))
notBigg_JdHbin(t,u_o2_b_b) = 1*(2*(C_O_a-u_o2_b_b)*(global_par_F_0*(1+global_par_delta_F*(1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1-3))))-1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1+global_par_t_fin+3))))))))
notBigg_JdHbout(t,u_notBigg_ddHb_b_b,u_notBigg_vV_b_b) = 1*((u_notBigg_ddHb_b_b/u_notBigg_vV_b_b)*(global_par_F_0*((u_notBigg_vV_b_b/u0_ss[111])^2+(u_notBigg_vV_b_b/u0_ss[111])^(-0.5)*global_par_tau_v/u0_ss[111]*(global_par_F_0*(1+global_par_delta_F*(1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1-3))))-1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1+global_par_t_fin+3))))))))/(1+global_par_F_0*(u_notBigg_vV_b_b/u0_ss[111])^(-0.5)*global_par_tau_v/u0_ss[111])))
notBigg_JO2art2cap(t,u_o2_b_b) = 1*((1/eto_b)*2*(C_O_a-u_o2_b_b)*(global_par_F_0*(1+global_par_delta_F*(1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1-3))))-1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1+global_par_t_fin+3))))))))
notBigg_JO2fromCap2a(u_o2_b_b,u_o2_c_a) = 1*((PScapA*(KO2b*(HbOP/u_o2_b_b-1.)^(-1/param_degree_nh)-u_o2_c_a)))
notBigg_JO2fromCap2n(u_o2_b_b,u_o2_c_n) = 1*((PScapNAratio*PScapA*(KO2b*(HbOP/u_o2_b_b-1.)^(-1/param_degree_nh)-u_o2_c_n)))
notBigg_trGLC_art_cap(t,u_glc_D_b_b) = 1*((1/eto_b)*(2*(C_Glc_a-u_glc_D_b_b))*(global_par_F_0*(1+global_par_delta_F*(1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1-3))))-1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1+global_par_t_fin+3))))))))
notBigg_JGlc_be(u_glc_D_ecsEndothelium_ecsEndothelium,u_glc_D_b_b) = 0.3904811708729737*(TmaxGLCce*(u_glc_D_b_b*(KeG+u_glc_D_ecsEndothelium_ecsEndothelium)-u_glc_D_ecsEndothelium_ecsEndothelium*(KeG+u_glc_D_b_b))/(KeG^2+KeG*ReGoi*u_glc_D_b_b+KeG*ReGio*u_glc_D_ecsEndothelium_ecsEndothelium+ReGee*u_glc_D_b_b*u_glc_D_ecsEndothelium_ecsEndothelium))
notBigg_JGlc_e2ecsBA(u_glc_D_ecsBA_ecsBA,u_glc_D_ecsEndothelium_ecsEndothelium) = 0.3904811708729737*(TmaxGLCeb*(u_glc_D_ecsEndothelium_ecsEndothelium*(KeG2+u_glc_D_ecsBA_ecsBA)-u_glc_D_ecsBA_ecsBA*(KeG2+u_glc_D_ecsEndothelium_ecsEndothelium))/(KeG2^2+KeG2*ReGoi2*u_glc_D_ecsEndothelium_ecsEndothelium+KeG2*ReGio2*u_glc_D_ecsBA_ecsBA+ReGee2*u_glc_D_ecsEndothelium_ecsEndothelium*u_glc_D_ecsBA_ecsBA))
notBigg_JGlc_ecsBA2a(u_glc_D_ecsBA_ecsBA,u_glc_D_c_a) = 1*(TmaxGLCba*(u_glc_D_ecsBA_ecsBA*(KeG3+u_glc_D_c_a)-u_glc_D_c_a*(KeG3+u_glc_D_ecsBA_ecsBA))/(KeG3^2+KeG3*ReGoi3*u_glc_D_ecsBA_ecsBA+KeG3*ReGio3*u_glc_D_c_a+ReGee3*u_glc_D_ecsBA_ecsBA*u_glc_D_c_a))
notBigg_JGlc_a2ecsAN(u_glc_D_ecsAN_ecsAN,u_glc_D_c_a) = 1*(TmaxGLCai*(u_glc_D_c_a*(KeG4+u_glc_D_ecsAN_ecsAN)-u_glc_D_ecsAN_ecsAN*(KeG4+u_glc_D_c_a))/(KeG4^2+KeG4*ReGoi4*u_glc_D_c_a+KeG4*ReGio4*u_glc_D_ecsAN_ecsAN+ReGee4*u_glc_D_c_a*u_glc_D_ecsAN_ecsAN))
notBigg_JGlc_ecsAN2n(u_glc_D_c_n,u_glc_D_ecsAN_ecsAN) = 0.7897515941368937*(TmaxGLCin*(u_glc_D_ecsAN_ecsAN*(KeG5+u_glc_D_c_n)-u_glc_D_c_n*(KeG5+u_glc_D_ecsAN_ecsAN))/(KeG5^2+KeG5*ReGoi5*u_glc_D_ecsAN_ecsAN+KeG5*ReGio5*u_glc_D_c_n+ReGee5*u_glc_D_ecsAN_ecsAN*u_glc_D_c_n))
notBigg_JGlc_diffEcs(u_glc_D_ecsBA_ecsBA,u_glc_D_ecsAN_ecsAN) = 1*(kGLCdiff*(u_glc_D_ecsBA_ecsBA-u_glc_D_ecsAN_ecsAN))
GLCS2_a(u_notBigg_GS_c_a,u_udpg_c_a) = 1*(kL2_GS_a*u_notBigg_GS_c_a*u_udpg_c_a/(kmL2_GS_a+u_udpg_c_a))
GLCP_a(u_glycogen_c_a,u_notBigg_GPa_c_a,u_camp_c_a,u_notBigg_GPb_c_a) = 1.1256906446836974*((u_notBigg_GPa_c_a/(u_notBigg_GPa_c_a+u_notBigg_GPb_c_a))*VmaxGP_a*u_glycogen_c_a*(1/(1+(KmGP_AMP_a^hGPa)/(u_camp_c_a^hGPa))))
PGMT_a(u_g1p_c_a,u_g6p_c_a) = 1*((Vmaxfpglm_a*u_g1p_c_a/KmG1PPGLM_a-((Vmaxfpglm_a*KmG6PPGLM_a)/(KmG1PPGLM_a*KeqPGLM_a))*u_g6p_c_a/KmG6PPGLM_a)/(1.0+u_g1p_c_a/KmG1PPGLM_a+u_g6p_c_a/KmG6PPGLM_a))
PDE1_a(u_camp_c_a) = 1*(VmaxPDE_a*u_camp_c_a/(Kmcamppde_a+u_camp_c_a))
GALUi_a(u_ppi_c_a,u_g1p_c_a,u_udpg_c_a,u_utp_c_a) = 0.5592071627317753*((VmaxfUDPGP*u_utp_c_a*u_g1p_c_a/(KutpUDPGP*Kg1pUDPGP)-VmaxrUDPGP*u_ppi_c_a*u_udpg_c_a/(KpiUDPGP*KUDPglucoUDPGP_a))/(1.0+u_g1p_c_a/Kg1pUDPGP+u_utp_c_a/KutpUDPGP+(u_g1p_c_a*u_utp_c_a)/(Kg1pUDPGP*KutpUDPGP)+u_udpg_c_a/KUDPglucoUDPGP_a+u_ppi_c_a/KpiUDPGP+(u_ppi_c_a*u_udpg_c_a)/(KpiUDPGP*KUDPglucoUDPGP_a)))
notBigg_psiGSAJay_a(u_notBigg_GS_c_a,u_udpg_c_a,u_notBigg_PHKa_c_a,u_notBigg_PKAa_c_a) = 1*(((kg8_GSAJay*PP1_a0*(st_GSAJay-u_notBigg_GS_c_a))/((kmg8_GSAJay/(1.0+s1_GSAJay*u_udpg_c_a/kg2_GSAJay))+(st_GSAJay-u_notBigg_GS_c_a)))-((kg7_GSAJay*(u_notBigg_PHKa_c_a+u_notBigg_PKAa_c_a)*u_notBigg_GS_c_a)/(kmg7_GSAJay*(1+s1_GSAJay*u_udpg_c_a/kg2_GSAJay)+u_notBigg_GS_c_a)))
notBigg_psiPHK_a(u_ca2_c_a,u_glycogen_c_a,u_g1p_c_a,u_notBigg_PHKa_c_a,u_notBigg_GPa_c_a,u_udpg_c_a) = 0.6024486647140077*((u_ca2_c_a/cai0_ca_ion)*(((kg5_PHK*u_notBigg_PHKa_c_a*(pt_PHK-u_notBigg_GPa_c_a))/(kmg5_PHK*(1.0+s1_PHK*u_g1p_c_a/kg2_PHK)+(pt_PHK-u_notBigg_GPa_c_a)))-((kg6_PHK*PP1_a0*u_notBigg_GPa_c_a)/(kmg6_PHK/(1+s2_PHK*u_udpg_c_a/kgi_PHK)+u_notBigg_GPa_c_a))-((0.003198/(1+u_glycogen_c_a)+kmind_PHK)*PP1_a0*u_notBigg_GPa_c_a)))
HEX1_n(u_glc_D_c_n,u_atp_c_n,u_g6p_c_n) = 0.8609297660662427*((VmaxHK_n*u_glc_D_c_n/(u_glc_D_c_n+KmHK_n))*(u_atp_c_n/(1+(u_atp_c_n/KIATPhex_n)^nHhexn))*(1/(1+u_g6p_c_n/KiHKG6P_n)))
HEX1_a(u_atp_c_a,u_g6p_c_a,u_glc_D_c_a) = 1*((VmaxHK_a*u_glc_D_c_a/(u_glc_D_c_a+KmHK_a))*(u_atp_c_a/(1+(u_atp_c_a/KIATPhex_a)^nHhexa))*(1/(1+u_g6p_c_a/KiHKG6P_a)))
PGI_n(u_f6p_c_n,u_g6p_c_n) = 0.5976049296442596*((Vmax_fPGI_n*(u_g6p_c_n/Km_G6P_fPGI_n-0.9*u_f6p_c_n/Km_F6P_rPGI_n))/(1.0+u_g6p_c_n/Km_G6P_fPGI_n+u_f6p_c_n/Km_F6P_rPGI_n))
PGI_a(u_g6p_c_a,u_f6p_c_a) = 1*((Vmax_fPGI_a*(u_g6p_c_a/Km_G6P_fPGI_a-0.9*u_f6p_c_a/Km_F6P_rPGI_a))/(1.0+u_g6p_c_a/Km_G6P_fPGI_a+u_f6p_c_a/Km_F6P_rPGI_a))
PFK_n(u_f6p_c_n,u_atp_c_n) = 0.7458451538827402*(VmaxPFK_n*(u_atp_c_n/(1+(u_atp_c_n/KiPFK_ATP_na)^nPFKn))*(u_f6p_c_n/(u_f6p_c_n+KmPFKF6P_n)))
PFK_a(u_atp_c_a,u_f26bp_c_a,u_f6p_c_a) = 0.6004550301335743*(VmaxPFK_a*(u_atp_c_a/(1+(u_atp_c_a/KiPFK_ATP_a)^nPFKa))*(u_f6p_c_a/(u_f6p_c_a+KmPFKF6P_a*(1-KoPFK_f26bp_a*((u_f26bp_c_a^nPFKf26bp_a)/(KmF26BP_PFK_a^nPFKf26bp_a+u_f26bp_c_a^nPFKf26bp_a)))))*(u_f26bp_c_a/(KmF26BP_PFK_a+u_f26bp_c_a)))
PFK26_a(u_adp_c_a,u_atp_c_a,u_f26bp_c_a,u_f6p_c_a) = 1*(Vmax_PFKII_g*u_f6p_c_a*u_atp_c_a*u_adp_c_a/((u_f6p_c_a+Kmf6pPFKII_g)*(u_atp_c_a+KmatpPFKII_g)*(u_adp_c_a+Km_act_adpPFKII_g))-(Vmax_PFKII_g*u_f26bp_c_a/(u_f26bp_c_a+Km_f26bp_f_26pase_g*(1+u_f6p_c_a/Ki_f6p_f_26_pase_g))))
FBA_n(u_fdp_c_n,u_dhap_c_n,u_g3p_c_n) = 0.7394718950651101*(Vmaxald_n*(u_fdp_c_n-u_g3p_c_n*u_dhap_c_n/Keqald_n)/((1+u_fdp_c_n/KmfbpAld_n)+(1+u_g3p_c_n/KmgapAld_n)*(1+u_dhap_c_n/KmdhapAld_n)-1))
FBA_a(u_g3p_c_a,u_fdp_c_a,u_dhap_c_a) = 1.3698862447606868*(Vmaxald_a*(u_fdp_c_a-u_g3p_c_a*u_dhap_c_a/Keqald_a)/((1+u_fdp_c_a/KmfbpAld_a)+(1+u_g3p_c_a/KmgapAld_a)*(1+u_dhap_c_a/KmdhapAld_a)-1))
TPI_n(u_dhap_c_n,u_g3p_c_n) = 0.43581417628746805*(Vmaxtpi_n*(u_dhap_c_n-u_g3p_c_n/Keqtpi_n)/(1+u_dhap_c_n/KmdhapTPI_n+u_g3p_c_n/KmgapTPI_n))
TPI_a(u_g3p_c_a,u_dhap_c_a) = 1*(Vmaxtpi_a*(u_dhap_c_a-u_g3p_c_a/Keqtpi_a)/(1+u_dhap_c_a/KmdhapTPI_a+u_g3p_c_a/KmgapTPI_a))
GAPD_n(u_nadh_c_n,u_nad_c_n,u_g3p_c_n,u_pi_c_n,u_13dpg_c_n) = 0.671837442539098*(Vmaxgapdh_n*(u_nad_c_n*u_g3p_c_n*u_pi_c_n-u_13dpg_c_n*u_nadh_c_n/Keqgapdh_na)/((1+u_nad_c_n/KmnadGpdh_n)*(1+u_g3p_c_n/KmGapGapdh_n)*(1+u_pi_c_n/KmpiGpdh_n)+(1+u_nadh_c_n/KmnadhGapdh_n)*(1+u_13dpg_c_n/KmBPG13Gapdh_n)-1))
GAPD_a(u_nadh_c_a,u_nad_c_a,u_pi_c_a,u_13dpg_c_a,u_g3p_c_a) = 1*(Vmaxgapdh_a*(u_nad_c_a*u_g3p_c_a*u_pi_c_a-u_13dpg_c_a*u_nadh_c_a/Keqgapdh_na)/((1+u_nad_c_a/KmnadGpdh_a)*(1+u_g3p_c_a/KmGapGapdh_a)*(1+u_pi_c_a/KmpiGpdh_a)+(1+u_nadh_c_a/KmnadhGapdh_a)*(1+u_13dpg_c_a/KmBPG13Gapdh_a)-1))
PGK_n(u_13dpg_c_n,u_3pg_c_n,u_atp_c_n,u_adp_c_n) = 0.5962295972157015*(Vmaxpgk_n*(u_13dpg_c_n*u_adp_c_n-u_3pg_c_n*u_atp_c_n/Keqpgk_na)/((1+u_13dpg_c_n/Kmbpg13pgk_n)*(1+u_adp_c_n/Kmadppgk_n)+(1+u_3pg_c_n/Kmpg3pgk_n)*(1+u_atp_c_n/Kmatppgk_n)-1))
PGK_a(u_adp_c_a,u_atp_c_a,u_3pg_c_a,u_13dpg_c_a) = 1*(Vmaxpgk_a*(u_13dpg_c_a*u_adp_c_a-u_3pg_c_a*u_atp_c_a/Keqpgk_na)/((1+u_13dpg_c_a/Kmbpg13pgk_a)*(1+u_adp_c_a/Kmadppgk_a)+(1+u_3pg_c_a/Kmpg3pgk_a)*(1+u_atp_c_a/Kmatppgk_a)-1))
PGM_n(u_2pg_c_n,u_3pg_c_n) = 0.709656099612707*(Vmaxpgm_n*(u_3pg_c_n-u_2pg_c_n/Keqpgm_n)/((1+u_3pg_c_n/Kmpg3pgm_n)+(1+u_2pg_c_n/Kmpg2pgm_n)-1))
PGM_a(u_2pg_c_a,u_3pg_c_a) = 0.8316195374288835*(Vmaxpgm_a*(u_3pg_c_a-u_2pg_c_a/Keqpgm_a)/((1+u_3pg_c_a/Kmpg3pgm_a)+(1+u_2pg_c_a/Kmpg2pgm_a)-1))
ENO_n(u_pep_c_n,u_2pg_c_n) = 0.679389216422442*(Vmaxenol_n*(u_2pg_c_n-u_pep_c_n/Keqenol_n)/((1+u_2pg_c_n/Kmpg2enol_n)+(1+u_pep_c_n/Km_pep_enol_n)-1))
ENO_a(u_2pg_c_a,u_pep_c_a) = 1*(Vmaxenol_a*(u_2pg_c_a-u_pep_c_a/Keqenol_a)/((1+u_2pg_c_a/Kmpg2enol_a)+(1+u_pep_c_a/Km_pep_enol_a)-1))
PYK_n(u_pep_c_n,u_atp_c_n,u_adp_c_n) = 1*(Vmaxpk_n*u_pep_c_n*u_adp_c_n/((u_pep_c_n+Km_pep_pk_n)*(u_adp_c_n+Km_adp_pk_n*(1+u_atp_c_n/Ki_ATP_pk_n))))
PYK_a(u_adp_c_a,u_atp_c_a,u_pep_c_a) = 1*(Vmaxpk_a*u_pep_c_a*u_adp_c_a/((u_pep_c_a+Km_pep_pk_a)*(u_adp_c_a+Km_adp_pk_a*(1+u_atp_c_a/Ki_ATP_pk_a))))
notBigg_JLacTr_b(u_lac_L_b_b,t) = 1*((2*(C_Lac_a-u_lac_L_b_b)/eto_b)*(global_par_F_0*(1+global_par_delta_F*(1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1-3))))-1/(1+exp((-4.59186)*(t-(global_par_t_0+global_par_t_1+global_par_t_fin+3))))))))
notBigg_MCT1_LAC_b(u_lac_L_b_b,u_lac_L_e_e) = 0.713341257512879*(TbLac*(u_lac_L_b_b/(u_lac_L_b_b+KbLac)-u_lac_L_e_e/(u_lac_L_e_e+KbLac)))
L_LACt2r_a(u_lac_L_e_e,u_lac_L_c_a) = 0.8508140076567653*(TaLac*(u_lac_L_e_e/(u_lac_L_e_e+Km_Lac_a)-u_lac_L_c_a/(u_lac_L_c_a+Km_Lac_a)))
L_LACt2r_n(u_lac_L_e_e,u_lac_L_c_n) = 0.45107525815399785*(TnLac*(u_lac_L_e_e/(u_lac_L_e_e+Km_LacTr_n)-u_lac_L_c_n/(u_lac_L_c_n+Km_LacTr_n)))
notBigg_jLacDiff_e(u_lac_L_e_e) = 1*(betaLacDiff*(u0_ss[150]-u_lac_L_e_e))
notBigg_vLACgc(u_lac_L_b_b,u_lac_L_c_a) = 0.8508140076567653*(TMaxLACgc*(u_lac_L_b_b/(u_lac_L_b_b+KtLACgc)-u_lac_L_c_a/(u_lac_L_c_a+KtLACgc)))
LDH_L_a(u_nad_c_a,u_nadh_c_a,u_lac_L_c_a,u_pyr_c_a) = 1.3088752137510924*(VmfLDH_a*u_pyr_c_a*u_nadh_c_a-KeLDH_a*VmfLDH_a*u_lac_L_c_a*u_nad_c_a)
LDH_L_n(u_nad_c_n,u_lac_L_c_n,u_nadh_c_n,u_pyr_c_n) = 0.5689693706174375*(VmfLDH_n*u_pyr_c_n*u_nadh_c_n-KeLDH_n*VmfLDH_n*u_lac_L_c_n*u_nad_c_n)
G6PDH2r_n(u_g6p_c_n,u_nadph_c_n,u_nadp_c_n,u_6pgl_c_n) = 0.8669025610198134*(VmaxG6PDH_n*(1/(K_G6P_G6PDH_n*K_NADP_G6PDH_n))*((u_g6p_c_n*u_nadp_c_n-u_6pgl_c_n*u_nadph_c_n/KeqG6PDH_n)/((1+u_g6p_c_n/K_G6P_G6PDH_n)*(1+u_nadp_c_n/K_NADP_G6PDH_n)+(1+u_6pgl_c_n/K_GL6P_G6PDH_n)*(1+u_nadph_c_n/K_NADPH_G6PDH_n)-1)))
G6PDH2r_a(u_6pgl_c_a,u_nadp_c_a,u_g6p_c_a,u_nadph_c_a) = 1*(VmaxG6PDH_a*(1/(K_G6P_G6PDH_a*K_NADP_G6PDH_a))*((u_g6p_c_a*u_nadp_c_a-u_6pgl_c_a*u_nadph_c_a/KeqG6PDH_a)/((1+u_g6p_c_a/K_G6P_G6PDH_a)*(1+u_nadp_c_a/K_NADP_G6PDH_a)+(1+u_6pgl_c_a/K_GL6P_G6PDH_a)*(1+u_nadph_c_a/K_NADPH_G6PDH_a)-1)))
PGL_n(u_6pgc_c_n,u_6pgl_c_n) = 1*(Vmax6PGL_n*(1/K_GL6P_6PGL_n)*((u_6pgl_c_n-u_6pgc_c_n/Keq6PGL_n)/((1+u_6pgl_c_n/K_GL6P_6PGL_n)+(1+u_6pgc_c_n/K_GO6P_6PGL_n)-1)))
PGL_a(u_6pgc_c_a,u_6pgl_c_a) = 1*(Vmax6PGL_a*(1/K_GL6P_6PGL_a)*((u_6pgl_c_a-u_6pgc_c_a/Keq6PGL_a)/((1+u_6pgl_c_a/K_GL6P_6PGL_a)+(1+u_6pgc_c_a/K_GO6P_6PGL_a)-1)))
GND_n(u_6pgc_c_n,u_nadph_c_n,u_nadp_c_n,u_ru5p_D_c_n) = 1*(Vmax6PGDH_n*(1/(K_GO6P_6PGDH_n*K_NADP_6PGDH_n))*(u_6pgc_c_n*u_nadp_c_n-u_ru5p_D_c_n*u_nadph_c_n/Keq6PGDH_n)/((1+u_6pgc_c_n/K_GO6P_6PGDH_n)*(1+u_nadp_c_n/K_NADP_6PGDH_n)+(1+u_ru5p_D_c_n/K_RU5P_6PGDH_n)*(1+u_nadph_c_n/K_NADPH_6PGDH_n)-1))
GND_a(u_6pgc_c_a,u_nadp_c_a,u_ru5p_D_c_a,u_nadph_c_a) = 1*(Vmax6PGDH_a*(1/(K_GO6P_6PGDH_a*K_NADP_6PGDH_a))*(u_6pgc_c_a*u_nadp_c_a-u_ru5p_D_c_a*u_nadph_c_a/Keq6PGDH_a)/((1+u_6pgc_c_a/K_GO6P_6PGDH_a)*(1+u_nadp_c_a/K_NADP_6PGDH_a)+(1+u_ru5p_D_c_a/K_RU5P_6PGDH_a)*(1+u_nadph_c_a/K_NADPH_6PGDH_a)-1))
RPI_n(u_r5p_c_n,u_ru5p_D_c_n) = 1*(VmaxRPI_n*(1/K_RU5P_RPI_n)*(u_ru5p_D_c_n-u_r5p_c_n/KeqRPI_n)/((1+u_ru5p_D_c_n/K_RU5P_RPI_n)+(1+u_r5p_c_n/K_R5P_RPI_n)-1))
RPI_a(u_r5p_c_a,u_ru5p_D_c_a) = 1*(VmaxRPI_a*(1/K_RU5P_RPI_a)*(u_ru5p_D_c_a-u_r5p_c_a/KeqRPI_a)/((1+u_ru5p_D_c_a/K_RU5P_RPI_a)+(1+u_r5p_c_a/K_R5P_RPI_a)-1))
RPE_n(u_xu5p_D_c_n,u_ru5p_D_c_n) = 0.7983535280369903*(VmaxRPE_n*(1/K_RU5P_RPE_n)*(u_ru5p_D_c_n-u_xu5p_D_c_n/KeqRPE_n)/((1+u_ru5p_D_c_n/K_RU5P_RPE_n)+(1+u_xu5p_D_c_n/K_X5P_RPE_n)-1))
RPE_a(u_ru5p_D_c_a,u_xu5p_D_c_a) = 1*(VmaxRPE_a*(1/K_RU5P_RPE_a)*(u_ru5p_D_c_a-u_xu5p_D_c_a/KeqRPE_a)/((1+u_ru5p_D_c_a/K_RU5P_RPE_a)+(1+u_xu5p_D_c_a/K_X5P_RPE_a)-1))
TKT1_n(u_s7p_c_n,u_r5p_c_n,u_xu5p_D_c_n,u_g3p_c_n) = 0.8883490961108477*(VmaxTKL1_n*(1/(K_X5P_TKL1_n*K_R5P_TKL1_n))*(u_xu5p_D_c_n*u_r5p_c_n-u_g3p_c_n*u_s7p_c_n/KeqTKL1_n)/((1+u_xu5p_D_c_n/K_X5P_TKL1_n)*(1+u_r5p_c_n/K_R5P_TKL1_n)+(1+u_g3p_c_n/K_GAP_TKL1_n)*(1+u_s7p_c_n/K_S7P_TKL1_n)-1))
TKT1_a(u_r5p_c_a,u_g3p_c_a,u_s7p_c_a,u_xu5p_D_c_a) = 0.8850284030244852*(VmaxTKL1_a*(1/(K_X5P_TKL1_a*K_R5P_TKL1_a))*(u_xu5p_D_c_a*u_r5p_c_a-u_g3p_c_a*u_s7p_c_a/KeqTKL1_a)/((1+u_xu5p_D_c_a/K_X5P_TKL1_a)*(1+u_r5p_c_a/K_R5P_TKL1_a)+(1+u_g3p_c_a/K_GAP_TKL1_a)*(1+u_s7p_c_a/K_S7P_TKL1_a)-1))
TKT2_n(u_f6p_c_n,u_e4p_c_n,u_xu5p_D_c_n,u_g3p_c_n) = 0.8883490961108477*(VmaxTKL2_n*(1/(K_F6P_TKL2_n*K_GAP_TKL2_n))*(u_f6p_c_n*u_g3p_c_n-u_xu5p_D_c_n*u_e4p_c_n/KeqTKL2_n)/((1+u_f6p_c_n/K_F6P_TKL2_n)*(1+u_g3p_c_n/K_GAP_TKL2_n)+(1+u_xu5p_D_c_n/K_X5P_TKL2_n)*(1+u_e4p_c_n/K_E4P_TKL2_n)-1))
TKT2_a(u_g3p_c_a,u_e4p_c_a,u_xu5p_D_c_a,u_f6p_c_a) = 0.8850284030244852*(VmaxTKL2_a*(1/(K_F6P_TKL2_a*K_GAP_TKL2_a))*(u_f6p_c_a*u_g3p_c_a-u_xu5p_D_c_a*u_e4p_c_a/KeqTKL2_a)/((1+u_f6p_c_a/K_F6P_TKL2_a)*(1+u_g3p_c_a/K_GAP_TKL2_a)+(1+u_xu5p_D_c_a/K_X5P_TKL2_a)*(1+u_e4p_c_a/K_E4P_TKL2_a)-1))
TALA_n(u_f6p_c_n,u_e4p_c_n,u_g3p_c_n,u_s7p_c_n) = 0.6639992687235359*(VmaxTAL_n*(1/(K_GAP_TAL_n*K_S7P_TAL_n))*(u_g3p_c_n*u_s7p_c_n-u_f6p_c_n*u_e4p_c_n/KeqTAL_n)/((1+u_g3p_c_n/K_GAP_TAL_n)*(1+u_s7p_c_n/K_S7P_TAL_n)+(1+u_f6p_c_n/K_F6P_TAL_n)*(1+u_e4p_c_n/K_E4P_TAL_n)-1))
TALA_a(u_g3p_c_a,u_e4p_c_a,u_s7p_c_a,u_f6p_c_a) = 1.2205175303641989*(VmaxTAL_a*(1/(K_GAP_TAL_a*K_S7P_TAL_a))*(u_g3p_c_a*u_s7p_c_a-u_f6p_c_a*u_e4p_c_a/KeqTAL_a)/((1+u_g3p_c_a/K_GAP_TAL_a)*(1+u_s7p_c_a/K_S7P_TAL_a)+(1+u_f6p_c_a/K_F6P_TAL_a)*(1+u_e4p_c_a/K_E4P_TAL_a)-1))
notBigg_psiNADPHox_n(u_nadph_c_n) = 1*(k1NADPHox_n*u_nadph_c_n)
notBigg_psiNADPHox_a(u_nadph_c_a) = 1*(k1NADPHox_a*u_nadph_c_a)
GTHO_n(u_nadph_c_n,u_gthox_c_n) = 0.7763893628874204*((Vmf_GSSGR_n*u_gthox_c_n*u_nadph_c_n)/((KmGSSGRGSSG_n+u_gthox_c_n)*(KmGSSGRNADPH_n+u_nadph_c_n)))
GTHO_a(u_gthox_c_a,u_nadph_c_a) = 1*((Vmf_GSSGR_a*u_gthox_c_a*u_nadph_c_a)/((KmGSSGRGSSG_a+u_gthox_c_a)*(KmGSSGRNADPH_a+u_nadph_c_a)))
GTHP_n(u_gthrd_c_n) = 1.405052609349276*(V_GPX_n*u_gthrd_c_n/(u_gthrd_c_n+KmGPXGSH_n))
GTHP_a(u_gthrd_c_a) = 1.0418536417455824*(V_GPX_a*u_gthrd_c_a/(u_gthrd_c_a+KmGPXGSH_a))
GTHS_n(u_gthrd_c_n) = 0.7800038574228693*(VmaxGSHsyn_n*(glycine_n*glutamylCys_n-u_gthrd_c_n/KeGSHSyn_n)/(Km_glutamylCys_GSHsyn_n*Km_glycine_GSHsyn_n+glutamylCys_n*Km_glutamylCys_GSHsyn_n+glycine_n*Km_glycine_GSHsyn_n*(1+glutamylCys_n/Km_glutamylCys_GSHsyn_n)+u_gthrd_c_n/KmGSHsyn_n))
GTHS_a(u_gthrd_c_a) = 1*(VmaxGSHsyn_a*(glycine_a*glutamylCys_a-u_gthrd_c_a/KeGSHSyn_a)/(Km_glutamylCys_GSHsyn_a*Km_glycine_GSHsyn_a+glutamylCys_a*Km_glutamylCys_GSHsyn_a+glycine_a*Km_glycine_GSHsyn_a*(1+glutamylCys_a/Km_glutamylCys_GSHsyn_a)+u_gthrd_c_a/KmGSHsyn_a))
ADNCYC_a(u_camp_c_a,u_atp_c_a) = 1*(((VmaxfAC_a*u_atp_c_a/(KmACATP_a*(1+u_camp_c_a/KicAMPAC_a))-VmaxrAC_a*u_camp_c_a/(KmpiAC_a*KmcAMPAC_a))/(1+u_atp_c_a/(KmACATP_a*(1+u_camp_c_a/KicAMPAC_a))+u_camp_c_a/KmcAMPAC_a)))
CKc_n(u_pcreat_c_n,u_atp_c_n,u_adp_c_n) = 0.32081154381027266*(kCKnps*u_pcreat_c_n*u_adp_c_n-KeqCKnpms*kCKnps*(Crtot-u_pcreat_c_n)*u_atp_c_n)
CKc_a(u_adp_c_a,u_atp_c_a,u_pcreat_c_a) = 1*(kCKgps*u_pcreat_c_a*u_adp_c_a-KeqCKgpms*kCKgps*(Crtot-u_pcreat_c_a)*u_atp_c_a)
PYRt2m_n(u_h_m_n,u_pyr_m_n,u_h_c_n,u_pyr_c_n) = 1.1810410492580787*(Vmax_PYRtrcyt2mito_nH*(u_pyr_c_n*u_h_c_n-u_pyr_m_n*u_h_m_n)/((1.0+u_pyr_c_n/KmPyrCytTr_n)*(1.0+u_pyr_m_n/KmPyrMitoTr_n)))
PYRt2m_a(u_h_m_a,u_pyr_c_a,u_h_c_a,u_pyr_m_a) = 1.1210261302822038*(Vmax_PYRtrcyt2mito_aH*(u_pyr_c_a*u_h_c_a-u_pyr_m_a*u_h_m_a)/((1.0+u_pyr_c_a/KmPyrCytTr_a)*(1.0+u_pyr_m_a/KmPyrMitoTr_a)))

notBigg_vShuttlen(u_nadh_m_n,u_nadh_c_n) = NADHshuttle_aging_n*(TnNADH_jlv*(u_nadh_c_n/(NAD_aging_coeff_n*0.212-u_nadh_c_n))/(MnCyto_jlv+(u_nadh_c_n/(NAD_aging_coeff_n*0.212-u_nadh_c_n)))*((1000*NADtot_n-u_nadh_m_n)/u_nadh_m_n)/(MnMito_jlv+((1000*NADtot_n-u_nadh_m_n)/u_nadh_m_n)))

notBigg_vShuttleg(u_nadh_c_a,u_nadh_m_a) = NADHshuttle_aging_a*(TgNADH_jlv*(u_nadh_c_a/(NAD_aging_coeff_a*0.212-u_nadh_c_a))/(MgCyto_jlv+(u_nadh_c_a/(NAD_aging_coeff_a*0.212-u_nadh_c_a)))*((1000*NADtot_a-u_nadh_m_a)/u_nadh_m_a)/(MgMito_jlv+((1000*NADtot_a-u_nadh_m_a)/u_nadh_m_a)))

notBigg_vMitooutn_n(u_nadh_m_n,u_nad_m_n,u_o2_c_n,u_adp_i_n,u_atp_i_n) = 1*(V_oxphos_n*((1/(u_atp_i_n/u_adp_i_n))/(mu_oxphos_n+(1/(u_atp_i_n/u_adp_i_n))))*((u_nadh_m_n/u_nad_m_n)/(nu_oxphos_n+(u_nadh_m_n/u_nad_m_n)))*(u_o2_c_n/(u_o2_c_n+K_oxphos_n)))
notBigg_vMitooutg_a(u_atp_i_a,u_nadh_m_a,u_nad_m_a,u_o2_c_a,u_adp_i_a) = 1*(V_oxphos_a*((1/(u_atp_i_a/u_adp_i_a))/(mu_oxphos_a+(1/(u_atp_i_a/u_adp_i_a))))*((u_nadh_m_a/u_nad_m_a)/(nu_oxphos_a+(u_nadh_m_a/u_nad_m_a)))*(u_o2_c_a/(u_o2_c_a+K_oxphos_a)))

notBigg_vMitoinn(u_pyr_m_n,u_nadh_m_n) = 1*(VMaxMitoinn*u_pyr_m_n/(u_pyr_m_n+KmMito)*(1000*NADtot_n-u_nadh_m_n)/(1000*NADtot_n-u_nadh_m_n+KmNADn_jlv))
notBigg_vMitoing(u_nadh_m_a,u_pyr_m_a) = 1*(VMaxMitoing*u_pyr_m_a/(u_pyr_m_a+KmMito_a)*(1000*NADtot_a-u_nadh_m_a)/(1000*NADtot_a-u_nadh_m_a+KmNADg_jlv))

du[1] = 0
du[2] = 0.5*T2Jcorrection*(1000*(notBigg_J_KH_n(u_h_m_n,u_h_i_n,u_k_m_n)+notBigg_J_K_n(u_k_m_n,u_notBigg_MitoMembrPotent_m_n))/W_x)
du[3] = 0.5*T2Jcorrection*(1000*(-notBigg_J_MgATPx_n(u_notBigg_ATP_mx_m_n,u_mg2_m_n)-notBigg_J_MgADPx_n(u_mg2_m_n,u_notBigg_ADP_mx_m_n))/W_x)
du[4] = 6.96*(notBigg_vMitoinn(u_pyr_m_n,u_nadh_m_n)+notBigg_vShuttlen(u_nadh_m_n,u_nadh_c_n)-notBigg_vMitooutn_n(u_nadh_m_n,u_nad_m_n,u_o2_c_n,u_adp_i_n,u_atp_i_n))
du[5] = 0.5*T2Jcorrection*(1000*(+NADH2_u10mi_n(u_nadh_m_n,u_q10h2_m_n)-CYOR_u10mi_n(u_focytC_m_n,u_notBigg_MitoMembrPotent_m_n,u_q10h2_m_n,u_pi_m_n))/W_x)
du[6] = 0.5*T2Jcorrection*(1000*(+2*CYOR_u10mi_n(u_focytC_m_n,u_notBigg_MitoMembrPotent_m_n,u_q10h2_m_n,u_pi_m_n)-2*CYOOm2i_n(u_focytC_m_n,u_notBigg_MitoMembrPotent_m_n,u_notBigg_Ctot_m_n,u_o2_c_n))/W_i)
du[7] = notBigg_JO2fromCap2n(u_o2_b_b,u_o2_c_n)-0.6*notBigg_vMitooutn_n(u_nadh_m_n,u_nad_m_n,u_o2_c_n,u_adp_i_n,u_atp_i_n)
du[8] = 0.5*T2Jcorrection*(1000*(+ATPS4mi_n(u_notBigg_ATP_mx_m_n,u_notBigg_ADP_mx_m_n,u_pi_m_n)-ATPtm_n(u_notBigg_MitoMembrPotent_m_n))/W_x)
du[9] = 0.5*T2Jcorrection*(1000*(-ATPS4mi_n(u_notBigg_ATP_mx_m_n,u_notBigg_ADP_mx_m_n,u_pi_m_n)+ATPtm_n(u_notBigg_MitoMembrPotent_m_n))/W_x)
du[10] = 0.5*T2Jcorrection*(1000*(notBigg_J_MgATPx_n(u_notBigg_ATP_mx_m_n,u_mg2_m_n))/W_x)
du[11] = 0.5*T2Jcorrection*(1000*(notBigg_J_MgADPx_n(u_mg2_m_n,u_notBigg_ADP_mx_m_n))/W_x)
du[12] = 0.5*T2Jcorrection*(1000*(-ATPS4mi_n(u_notBigg_ATP_mx_m_n,u_notBigg_ADP_mx_m_n,u_pi_m_n)+notBigg_J_Pi1_n(u_h_m_n,u_h_i_n))/W_x)
du[13] = 0.5*T2Jcorrection*(1000*(+notBigg_J_ATP_n(u_atp_c_n,u_atp_i_n)+ATPtm_n(u_notBigg_MitoMembrPotent_m_n)+ADK1m_n(u_amp_i_n,u_atp_i_n,u_adp_i_n))/W_i)
du[14] = 0.5*T2Jcorrection*(1000*(+notBigg_J_ADP_n(u_adp_i_n,u_adp_c_n)-ATPtm_n(u_notBigg_MitoMembrPotent_m_n)-2*ADK1m_n(u_amp_i_n,u_atp_i_n,u_adp_i_n))/W_i)
du[15] = 0.5*T2Jcorrection*(1000*(+notBigg_J_AMP_n(u_amp_i_n,u_amp_c_n)+ADK1m_n(u_amp_i_n,u_atp_i_n,u_adp_i_n))/W_i)
du[16] = 0.5*T2Jcorrection*(1000*(notBigg_J_MgATPi_n(u_notBigg_ATP_mi_i_n))/W_i)
du[17] = 0.5*T2Jcorrection*(1000*(notBigg_J_MgADPi_n(u_notBigg_ADP_mi_i_n))/W_i)
du[18] = 0.5*T2Jcorrection*(1000*(-notBigg_J_Pi1_n(u_h_m_n,u_h_i_n)+notBigg_J_Pi2_n(u_pi_i_n,u_pi_c_n))/W_i)
du[19] = 0.5*T2Jcorrection*(4*NADH2_u10mi_n(u_nadh_m_n,u_q10h2_m_n)+2*CYOR_u10mi_n(u_focytC_m_n,u_notBigg_MitoMembrPotent_m_n,u_q10h2_m_n,u_pi_m_n)+4*CYOOm2i_n(u_focytC_m_n,u_notBigg_MitoMembrPotent_m_n,u_notBigg_Ctot_m_n,u_o2_c_n)-n_A*ATPS4mi_n(u_notBigg_ATP_mx_m_n,u_notBigg_ADP_mx_m_n,u_pi_m_n)-ATPtm_n(u_notBigg_MitoMembrPotent_m_n)-notBigg_J_Hle_n(u_h_m_n,u_h_i_n,u_notBigg_MitoMembrPotent_m_n)-notBigg_J_K_n(u_k_m_n,u_notBigg_MitoMembrPotent_m_n))/CIM
du[20] = 0
du[21] = 0
du[22] = 0
du[23] = (CKc_n(u_pcreat_c_n,u_atp_c_n,u_adp_c_n)+0.5*(1/6.96)*1000*(-notBigg_J_ATP_n(u_atp_c_n,u_atp_i_n))-HEX1_n(u_glc_D_c_n,u_atp_c_n,u_g6p_c_n)-PFK_n(u_f6p_c_n,u_atp_c_n)+PGK_n(u_13dpg_c_n,u_3pg_c_n,u_atp_c_n,u_adp_c_n)+PYK_n(u_pep_c_n,u_atp_c_n,u_adp_c_n)-0.15*vPumpn-vATPasesn)/(1-dAMPdATPn)
du[24] = 0
du[25] = T2Jcorrection*(0.5*1000*r0509_n(u_nadh_m_n,u_pi_m_n)/W_x-FUMm_n(u_fum_m_n,u_mal_L_m_n))
du[26] = T2Jcorrection*(FUMm_n(u_fum_m_n,u_mal_L_m_n)-MDHm_n(u_nadh_m_n,u_oaa_m_n,u_nad_m_n,u_mal_L_m_n))+6.96*AKGMALtm_n(u_mal_L_c_n,u_akg_m_n,u_akg_c_n,u_mal_L_m_n)

du[27] = T2Jcorrection*(MDHm_n(u_nadh_m_n,u_oaa_m_n,u_nad_m_n,u_mal_L_m_n)-CSm_n(u_accoa_m_n,u_oaa_m_n,u_cit_m_n,u_coa_m_n) + PCm_n(u_co2_m_n,u_oaa_m_n,u_pyr_m_n,u_atp_m_n,u_adp_m_n)) +ASPTAm_n(u_oaa_m_n,u_akg_m_n,u_glu_L_m_n,u_asp_L_m_n)

du[28] = T2Jcorrection*(0.5*SUCOASm_n(u_coa_m_n,u_succ_m_n,u_pi_m_n,u_adp_m_n,u_succoa_m_n,u_atp_m_n)-0.5*1000*r0509_n(u_nadh_m_n,u_pi_m_n)/W_x)+0.5*T2Jcorrection*OCOAT1m_n(u_acac_c_n,u_aacoa_m_n,u_succoa_m_n,u_succ_m_n)
du[29] = 0.5*T2Jcorrection*(AKGDm_n(u_coa_m_n,u_nadh_m_n,u_ca2_m_n,u_adp_m_n,u_succoa_m_n,u_nad_m_n,u_atp_m_n,u_akg_m_n)-SUCOASm_n(u_coa_m_n,u_succ_m_n,u_pi_m_n,u_adp_m_n,u_succoa_m_n,u_atp_m_n))-0.5*T2Jcorrection*OCOAT1m_n(u_acac_c_n,u_aacoa_m_n,u_succoa_m_n,u_succ_m_n)
du[30] = T2Jcorrection*(CSm_n(u_accoa_m_n,u_oaa_m_n,u_cit_m_n,u_coa_m_n)-PDHm_n(u_pyr_m_n,u_coa_m_n,u_nad_m_n)-0.5*AKGDm_n(u_coa_m_n,u_nadh_m_n,u_ca2_m_n,u_adp_m_n,u_succoa_m_n,u_nad_m_n,u_atp_m_n,u_akg_m_n)+0.5*SUCOASm_n(u_coa_m_n,u_succ_m_n,u_pi_m_n,u_adp_m_n,u_succoa_m_n,u_atp_m_n)-0.5*ACACT1rm_n(u_aacoa_m_n,u_coa_m_n))
du[31] = 0.5*T2Jcorrection*(ICDHxm_n(u_nadh_m_n,u_icit_m_n,u_nad_m_n)-AKGDm_n(u_coa_m_n,u_nadh_m_n,u_ca2_m_n,u_adp_m_n,u_succoa_m_n,u_nad_m_n,u_atp_m_n,u_akg_m_n))-ASPTAm_n(u_oaa_m_n,u_akg_m_n,u_glu_L_m_n,u_asp_L_m_n)-AKGMALtm_n(u_mal_L_c_n,u_akg_m_n,u_akg_c_n,u_mal_L_m_n)
du[32] = 0
du[33] = 0.5*T2Jcorrection*(ACONTm_n(u_icit_m_n,u_cit_m_n)-ICDHxm_n(u_nadh_m_n,u_icit_m_n,u_nad_m_n))
du[34] = T2Jcorrection*(CSm_n(u_accoa_m_n,u_oaa_m_n,u_cit_m_n,u_coa_m_n)-0.5*ACONTm_n(u_icit_m_n,u_cit_m_n))
du[35] = T2Jcorrection*(PDHm_n(u_pyr_m_n,u_coa_m_n,u_nad_m_n)-CSm_n(u_accoa_m_n,u_oaa_m_n,u_cit_m_n,u_coa_m_n))+T2Jcorrection*ACACT1rm_n(u_aacoa_m_n,u_coa_m_n)
du[36] = 0.5*T2Jcorrection*(BDHm_n(u_acac_c_n,u_bhb_c_n,u_nadh_m_n,u_nad_m_n)-OCOAT1m_n(u_acac_c_n,u_aacoa_m_n,u_succoa_m_n,u_succ_m_n))
du[37] = 0.5*T2Jcorrection*(OCOAT1m_n(u_acac_c_n,u_aacoa_m_n,u_succoa_m_n,u_succ_m_n)-ACACT1rm_n(u_aacoa_m_n,u_coa_m_n))

du[38] = 6.96*PYRt2m_n(u_h_m_n,u_pyr_m_n,u_h_c_n,u_pyr_c_n)-T2Jcorrection*(PDHm_n(u_pyr_m_n,u_coa_m_n,u_nad_m_n) + PCm_n(u_co2_m_n,u_oaa_m_n,u_pyr_m_n,u_atp_m_n,u_adp_m_n))

du[39] = 0.44*BHBt_n(u_bhb_c_n,u_bhb_e_e)-BDHm_n(u_acac_c_n,u_bhb_c_n,u_nadh_m_n,u_nad_m_n)
du[40] = 0.0275*notBigg_MCT1_bHB_b(u_bhb_e_e,u_bhb_b_b)-BHBt_n(u_bhb_c_n,u_bhb_e_e)-BHBt_a(u_bhb_c_a,u_bhb_e_e)
du[41] = 0 #0.8*BHBt_a(u_bhb_e_e,u_bhb_c_a) - BDHm_a(u_bhb_c_a,u_acac_c_a,u_nad_m_a,u_nadh_m_a) # 0
du[42] = notBigg_JbHBTrArtCap(t,u_bhb_b_b)-notBigg_MCT1_bHB_b(u_bhb_e_e,u_bhb_b_b)
du[43] = 0
du[44] = 0
du[45] = 0.5*T2Jcorrection*(ASPTAm_n(u_oaa_m_n,u_akg_m_n,u_glu_L_m_n,u_asp_L_m_n)+6.96*ASPGLUm_n(u_h_c_n,u_glu_L_c_n,u_asp_L_m_n,u_asp_L_c_n,u_notBigg_MitoMembrPotent_m_n,u_glu_L_m_n,u_h_m_n)+GLUNm_n(u_gln_L_c_n,u_glu_L_m_n))
du[46] = 0
du[47] = 0
du[48] = 0
du[49] = ASPTA_n(u_glu_L_c_n,u_asp_L_c_n,u_oaa_c_n,u_akg_c_n)-ASPGLUm_n(u_h_c_n,u_glu_L_c_n,u_asp_L_m_n,u_asp_L_c_n,u_notBigg_MitoMembrPotent_m_n,u_glu_L_m_n,u_h_m_n)
du[50] = GAPD_n(u_nadh_c_n,u_nad_c_n,u_g3p_c_n,u_pi_c_n,u_13dpg_c_n)-LDH_L_n(u_nad_c_n,u_lac_L_c_n,u_nadh_c_n,u_pyr_c_n)-notBigg_vShuttlen(u_nadh_m_n,u_nadh_c_n)
du[51] = 0
du[52] = 0.5*T2Jcorrection*(1000*(notBigg_J_KH_a(u_h_i_a,u_h_m_a,u_k_m_a)+notBigg_J_K_a(u_k_m_a,u_notBigg_MitoMembrPotent_m_a))/W_x)
du[53] = 0.5*T2Jcorrection*(1000*(-notBigg_J_MgATPx_a(u_notBigg_ATP_mx_m_a,u_mg2_m_a)-notBigg_J_MgADPx_a(u_notBigg_ADP_mx_m_a,u_mg2_m_a))/W_x)
du[54] = 6.96*(notBigg_vMitoing(u_nadh_m_a,u_pyr_m_a)+notBigg_vShuttleg(u_nadh_c_a,u_nadh_m_a)-notBigg_vMitooutg_a(u_atp_i_a,u_nadh_m_a,u_nad_m_a,u_o2_c_a,u_adp_i_a))
du[55] = 0.5*T2Jcorrection*(1000*(+NADH2_u10mi_a(u_nadh_m_a,u_q10h2_m_a)-CYOR_u10mi_a(u_focytC_m_a,u_q10h2_m_a,u_pi_m_a,u_notBigg_MitoMembrPotent_m_a))/W_x)
du[56] = 0.5*T2Jcorrection*(1000*(+2*CYOR_u10mi_a(u_focytC_m_a,u_q10h2_m_a,u_pi_m_a,u_notBigg_MitoMembrPotent_m_a)-2*CYOOm2i_a(u_notBigg_Ctot_m_a,u_focytC_m_a,u_notBigg_MitoMembrPotent_m_a,u_o2_c_a))/W_i)
du[57] = notBigg_JO2fromCap2a(u_o2_b_b,u_o2_c_a)-0.6*notBigg_vMitooutg_a(u_atp_i_a,u_nadh_m_a,u_nad_m_a,u_o2_c_a,u_adp_i_a)
du[58] = 0.5*T2Jcorrection*(1000*(+ATPS4mi_a(u_notBigg_ATP_mx_m_a,u_pi_m_a,u_notBigg_ADP_mx_m_a)-ATPtm_a(u_notBigg_MitoMembrPotent_m_a))/W_x)
du[59] = 0.5*T2Jcorrection*(1000*(-ATPS4mi_a(u_notBigg_ATP_mx_m_a,u_pi_m_a,u_notBigg_ADP_mx_m_a)+ATPtm_a(u_notBigg_MitoMembrPotent_m_a))/W_x)
du[60] = 0.5*T2Jcorrection*(1000*(notBigg_J_MgATPx_a(u_notBigg_ATP_mx_m_a,u_mg2_m_a))/W_x)
du[61] = 0.5*T2Jcorrection*(1000*(notBigg_J_MgADPx_a(u_notBigg_ADP_mx_m_a,u_mg2_m_a))/W_x)
du[62] = 0.5*T2Jcorrection*(1000*(-ATPS4mi_a(u_notBigg_ATP_mx_m_a,u_pi_m_a,u_notBigg_ADP_mx_m_a)+notBigg_J_Pi1_a(u_h_i_a,u_h_m_a))/W_x)
du[63] = 0.5*T2Jcorrection*(1000*(+notBigg_J_ATP_a(u_atp_i_a,u_atp_c_a)+ATPtm_a(u_notBigg_MitoMembrPotent_m_a)+ADK1m_a(u_atp_i_a,u_adp_i_a,u_amp_i_a))/W_i)
du[64] = 0.5*T2Jcorrection*(1000*(+notBigg_J_ADP_a(u_adp_c_a,u_adp_i_a)-ATPtm_a(u_notBigg_MitoMembrPotent_m_a)-2*ADK1m_a(u_atp_i_a,u_adp_i_a,u_amp_i_a))/W_i)
du[65] = 0.5*T2Jcorrection*(1000*(+notBigg_J_AMP_a(u_amp_i_a,u_amp_c_a)+ADK1m_a(u_atp_i_a,u_adp_i_a,u_amp_i_a))/W_i)
du[66] = 0.5*T2Jcorrection*(1000*(notBigg_J_MgATPi_a(u_notBigg_ATP_mi_i_a))/W_i)
du[67] = 0.5*T2Jcorrection*(1000*(notBigg_J_MgADPi_a(u_notBigg_ADP_mi_i_a))/W_i)
du[68] = 0.5*T2Jcorrection*(1000*(-notBigg_J_Pi1_a(u_h_i_a,u_h_m_a)+notBigg_J_Pi2_a(u_pi_i_a,u_pi_c_a))/W_i)
du[69] = 0.5*T2Jcorrection*((4*NADH2_u10mi_a(u_nadh_m_a,u_q10h2_m_a)+2*CYOR_u10mi_a(u_focytC_m_a,u_q10h2_m_a,u_pi_m_a,u_notBigg_MitoMembrPotent_m_a)+4*CYOOm2i_a(u_notBigg_Ctot_m_a,u_focytC_m_a,u_notBigg_MitoMembrPotent_m_a,u_o2_c_a)-n_A*ATPS4mi_a(u_notBigg_ATP_mx_m_a,u_pi_m_a,u_notBigg_ADP_mx_m_a)-ATPtm_a(u_notBigg_MitoMembrPotent_m_a)-notBigg_J_Hle_a(u_h_i_a,u_h_m_a,u_notBigg_MitoMembrPotent_m_a)-notBigg_J_K_a(u_k_m_a,u_notBigg_MitoMembrPotent_m_a))/CIM)
du[70] = 0
du[71] = 0
du[72] = 0
du[73] = (-(u_ca2_c_a/cai0_ca_ion)*(1+xNEmod*(u[178]/(KdNEmod+u[178])))*ADNCYC_a(u_camp_c_a,u_atp_c_a)+CKc_a(u_adp_c_a,u_atp_c_a,u_pcreat_c_a)+0.5*(1/6.96)*1000*(-notBigg_J_ATP_a(u_atp_i_a,u_atp_c_a))-HEX1_a(u_atp_c_a,u_g6p_c_a,u_glc_D_c_a)-PFK_a(u_atp_c_a,u_f26bp_c_a,u_f6p_c_a)-PFK26_a(u_adp_c_a,u_atp_c_a,u_f26bp_c_a,u_f6p_c_a)+PGK_a(u_adp_c_a,u_atp_c_a,u_3pg_c_a,u_13dpg_c_a)+PYK_a(u_adp_c_a,u_atp_c_a,u_pep_c_a)-0.15*(7/4)*vPumpg-vATPasesg)/(1-dAMPdATPg)
du[74] = 0
du[75] = 0.5*T2Jcorrection*(1000*r0509_a(u_nadh_m_a,u_pi_m_a)/W_x-FUMm_a(u_mal_L_m_a,u_fum_m_a))
du[76] = 0.5*T2Jcorrection*(FUMm_a(u_mal_L_m_a,u_fum_m_a)-MDHm_a(u_nad_m_a,u_oaa_m_a,u_mal_L_m_a,u_nadh_m_a))

du[77] = 0.5*T2Jcorrection*(MDHm_a(u_nad_m_a,u_oaa_m_a,u_mal_L_m_a,u_nadh_m_a)-CSm_a(u_oaa_m_a,u_cit_m_a,u_accoa_m_a,u_coa_m_a)+PCm_a(u_co2_m_a,u_oaa_m_a,u_pyr_m_a,u_atp_m_a,u_adp_m_a))

du[78] = 0.5*T2Jcorrection*(SUCOASm_a(u_coa_m_a,u_succoa_m_a,u_atp_m_a,u_succ_m_a,u_pi_m_a,u_adp_m_a)-1000*r0509_a(u_nadh_m_a,u_pi_m_a)/W_x)
du[79] = 0.5*T2Jcorrection*(AKGDm_a(u_coa_m_a,u_nadh_m_a,u_akg_m_a,u_ca2_m_a,u_nad_m_a,u_succoa_m_a,u_atp_m_a,u_adp_m_a)-SUCOASm_a(u_coa_m_a,u_succoa_m_a,u_atp_m_a,u_succ_m_a,u_pi_m_a,u_adp_m_a))
du[80] = 0.5*T2Jcorrection*(CSm_a(u_oaa_m_a,u_cit_m_a,u_accoa_m_a,u_coa_m_a)-PDHm_a(u_nad_m_a,u_pyr_m_a,u_coa_m_a)-AKGDm_a(u_coa_m_a,u_nadh_m_a,u_akg_m_a,u_ca2_m_a,u_nad_m_a,u_succoa_m_a,u_atp_m_a,u_adp_m_a)+SUCOASm_a(u_coa_m_a,u_succoa_m_a,u_atp_m_a,u_succ_m_a,u_pi_m_a,u_adp_m_a))
du[81] = 0.5*T2Jcorrection*(ICDHxm_a(u_nad_m_a,u_nadh_m_a,u_icit_m_a)-AKGDm_a(u_coa_m_a,u_nadh_m_a,u_akg_m_a,u_ca2_m_a,u_nad_m_a,u_succoa_m_a,u_atp_m_a,u_adp_m_a)+GLUDxm_a(u_nad_m_a,u_nadh_m_a,u_glu_L_c_a,u_akg_m_a))
du[82] = 0
du[83] = 0.5*T2Jcorrection*(ACONTm_a(u_cit_m_a,u_icit_m_a)-ICDHxm_a(u_nad_m_a,u_nadh_m_a,u_icit_m_a))
du[84] = 0.5*T2Jcorrection*(CSm_a(u_oaa_m_a,u_cit_m_a,u_accoa_m_a,u_coa_m_a)-ACONTm_a(u_cit_m_a,u_icit_m_a))
du[85] = 0.5*T2Jcorrection*(PDHm_a(u_nad_m_a,u_pyr_m_a,u_coa_m_a)-CSm_a(u_oaa_m_a,u_cit_m_a,u_accoa_m_a,u_coa_m_a))
du[86] = 0
du[87] = 0

du[88] = 6.96*PYRt2m_a(u_h_m_a,u_pyr_c_a,u_h_c_a,u_pyr_m_a)-T2Jcorrection*(PDHm_a(u_nad_m_a,u_pyr_m_a,u_coa_m_a)+PCm_a(u_co2_m_a,u_oaa_m_a,u_pyr_m_a,u_atp_m_a,u_adp_m_a))

du[89] = T2Jcorrection*(GLNt4_n(u_gln_L_c_n,u_gln_L_e_e)-GLUNm_n(u_gln_L_c_n,u_glu_L_m_n))
du[90] = T2Jcorrection*(-GLNt4_n(u_gln_L_c_n,u_gln_L_e_e)+GLNt4_a(u_gln_L_c_a,u_gln_L_e_e))
du[91] = T2Jcorrection*(-GLNt4_a(u_gln_L_c_a,u_gln_L_e_e)+GLNS_a(u_adp_c_a,u_atp_c_a,u_glu_L_c_a))
du[92] = T2Jcorrection*(0.0266*GLUt6_a(u_na1_c_a,u_notBigg_Va_c_a,u_k_e_e,u_glu_L_syn_syn,u_k_c_a,u_glu_L_c_a)-GLNS_a(u_adp_c_a,u_atp_c_a,u_glu_L_c_a)-GLUDxm_a(u_nad_m_a,u_nadh_m_a,u_glu_L_c_a,u_akg_m_a))
du[93] = (1/4e-4)*(-dIPump_a-IBK-IKirAS-IKirAV-IleakA-ITRP_a)
du[94] = vLeakNag-3*vPumpg+vgstim
du[95] = JNaK_a+(-IleakA-IBK-IKirAS-IKirAV)/(4e-4*843.0*1000.)-RateDecayK_a*(u_k_c_a-u0_ss[95])
du[96] = SmVn/F*(IK+IM)*(eto_n/eto_ecs)-2*vPumpn*(eto_n/eto_ecs)-2*(eto_a/eto_ecs)*vPumpg-JdiffK-((-IleakA-IBK-IKirAS-IKirAV)/(4e-4*843.0*1000.0))
du[97] = 0
du[98] = 1/Cm*(-IL-INa-IK-ICa-ImAHP-dIPump+Isyne+Isyni-IM+Iinj)
du[99] = vLeakNan-3*vPumpn+vnstim
du[100] = phi*(hinf-u_notBigg_hgate_c_n)/tauh
du[101] = phi*(ninf-u_notBigg_ngate_c_n)/taun
du[102] = -SmVn/F*ICa-(u_ca2_c_n-u0_ss[102])/tauCa
du[103] = phi*(p_inf-u_notBigg_pgate_c_n)/tau_p
du[104] = psiBK*cosh((u_notBigg_Va_c_a-(-0.5*v5BK*tanh((u_ca2_c_a-Ca3BK)/Ca4BK)+v6BK))/(2*v4BK))*(nBKinf-u_notBigg_nBK_c_a)
du[105] = 0
du[106] = rhIP3a*((u_notBigg_mGluRboundRatio_c_a+deltaGlutSyn)/(KGlutSyn+u_notBigg_mGluRboundRatio_c_a+deltaGlutSyn))-kdegIP3a*u_notBigg_IP3_c_a
du[107] = konhIP3Ca_a*(khIP3Ca_aINH-(u_ca2_c_a+khIP3Ca_aINH)*u_notBigg_hIP3Ca_c_a)
du[108] = beta_Ca_a*(IIP3_a-ICa_pump_a+Ileak_CaER_a)-0.5*ITRP_a/(4e-4*843.0*1000.)
du[109] = 0
du[110] = (Ca_perivasc/tauTRPCa_perivasc)*(sinfTRPV-u_notBigg_sTRP_c_a)
du[111] = notBigg_FinDyn_W2017(t)-notBigg_Fout_W2017(t,u_notBigg_vV_b_b)
du[112] = VprodEET_a*(u_ca2_c_a-CaMinEET_a)-kdeg_EET_a*u_notBigg_EET_c_a
du[113] = notBigg_JdHbin(t,u_o2_b_b)-notBigg_JdHbout(t,u_notBigg_ddHb_b_b,u_notBigg_vV_b_b)
du[114] = notBigg_JO2art2cap(t,u_o2_b_b)-(eto_n/eto_b)*notBigg_JO2fromCap2n(u_o2_b_b,u_o2_c_n)-(eto_a/eto_b)*notBigg_JO2fromCap2a(u_o2_b_b,u_o2_c_a)
du[115] = notBigg_trGLC_art_cap(t,u_glc_D_b_b)-notBigg_JGlc_be(u_glc_D_ecsEndothelium_ecsEndothelium,u_glc_D_b_b)
du[116] = 0.32*notBigg_JGlc_be(u_glc_D_ecsEndothelium_ecsEndothelium,u_glc_D_b_b)-notBigg_JGlc_e2ecsBA(u_glc_D_ecsBA_ecsBA,u_glc_D_ecsEndothelium_ecsEndothelium)
du[117] = 1.13*notBigg_JGlc_e2ecsBA(u_glc_D_ecsBA_ecsBA,u_glc_D_ecsEndothelium_ecsEndothelium)-notBigg_JGlc_ecsBA2a(u_glc_D_ecsBA_ecsBA,u_glc_D_c_a)-notBigg_JGlc_diffEcs(u_glc_D_ecsBA_ecsBA,u_glc_D_ecsAN_ecsAN)
du[118] = 0.06*notBigg_JGlc_ecsBA2a(u_glc_D_ecsBA_ecsBA,u_glc_D_c_a)-HEX1_a(u_atp_c_a,u_g6p_c_a,u_glc_D_c_a)-notBigg_JGlc_a2ecsAN(u_glc_D_ecsAN_ecsAN,u_glc_D_c_a)
du[119] = 1.35*notBigg_JGlc_a2ecsAN(u_glc_D_ecsAN_ecsAN,u_glc_D_c_a)-notBigg_JGlc_ecsAN2n(u_glc_D_c_n,u_glc_D_ecsAN_ecsAN)+0.08*notBigg_JGlc_diffEcs(u_glc_D_ecsBA_ecsBA,u_glc_D_ecsAN_ecsAN)
du[120] = 0.41*notBigg_JGlc_ecsAN2n(u_glc_D_c_n,u_glc_D_ecsAN_ecsAN)-HEX1_n(u_glc_D_c_n,u_atp_c_n,u_g6p_c_n)
du[121] = HEX1_n(u_glc_D_c_n,u_atp_c_n,u_g6p_c_n)-PGI_n(u_f6p_c_n,u_g6p_c_n)-G6PDH2r_n(u_g6p_c_n,u_nadph_c_n,u_nadp_c_n,u_6pgl_c_n)
du[122] = HEX1_a(u_atp_c_a,u_g6p_c_a,u_glc_D_c_a)-PGI_a(u_g6p_c_a,u_f6p_c_a)-G6PDH2r_a(u_6pgl_c_a,u_nadp_c_a,u_g6p_c_a,u_nadph_c_a)+PGMT_a(u_g1p_c_a,u_g6p_c_a)
du[123] = PGI_n(u_f6p_c_n,u_g6p_c_n)-PFK_n(u_f6p_c_n,u_atp_c_n)-TKT2_n(u_f6p_c_n,u_e4p_c_n,u_xu5p_D_c_n,u_g3p_c_n)+TALA_n(u_f6p_c_n,u_e4p_c_n,u_g3p_c_n,u_s7p_c_n)
du[124] = PGI_a(u_g6p_c_a,u_f6p_c_a)-PFK_a(u_atp_c_a,u_f26bp_c_a,u_f6p_c_a)-PFK26_a(u_adp_c_a,u_atp_c_a,u_f26bp_c_a,u_f6p_c_a)-TKT2_a(u_g3p_c_a,u_e4p_c_a,u_xu5p_D_c_a,u_f6p_c_a)+TALA_a(u_g3p_c_a,u_e4p_c_a,u_s7p_c_a,u_f6p_c_a)
du[125] = PFK_n(u_f6p_c_n,u_atp_c_n)-FBA_n(u_fdp_c_n,u_dhap_c_n,u_g3p_c_n)
du[126] = PFK_a(u_atp_c_a,u_f26bp_c_a,u_f6p_c_a)-FBA_a(u_g3p_c_a,u_fdp_c_a,u_dhap_c_a)
du[127] = PFK26_a(u_adp_c_a,u_atp_c_a,u_f26bp_c_a,u_f6p_c_a)
du[128] = GLCS2_a(u_notBigg_GS_c_a,u_udpg_c_a)-GLCP_a(u_glycogen_c_a,u_notBigg_GPa_c_a,u_camp_c_a,u_notBigg_GPb_c_a)
du[129] = 0
du[130] = 0
du[131] = 10*GLCP_a(u_glycogen_c_a,u_notBigg_GPa_c_a,u_camp_c_a,u_notBigg_GPb_c_a)-PGMT_a(u_g1p_c_a,u_g6p_c_a)-GALUi_a(u_ppi_c_a,u_g1p_c_a,u_udpg_c_a,u_utp_c_a)
du[132] = FBA_n(u_fdp_c_n,u_dhap_c_n,u_g3p_c_n)-GAPD_n(u_nadh_c_n,u_nad_c_n,u_g3p_c_n,u_pi_c_n,u_13dpg_c_n)+TPI_n(u_dhap_c_n,u_g3p_c_n)-TKT2_n(u_f6p_c_n,u_e4p_c_n,u_xu5p_D_c_n,u_g3p_c_n)-TALA_n(u_f6p_c_n,u_e4p_c_n,u_g3p_c_n,u_s7p_c_n)+TKT1_n(u_s7p_c_n,u_r5p_c_n,u_xu5p_D_c_n,u_g3p_c_n)
du[133] = FBA_a(u_g3p_c_a,u_fdp_c_a,u_dhap_c_a)-GAPD_a(u_nadh_c_a,u_nad_c_a,u_pi_c_a,u_13dpg_c_a,u_g3p_c_a)+TPI_a(u_g3p_c_a,u_dhap_c_a)-TKT2_a(u_g3p_c_a,u_e4p_c_a,u_xu5p_D_c_a,u_f6p_c_a)-TALA_a(u_g3p_c_a,u_e4p_c_a,u_s7p_c_a,u_f6p_c_a)+TKT1_a(u_r5p_c_a,u_g3p_c_a,u_s7p_c_a,u_xu5p_D_c_a)
du[134] = FBA_n(u_fdp_c_n,u_dhap_c_n,u_g3p_c_n)-TPI_n(u_dhap_c_n,u_g3p_c_n)
du[135] = FBA_a(u_g3p_c_a,u_fdp_c_a,u_dhap_c_a)-TPI_a(u_g3p_c_a,u_dhap_c_a)
du[136] = GAPD_n(u_nadh_c_n,u_nad_c_n,u_g3p_c_n,u_pi_c_n,u_13dpg_c_n)-PGK_n(u_13dpg_c_n,u_3pg_c_n,u_atp_c_n,u_adp_c_n)
du[137] = GAPD_a(u_nadh_c_a,u_nad_c_a,u_pi_c_a,u_13dpg_c_a,u_g3p_c_a)-PGK_a(u_adp_c_a,u_atp_c_a,u_3pg_c_a,u_13dpg_c_a)
du[138] = GAPD_a(u_nadh_c_a,u_nad_c_a,u_pi_c_a,u_13dpg_c_a,u_g3p_c_a)-LDH_L_a(u_nad_c_a,u_nadh_c_a,u_lac_L_c_a,u_pyr_c_a)-notBigg_vShuttleg(u_nadh_c_a,u_nadh_m_a)
du[139] = 0
du[140] = 0
du[141] = PGK_n(u_13dpg_c_n,u_3pg_c_n,u_atp_c_n,u_adp_c_n)-PGM_n(u_2pg_c_n,u_3pg_c_n)
du[142] = PGK_a(u_adp_c_a,u_atp_c_a,u_3pg_c_a,u_13dpg_c_a)-PGM_a(u_2pg_c_a,u_3pg_c_a)
du[143] = PGM_n(u_2pg_c_n,u_3pg_c_n)-ENO_n(u_pep_c_n,u_2pg_c_n)
du[144] = PGM_a(u_2pg_c_a,u_3pg_c_a)-ENO_a(u_2pg_c_a,u_pep_c_a)
du[145] = ENO_n(u_pep_c_n,u_2pg_c_n)-PYK_n(u_pep_c_n,u_atp_c_n,u_adp_c_n)
du[146] = ENO_a(u_2pg_c_a,u_pep_c_a)-PYK_a(u_adp_c_a,u_atp_c_a,u_pep_c_a)
du[147] = PYK_n(u_pep_c_n,u_atp_c_n,u_adp_c_n)-PYRt2m_n(u_h_m_n,u_pyr_m_n,u_h_c_n,u_pyr_c_n)-LDH_L_n(u_nad_c_n,u_lac_L_c_n,u_nadh_c_n,u_pyr_c_n)
du[148] = PYK_a(u_adp_c_a,u_atp_c_a,u_pep_c_a)-PYRt2m_a(u_h_m_a,u_pyr_c_a,u_h_c_a,u_pyr_m_a)-LDH_L_a(u_nad_c_a,u_nadh_c_a,u_lac_L_c_a,u_pyr_c_a)
du[149] = notBigg_JLacTr_b(u_lac_L_b_b,t)-notBigg_MCT1_LAC_b(u_lac_L_b_b,u_lac_L_e_e)-notBigg_vLACgc(u_lac_L_b_b,u_lac_L_c_a)
du[150] = 0.0275*notBigg_MCT1_LAC_b(u_lac_L_b_b,u_lac_L_e_e)-L_LACt2r_a(u_lac_L_e_e,u_lac_L_c_a)-L_LACt2r_n(u_lac_L_e_e,u_lac_L_c_n)+notBigg_jLacDiff_e(u_lac_L_e_e)
du[151] = 0.8*L_LACt2r_a(u_lac_L_e_e,u_lac_L_c_a)+0.022*notBigg_vLACgc(u_lac_L_b_b,u_lac_L_c_a)+LDH_L_a(u_nad_c_a,u_nadh_c_a,u_lac_L_c_a,u_pyr_c_a)
du[152] = 0.44*L_LACt2r_n(u_lac_L_e_e,u_lac_L_c_n)+LDH_L_n(u_nad_c_n,u_lac_L_c_n,u_nadh_c_n,u_pyr_c_n)
du[153] = G6PDH2r_n(u_g6p_c_n,u_nadph_c_n,u_nadp_c_n,u_6pgl_c_n)+GND_n(u_6pgc_c_n,u_nadph_c_n,u_nadp_c_n,u_ru5p_D_c_n)-notBigg_psiNADPHox_n(u_nadph_c_n)-GTHO_n(u_nadph_c_n,u_gthox_c_n)
du[154] = G6PDH2r_a(u_6pgl_c_a,u_nadp_c_a,u_g6p_c_a,u_nadph_c_a)+GND_a(u_6pgc_c_a,u_nadp_c_a,u_ru5p_D_c_a,u_nadph_c_a)-notBigg_psiNADPHox_a(u_nadph_c_a)-GTHO_a(u_gthox_c_a,u_nadph_c_a)
du[155] = G6PDH2r_n(u_g6p_c_n,u_nadph_c_n,u_nadp_c_n,u_6pgl_c_n)-PGL_n(u_6pgc_c_n,u_6pgl_c_n)
du[156] = G6PDH2r_a(u_6pgl_c_a,u_nadp_c_a,u_g6p_c_a,u_nadph_c_a)-PGL_a(u_6pgc_c_a,u_6pgl_c_a)
du[157] = PGL_n(u_6pgc_c_n,u_6pgl_c_n)-GND_n(u_6pgc_c_n,u_nadph_c_n,u_nadp_c_n,u_ru5p_D_c_n)
du[158] = PGL_a(u_6pgc_c_a,u_6pgl_c_a)-GND_a(u_6pgc_c_a,u_nadp_c_a,u_ru5p_D_c_a,u_nadph_c_a)
du[159] = GND_n(u_6pgc_c_n,u_nadph_c_n,u_nadp_c_n,u_ru5p_D_c_n)-RPE_n(u_xu5p_D_c_n,u_ru5p_D_c_n)-RPI_n(u_r5p_c_n,u_ru5p_D_c_n)
du[160] = GND_a(u_6pgc_c_a,u_nadp_c_a,u_ru5p_D_c_a,u_nadph_c_a)-RPE_a(u_ru5p_D_c_a,u_xu5p_D_c_a)-RPI_a(u_r5p_c_a,u_ru5p_D_c_a)
du[161] = RPI_n(u_r5p_c_n,u_ru5p_D_c_n)-TKT1_n(u_s7p_c_n,u_r5p_c_n,u_xu5p_D_c_n,u_g3p_c_n)
du[162] = RPI_a(u_r5p_c_a,u_ru5p_D_c_a)-TKT1_a(u_r5p_c_a,u_g3p_c_a,u_s7p_c_a,u_xu5p_D_c_a)
du[163] = RPE_n(u_xu5p_D_c_n,u_ru5p_D_c_n)-TKT1_n(u_s7p_c_n,u_r5p_c_n,u_xu5p_D_c_n,u_g3p_c_n)+TKT2_n(u_f6p_c_n,u_e4p_c_n,u_xu5p_D_c_n,u_g3p_c_n)
du[164] = RPE_a(u_ru5p_D_c_a,u_xu5p_D_c_a)-TKT1_a(u_r5p_c_a,u_g3p_c_a,u_s7p_c_a,u_xu5p_D_c_a)+TKT2_a(u_g3p_c_a,u_e4p_c_a,u_xu5p_D_c_a,u_f6p_c_a)
du[165] = TKT1_n(u_s7p_c_n,u_r5p_c_n,u_xu5p_D_c_n,u_g3p_c_n)-TALA_n(u_f6p_c_n,u_e4p_c_n,u_g3p_c_n,u_s7p_c_n)
du[166] = TKT1_a(u_r5p_c_a,u_g3p_c_a,u_s7p_c_a,u_xu5p_D_c_a)-TALA_a(u_g3p_c_a,u_e4p_c_a,u_s7p_c_a,u_f6p_c_a)
du[167] = TKT2_n(u_f6p_c_n,u_e4p_c_n,u_xu5p_D_c_n,u_g3p_c_n)+TALA_n(u_f6p_c_n,u_e4p_c_n,u_g3p_c_n,u_s7p_c_n)
du[168] = TKT2_a(u_g3p_c_a,u_e4p_c_a,u_xu5p_D_c_a,u_f6p_c_a)+TALA_a(u_g3p_c_a,u_e4p_c_a,u_s7p_c_a,u_f6p_c_a)
du[169] = 2*(GTHO_n(u_nadph_c_n,u_gthox_c_n)-GTHP_n(u_gthrd_c_n))+GTHS_n(u_gthrd_c_n)
du[170] = 2*(GTHO_a(u_gthox_c_a,u_nadph_c_a)-GTHP_a(u_gthrd_c_a))+GTHS_a(u_gthrd_c_a)
du[171] = -GTHO_n(u_nadph_c_n,u_gthox_c_n)+GTHP_n(u_gthrd_c_n)
du[172] = -GTHO_a(u_gthox_c_a,u_nadph_c_a)+GTHP_a(u_gthrd_c_a)
du[173] = 0
du[174] = -CKc_n(u_pcreat_c_n,u_atp_c_n,u_adp_c_n)
du[175] = 0
du[176] = -CKc_a(u_adp_c_a,u_atp_c_a,u_pcreat_c_a)
du[177] = (u_ca2_c_a/cai0_ca_ion)*(1+xNEmod*(u[178]/(KdNEmod+u[178])))*ADNCYC_a(u_camp_c_a,u_atp_c_a)-PDE1_a(u_camp_c_a)
du[178] = 0
du[179] = 0
du[180] = 0
du[181] = 0
du[182] = notBigg_psiPHK_a(u_ca2_c_a,u_glycogen_c_a,u_g1p_c_a,u_notBigg_PHKa_c_a,u_notBigg_GPa_c_a,u_udpg_c_a)
du[183] = -notBigg_psiPHK_a(u_ca2_c_a,u_glycogen_c_a,u_g1p_c_a,u_notBigg_PHKa_c_a,u_notBigg_GPa_c_a,u_udpg_c_a)
end



end

#######################################################
# NEmod PARAMETERS CAN BE CHANGED HERE:
#######################################################

KdNEmod = 3.0e-4
taune1_neuromod = 0.01
taune2_neuromod = 100.

tstimNE = ti1  # NE stimulus begins

tspan2sim = (1.,tspanFin) # biol t interval to be sim

# def stim and rest t intervals
conditionK1ephys(u,t,integrator) = (integrator.t<(ti1)) | (integrator.t>=(tf1))
conditionK2ephys(u,t,integrator) = (integrator.t>=(ti1))&(integrator.t<(tf1))

# metabolic pulse t:
conditionMetPulse1(u,t,integrator) = (integrator.t<(ti1+10))|(integrator.t>=(ti1+20))
conditionMetPulse2(u,t,integrator) = (integrator.t>=(ti1+10))&(integrator.t<(ti1+20))


# this is at rest
function affectK1ephys!(integrator)
    integrator.p[1] = 0
    integrator.u[97] = GLUT_out0
    integrator.u[105] = 0.0
end

# SYN ACT FUNCTION WITH SLOW DECAY
function affectK2ephysSyn!(integrator)
    integrator.p[1] = 0.05*global_par_vn_2_tp*(integrator.t-ti1)/metglobal_par_t_stim_tp*exp((-(integrator.t-ti1))/metglobal_par_t_stim_tp)  # more realistic stim
    integrator.u[49] = integrator.u[49] - syn_aging_coeff*(1/(17.8e-12/1e-18))*global_par_vn_2_tp*(integrator.t-ti1)/metglobal_par_t_stim_tp*exp((-(integrator.t-ti1))/metglobal_par_t_stim_tp)
    integrator.u[97] = syn_aging_coeff*global_par_vn_2_tp*(integrator.t-ti1)/metglobal_par_t_stim_tp*exp((-(integrator.t-ti1))/metglobal_par_t_stim_tp)   # GLUT_syn
    integrator.u[105] = syn_aging_coeff*0.667*global_par_vn_2_tp*(integrator.t-ti1)/metglobal_par_t_stim_tp*exp((-(integrator.t-ti1))/metglobal_par_t_stim_tp)   # mGluRboundRatio_a
end

cb_ksi_ephys1 = DiscreteCallback(conditionK1ephys,affectK1ephys!,save_positions=(false,false))
cb_ksi_ephys2syn = DiscreteCallback(conditionK2ephys,affectK2ephysSyn!,save_positions=(false,false));

conditionNE1(u,t,integrator) = (integrator.t>=tstimNE)
# THIS IS CB for NEmod
function affectNE1!(integrator)
    integrator.u[178] = exp(-(integrator.t-tstimNE)/taune2_neuromod) - exp(-(integrator.t-tstimNE)/taune1_neuromod)
end
cbNE1 = DiscreteCallback(conditionNE1,affectNE1!,save_positions=(false,false))

##########################################################
# Iinj
function affectIinj1!(integrator)
    integrator.p[2] = 0.0
end
function affectIinj2!(integrator)
    integrator.p[2] = IinjAmpl
end


cb_Iinj1 = DiscreteCallback(conditionK1ephys,affectIinj1!,save_positions=(false,false))
cb_Iinj2 = DiscreteCallback(conditionK2ephys,affectIinj2!,save_positions=(false,false));

######################################################################
# Met pulse during low-freq firing


if default_or_custom_config == "custom"

    if preset_for_custom in [ "9_glc_pls", "g1_29_glc_pls", "g13_49_glc_pls"]

        function affectMetPulse1!(integrator)
            integrator.p[5] = C_Glc_a # not during pulse
        end

        function affectMetPulse2!(integrator)
            integrator.p[5] = C_Glc_a_mod # during pulse

        end

        cb_MetPulse1 = DiscreteCallback(conditionMetPulse1,affectMetPulse1!,save_positions=(false,false));
        cb_MetPulse2 = DiscreteCallback(conditionMetPulse2,affectMetPulse2!,save_positions=(false,false));
        callbacksetStim = CallbackSet(cb_Iinj1,cb_Iinj2,cb_MetPulse1,cb_MetPulse2)

    elseif preset_for_custom in ["10_lac_pls","g1_30_lac_pls","g13_50_lac_pls"]

        function affectMetPulse1!(integrator)
            integrator.p[6] = C_Lac_a
        end

        function affectMetPulse2!(integrator)
            integrator.p[6] = C_Lac_a_mod

        end

        cb_MetPulse1 = DiscreteCallback(conditionMetPulse1,affectMetPulse1!,save_positions=(false,false));
        cb_MetPulse2 = DiscreteCallback(conditionMetPulse2,affectMetPulse2!,save_positions=(false,false));

        callbacksetStim = CallbackSet(cb_Iinj1,cb_Iinj2,cb_MetPulse1,cb_MetPulse2)

    elseif preset_for_custom in [ "11_bhb_pls","g1_31_bhb_pls","g13_51_bhb_pls"]

        function affectMetPulse1!(integrator)
            integrator.p[7] = C_bHB_a
        end

        function affectMetPulse2!(integrator)
            integrator.p[7] = C_bHB_a_mod

        end

        cb_MetPulse1 = DiscreteCallback(conditionMetPulse1,affectMetPulse1!,save_positions=(false,false));
        cb_MetPulse2 = DiscreteCallback(conditionMetPulse2,affectMetPulse2!,save_positions=(false,false));

        callbacksetStim = CallbackSet(cb_Iinj1,cb_Iinj2,cb_MetPulse1,cb_MetPulse2)

    ##############

    elseif preset_for_custom in ["12_akg_pls","g1_32_akg_pls","g13_52_akg_pls"]

        function affectMetPulse1!(integrator)
            integrator.u[48] = u0_ss[48]
        end

        function affectMetPulse2!(integrator)

            # pulse from default sim pre-pulse value, to from u0_ss
            integrator.u[31] = 1.05*0.056332   #1.05*u0_ss[31]
            integrator.u[48] = 1.05*0.2        #1.05*u0_ss[48]
            integrator.u[81] = 1.05*0.011908   #1.05*u0_ss[81]

        end

        cb_MetPulse1 = DiscreteCallback(conditionMetPulse1,affectMetPulse1!,save_positions=(false,false));
        cb_MetPulse2 = DiscreteCallback(conditionMetPulse2,affectMetPulse2!,save_positions=(false,false));

        callbacksetStim = CallbackSet(cb_Iinj1,cb_Iinj2,cb_MetPulse1,cb_MetPulse2)

    ##############

    elseif preset_for_custom in ["13_succoa_pls","g1_33_succoa_pls","g13_53_succoa_pls"]


        function affectMetPulse2!(integrator)
            # pulse from default sim pre-pulse value, to from u0_ss
            integrator.u[29] = 1.05*0.002662 #1.05*u0_ss[29]
            integrator.u[79] = 1.05*0.001761 #1.05*u0_ss[79]
        end


        cb_MetPulse2 = DiscreteCallback(conditionMetPulse2,affectMetPulse2!,save_positions=(false,false));


        callbacksetStim = CallbackSet(cb_Iinj1,cb_Iinj2,cb_MetPulse2)

    ##############

    elseif preset_for_custom in ["14_fum_pls","g1_34_fum_pls","g13_54_fum_pls"]


        function affectMetPulse2!(integrator)
            integrator.u[25] = 1.05*0.075143 #1.05*u0_ss[25]
            integrator.u[75] = 1.05*0.055469 #1.05*u0_ss[75]
        end

        cb_MetPulse2 = DiscreteCallback(conditionMetPulse2,affectMetPulse2!,save_positions=(false,false));

        callbacksetStim = CallbackSet(cb_Iinj1,cb_Iinj2,cb_MetPulse2)

    ##############

    elseif preset_for_custom in ["15_mal_pls","g1_35_mal_pls","g13_55_mal_pls"]

        function affectMetPulse1!(integrator)
            integrator.u[46] = u0_ss[46] # because du[46] = 0
        end

        function affectMetPulse2!(integrator)
            integrator.u[26] = 1.05*0.411779 #1.05*u0_ss[26]
            integrator.u[46] = 1.05*0.45 #1.05*u0_ss[46]
            integrator.u[76] = 1.05*0.278744 #1.05*u0_ss[76]
        end

        cb_MetPulse1 = DiscreteCallback(conditionMetPulse1,affectMetPulse1!,save_positions=(false,false));
        cb_MetPulse2 = DiscreteCallback(conditionMetPulse2,affectMetPulse2!,save_positions=(false,false));

        callbacksetStim = CallbackSet(cb_Iinj1,cb_Iinj2,cb_MetPulse1,cb_MetPulse2)


    ##############

    elseif preset_for_custom in ["16_oxa_pls","g1_36_oxa_pls","g13_56_oxa_pls"]

        function affectMetPulse1!(integrator)
            integrator.u[47] = u0_ss[47] # because du[47] = 0
        end

        function affectMetPulse2!(integrator)
            integrator.u[27] = 1.05*0.014046 #1.05*u0_ss[27]
            integrator.u[47] = 1.05*0.01 #1.05*u0_ss[47]
            integrator.u[77] = 1.05*0.006024 #1.05*u0_ss[77]
        end

        cb_MetPulse1 = DiscreteCallback(conditionMetPulse1,affectMetPulse1!,save_positions=(false,false));
        cb_MetPulse2 = DiscreteCallback(conditionMetPulse2,affectMetPulse2!,save_positions=(false,false));

        callbacksetStim = CallbackSet(cb_Iinj1,cb_Iinj2,cb_MetPulse1,cb_MetPulse2)



    elseif preset_for_custom in all_custom_setups

        callbacksetStim = CallbackSet(cb_Iinj1,cb_Iinj2)

    ##########################################################################
    # HERE YOU CAN add:

    # elseif preset_for_custom in ["your condition"]
        # <your changes>

    ##########################################################################
    else
        print("ATTENTION CB not defined:",preset_for_custom)
    end

elseif default_or_custom_config == "default"
    if stim_choice == "train_inj"
        callbacksetStim = CallbackSet(cb_Iinj1,cb_Iinj2)
    elseif stim_choice == "mainSyn"
        callbacksetStim = CallbackSet(cb_ksi_ephys1,cb_ksi_ephys2syn)
    else
        println("CHECK STIM!")
    end
else
    println("UNEXPECTED/UNDEFINED default_or_custom_config")
end

# CBs to choose:
callbacksetksiSyn = CallbackSet(cb_ksi_ephys1,cb_ksi_ephys2syn)
callbacksetNEneuromodSyn = CallbackSet(cbNE1,cb_ksi_ephys1,cb_ksi_ephys2syn)
callbacksetNEneuromodOnly = CallbackSet(cbNE1)

p = [synInput, Iinj0,global_par_t_0,global_par_t_fin,C_Glc_a,C_Lac_a,C_bHB_a]
println("params are:")
println(p)
du = copy(u0_ss)
prep_prob = ODEProblem(metabolism!,u0_ss,tspan2sim,p)
de = modelingtoolkitize(prep_prob);
prob = ODEProblem(de,Float64[],tspan2sim, sparse=true)

try
    println("Start solving")
    println(Dates.format(now(), "HH:MM:SS")  )

    sol_r23 = solve(prob,Rosenbrock23(autodiff=false),reltol=1e-8,abstol=1e-8, saveat=saveat_dt,
        callback = callbacksetStim, maxiters=1e6,
        isoutofdomain=(u,p,t) -> any(x -> x < 0, u[cb_nonneg_idxs]))

    println("------------------------------- SOLRETCODE ---------------------------------")
    println(sol_r23.retcode)  # should print Success

    writedlm(string(outresdirname,"/",outfid,"_t.csv"), sol_r23.t, ',');
    writedlm(string(outresdirname,"/",outfid,"_u.csv"), sol_r23.u, ',');
    writedlm(string(outresdirname,"/",outfid,"_unames.csv"), u0l, ',');

catch
    println("------------------------------- CATCHED ERR --------------------------------")
    println(sol_r23.retcode)
finally
    println(Dates.format(now(), "HH:MM:SS")  )
end

println(outfid)


println("=================================================== SIM DONE =============================================================================")
