-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/sound/csoundsource.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local csoundsource = {}
csoundsource.Data = {
[1] = {id = 1, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_scene_login", volume = 100}
, 
[2] = {id = 2, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_scene_firstscenemap", volume = 100}
, 
[3] = {id = 3, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_battle_normal1", volume = 80}
, 
[4] = {id = 4, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_battle_victory", volume = 100}
, 
[5] = {id = 5, required = 1, cueSheet = "main:SE/dead", cueName = "SOUND_skill_dead_disappear", volume = 90}
, 
[6] = {id = 6, required = 1, cueSheet = "main:SE/nomalattack", cueName = "SOUND_skill_nomalattack_01", volume = 90}
, 
[7] = {id = 7, required = 1, cueSheet = "main:SE/nomalattack", cueName = "SOUND_skill_nomalattack_02", volume = 90}
, 
[8] = {id = 8, required = 1, cueSheet = "main:SE/shenzhihuo", cueName = "SOUND_skill_shenzhihuo_01", volume = 90}
, 
[9] = {id = 9, required = 1, cueSheet = "main:SE/shenzhihuo", cueName = "SOUND_skill_shenzhihuo_02", volume = 90}
, 
[10] = {id = 10, required = 1, cueSheet = "main:SE/shenzhihuo", cueName = "SOUND_skill_shenzhihuo_02", volume = 90}
, 
[11] = {id = 11, required = 1, cueSheet = "main:SE/shenzhihuo", cueName = "SOUND_skill_shenzhihuo_03", volume = 90}
, 
[12] = {id = 12, required = 1, cueSheet = "main:SE/shenzhihuo", cueName = "SOUND_skill_shenzhihuo_01", volume = 90}
, 
[13] = {id = 13, required = 1, cueSheet = "main:SE/shenzhihuo", cueName = "SOUND_skill_shenzhihuo_02", volume = 90}
, 
[14] = {id = 14, required = 1, cueSheet = "main:SE/shenzhihuo", cueName = "SOUND_skill_shenzhihuo_03", volume = 90}
, 
[15] = {id = 15, required = 1, cueSheet = "main:SE/zhiliao", cueName = "SOUND_skill_zhiliao_01", volume = 90}
, 
[16] = {id = 16, required = 1, cueSheet = "main:SE/qianghua", cueName = "SOUND_skill_qianghua_01", volume = 90}
, 
[17] = {id = 17, required = 1, cueSheet = "main:SE/chaofeng", cueName = "SOUND_skill_chaofeng_01", volume = 90}
, 
[18] = {id = 18, required = 1, cueSheet = "main:SE/fengxian", cueName = "SOUND_skill_fengxian_01", volume = 90}
, 
[19] = {id = 19, required = 1, cueSheet = "main:SE/xuanyun", cueName = "SOUND_skill_xuanyun_01", volume = 90}
, 
[20] = {id = 20, required = 1, cueSheet = "main:SE/xuanyun", cueName = "SOUND_skill_xuanyun_02", volume = 90}
, 
[21] = {id = 21, required = 1, cueSheet = "main:SE/xixue", cueName = "SOUND_skill_xixue_01", volume = 90}
, 
[22] = {id = 22, required = 1, cueSheet = "main:SE/xixue", cueName = "SOUND_skill_xixue_02", volume = 90}
, 
[23] = {id = 23, required = 1, cueSheet = "main:SE/nomalattack", cueName = "SOUND_skill_nomalattack_01", volume = 90}
, 
[24] = {id = 24, required = 1, cueSheet = "main:SE/nomalattack", cueName = "SOUND_skill_nomalattack_02", volume = 90}
, 
[25] = {id = 25, required = 1, cueSheet = "main:SE/shenzhihuo", cueName = "SOUND_skill_shenzhihuo_03", volume = 90}
, 
[26] = {id = 26, required = 1, cueSheet = "main:SE/nomalattack", cueName = "SOUND_skill_nomalattack_02", volume = 90}
, 
[27] = {id = 27, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_rain", volume = 100}
, 
[28] = {id = 28, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_quiet", volume = 100}
, 
[29] = {id = 29, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_lakeside", volume = 100}
, 
[30] = {id = 30, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_lighton", volume = 100}
, 
[31] = {id = 31, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_towergateopen", volume = 100}
, 
[32] = {id = 32, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_battle_boss1", volume = 80}
, 
[33] = {id = 33, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_scene_tower", volume = 100}
, 
[34] = {id = 34, required = 1, cueSheet = "main:BGM/firstscene", cueName = "BGM_story_firstscene_wakeup", volume = 100}
, 
[35] = {id = 35, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_shixiangguidown", volume = 100}
, 
[36] = {id = 36, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_shixiangguishow", volume = 100}
, 
[37] = {id = 37, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_shixiangguijump", volume = 100}
, 
[38] = {id = 38, required = 1, cueSheet = "main:SE/role", cueName = "SOUND_role_footstep_walking", volume = 100}
, 
[39] = {id = 39, required = 1, cueSheet = "main:SE/role", cueName = "SOUND_role_footstep_running", volume = 100}
, 
[40] = {id = 40, required = 1, cueSheet = "main:SE/role", cueName = "SOUND_role_haton", volume = 100}
, 
[41] = {id = 41, required = 1, cueSheet = "main:SE/role", cueName = "SOUND_role_shimmer_1", volume = 100}
, 
[42] = {id = 42, required = 1, cueSheet = "main:SE/baozi", cueName = "SOUND_skill_baozi_01", volume = 90}
, 
[43] = {id = 43, required = 1, cueSheet = "main:SE/chanraotengman", cueName = "SOUND_skill_chanraotengman_01", volume = 90}
, 
[44] = {id = 44, required = 1, cueSheet = "main:SE/chanraotengman", cueName = "SOUND_skill_chanraotengman_02", volume = 90}
, 
[45] = {id = 45, required = 1, cueSheet = "main:SE/fenshen", cueName = "SOUND_skill_fenshen_01", volume = 90}
, 
[46] = {id = 46, required = 1, cueSheet = "main:SE/jingjijianci", cueName = "SOUND_skill_jingjijianci_01", volume = 90}
, 
[47] = {id = 47, required = 1, cueSheet = "main:SE/molihudun", cueName = "SOUND_skill_molihudun_01", volume = 90}
, 
[48] = {id = 48, required = 1, cueSheet = "main:SE/molihudun", cueName = "SOUND_skill_molihudun_02", volume = 90}
, 
[49] = {id = 49, required = 1, cueSheet = "main:SE/shandianfengbao", cueName = "SOUND_skill_shandianfengbao_01", volume = 90}
, 
[50] = {id = 50, required = 1, cueSheet = "main:SE/shandianfengbao", cueName = "SOUND_skill_shandianfengbao_02", volume = 90}
, 
[51] = {id = 51, required = 1, cueSheet = "main:SE/zhanyi", cueName = "SOUND_skill_zhanyi_01", volume = 90}
, 
[52] = {id = 52, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_battle_demobattle", volume = 80}
, 
[53] = {id = 53, required = 1, cueSheet = "main:SE/ui", cueName = "SOUND_ui_skillready", volume = 100}
, 
[54] = {id = 54, required = 1, cueSheet = "main:SE/fengkuangshengzhang", cueName = "SOUND_skill_fengkuangshengzhang_01", volume = 90}
, 
[55] = {id = 55, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_torch", volume = 100}
, 
[56] = {id = 56, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_noise", volume = 100}
, 
[57] = {id = 57, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_monstershout", volume = 100}
, 
[58] = {id = 58, required = 1, cueSheet = "main:BGM/character", cueName = "BGM_role_blackcat", volume = 100}
, 
[59] = {id = 59, required = 1, cueSheet = "main:BGM/universal", cueName = "BGM_story_universal_meetboss", volume = 100}
, 
[60] = {id = 60, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_battle_boss2", volume = 80}
, 
[61] = {id = 61, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_scene_timetunnel", volume = 100}
, 
[62] = {id = 62, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_bird", volume = 100}
, 
[63] = {id = 63, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_cheston", volume = 100}
, 
[64] = {id = 64, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_insect", volume = 100}
, 
[65] = {id = 65, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_lifts", volume = 100}
, 
[66] = {id = 66, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_lightroadon", volume = 100}
, 
[67] = {id = 67, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_mirrogleam", volume = 100}
, 
[68] = {id = 68, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_mirroup", volume = 100}
, 
[69] = {id = 69, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_pullgear", volume = 100}
, 
[70] = {id = 70, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_scene_empty", volume = 100}
, 
[71] = {id = 71, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_birdfly", volume = 100}
, 
[72] = {id = 72, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_mirrorrotate", volume = 100}
, 
[73] = {id = 73, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_gateopen", volume = 100}
, 
[74] = {id = 74, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_shixiangguieye", volume = 100}
, 
[75] = {id = 75, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_shixiangguistone", volume = 100}
, 
[76] = {id = 76, required = 1, cueSheet = "main:BGM/firstscene", cueName = "BGM_story_firstscene_asleep", volume = 100}
, 
[77] = {id = 77, required = 1, cueSheet = "main:BGM/firstscene", cueName = "BGM_story_firstscene_wakeup1", volume = 100}
, 
[78] = {id = 78, required = 1, cueSheet = "main:BGM/firstscene", cueName = "BGM_story_firstscene_climax", volume = 100}
, 
[79] = {id = 79, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_pageturn", volume = 100}
, 
[80] = {id = 80, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_lampfall", volume = 100}
, 
[81] = {id = 81, required = 1, cueSheet = "main:SE/guangzili", cueName = "SOUND_skill_guangzili_01", volume = 90}
, 
[82] = {id = 82, required = 1, cueSheet = "main:SE/kulouchui", cueName = "SOUND_skill_kulouchui_01", volume = 90}
, 
[83] = {id = 83, required = 1, cueSheet = "main:SE/linghunjian", cueName = "SOUND_skill_linghunjian_01", volume = 90}
, 
[84] = {id = 84, required = 1, cueSheet = "main:SE/linghunjian", cueName = "SOUND_skill_linghunjian_02", volume = 90}
, 
[85] = {id = 85, required = 1, cueSheet = "main:SE/modan", cueName = "SOUND_skill_modan_01", volume = 90}
, 
[86] = {id = 86, required = 1, cueSheet = "main:SE/modan", cueName = "SOUND_skill_modan_02", volume = 90}
, 
[87] = {id = 87, required = 1, cueSheet = "main:SE/molizhendang", cueName = "SOUND_skill_molizhendang_01", volume = 90}
, 
[88] = {id = 88, required = 1, cueSheet = "main:SE/normalattackzhua", cueName = "SOUND_skill_normalattackzhua_01", volume = 90}
, 
[89] = {id = 89, required = 1, cueSheet = "main:SE/rouguang", cueName = "SOUND_skill_rouguang_01", volume = 90}
, 
[90] = {id = 90, required = 1, cueSheet = "main:SE/yuanling", cueName = "SOUND_skill_yuanling_01", volume = 90}
, 
[91] = {id = 91, required = 1, cueSheet = "main:SE/yuanling", cueName = "SOUND_skill_yuanling_02", volume = 90}
, 
[92] = {id = 92, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_stoneroll", volume = 100}
, 
[93] = {id = 93, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_mirrofloat", volume = 100}
, 
[94] = {id = 94, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_mirroridle", volume = 100}
, 
[95] = {id = 95, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_bossattack", volume = 100}
, 
[96] = {id = 96, required = 1, cueSheet = "main:SE/ui", cueName = "SOUND_ui_getItem1", volume = 100}
, 
[97] = {id = 97, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_scene_grassland", volume = 100}
, 
[98] = {id = 98, required = 1, cueSheet = "main:SE/xiaoleiji", cueName = "SOUND_skill_xiaoleiji_01", volume = 90}
, 
[99] = {id = 99, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_brightcombine", volume = 100}
, 
[100] = {id = 100, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_catdisappear", volume = 100}
, 
[101] = {id = 101, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_throughmirror", volume = 100}
, 
[102] = {id = 102, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_pinjingzi", volume = 100}
, 
[103] = {id = 103, required = 1, cueSheet = "main:SE/linghunjian", cueName = "SOUND_skill_linghunjian_03", volume = 90}
, 
[104] = {id = 104, required = 1, cueSheet = "main:SE/heianqinshi", cueName = "SOUND_skill_heianqinshi_01", volume = 90}
, 
[105] = {id = 105, required = 1, cueSheet = "main:SE/zhongming", cueName = "SOUND_skill_zhongming", volume = 90}
, 
[106] = {id = 106, required = 1, cueSheet = "main:SE/shizhijiasuo", cueName = "SOUND_skill_shizhijiasuo_01", volume = 90}
, 
[107] = {id = 107, required = 1, cueSheet = "main:SE/shizhijiasuo", cueName = "SOUND_skill_shizhijiasuo_02", volume = 90}
, 
[108] = {id = 108, required = 1, cueSheet = "main:SE/xishoulinghun", cueName = "SOUND_skill_xishoulinghun", volume = 90}
, 
[109] = {id = 109, required = 1, cueSheet = "main:SE/linghunshichu", cueName = "SOUND_skill_linghunshichu", volume = 90}
, 
[110] = {id = 110, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_mirroup_02", volume = 100}
, 
[111] = {id = 111, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_statue", volume = 100}
, 
[112] = {id = 112, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_brightcombine_1", volume = 100}
, 
[113] = {id = 113, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_scene_magicforest", volume = 100}
, 
[129] = {id = 129, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_scene_magicforest2", volume = 100}
, 
[130] = {id = 130, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_scene_towermaze", volume = 100}
, 
[131] = {id = 131, required = 1, cueSheet = "main:BGM/character", cueName = "BGM_role_frog", volume = 100}
, 
[132] = {id = 132, required = 1, cueSheet = "main:BGM/magicforest", cueName = "BGM_story_magicforest_forestgoddess", volume = 100}
, 
[133] = {id = 133, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_battle_forestgoddess", volume = 80}
, 
[134] = {id = 134, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_battle_normal2", volume = 80}
, 
[135] = {id = 135, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_scene_magicforest1", volume = 100}
, 
[136] = {id = 136, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_scene_menu", volume = 100}
, 
[137] = {id = 137, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_battle_defeat", volume = 80}
, 
[138] = {id = 138, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_vinegrow", volume = 100}
, 
[139] = {id = 139, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_vinesink", volume = 100}
, 
[140] = {id = 140, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_stonedoor", volume = 100}
, 
[141] = {id = 141, required = 1, cueSheet = "main:SE/baoji", cueName = "SOUND_skill_baoji", volume = 90}
, 
[142] = {id = 142, required = 1, cueSheet = "main:SE/bianfu", cueName = "SOUND_skill_bianfu_att", volume = 90}
, 
[143] = {id = 143, required = 1, cueSheet = "main:SE/bianfu", cueName = "SOUND_skill_bianfu", volume = 90}
, 
[144] = {id = 144, required = 1, cueSheet = "main:SE/bingfeng", cueName = "SOUND_skill_bingfeng", volume = 90}
, 
[145] = {id = 145, required = 1, cueSheet = "main:SE/bingjian", cueName = "SOUND_skill_bingjianshouji", volume = 90}
, 
[146] = {id = 146, required = 1, cueSheet = "main:SE/bingjian", cueName = "SOUND_skill_bingjian", volume = 90}
, 
[147] = {id = 147, required = 1, cueSheet = "main:SE/bishou", cueName = "SOUND_skill_bishou", volume = 90}
, 
[148] = {id = 148, required = 1, cueSheet = "main:SE/baofengxue", cueName = "SOUND_skill_chuixue_shifa", volume = 90}
, 
[149] = {id = 149, required = 1, cueSheet = "main:SE/baofengxue", cueName = "SOUND_skill_chuixue", volume = 90}
, 
[150] = {id = 150, required = 1, cueSheet = "main:SE/hudie", cueName = "SOUND_skill_hudiedeath", volume = 90}
, 
[151] = {id = 151, required = 1, cueSheet = "main:SE/hudie", cueName = "SOUND_skill_hudiehunshuilinpian", volume = 90}
, 
[152] = {id = 152, required = 1, cueSheet = "main:SE/huixuanliandao", cueName = "SOUND_skill_huixuanliandao", volume = 90}
, 
[153] = {id = 153, required = 1, cueSheet = "main:SE/jingjisheji", cueName = "SOUND_skill_jingjisheji", volume = 90}
, 
[154] = {id = 154, required = 1, cueSheet = "main:SE/jinjihuibi", cueName = "SOUND_skill_jinjihuibi", volume = 90}
, 
[155] = {id = 155, required = 1, cueSheet = "main:SE/kulouwang", cueName = "SOUND_skill_kulouwangdeath", volume = 90}
, 
[156] = {id = 156, required = 1, cueSheet = "main:SE/kulouwang", cueName = "SOUND_skill_kulouwanghuozhu", volume = 90}
, 
[157] = {id = 157, required = 1, cueSheet = "main:SE/leijian", cueName = "SOUND_skill_leijian", volume = 90}
, 
[158] = {id = 158, required = 1, cueSheet = "main:SE/liandaopikan", cueName = "SOUND_skill_liandaopikan", volume = 90}
, 
[159] = {id = 159, required = 1, cueSheet = "main:SE/liqishouji", cueName = "SOUND_skill_liqishouji_att", volume = 90}
, 
[160] = {id = 160, required = 1, cueSheet = "main:SE/lvdonghuisu", cueName = "SOUND_skill_lvdonghuisu", volume = 90}
, 
[161] = {id = 161, required = 1, cueSheet = "main:SE/meihuo", cueName = "SOUND_skill_meihuo_att", volume = 90}
, 
[162] = {id = 162, required = 1, cueSheet = "main:SE/yepianfeidao", cueName = "SOUND_skill_yepianfeidao", volume = 90}
, 
[163] = {id = 163, required = 1, cueSheet = "main:SE/zhongjian", cueName = "SOUND_skill_zhongjian", volume = 70}
, 
[164] = {id = 164, required = 1, cueSheet = "main:SE/meimohuo", cueName = "SOUND_skill_meimohuo", volume = 90}
, 
[165] = {id = 165, required = 1, cueSheet = "main:SE/moguzhuangji", cueName = "SOUND_skill_moguzhuangji", volume = 90}
, 
[166] = {id = 166, required = 1, cueSheet = "main:SE/zhentou", cueName = "SOUND_skill_zhentou", volume = 90}
, 
[167] = {id = 167, required = 1, cueSheet = "main:SE/yingxi", cueName = "SOUND_skill_yingxi", volume = 90}
, 
[168] = {id = 168, required = 1, cueSheet = "main:SE/yanxingfeidan", cueName = "SOUND_skill_yanxingfeidan", volume = 90}
, 
[169] = {id = 169, required = 1, cueSheet = "main:SE/xiaoguaisiwang", cueName = "SOUND_skill_xiaoguaisiwang", volume = 90}
, 
[170] = {id = 170, required = 1, cueSheet = "main:SE/shizhongguaisiwang", cueName = "SOUND_skill_shizhongguaideath", volume = 90}
, 
[171] = {id = 171, required = 1, cueSheet = "main:SE/shixiangguideath", cueName = "SOUND_skill_shixiangguideath", volume = 90}
, 
[172] = {id = 172, required = 1, cueSheet = "main:SE/qingjian", cueName = "SOUND_skill_qingjian", volume = 90}
, 
[173] = {id = 173, required = 1, cueSheet = "main:SE/shitu", cueName = "SOUND_skill_shitu", volume = 100}
, 
[174] = {id = 174, required = 1, cueSheet = "main:SE/shitouren", cueName = "SOUND_skill_shitourenchuidi", volume = 100}
, 
[175] = {id = 175, required = 1, cueSheet = "main:SE/shitouren", cueName = "SOUND_skill_shitourendeath", volume = 90}
, 
[176] = {id = 176, required = 1, cueSheet = "main:SE/shilaimutuxi", cueName = "SOUND_skill_shilaimutuxi_att", volume = 90}
, 
[177] = {id = 177, required = 1, cueSheet = "main:SE/shilaimutuxi", cueName = "SOUND_skill_shilaimutuxi", volume = 90}
, 
[178] = {id = 178, required = 1, cueSheet = "main:SE/shijianjingu", cueName = "SOUND_skill_shijianjinguhui", volume = 90}
, 
[179] = {id = 179, required = 1, cueSheet = "main:SE/shijianjingu", cueName = "SOUND_skill_shijianjinguzou", volume = 90}
, 
[180] = {id = 180, required = 1, cueSheet = "main:SE/qingwatuci", cueName = "SOUND_skill_qingwatuci", volume = 90}
, 
[181] = {id = 181, required = 1, cueSheet = "main:SE/qiuxingfeidan", cueName = "SOUND_skill_qiuxingfeidan", volume = 90}
, 
[182] = {id = 182, required = 1, cueSheet = "main:SE/renxingfeidan", cueName = "SOUND_skill_renxingfeidan", volume = 90}
, 
[183] = {id = 183, required = 1, cueSheet = "main:SE/huzhilvdong", cueName = "SOUND_skill_huzhilvdong", volume = 90}
, 
[184] = {id = 184, required = 1, cueSheet = "main:SE/shizhijiasuo", cueName = "SOUND_skill_shizhijiasuo", volume = 100}
, 
[185] = {id = 185, required = 1, cueSheet = "main:SE/mao", cueName = "SOUND_skill_mao", volume = 90}
, 
[186] = {id = 186, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_scene_gacha", volume = 100}
, 
[187] = {id = 187, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_hudiehuo", volume = 90}
, 
[188] = {id = 188, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_jianjiaoshouji", volume = 90}
, 
[189] = {id = 189, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_jingjici_att", volume = 90}
, 
[190] = {id = 190, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_kuanghua", volume = 90}
, 
[191] = {id = 191, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_liuguangzhan24", volume = 90}
, 
[192] = {id = 192, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_liuguangzhan135", volume = 90}
, 
[193] = {id = 193, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_liuguangzhanchongci", volume = 90}
, 
[194] = {id = 194, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_liuxingzhan", volume = 90}
, 
[195] = {id = 195, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_luodi", volume = 90}
, 
[196] = {id = 196, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_pingzhang", volume = 90}
, 
[197] = {id = 197, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_pingzhangposui", volume = 90}
, 
[198] = {id = 198, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_qingliqi_att", volume = 90}
, 
[199] = {id = 199, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_qirenzhan", volume = 90}
, 
[200] = {id = 200, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_renxingfeidan_att", volume = 90}
, 
[201] = {id = 201, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_senlinnvshendeath", volume = 90}
, 
[202] = {id = 202, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_shenshoudejiahu", volume = 90}
, 
[203] = {id = 203, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_shibukedang", volume = 90}
, 
[204] = {id = 204, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_shitourenquanfeng_att", volume = 100}
, 
[205] = {id = 205, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_shiwenzizhan", volume = 90}
, 
[206] = {id = 206, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_shouhu", volume = 90}
, 
[207] = {id = 207, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_shouhuzhiyu", volume = 90}
, 
[208] = {id = 208, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_suijia", volume = 90}
, 
[209] = {id = 209, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_xiangrikuijianjiao", volume = 90}
, 
[210] = {id = 210, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_xuanfengzhanchong", volume = 90}
, 
[211] = {id = 211, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_xuanfengzhanhui", volume = 90}
, 
[212] = {id = 212, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_yuanzibenghuai_att", volume = 90}
, 
[213] = {id = 213, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_yuanzibenghuai_shifa", volume = 90}
, 
[214] = {id = 214, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_ziranzhiyu", volume = 90}
, 
[215] = {id = 215, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_ziranzhiyu_att", volume = 90}
, 
[216] = {id = 216, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_renxingfeidan_att_putong", volume = 90}
, 
[217] = {id = 217, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_chanlei", volume = 90}
, 
[218] = {id = 218, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_leijianzhan", volume = 90}
, 
[219] = {id = 219, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_leijianzhan_att", volume = 90}
, 
[220] = {id = 220, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_liuguangzhan_xialuo", volume = 90}
, 
[221] = {id = 221, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_qingwa_luodi", volume = 90}
, 
[222] = {id = 222, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_qingwajinchang_att", volume = 90}
, 
[223] = {id = 223, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_xuetiaoposui", volume = 90}
, 
[224] = {id = 224, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_zhentou_att", volume = 90}
, 
[225] = {id = 225, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_qiangguang", volume = 90}
, 
[226] = {id = 226, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_MonAppear", volume = 100}
, 
[227] = {id = 227, required = 1, cueSheet = "main:SE/ui", cueName = "SOUND_ui_lvlup", volume = 100}
, 
[228] = {id = 228, required = 1, cueSheet = "main:SE/bingfeng", cueName = "SOUND_skill_bingfeng_start", volume = 90}
, 
[229] = {id = 229, required = 1, cueSheet = "main:SE/bingfeng", cueName = "SOUND_skill_bingfeng_end", volume = 90}
, 
[230] = {id = 230, required = 1, cueSheet = "main:SE/role", cueName = "SOUND_role_footstep_highhell_walking", volume = 100}
, 
[231] = {id = 231, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_gatcha_SFX", volume = 100}
, 
[232] = {id = 232, required = 1, cueSheet = "main:SE/ui", cueName = "SOUND_ui_touchfeedback1", volume = 100}
, 
[233] = {id = 233, required = 1, cueSheet = "main:SE/ui", cueName = "SOUND_ui_touchfeedback2", volume = 100}
, 
[234] = {id = 234, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_scene_iceworld", volume = 100}
, 
[235] = {id = 235, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_icethorn", volume = 100}
, 
[236] = {id = 236, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_scene_towerToIceworld", volume = 100}
, 
[237] = {id = 237, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_icing", volume = 100}
, 
[238] = {id = 238, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_flash", volume = 100}
, 
[239] = {id = 239, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_icebreak", volume = 100}
, 
[240] = {id = 240, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_enviroment_howlingwind", volume = 100}
, 
[241] = {id = 241, required = 1, cueSheet = "main:BGM/iceworld", cueName = "BGM_story_iceworld_helpDyingGirls", volume = 100}
, 
[242] = {id = 242, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_scene_magicforest2", volume = 100}
, 
[243] = {id = 243, required = 1, cueSheet = "main:BGM/iceworld", cueName = "BGM_story_iceworld_icegoddess", volume = 100}
, 
[244] = {id = 244, required = 1, cueSheet = "main:BGM/iceworld", cueName = "BGM_story_iceworld_icegoddess2", volume = 100}
, 
[245] = {id = 245, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_lightTheBonfire", volume = 100}
, 
[246] = {id = 246, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_enviroment_volcanic1", volume = 100}
, 
[247] = {id = 247, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_enviroment_volcanic2", volume = 100}
, 
[248] = {id = 248, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_enviroment_volcanic3", volume = 100}
, 
[249] = {id = 249, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_enviroment_volcanic4", volume = 100}
, 
[250] = {id = 250, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_enviroment_earthshake", volume = 100}
, 
[251] = {id = 251, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_scene_magicforest3", volume = 100}
, 
[252] = {id = 252, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_skateBreak", volume = 100}
, 
[253] = {id = 253, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_battle_normal3", volume = 80}
, 
[254] = {id = 254, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_icethornRecover", volume = 100}
, 
[255] = {id = 255, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_crystalClusterBroken", volume = 100}
, 
[256] = {id = 256, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_scene_JangleBells", volume = 100}
, 
[257] = {id = 257, required = 1, cueSheet = "main:BGM/SwapBGM", cueName = "SwapBGM_role_frog", volume = 100}
, 
[258] = {id = 258, required = 1, cueSheet = "main:BGM/SwapBGM", cueName = "SwapBGM_role_blackcat", volume = 100}
, 
[259] = {id = 259, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_baoxiangguai", volume = 90}
, 
[260] = {id = 260, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_bianfushengbo", volume = 90}
, 
[261] = {id = 261, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_chuantousheji_fly", volume = 90}
, 
[262] = {id = 262, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_diaoshefashe", volume = 90}
, 
[263] = {id = 263, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_diaoshexialuo", volume = 90}
, 
[264] = {id = 264, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_erlianshe", volume = 90}
, 
[265] = {id = 265, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_gongbingbiaoji", volume = 90}
, 
[266] = {id = 266, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_gongjian_att", volume = 90}
, 
[267] = {id = 267, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_jianyu", volume = 90}
, 
[268] = {id = 268, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_jiejingchonghudun", volume = 90}
, 
[269] = {id = 269, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_jingjishejidanfa_fly", volume = 90}
, 
[270] = {id = 270, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_jingyingjianyu_att", volume = 90}
, 
[271] = {id = 271, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_jingyingjianyufengbao", volume = 90}
, 
[272] = {id = 272, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_langyao", volume = 90}
, 
[273] = {id = 273, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_mofashuhuo_att", volume = 90}
, 
[274] = {id = 274, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_mofashushui_att", volume = 90}
, 
[275] = {id = 275, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_sanlianshe", volume = 90}
, 
[276] = {id = 276, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_shijianfengbao_shifa", volume = 90}
, 
[277] = {id = 277, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_shuangjingqiang", volume = 90}
, 
[278] = {id = 278, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_shuimu", volume = 90}
, 
[279] = {id = 279, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_songguozibao", volume = 90}
, 
[280] = {id = 280, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_tuxueqiu", volume = 90}
, 
[281] = {id = 281, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_weibinghaoling", volume = 90}
, 
[282] = {id = 282, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_wuduwawa", volume = 90}
, 
[283] = {id = 283, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_xiaoguaisiwang", volume = 90}
, 
[284] = {id = 284, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_xiongpaoxiao", volume = 90}
, 
[285] = {id = 285, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_xiongzhua", volume = 90}
, 
[286] = {id = 286, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_xueguaitouzhixuekuai", volume = 90}
, 
[287] = {id = 287, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_xueguaixuekuai_att", volume = 90}
, 
[288] = {id = 288, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_xueguaiyangxue", volume = 90}
, 
[289] = {id = 289, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_xuehuachen", volume = 90}
, 
[290] = {id = 290, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_xueqiu_att", volume = 90}
, 
[291] = {id = 291, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_langhao", volume = 90}
, 
[292] = {id = 292, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_mofashutu", volume = 90}
, 
[293] = {id = 293, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_tucixuli", volume = 90}
, 
[294] = {id = 294, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_skate", volume = 100}
, 
[295] = {id = 295, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char003_attack", volume = 90}
, 
[296] = {id = 296, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char003_skill-1", volume = 90}
, 
[297] = {id = 297, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char003_skill-2", volume = 90}
, 
[298] = {id = 298, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char006_attack", volume = 90}
, 
[299] = {id = 299, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char006_skill-1", volume = 90}
, 
[300] = {id = 300, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char006_skill-2", volume = 90}
, 
[301] = {id = 301, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char021_attack", volume = 90}
, 
[302] = {id = 302, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char021_skill-1", volume = 90}
, 
[303] = {id = 303, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char021_skill-2", volume = 90}
, 
[304] = {id = 304, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char022_attack", volume = 90}
, 
[305] = {id = 305, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char022_skill-1", volume = 90}
, 
[306] = {id = 306, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char022_skill-2", volume = 90}
, 
[308] = {id = 308, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char024_skill-1", volume = 90}
, 
[309] = {id = 309, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char024_skill-2", volume = 90}
, 
[310] = {id = 310, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char024_skill-3", volume = 90}
, 
[311] = {id = 311, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char024_skill-4", volume = 90}
, 
[312] = {id = 312, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char025_attack", volume = 70}
, 
[313] = {id = 313, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char025_skill-1", volume = 90}
, 
[314] = {id = 314, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char025_skill-2", volume = 90}
, 
[315] = {id = 315, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char026_attack", volume = 90}
, 
[316] = {id = 316, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char026_skill-1", volume = 90}
, 
[317] = {id = 317, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char026_skill-2", volume = 90}
, 
[318] = {id = 318, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char027_attack", volume = 90}
, 
[319] = {id = 319, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char027_skill-1", volume = 90}
, 
[320] = {id = 320, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char027_skill-2", volume = 90}
, 
[321] = {id = 321, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char029_attack", volume = 90}
, 
[322] = {id = 322, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char029_skill-1", volume = 90}
, 
[323] = {id = 323, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char029_skill-2", volume = 90}
, 
[324] = {id = 324, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char030_attack", volume = 90}
, 
[325] = {id = 325, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char030_skill-1", volume = 90}
, 
[326] = {id = 326, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char030_skill-2", volume = 90}
, 
[327] = {id = 327, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char031_attack", volume = 70}
, 
[328] = {id = 328, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char031_skill-1", volume = 90}
, 
[329] = {id = 329, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char031_skill-2", volume = 90}
, 
[330] = {id = 330, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char031_skill-3", volume = 90}
, 
[331] = {id = 331, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char033_attack", volume = 90}
, 
[332] = {id = 332, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char033_skill-1", volume = 90}
, 
[333] = {id = 333, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char033_skill-2", volume = 90}
, 
[334] = {id = 334, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char033_skill-3", volume = 90}
, 
[335] = {id = 335, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char034_attack", volume = 90}
, 
[336] = {id = 336, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char034_skill-1", volume = 90}
, 
[337] = {id = 337, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char034_skill-2", volume = 90}
, 
[338] = {id = 338, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char041_attack", volume = 90}
, 
[339] = {id = 339, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char041_skill-1", volume = 90}
, 
[340] = {id = 340, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char041_skill-2", volume = 90}
, 
[341] = {id = 341, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char042_attack", volume = 90}
, 
[342] = {id = 342, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char042_skill-1", volume = 90}
, 
[343] = {id = 343, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char042_skill-2", volume = 90}
, 
[344] = {id = 344, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_006_attack", volume = 90}
, 
[345] = {id = 345, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_006_skill-1", volume = 90}
, 
[346] = {id = 346, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_006_skill-2", volume = 90}
, 
[347] = {id = 347, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_007_attack", volume = 90}
, 
[348] = {id = 348, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_007_skill-1", volume = 90}
, 
[349] = {id = 349, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_007_skill-2", volume = 90}
, 
[350] = {id = 350, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_023_attack", volume = 30}
, 
[351] = {id = 351, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_023_skill-1", volume = 90}
, 
[352] = {id = 352, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_023_skill-2", volume = 90}
, 
[353] = {id = 353, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_032_attack", volume = 90}
, 
[354] = {id = 354, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_032_skill-1", volume = 90}
, 
[355] = {id = 355, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_032_skill-2", volume = 90}
, 
[356] = {id = 356, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_035_attack", volume = 90}
, 
[357] = {id = 357, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_035_skill-1", volume = 90}
, 
[358] = {id = 358, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_035_skill-2", volume = 90}
, 
[359] = {id = 359, required = 1, cueSheet = "main:SE/skill", cueName = "SE_W2_Boss_01_attack", volume = 90}
, 
[360] = {id = 360, required = 1, cueSheet = "main:SE/skill", cueName = "SE_W2_Boss_01_bearclaw", volume = 90}
, 
[361] = {id = 361, required = 1, cueSheet = "main:SE/skill", cueName = "SE_W2_Boss_01_defeat", volume = 90}
, 
[362] = {id = 362, required = 1, cueSheet = "main:SE/skill", cueName = "SE_W2_Boss_01_icebreath", volume = 90}
, 
[363] = {id = 363, required = 1, cueSheet = "main:SE/skill", cueName = "SE_W2_Boss_01_roar", volume = 90}
, 
[364] = {id = 364, required = 1, cueSheet = "main:SE/skill", cueName = "SE_W2_Boss_02_Transform_1", volume = 90}
, 
[365] = {id = 365, required = 1, cueSheet = "main:SE/skill", cueName = "SE_W2_Boss_02_Transform_2", volume = 90}
, 
[397] = {id = 397, required = 1, cueSheet = "main:SE/skill", cueName = "Char_07_1", volume = 90}
, 
[398] = {id = 398, required = 1, cueSheet = "main:SE/skill", cueName = "Char_07_2", volume = 90}
, 
[399] = {id = 399, required = 1, cueSheet = "main:SE/skill", cueName = "Char_07_3", volume = 90}
, 
[400] = {id = 400, required = 1, cueSheet = "main:SE/skill", cueName = "Char_07_hit", volume = 90}
, 
[401] = {id = 401, required = 1, cueSheet = "main:SE/skill", cueName = "Char_08_2", volume = 90}
, 
[402] = {id = 402, required = 1, cueSheet = "main:SE/skill", cueName = "Char_08_3", volume = 90}
, 
[403] = {id = 403, required = 1, cueSheet = "main:SE/skill", cueName = "Char_08_hit", volume = 90}
, 
[404] = {id = 404, required = 1, cueSheet = "main:SE/skill", cueName = "Char_23_1", volume = 90}
, 
[405] = {id = 405, required = 1, cueSheet = "main:SE/skill", cueName = "Char_23_2", volume = 90}
, 
[406] = {id = 406, required = 1, cueSheet = "main:SE/skill", cueName = "Char_23_3", volume = 90}
, 
[407] = {id = 407, required = 1, cueSheet = "main:SE/skill", cueName = "Char_23_hit", volume = 90}
, 
[408] = {id = 408, required = 1, cueSheet = "main:SE/skill", cueName = "Char_32_1", volume = 90}
, 
[409] = {id = 409, required = 1, cueSheet = "main:SE/skill", cueName = "Char_32_2", volume = 90}
, 
[410] = {id = 410, required = 1, cueSheet = "main:SE/skill", cueName = "Char_32_3", volume = 90}
, 
[411] = {id = 411, required = 1, cueSheet = "main:SE/skill", cueName = "Char_32_hit", volume = 90}
, 
[412] = {id = 412, required = 1, cueSheet = "main:SE/skill", cueName = "Char_33_1", volume = 90}
, 
[413] = {id = 413, required = 1, cueSheet = "main:SE/skill", cueName = "Char_33_2", volume = 90}
, 
[414] = {id = 414, required = 1, cueSheet = "main:SE/skill", cueName = "Char_33_3", volume = 90}
, 
[415] = {id = 415, required = 1, cueSheet = "main:SE/skill", cueName = "Char_33_hit", volume = 90}
, 
[416] = {id = 416, required = 1, cueSheet = "main:SE/skill", cueName = "Char_34_1", volume = 90}
, 
[417] = {id = 417, required = 1, cueSheet = "main:SE/skill", cueName = "Char_34_2", volume = 90}
, 
[418] = {id = 418, required = 1, cueSheet = "main:SE/skill", cueName = "Char_34_3", volume = 90}
, 
[419] = {id = 419, required = 1, cueSheet = "main:SE/skill", cueName = "Char_34_hit", volume = 90}
, 
[420] = {id = 420, required = 1, cueSheet = "main:SE/skill", cueName = "Char_35_1", volume = 90}
, 
[421] = {id = 421, required = 1, cueSheet = "main:SE/skill", cueName = "Char_35_2", volume = 90}
, 
[422] = {id = 422, required = 1, cueSheet = "main:SE/skill", cueName = "Char_35_3", volume = 90}
, 
[423] = {id = 423, required = 1, cueSheet = "main:SE/skill", cueName = "Char_35_hit", volume = 90}
, 
[424] = {id = 424, required = 1, cueSheet = "main:SE/skill", cueName = "Char_41_1", volume = 90}
, 
[425] = {id = 425, required = 1, cueSheet = "main:SE/skill", cueName = "Char_41_2", volume = 90}
, 
[426] = {id = 426, required = 1, cueSheet = "main:SE/skill", cueName = "Char_41_3", volume = 90}
, 
[427] = {id = 427, required = 1, cueSheet = "main:SE/skill", cueName = "Char_41_hit", volume = 90}
, 
[428] = {id = 428, required = 1, cueSheet = "main:SE/skill", cueName = "Char_42_1", volume = 90}
, 
[429] = {id = 429, required = 1, cueSheet = "main:SE/skill", cueName = "Char_42_2", volume = 90}
, 
[430] = {id = 430, required = 1, cueSheet = "main:SE/skill", cueName = "Char_42_3", volume = 90}
, 
[431] = {id = 431, required = 1, cueSheet = "main:SE/skill", cueName = "Char_42_hit", volume = 90}
, 
[438] = {id = 438, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_mirrorOnTower20", volume = 100}
, 
[439] = {id = 439, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_IceThornSwitchOn", volume = 100}
, 
[440] = {id = 440, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_IceThornSwitchOff", volume = 100}
, 
[441] = {id = 441, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_AbsorbIceGoddessPower", volume = 100}
, 
[442] = {id = 442, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_CaveRainAmbience", volume = 100}
, 
[443] = {id = 443, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_IceGoddessFreeze", volume = 100}
, 
[444] = {id = 444, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_baofengxueII", volume = 90}
, 
[445] = {id = 445, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_baofengxueI", volume = 90}
, 
[446] = {id = 446, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_bingjian", volume = 90}
, 
[447] = {id = 447, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_bingjiejingpaoxiao", volume = 90}
, 
[448] = {id = 448, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_bingjiejingxiao", volume = 90}
, 
[449] = {id = 449, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_bingjiejing", volume = 90}
, 
[450] = {id = 450, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_bingrui_fashe", volume = 90}
, 
[451] = {id = 451, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_jiaxue_xuli", volume = 90}
, 
[452] = {id = 452, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_battle_Icegoddess1", volume = 80}
, 
[453] = {id = 453, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_battle_Icegoddess2", volume = 80}
, 
[454] = {id = 454, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_battle_Anemone", volume = 80}
, 
[455] = {id = 455, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_cangqiongzhifeng", volume = 90}
, 
[456] = {id = 456, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_dongjieshu_shifa", volume = 90}
, 
[457] = {id = 457, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_dongjieshu", volume = 90}
, 
[458] = {id = 458, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_jishuguang_fashe", volume = 90}
, 
[459] = {id = 459, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_jishuguang_xuli", volume = 90}
, 
[460] = {id = 460, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_dihuo", volume = 90}
, 
[461] = {id = 461, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_fengxianlinghun", volume = 90}
, 
[462] = {id = 462, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_fengxuejianwu", volume = 90}
, 
[463] = {id = 463, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_linghunzhan", volume = 90}
, 
[464] = {id = 464, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_shenpanzhihuo", volume = 90}
, 
[465] = {id = 465, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_yinran_att", volume = 90}
, 
[466] = {id = 466, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_zhuoshao", volume = 90}
, 
[467] = {id = 467, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char024_attackv2", volume = 90}
, 
[468] = {id = 468, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char024_skill-1v2", volume = 90}
, 
[469] = {id = 469, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char024_skill-2v2", volume = 90}
, 
[470] = {id = 470, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char024_skill-3v2", volume = 90}
, 
[471] = {id = 471, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char024_skill-4v2", volume = 90}
, 
[472] = {id = 472, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char025_attackv2", volume = 90}
, 
[473] = {id = 473, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char025_skill-1v2", volume = 90}
, 
[474] = {id = 474, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char025_skill-2v2", volume = 90}
, 
[475] = {id = 475, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char027_attackv2", volume = 90}
, 
[476] = {id = 476, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char027_skill-1v2", volume = 90}
, 
[477] = {id = 477, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char027_skill-2v2", volume = 90}
, 
[478] = {id = 478, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char029_attackv2", volume = 90}
, 
[479] = {id = 479, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char029_skill-1v2", volume = 90}
, 
[480] = {id = 480, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char029_skill-2v2", volume = 90}
, 
[481] = {id = 481, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char030_attackv2", volume = 90}
, 
[482] = {id = 482, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char030_skill-1v2", volume = 90}
, 
[483] = {id = 483, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char030_skill-2v2", volume = 90}
, 
[484] = {id = 484, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char031_attackv2", volume = 90}
, 
[485] = {id = 485, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char031_skill-1v2", volume = 90}
, 
[486] = {id = 486, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char031_skill-2v2", volume = 90}
, 
[487] = {id = 487, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char031_skill-3v2", volume = 90}
, 
[488] = {id = 488, required = 1, cueSheet = "main:SE/skill", cueName = "Char003_01", volume = 90}
, 
[489] = {id = 489, required = 1, cueSheet = "main:SE/skill", cueName = "Char003_02", volume = 90}
, 
[490] = {id = 490, required = 1, cueSheet = "main:SE/skill", cueName = "Char003_03", volume = 90}
, 
[491] = {id = 491, required = 1, cueSheet = "main:SE/skill", cueName = "Char003_hit", volume = 90}
, 
[492] = {id = 492, required = 1, cueSheet = "main:SE/skill", cueName = "Char006_1", volume = 90}
, 
[493] = {id = 493, required = 1, cueSheet = "main:SE/skill", cueName = "Char006_2", volume = 90}
, 
[494] = {id = 494, required = 1, cueSheet = "main:SE/skill", cueName = "Char006_3", volume = 90}
, 
[495] = {id = 495, required = 1, cueSheet = "main:SE/skill", cueName = "Char021_01", volume = 90}
, 
[496] = {id = 496, required = 1, cueSheet = "main:SE/skill", cueName = "Char021_02", volume = 90}
, 
[497] = {id = 497, required = 1, cueSheet = "main:SE/skill", cueName = "Char021_03", volume = 90}
, 
[498] = {id = 498, required = 1, cueSheet = "main:SE/skill", cueName = "Char021_hit", volume = 90}
, 
[499] = {id = 499, required = 1, cueSheet = "main:SE/skill", cueName = "Char022_1", volume = 90}
, 
[500] = {id = 500, required = 1, cueSheet = "main:SE/skill", cueName = "Char022_2", volume = 90}
, 
[501] = {id = 501, required = 1, cueSheet = "main:SE/skill", cueName = "Char022_3", volume = 90}
, 
[502] = {id = 502, required = 1, cueSheet = "main:SE/skill", cueName = "Char022_4", volume = 90}
, 
[503] = {id = 503, required = 1, cueSheet = "main:SE/skill", cueName = "Char022_hit", volume = 90}
, 
[504] = {id = 504, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_gelieshunyi", volume = 90}
, 
[505] = {id = 505, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_lianjie", volume = 90}
, 
[506] = {id = 506, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_zhuhongdun", volume = 90}
, 
[507] = {id = 507, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_zhuhongzhan_att", volume = 90}
, 
[508] = {id = 508, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_suming_buff", volume = 90}
, 
[509] = {id = 509, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_sumingfuhuo", volume = 90}
, 
[510] = {id = 510, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_xuliyiji", volume = 90}
, 
[511] = {id = 511, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_fanrong", volume = 90}
, 
[512] = {id = 512, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_zhenjie", volume = 90}
, 
[513] = {id = 513, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_gongjian035", volume = 90}
, 
[514] = {id = 514, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_chongji_att", volume = 90}
, 
[515] = {id = 515, required = 1, cueSheet = "main:SE/ui", cueName = "SOUND_ui_evolution", volume = 100}
, 
[516] = {id = 516, required = 1, cueSheet = "main:SE/ui", cueName = "SOUND_ui_tupo", volume = 100}
, 
[517] = {id = 517, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_chongneng", volume = 90}
, 
[518] = {id = 518, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char006_Attack_0", volume = 70}
, 
[519] = {id = 519, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char006_Skill_1", volume = 90}
, 
[520] = {id = 520, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char006_Skill_2", volume = 90}
, 
[521] = {id = 521, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char014_Skill_2", volume = 90}
, 
[522] = {id = 522, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char024_attack", volume = 70}
, 
[523] = {id = 523, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char024_Dragon_Attack", volume = 70}
, 
[524] = {id = 524, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char024_Dragon_Skill_1", volume = 90}
, 
[525] = {id = 525, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char024_Skill_1", volume = 90}
, 
[526] = {id = 526, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char024_Skill_2C", volume = 90}
, 
[527] = {id = 527, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char025_Attack_v3", volume = 70}
, 
[528] = {id = 528, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char025_Skill_1_v3", volume = 90}
, 
[529] = {id = 529, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char025_Skill_2_v3", volume = 90}
, 
[530] = {id = 530, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char027_Attack_v3", volume = 70}
, 
[531] = {id = 531, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char027_Skill_1_v3", volume = 90}
, 
[532] = {id = 532, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char027_Skill_2_v3", volume = 90}
, 
[533] = {id = 533, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char030_Attack_v3", volume = 70}
, 
[534] = {id = 534, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char030_Skill_2_v3", volume = 90}
, 
[535] = {id = 535, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char031_Attack_v3", volume = 70}
, 
[536] = {id = 536, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char031_Skill_1_v3", volume = 90}
, 
[537] = {id = 537, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char031_Skill_2_v3", volume = 90}
, 
[538] = {id = 538, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char031_Skill_3_v3", volume = 90}
, 
[539] = {id = 539, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char031_Skill_4_v3", volume = 90}
, 
[540] = {id = 540, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char033_Attack_v3", volume = 70}
, 
[541] = {id = 541, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char033_Skill_1_v3", volume = 90}
, 
[542] = {id = 542, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char033_Skill_2_v3", volume = 90}
, 
[543] = {id = 543, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char36_Skill_1", volume = 90}
, 
[544] = {id = 544, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char37_Skill_1", volume = 90}
, 
[545] = {id = 545, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char37_Skill_2", volume = 90}
, 
[546] = {id = 546, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char37_Skill_3", volume = 90}
, 
[547] = {id = 547, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char49_Attack", volume = 70}
, 
[548] = {id = 548, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char49_Skill_1", volume = 90}
, 
[549] = {id = 549, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char49_Skill_2", volume = 90}
, 
[550] = {id = 550, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char52_Attack", volume = 70}
, 
[551] = {id = 551, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char52_Skill_1", volume = 90}
, 
[552] = {id = 552, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char52_Skill_2", volume = 90}
, 
[553] = {id = 553, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char53_Attack", volume = 70}
, 
[554] = {id = 554, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char53_Skill_1", volume = 90}
, 
[555] = {id = 555, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char53_Skill_2", volume = 90}
, 
[556] = {id = 556, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char54_Attack", volume = 70}
, 
[557] = {id = 557, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char54_Skill_1", volume = 90}
, 
[558] = {id = 558, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char54_Skill_2", volume = 90}
, 
[559] = {id = 559, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char55_Attack", volume = 70}
, 
[560] = {id = 560, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char55_Skill_1", volume = 90}
, 
[561] = {id = 561, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char55_Skill_2", volume = 90}
, 
[562] = {id = 562, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char56_Attack", volume = 70}
, 
[563] = {id = 563, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char56_Skill_1", volume = 90}
, 
[564] = {id = 564, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char58_Skill_1", volume = 90}
, 
[565] = {id = 565, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char58_Skill_2", volume = 90}
, 
[566] = {id = 566, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char60_Skill_2", volume = 100}
, 
[567] = {id = 567, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char60_Skill_3", volume = 100}
, 
[568] = {id = 568, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_008_Skill_2_v3", volume = 90}
, 
[569] = {id = 569, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_023_Skill_2_v3", volume = 90}
, 
[570] = {id = 570, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_035_Skill_2_v3", volume = 90}
, 
[571] = {id = 571, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_IceworldPast", volume = 80}
, 
[572] = {id = 572, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_IceworldLava1", volume = 80}
, 
[573] = {id = 573, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_IceworldLava2", volume = 80}
, 
[574] = {id = 574, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_Scene_IceworldPast1", volume = 100}
, 
[575] = {id = 575, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_Scene_IceworldPast2", volume = 100}
, 
[576] = {id = 576, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_Scene_IceworldLava", volume = 100}
, 
[577] = {id = 577, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_magiccircle", volume = 100}
, 
[578] = {id = 578, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_visionbroken", volume = 100}
, 
[579] = {id = 579, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_coldair", volume = 100}
, 
[580] = {id = 580, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_bearroar", volume = 100}
, 
[581] = {id = 581, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_earthshakewithicecone", volume = 100}
, 
[582] = {id = 582, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_wolfflashout", volume = 100}
, 
[583] = {id = 583, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_foxflee", volume = 100}
, 
[584] = {id = 584, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_activation", volume = 100}
, 
[585] = {id = 585, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_LightUpStele", volume = 100}
, 
[586] = {id = 586, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_walldisappear", volume = 100}
, 
[587] = {id = 587, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_GemGateOpen", volume = 100}
, 
[588] = {id = 588, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char040_HM_skill_1", volume = 90}
, 
[589] = {id = 589, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char040_HM_skill_2", volume = 90}
, 
[590] = {id = 590, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char040_HM_skill_3", volume = 90}
, 
[591] = {id = 591, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char031_Attack_Att", volume = 70}
, 
[592] = {id = 592, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char033_Skill_2B_v3", volume = 90}
, 
[593] = {id = 593, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_01_Explode", volume = 90}
, 
[594] = {id = 594, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_01_ForShow", volume = 90}
, 
[595] = {id = 595, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char28_Demon_Transform", volume = 90}
, 
[596] = {id = 596, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char47_Attack", volume = 70}
, 
[597] = {id = 597, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char56-Skill_2_v3", volume = 90}
, 
[598] = {id = 598, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_t1_27s_Skill-1", volume = 90}
, 
[599] = {id = 599, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w1_47s_Skill-1", volume = 90}
, 
[600] = {id = 600, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w4_02_Attack", volume = 90}
, 
[601] = {id = 601, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w4_03_Skill-2", volume = 90}
, 
[602] = {id = 602, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w4_04_Attack", volume = 90}
, 
[603] = {id = 603, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w4_04_Skill-1", volume = 90}
, 
[604] = {id = 604, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w4_04_Skill-2", volume = 90}
, 
[605] = {id = 605, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_01_Attack-1", volume = 90}
, 
[606] = {id = 606, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_01_Attack-2", volume = 90}
, 
[607] = {id = 607, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w4_02_Skill-1_Att", volume = 90}
, 
[608] = {id = 608, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w4_03_Skill-1", volume = 90}
, 
[609] = {id = 609, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w4_03_Skill-1_Att", volume = 90}
, 
[610] = {id = 610, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_01_Skill-2", volume = 90}
, 
[611] = {id = 611, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_01_Skill-2b", volume = 90}
, 
[612] = {id = 612, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_01_Skill-3", volume = 90}
, 
[613] = {id = 613, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_01_Skill-4", volume = 90}
, 
[614] = {id = 614, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_01_Skill-4b", volume = 90}
, 
[615] = {id = 615, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char17_Attack-1", volume = 90}
, 
[616] = {id = 616, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char17_Attack-1_Att", volume = 90}
, 
[617] = {id = 617, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char17_Attack-2", volume = 90}
, 
[618] = {id = 618, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char17_Attack-2_Att", volume = 90}
, 
[619] = {id = 619, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char28_Attack", volume = 70}
, 
[620] = {id = 620, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char28_Attack_Att", volume = 70}
, 
[621] = {id = 621, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char28_Skill-2_Transform", volume = 90}
, 
[622] = {id = 622, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char36_Skill-2_v2", volume = 90}
, 
[623] = {id = 623, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char36_Skill-2b_v2", volume = 90}
, 
[624] = {id = 624, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char37_Skill_1b", volume = 90}
, 
[625] = {id = 625, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w1_29_Skill-1", volume = 90}
, 
[626] = {id = 626, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w2_16_Attack", volume = 90}
, 
[627] = {id = 627, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w2_16_Attack_Att", volume = 90}
, 
[628] = {id = 628, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w2_18_Attack", volume = 90}
, 
[629] = {id = 629, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w2_18_Attack_Att", volume = 90}
, 
[630] = {id = 630, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w4_02_Skill-1", volume = 90}
, 
[631] = {id = 631, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Boss_w4_01_Firsttime", volume = 80}
, 
[632] = {id = 632, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_035_Skill-1v3_release", volume = 90}
, 
[633] = {id = 633, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_035_Skill-1v3_ice", volume = 90}
, 
[634] = {id = 634, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_035_Skill-1v3_hit", volume = 90}
, 
[635] = {id = 635, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_035_Attackv3_release", volume = 70}
, 
[636] = {id = 636, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_035_Attackv3_hit", volume = 70}
, 
[637] = {id = 637, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_032_Skill-2v3_release", volume = 90}
, 
[638] = {id = 638, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_032_Skill-2v3_hit", volume = 90}
, 
[639] = {id = 639, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_032_Skill-2v3_flag", volume = 90}
, 
[640] = {id = 640, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_032_Skill-1v3_release", volume = 90}
, 
[641] = {id = 641, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_032_Skill-1v3_hit", volume = 90}
, 
[642] = {id = 642, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_032_Attackv3_release", volume = 70}
, 
[643] = {id = 643, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_032_Attackv3_hit", volume = 70}
, 
[644] = {id = 644, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_023_Skill-1v3_release", volume = 90}
, 
[645] = {id = 645, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_023_Skill-1v3_hit", volume = 90}
, 
[646] = {id = 646, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_023_Attackv3_release", volume = 70}
, 
[647] = {id = 647, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_023_Attackv3_hit", volume = 70}
, 
[648] = {id = 648, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char60-Skill-1_Release", volume = 90}
, 
[649] = {id = 649, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char60-Skill-1_Hit", volume = 90}
, 
[650] = {id = 650, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char60-Attack_Release", volume = 40}
, 
[651] = {id = 651, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char60-Attack_Hit", volume = 70}
, 
[652] = {id = 652, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char58-Skill-1_Release", volume = 90}
, 
[653] = {id = 653, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char58-Skill-1_Hit", volume = 90}
, 
[654] = {id = 654, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char58-Attack_Release", volume = 70}
, 
[655] = {id = 655, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char58-Attack_Hit", volume = 70}
, 
[656] = {id = 656, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char51-Skill-2_Release", volume = 90}
, 
[657] = {id = 657, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char51-Skill-2_Hit", volume = 90}
, 
[658] = {id = 658, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char51-Skill-1_Release", volume = 90}
, 
[659] = {id = 659, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char51-Skill-1_Hit", volume = 90}
, 
[660] = {id = 660, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char51-Attack_Release", volume = 70}
, 
[661] = {id = 661, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char51-Attack_Hit", volume = 70}
, 
[662] = {id = 662, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char44-Skill-2_Release", volume = 90}
, 
[663] = {id = 663, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char44-Skill-2_Hit", volume = 90}
, 
[664] = {id = 664, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char44-Skill-1_Release", volume = 90}
, 
[665] = {id = 665, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char44-Skill-1_Hit", volume = 90}
, 
[666] = {id = 666, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char44-Attack_Release", volume = 70}
, 
[667] = {id = 667, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char44-Attack_Hit", volume = 70}
, 
[668] = {id = 668, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char43-Skill-2_Release", volume = 90}
, 
[669] = {id = 669, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char43-Skill-2_Hit", volume = 90}
, 
[670] = {id = 670, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char43-Skill-1_Release", volume = 90}
, 
[671] = {id = 671, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char43-Skill-1_Hit", volume = 90}
, 
[672] = {id = 672, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char43-Attack_Release", volume = 70}
, 
[673] = {id = 673, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char43-Attack_Hit", volume = 70}
, 
[674] = {id = 674, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char041_Skill-2v3_swamp", volume = 90}
, 
[675] = {id = 675, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char041_Skill-2v3_hit", volume = 90}
, 
[676] = {id = 676, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char041_Skill-2v3_dmg", volume = 90}
, 
[677] = {id = 677, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char40-Skill-1_Release", volume = 90}
, 
[678] = {id = 678, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char40-Skill-1_Hit", volume = 90}
, 
[679] = {id = 679, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char40-Skill-1_Dmg", volume = 90}
, 
[680] = {id = 680, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char40-Attack_release", volume = 70}
, 
[681] = {id = 681, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char40-Attack_hit", volume = 70}
, 
[682] = {id = 682, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char37-Attack_release", volume = 70}
, 
[683] = {id = 683, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char37-Attack_hit", volume = 70}
, 
[684] = {id = 684, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char37-Attack_Card", volume = 70}
, 
[685] = {id = 685, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char36-Attack_release", volume = 70}
, 
[686] = {id = 686, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char36-Attack_hit", volume = 70}
, 
[687] = {id = 687, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char030_Skill-1v3_release", volume = 90}
, 
[688] = {id = 688, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char030_Skill-1v3_hit", volume = 90}
, 
[689] = {id = 689, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char021_Attackv3_release", volume = 70}
, 
[690] = {id = 690, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char021_Attackv3_hit", volume = 70}
, 
[691] = {id = 691, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w4_04_Skill-1_Att", volume = 90}
, 
[692] = {id = 692, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_01_ForShow_P3", volume = 90}
, 
[693] = {id = 693, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_01_ForShow_P2", volume = 90}
, 
[694] = {id = 694, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_01_ForShow_P1", volume = 90}
, 
[695] = {id = 695, required = 1, cueSheet = "main:SE/skill", cueName = "SE_MonT212-Attack_Release", volume = 90}
, 
[696] = {id = 696, required = 1, cueSheet = "main:SE/skill", cueName = "SE_MonT212-Attack_Hit", volume = 90}
, 
[697] = {id = 697, required = 1, cueSheet = "main:SE/skill", cueName = "SE_MonT211-Skill-2_Release", volume = 90}
, 
[698] = {id = 698, required = 1, cueSheet = "main:SE/skill", cueName = "SE_MonT211-Skill-2_Hit", volume = 90}
, 
[699] = {id = 699, required = 1, cueSheet = "main:SE/skill", cueName = "SE_MonT211-Skill-1_Release", volume = 90}
, 
[700] = {id = 700, required = 1, cueSheet = "main:SE/skill", cueName = "SE_MonT211-Skill-1_Hit", volume = 90}
, 
[701] = {id = 701, required = 1, cueSheet = "main:SE/skill", cueName = "SE_MonT210-Skill-2_Release", volume = 90}
, 
[702] = {id = 702, required = 1, cueSheet = "main:SE/skill", cueName = "SE_MonT210-Skill-2_Hit", volume = 90}
, 
[703] = {id = 703, required = 1, cueSheet = "main:SE/skill", cueName = "SE_MonT210-Skill-1_Release", volume = 90}
, 
[704] = {id = 704, required = 1, cueSheet = "main:SE/skill", cueName = "SE_MonT210-Skill-1_Hit", volume = 90}
, 
[705] = {id = 705, required = 1, cueSheet = "main:SE/skill", cueName = "SE_MonT2_13-Skill-2_Release", volume = 90}
, 
[706] = {id = 706, required = 1, cueSheet = "main:SE/skill", cueName = "SE_MonT2_13-Skill-2_Hit", volume = 90}
, 
[707] = {id = 707, required = 1, cueSheet = "main:SE/skill", cueName = "SE_MonT2_13-Skill-1_Release", volume = 90}
, 
[708] = {id = 708, required = 1, cueSheet = "main:SE/skill", cueName = "SE_MonT2_13-Skill-1_Hit", volume = 90}
, 
[709] = {id = 709, required = 1, cueSheet = "main:SE/skill", cueName = "SE_MonT2_13-Attack_Release", volume = 90}
, 
[710] = {id = 710, required = 1, cueSheet = "main:SE/skill", cueName = "SE_MonT2_13-Attack_Hit", volume = 90}
, 
[711] = {id = 711, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char69_Skill-2_Release", volume = 90}
, 
[712] = {id = 712, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char69_Skill-2_Hit", volume = 90}
, 
[713] = {id = 713, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char69_Skill-1_Release", volume = 90}
, 
[714] = {id = 714, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char69_Skill-1_Hit", volume = 90}
, 
[715] = {id = 715, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char69_Attack_Release", volume = 70}
, 
[716] = {id = 716, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char69_Attack_Hit", volume = 70}
, 
[717] = {id = 717, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char62_Skill-2p2_Release", volume = 90}
, 
[718] = {id = 718, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char62_Skill-2p2_Hit", volume = 90}
, 
[719] = {id = 719, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char62_Skill-2p1_Release", volume = 90}
, 
[720] = {id = 720, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char62_Skill-2p1_Hit", volume = 90}
, 
[721] = {id = 721, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char62_Skill-1_Release", volume = 90}
, 
[722] = {id = 722, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char62_Skill-1_Hit", volume = 90}
, 
[723] = {id = 723, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char62_Attack_Release", volume = 70}
, 
[724] = {id = 724, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char62_Attack_Hit", volume = 90}
, 
[725] = {id = 725, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char47_Skill-2_Release", volume = 90}
, 
[726] = {id = 726, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char47_Skill-2_Hit", volume = 90}
, 
[727] = {id = 727, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char47_Skill-1_Release", volume = 90}
, 
[728] = {id = 728, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char47_Skill-1_Hit", volume = 90}
, 
[729] = {id = 729, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char30M_Skill-1", volume = 90}
, 
[730] = {id = 730, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char28_Skill-1_Release", volume = 90}
, 
[731] = {id = 731, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char28_Skill-1_Hit", volume = 90}
, 
[732] = {id = 732, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char28_Demon_Attack-2_Release", volume = 90}
, 
[733] = {id = 733, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char28_Demon_Attack-2_Hit", volume = 90}
, 
[734] = {id = 734, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char28_Demon_Attack-1_Release", volume = 90}
, 
[735] = {id = 735, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char28_Demon_Attack-1_Hit", volume = 90}
, 
[736] = {id = 736, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_02_Skill-1_Release", volume = 90}
, 
[737] = {id = 737, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_02_Skill-1_Hit", volume = 90}
, 
[738] = {id = 738, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_01_Skill-1_Release", volume = 90}
, 
[739] = {id = 739, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_01_Skill-1_Hit", volume = 90}
, 
[740] = {id = 740, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w4_04II-Release", volume = 90}
, 
[741] = {id = 741, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w4_04II-Hit", volume = 90}
, 
[742] = {id = 742, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w1_29_Skill-2_Release", volume = 90}
, 
[743] = {id = 743, required = 1, cueSheet = "main:SE/skill", cueName = "Mon_w1_29_Skill-2_Hit", volume = 90}
, 
[744] = {id = 744, required = 1, cueSheet = "main:SE/skill", cueName = "Mon17_Skill-5_Release", volume = 90}
, 
[745] = {id = 745, required = 1, cueSheet = "main:SE/skill", cueName = "Mon17_Skill-5_Hit", volume = 90}
, 
[746] = {id = 746, required = 1, cueSheet = "main:SE/skill", cueName = "Mon17_Skill-4_Release", volume = 90}
, 
[747] = {id = 747, required = 1, cueSheet = "main:SE/skill", cueName = "Mon17_Skill-4_Hit", volume = 90}
, 
[748] = {id = 748, required = 1, cueSheet = "main:SE/skill", cueName = "Mon17_Skill-3_Release", volume = 90}
, 
[749] = {id = 749, required = 1, cueSheet = "main:SE/skill", cueName = "Mon17_Skill-3_Hit", volume = 90}
, 
[750] = {id = 750, required = 1, cueSheet = "main:SE/skill", cueName = "Mon17_Skill-2_Release", volume = 90}
, 
[751] = {id = 751, required = 1, cueSheet = "main:SE/skill", cueName = "Mon17_Skill-2_Hit", volume = 90}
, 
[752] = {id = 752, required = 1, cueSheet = "main:SE/skill", cueName = "Mon17_Skill-1_Release", volume = 90}
, 
[753] = {id = 753, required = 1, cueSheet = "main:SE/skill", cueName = "Mon17_Skill-1_Hit", volume = 90}
, 
[754] = {id = 754, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Boss_w4_01_Final", volume = 80}
, 
[755] = {id = 755, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Boss_w4_02_Final", volume = 80}
, 
[756] = {id = 756, required = 1, cueSheet = "main:BGM/iceworld", cueName = "BGM_Story_After_First_Boss_Battle", volume = 100}
, 
[757] = {id = 757, required = 1, cueSheet = "main:BGM/iceworld", cueName = "BGM_Story_Final_Battle_Win", volume = 100}
, 
[758] = {id = 758, required = 1, cueSheet = "main:BGM/iceworld", cueName = "BGM_Story_Lava_Boss_Approach_Intro", volume = 100}
, 
[759] = {id = 759, required = 1, cueSheet = "main:SE/skill", cueName = "SE_CharPlayer1_Skill5_Release", volume = 90}
, 
[760] = {id = 760, required = 1, cueSheet = "main:SE/skill", cueName = "SE_CharPlayer1_Skill5_Hit", volume = 90}
, 
[761] = {id = 761, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char50-Skill-2_Release", volume = 90}
, 
[762] = {id = 762, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char50-Skill-2_Hit", volume = 90}
, 
[763] = {id = 763, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char50-Skill-1_Release", volume = 90}
, 
[764] = {id = 764, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char50-Skill-1_Hit", volume = 90}
, 
[765] = {id = 765, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char50-Attack_Release", volume = 70}
, 
[766] = {id = 766, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char50-Attack_Hit", volume = 90}
, 
[767] = {id = 767, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_02-Skill-3_Release", volume = 90}
, 
[768] = {id = 768, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_02-Skill-3_Hit", volume = 90}
, 
[769] = {id = 769, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_02-Skill-2_Release", volume = 90}
, 
[770] = {id = 770, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_02-Skill-2_Hit", volume = 90}
, 
[771] = {id = 771, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_02-Attack-3_Release", volume = 90}
, 
[772] = {id = 772, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_02-Attack-3_Hit", volume = 70}
, 
[773] = {id = 773, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_02-Attack-2_Release", volume = 90}
, 
[774] = {id = 774, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_02-Attack-2_Hit", volume = 90}
, 
[775] = {id = 775, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_02-Attack-1_Release", volume = 90}
, 
[776] = {id = 776, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_02-Attack-1_Hit", volume = 90}
, 
[777] = {id = 777, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_chestonpata", volume = 100}
, 
[778] = {id = 778, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Boss_w04_02-Skill-2_Charge", volume = 90}
, 
[779] = {id = 779, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char50-Skill-2_v2_Blink", volume = 90}
, 
[780] = {id = 780, required = 1, cueSheet = "main:SE/ui", cueName = "SOUND_ui_gongming", volume = 100}
, 
[781] = {id = 781, required = 1, cueSheet = "main:SE/ui", cueName = "SOUND_ui_gongming_jingyin", volume = 100}
, 
[782] = {id = 782, required = 1, cueSheet = "main:BGM/universal", cueName = "BGM_Story_LakeandHarp", volume = 100}
, 
[783] = {id = 783, required = 1, cueSheet = "main:BGM/universal", cueName = "BGM_Story_LakeandPiano", volume = 100}
, 
[784] = {id = 784, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_Scene_Iceworld2", volume = 100}
, 
[785] = {id = 785, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_Scene_Iceworld3", volume = 100}
, 
[794] = {id = 794, required = 1, cueSheet = "main:BGM/iceworld", cueName = "BGM_Story_After_First_Boss_Battle_0", volume = 100}
, 
[795] = {id = 795, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_shitourenShake", volume = 100}
, 
[796] = {id = 796, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_shitourenPaidi", volume = 100}
, 
[797] = {id = 797, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_shitourenPaidi2", volume = 100}
, 
[798] = {id = 798, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_transport", volume = 100}
, 
[799] = {id = 799, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_launcher", volume = 100}
, 
[800] = {id = 800, required = 1, cueSheet = "main:SE/TimelineVolDown", cueName = "BlankAudio", volume = 100}
, 
[801] = {id = 801, required = 1, cueSheet = "main:SE/environment", cueName = "SE_Gacha2_Intro", volume = 100}
, 
[802] = {id = 802, required = 1, cueSheet = "main:SE/environment", cueName = "SE_Gacha2_Reveal", volume = 100}
, 
[803] = {id = 803, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_manaT1", volume = 100}
, 
[804] = {id = 804, required = 1, cueSheet = "main:SE/skill", cueName = "Char057_changqiangtuci", volume = 90}
, 
[805] = {id = 805, required = 1, cueSheet = "main:SE/skill", cueName = "Char057_changqiangtuci_Att", volume = 90}
, 
[806] = {id = 806, required = 1, cueSheet = "main:SE/skill", cueName = "Char057_gedangfanji", volume = 90}
, 
[807] = {id = 807, required = 1, cueSheet = "main:SE/skill", cueName = "Char057_jianshou", volume = 90}
, 
[808] = {id = 808, required = 1, cueSheet = "main:SE/skill", cueName = "Char061_huanshouzhiwu", volume = 90}
, 
[809] = {id = 809, required = 1, cueSheet = "main:SE/skill", cueName = "Char061_pomozhiqiang", volume = 90}
, 
[810] = {id = 810, required = 1, cueSheet = "main:SE/skill", cueName = "Char061_pomozhiqiang_Att", volume = 90}
, 
[811] = {id = 811, required = 1, cueSheet = "main:SE/skill", cueName = "Char061_pomozhiqiangS", volume = 90}
, 
[812] = {id = 812, required = 1, cueSheet = "main:SE/skill", cueName = "Char063_changqiangciji", volume = 70}
, 
[813] = {id = 813, required = 1, cueSheet = "main:SE/skill", cueName = "Char063_changqiangciji_Att", volume = 70}
, 
[814] = {id = 814, required = 1, cueSheet = "main:SE/skill", cueName = "Char063_duanmo", volume = 90}
, 
[815] = {id = 815, required = 1, cueSheet = "main:SE/skill", cueName = "Char063_tongling", volume = 90}
, 
[816] = {id = 816, required = 1, cueSheet = "main:SE/skill", cueName = "Char065_cishahong", volume = 90}
, 
[817] = {id = 817, required = 1, cueSheet = "main:SE/skill", cueName = "Char065_cishahong_Att", volume = 90}
, 
[818] = {id = 818, required = 1, cueSheet = "main:SE/skill", cueName = "Char065_cishalan", volume = 90}
, 
[819] = {id = 819, required = 1, cueSheet = "main:SE/skill", cueName = "Char065_cishalan_Att", volume = 90}
, 
[820] = {id = 820, required = 1, cueSheet = "main:SE/skill", cueName = "Char065_jiaosha", volume = 100}
, 
[821] = {id = 821, required = 1, cueSheet = "main:SE/skill", cueName = "Char065_jiaosha_Att", volume = 70}
, 
[822] = {id = 822, required = 1, cueSheet = "main:SE/skill", cueName = "Char065_quanji", volume = 90}
, 
[823] = {id = 823, required = 1, cueSheet = "main:SE/skill", cueName = "Char065_quanji_Att", volume = 90}
, 
[824] = {id = 824, required = 1, cueSheet = "main:SE/skill", cueName = "Char072_jiaxue", volume = 90}
, 
[825] = {id = 825, required = 1, cueSheet = "main:SE/skill", cueName = "Char072_qidao ", volume = 90}
, 
[826] = {id = 826, required = 1, cueSheet = "main:SE/skill", cueName = "Char072_shenshengzhiliao", volume = 90}
, 
[827] = {id = 827, required = 1, cueSheet = "main:SE/skill", cueName = "Char072_shenshengzhiliao_hudun", volume = 90}
, 
[828] = {id = 828, required = 1, cueSheet = "main:SE/skill", cueName = "Char075_changqiangciji", volume = 90}
, 
[829] = {id = 829, required = 1, cueSheet = "main:SE/skill", cueName = "Char075_changqiangciji_Att", volume = 90}
, 
[830] = {id = 830, required = 1, cueSheet = "main:SE/skill", cueName = "Char075_changqianghuikan", volume = 90}
, 
[831] = {id = 831, required = 1, cueSheet = "main:SE/skill", cueName = "Char075_fuwenguanzhu_loop", volume = 90}
, 
[832] = {id = 832, required = 1, cueSheet = "main:SE/skill", cueName = "Char075_fuwenguanzhu_start", volume = 90}
, 
[833] = {id = 833, required = 1, cueSheet = "main:SE/skill", cueName = "Char075_luanwu", volume = 90}
, 
[834] = {id = 834, required = 1, cueSheet = "main:SE/skill", cueName = "Char075_luanwu_Att", volume = 90}
, 
[835] = {id = 835, required = 1, cueSheet = "main:SE/skill", cueName = "Char075_wuqiang", volume = 90}
, 
[836] = {id = 836, required = 1, cueSheet = "main:SE/skill", cueName = "Char075_wuqiang_Att", volume = 90}
, 
[837] = {id = 837, required = 1, cueSheet = "main:SE/skill", cueName = "Char076_huayu", volume = 90}
, 
[838] = {id = 838, required = 1, cueSheet = "main:SE/skill", cueName = "Char076_jiaxue", volume = 90}
, 
[839] = {id = 839, required = 1, cueSheet = "main:SE/skill", cueName = "Char076_jingjihujia", volume = 90}
, 
[840] = {id = 840, required = 1, cueSheet = "main:SE/skill", cueName = "SE_CharPlayer-Skill-5A", volume = 90}
, 
[841] = {id = 841, required = 1, cueSheet = "main:SE/skill", cueName = "SE_CharPlayer-Skill-5B", volume = 90}
, 
[842] = {id = 842, required = 1, cueSheet = "main:SE/skill", cueName = "SE_CharPlayer-Skill-5C", volume = 90}
, 
[843] = {id = 843, required = 1, cueSheet = "main:SE/skill", cueName = "SE_CharPlayer-Skill-5D", volume = 90}
, 
[844] = {id = 844, required = 1, cueSheet = "main:SE/skill", cueName = "SE_CharPlayer-Skill-5E", volume = 90}
, 
[845] = {id = 845, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_nengliang_full", volume = 100}
, 
[846] = {id = 846, required = 1, cueSheet = "main:SE/skill", cueName = "SOUND_skill_nengliang_click", volume = 100}
, 
[847] = {id = 847, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_fragmentsAppear", volume = 100}
, 
[848] = {id = 848, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_fragmentation1", volume = 100}
, 
[849] = {id = 849, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_fragmentation2", volume = 100}
, 
[850] = {id = 850, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_fragmentation3", volume = 100}
, 
[851] = {id = 851, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_fragmentation4", volume = 100}
, 
[852] = {id = 852, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_fragmentation5", volume = 100}
, 
[853] = {id = 853, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_throughTheMirror", volume = 100}
, 
[854] = {id = 854, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_lightRune", volume = 100}
, 
[855] = {id = 855, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_siphonSoul", volume = 100}
, 
[856] = {id = 856, required = 1, cueSheet = "main:SE/role", cueName = "SOUND_role_footstep_mercenary", volume = 70}
, 
[857] = {id = 857, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_altar", volume = 70}
, 
[858] = {id = 858, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_manaTree", volume = 100}
, 
[859] = {id = 859, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_manaCrystal", volume = 100}
, 
[860] = {id = 860, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_mana", volume = 50}
, 
[861] = {id = 861, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_slappingGround", volume = 100}
, 
[862] = {id = 862, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_frogFalldown", volume = 100}
, 
[863] = {id = 863, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_absorbMagic", volume = 100}
, 
[864] = {id = 864, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_actorFalldown", volume = 60}
, 
[865] = {id = 865, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Battle-Energy-Click", volume = 100}
, 
[866] = {id = 866, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Battle-EnergyBurst", volume = 100}
, 
[867] = {id = 867, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Battle-EnergyCharge", volume = 5}
, 
[868] = {id = 868, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Battle-EnergyFull", volume = 60}
, 
[869] = {id = 869, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char32-Attack-1", volume = 100}
, 
[870] = {id = 870, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char32-Attack-1_Hit", volume = 50}
, 
[871] = {id = 871, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char32-Skill-1", volume = 100}
, 
[872] = {id = 872, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char32-Skill-2", volume = 100}
, 
[875] = {id = 875, required = 1, cueSheet = "main:SE/skill", cueName = "Char001_0_MoDan", volume = 70}
, 
[876] = {id = 876, required = 1, cueSheet = "main:SE/skill", cueName = "Char001_0_MoDan_Hit", volume = 70}
, 
[877] = {id = 877, required = 1, cueSheet = "main:SE/skill", cueName = "Char001_1_LingHunJian", volume = 100}
, 
[878] = {id = 878, required = 1, cueSheet = "main:SE/skill", cueName = "Char001_1_LingHunJian_Hit", volume = 100}
, 
[879] = {id = 879, required = 1, cueSheet = "main:SE/skill", cueName = "Char001_2_JinJiHuiBi", volume = 100}
, 
[880] = {id = 880, required = 1, cueSheet = "main:SE/skill", cueName = "Char004_0_MoDan", volume = 70}
, 
[881] = {id = 881, required = 1, cueSheet = "main:SE/skill", cueName = "Char004_1_RouGuang", volume = 50}
, 
[882] = {id = 882, required = 1, cueSheet = "main:SE/skill", cueName = "Char004_2_QiangGuang", volume = 80}
, 
[883] = {id = 883, required = 1, cueSheet = "main:SE/skill", cueName = "Char004_3_Revive", volume = 100}
, 
[884] = {id = 884, required = 1, cueSheet = "main:SE/skill", cueName = "Char006_0_ZhiLiao", volume = 40}
, 
[885] = {id = 885, required = 1, cueSheet = "main:SE/skill", cueName = "Char006_1_SuSheng", volume = 80}
, 
[886] = {id = 886, required = 1, cueSheet = "main:SE/skill", cueName = "Char006_2_ShengYuZhuFu", volume = 90}
, 
[887] = {id = 887, required = 1, cueSheet = "main:SE/skill", cueName = "Char012_0_XiJianHuiKan", volume = 70}
, 
[888] = {id = 888, required = 1, cueSheet = "main:SE/skill", cueName = "Char012_0_XiJianHuiKan_Hit", volume = 70}
, 
[889] = {id = 889, required = 1, cueSheet = "main:SE/skill", cueName = "Char012_1_LiuXingZhan", volume = 90}
, 
[890] = {id = 890, required = 1, cueSheet = "main:SE/skill", cueName = "Char012_1_LiuXingZhan_Hit", volume = 90}
, 
[891] = {id = 891, required = 1, cueSheet = "main:SE/skill", cueName = "Char012_2_AoYiLiuGuangZhan", volume = 100}
, 
[892] = {id = 892, required = 1, cueSheet = "main:SE/skill", cueName = "Char012_2_AoYiLiuGuangZhan_Hit", volume = 100}
, 
[893] = {id = 893, required = 1, cueSheet = "main:SE/skill", cueName = "Char014_0_BiShouHuiKan", volume = 40}
, 
[894] = {id = 894, required = 1, cueSheet = "main:SE/skill", cueName = "Char014_0_BiShouHuiKan_Hit", volume = 70}
, 
[895] = {id = 895, required = 1, cueSheet = "main:SE/skill", cueName = "Char014_1_YingXi", volume = 100}
, 
[896] = {id = 896, required = 1, cueSheet = "main:SE/skill", cueName = "Char014_1_YingXi_Hit", volume = 100}
, 
[897] = {id = 897, required = 1, cueSheet = "main:SE/skill", cueName = "Char014_1_YingXi_ShunYi", volume = 100}
, 
[898] = {id = 898, required = 1, cueSheet = "main:SE/skill", cueName = "Char014_2_YeRenBiaoJi", volume = 100}
, 
[899] = {id = 899, required = 1, cueSheet = "main:SE/skill", cueName = "Char015_0_ChangQiangCiJi", volume = 30}
, 
[900] = {id = 900, required = 1, cueSheet = "main:SE/skill", cueName = "Char015_0_ChangQiangCiJi_Hit", volume = 70}
, 
[901] = {id = 901, required = 1, cueSheet = "main:SE/skill", cueName = "Char015_1_ShiBuKeDang", volume = 100}
, 
[902] = {id = 902, required = 1, cueSheet = "main:SE/skill", cueName = "Char015_1_ShiBuKeDang_Hit", volume = 100}
, 
[903] = {id = 903, required = 1, cueSheet = "main:SE/skill", cueName = "Char015_2_ShouHuZhiYu", volume = 40}
, 
[904] = {id = 904, required = 1, cueSheet = "main:SE/skill", cueName = "Char016_0_ZhiLiao", volume = 40}
, 
[905] = {id = 905, required = 1, cueSheet = "main:SE/skill", cueName = "Char016_1_HuZhiLvDong", volume = 80}
, 
[906] = {id = 906, required = 1, cueSheet = "main:SE/skill", cueName = "Char016_2_LvDongHuiSu", volume = 50}
, 
[907] = {id = 907, required = 1, cueSheet = "main:SE/skill", cueName = "Char018_0_ZhenTouHuiDa", volume = 70}
, 
[908] = {id = 908, required = 1, cueSheet = "main:SE/skill", cueName = "Char018_0_ZhenTouHuiDa_Hit", volume = 70}
, 
[909] = {id = 909, required = 1, cueSheet = "main:SE/skill", cueName = "Char018_1_PingZhang", volume = 100}
, 
[910] = {id = 910, required = 1, cueSheet = "main:SE/skill", cueName = "Char018_2_ShouHu", volume = 100}
, 
[911] = {id = 911, required = 1, cueSheet = "main:SE/skill", cueName = "Char019_0_BingJian", volume = 40}
, 
[912] = {id = 912, required = 1, cueSheet = "main:SE/skill", cueName = "Char019_0_BingJian_Hit", volume = 50}
, 
[913] = {id = 913, required = 1, cueSheet = "main:SE/skill", cueName = "Char019_1_BingFeng", volume = 100}
, 
[914] = {id = 914, required = 1, cueSheet = "main:SE/skill", cueName = "Char019_1_BingFeng_BingKuaiSuiLie", volume = 100}
, 
[915] = {id = 915, required = 1, cueSheet = "main:SE/skill", cueName = "Char019_1_BingFeng_Hit", volume = 100}
, 
[916] = {id = 916, required = 1, cueSheet = "main:SE/skill", cueName = "Char019_1_BingFeng_JieBingChiXu", volume = 100}
, 
[917] = {id = 917, required = 1, cueSheet = "main:SE/skill", cueName = "Char019_2_ChuiXue", volume = 90}
, 
[918] = {id = 918, required = 1, cueSheet = "main:SE/skill", cueName = "Char020_0_ZhiLiao", volume = 40}
, 
[919] = {id = 919, required = 1, cueSheet = "main:SE/skill", cueName = "Char020_1_FenXiang", volume = 100}
, 
[920] = {id = 920, required = 1, cueSheet = "main:SE/skill", cueName = "Char020_2_FenXiangLiaoYu", volume = 100}
, 
[921] = {id = 921, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_meetEnemy", volume = 100}
, 
[922] = {id = 922, required = 1, cueSheet = "main:SE/skill", cueName = "mon_base_boss02-Skill-1_Hit", volume = 100}
, 
[923] = {id = 923, required = 1, cueSheet = "main:SE/skill", cueName = "mon_base_boss02-Skill-2_Hit", volume = 100}
, 
[924] = {id = 924, required = 1, cueSheet = "main:SE/skill", cueName = "mon_base_boss02-Skill-3_Hit", volume = 100}
, 
[925] = {id = 925, required = 1, cueSheet = "main:SE/skill", cueName = "mon_base_boss03warrior-Skill-1_Hit", volume = 100}
, 
[926] = {id = 926, required = 1, cueSheet = "main:SE/skill", cueName = "mon_base_boss03warrior-Skill-2_Hit", volume = 100}
, 
[927] = {id = 927, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char064-Attack-1", volume = 100}
, 
[928] = {id = 928, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char064-Attack-1_Hit", volume = 100}
, 
[929] = {id = 929, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char064-Skill-1", volume = 100}
, 
[930] = {id = 930, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char064-Skill-1_Hit", volume = 100}
, 
[931] = {id = 931, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char064-Skill-2", volume = 100}
, 
[932] = {id = 932, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char064-Skill-2_Hit", volume = 100}
, 
[933] = {id = 933, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char066-Attack-1", volume = 100}
, 
[934] = {id = 934, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char066-Attack-1_Hit", volume = 100}
, 
[935] = {id = 935, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char066-Skill-1", volume = 100}
, 
[936] = {id = 936, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char066-Skill-2", volume = 100}
, 
[938] = {id = 938, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char070-Attack-1_Hit", volume = 100}
, 
[939] = {id = 939, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char070-Skill-1", volume = 100}
, 
[940] = {id = 940, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char070-Skill-1_Hit", volume = 100}
, 
[941] = {id = 941, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char070-Skill-2_Hit", volume = 100}
, 
[942] = {id = 942, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char073-Attack-1", volume = 100}
, 
[943] = {id = 943, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char073-Skill-1", volume = 100}
, 
[944] = {id = 944, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char073-Skill-2", volume = 100}
, 
[945] = {id = 945, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char073-Skill-2_Buff", volume = 100}
, 
[946] = {id = 946, required = 1, cueSheet = "main:SE/skill", cueName = "SE_CharPlayer-Skill-6_End", volume = 100}
, 
[947] = {id = 947, required = 1, cueSheet = "main:SE/skill", cueName = "SE_CharPlayer-Skill-6_Start", volume = 100}
, 
[948] = {id = 948, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_w3_26-Attack-1", volume = 100}
, 
[949] = {id = 949, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_w3_26-Attack-1_Hit", volume = 100}
, 
[950] = {id = 950, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_w3_26-Skill-1", volume = 100}
, 
[951] = {id = 951, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_w3_26-Skill-1_Hit", volume = 100}
, 
[952] = {id = 952, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_01-Attack-1_Hit", volume = 100}
, 
[953] = {id = 953, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_01-Magic-1_Hit", volume = 100}
, 
[954] = {id = 954, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_09-Attack-1_Fly", volume = 100}
, 
[955] = {id = 955, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_09-Attack-1_Hit", volume = 100}
, 
[956] = {id = 956, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_10-Attack-1_Hit", volume = 100}
, 
[957] = {id = 957, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_10-Magic-1", volume = 100}
, 
[958] = {id = 958, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_28-Attack-1_Hit", volume = 100}
, 
[959] = {id = 959, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_28-Magic-1_Hit", volume = 100}
, 
[960] = {id = 960, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_29-Attack-1_Fly", volume = 100}
, 
[961] = {id = 961, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_29-Attack-1_Hit", volume = 100}
, 
[962] = {id = 962, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_29-Magic-1", volume = 100}
, 
[963] = {id = 963, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_29-Magic-1_Fly", volume = 100}
, 
[964] = {id = 964, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_30-Attack-1_Hit", volume = 100}
, 
[965] = {id = 965, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_30-Magic-1_Hit", volume = 100}
, 
[966] = {id = 966, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_34-Attack-1_Hit", volume = 100}
, 
[967] = {id = 967, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_34-Magic-1_Hit", volume = 100}
, 
[968] = {id = 968, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_35-Attack-1_Hit", volume = 100}
, 
[969] = {id = 969, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_35-Magic-1", volume = 100}
, 
[970] = {id = 970, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_36-Attack-1", volume = 100}
, 
[971] = {id = 971, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_36-Attack-1_Hit", volume = 100}
, 
[972] = {id = 972, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_36-Magic-1", volume = 100}
, 
[973] = {id = 973, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_37-Attack-1", volume = 100}
, 
[974] = {id = 974, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_37-Attack-1_Hit", volume = 100}
, 
[975] = {id = 975, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_38-Attack-1_Hit", volume = 100}
, 
[976] = {id = 976, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_38-Magic-1", volume = 100}
, 
[977] = {id = 977, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_38-Magic-2", volume = 100}
, 
[978] = {id = 978, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_38-Magic-3", volume = 100}
, 
[979] = {id = 979, required = 1, cueSheet = "main:SE/skill", cueName = "mon_base_boss05mana-Skill-1_Hit", volume = 100}
, 
[980] = {id = 980, required = 1, cueSheet = "main:SE/skill", cueName = "mon_base_boss05mana-Skill-2_Hit", volume = 100}
, 
[981] = {id = 981, required = 1, cueSheet = "main:SE/skill", cueName = "mon_base_boss05mana-Skill-3_Hit", volume = 100}
, 
[982] = {id = 982, required = 1, cueSheet = "main:SE/skill", cueName = "mon_base_boss05mana-Skill-4_Hit", volume = 100}
, 
[983] = {id = 983, required = 1, cueSheet = "main:SE/skill", cueName = "mon_base_boss05mana-Skill-4_Show", volume = 100}
, 
[984] = {id = 984, required = 1, cueSheet = "main:SE/skill", cueName = "mon_base_boss05mana-Skill-5_Hit", volume = 100}
, 
[985] = {id = 985, required = 1, cueSheet = "main:SE/skill", cueName = "mon_base_boss05mana-Skill-6_Hit", volume = 100}
, 
[986] = {id = 986, required = 1, cueSheet = "main:SE/skill", cueName = "mon_base_boss03warrior-Skill-3_Hit", volume = 100}
, 
[987] = {id = 987, required = 1, cueSheet = "main:SE/skill", cueName = "mon_base_boss04mage-Skill-1_Hit", volume = 100}
, 
[988] = {id = 988, required = 1, cueSheet = "main:SE/skill", cueName = "mon_base_boss04mage-Skilll-2_Hit", volume = 100}
, 
[989] = {id = 989, required = 1, cueSheet = "main:SE/skill", cueName = "mon_base_boss04mage-Skilll-3_Hit", volume = 100}
, 
[990] = {id = 990, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_Char_024_MapDragonRoar", volume = 100}
, 
[991] = {id = 991, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char065_sankai", volume = 100}
, 
[992] = {id = 992, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_Erinnern", volume = 100}
, 
[993] = {id = 993, required = 1, cueSheet = "main:BGM/character", cueName = "BGM_Role_DrVaspa", volume = 100}
, 
[994] = {id = 994, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_Scene_CaspielLow1", volume = 100}
, 
[995] = {id = 995, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_Scene_CaspielLow2", volume = 100}
, 
[996] = {id = 996, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_pageturn4", volume = 100}
, 
[997] = {id = 997, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_Soradeus_Tail", volume = 100}
, 
[998] = {id = 998, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_Soradeus_Abdomen", volume = 100}
, 
[999] = {id = 999, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_Soradeus_Head", volume = 100}
, 
[1000] = {id = 1000, required = 1, cueSheet = "main:SE/role", cueName = "SOUND_role_footstep_grass_walking", volume = 100}
, 
[1001] = {id = 1001, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_insectLoop", volume = 100}
, 
[1002] = {id = 1002, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_runeRecharge", volume = 100}
, 
[1003] = {id = 1003, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_speedup", volume = 100}
, 
[1004] = {id = 1004, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_stealth", volume = 100}
, 
[1005] = {id = 1005, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_001_v1-Attack-1", volume = 70}
, 
[1006] = {id = 1006, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_001_v1-Attack-1_Hit", volume = 90}
, 
[1007] = {id = 1007, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_001_v1-Magic-1_Fire", volume = 90}
, 
[1008] = {id = 1008, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_001_v1-Magic-1_Gate", volume = 90}
, 
[1009] = {id = 1009, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_001_v1-Magic-2", volume = 90}
, 
[1010] = {id = 1010, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_001_v1-Magic-2_Gate", volume = 90}
, 
[1011] = {id = 1011, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_001_v1-Magic-3_End", volume = 90}
, 
[1012] = {id = 1012, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_001_v1-Magic-3A", volume = 90}
, 
[1013] = {id = 1013, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_001_v1-Magic-3B", volume = 100}
, 
[1014] = {id = 1014, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_017_v1-Attack-1", volume = 100}
, 
[1015] = {id = 1015, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_017_v1-Attack-1_Hit", volume = 100}
, 
[1016] = {id = 1016, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_017_v1-Magic-1", volume = 100}
, 
[1017] = {id = 1017, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_017_v1-Magic-1_Hit", volume = 100}
, 
[1018] = {id = 1018, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_017_v1-Magic-2", volume = 100}
, 
[1019] = {id = 1019, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_017_v1-Magic-2_Hit", volume = 100}
, 
[1020] = {id = 1020, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_017_v1-Magic-3", volume = 100}
, 
[1021] = {id = 1021, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_017_v1-Magic-4_Hit", volume = 100}
, 
[1022] = {id = 1022, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_017_v1-Magic-4_UI-End", volume = 100}
, 
[1023] = {id = 1023, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_017_v1-Magic-4_UI", volume = 100}
, 
[1024] = {id = 1024, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_054_v1-Magic-1", volume = 100}
, 
[1025] = {id = 1025, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_054_v1-Magic-2", volume = 100}
, 
[1026] = {id = 1026, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss01-Book-1", volume = 100}
, 
[1027] = {id = 1027, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss01-Gemstone-1", volume = 100}
, 
[1028] = {id = 1028, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss01-Hammer-1", volume = 100}
, 
[1029] = {id = 1029, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss01-Hammer-1_Hit", volume = 100}
, 
[1030] = {id = 1030, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss01-Hammer-2", volume = 100}
, 
[1031] = {id = 1031, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss01-Hammer-2_Hit", volume = 100}
, 
[1032] = {id = 1032, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss01-Saber-1", volume = 100}
, 
[1033] = {id = 1033, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss01-Saber-1_Hit", volume = 100}
, 
[1034] = {id = 1034, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss01-Wand-1", volume = 100}
, 
[1035] = {id = 1035, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss01-Wand-1_Hit", volume = 100}
, 
[1036] = {id = 1036, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss01-Wand-2", volume = 100}
, 
[1037] = {id = 1037, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss01-Wand-2_Hit", volume = 100}
, 
[1038] = {id = 1038, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss06shdow-Attack-1_Hit", volume = 100}
, 
[1039] = {id = 1039, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss06shdow-Shield", volume = 100}
, 
[1040] = {id = 1040, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss06shdow-Shield_End", volume = 100}
, 
[1041] = {id = 1041, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss06shdow-Transform", volume = 100}
, 
[1042] = {id = 1042, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss07shdow02-Attack-1_Hit", volume = 100}
, 
[1043] = {id = 1043, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss07shdow02-Magic-1", volume = 100}
, 
[1044] = {id = 1044, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss07shdow02-Shield-001", volume = 100}
, 
[1045] = {id = 1045, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss07shdow02-Shield", volume = 100}
, 
[1046] = {id = 1046, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss07shdow02-Transform", volume = 100}
, 
[1047] = {id = 1047, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss07shdow03-Attack-1_Hit", volume = 100}
, 
[1048] = {id = 1048, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss07shdow03-Magic-1", volume = 100}
, 
[1049] = {id = 1049, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss07shdow03-Magic-2", volume = 100}
, 
[1050] = {id = 1050, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss07shdow03-Shield", volume = 100}
, 
[1051] = {id = 1051, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss07shdow03-Shield_End", volume = 100}
, 
[1052] = {id = 1052, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss07shdow03-Transform", volume = 100}
, 
[1053] = {id = 1053, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss07shdow04-Attack-1_Hit", volume = 100}
, 
[1054] = {id = 1054, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss07shdow04-Magic-1", volume = 100}
, 
[1055] = {id = 1055, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss07shdow04-Magic-2", volume = 100}
, 
[1056] = {id = 1056, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss07shdow04-Shield", volume = 100}
, 
[1057] = {id = 1057, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss07shdow04-Shield_End", volume = 100}
, 
[1058] = {id = 1058, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_05-Attack-1-001", volume = 100}
, 
[1059] = {id = 1059, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_05-Attack-1", volume = 100}
, 
[1060] = {id = 1060, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_05-Attack-1_Fire", volume = 100}
, 
[1061] = {id = 1061, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_05-Attack-1_Hit-001", volume = 100}
, 
[1062] = {id = 1062, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_05-Attack-1_Hit", volume = 100}
, 
[1063] = {id = 1063, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_05-Stand-1", volume = 25}
, 
[1064] = {id = 1064, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_27-Attack-1_Hit", volume = 100}
, 
[1065] = {id = 1065, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_27-Attack-2_Hit", volume = 100}
, 
[1066] = {id = 1066, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_27-Magic-1", volume = 150}
, 
[1067] = {id = 1067, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_27-Magic-2", volume = 100}
, 
[1068] = {id = 1068, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_31-Attack-1", volume = 100}
, 
[1069] = {id = 1069, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_31-Attack-1_Hit", volume = 100}
, 
[1070] = {id = 1070, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_31-Magic-1", volume = 100}
, 
[1071] = {id = 1071, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_31-Shield", volume = 100}
, 
[1072] = {id = 1072, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_37-Magic-1", volume = 100}
, 
[1073] = {id = 1073, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_37-Magic-1_Hit", volume = 100}
, 
[1074] = {id = 1074, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_37-Magic-2", volume = 100}
, 
[1075] = {id = 1075, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_37-Magic-2_End", volume = 100}
, 
[1076] = {id = 1076, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w4_01-Magic-2", volume = 100}
, 
[1077] = {id = 1077, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w4_01-Magic-2_Hit", volume = 100}
, 
[1078] = {id = 1078, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_065-Magic-4_BuffA", volume = 90}
, 
[1079] = {id = 1079, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_065-Magic-4_BuffB", volume = 90}
, 
[1080] = {id = 1080, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_065-Magic-4_Fly", volume = 90}
, 
[1081] = {id = 1081, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_065-Magic-4_Hit", volume = 90}
, 
[1082] = {id = 1082, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_065-Magic-4A", volume = 90}
, 
[1083] = {id = 1083, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_065-Magic-4B", volume = 90}
, 
[1084] = {id = 1084, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_065-Magic-5", volume = 90}
, 
[1085] = {id = 1085, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_065-Magic-5_Buff_End", volume = 90}
, 
[1086] = {id = 1086, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_065-Magic-5_BuffA", volume = 90}
, 
[1087] = {id = 1087, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_065-Magic-5_BuffB", volume = 90}
, 
[1088] = {id = 1088, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_065-Magic-5_Hit", volume = 90}
, 
[1089] = {id = 1089, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_25-Attack-1", volume = 100}
, 
[1090] = {id = 1090, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_25-Attack-1_Hit", volume = 100}
, 
[1091] = {id = 1091, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_25-Attack-2", volume = 100}
, 
[1092] = {id = 1092, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_25-Attack-2_Buff", volume = 100}
, 
[1093] = {id = 1093, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_25-Attack-2_Hit", volume = 100}
, 
[1094] = {id = 1094, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_25-Magic-1", volume = 100}
, 
[1095] = {id = 1095, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_32-Attack-1_Hit", volume = 100}
, 
[1096] = {id = 1096, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_32-Attack-2", volume = 100}
, 
[1097] = {id = 1097, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_32-Attack-2_Hit", volume = 100}
, 
[1098] = {id = 1098, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_32-Magic-1", volume = 100}
, 
[1099] = {id = 1099, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_32-Magic-2", volume = 100}
, 
[1100] = {id = 1100, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_33-Attack-1", volume = 100}
, 
[1101] = {id = 1101, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_33-Attack-Hit", volume = 100}
, 
[1102] = {id = 1102, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_33-Magic-1", volume = 100}
, 
[1103] = {id = 1103, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_33-Magic-1_Buff", volume = 100}
, 
[1104] = {id = 1104, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_33-Magic-1_Hit", volume = 100}
, 
[1105] = {id = 1105, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_33-Magic-3", volume = 100}
, 
[1106] = {id = 1106, required = 1, cueSheet = "main:SE/skill", cueName = "SE_boss_w3_03_Voice-1", volume = 100}
, 
[1107] = {id = 1107, required = 1, cueSheet = "main:SE/skill", cueName = "SE_boss_w3_03_Voice-2", volume = 100}
, 
[1108] = {id = 1108, required = 1, cueSheet = "main:SE/skill", cueName = "SE_boss_w3_03_Voice-Death", volume = 100}
, 
[1109] = {id = 1109, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss01_Voice-1", volume = 100}
, 
[1110] = {id = 1110, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss01_Voice-2", volume = 100}
, 
[1111] = {id = 1111, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss02_Voice-1", volume = 100}
, 
[1112] = {id = 1112, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss02_Voice-2", volume = 100}
, 
[1113] = {id = 1113, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss03_Voice-1", volume = 100}
, 
[1114] = {id = 1114, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss03_Voice-2", volume = 100}
, 
[1115] = {id = 1115, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss04_Voice-1", volume = 100}
, 
[1116] = {id = 1116, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss04_Voice-2", volume = 100}
, 
[1117] = {id = 1117, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss05mana_Voice-1", volume = 100}
, 
[1118] = {id = 1118, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss05mana_Voice-2", volume = 100}
, 
[1119] = {id = 1119, required = 1, cueSheet = "main:SE/skill", cueName = "SE_boss_w3_01A-Attack-1", volume = 100}
, 
[1120] = {id = 1120, required = 1, cueSheet = "main:SE/skill", cueName = "SE_boss_w3_01A-Attack-2", volume = 100}
, 
[1121] = {id = 1121, required = 1, cueSheet = "main:SE/skill", cueName = "SE_boss_w3_01A-Magic-1", volume = 100}
, 
[1122] = {id = 1122, required = 1, cueSheet = "main:SE/skill", cueName = "SE_boss_w3_01A-Magic-2", volume = 100}
, 
[1123] = {id = 1123, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss01-Gemstone-2", volume = 100}
, 
[1124] = {id = 1124, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss01-Saber-2", volume = 100}
, 
[1125] = {id = 1125, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss01-Saber-3", volume = 100}
, 
[1126] = {id = 1126, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss01-Saber-4", volume = 100}
, 
[1127] = {id = 1127, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_w3_07-Magic", volume = 100}
, 
[1128] = {id = 1128, required = 1, cueSheet = "main:SE/skill", cueName = "SE_boss_w3_02-Attack-1", volume = 100}
, 
[1129] = {id = 1129, required = 1, cueSheet = "main:SE/skill", cueName = "SE_boss_w3_02-Attack-2", volume = 100}
, 
[1130] = {id = 1130, required = 1, cueSheet = "main:SE/skill", cueName = "SE_boss_w3_02-Magic-1", volume = 100}
, 
[1131] = {id = 1131, required = 1, cueSheet = "main:SE/skill", cueName = "SE_boss_w3_02-Magic-2", volume = 100}
, 
[1132] = {id = 1132, required = 1, cueSheet = "main:SE/skill", cueName = "SE_boss_w3_02-Magic-3", volume = 100}
, 
[1133] = {id = 1133, required = 1, cueSheet = "main:SE/skill", cueName = "SE_boss_w3_03-Attack-1", volume = 100}
, 
[1134] = {id = 1134, required = 1, cueSheet = "main:SE/skill", cueName = "SE_boss_w3_03-Attack-2", volume = 100}
, 
[1135] = {id = 1135, required = 1, cueSheet = "main:SE/skill", cueName = "SE_boss_w3_03-Magic-1", volume = 100}
, 
[1136] = {id = 1136, required = 1, cueSheet = "main:SE/skill", cueName = "SE_boss_w3_03-Magic-2-1", volume = 100}
, 
[1137] = {id = 1137, required = 1, cueSheet = "main:SE/skill", cueName = "SE_boss_w3_03-Magic-2-2", volume = 100}
, 
[1138] = {id = 1138, required = 1, cueSheet = "main:SE/skill", cueName = "SE_boss_w3_03-Magic-3", volume = 100}
, 
[1139] = {id = 1139, required = 1, cueSheet = "main:SE/skill", cueName = "mon_base_boss05mana-Skill-5_HitA", volume = 100}
, 
[1140] = {id = 1140, required = 1, cueSheet = "main:SE/skill", cueName = "mon_base_boss05mana-Skill-5_HitB", volume = 100}
, 
[1141] = {id = 1141, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss06shdow02-Death", volume = 100}
, 
[1142] = {id = 1142, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss06shdow03-Death", volume = 100}
, 
[1143] = {id = 1143, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss06shdow04-Death", volume = 100}
, 
[1144] = {id = 1144, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_boss06shdow-Death", volume = 100}
, 
[1145] = {id = 1145, required = 1, cueSheet = "main:BGM/OST", cueName = "01Awakening", volume = 100}
, 
[1146] = {id = 1146, required = 1, cueSheet = "main:BGM/OST", cueName = "02Revived Witch", volume = 100}
, 
[1147] = {id = 1147, required = 1, cueSheet = "main:BGM/OST", cueName = "03The Forest", volume = 100}
, 
[1148] = {id = 1148, required = 1, cueSheet = "main:BGM/OST", cueName = "04Mysterious Black Cat", volume = 100}
, 
[1149] = {id = 1149, required = 1, cueSheet = "main:BGM/OST", cueName = "05Tower Atrium", volume = 100}
, 
[1150] = {id = 1150, required = 1, cueSheet = "main:BGM/OST", cueName = "06The Guardian", volume = 100}
, 
[1151] = {id = 1151, required = 1, cueSheet = "main:BGM/OST", cueName = "07Victory Fanfare", volume = 100}
, 
[1152] = {id = 1152, required = 1, cueSheet = "main:BGM/OST", cueName = "08Main Menu", volume = 100}
, 
[1153] = {id = 1153, required = 1, cueSheet = "main:BGM/OST", cueName = "09Tower of Time", volume = 100}
, 
[1154] = {id = 1154, required = 1, cueSheet = "main:BGM/OST", cueName = "10Spellbooks", volume = 100}
, 
[1155] = {id = 1155, required = 1, cueSheet = "main:BGM/OST", cueName = "11Through the Mirror", volume = 100}
, 
[1156] = {id = 1156, required = 1, cueSheet = "main:BGM/OST", cueName = "12Keeper of Time", volume = 100}
, 
[1157] = {id = 1157, required = 1, cueSheet = "main:BGM/OST", cueName = "13Magic Forest of Irminsul", volume = 100}
, 
[1158] = {id = 1158, required = 1, cueSheet = "main:BGM/OST", cueName = "14Forest Defenders", volume = 100}
, 
[1159] = {id = 1159, required = 1, cueSheet = "main:BGM/OST", cueName = "15Irminsul Night", volume = 100}
, 
[1160] = {id = 1160, required = 1, cueSheet = "main:BGM/OST", cueName = "16Frog Knight", volume = 100}
, 
[1161] = {id = 1161, required = 1, cueSheet = "main:BGM/OST", cueName = "17Heart of the Forest", volume = 100}
, 
[1162] = {id = 1162, required = 1, cueSheet = "main:BGM/OST", cueName = "18Forest Goddess", volume = 100}
, 
[1163] = {id = 1163, required = 1, cueSheet = "main:BGM/OST", cueName = "19Anemone", volume = 100}
, 
[1164] = {id = 1164, required = 1, cueSheet = "main:BGM/OST", cueName = "20Snegurochka", volume = 100}
, 
[1165] = {id = 1165, required = 1, cueSheet = "main:BGM/OST", cueName = "21Campfire", volume = 100}
, 
[1166] = {id = 1166, required = 1, cueSheet = "main:BGM/OST", cueName = "22Ice Plains of Snegurochka", volume = 100}
, 
[1167] = {id = 1167, required = 1, cueSheet = "main:BGM/OST", cueName = "23Hunters and Wolves", volume = 100}
, 
[1168] = {id = 1168, required = 1, cueSheet = "main:BGM/OST", cueName = "24Heart of Ice", volume = 100}
, 
[1169] = {id = 1169, required = 1, cueSheet = "main:BGM/OST", cueName = "25Ice Goddess", volume = 100}
, 
[1170] = {id = 1170, required = 1, cueSheet = "main:BGM/OST", cueName = "26Goddess\' Regret", volume = 100}
, 
[1171] = {id = 1171, required = 1, cueSheet = "main:BGM/OST", cueName = "27The Silver Lake", volume = 100}
, 
[1172] = {id = 1172, required = 1, cueSheet = "main:BGM/OST", cueName = "28Before the Storm", volume = 100}
, 
[1173] = {id = 1173, required = 1, cueSheet = "main:BGM/OST", cueName = "29Together We Can Save this World", volume = 100}
, 
[1174] = {id = 1174, required = 1, cueSheet = "main:BGM/OST", cueName = "30Descent", volume = 100}
, 
[1175] = {id = 1175, required = 1, cueSheet = "main:BGM/OST", cueName = "31Lava Lake", volume = 100}
, 
[1176] = {id = 1176, required = 1, cueSheet = "main:BGM/OST", cueName = "32Djinn and Giants", volume = 100}
, 
[1177] = {id = 1177, required = 1, cueSheet = "main:BGM/OST", cueName = "33Heart of Fire", volume = 100}
, 
[1178] = {id = 1178, required = 1, cueSheet = "main:BGM/OST", cueName = "34The Banshee", volume = 100}
, 
[1179] = {id = 1179, required = 1, cueSheet = "main:BGM/OST", cueName = "35One Last Time", volume = 100}
, 
[1180] = {id = 1180, required = 1, cueSheet = "main:BGM/OST", cueName = "36Duel with a Demon", volume = 100}
, 
[1181] = {id = 1181, required = 1, cueSheet = "main:BGM/OST", cueName = "37Hope Returning", volume = 100}
, 
[1182] = {id = 1182, required = 1, cueSheet = "main:SE/skill", cueName = "SE_n007_Attack", volume = 100}
, 
[1183] = {id = 1183, required = 1, cueSheet = "main:SE/skill", cueName = "SE_n007_Magic3", volume = 100}
, 
[1184] = {id = 1184, required = 1, cueSheet = "main:SE/skill", cueName = "SE_W3_Boss_Change1", volume = 100}
, 
[1185] = {id = 1185, required = 1, cueSheet = "main:SE/skill", cueName = "SE_W3_Boss_Change2", volume = 100}
, 
[1186] = {id = 1186, required = 1, cueSheet = "main:SE/skill", cueName = "SE_W3_Boss_Change3", volume = 100}
, 
[1187] = {id = 1187, required = 1, cueSheet = "main:SE/skill", cueName = "SE_W3_Boss_Start", volume = 100}
, 
[1188] = {id = 1188, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_BubbleAngry", volume = 0}
, 
[1189] = {id = 1189, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_BubbleDrop&Dots&Question&Sleep", volume = 0}
, 
[1190] = {id = 1190, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_BubbleHappy", volume = 0}
, 
[1191] = {id = 1191, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_BubbleIdea", volume = 0}
, 
[1192] = {id = 1192, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_BubbleLike", volume = 0}
, 
[1193] = {id = 1193, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_BubbleShock", volume = 0}
, 
[1194] = {id = 1194, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_BubbleUnhappy", volume = 0}
, 
[1195] = {id = 1195, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_Char_017_DeconstructionHitImprisoning", volume = 100}
, 
[1196] = {id = 1196, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_Char_024_DragonFly_1", volume = 100}
, 
[1197] = {id = 1197, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_Char_024_DragonFly_2", volume = 100}
, 
[1198] = {id = 1198, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_Char_024_DragonFly_3", volume = 100}
, 
[1199] = {id = 1199, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_Char_024_DragonRoar", volume = 100}
, 
[1200] = {id = 1200, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_Char_024_DragontoHuman", volume = 100}
, 
[1201] = {id = 1201, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_CharAppear", volume = 100}
, 
[1202] = {id = 1202, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_CharClaw", volume = 100}
, 
[1203] = {id = 1203, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_CharDissolve", volume = 100}
, 
[1204] = {id = 1204, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_CharGetUp", volume = 100}
, 
[1205] = {id = 1205, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_CharWalkfromForest", volume = 100}
, 
[1206] = {id = 1206, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_DrawSword", volume = 100}
, 
[1207] = {id = 1207, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_MagicCast_Book", volume = 100}
, 
[1208] = {id = 1208, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_Mon_t2_10m_ScytheChain_1", volume = 100}
, 
[1209] = {id = 1209, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_Mon_t2_10m_ScytheChain_2", volume = 100}
, 
[1210] = {id = 1210, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_Mon_t2_10m_ScytheChain_3", volume = 100}
, 
[1211] = {id = 1211, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_MonsterAppear", volume = 100}
, 
[1212] = {id = 1212, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_MonsterFloating", volume = 100}
, 
[1213] = {id = 1213, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_N001_EarthFireCast", volume = 100}
, 
[1214] = {id = 1214, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_N001_EarthFireHit", volume = 100}
, 
[1215] = {id = 1215, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_N007_Fingersnap1", volume = 100}
, 
[1216] = {id = 1216, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_N007_Fingersnap2", volume = 100}
, 
[1217] = {id = 1217, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_ReadytoFight", volume = 100}
, 
[1218] = {id = 1218, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_StatueMove_A", volume = 100}
, 
[1219] = {id = 1219, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_StatueMove_B", volume = 100}
, 
[1220] = {id = 1220, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_DrVaspa", volume = 100}
, 
[1221] = {id = 1221, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_Normal4", volume = 100}
, 
[1222] = {id = 1222, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_Fellagood_III", volume = 100}
, 
[1223] = {id = 1223, required = 1, cueSheet = "main:BGM/Caspiel", cueName = "BGM_Story_Cliff", volume = 50}
, 
[1224] = {id = 1224, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_MercenaryDie_1", volume = 100}
, 
[1225] = {id = 1225, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_MercenaryDie_2", volume = 100}
, 
[1226] = {id = 1226, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_063_Magic2", volume = 100}
, 
[1227] = {id = 1227, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_063_Magic", volume = 100}
, 
[1228] = {id = 1228, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_063_Magic_Att", volume = 100}
, 
[1229] = {id = 1229, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_063_Magic_Loop", volume = 100}
, 
[1230] = {id = 1230, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_063_Magic_LoopA", volume = 100}
, 
[1231] = {id = 1231, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_063_Magic_LoopB", volume = 100}
, 
[1232] = {id = 1232, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_067_Attack2_Att", volume = 100}
, 
[1233] = {id = 1233, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_067_Attack_Att", volume = 100}
, 
[1234] = {id = 1234, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_067_Magic2", volume = 100}
, 
[1235] = {id = 1235, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_067_Magic", volume = 100}
, 
[1236] = {id = 1236, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_067_Magic_Att", volume = 100}
, 
[1237] = {id = 1237, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_067_MagicP", volume = 100}
, 
[1238] = {id = 1238, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_067_MagicP_Att", volume = 100}
, 
[1239] = {id = 1239, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_068_Attack", volume = 100}
, 
[1240] = {id = 1240, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_068_Attack_Att", volume = 100}
, 
[1241] = {id = 1241, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_068_Maagic2", volume = 100}
, 
[1242] = {id = 1242, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_068_Magic", volume = 100}
, 
[1243] = {id = 1243, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_068_Magic_Att", volume = 100}
, 
[1244] = {id = 1244, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_068_MagicP", volume = 100}
, 
[1245] = {id = 1245, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_068_MagicP_Att", volume = 100}
, 
[1246] = {id = 1246, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_074_Magic2", volume = 100}
, 
[1247] = {id = 1247, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_074_Magic2_Att1", volume = 100}
, 
[1248] = {id = 1248, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_074_Magic2_Att2", volume = 100}
, 
[1249] = {id = 1249, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_074_Magic", volume = 100}
, 
[1250] = {id = 1250, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_074_Magic_Att", volume = 100}
, 
[1251] = {id = 1251, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_huijian", volume = 50}
, 
[1252] = {id = 1252, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_Scene_StarryMirror_Easy", volume = 35}
, 
[1253] = {id = 1253, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_Scene_StarryMirror_Hard", volume = 30}
, 
[1254] = {id = 1254, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_FatePresence_P1", volume = 100}
, 
[1255] = {id = 1255, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_FatePresence_P2", volume = 100}
, 
[1256] = {id = 1256, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_Starrymirror_Easy", volume = 100}
, 
[1257] = {id = 1257, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_Starrymirror_Hard", volume = 100}
, 
[1258] = {id = 1258, required = 1, cueSheet = "main:BGM/character", cueName = "BGM_Role_Fellagood_III", volume = 100}
, 
[1259] = {id = 1259, required = 1, cueSheet = "main:BGM/character", cueName = "BGM_Role_Flare", volume = 100}
, 
[1260] = {id = 1260, required = 1, cueSheet = "main:BGM/character", cueName = "BGM_Role_Laksha", volume = 100}
, 
[1261] = {id = 1261, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_fs_01_Attack", volume = 100}
, 
[1262] = {id = 1262, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_fs_01_Attack_Att", volume = 100}
, 
[1263] = {id = 1263, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_012_Magic_lx", volume = 100}
, 
[1264] = {id = 1264, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_002_Magic_jfjq", volume = 100}
, 
[1265] = {id = 1265, required = 1, cueSheet = "main:SE/skill", cueName = "SE_char_002_Magic_xy", volume = 100}
, 
[1266] = {id = 1266, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_enviroment_wings", volume = 100}
, 
[1267] = {id = 1267, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_glassBroken", volume = 15}
, 
[1268] = {id = 1268, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_006_Attack", volume = 100}
, 
[1269] = {id = 1269, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_006_Attack_Att", volume = 100}
, 
[1270] = {id = 1270, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_006_Magic2_1", volume = 100}
, 
[1271] = {id = 1271, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_006_Magic2_2", volume = 100}
, 
[1272] = {id = 1272, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_006_Magic2_buff", volume = 100}
, 
[1273] = {id = 1273, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_006_Magic", volume = 100}
, 
[1274] = {id = 1274, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_006_Magic_buff", volume = 100}
, 
[1275] = {id = 1275, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_045_Attack", volume = 100}
, 
[1276] = {id = 1276, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_045_Attack_Att", volume = 100}
, 
[1277] = {id = 1277, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_045_Magic2", volume = 100}
, 
[1278] = {id = 1278, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_045_Magic2_2", volume = 100}
, 
[1279] = {id = 1279, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_045_Magic", volume = 100}
, 
[1280] = {id = 1280, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Char_045_Magic_buff", volume = 100}
, 
[1281] = {id = 1281, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_01_Attack_Att", volume = 100}
, 
[1282] = {id = 1282, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_01_Magic", volume = 100}
, 
[1283] = {id = 1283, required = 1, cueSheet = "main:SE/skill", cueName = "SE_mon_base_05_Magic", volume = 100}
, 
[1284] = {id = 1284, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_base_010_TanLan_att", volume = 30}
, 
[1285] = {id = 1285, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_base_011_BianJi_att", volume = 100}
, 
[1286] = {id = 1286, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_base_011_JiNu_ZiShen", volume = 100}
, 
[1287] = {id = 1287, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_base_13_fumianqixi", volume = 100}
, 
[1288] = {id = 1288, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_base_13_lansan", volume = 100}
, 
[1289] = {id = 1289, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_base_13_lansan_att", volume = 100}
, 
[1290] = {id = 1290, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_base_14_baonu_buff", volume = 100}
, 
[1291] = {id = 1291, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_base_14_sisui_S_att", volume = 100}
, 
[1292] = {id = 1292, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_base_14_zaji_hei_att", volume = 30}
, 
[1293] = {id = 1293, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_base_15_HP", volume = 40}
, 
[1294] = {id = 1294, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_base_15_JiDu", volume = 100}
, 
[1295] = {id = 1295, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_base_15_JingPian_HP", volume = 40}
, 
[1296] = {id = 1296, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_base_15_JingZhong_HP", volume = 100}
, 
[1297] = {id = 1297, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_w3_012_kenYao_att", volume = 100}
, 
[1298] = {id = 1298, required = 1, cueSheet = "main:SE/skill", cueName = "SE_Mon_w3_012_TunShi_att", volume = 100}
, 
[1299] = {id = 1299, required = 1, cueSheet = "main:SE/Char_048", cueName = "SE_Char_048_ai_att", volume = 60}
, 
[1300] = {id = 1300, required = 1, cueSheet = "main:SE/Char_048", cueName = "SE_Char_048_Attack", volume = 60}
, 
[1301] = {id = 1301, required = 1, cueSheet = "main:SE/Char_048", cueName = "SE_Char_048_Attack_Att", volume = 60}
, 
[1302] = {id = 1302, required = 1, cueSheet = "main:SE/Char_048", cueName = "SE_Char_048_nu_att", volume = 60}
, 
[1303] = {id = 1303, required = 1, cueSheet = "main:SE/Char_048", cueName = "SE_Char_048_qiehuan_ai", volume = 60}
, 
[1304] = {id = 1304, required = 1, cueSheet = "main:SE/Char_048", cueName = "SE_Char_048_qiehuan_nu", volume = 60}
, 
[1305] = {id = 1305, required = 1, cueSheet = "main:SE/Char_048", cueName = "SE_Char_048_qiehuan_xi", volume = 60}
, 
[1306] = {id = 1306, required = 1, cueSheet = "main:SE/Char_048", cueName = "SE_Char_048_xi_att", volume = 60}
, 
[1307] = {id = 1307, required = 1, cueSheet = "main:SE/environment", cueName = "Sound_enviroment_wavingStaff", volume = 30}
, 
[1308] = {id = 1308, required = 1, cueSheet = "main:SE/environment", cueName = "Sound_enviroment_fire", volume = 80}
, 
[1309] = {id = 1309, required = 1, cueSheet = "main:SE/environment", cueName = "SOUND_environment_shixiangguieye", volume = 50}
, 
[1310] = {id = 1310, required = 1, cueSheet = "main:SE/Mon_base_16", cueName = "SE_Mon_base_16_MirrorRain", volume = 100}
, 
[1311] = {id = 1311, required = 1, cueSheet = "main:SE/Mon_base_16", cueName = "SE_Mon_base_16_MirrorRain_fly", volume = 100}
, 
[1312] = {id = 1312, required = 1, cueSheet = "main:SE/Mon_base_16", cueName = "SE_Mon_base_16_MirrorRain_att", volume = 100}
, 
[1313] = {id = 1313, required = 1, cueSheet = "main:SE/Mon_base_16", cueName = "SE_Mon_base_16_GateofBabylon", volume = 100}
, 
[1314] = {id = 1314, required = 1, cueSheet = "main:SE/Mon_base_16", cueName = "SE_Mon_base_16_GateofBabylon_fly", volume = 100}
, 
[1315] = {id = 1315, required = 1, cueSheet = "main:SE/Mon_base_16", cueName = "SE_Mon_base_16_GateofBabylon_att", volume = 100}
, 
[1316] = {id = 1316, required = 1, cueSheet = "main:SE/Mon_base_16", cueName = "SE_Mon_base_17_zhendi_att", volume = 100}
, 
[1317] = {id = 1317, required = 1, cueSheet = "main:SE/Mon_base_16", cueName = "SE_Mon_base_17_pentu_att", volume = 100}
, 
[1318] = {id = 1318, required = 1, cueSheet = "main:SE/Mon_base_16", cueName = "SE_Mon_base_17_ciji_att", volume = 100}
, 
[1319] = {id = 1319, required = 1, cueSheet = "main:SE/Char_045", cueName = "SE_Char_045_TX_shuiqiu_fly", volume = 20}
, 
[1320] = {id = 1320, required = 1, cueSheet = "main:SE/Char_045", cueName = "SE_Char_045_TX_huzhizhufu_S", volume = 20}
, 
[1321] = {id = 1321, required = 1, cueSheet = "main:SE/Char_045", cueName = "SE_Char_045_TX_lianzhushuiqiu_fly", volume = 20}
, 
[1322] = {id = 1322, required = 1, cueSheet = "main:SE/Char_045", cueName = "SE_Char_045_TX_shuiqiu_fly", volume = 20}
, 
[1323] = {id = 1323, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_Scene_SeaIsland_Night", volume = 100}
, 
[1324] = {id = 1324, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_Scene_SeaIsland_Day", volume = 100}
, 
[1325] = {id = 1325, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_SeaIsland1", volume = 80}
, 
[1326] = {id = 1326, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_SeaIsland1", volume = 80}
, 
[1327] = {id = 1327, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_Deepsea", volume = 80}
, 
[1328] = {id = 1328, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_scene_menu", volume = 100}
, 
[1329] = {id = 1329, required = 1, cueSheet = "main:SE/Char_071", cueName = "SE_Char_071_TX_nengliangzhuanyi", volume = 40}
, 
[1330] = {id = 1330, required = 1, cueSheet = "main:SE/Char_071", cueName = "SE_Char_071_TX_pg", volume = 25}
, 
[1331] = {id = 1331, required = 1, cueSheet = "main:SE/Char_071", cueName = "SE_Char_071_TX_ruodian", volume = 25}
, 
[1332] = {id = 1332, required = 1, cueSheet = "main:SE/skill0923", cueName = "SE_Char_078_TX_gedang", volume = 40}
, 
[1333] = {id = 1333, required = 1, cueSheet = "main:SE/skill0923", cueName = "SE_Char_078_TX_pg", volume = 40}
, 
[1334] = {id = 1334, required = 1, cueSheet = "main:SE/skill0923", cueName = "SE_Char_078_TX_tingdun", volume = 40}
, 
[1335] = {id = 1335, required = 1, cueSheet = "main:SE/skill0923", cueName = "SE_Char_079_att_HP", volume = 40}
, 
[1336] = {id = 1336, required = 1, cueSheet = "main:SE/skill0923", cueName = "SE_Char_079_fly_SP", volume = 40}
, 
[1337] = {id = 1337, required = 1, cueSheet = "main:SE/skill0923", cueName = "SE_Char_079_Magic2_Lang_S", volume = 40}
, 
[1338] = {id = 1338, required = 1, cueSheet = "main:SE/skill0923", cueName = "SE_Char_079_Magic_Buff_S", volume = 40}
, 
[1339] = {id = 1339, required = 1, cueSheet = "main:SE/skill0923", cueName = "SE_Mon_sum_01_TianLaiZhiYin_B", volume = 30}
, 
[1340] = {id = 1340, required = 1, cueSheet = "main:SE/skill0923", cueName = "SE_Mon_sum_02_LuanDa_B", volume = 30}
, 
[1341] = {id = 1341, required = 1, cueSheet = "main:SE/skill0923", cueName = "SE_Mon_sum_03_LaoLong_B", volume = 30}
, 
[1342] = {id = 1342, required = 1, cueSheet = "main:SE/skill0923", cueName = "SE_Mon_sum_06_magic3_HP", volume = 30}
, 
[1343] = {id = 1343, required = 1, cueSheet = "main:SE/skill0923", cueName = "SE_Mon_sum_06_magic4_S", volume = 30}
, 
[1344] = {id = 1344, required = 1, cueSheet = "main:SE/skill0923", cueName = "SE_Mon_sum_06_magic_HP", volume = 30}
, 
[1345] = {id = 1345, required = 1, cueSheet = "main:SE/Char_089", cueName = "SE_Char_089_ChengJie_fly", volume = 40}
, 
[1346] = {id = 1346, required = 1, cueSheet = "main:SE/Char_089", cueName = "SE_Char_089_XingXing", volume = 40}
, 
[1347] = {id = 1347, required = 1, cueSheet = "main:SE/Char_090", cueName = "SE_Char_090_DaoDan_HP", volume = 40}
, 
[1348] = {id = 1348, required = 1, cueSheet = "main:SE/Char_090", cueName = "SE_Char_090_NanGuaZhaDan_S", volume = 40}
, 
[1349] = {id = 1349, required = 1, cueSheet = "main:SE/Char_081", cueName = "SE_Char_081_BaoHu_B", volume = 40}
, 
[1350] = {id = 1350, required = 1, cueSheet = "main:SE/Char_081", cueName = "SE_Char_081_ZhiYuZhiShou_B", volume = 40}
, 
[1351] = {id = 1351, required = 1, cueSheet = "main:SE/Char_083", cueName = "SE_Char_083_baofengxue", volume = 40}
, 
[1352] = {id = 1352, required = 1, cueSheet = "main:SE/Char_083", cueName = "SE_Char_083_bingzhui", volume = 20}
, 
[1353] = {id = 1353, required = 1, cueSheet = "main:SE/Char_095", cueName = "SE_Char_095_juguangdeng", volume = 30}
, 
[1354] = {id = 1354, required = 1, cueSheet = "main:SE/Char_095", cueName = "SE_Char_095_showtime", volume = 30}
, 
[1355] = {id = 1355, required = 1, cueSheet = "main:SE/Char_095", cueName = "SE_Char_095_wutai", volume = 30}
, 
[1356] = {id = 1356, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_Scene_Christmas", volume = 100}
, 
[1357] = {id = 1357, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_ChristmasBattle", volume = 100}
, 
[1358] = {id = 1358, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_Scene_SpringFestival", volume = 50}
, 
[1359] = {id = 1359, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_SpringFestival", volume = 100}
, 
[1360] = {id = 1360, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_Nian", volume = 100}
, 
[1361] = {id = 1361, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_Scene_Valentine\'sDay", volume = 100}
, 
[1362] = {id = 1362, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_ValentinesDay", volume = 100}
, 
[1363] = {id = 1363, required = 1, cueSheet = "main:SE/Char_080", cueName = "SE_Char_080_CiYuan", volume = 40}
, 
[1364] = {id = 1364, required = 1, cueSheet = "main:SE/Char_080", cueName = "SE_Char_080_JinGu", volume = 40}
, 
[1365] = {id = 1365, required = 1, cueSheet = "main:SE/Char_080", cueName = "SE_Char_080_Jinji", volume = 40}
, 
[1366] = {id = 1366, required = 1, cueSheet = "main:SE/ui", cueName = "SOUND_ui_opendoor", volume = 100}
, 
[1367] = {id = 1367, required = 1, cueSheet = "main:SE/Char_108", cueName = "SE_Char_108_JinJi_Att", volume = 40}
, 
[1368] = {id = 1368, required = 1, cueSheet = "main:SE/Char_108", cueName = "SE_Char_108_JinJi_Pao", volume = 40}
, 
[1369] = {id = 1369, required = 1, cueSheet = "main:SE/Char_108", cueName = "SE_Char_108_ShouHu_Dun", volume = 40}
, 
[1370] = {id = 1370, required = 1, cueSheet = "main:SE/Char_108", cueName = "SE_Char_108_ShouHu_XuLi", volume = 40}
, 
[1371] = {id = 1371, required = 1, cueSheet = "main:SE/Char_110", cueName = "SE_Char_110_MaoShi", volume = 40}
, 
[1372] = {id = 1372, required = 1, cueSheet = "main:SE/Char_110", cueName = "SE_Char_110_YueYueYuShi_B", volume = 40}
, 
[1373] = {id = 1373, required = 1, cueSheet = "main:SE/Char_110", cueName = "SE_Char_110_YueYueYuShi_HP", volume = 40}
, 
[1374] = {id = 1374, required = 1, cueSheet = "main:SE/Char_100", cueName = "SE_Char_100_WuXinZhiShi_Shouji", volume = 40}
, 
[1375] = {id = 1375, required = 1, cueSheet = "main:SE/Char_100", cueName = "SE_Char_100_WuXinZhiShi_Zishen", volume = 40}
, 
[1376] = {id = 1376, required = 1, cueSheet = "main:SE/Char_100", cueName = "SE_Char_100_ZhuLi_ShouJi", volume = 40}
, 
[1377] = {id = 1377, required = 1, cueSheet = "main:SE/Char_106", cueName = "SE_Char_106_ShouHu_Dun", volume = 40}
, 
[1378] = {id = 1378, required = 1, cueSheet = "main:SE/Char_106", cueName = "SE_Char_106_ShouHu_XuLi", volume = 40}
, 
[1379] = {id = 1379, required = 1, cueSheet = "main:SE/BOSS_chun", cueName = "BOSS_chun01_att_HP", volume = 100}
, 
[1380] = {id = 1380, required = 1, cueSheet = "main:SE/BOSS_chun", cueName = "BOSS_chun01_bianshen_B", volume = 100}
, 
[1381] = {id = 1381, required = 1, cueSheet = "main:SE/BOSS_chun", cueName = "BOSS_chun01_magic_S", volume = 100}
, 
[1382] = {id = 1382, required = 1, cueSheet = "main:SE/BOSS_chun", cueName = "BOSS_chun01_magic2_yu_S", volume = 100}
, 
[1383] = {id = 1383, required = 1, cueSheet = "main:SE/BOSS_chun", cueName = "BOSS_chun01_magic3_SP", volume = 100}
, 
[1384] = {id = 1384, required = 1, cueSheet = "main:SE/BOSS_chun", cueName = "BOSS_chun02_magic_fire_SP", volume = 100}
, 
[1385] = {id = 1385, required = 1, cueSheet = "main:SE/BOSS_chun", cueName = "BOSS_chun02_magic2_yu_S", volume = 100}
, 
[1386] = {id = 1386, required = 1, cueSheet = "main:SE/BOSS_chun", cueName = "BOSS_chun03_magic_SP", volume = 100}
, 
[1387] = {id = 1387, required = 1, cueSheet = "main:SE/BOSS_chun", cueName = "BOSS_chun03_magic2_fire_S", volume = 100}
, 
[1388] = {id = 1388, required = 1, cueSheet = "main:SE/Mon_Valentine", cueName = "Mon_vlt01_magic2_att", volume = 100}
, 
[1389] = {id = 1389, required = 1, cueSheet = "main:SE/Mon_Valentine", cueName = "Mon_vlt03_yanwu_zishen", volume = 100}
, 
[1390] = {id = 1390, required = 1, cueSheet = "main:SE/Mon_Valentine", cueName = "Mon_vlt04_aimuzhixin_changjing", volume = 100}
, 
[1391] = {id = 1391, required = 1, cueSheet = "main:SE/Mon_Valentine", cueName = "Mon_vlt04_yuren_shouji", volume = 100}
, 
[1392] = {id = 1392, required = 1, cueSheet = "main:SE/Mon_Valentine", cueName = "SE_Mon_vlt01_magic_att_B", volume = 100}
, 
[1393] = {id = 1393, required = 1, cueSheet = "main:SE/Mon_Valentine", cueName = "SE_Mon_vlt02_jieyao_changjing", volume = 100}
, 
[1394] = {id = 1394, required = 1, cueSheet = "main:SE/role", cueName = "SOUND_role_folklore_singing", volume = 100}
, 
[1395] = {id = 1395, required = 1, cueSheet = "main:BGM/character", cueName = "BGM_Role_Folklore", volume = 100}
, 
[1396] = {id = 1396, required = 1, cueSheet = "main:SE/Char_011", cueName = "SE_Char_011_Jiubei_shouji", volume = 40}
, 
[1397] = {id = 1397, required = 1, cueSheet = "main:SE/Char_011", cueName = "SE_Char_011_Jiubei_zishen", volume = 40}
, 
[1398] = {id = 1398, required = 1, cueSheet = "main:SE/Char_011", cueName = "SE_Char_011_Ruili_shouji", volume = 40}
, 
[1399] = {id = 1399, required = 1, cueSheet = "main:SE/Char_066", cueName = "SE_Char_066_Huyou", volume = 40}
, 
[1400] = {id = 1400, required = 1, cueSheet = "main:SE/Char_066", cueName = "SE_Char_066_Lichang", volume = 40}
, 
[1401] = {id = 1401, required = 1, cueSheet = "main:SE/Char_067", cueName = "SE_Char_067_Cj_danti", volume = 40}
, 
[1402] = {id = 1402, required = 1, cueSheet = "main:SE/Char_067", cueName = "SE_Char_067_Cj_qungong", volume = 40}
, 
[1403] = {id = 1403, required = 1, cueSheet = "main:SE/Char_067", cueName = "SE_Char_067_Pg_danti", volume = 40}
, 
[1404] = {id = 1404, required = 1, cueSheet = "main:SE/Char_099", cueName = "SE_Char_099_Rumengruhuan", volume = 40}
, 
[1405] = {id = 1405, required = 1, cueSheet = "main:SE/Char_099", cueName = "SE_Char_099_Shuiba", volume = 40}
, 
[1406] = {id = 1406, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_Caspiel_Camilyne", volume = 100}
, 
[1407] = {id = 1407, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_Caspiel_Lyne", volume = 100}
, 
[1408] = {id = 1408, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_Scene_Caspiel_ForestElves", volume = 80}
, 
[1409] = {id = 1409, required = 1, cueSheet = "main:BGM/scene", cueName = "BGM_Scene_CaspielUp", volume = 100}
, 
[1410] = {id = 1410, required = 1, cueSheet = "main:SE/ui", cueName = "SOUND_ui_punches", volume = 100}
, 
[1411] = {id = 1411, required = 1, cueSheet = "main:SE/Char_046", cueName = "SE_Char_046_Attack", volume = 40}
, 
[1412] = {id = 1412, required = 1, cueSheet = "main:SE/Char_046", cueName = "SE_Char_046_Skill1", volume = 40}
, 
[1413] = {id = 1413, required = 1, cueSheet = "main:SE/Char_046", cueName = "SE_Char_046_Skill2", volume = 40}
, 
[1414] = {id = 1414, required = 1, cueSheet = "main:SE/Char_046", cueName = "SE_Char_046_Skill2_L2", volume = 40}
, 
[1415] = {id = 1415, required = 1, cueSheet = "main:SE/Char_046", cueName = "SE_Char_046_Skill3", volume = 40}
, 
[1416] = {id = 1416, required = 1, cueSheet = "main:BGM/battle", cueName = "BGM_Battle_Caspiel_Camilyne_Transform", volume = 100}
, 
[1417] = {id = 1417, required = 1, cueSheet = "main:SE/Char_091", cueName = "SE_Char_091_Attack", volume = 40}
, 
[1418] = {id = 1418, required = 1, cueSheet = "main:SE/Char_091", cueName = "SE_Char_091_Skill1", volume = 40}
, 
[1419] = {id = 1419, required = 1, cueSheet = "main:SE/Char_091", cueName = "SE_Char_091_Skill1_L2", volume = 40}
, 
[1420] = {id = 1420, required = 1, cueSheet = "main:SE/Char_091", cueName = "SE_Char_091_Skill2", volume = 40}
, 
[1421] = {id = 1421, required = 1, cueSheet = "main:SE/Char_021_v1", cueName = "Char_021_v1_TX_Prefab_pg_att", volume = 40}
, 
[1422] = {id = 1422, required = 1, cueSheet = "main:SE/Char_021_v1", cueName = "Char_021_v1_TX_Prefab_pg_fly", volume = 40}
, 
[1423] = {id = 1423, required = 1, cueSheet = "main:SE/Char_021_v1", cueName = "Char_021_v1_TX_Prefab_XingHongFengBao", volume = 40}
, 
[1424] = {id = 1424, required = 1, cueSheet = "main:SE/Char_021_v1", cueName = "Char_021_v1_TX_Prefab_YeZhiQiXi_zishen", volume = 40}
, 
[1425] = {id = 1425, required = 1, cueSheet = "main:SE/Char_092", cueName = "SE_Char_092_Attack", volume = 40}
, 
[1426] = {id = 1426, required = 1, cueSheet = "main:SE/Char_092", cueName = "SE_Char_092_Skill1", volume = 40}
, 
[1427] = {id = 1427, required = 1, cueSheet = "main:SE/Char_092", cueName = "SE_Char_092_Skill1_L2", volume = 40}
, 
[1428] = {id = 1428, required = 1, cueSheet = "main:SE/Char_092", cueName = "SE_Char_092_Skill2", volume = 40}
, 
[1429] = {id = 1429, required = 1, cueSheet = "main:SE/Char_092", cueName = "SE_Char_092_Skill2_L2", volume = 40}
, 
[1430] = {id = 1430, required = 1, cueSheet = "main:SE/Char_103", cueName = "SE_Char_103_Attack", volume = 40}
, 
[1431] = {id = 1431, required = 1, cueSheet = "main:SE/Char_103", cueName = "SE_Char_103_Skill1", volume = 40}
, 
[1432] = {id = 1432, required = 1, cueSheet = "main:SE/Char_103", cueName = "SE_Char_103_Skill2", volume = 40}
, 
[1433] = {id = 1433, required = 1, cueSheet = "main:SE/Char_103", cueName = "SE_Char_103_Skill2_L2", volume = 40}
, 
[1434] = {id = 1434, required = 1, cueSheet = "main:SE/Char_102", cueName = "SE_Char_102_Attack", volume = 40}
, 
[1435] = {id = 1435, required = 1, cueSheet = "main:SE/Char_102", cueName = "SE_Char_102_Skill1", volume = 40}
, 
[1436] = {id = 1436, required = 1, cueSheet = "main:SE/Char_102", cueName = "SE_Char_102_Skill1_L2", volume = 40}
, 
[1437] = {id = 1437, required = 1, cueSheet = "main:SE/Char_102", cueName = "SE_Char_102_Skill1_L3", volume = 40}
, 
[1438] = {id = 1438, required = 1, cueSheet = "main:SE/Char_102", cueName = "SE_Char_102_Skill1_L4", volume = 40}
, 
[1439] = {id = 1439, required = 1, cueSheet = "main:SE/Char_102", cueName = "SE_Char_102_Skill2", volume = 40}
, 
[1440] = {id = 1440, required = 1, cueSheet = "main:SE/Char_084", cueName = "SE_Char_084_Attack", volume = 40}
, 
[1441] = {id = 1441, required = 1, cueSheet = "main:SE/Char_084", cueName = "SE_Char_084_Skill1", volume = 40}
, 
[1442] = {id = 1442, required = 1, cueSheet = "main:SE/Char_084", cueName = "SE_Char_084_Skill1_Fly", volume = 40}
, 
[1443] = {id = 1443, required = 1, cueSheet = "main:SE/Char_084", cueName = "SE_Char_084_Skill1_Hit", volume = 40}
, 
[1444] = {id = 1444, required = 1, cueSheet = "main:SE/Char_084", cueName = "SE_Char_084_Skill2", volume = 40}
, 
[1445] = {id = 1445, required = 1, cueSheet = "main:SE/Char_085", cueName = "SE_Char_085_Attack", volume = 40}
, 
[1446] = {id = 1446, required = 1, cueSheet = "main:SE/Char_085", cueName = "SE_Char_085_Skill1", volume = 40}
, 
[1447] = {id = 1447, required = 1, cueSheet = "main:SE/Char_085", cueName = "SE_Char_085_Skill1_Buff", volume = 40}
, 
[1448] = {id = 1448, required = 1, cueSheet = "main:SE/Char_085", cueName = "SE_Char_085_Skill1_L2", volume = 40}
, 
[1449] = {id = 1449, required = 1, cueSheet = "main:SE/Char_085", cueName = "SE_Char_085_Skill2", volume = 40}
, 
[1450] = {id = 1450, required = 1, cueSheet = "main:SE/Char_085", cueName = "SE_Char_085_Skill3", volume = 40}
, 
[1451] = {id = 1451, required = 1, cueSheet = "main:SE/Char_085", cueName = "SE_Char_085_Skill3_L2", volume = 40}
, 
[1452] = {id = 1452, required = 1, cueSheet = "main:SE/Boss_w6_3", cueName = "SE_Boss_w6_3_Magic1", volume = 40}
, 
[1453] = {id = 1453, required = 1, cueSheet = "main:SE/Boss_w6_3", cueName = "SE_Boss_w6_3_Magic2", volume = 40}
, 
[1454] = {id = 1454, required = 1, cueSheet = "main:SE/Boss_w6_3", cueName = "SE_Boss_w6_3_Magic3", volume = 40}
, 
[1455] = {id = 1455, required = 1, cueSheet = "main:SE/Boss_w6_3", cueName = "SE_Boss_w6_3_Magic4", volume = 40}
, 
[1456] = {id = 1456, required = 1, cueSheet = "main:SE/Boss_w6_3", cueName = "SE_Boss_w6_3_Magic5", volume = 40}
, 
[1457] = {id = 1457, required = 1, cueSheet = "main:SE/Boss_w6_3", cueName = "SE_Boss_w6_3_Magic6", volume = 40}
, 
[1458] = {id = 1458, required = 1, cueSheet = "main:SE/Boss_w6_3", cueName = "SE_Boss_w6_3_Magic7", volume = 40}
, 
[1459] = {id = 1459, required = 1, cueSheet = "main:SE/Char_094", cueName = "SE_Char_094_Attack", volume = 40}
, 
[1460] = {id = 1460, required = 1, cueSheet = "main:SE/Char_094", cueName = "SE_Char_094_Skill1_1", volume = 40}
, 
[1461] = {id = 1461, required = 1, cueSheet = "main:SE/Char_094", cueName = "SE_Char_094_Skill1_2", volume = 40}
, 
[1462] = {id = 1462, required = 1, cueSheet = "main:SE/Char_094", cueName = "SE_Char_094_Skill2_1", volume = 40}
, 
[1463] = {id = 1463, required = 1, cueSheet = "main:SE/Char_094", cueName = "SE_Char_094_Skill2_2", volume = 40}
, 
[1464] = {id = 1464, required = 1, cueSheet = "main:SE/Char_101", cueName = "SE_Char_101_Attack", volume = 40}
, 
[1465] = {id = 1465, required = 1, cueSheet = "main:SE/Char_101", cueName = "SE_Char_101_Skill1_1", volume = 40}
, 
[1466] = {id = 1466, required = 1, cueSheet = "main:SE/Char_101", cueName = "SE_Char_101_Skill2_1", volume = 40}
, 
[1467] = {id = 1467, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_12_Attack", volume = 40}
, 
[1468] = {id = 1468, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_12_Magic", volume = 40}
, 
[1469] = {id = 1469, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_12_Magic2", volume = 40}
, 
[1470] = {id = 1470, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_12_Magic3", volume = 40}
, 
[1471] = {id = 1471, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_14_Magic", volume = 40}
, 
[1472] = {id = 1472, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_15_Magic", volume = 40}
, 
[1473] = {id = 1473, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_16_Attac", volume = 40}
, 
[1474] = {id = 1474, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_16_Magic", volume = 40}
, 
[1475] = {id = 1475, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_52_Attack", volume = 40}
, 
[1476] = {id = 1476, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_52_Magic", volume = 40}
, 
[1477] = {id = 1477, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_53_Attack", volume = 40}
, 
[1478] = {id = 1478, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_53_Magic", volume = 40}
, 
[1479] = {id = 1479, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_54_Attack", volume = 40}
, 
[1480] = {id = 1480, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_54_Magic", volume = 40}
, 
[1481] = {id = 1481, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_m01_Magic", volume = 40}
, 
[1482] = {id = 1482, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_m01_Magic_hit", volume = 40}
, 
[1483] = {id = 1483, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_m01_Magic2", volume = 40}
, 
[1484] = {id = 1484, required = 1, cueSheet = "main:SE/Mon_w6", cueName = "SE_mon_w6_04_Magic", volume = 40}
, 
[1485] = {id = 1485, required = 1, cueSheet = "main:SE/Mon_w6", cueName = "SE_mon_w6_04_Magic2", volume = 40}
, 
[1486] = {id = 1486, required = 1, cueSheet = "main:SE/Mon_w6", cueName = "SE_mon_w6_04_Magic3", volume = 40}
, 
[1487] = {id = 1487, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_25_Magic", volume = 40}
, 
[1488] = {id = 1488, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_25_Magic2", volume = 40}
, 
[1489] = {id = 1489, required = 1, cueSheet = "main:SE/Mon_w3", cueName = "SE_mon_w3_25_Magic3", volume = 40}
, 
[1490] = {id = 1490, required = 1, cueSheet = "main:SE/Boss_w6_4", cueName = "SE_boss_w6_4_Magic", volume = 40}
, 
[1491] = {id = 1491, required = 1, cueSheet = "main:SE/Boss_w6_4", cueName = "SE_boss_w6_4_Magic2", volume = 40}
, 
[1492] = {id = 1492, required = 1, cueSheet = "main:SE/Boss_w6_4", cueName = "SE_boss_w6_4_Magic3", volume = 40}
, 
[1493] = {id = 1493, required = 1, cueSheet = "main:SE/Boss_w6_4", cueName = "SE_boss_w6_4_Magic4", volume = 40}
, 
[1494] = {id = 1494, required = 1, cueSheet = "main:SE/Boss_w6_4", cueName = "SE_boss_w6_4_Magic5", volume = 40}
, 
[1495] = {id = 1495, required = 1, cueSheet = "main:SE/Char_097", cueName = "SE_Char_097_Attack", volume = 40}
, 
[1496] = {id = 1496, required = 1, cueSheet = "main:SE/Char_097", cueName = "SE_Char_097_Skill1_1", volume = 40}
, 
[1497] = {id = 1497, required = 1, cueSheet = "main:SE/Char_097", cueName = "SE_Char_097_Skill2_1", volume = 40}
, 
[1498] = {id = 1498, required = 1, cueSheet = "main:SE/Boss_w6_1", cueName = "SE_boss_w6_1_Attack", volume = 40}
, 
[1499] = {id = 1499, required = 1, cueSheet = "main:SE/Boss_w6_1", cueName = "SE_boss_w6_1_Magic", volume = 40}
, 
[1500] = {id = 1500, required = 1, cueSheet = "main:SE/Boss_w6_1", cueName = "SE_boss_w6_1_Magic2", volume = 40}
, 
[1501] = {id = 1501, required = 1, cueSheet = "main:SE/Boss_w6_1", cueName = "SE_boss_w6_1_Magic3", volume = 40}
, 
[1502] = {id = 1502, required = 1, cueSheet = "main:SE/Boss_w6_1", cueName = "SE_boss_w6_2_Magic", volume = 40}
, 
[1503] = {id = 1503, required = 1, cueSheet = "main:SE/Boss_w6_1", cueName = "SE_boss_w6_2_Magic2", volume = 40}
, 
[1504] = {id = 1504, required = 1, cueSheet = "main:SE/Boss_w6_1", cueName = "SE_boss_w6_2_Magic3", volume = 40}
, 
[1505] = {id = 1505, required = 1, cueSheet = "main:SE/Boss_w6_1", cueName = "SE_boss_w6_2_Magic4", volume = 40}
, 
[1506] = {id = 1506, required = 1, cueSheet = "main:SE/Boss_w6_1", cueName = "SE_boss_w6_4_Magic5", volume = 40}
, 
[1507] = {id = 1507, required = 1, cueSheet = "main:SE/Boss_Char_023", cueName = "SE_Char_023_Magic2", volume = 40}
, 
[1508] = {id = 1508, required = 1, cueSheet = "main:SE/Boss_Char_023", cueName = "SE_Char_023_Magic3", volume = 40}
, 
[1509] = {id = 1509, required = 1, cueSheet = "main:SE/Char_088", cueName = "SE_Char_088_Attack", volume = 40}
, 
[1510] = {id = 1510, required = 1, cueSheet = "main:SE/Char_088", cueName = "SE_Char_088_Skill1", volume = 40}
, 
[1511] = {id = 1511, required = 1, cueSheet = "main:SE/Char_088", cueName = "SE_Char_088_Skill2", volume = 40}
, 
[1512] = {id = 1512, required = 1, cueSheet = "main:SE/Char_112", cueName = "SE_Char_112_Attack", volume = 40}
, 
[1513] = {id = 1513, required = 1, cueSheet = "main:SE/Char_112", cueName = "SE_Char_112_Skill1", volume = 40}
, 
[1514] = {id = 1514, required = 1, cueSheet = "main:SE/Char_112", cueName = "SE_Char_112_Skill2", volume = 40}
, 
[1515] = {id = 1515, required = 1, cueSheet = "main:SE/Char_112", cueName = "SE_Char_112_Skill3", volume = 40}
, 
[1516] = {id = 1516, required = 1, cueSheet = "main:SE/Char_104", cueName = "SE_Char_104_Attack", volume = 40}
, 
[1517] = {id = 1517, required = 1, cueSheet = "main:SE/Char_104", cueName = "SE_Char_104_Skill1", volume = 40}
, 
[1518] = {id = 1518, required = 1, cueSheet = "main:SE/Char_104", cueName = "SE_Char_104_Skill2", volume = 40}
, 
[1519] = {id = 1519, required = 1, cueSheet = "main:SE/Char_120", cueName = "SE_Char_120_Attack", volume = 40}
, 
[1520] = {id = 1520, required = 1, cueSheet = "main:SE/Char_120", cueName = "SE_Char_120_Skill1", volume = 40}
, 
[1521] = {id = 1521, required = 1, cueSheet = "main:SE/Char_120", cueName = "SE_Char_120_Skill2", volume = 40}
, 
[1522] = {id = 1522, required = 1, cueSheet = "main:SE/Char_120", cueName = "SE_Char_120_Skill3", volume = 40}
, 
[1523] = {id = 1523, required = 1, cueSheet = "main:SE/Char_113", cueName = "SE_Char_113_Attack", volume = 40}
, 
[1524] = {id = 1524, required = 1, cueSheet = "main:SE/Char_113", cueName = "SE_Char_113_Skill1", volume = 40}
, 
[1525] = {id = 1525, required = 1, cueSheet = "main:SE/Char_113", cueName = "SE_Char_113_Skill2", volume = 40}
, 
[1526] = {id = 1526, required = 1, cueSheet = "main:SE/Char_111", cueName = "SE_Char_111_Attack", volume = 40}
, 
[1527] = {id = 1527, required = 1, cueSheet = "main:SE/Char_111", cueName = "SE_Char_111_Skill1", volume = 40}
, 
[1528] = {id = 1528, required = 1, cueSheet = "main:SE/Char_111", cueName = "SE_Char_111_Skill2", volume = 40}
, 
[1529] = {id = 1529, required = 1, cueSheet = "main:SE/Mon_w3_40", cueName = "SE_mon_w3_40_Magic", volume = 40}
, 
[1530] = {id = 1530, required = 1, cueSheet = "main:SE/Mon_w3_40", cueName = "SE_mon_w3_40_Magic2", volume = 40}
, 
[1531] = {id = 1531, required = 1, cueSheet = "main:SE/Mon_w3_40", cueName = "SE_mon_w3_40_Magic3", volume = 40}
, 
[1532] = {id = 1532, required = 1, cueSheet = "main:SE/Mon_w3_40", cueName = "SE_mon_w3_40_p2_Magic", volume = 40}
, 
[1533] = {id = 1533, required = 1, cueSheet = "main:SE/Mon_w3_40", cueName = "SE_mon_w3_40_p2_Magic2", volume = 40}
, 
[1534] = {id = 1534, required = 1, cueSheet = "main:SE/Mon_w3_40", cueName = "SE_mon_w3_40_p2_Magic3", volume = 40}
, 
[1535] = {id = 1535, required = 1, cueSheet = "main:SE/Mon_w3_40", cueName = "SE_mon_w3_40_p2_Magic4", volume = 40}
, 
[1536] = {id = 1536, required = 1, cueSheet = "main:SE/Char_109", cueName = "SE_Char_109_Attack", volume = 40}
, 
[1537] = {id = 1537, required = 1, cueSheet = "main:SE/Char_109", cueName = "SE_Char_109_Skill1", volume = 40}
, 
[1538] = {id = 1538, required = 1, cueSheet = "main:SE/Char_109", cueName = "SE_Char_109_Skill2", volume = 40}
, 
[1539] = {id = 1539, required = 1, cueSheet = "main:SE/Char_115", cueName = "SE_Char_115_Attack", volume = 40}
, 
[1540] = {id = 1540, required = 1, cueSheet = "main:SE/Char_115", cueName = "SE_Char_115_Skill1", volume = 40}
, 
[1541] = {id = 1541, required = 1, cueSheet = "main:SE/Char_115", cueName = "SE_Char_115_Skill2", volume = 40}
, 
[1542] = {id = 1542, required = 1, cueSheet = "main:SE/Char_098", cueName = "SE_Char_098_Attack", volume = 40}
, 
[1543] = {id = 1543, required = 1, cueSheet = "main:SE/Char_098", cueName = "SE_Char_098_Skill1", volume = 40}
, 
[1544] = {id = 1544, required = 1, cueSheet = "main:SE/Char_098", cueName = "SE_Char_098_Skill2", volume = 40}
, 
[1545] = {id = 1545, required = 1, cueSheet = "main:SE/Char_119", cueName = "SE_Char_119_Attack", volume = 40}
, 
[1546] = {id = 1546, required = 1, cueSheet = "main:SE/Char_119", cueName = "SE_Char_119_Skill1", volume = 40}
, 
[1547] = {id = 1547, required = 1, cueSheet = "main:SE/Char_119", cueName = "SE_Char_119_Skill2", volume = 40}
, 
[1548] = {id = 1548, required = 1, cueSheet = "main:SE/Char_105", cueName = "SE_Char_105_Attack", volume = 40}
, 
[1549] = {id = 1549, required = 1, cueSheet = "main:SE/Char_105", cueName = "SE_Char_105_Skill1", volume = 40}
, 
[1550] = {id = 1550, required = 1, cueSheet = "main:SE/Char_105", cueName = "SE_Char_105_Skill2", volume = 40}
, 
[1551] = {id = 1551, required = 1, cueSheet = "main:SE/Char_107", cueName = "SE_Char_107_Attack", volume = 40}
, 
[1552] = {id = 1552, required = 1, cueSheet = "main:SE/Char_107", cueName = "SE_Char_107_Skill1", volume = 40}
, 
[1553] = {id = 1553, required = 1, cueSheet = "main:SE/Char_107", cueName = "SE_Char_107_Skill2", volume = 40}
}
csoundsource.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556, 557, 558, 559, 560, 561, 562, 563, 564, 565, 566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611, 612, 613, 614, 615, 616, 617, 618, 619, 620, 621, 622, 623, 624, 625, 626, 627, 628, 629, 630, 631, 632, 633, 634, 635, 636, 637, 638, 639, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 655, 656, 657, 658, 659, 660, 661, 662, 663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685, 686, 687, 688, 689, 690, 691, 692, 693, 694, 695, 696, 697, 698, 699, 700, 701, 702, 703, 704, 705, 706, 707, 708, 709, 710, 711, 712, 713, 714, 715, 716, 717, 718, 719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 729, 730, 731, 732, 733, 734, 735, 736, 737, 738, 739, 740, 741, 742, 743, 744, 745, 746, 747, 748, 749, 750, 751, 752, 753, 754, 755, 756, 757, 758, 759, 760, 761, 762, 763, 764, 765, 766, 767, 768, 769, 770, 771, 772, 773, 774, 775, 776, 777, 778, 779, 780, 781, 782, 783, 784, 785, 794, 795, 796, 797, 798, 799, 800, 801, 802, 803, 804, 805, 806, 807, 808, 809, 810, 811, 812, 813, 814, 815, 816, 817, 818, 819, 820, 821, 822, 823, 824, 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835, 836, 837, 838, 839, 840, 841, 842, 843, 844, 845, 846, 847, 848, 849, 850, 851, 852, 853, 854, 855, 856, 857, 858, 859, 860, 861, 862, 863, 864, 865, 866, 867, 868, 869, 870, 871, 872, 875, 876, 877, 878, 879, 880, 881, 882, 883, 884, 885, 886, 887, 888, 889, 890, 891, 892, 893, 894, 895, 896, 897, 898, 899, 900, 901, 902, 903, 904, 905, 906, 907, 908, 909, 910, 911, 912, 913, 914, 915, 916, 917, 918, 919, 920, 921, 922, 923, 924, 925, 926, 927, 928, 929, 930, 931, 932, 933, 934, 935, 936, 938, 939, 940, 941, 942, 943, 944, 945, 946, 947, 948, 949, 950, 951, 952, 953, 954, 955, 956, 957, 958, 959, 960, 961, 962, 963, 964, 965, 966, 967, 968, 969, 970, 971, 972, 973, 974, 975, 976, 977, 978, 979, 980, 981, 982, 983, 984, 985, 986, 987, 988, 989, 990, 991, 992, 993, 994, 995, 996, 997, 998, 999, 1000, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1035, 1036, 1037, 1038, 1039, 1040, 1041, 1042, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051, 1052, 1053, 1054, 1055, 1056, 1057, 1058, 1059, 1060, 1061, 1062, 1063, 1064, 1065, 1066, 1067, 1068, 1069, 1070, 1071, 1072, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1088, 1089, 1090, 1091, 1092, 1093, 1094, 1095, 1096, 1097, 1098, 1099, 1100, 1101, 1102, 1103, 1104, 1105, 1106, 1107, 1108, 1109, 1110, 1111, 1112, 1113, 1114, 1115, 1116, 1117, 1118, 1119, 1120, 1121, 1122, 1123, 1124, 1125, 1126, 1127, 1128, 1129, 1130, 1131, 1132, 1133, 1134, 1135, 1136, 1137, 1138, 1139, 1140, 1141, 1142, 1143, 1144, 1145, 1146, 1147, 1148, 1149, 1150, 1151, 1152, 1153, 1154, 1155, 1156, 1157, 1158, 1159, 1160, 1161, 1162, 1163, 1164, 1165, 1166, 1167, 1168, 1169, 1170, 1171, 1172, 1173, 1174, 1175, 1176, 1177, 1178, 1179, 1180, 1181, 1182, 1183, 1184, 1185, 1186, 1187, 1188, 1189, 1190, 1191, 1192, 1193, 1194, 1195, 1196, 1197, 1198, 1199, 1200, 1201, 1202, 1203, 1204, 1205, 1206, 1207, 1208, 1209, 1210, 1211, 1212, 1213, 1214, 1215, 1216, 1217, 1218, 1219, 1220, 1221, 1222, 1223, 1224, 1225, 1226, 1227, 1228, 1229, 1230, 1231, 1232, 1233, 1234, 1235, 1236, 1237, 1238, 1239, 1240, 1241, 1242, 1243, 1244, 1245, 1246, 1247, 1248, 1249, 1250, 1251, 1252, 1253, 1254, 1255, 1256, 1257, 1258, 1259, 1260, 1261, 1262, 1263, 1264, 1265, 1266, 1267, 1268, 1269, 1270, 1271, 1272, 1273, 1274, 1275, 1276, 1277, 1278, 1279, 1280, 1281, 1282, 1283, 1284, 1285, 1286, 1287, 1288, 1289, 1290, 1291, 1292, 1293, 1294, 1295, 1296, 1297, 1298, 1299, 1300, 1301, 1302, 1303, 1304, 1305, 1306, 1307, 1308, 1309, 1310, 1311, 1312, 1313, 1314, 1315, 1316, 1317, 1318, 1319, 1320, 1321, 1322, 1323, 1324, 1325, 1326, 1327, 1328, 1329, 1330, 1331, 1332, 1333, 1334, 1335, 1336, 1337, 1338, 1339, 1340, 1341, 1342, 1343, 1344, 1345, 1346, 1347, 1348, 1349, 1350, 1351, 1352, 1353, 1354, 1355, 1356, 1357, 1358, 1359, 1360, 1361, 1362, 1363, 1364, 1365, 1366, 1367, 1368, 1369, 1370, 1371, 1372, 1373, 1374, 1375, 1376, 1377, 1378, 1379, 1380, 1381, 1382, 1383, 1384, 1385, 1386, 1387, 1388, 1389, 1390, 1391, 1392, 1393, 1394, 1395, 1396, 1397, 1398, 1399, 1400, 1401, 1402, 1403, 1404, 1405, 1406, 1407, 1408, 1409, 1410, 1411, 1412, 1413, 1414, 1415, 1416, 1417, 1418, 1419, 1420, 1421, 1422, 1423, 1424, 1425, 1426, 1427, 1428, 1429, 1430, 1431, 1432, 1433, 1434, 1435, 1436, 1437, 1438, 1439, 1440, 1441, 1442, 1443, 1444, 1445, 1446, 1447, 1448, 1449, 1450, 1451, 1452, 1453, 1454, 1455, 1456, 1457, 1458, 1459, 1460, 1461, 1462, 1463, 1464, 1465, 1466, 1467, 1468, 1469, 1470, 1471, 1472, 1473, 1474, 1475, 1476, 1477, 1478, 1479, 1480, 1481, 1482, 1483, 1484, 1485, 1486, 1487, 1488, 1489, 1490, 1491, 1492, 1493, 1494, 1495, 1496, 1497, 1498, 1499, 1500, 1501, 1502, 1503, 1504, 1505, 1506, 1507, 1508, 1509, 1510, 1511, 1512, 1513, 1514, 1515, 1516, 1517, 1518, 1519, 1520, 1521, 1522, 1523, 1524, 1525, 1526, 1527, 1528, 1529, 1530, 1531, 1532, 1533, 1534, 1535, 1536, 1537, 1538, 1539, 1540, 1541, 1542, 1543, 1544, 1545, 1546, 1547, 1548, 1549, 1550, 1551, 1552, 1553}
return csoundsource

