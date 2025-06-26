-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/buff/cbuffeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cbuffeffect = {}
cbuffeffect.Data = {
[1] = {id = 1, effectName = "BOSS_TX_t1_02_wudi_1", packageName = "effects/particles.prefabs.skilleffects.boss_t1_02.assetbundle", socket = "ShootPoint", isInEffectSocket = "0"}
, 
[2] = {id = 2, effectName = "BOSS_TX_t1_02_wudi_2", packageName = "effects/particles.prefabs.skilleffects.boss_t1_02.assetbundle", socket = "ShootPoint", isInEffectSocket = "0"}
, 
[3] = {id = 3, effectName = "Mon_TX_T1_07_meihuo_buff", packageName = "effects/particles.prefabs.skilleffects.mon_t1_07.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[4] = {id = 4, effectName = "Mon_TX_W1_47_hunshui_buff", packageName = "effects/particles.prefabs.skilleffects.mon_w1_47.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[5] = {id = 5, effectName = "TX_Prefab_rouguang_buff", packageName = "effects/particles.prefabs.skilleffects.common.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[6] = {id = 6, effectName = "TX_tongyong_yun", packageName = "effects/particles.prefabs.skilleffects.common.assetbundle", socket = "HitPoint_Head", isInEffectSocket = "0"}
, 
[7] = {id = 7, effectName = "Char_006_TX_Prefab_TianShi_buff", packageName = "effects/particles.prefabs.skilleffects.char_006.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[8] = {id = 8, effectName = "Char_014_TX_Prefab_yingwuxianshen", packageName = "effects/particles.prefabs.skilleffects.char_014.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[9] = {id = 9, effectName = "Char_014_TX_Prefab_yingwuxiaoshi", packageName = "effects/particles.prefabs.skilleffects.char_014.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[10] = {id = 10, effectName = "Char_014_TX_Prefab_yingwuxianshen", packageName = "effects/particles.prefabs.skilleffects.char_014.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[11] = {id = 11, effectName = "Char_014_TX_Prefab_yingwuxiaoshi", packageName = "effects/particles.prefabs.skilleffects.char_014.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[12] = {id = 12, effectName = "Char_003_TX_Prefab_QingReZhiWu_buff", packageName = "effects/particles.prefabs.skilleffects.char_003.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[13] = {id = 13, effectName = "Char_002_TX_LeiJian", packageName = "effects/particles.prefabs.skilleffects.char_002.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[15] = {id = 15, effectName = "Char_002_TX_xuanfengzhan_loop", packageName = "effects/particles.prefabs.skilleffects.char_002.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[17] = {id = 17, effectName = "Char_002_TX_xuanfengzhan_lighting_loop", packageName = "effects/particles.prefabs.skilleffects.char_002.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[19] = {id = 19, effectName = "BOSS_TX_w1_02_tengman_chanyao", packageName = "effects/particles.prefabs.skilleffects.boss_w1_02.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[21] = {id = 21, effectName = "Char_019_TX_Prefab_ChuiXue_XiaoShi", packageName = "effects/particles.prefabs.skilleffects.char_019.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[22] = {id = 22, effectName = "Char_018_TX_Prefab_PingZhang", packageName = "effects/particles.prefabs.skilleffects.char_018.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[23] = {id = 23, effectName = "Char_018_TX_Prefab_PingZhang_hit", packageName = "effects/particles.prefabs.skilleffects.char_018.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[24] = {id = 24, effectName = "Char_018_TX_Prefab_ShouHu", packageName = "effects/particles.prefabs.skilleffects.char_018.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[25] = {id = 25, effectName = "Char_014_TX_Prefab_yinji", packageName = "effects/particles.prefabs.skilleffects.char_014.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[26] = {id = 26, effectName = "Char_019_TX_Prefab_ChuiXue_JianSu", packageName = "effects/particles.prefabs.skilleffects.char_019.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[28] = {id = 28, effectName = "Char_019_TX_Prefab_BingFeng", packageName = "effects/particles.prefabs.skilleffects.char_019.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[29] = {id = 29, effectName = "BOSS_TX_t1_02_ShiZhiJinGu_zouni", packageName = "effects/particles.prefabs.skilleffects.boss_t1_02.assetbundle", socket = "HitPoint", isInEffectSocket = "1"}
, 
[30] = {id = 30, effectName = "BOSS_TX_t1_02_ShiZhiJinGu_huilai", packageName = "effects/particles.prefabs.skilleffects.boss_t1_02.assetbundle", socket = "HitPoint", isInEffectSocket = "1"}
, 
[31] = {id = 31, effectName = "Char_015_TX_Prefab_ShenShouDeJiaHu", packageName = "effects/particles.prefabs.skilleffects.char_015.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[32] = {id = 32, effectName = "Mon_TX_W1_48_suijia_buff", packageName = "effects/particles.prefabs.skilleffects.mon_w1_48.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[33] = {id = 33, effectName = "Mon_TX_W1_49_kuanghua_Buff", packageName = "effects/particles.prefabs.skilleffects.mon_w1_49.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[34] = {id = 34, effectName = "Mon_TX_W1_49_kuanghua", packageName = "effects/particles.prefabs.skilleffects.mon_w1_49.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[35] = {id = 35, effectName = "Char_016_TX_Prefab_QinYinHuTi", packageName = "effects/particles.prefabs.skilleffects.char_016.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[36] = {id = 36, effectName = "Mon_TX_T1_27_kuanghua", packageName = "effects/particles.prefabs.skilleffects.mon_t1_27.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[37] = {id = 37, effectName = "BOSS_TX_w1_02_baozi_buff", packageName = "effects/particles.prefabs.skilleffects.boss_w1_02.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[38] = {id = 38, effectName = "Char_019_TX_Prefab_BingFeng_dimian", packageName = "effects/particles.prefabs.skilleffects.char_019.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[39] = {id = 39, effectName = "Char_019_TX_Prefab_BingFeng_suilie", packageName = "effects/particles.prefabs.skilleffects.char_019.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[40] = {id = 40, effectName = "Char_021_TX_Prefab_XingHongFengBao_huifu", packageName = "effects/particles.prefabs.skilleffects.char_021.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[41] = {id = 41, effectName = "Char_027_TX_Prefab_GouTong", packageName = "effects/particles.prefabs.skilleffects.char_027.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[42] = {id = 42, effectName = "Char_027_TX_Prefab_SuMing_buff", packageName = "effects/particles.prefabs.skilleffects.char_027.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[43] = {id = 43, effectName = "Char_003_TX_HuoLiZhiWu_jianshang", packageName = "effects/particles.prefabs.skilleffects.char_003.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[45] = {id = 45, effectName = "Char_027_TX_Prefab_SuMing", packageName = "effects/particles.prefabs.skilleffects.char_027.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[46] = {id = 46, effectName = "Char_031_TX_Prefab_lianjie_buff", packageName = "effects/particles.prefabs.skilleffects.char_031.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[49] = {id = 49, effectName = "Char_026_TX_debuff", packageName = "effects/particles.prefabs.skilleffects.char_026.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[50] = {id = 50, effectName = "Char_030_TX_ChiSeLiuXing", packageName = "effects/particles.prefabs.skilleffects.char_030.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[51] = {id = 51, effectName = "Char_042_TX_DiZhiBiYou_att", packageName = "effects/particles.prefabs.skilleffects.char_042.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[52] = {id = 52, effectName = "Char_030_TX_ZhuHongZhan_hudun", packageName = "effects/particles.prefabs.skilleffects.char_030.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[53] = {id = 53, effectName = "Char_007_TX_LangHao_Buff", packageName = "effects/particles.prefabs.skilleffects.char_007.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[54] = {id = 54, effectName = "Char_007_TX_SiYao_jiaxue", packageName = "effects/particles.prefabs.skilleffects.char_007.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[55] = {id = 55, effectName = "Char_034_TX_GuanZhiBi_buff", packageName = "effects/particles.prefabs.skilleffects.char_034.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[56] = {id = 56, effectName = "Char_035_TX_CangQiongZhiFeng_shun", packageName = "effects/particles.prefabs.skilleffects.char_035.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[57] = {id = 57, effectName = "Char_035_TX_CangQiongZhiFeng_ni", packageName = "effects/particles.prefabs.skilleffects.char_035.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[58] = {id = 58, effectName = "Char_029_TX_XuLiYiJi", packageName = "effects/particles.prefabs.skilleffects.char_029.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[59] = {id = 59, effectName = "N001_TX_ZhuoShao_Buff", packageName = "effects/particles.prefabs.skilleffects.n001.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[60] = {id = 60, effectName = "BOSS_TX_w2_01_bingtuxi_buff", packageName = "effects/particles.prefabs.skilleffects.boss_w2_01.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[61] = {id = 61, effectName = "Mon_TX_T2_06_ShiJianSuoDing_zouni", packageName = "effects/particles.prefabs.skilleffects.mon_t2_06.assetbundle", socket = "HitPoint", isInEffectSocket = "1"}
, 
[62] = {id = 62, effectName = "Mon_TX_T2_06_ShiJianSuoDing_huilai", packageName = "effects/particles.prefabs.skilleffects.mon_t2_06.assetbundle", socket = "HitPoint", isInEffectSocket = "1"}
, 
[63] = {id = 63, effectName = "TX_Prefab_fanrong_buff", packageName = "effects/particles.prefabs.skilleffects.char_001.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[64] = {id = 64, effectName = "TX_Prefab_ZhenJie_buff", packageName = "effects/particles.prefabs.skilleffects.common.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[65] = {id = 65, effectName = "Char_039_TX_MengPu0_smoke", packageName = "effects/particles.prefabs.skilleffects.char_039.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[66] = {id = 66, effectName = "Char_039_TX_MengPu0_disappear", packageName = "effects/particles.prefabs.skilleffects.char_039.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[67] = {id = 67, effectName = "Char_039_TX_SiSui0_line", packageName = "effects/particles.prefabs.skilleffects.char_039.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[68] = {id = 68, effectName = "Char_039_TX_SiSui0_disappear", packageName = "effects/particles.prefabs.skilleffects.char_039.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[69] = {id = 69, effectName = "Char_007_TX_Prefab_chuxian", packageName = "effects/particles.prefabs.skilleffects.char_007.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[70] = {id = 70, effectName = "Mon_TX_W2_13_biaoji_buff", packageName = "effects/particles.prefabs.skilleffects.mon_w2_13.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[71] = {id = 71, effectName = "Mon_TX_W2_14_haoling_buff", packageName = "effects/particles.prefabs.skilleffects.mon_w2_14.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[72] = {id = 72, effectName = "Mon_TX_W2_08_minruici_buff", packageName = "effects/particles.prefabs.skilleffects.mon_w2_08.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[73] = {id = 73, effectName = "BOSS_TX_w2_02_baofengxue_01", packageName = "effects/particles.prefabs.skilleffects.boss_w2_02.assetbundle", socket = "HitPoint_Bottom2", isInEffectSocket = "0"}
, 
[74] = {id = 74, effectName = "TX_tongyong_pugong_gongjian", packageName = "effects/particles.prefabs.skilleffects.common.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[75] = {id = 75, effectName = "BOSS_TX_w2_02_xulijiaxue_xuli", packageName = "effects/particles.prefabs.skilleffects.boss_w2_02.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[76] = {id = 76, effectName = "Char_043_TX_ZhiMingDuWu_buff", packageName = "effects/particles.prefabs.skilleffects.char_043.assetbundle", socket = "HitPoint_Head", isInEffectSocket = "0"}
, 
[77] = {id = 77, effectName = "Char_037_TX_Prefab_ZhanBu_XieLou", packageName = "effects/particles.prefabs.skilleffects.char_037.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[78] = {id = 78, effectName = "Char_049_TX_BDXL_buff", packageName = "effects/particles.prefabs.skilleffects.char_049.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[79] = {id = 79, effectName = "Char_037_TX_Prefab_ZhanBu_loop", packageName = "effects/particles.prefabs.skilleffects.char_037.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[80] = {id = 80, effectName = "Char_037_TX_Prefab_ZhanBu_end", packageName = "effects/particles.prefabs.skilleffects.char_037.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[81] = {id = 81, effectName = "Char_052_TX_TSZX_zishen_buff", packageName = "effects/particles.prefabs.skilleffects.char_052.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[82] = {id = 82, effectName = "Char_052_TX_TSZX_hudun_buff", packageName = "effects/particles.prefabs.skilleffects.char_052.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[83] = {id = 83, effectName = "Char_037_TX_Prefab_XieLou_gaoji", packageName = "effects/particles.prefabs.skilleffects.char_037.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[85] = {id = 85, effectName = "Char_040_TX_jiguang_B", packageName = "effects/particles.prefabs.skilleffects.char_040.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[86] = {id = 86, effectName = "Char_060_TX_CYZY_buff_B", packageName = "effects/particles.prefabs.skilleffects.char_060.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[87] = {id = 87, effectName = "Char_060_TX_FHH_buff_Head", packageName = "effects/particles.prefabs.skilleffects.char_060.assetbundle", socket = "HitPoint_Head", isInEffectSocket = "0"}
, 
[88] = {id = 88, effectName = "Char_060_TX_NiePan_buff_H", packageName = "effects/particles.prefabs.skilleffects.char_060.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[89] = {id = 89, effectName = "Char_058_TX_Prefab_RiZhiZhou_buff", packageName = "effects/particles.prefabs.skilleffects.char_058.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[90] = {id = 90, effectName = "Char_036_TX_Prefab_ShouHuLing_H", packageName = "effects/particles.prefabs.skilleffects.char_036.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[91] = {id = 91, effectName = "Char_036_TX_Prefab_ShouHuLing_att_H", packageName = "effects/particles.prefabs.skilleffects.char_036.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[92] = {id = 92, effectName = "Char_036_TX_Prefab_ShouHuLing_02_H", packageName = "effects/particles.prefabs.skilleffects.char_036.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[93] = {id = 93, effectName = "Char_053_TX_ZhiYuZhiShou_H", packageName = "effects/particles.prefabs.skilleffects.char_053.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[94] = {id = 94, effectName = "Char_053_TX_ZhiYuZhiShou_B", packageName = "effects/particles.prefabs.skilleffects.char_053.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[95] = {id = 95, effectName = "Char_053_TX_AnFu_H", packageName = "effects/particles.prefabs.skilleffects.char_053.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[96] = {id = 96, effectName = "Char_027_TX_YingHuaYu_buff_B", packageName = "effects/particles.prefabs.skilleffects.char_027.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[97] = {id = 97, effectName = "Char_001_TX_ShiJianHuiSu_buff", packageName = "effects/particles.prefabs.skilleffects.char_001.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[98] = {id = 98, effectName = "Char_051_TX_ChiTong", packageName = "effects/particles.prefabs.skilleffects.char_051.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[99] = {id = 99, effectName = "Char_051_TX_ChiTong_att", packageName = "effects/particles.prefabs.skilleffects.char_051.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[101] = {id = 101, effectName = "Char_054_TX_Prefab_ZhiYuHaiLang_hudun", packageName = "effects/particles.prefabs.skilleffects.char_054.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[102] = {id = 102, effectName = "Char_027_TX_XueSeHuaLian_B", packageName = "effects/particles.prefabs.skilleffects.char_027.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[103] = {id = 103, effectName = "Char_027_TX_Dun_HP", packageName = "effects/particles.prefabs.skilleffects.char_027.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[106] = {id = 106, effectName = "Mon_TX_T1_27_kuanghua", packageName = "effects/particles.prefabs.skilleffects.mon_t1_27.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[107] = {id = 107, effectName = "Mon_TX_T1_27_kuanghua", packageName = "effects/particles.prefabs.skilleffects.mon_t1_27.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[108] = {id = 108, effectName = "Mon_TX_T1_27_kuanghua", packageName = "effects/particles.prefabs.skilleffects.mon_t1_27.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[109] = {id = 109, effectName = "Mon_TX_T1_27_kuanghua", packageName = "effects/particles.prefabs.skilleffects.mon_t1_27.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[110] = {id = 110, effectName = "Mon_TX_T1_27_kuanghua", packageName = "effects/particles.prefabs.skilleffects.mon_t1_27.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[111] = {id = 111, effectName = "Mon_TX_T1_27_kuanghua", packageName = "effects/particles.prefabs.skilleffects.mon_t1_27.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[112] = {id = 112, effectName = "Mon_TX_T1_27_kuanghua", packageName = "effects/particles.prefabs.skilleffects.mon_t1_27.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[113] = {id = 113, effectName = "Mon_TX_T1_27_kuanghua", packageName = "effects/particles.prefabs.skilleffects.mon_t1_27.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[114] = {id = 114, effectName = "Mon_TX_T1_27_YuanLing_buff", packageName = "effects/particles.prefabs.skilleffects.mon_t1_27.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[115] = {id = 115, effectName = "Mon_TX_W1_47_LinPianHuDun", packageName = "effects/particles.prefabs.skilleffects.mon_w1_47.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[116] = {id = 116, effectName = "Char_062_TX_GuangHui_att_HP", packageName = "effects/particles.prefabs.skilleffects.char_062.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[117] = {id = 117, effectName = "Char_062_TX_BaoShiPingZhang_HP", packageName = "effects/particles.prefabs.skilleffects.char_062.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[119] = {id = 119, effectName = "Mon_TX_T2_13_FuShe_buff", packageName = "effects/particles.prefabs.skilleffects.mon_t2_13.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[120] = {id = 120, effectName = "Char_017_TX_LCZhen_hei_HP", packageName = "effects/particles.prefabs.skilleffects.char_017.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[121] = {id = 121, effectName = "Char_005_TX_QingReZhiWu_buff_B", packageName = "effects/particles.prefabs.skilleffects.char_005.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[122] = {id = 122, effectName = "Char_005_TX_MeiHuoZhiWu_debuff", packageName = "effects/particles.prefabs.skilleffects.char_005.assetbundle", socket = "HitPoint_Head", isInEffectSocket = "0"}
, 
[123] = {id = 123, effectName = "Char_072_ShenShengZhiLiao_Dun", packageName = "effects/particles.prefabs.skilleffects.char_072.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[124] = {id = 124, effectName = "Char_072_QiDao_buff", packageName = "effects/particles.prefabs.skilleffects.char_072.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[125] = {id = 125, effectName = "char_057_DunXunHuan", packageName = "effects/particles.prefabs.skilleffects.char_057.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[126] = {id = 126, effectName = "Char_065_CiSha_lan", packageName = "effects/particles.prefabs.skilleffects.char_065.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[127] = {id = 127, effectName = "Char_065_CiSha_red", packageName = "effects/particles.prefabs.skilleffects.char_065.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[128] = {id = 128, effectName = "Char_076_jingjihujia_buff", packageName = "effects/particles.prefabs.skilleffects.char_076.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[129] = {id = 129, effectName = "Char_032_RongYaoZhiQi_hudun", packageName = "effects/particles.prefabs.skilleffects.char_032.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[130] = {id = 130, effectName = "Char_032_shenzhibiyou_buff_B", packageName = "effects/particles.prefabs.skilleffects.char_032.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[131] = {id = 131, effectName = "Char_066_TX_HuanJingZhiYou_H", packageName = "effects/particles.prefabs.skilleffects.char_066.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[132] = {id = 132, effectName = "char_073_XingLuo_XingNeng", packageName = "effects/particles.prefabs.skilleffects.char_073.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[133] = {id = 133, effectName = "Mon_TX_W3_28_kuanghua", packageName = "effects/particles.prefabs.skilleffects.mon_w3_28.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[134] = {id = 134, effectName = "Mon_TX_W3_26_att_debuff", packageName = "effects/particles.prefabs.skilleffects.mon_w3_26.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[135] = {id = 135, effectName = "Char_070_TX_YueGuang_buff_B", packageName = "effects/particles.prefabs.skilleffects.char_070.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[136] = {id = 136, effectName = "TX_Prefab_ZhuFu_buff", packageName = "effects/particles.prefabs.skilleffects.common.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[137] = {id = 137, effectName = "TX_Prefab_TimeStop_end", packageName = "effects/particles.prefabs.skilleffects.common.assetbundle", socket = "ShootPoint", isInEffectSocket = "0"}
, 
[138] = {id = 138, effectName = "Char_070_TX_HuDun", packageName = "effects/particles.prefabs.skilleffects.char_070.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[139] = {id = 139, effectName = "BOSS06shdow1_TX_Dun", packageName = "effects/particles.prefabs.skilleffects.boss_06shdow.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[140] = {id = 140, effectName = "BOSS07shdow02_TX_Dun", packageName = "effects/particles.prefabs.skilleffects.boss_06shdow.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[141] = {id = 141, effectName = "BOSS08shdow03_TX_Dun", packageName = "effects/particles.prefabs.skilleffects.boss_06shdow.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[142] = {id = 142, effectName = "BOSS09shdow04_TX_Dun", packageName = "effects/particles.prefabs.skilleffects.boss_06shdow.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[143] = {id = 143, effectName = "Mon_TX_W3_31_leiji_mabi", packageName = "effects/particles.prefabs.skilleffects.mon_w3_31.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[144] = {id = 144, effectName = "Mon_TX_W3_31_leidianjixu", packageName = "effects/particles.prefabs.skilleffects.mon_w3_31.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[145] = {id = 145, effectName = "Mon_TX_W3_01_duye_liuxue", packageName = "effects/particles.prefabs.skilleffects.mon_w3_01.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[146] = {id = 146, effectName = "Mon_TX_W3_04_duye_fushi", packageName = "effects/particles.prefabs.skilleffects.mon_w3_04.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[147] = {id = 147, effectName = "BOSS_05mana_TX_WeiYi_chuxian", packageName = "effects/particles.prefabs.skilleffects.boss_05mana.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[148] = {id = 148, effectName = "BOSS_05mana_TX_FeiE_buff", packageName = "effects/particles.prefabs.skilleffects.boss_05mana.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[149] = {id = 149, effectName = "BOSS08shdow3_TX_YinYing", packageName = "effects/particles.prefabs.skilleffects.boss_06shdow.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[150] = {id = 150, effectName = "Mon_w3_10_KuangHua_ZiShen", packageName = "effects/particles.prefabs.skilleffects.mon_w3_10.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[151] = {id = 151, effectName = "Mon_w3_10_DuYeTuXi_KuangHua_att", packageName = "effects/particles.prefabs.skilleffects.mon_w3_10.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[152] = {id = 152, effectName = "BOSS_05mana_TX_FenShen_appear", packageName = "effects/particles.prefabs.skilleffects.boss_05mana.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[153] = {id = 153, effectName = "Char_014_TX_Prefab_yingwuxianshen_nosound", packageName = "effects/particles.prefabs.skilleffects.char_014.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[154] = {id = 154, effectName = "Char_014_TX_Prefab_yingwuxiaoshi_nosound", packageName = "effects/particles.prefabs.skilleffects.char_014.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[155] = {id = 155, effectName = "Mon_TX_W3_35_du_debuff_B", packageName = "effects/particles.prefabs.skilleffects.mon_w3_35.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[156] = {id = 156, effectName = "Mon_TX_W3_33__leidianzhuaji_buff", packageName = "effects/particles.prefabs.skilleffects.mon_w3_33.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[157] = {id = 157, effectName = "Mon_TX_w3_32_kuanghua", packageName = "effects/particles.prefabs.skilleffects.mon_w3_32.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[158] = {id = 158, effectName = "Mon_TX_w3_25_xieweiciji_chixudiaoxue", packageName = "effects/particles.prefabs.skilleffects.mon_w3_25.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[159] = {id = 159, effectName = "Char_065_TX_Jushu_buff", packageName = "effects/particles.prefabs.skilleffects.char_065.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[160] = {id = 160, effectName = "Char_065_TX_Jushu_sankai", packageName = "effects/particles.prefabs.skilleffects.char_065.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[161] = {id = 161, effectName = "Char_065_TX_Fang_buff", packageName = "effects/particles.prefabs.skilleffects.char_065.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[162] = {id = 162, effectName = "Char_065_TX_XuLi_fen_HP", packageName = "effects/particles.prefabs.skilleffects.char_065.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[163] = {id = 163, effectName = "Char_065_TX_XuLi_lan_HP", packageName = "effects/particles.prefabs.skilleffects.char_065.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[164] = {id = 164, effectName = "Mon_TX_W3_36_buff", packageName = "effects/particles.prefabs.skilleffects.mon_w3_36.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[165] = {id = 165, effectName = "N007_AnHeiFuYin_buff_B", packageName = "effects/particles.prefabs.skilleffects.n007.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[166] = {id = 166, effectName = "Mon_TX_W3_05_Linjia_dun", packageName = "effects/particles.prefabs.skilleffects.mon_w3_05.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[167] = {id = 167, effectName = "BOSS06shdow1_TX_Dun_diss", packageName = "effects/particles.prefabs.skilleffects.boss_06shdow.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[168] = {id = 168, effectName = "BOSS07shdow2_TX_Dun_diss", packageName = "effects/particles.prefabs.skilleffects.boss_06shdow.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[169] = {id = 169, effectName = "BOSS08shdow3_TX_Dun_diss", packageName = "effects/particles.prefabs.skilleffects.boss_06shdow.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[170] = {id = 170, effectName = "BOSS09shdow4_TX_Dun_diss", packageName = "effects/particles.prefabs.skilleffects.boss_06shdow.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[171] = {id = 171, effectName = "Mon_TX_w3_32_kuanghua", packageName = "effects/particles.prefabs.skilleffects.mon_w3_32.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[172] = {id = 172, effectName = "Mon_TX_base_boss01_MiShu_FaDiAn_QiangHua_Buff", packageName = "effects/particles.prefabs.skilleffects.boss_01mishu.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[173] = {id = 173, effectName = "Mon_TX_W3_37_dun_buff", packageName = "effects/particles.prefabs.skilleffects.mon_w3_37.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[174] = {id = 174, effectName = "Mon_TX_W3_35_du_debuff_B", packageName = "effects/particles.prefabs.skilleffects.mon_w3_35.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[175] = {id = 175, effectName = "Char_001_V1_TX_shikongzhuanyi_zouni", packageName = "effects/particles.prefabs.skilleffects.char_001.assetbundle", socket = "HitPoint", isInEffectSocket = "1"}
, 
[176] = {id = 176, effectName = "Char_001_V1_TX_shikongzhuanyi_huilai", packageName = "effects/particles.prefabs.skilleffects.char_001.assetbundle", socket = "HitPoint", isInEffectSocket = "1"}
, 
[177] = {id = 177, effectName = "Char_001_V1_TX_shijianjiasu", packageName = "effects/particles.prefabs.skilleffects.char_001.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[178] = {id = 178, effectName = "Char_001_V1_TX_shijianjiasu_xiaoshi", packageName = "effects/particles.prefabs.skilleffects.char_001.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[179] = {id = 179, effectName = "Mon_TX_base_boss01_XueQiBaiFa", packageName = "effects/particles.prefabs.skilleffects.boss_01mishu.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[180] = {id = 180, effectName = "Boss_TX_w3_03_TunShi_RenZou", packageName = "effects/particles.prefabs.skilleffects.boss_w3_03.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "1"}
, 
[181] = {id = 181, effectName = "Boss_TX_w3_03_TunShi_RenHui", packageName = "effects/particles.prefabs.skilleffects.boss_w3_03.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "1"}
, 
[182] = {id = 182, effectName = "BOSS02knight_TX_ZhuoShao_buff", packageName = "effects/particles.prefabs.skilleffects.boss_02knight.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[183] = {id = 183, effectName = "Mon_TX_W4_01_zibao_att", packageName = "effects/particles.prefabs.skilleffects.mon_w4_01.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[184] = {id = 184, effectName = "Char_017_v1_dun", packageName = "effects/particles.prefabs.skilleffects.char_017.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[185] = {id = 185, effectName = "Char_065_TX_XuLi_fen_HP", packageName = "effects/particles.prefabs.skilleffects.char_065.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[186] = {id = 186, effectName = "Char_063_TX_jingzhishouhu_loop_B", packageName = "effects/particles.prefabs.skilleffects.char_063.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[187] = {id = 187, effectName = "Char_048_TX_buff_lan_H", packageName = "effects/particles.prefabs.skilleffects.char_048.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[188] = {id = 188, effectName = "Char_048_TX_buff_huang_H", packageName = "effects/particles.prefabs.skilleffects.char_048.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[189] = {id = 189, effectName = "Char_048_TX_buff_red_H", packageName = "effects/particles.prefabs.skilleffects.char_048.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[190] = {id = 190, effectName = "Char_012_buff_HP", packageName = "effects/particles.prefabs.skilleffects.char_012.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[191] = {id = 191, effectName = "Char_058_TX_RiZhiZhou_buff_jin", packageName = "effects/particles.prefabs.skilleffects.char_058.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[192] = {id = 192, effectName = "Mon_base_13_stand_B", packageName = "effects/particles.prefabs.skilleffects.mon_base_13.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[193] = {id = 193, effectName = "Mon_base_13_fumianqixi_buff_HP", packageName = "effects/particles.prefabs.skilleffects.mon_base_13.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[194] = {id = 194, effectName = "Mon_base_14_baonu_buff_B", packageName = "effects/particles.prefabs.skilleffects.mon_base_14.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[195] = {id = 195, effectName = "Mon_base_010_TanLan_ShiXue", packageName = "effects/particles.prefabs.skilleffects.mon_base_010.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[196] = {id = 196, effectName = "Char_001_V1_TX_shikongzhuanyi_zouni", packageName = "effects/particles.prefabs.skilleffects.char_001.assetbundle", socket = "HitPoint", isInEffectSocket = "1"}
, 
[197] = {id = 197, effectName = "Char_001_V1_TX_shikongzhuanyi_huilai", packageName = "effects/particles.prefabs.skilleffects.char_001.assetbundle", socket = "HitPoint", isInEffectSocket = "1"}
, 
[198] = {id = 198, effectName = "Mon_base_15_JingZhong_HP", packageName = "effects/particles.prefabs.skilleffects.mon_base_15.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[199] = {id = 199, effectName = "Mon_base_17_tunshi_HP", packageName = "effects/particles.prefabs.skilleffects.mon_base_17.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[200] = {id = 200, effectName = "Char_023_TX_Prefab_JunHeng", packageName = "effects/particles.prefabs.skilleffects.char_023.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[201] = {id = 201, effectName = "Char_081_dun_B", packageName = "effects/particles.prefabs.skilleffects.char_081.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[202] = {id = 202, effectName = "Char_081_ZhiYuZhiShou_B", packageName = "effects/particles.prefabs.skilleffects.char_081.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[203] = {id = 203, effectName = "Mon_sum_02_LuanDa_HP", packageName = "effects/particles.prefabs.skilleffects.mon_sum_02.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[204] = {id = 204, effectName = "Char_078_TX_GeDang_HP", packageName = "effects/particles.prefabs.skilleffects.char_078.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[205] = {id = 205, effectName = "Char_078_TX_GeDang_B_loop", packageName = "effects/particles.prefabs.skilleffects.char_078.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[206] = {id = 206, effectName = "Char_078_TX_TingDun_HP_att", packageName = "effects/particles.prefabs.skilleffects.char_078.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[207] = {id = 207, effectName = "Mon_sum_06_magic_HP", packageName = "effects/particles.prefabs.skilleffects.mon_sum_06.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[208] = {id = 208, effectName = "Char_079_Magic_Buff_HP", packageName = "effects/particles.prefabs.skilleffects.char_079.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[209] = {id = 209, effectName = "Mon_sum_01_XuanWo_B", packageName = "effects/particles.prefabs.skilleffects.mon_sum_01.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[210] = {id = 210, effectName = "Mon_sum_03_LaoLong_B", packageName = "effects/particles.prefabs.skilleffects.mon_sum_03.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[211] = {id = 211, effectName = "Char_083_TX_debuff_HP", packageName = "effects/particles.prefabs.skilleffects.char_083.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[212] = {id = 212, effectName = "Char_080_JinJiZhiShu_debuff_B", packageName = "effects/particles.prefabs.skilleffects.char_080.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[213] = {id = 213, effectName = "Char_080_CiYuan_debuff_HP", packageName = "effects/particles.prefabs.skilleffects.char_080.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[214] = {id = 214, effectName = "Char_110_maoshi_debuff_HP", packageName = "effects/particles.prefabs.skilleffects.char_110.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[215] = {id = 215, effectName = "Char_108_Magic2_dun_B", packageName = "effects/particles.prefabs.skilleffects.char_108.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[216] = {id = 216, effectName = "Char_110_yueyueyushi_dun_B", packageName = "effects/particles.prefabs.skilleffects.char_110.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[217] = {id = 217, effectName = "Char_110_maoshi_debuff_HP", packageName = "effects/particles.prefabs.skilleffects.char_110.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[218] = {id = 218, effectName = "Mon_chun01_yuansuhujia_zishen", packageName = "effects/particles.prefabs.skilleffects.mon_chun01.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[219] = {id = 219, effectName = "Mon_chun02_yuansuhujia_zishen", packageName = "effects/particles.prefabs.skilleffects.mon_chun01.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[220] = {id = 220, effectName = "Mon_chun03_yuansuhujia_zishen", packageName = "effects/particles.prefabs.skilleffects.mon_chun01.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[221] = {id = 221, effectName = "Char_100_magic2_dun", packageName = "effects/particles.prefabs.skilleffects.char_100.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[222] = {id = 222, effectName = "Char_106_WuXinZhiShi_buff", packageName = "effects/particles.prefabs.skilleffects.char_106.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[223] = {id = 223, effectName = "Char_049_v1_TX_BDXL_buff_HP", packageName = "effects/particles.prefabs.skilleffects.char_049.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[224] = {id = 224, effectName = "Mon_vlt01_magic3_fly", packageName = "effects/particles.prefabs.skilleffects.mon_vlt01.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[225] = {id = 225, effectName = "Char_066_TX_HuanJingLiChang_buff", packageName = "effects/particles.prefabs.skilleffects.char_066.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[226] = {id = 226, effectName = "Char_018_v1_TX_Prefab_PingZhang", packageName = "effects/particles.prefabs.skilleffects.char_018.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[227] = {id = 227, effectName = "Char_018_v1_TX_Prefab_PingZhang_hit", packageName = "effects/particles.prefabs.skilleffects.char_018.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[228] = {id = 228, effectName = "Char_018_v1_TX_Prefab_ShouHu", packageName = "effects/particles.prefabs.skilleffects.char_018.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[229] = {id = 229, effectName = "Char_099_Stand_HP", packageName = "effects/particles.prefabs.skilleffects.char_099.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[230] = {id = 230, effectName = "Char_099_yun_Head", packageName = "effects/particles.prefabs.skilleffects.char_099.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[231] = {id = 231, effectName = "Char_046_TX_LangLingXueMai_buff", packageName = "effects/particles.prefabs.skilleffects.char_046.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[232] = {id = 232, effectName = "Char_046_TX_LangLingZhenShe_hudun", packageName = "effects/particles.prefabs.skilleffects.char_046.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[233] = {id = 233, effectName = "BOSS_TX_w6_4_jizhongdianliu_debuff", packageName = "effects/particles.prefabs.skilleffects.boss_w6_4.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[234] = {id = 234, effectName = "BOSS_TX_w6_4_nenglianghudun_zishen", packageName = "effects/particles.prefabs.skilleffects.boss_w6_4.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[235] = {id = 235, effectName = "BOSS_TX_w6_4_jizhongdianliu_debuff", packageName = "effects/particles.prefabs.skilleffects.boss_w6_4.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[236] = {id = 236, effectName = "Mon_TX_W3_m01_monengzhaohuan_att", packageName = "effects/particles.prefabs.skilleffects.mon_w3_m01.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[237] = {id = 237, effectName = "Char_092_TX_ShanGuangDeAKaSha_buff", packageName = "effects/particles.prefabs.skilleffects.char_092.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[238] = {id = 238, effectName = "Char_092_TX_XingGuangJiaShi_buff", packageName = "effects/particles.prefabs.skilleffects.char_092.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[239] = {id = 239, effectName = "Char_103_TX_Prefab_YaoJingZhuFu_hudun", packageName = "effects/particles.prefabs.skilleffects.char_103.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[240] = {id = 240, effectName = "Char_102_TX_Prefab_HongYeHe_hudun_loop", packageName = "effects/particles.prefabs.skilleffects.char_102.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[241] = {id = 241, effectName = "Char_102_TX_Prefab_HongYeHe_hudun_end", packageName = "effects/particles.prefabs.skilleffects.char_102.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[242] = {id = 242, effectName = "Char_102_TX_Prefab_HongYeHe_huixue", packageName = "effects/particles.prefabs.skilleffects.char_102.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[243] = {id = 243, effectName = "Char_085_TX_Prefab_ZhiYuFenChen_buff", packageName = "effects/particles.prefabs.skilleffects.char_085.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[244] = {id = 244, effectName = "BOSS_TX_w6_3_yunzhongmanbu_zishen", packageName = "effects/particles.prefabs.skilleffects.boss_w6_3.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[245] = {id = 245, effectName = "BOSS_TX_w6_3_feieranhuo_zishen", packageName = "effects/particles.prefabs.skilleffects.boss_w6_3.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[246] = {id = 246, effectName = "BOSS_TX_w6_3_yunqifanyong_penchu", packageName = "effects/particles.prefabs.skilleffects.boss_w6_3.assetbundle", socket = "ShootPoint1", isInEffectSocket = "0"}
, 
[247] = {id = 247, effectName = "Char_101_TX_Prefab_HaiZhiBiYou_buff", packageName = "effects/particles.prefabs.skilleffects.char_101.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[248] = {id = 248, effectName = "BOSS_TX_kuangbao_M", packageName = "effects/particles.prefabs.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[249] = {id = 249, effectName = "BOSS_TX_kuangbao_L", packageName = "effects/particles.prefabs.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[250] = {id = 250, effectName = "BOSS_TX_kuangbao_XL", packageName = "effects/particles.prefabs.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[251] = {id = 251, effectName = "BOSS_TX_W6_01_nengliangxishou_hudun", packageName = "effects/particles.prefabs.skilleffects.boss_w6_1.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[252] = {id = 252, effectName = "BOSS_TX_W6_01_nengliangxishou_buff", packageName = "effects/particles.prefabs.skilleffects.boss_w6_1.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[253] = {id = 253, effectName = "BOSS_TX_W6_02_daiji", packageName = "effects/particles.prefabs.skilleffects.boss_w6_2.assetbundle", socket = "HitPoint1", isInEffectSocket = "0"}
, 
[254] = {id = 254, effectName = "BOSS_TX_W6_02_nengliangxishou_hudun", packageName = "effects/particles.prefabs.skilleffects.boss_w6_2.assetbundle", socket = "HitPoint1", isInEffectSocket = "0"}
, 
[255] = {id = 255, effectName = "BOSS_TX_W6_02_nengliangxishou_buff", packageName = "effects/particles.prefabs.skilleffects.boss_w6_2.assetbundle", socket = "HitPoint1", isInEffectSocket = "0"}
, 
[256] = {id = 256, effectName = "BOSS_TX_W6_02_shouhuzhedeweiyan_zishen", packageName = "effects/particles.prefabs.skilleffects.boss_w6_2.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[257] = {id = 257, effectName = "Char_088_ShenXing_buff", packageName = "effects/particles.prefabs.skilleffects.char_088.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[258] = {id = 258, effectName = "Char_112_Dun_loop_B", packageName = "effects/particles.prefabs.skilleffects.char_112.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[259] = {id = 259, effectName = "Char_120_TX_beidong", packageName = "effects/particles.prefabs.skilleffects.char_120.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[260] = {id = 260, effectName = "Char_052_v1_TX_TSZX_zishen_buff_B", packageName = "effects/particles.prefabs.skilleffects.char_052_v1.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[261] = {id = 261, effectName = "Char_052_v1_TX_TSZX_hudun_buff", packageName = "effects/particles.prefabs.skilleffects.char_052_v1.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[266] = {id = 266, effectName = "Char_043_v1_ZhiMingDuWu_buff", packageName = "effects/particles.prefabs.skilleffects.char_043.assetbundle", socket = "HitPoint_Head", isInEffectSocket = "0"}
, 
[267] = {id = 267, effectName = "Char_032_v1_RongYaoZhiQi_hudun", packageName = "effects/particles.prefabs.skilleffects.char_032_v1.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[268] = {id = 268, effectName = "Char_032_v1_shenzhibiyou_buff_B", packageName = "effects/particles.prefabs.skilleffects.char_032_v1.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[269] = {id = 269, effectName = "Char_109_Dun_B", packageName = "effects/particles.prefabs.skilleffects.char_109.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
, 
[270] = {id = 270, effectName = "Char_098_m2_dun_hp", packageName = "effects/particles.prefabs.skilleffects.char_098.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[271] = {id = 271, effectName = "Char_103_v1_TX_Prefab_YaoJingZhuFu_hudun", packageName = "effects/particles.prefabs.skilleffects.char_103_v1.assetbundle", socket = "HitPoint", isInEffectSocket = "0"}
, 
[272] = {id = 272, effectName = "Char_126_TX_magic2_B", packageName = "effects/particles.prefabs.skilleffects.char_126.assetbundle", socket = "HitPoint_Bottom", isInEffectSocket = "0"}
}
cbuffeffect.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 17, 19, 21, 22, 23, 24, 25, 26, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 45, 46, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 101, 102, 103, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 266, 267, 268, 269, 270, 271, 272}
return cbuffeffect

