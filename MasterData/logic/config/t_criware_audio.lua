-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_criware_audio.lua

module("logic.config.t_criware_audio", package.seeall)

local title = {
	awbName = 4,
	code = 1,
	acbName = 3,
	cueName = 2
}
local dataList = {
	{
		900001,
		"amb_spaces_room",
		"amb.acb",
		""
	},
	{
		900002,
		"amb_juqing_OADzhukong",
		"amb.acb",
		""
	},
	{
		900003,
		"amb_juqing_aerfadibiao",
		"amb.acb",
		""
	},
	{
		900004,
		"amb_juqing_aerfadixiashi",
		"amb.acb",
		""
	},
	{
		900005,
		"amb_juqing_aerfafeixu",
		"amb.acb",
		""
	},
	{
		900006,
		"amb_juqing_aerfagongchang",
		"amb.acb",
		""
	},
	{
		900007,
		"amb_juqing_beihailianmeng",
		"amb.acb",
		""
	},
	{
		900008,
		"amb_juqing_chengshibianyuan",
		"amb.acb",
		""
	},
	{
		900009,
		"amb_juqing_feichuanzoulang",
		"amb.acb",
		""
	},
	{
		900010,
		"amb_juqing_muyuanRain",
		"amb.acb",
		""
	},
	{
		900011,
		"amb_juqing_muyuanSunny",
		"amb.acb",
		""
	},
	{
		900012,
		"amb_juqing_shangyejie",
		"amb.acb",
		""
	},
	{
		900013,
		"amb_juqing_yishikongjianshiti",
		"amb.acb",
		""
	},
	{
		900014,
		"amb_juqing_beifengzhen",
		"amb.acb",
		""
	},
	{
		900015,
		"amb_juqing_shangyejieDaytime",
		"amb.acb",
		""
	},
	{
		900016,
		"amb_juqing_shangyejieNight",
		"amb.acb",
		""
	},
	{
		900017,
		"amb_juqing_tingshiDaytime",
		"amb.acb",
		""
	},
	{
		900018,
		"amb_juqing_tingshiNight",
		"amb.acb",
		""
	},
	{
		900019,
		"amb_changjing_haitan",
		"amb.acb",
		""
	},
	{
		900020,
		"amb_changjing_chouka",
		"amb.acb",
		""
	},
	{
		900021,
		"amb_changjing_chouka_search_02",
		"amb.acb",
		""
	},
	{
		900022,
		"amb_changjing_chouka_search_01",
		"amb.acb",
		""
	},
	{
		900023,
		"amb_changjing_haitan_echo",
		"amb.acb",
		""
	},
	{
		900024,
		"amb_battle_city_rain",
		"amb.acb",
		""
	},
	{
		900025,
		"amb_battle_OAD",
		"amb.acb",
		""
	},
	{
		900026,
		"amb_battle_beihaifeiqikuangqu",
		"amb.acb",
		""
	},
	{
		900027,
		"amb_battle_beijicanhai",
		"amb.acb",
		""
	},
	{
		900028,
		"amb_battle_feiqigongchang",
		"amb.acb",
		""
	},
	{
		900029,
		"amb_battle_yishikongjian",
		"amb.acb",
		""
	},
	{
		100091,
		"skill_120110_Piano_Test",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100100,
		"skill_120004_teqianduizhiyuanbing_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100110,
		"skill_120110_Piano_01",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100111,
		"skill_120110_Piano_02",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100112,
		"skill_120110_Piano_03",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100113,
		"skill_100005_huanxing_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100114,
		"skill_100005_huanxing_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100115,
		"skill_100005_huanxing_unique_1_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100116,
		"skill_100005_huanxing_unique_2_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100117,
		"skill_100008_liufenyi_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100118,
		"skill_100011_yiyun_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100119,
		"skill_100011_yiyun_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100120,
		"skill_100011_yiyun_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100121,
		"skill_100012_fenlier_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100122,
		"skill_100012_fenlier_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100123,
		"skill_100012_fenlier_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100124,
		"skill_100013_anniwei_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100125,
		"skill_100013_anniwei_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100126,
		"skill_100013_anniwei_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100127,
		"skill_100016_yanhuo_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100128,
		"skill_100016_yanhuo_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100129,
		"skill_100016_yanhuo_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100130,
		"skill_100019_duolian_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100131,
		"skill_100019_duolian_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100132,
		"skill_100020_anbuleila_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100133,
		"skill_100020_anbuleila_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100135,
		"skill_100021_muxue_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100136,
		"skill_100022_feiniao_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100137,
		"skill_100022_feiniao_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100138,
		"skill_100022_feiniao_aim_start_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100139,
		"skill_100022_feiniao_unique_1_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100140,
		"skill_100028_chuang_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100143,
		"skill_100036_duoluoxi_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100144,
		"skill_100036_duoluoxi_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100145,
		"skill_100036_duoluoxi_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100146,
		"skill_100039_yilishabai_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100147,
		"skill_100039_yilishabai_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100148,
		"skill_100039_yilishabai_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100149,
		"skill_100041_xinderuila_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100150,
		"skill_100041_xinderuila_attack_anti_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100151,
		"skill_100041_xinderuila_unique2_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100152,
		"skill_100041_xinderuila_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100153,
		"skill_100043_ya_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100154,
		"skill_100043_ya_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100155,
		"skill_100043_ya_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100156,
		"skill_100047_aojieta_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100157,
		"skill_100053_aniya_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100158,
		"skill_100053_aniya_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100159,
		"skill_100053_aniya_unique_1_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100160,
		"skill_100053_aniya_unique_2_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100161,
		"skill_100055_geligaolie_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100162,
		"skill_100055_geligaolie_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100163,
		"skill_100056_tiya_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100164,
		"skill_100056_tiya_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100165,
		"skill_100056_tiya_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100166,
		"skill_100057_edipusi_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100167,
		"skill_100057_edipusi_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100168,
		"skill_100057_edipusi_cast_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100169,
		"skill_100057_edipusi_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100170,
		"skill_100012_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100171,
		"skill_100013_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100172,
		"skill_100016_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100173,
		"skill_100020_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100174,
		"skill_100022_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100175,
		"skill_100036_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100176,
		"skill_100039_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100177,
		"skill_100041_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100178,
		"skill_100043_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100179,
		"skill_100047_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100180,
		"skill_100053_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100181,
		"skill_100056_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100182,
		"skill_120001_teqianduishouweibing_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100183,
		"skill_120003_teqianduijujibing_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100184,
		"skill_120003_teqianduijujibing_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100185,
		"skill_120005_teqianduiyunmiebing_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100186,
		"skill_120005_teqianduiyunmiebing_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100187,
		"skill_120007_miwushitushouweibing_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100188,
		"skill_120008_miwushitujujibing_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100189,
		"skill_120009_miwushituzhiyuanbing_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100190,
		"skill_120010_miwushituyunmiebing_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100191,
		"skill_120010_miwushituyunmiebing_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100192,
		"skill_120012_gros_jiguang_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100193,
		"skill_120012_gros_jiguang_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100194,
		"skill_120014_gros_jianjia_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100195,
		"skill_120015_gros_liren_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100196,
		"skill_120016_gros_shaobing_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100197,
		"skill_120017_gros_lieshizhe_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100198,
		"skill_120017_gros_lieshizhe_break_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100199,
		"skill_120017_gros_lieshizhe_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100200,
		"skill_120017_gros_lieshizhe_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100201,
		"skill_120026_buxiu_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100202,
		"skill_120026_buxiu_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100203,
		"skill_120026_buxiu_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100204,
		"skill_120027_xiugesi_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100205,
		"skill_120027_xiugesi_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100206,
		"skill_120027_xiugesi_cast_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100207,
		"skill_120028_buxiuzheyouti_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100208,
		"skill_120029_nishengfuyou_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100209,
		"skill_120030_dijipinang_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100210,
		"skill_120031_chuanshujingguan_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100211,
		"skill_120033_xulie_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100212,
		"skill_120034_teqianduiteyibing_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100213,
		"skill_120035_miwushituteyibing_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100214,
		"skill_120037_ailisibenti_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100215,
		"skill_1203803_01",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100216,
		"skill_1203803_02",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100217,
		"skill_1203803_03",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100219,
		"skill_120038_mieshi_l_hand_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100221,
		"skill_120045_shuidihuanying_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100222,
		"skill_120046_shuidishouwei_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100223,
		"skill_120047_shuidijuji_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100224,
		"skill_120048_shuidizhiyuan_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100225,
		"skill_120048_shuidizhiyuan_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100226,
		"skill_120049_shuidiyunmie_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100227,
		"skill_120049_shuidiyunmie_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100228,
		"skill_120050_shuiditeyi_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100229,
		"skill_1207901",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100230,
		"skill_120080_lanpaopao_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100231,
		"skill_120083_gros_dashuijing_special1_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100232,
		"skill_120083_gros_dashuijing_special2_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100233,
		"skill_120083_gros_dashuijing_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100234,
		"skill_120084_gros_xiaoshuijing_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100235,
		"skill_120087_ruchongfangyingji_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100238,
		"skill_1208703_01_sp",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100239,
		"skill_1208703_01_01_sp",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100240,
		"skill_120087_ruchongfangyingji_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100241,
		"skill_120088_kuanghuanludeng_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100242,
		"skill_120088_kuanghuanludeng_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100243,
		"skill_120090_xuegaotongjiaoshou_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100244,
		"skill_120091_eyunyugao_special1_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100245,
		"skill_120091_eyunyugao_special2",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100246,
		"skill_120091_eyunyugao_special3",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100247,
		"skill_120092_jianbudeguangdediaoxiang_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100274,
		"skill_120026_buxiu_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100275,
		"skill_120026_buxiu_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100276,
		"skill_120026_buxiu_cast_special",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100277,
		"skill_120026_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100278,
		"speech_120026_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100280,
		"skill_120026_buxiu_idle1",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100281,
		"skill_120027_xiugesi_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100282,
		"skill_120027_xiugesi_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100283,
		"skill_120027_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100284,
		"speech_120027_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100285,
		"skill_120027_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100286,
		"skill_120028_buxiuzheyouti_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100287,
		"skill_120028_buxiuzheyouti_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100288,
		"skill_120028_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100289,
		"speech_120028_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100292,
		"skill_120028_buxiuzheyouti_idle1",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100293,
		"skill_120028_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100294,
		"skill_120029_nishengfuyou_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100295,
		"skill_120029_nishengfuyou_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100296,
		"skill_120029_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100297,
		"speech_120029_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100300,
		"skill_120029_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100301,
		"skill_120030_dijipinang_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100302,
		"skill_120030_dijipinang_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100303,
		"skill_120030_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100304,
		"speech_120030_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100307,
		"skill_120030_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100308,
		"skill_120031_chuangshujinguan_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100309,
		"skill_120031_chuangshujinguan_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100310,
		"skill_120031_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100311,
		"speech_120031_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100314,
		"skill_120031_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100322,
		"skill_120045_shuidihuanying_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100323,
		"skill_120045_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100324,
		"skill_120045_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100325,
		"skill_120045_hit",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100328,
		"skill_120045_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100329,
		"skill_120003_teqianduijujibing_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100330,
		"skill_120003_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100331,
		"skill_120003_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100332,
		"skill_120003_hit",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100335,
		"skill_120003_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100336,
		"skill_120008_miwushitujujibing_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100337,
		"skill_120008_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100338,
		"skill_120008_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100339,
		"skill_120008_hit",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100342,
		"skill_120008_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100343,
		"skill_120047_shuidijuji_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100344,
		"skill_120047_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100345,
		"skill_120047_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100346,
		"skill_120047_hit",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100349,
		"skill_120047_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100350,
		"skill_120001_teqianduishouweibing_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100351,
		"skill_120001_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100352,
		"skill_120001_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100353,
		"skill_120001_hit",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100356,
		"skill_120001_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100357,
		"skill_120007_miwushitushouweibing_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100358,
		"skill_120007_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100359,
		"skill_120007_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100360,
		"skill_120007_hit",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100363,
		"skill_120007_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100364,
		"skill_120046_shuidishouwei_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100365,
		"skill_120046_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100366,
		"skill_120046_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100367,
		"skill_120046_hit",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100370,
		"skill_120046_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100371,
		"skill_120034_teqianduiteyibing_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100372,
		"skill_120034_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100373,
		"skill_120034_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100374,
		"skill_120034_hit",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100377,
		"skill_120034_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100378,
		"skill_120035_miwushituteyibing_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100379,
		"skill_120035_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100380,
		"skill_120035_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100381,
		"skill_120035_hit",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100384,
		"skill_120035_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100385,
		"skill_120050_shuiditeyi_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100386,
		"skill_120050_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100387,
		"skill_120050_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100388,
		"skill_120050_hit",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100391,
		"skill_120050_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100392,
		"skill_120005_teqianduiyunmiebing_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100393,
		"skill_120005_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100394,
		"skill_120005_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100395,
		"skill_120005_hit",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100398,
		"skill_120005_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100399,
		"skill_120010_miwushituyunmiebing_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100400,
		"skill_120010_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100401,
		"skill_120010_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100402,
		"skill_120010_hit",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100405,
		"skill_120010_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100406,
		"skill_120049_shuidiyunmie_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100407,
		"skill_120049_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100408,
		"skill_120049_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100409,
		"skill_120049_hit",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100412,
		"skill_120049_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100413,
		"skill_120004_teqianduizhiyuanbing_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100414,
		"skill_120004_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100415,
		"skill_120004_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100416,
		"skill_120004_hit",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100419,
		"skill_120004_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100420,
		"skill_120009_miwushituzhiyuanbing_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100421,
		"skill_120009_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100422,
		"skill_120009_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100423,
		"skill_120009_hit",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100426,
		"skill_120009_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100427,
		"skill_120048_shuidizhiyuan_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100428,
		"skill_120048_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100429,
		"skill_120048_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100430,
		"skill_120048_hit",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100433,
		"skill_120048_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100435,
		"skill_kidshoes_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100436,
		"skill_120110_Piano_04",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100437,
		"skill_120110_Piano_05",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100438,
		"skill_120110_Piano_06",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100439,
		"skill_120110_Piano_07",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100440,
		"skill_120110_Piano_Tour",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100441,
		"skill_100057_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100442,
		"skill_100005_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100443,
		"skill_100020_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100444,
		"skill_100021_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100445,
		"skill_100030_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100446,
		"skill_100039_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100447,
		"skill_100043_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100448,
		"skill_100053_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100449,
		"skill_100010_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100450,
		"skill_100015_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100451,
		"skill_100012_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100452,
		"skill_100007_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100453,
		"skill_100013_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100454,
		"skill_100016_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100455,
		"skill_100022_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100456,
		"skill_100047_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100457,
		"skill_100055_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100458,
		"skill_100041_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100459,
		"skill_100028_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100460,
		"skill_100025_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100461,
		"skill_100019_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100462,
		"skill_100008_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100463,
		"skill_100036_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100464,
		"skill_100005_huanxing_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100465,
		"skill_100008_liufenyi_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100466,
		"skill_100011_yiyun_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100467,
		"skill_100012_fenlier_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100468,
		"skill_100013_anniwei_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100469,
		"skill_100016_yanhuo_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100470,
		"skill_100019_duolian_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100471,
		"skill_100020_anbuleila_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100472,
		"skill_100021_muxue_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100473,
		"skill_100022_feiniao_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100474,
		"skill_100025_linhuo_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100475,
		"skill_100028_chuang_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100476,
		"skill_100036_duoluoxi_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100477,
		"skill_100039_yilishabai_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100478,
		"skill_100041_xinderuila_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100479,
		"skill_100043_ya_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100480,
		"skill_100053_aniya_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100481,
		"skill_100055_geligaolie_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100482,
		"skill_100056_tiya_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100483,
		"skill_100057_edipusi_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100484,
		"skill_100056_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100485,
		"skill_100011_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100486,
		"skill_100007_oujilide_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100487,
		"skill_100007_oujilide_unique_1_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100488,
		"skill_100007_oujilide_unique_2_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100489,
		"skill_100010_linxiao_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100490,
		"skill_100010_linxiao_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100491,
		"skill_100010_linxiao_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100492,
		"skill_100015_qimangxing_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100493,
		"skill_100015_qimangxing_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100494,
		"skill_100019_duolian_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100495,
		"skill_100020_anbuleila_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100496,
		"skill_100021_muxue_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100497,
		"skill_100025_linhuo_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100498,
		"skill_100028_chuang_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100499,
		"skill_100030_bobosha_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100500,
		"skill_100030_bobosha_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100501,
		"skill_100030_bobosha_unique_1_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100502,
		"skill_100030_bobosha_unique_2_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100503,
		"skill_100031_kabuqinuo_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100504,
		"skill_100031_kabuqinuo_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100505,
		"skill_100041_xinderuila_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100506,
		"skill_100047_aojieta_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100507,
		"skill_100055_geligaolie_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100508,
		"skill_120089_huajianyusan_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100509,
		"skill_120100_gangqin_refresh",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100510,
		"skill_120100_gangqin_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100511,
		"biaoqian_chaogan_0",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100512,
		"biaoqian_chaogan_1",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100513,
		"biaoqian_chaogan_2",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100514,
		"biaoqian_chaogan_3",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100515,
		"biaoqian_huguang_1",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100516,
		"biaoqian_jiuji_1",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100517,
		"biaoqian_jiuji_2",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100518,
		"biaoqian_jiuji_3",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100519,
		"biaoqian_jiuji_body",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100520,
		"biaoqian_zhendang_1",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100521,
		"biaoqian_zhendang_2",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100522,
		"biaoqian_zhendang_3",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100523,
		"biaoqian_zhengdang_mirror",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100524,
		"biaoqian_zhuici_1",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100525,
		"biaoqian_zhuici_2",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100526,
		"disk_eclipse",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100527,
		"disk_fullmoon",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100528,
		"disk_perception",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100529,
		"disk_pressure",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100530,
		"disk_scarecrow",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100531,
		"disk_warp",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100532,
		"role_outbreak_begin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100533,
		"role_outbreak_burst",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100534,
		"role_outbreak_loop",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100535,
		"terrains_ceremony_begin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100536,
		"terrains_ceremony_loop",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100537,
		"skill_120038_mieshi_l_hand_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100538,
		"skill_120038_mieshi_l_hand_both_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100540,
		"skill_120038_mieshi_r_hand_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100542,
		"skill_120038_mieshi_special1_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100543,
		"skill_120038_mieshi_special2_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100544,
		"skill_120038_mieshi_special3_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100545,
		"skill_120038_mieshi_unique1_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100546,
		"skill_120038_mieshi_unique2_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100549,
		"skill_120087_ruchongfangyingji_special2_line",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100550,
		"skill_120087_ruchongfangyingji_special1_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100551,
		"skill_120087_ruchongfangyingji_special1_loop",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100552,
		"skill_120087_ruchongfangyingji_special1_broken",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100553,
		"skill_120078_qingtianwawa_p2_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100554,
		"skill_120078_qingtianwawa_p2_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100555,
		"skill_120078_qingtianwawa_p2_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100556,
		"skill_120083_gros_dashuijing_special3_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100557,
		"skill_100008_liufenyi_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100558,
		"skill_100015_qimangxing_unique_1_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100559,
		"skill_100015_qimangxing_unique_2_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100562,
		"skill_100025_linhuo_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100563,
		"skill_100025_linhuo_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100564,
		"skill_120067_gros_chongji_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100565,
		"skill_120068_emeng_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100566,
		"skill_120069_gros_fenyuan_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100567,
		"skill_120069_gros_fenyuan_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100568,
		"skill_120070_gros_kuangre_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100569,
		"skill_120070_gros_kuangre_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100570,
		"skill_120081_yang_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100571,
		"skill_120081_yang_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100572,
		"skill_120082_she_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100573,
		"skill_120097_paihuaizhe_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100574,
		"skill_120098_heisanren_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100575,
		"skill_120098_heisanren_cast_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100576,
		"skill_100005_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100577,
		"skill_100008_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100578,
		"skill_100010_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100579,
		"skill_100015_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100580,
		"skill_100019_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100581,
		"skill_100021_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100582,
		"skill_100025_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100583,
		"skill_100028_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100584,
		"skill_100030_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100585,
		"skill_100031_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100586,
		"skill_100055_cutin",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100587,
		"skill_100010_linxiao_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100588,
		"skill_100015_qimangxing_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100589,
		"skill_100030_bobosha_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100590,
		"skill_100021_muxue_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100591,
		"skill_100028_chuang_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100592,
		"skill_120038_mieshi_r_hand_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100593,
		"skill_120078_qingtianwawa_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100594,
		"skill_120110_Piano_09",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100595,
		"skill_120110_Piano_10",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100596,
		"skill_120110_Piano_11",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100597,
		"skill_120110_Piano_12",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100598,
		"skill_120110_Piano_13",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100599,
		"skill_120110_Piano_14",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100600,
		"skill_120110_Piano_15",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100601,
		"skill_120110_Piano_16",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100602,
		"skill_120110_Piano_17",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100603,
		"biaoqian_duolian_1",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100604,
		"biaoqian_duolian_2",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100605,
		"biaoqian_duolian_3",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100606,
		"biaoqian_fenlier",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100607,
		"biaoqian_geligaolie_1",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100608,
		"biaoqian_geligaolie_2",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100609,
		"biaoqian_geligaolie_3",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100610,
		"biaoqian_huanxing_1",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100611,
		"biaoqian_huanxing_2",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100612,
		"biaoqian_huanxing_3",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100613,
		"biaoqian_huguang",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100614,
		"biaoqian_huguang_feiniao",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100615,
		"biaoqian_xinderuila_1",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100616,
		"biaoqian_xinderuila_2",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100617,
		"biaoqian_xinderuila_3",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100618,
		"biaoqian_yuanhu_curse_1",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100619,
		"biaoqian_yuanhu_curse_2",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100620,
		"biaoqian_yuanhu_curse_3",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100621,
		"scene_attack_missile",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100622,
		"biaoqian_alisi_1",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100623,
		"biaoqian_alisi_2",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100624,
		"biaoqian_alisi_3",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100625,
		"biaoqian_edipusi_circle",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100626,
		"biaoqian_edipusi_line",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100627,
		"skill_100002_ailisi_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100628,
		"skill_100002_ailisi_boss_unique_end_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100629,
		"skill_100002_ailisi_boss_unique_start_1_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100630,
		"skill_100002_ailisi_boss_unique_start_2_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100631,
		"skill_100002_ailisi_special_3_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100632,
		"skill_100002_ailisi_unique_1_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100633,
		"skill_100002_ailisi_unique_2_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100634,
		"skill_100002_ailisi_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100635,
		"skill_100011_yiyun_biaoqian_1_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100636,
		"skill_100011_yiyun_biaoqian_2_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100637,
		"skill_100011_yiyun_biaoqian_3_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100638,
		"skill_120013_gros_jinran_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100639,
		"skill_120032_gros_zhixingzhe_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100640,
		"skill_120032_gros_zhixingzhe_unique_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100641,
		"skill_120037_ailisibenti_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100642,
		"skill_120037_ailisibenti_change_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100643,
		"skill_120077_paopao_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100644,
		"skill_120077_paopao_special1_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100645,
		"skill_120077_paopao_special2_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100646,
		"skill_120077_paopao_special3_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100647,
		"skill_120078_qingtianwawa_p2_run_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100648,
		"skill_120078_qingtianwawa_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100649,
		"skill_120080_lanpaopao_cast_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100650,
		"skill_120093_zicaiqiqiu_attack_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100651,
		"skill_120094_kongtiaokuangrezhe_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100652,
		"skill_120095_choushuihuasa_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100653,
		"show_100005_huanxing_xiangqing_change_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100654,
		"show_100008_liufenyi_xiangqing_change_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100655,
		"show_100019_duolian_xiangqing_change_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100656,
		"show_100039_yilishabai_xiangqing_change_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100657,
		"skill_120012_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100658,
		"speech_120012_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100659,
		"speech_120012_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100660,
		"skill_120012_gros_jiguang_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100661,
		"skill_120012_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100662,
		"skill_120094_kongtiaokuangrezhe_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100663,
		"skill_120094_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100664,
		"speech_120094_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100665,
		"speech_120094_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100666,
		"skill_120094_kongtiaokuangrezhe_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100667,
		"skill_120095_choushuihuasa_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100668,
		"skill_120095_choushuihuasa_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100669,
		"skill_120095_choushuihuasa_special",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100670,
		"skill_120095_die ",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100671,
		"speech_120095_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100672,
		"speech_120095_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100673,
		"skill_120097_paihuaizhe_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100674,
		"skill_120097_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100675,
		"speech_120097_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100676,
		"speech_120097_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100677,
		"skill_120097_paihuaizhe_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100678,
		"skill_120098_heisanren_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100679,
		"skill_120098_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100680,
		"skill_120098_heisanren_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100681,
		"speech_120098_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100682,
		"speech_120098_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100683,
		"skill_120013_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100684,
		"speech_120013_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100685,
		"speech_120013_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100686,
		"skill_120013_gros_jinran_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100687,
		"skill_120013_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100688,
		"skill_120014_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100689,
		"speech_120014_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100690,
		"speech_120014_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100691,
		"skill_120014_gros_jianjia_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100692,
		"skill_120014_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100693,
		"skill_120015_gros_liren_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100694,
		"skill_120015_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100695,
		"speech_120015_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100696,
		"speech_120015_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100697,
		"skill_120015_gros_liren_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100698,
		"skill_120015_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100699,
		"skill_120016_gros_shaobing_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100700,
		"skill_120016_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100701,
		"speech_120016_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100702,
		"speech_120016_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100703,
		"skill_120016_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100704,
		"skill_120016_gros_shaobing_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100705,
		"skill_120017_gros_lieshizhe_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100706,
		"skill_120017_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100707,
		"speech_120017_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100708,
		"skill_120017_gros_lieshizhe_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100709,
		"skill_120017_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100710,
		"skill_120032_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100711,
		"speech_120032_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100712,
		"skill_120032_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100713,
		"skill_120032_gros_zhixingzhe_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100714,
		"skill_120033_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100715,
		"speech_120033_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100716,
		"speech_120033_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100717,
		"skill_120033_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100718,
		"skill_120033_xulie_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100719,
		"skill_120037_ailisibenti_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100720,
		"skill_120037_ailisibenti_unique",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100721,
		"skill_120037_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100722,
		"speech_120037_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100723,
		"skill_120037_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100724,
		"skill_120038_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100725,
		"skill_120086_jian_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100726,
		"speech_120086_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100727,
		"speech_120086_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100728,
		"skill_120086_jian_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100729,
		"skill_120086_jian_break_special",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100730,
		"skill_120086_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100731,
		"skill_120088_kuanghuanludeng_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100732,
		"skill_120088_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100733,
		"speech_120088_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100734,
		"speech_120088_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100735,
		"skill_120088_kuanghuanludeng_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100736,
		"skill_120088_kuanghuanludeng_special",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100737,
		"skill_120088_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100738,
		"skill_120089_huajianyusan_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100739,
		"skill_120089_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100740,
		"speech_120089_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100741,
		"speech_120089_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100742,
		"skill_120089_huajianyusan_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100743,
		"skill_120089_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100744,
		"skill_120090_xuegaotongjiaoshou_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100745,
		"skill_120090_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100746,
		"speech_120090_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100747,
		"speech_120090_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100748,
		"skill_120090_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100749,
		"skill_120090_xuegaotongjiaoshou_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100750,
		"skill_120039_mieshiyuanchengbufen_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100751,
		"skill_120039_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100752,
		"speech_120039_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100753,
		"speech_120039_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100754,
		"skill_120039_mieshiyuanchengbufen_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100755,
		"skill_120039_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100756,
		"skill_120067_gros_chongji_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100757,
		"skill_120067_gros_chongji_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100758,
		"skill_120067_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100759,
		"speech_120067_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100760,
		"speech_120067_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100761,
		"skill_120067_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100762,
		"skill_120068_emeng_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100763,
		"skill_120068_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100764,
		"skill_120068_emeng_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100765,
		"speech_120068_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100766,
		"speech_120068_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100767,
		"skill_120068_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100768,
		"skill_120069_gros_fenyuan_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100769,
		"skill_120069_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100770,
		"skill_120069_gros_fenyuan_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100771,
		"speech_120069_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100772,
		"speech_120069_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100773,
		"skill_120069_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100774,
		"skill_120070_gros_kuangre_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100775,
		"skill_120070_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100776,
		"speech_120070_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100777,
		"speech_120070_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100778,
		"skill_120070_gros_kuangre_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100779,
		"skill_120070_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100780,
		"skill_120077_paopao_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100781,
		"skill_120077_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100782,
		"speech_120077_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100783,
		"skill_120077_paopao_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100784,
		"skill_120077_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100785,
		"skill_120078_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100786,
		"speech_120078_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100787,
		"speech_120078_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100788,
		"skill_120078_qingtianwawa_p2_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100789,
		"skill_120078_p2_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100790,
		"speech_120078_p2_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100791,
		"skill_120078_p2_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100792,
		"skill_120078_qingtianwawap2_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100793,
		"skill_120079_hongpaopao_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100794,
		"skill_120079_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100795,
		"speech_120079_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100796,
		"speech_120079_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100797,
		"skill_120079_hongpaopao_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100798,
		"skill_120079_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100799,
		"skill_120080_lanpaopao_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100800,
		"skill_120080_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100801,
		"speech_120080_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100802,
		"speech_120080_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100803,
		"skill_120080_lanpaopao_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100804,
		"skill_120080_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100805,
		"skill_120081_yang_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100806,
		"skill_120081_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100807,
		"speech_120081_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100808,
		"speech_120081_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100809,
		"skill_120081_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100810,
		"skill_120081_yang_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100811,
		"skill_120082_she_cast",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100812,
		"skill_120082_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100813,
		"speech_120082_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100814,
		"speech_120082_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100815,
		"skill_120082_run",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100816,
		"skill_120082_she_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100817,
		"skill_120083_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100818,
		"speech_120083_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100819,
		"speech_120083_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100820,
		"skill_120084_die",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100821,
		"speech_120084_hit_light",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100822,
		"speech_120084_hit_heavy",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100823,
		"skill_120089_huajianyusan_special_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		100824,
		"skill_120087_ruchongfangyingji_attack_skip_p",
		"character_skill.acb",
		"character_skill.awb"
	},
	{
		140009,
		"music_battle_shenhua_buxiu_block",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140014,
		"music_tujian_battle_shenhua_buxiu",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140015,
		"music_battle_fail",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140016,
		"music_battle_victory",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140017,
		"music_battle_normal01_01",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140018,
		"music_battle_normal01_02",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140019,
		"music_battle_normal01_03",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140020,
		"music_battle_normal02_01",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140021,
		"music_battle_normal02_02",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140022,
		"music_battle_normal03_01",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140023,
		"music_battle_normal03_02",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140024,
		"music_battle_normal01_block",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140025,
		"music_battle_normal02_block",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140026,
		"music_battle_normal03_block",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140027,
		"music_battle_gros_mieshi_battleloop1",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140028,
		"music_battle_gros_mieshi_intro",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140029,
		"music_battle_gros_mieshi_transition",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140030,
		"music_battle_gros_mieshi_block",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140032,
		"music_battle_gros_mieshi_battleloop2",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140033,
		"music_battle_shenhua_buxiu_loop",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140034,
		"music_battle_shenhua_buxiu_intro",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140035,
		"music_battle_anna_battleloop",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140036,
		"music_battle_anna_beforebattle",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140037,
		"music_battle_anna_introloop",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140038,
		"music_battle_anna_transition",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140039,
		"music_battle_character_anna_block",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140040,
		"music_battle_cailiao_block",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140041,
		"music_battle_shenhua_gaojibuxiu_block",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		140042,
		"music_battle_character_edipusi_block",
		"music_battle.acb",
		"music_battle.awb"
	},
	{
		110000,
		"music_juqing_changjing_dushi",
		"music_changjing.acb",
		"music_changjing.awb"
	},
	{
		110001,
		"music_juqing_changjing_meishuguan",
		"music_changjing.acb",
		"music_changjing.awb"
	},
	{
		110002,
		"music_juqing_changjing_xueyu",
		"music_changjing.acb",
		"music_changjing.awb"
	},
	{
		110003,
		"music_juqing_changjing_kuangqu",
		"music_changjing.acb",
		"music_changjing.awb"
	},
	{
		120002,
		"music_main_jiansuo",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120003,
		"music_main_huodong",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120004,
		"music_main_mengjingdangan_fight",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120005,
		"music_main_mengjingdangan_explore",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120007,
		"music_main_mengjingdangan_block",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120008,
		"music_main_jiansuo_pre",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120009,
		"music_main_denglu",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120010,
		"music_main_shoumiren_intro",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120011,
		"music_main_shoumiren_loop",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120012,
		"music_main_shoumiren",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120013,
		"music_main",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120014,
		"music_main_shop",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120015,
		"music_main_shop_intro",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120016,
		"music_main_shop_loop",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120017,
		"music_main_echo",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120018,
		"music_denglu_waves_loop",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120019,
		"music_stop",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120020,
		"music_main_zhaomu_01",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120021,
		"music_main_zhaomu_02",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120022,
		"music_main_zhaomu_03",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120023,
		"music_main_zhaomu_pianoamb",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		120024,
		"music_main_zhaomu_randomvocal",
		"music_interface.acb",
		"music_interface.awb"
	},
	{
		130001,
		"music_juqing_dangerous",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130004,
		"music_juqing_sad",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130006,
		"music_juqing_qingsong",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130007,
		"music_juqing_jinzhang",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130008,
		"music_juqing_shikong_intro",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130009,
		"music_juqing_shikong_loop",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130013,
		"music_themesong",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130014,
		"music_juqing_jinzhang_02",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130015,
		"music_scene1601_01",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130016,
		"music_scene1601_02",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130017,
		"music_scene1601_03",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130018,
		"music_scene1601_04",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130019,
		"music_juqing_strange_02",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130020,
		"music_juqing_strange_01",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130021,
		"music_juqing_normal_01",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130022,
		"music_juqing_emotional_01",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130023,
		"music_juqing_yanhuo_01",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130024,
		"music_juqing_yanhuo_02",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130025,
		"music_juqing_yanhuo_03",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130026,
		"music_juqing_shuidi",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130027,
		"music_juqing_edipusi",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		130028,
		"music_juqing_zhuguanshi",
		"music_juqing.acb",
		"music_juqing.awb"
	},
	{
		700000,
		"npc_xiaojiqiren_move",
		"npc.acb",
		""
	},
	{
		500000,
		"juqing_badao",
		"story.acb",
		""
	},
	{
		500001,
		"juqing_baizaoyin",
		"story.acb",
		""
	},
	{
		500002,
		"juqing_daodi",
		"story.acb",
		""
	},
	{
		500003,
		"juqing_dishui1",
		"story.acb",
		""
	},
	{
		500004,
		"juqing_dishui2",
		"story.acb",
		""
	},
	{
		500005,
		"juqing_dishui3",
		"story.acb",
		""
	},
	{
		500006,
		"juqing_huoyan",
		"story.acb",
		""
	},
	{
		500007,
		"juqing_jiaobu",
		"story.acb",
		""
	},
	{
		500008,
		"juqing_kaimen",
		"story.acb",
		""
	},
	{
		500009,
		"juqing_paobu",
		"story.acb",
		""
	},
	{
		500010,
		"juqing_qiang",
		"story.acb",
		""
	},
	{
		500011,
		"juqing_shangkelingsheng",
		"story.acb",
		""
	},
	{
		500012,
		"juqing_xiache",
		"story.acb",
		""
	},
	{
		500013,
		"juqing_zhongsheng",
		"story.acb",
		""
	},
	{
		500014,
		"juqing_zhuangji",
		"story.acb",
		""
	},
	{
		500015,
		"juqing_denglu",
		"story.acb",
		""
	},
	{
		500016,
		"juqing_feng",
		"story.acb",
		""
	},
	{
		500017,
		"juqing_feng2",
		"story.acb",
		""
	},
	{
		500018,
		"juqing_guanmen",
		"story.acb",
		""
	},
	{
		500019,
		"juqing_jiaotan",
		"story.acb",
		""
	},
	{
		500020,
		"juqing_jingshi",
		"story.acb",
		""
	},
	{
		500021,
		"juqing_kaiche",
		"story.acb",
		""
	},
	{
		500022,
		"juqing_lingsheng",
		"story.acb",
		""
	},
	{
		500023,
		"juqing_moca",
		"story.acb",
		""
	},
	{
		500024,
		"juqing_xuannao",
		"story.acb",
		""
	},
	{
		500025,
		"juqing_zhuangche",
		"story.acb",
		""
	},
	{
		600000,
		"story3d_ani_00_007_01",
		"story3d_ani_00_007.acb",
		""
	},
	{
		600001,
		"story3d_ani_00_007_02",
		"story3d_ani_00_007.acb",
		""
	},
	{
		600002,
		"story3d_ani_00_007_Amb",
		"story3d_ani_00_007.acb",
		""
	},
	{
		610000,
		"story3d_ani_00_007_1_01",
		"story3d_ani_00_007_1.acb",
		""
	},
	{
		610001,
		"story3d_ani_00_007_1_02",
		"story3d_ani_00_007_1.acb",
		""
	},
	{
		610002,
		"story3d_ani_00_007_1_03",
		"story3d_ani_00_007_1.acb",
		""
	},
	{
		610003,
		"story3d_ani_00_007_1_04",
		"story3d_ani_00_007_1.acb",
		""
	},
	{
		610004,
		"story3d_ani_00_007_1_05",
		"story3d_ani_00_007_1.acb",
		""
	},
	{
		610005,
		"story3d_ani_00_007_1_06",
		"story3d_ani_00_007_1.acb",
		""
	},
	{
		610006,
		"story3d_ani_00_007_1_07",
		"story3d_ani_00_007_1.acb",
		""
	},
	{
		610007,
		"story3d_ani_00_007_1_Amb",
		"story3d_ani_00_007_1.acb",
		""
	},
	{
		610008,
		"story3d_ani_00_007_1_02m",
		"story3d_ani_00_007_1.acb",
		""
	},
	{
		620000,
		"story3d_ani_00_007_2_01",
		"story3d_ani_00_007_2.acb",
		""
	},
	{
		620001,
		"story3d_ani_00_007_2_02",
		"story3d_ani_00_007_2.acb",
		""
	},
	{
		620002,
		"story3d_ani_00_007_2_03",
		"story3d_ani_00_007_2.acb",
		""
	},
	{
		620005,
		"story3d_ani_00_007_2_Amb_Block",
		"story3d_ani_00_007_2.acb",
		""
	},
	{
		630000,
		"story3d_ani_00_008_01",
		"story3d_ani_00_008.acb",
		""
	},
	{
		640000,
		"story3d_ani_00_010_01",
		"story3d_ani_00_010.acb",
		""
	},
	{
		650000,
		"story3d_ani_00_011_01",
		"story3d_ani_00_011.acb",
		""
	},
	{
		521000,
		"juqing_1020202_dianhualing_01",
		"story_1020202.acb",
		""
	},
	{
		522000,
		"juqing_1020301_02_zayin",
		"story_1020301.acb",
		""
	},
	{
		523000,
		"juqing_1020401_dianhualing_01",
		"story_1020401.acb",
		""
	},
	{
		523001,
		"juqing_1020401_jiedianhua_01",
		"story_1020401.acb",
		""
	},
	{
		524000,
		"juqing_1020601_02_zayin",
		"story_1020601.acb",
		""
	},
	{
		524001,
		"juqing_1020601_08_yuanti",
		"story_1020601.acb",
		""
	},
	{
		525000,
		"juqing_1020801_dianhualing_01",
		"story_1020801.acb",
		""
	},
	{
		525001,
		"juqing_1020801_jiedianhua_01",
		"story_1020801.acb",
		""
	},
	{
		526000,
		"juqing_1020901_08_yuanti",
		"story_1020901.acb",
		""
	},
	{
		527000,
		"juqing_1021001_02_zayin",
		"story_1021001.acb",
		""
	},
	{
		527001,
		"juqing_1021001_dianhualing_01",
		"story_1021001.acb",
		""
	},
	{
		527002,
		"juqing_1021001_jiedianhua_01",
		"story_1021001.acb",
		""
	},
	{
		527003,
		"juqing_1021001_shuidi",
		"story_1021001.acb",
		""
	},
	{
		528000,
		"juqing_1021101_mensuilie",
		"story_1021101.acb",
		""
	},
	{
		528001,
		"juqing_1021101_yitaijiejinjingyingguai",
		"story_1021101.acb",
		""
	},
	{
		528002,
		"juqing_1021101_zhuangmen",
		"story_1021101.acb",
		""
	},
	{
		529000,
		"juqing_1021301_dianhualing_01",
		"story_1021301.acb",
		""
	},
	{
		530000,
		"juqing_1021401_dianhualing_01",
		"story_1021401.acb",
		""
	},
	{
		530001,
		"juqing_1021401_ding",
		"story_1021401.acb",
		""
	},
	{
		200021,
		"ui_effect_rising_star",
		"ui.acb",
		""
	},
	{
		200023,
		"ui_effect_tips_story",
		"ui.acb",
		""
	},
	{
		200024,
		"ui_effect_upgrade",
		"ui.acb",
		""
	},
	{
		200025,
		"ui_effect_warm_story",
		"ui.acb",
		""
	},
	{
		200026,
		"ui_effect_battle_scope",
		"ui.acb",
		""
	},
	{
		200028,
		"ui_generic_click",
		"ui.acb",
		""
	},
	{
		200029,
		"ui_generic_click_buy",
		"ui.acb",
		""
	},
	{
		200033,
		"ui_generic_click_return",
		"ui.acb",
		""
	},
	{
		200035,
		"ui_generic_enter",
		"ui.acb",
		""
	},
	{
		200036,
		"ui_generic_page_change",
		"ui.acb",
		""
	},
	{
		200037,
		"ui_generic_select",
		"ui.acb",
		""
	},
	{
		200050,
		"ui_tickdown",
		"ui.acb",
		""
	},
	{
		200051,
		"ui_tickup",
		"ui.acb",
		""
	},
	{
		200056,
		"ui_window_history_open",
		"ui.acb",
		""
	},
	{
		200060,
		"ui_shoumiren_cailiaobuzu",
		"ui.acb",
		""
	},
	{
		200071,
		"ui_main_fuli",
		"ui.acb",
		""
	},
	{
		200072,
		"ui_main_jiansuo",
		"ui.acb",
		""
	},
	{
		200073,
		"ui_main_shop",
		"ui.acb",
		""
	},
	{
		200074,
		"ui_main_shoumiren",
		"ui.acb",
		""
	},
	{
		200075,
		"ui_shop_buysuccess",
		"ui.acb",
		""
	},
	{
		200076,
		"ui_main_chat",
		"ui.acb",
		""
	},
	{
		200077,
		"ui_main_friend",
		"ui.acb",
		""
	},
	{
		200078,
		"ui_main_mail",
		"ui.acb",
		""
	},
	{
		200079,
		"ui_main_setting",
		"ui.acb",
		""
	},
	{
		200080,
		"ui_battle_confirmclick",
		"ui.acb",
		""
	},
	{
		200081,
		"ui_battle_endbanner",
		"ui.acb",
		""
	},
	{
		200082,
		"ui_battle_overdraftappear",
		"ui.acb",
		""
	},
	{
		200083,
		"ui_battle_overdraftclick",
		"ui.acb",
		""
	},
	{
		200084,
		"ui_battle_renwupickup",
		"ui.acb",
		""
	},
	{
		200085,
		"ui_battle_renwuputdown",
		"ui.acb",
		""
	},
	{
		200086,
		"ui_battle_shoumirenTurn",
		"ui.acb",
		""
	},
	{
		200087,
		"ui_battle_solohalo",
		"ui.acb",
		""
	},
	{
		200088,
		"ui_battle_standbyclick",
		"ui.acb",
		""
	},
	{
		200089,
		"ui_battle_startbanner",
		"ui.acb",
		""
	},
	{
		200090,
		"ui_battle_targetselect",
		"ui.acb",
		""
	},
	{
		200091,
		"ui_battle_teamhalo",
		"ui.acb",
		""
	},
	{
		200092,
		"ui_battle_yourturn",
		"ui.acb",
		""
	},
	{
		200093,
		"ui_juqing_dialogselect",
		"ui.acb",
		""
	},
	{
		200094,
		"ui_juqing_emojicutin",
		"ui.acb",
		""
	},
	{
		200095,
		"ui_juqing_placeintro",
		"ui.acb",
		""
	},
	{
		200096,
		"ui_juqing_rolerecord",
		"ui.acb",
		""
	},
	{
		200097,
		"ui_juqing_roletag",
		"ui.acb",
		""
	},
	{
		200098,
		"ui_juqing_telepathyattack",
		"ui.acb",
		""
	},
	{
		200099,
		"ui_juqing_telepathyhold",
		"ui.acb",
		""
	},
	{
		200100,
		"ui_juqing_telepathyrelease",
		"ui.acb",
		""
	},
	{
		200101,
		"ui_general_buffeffect",
		"ui.acb",
		""
	},
	{
		200102,
		"ui_general_cure",
		"ui.acb",
		""
	},
	{
		200103,
		"ui_general_debuffeffect",
		"ui.acb",
		""
	},
	{
		200104,
		"ui_general_hit",
		"ui.acb",
		""
	},
	{
		200105,
		"ui_general_sanrecover",
		"ui.acb",
		""
	},
	{
		200106,
		"ui_general_sanreduce",
		"ui.acb",
		""
	},
	{
		200115,
		"ui_chouka_resulta",
		"ui.acb",
		""
	},
	{
		200116,
		"ui_chouka_resultb",
		"ui.acb",
		""
	},
	{
		200117,
		"ui_chouka_results",
		"ui.acb",
		""
	},
	{
		200121,
		"ui_chouka_results_convert",
		"ui.acb",
		""
	},
	{
		200122,
		"ui_chouka_carda",
		"ui.acb",
		""
	},
	{
		200123,
		"ui_chouka_cardb",
		"ui.acb",
		""
	},
	{
		200124,
		"ui_chouka_cards",
		"ui.acb",
		""
	},
	{
		200125,
		"ui_chouka_echoburst",
		"ui.acb",
		""
	},
	{
		200126,
		"ui_chouka_echocardpull",
		"ui.acb",
		""
	},
	{
		200127,
		"ui_chouka_echocardpush",
		"ui.acb",
		""
	},
	{
		200128,
		"ui_main_zichan",
		"ui.acb",
		""
	},
	{
		200129,
		"ui_main_diaocha",
		"ui.acb",
		""
	},
	{
		200130,
		"ui_main_fuben",
		"ui.acb",
		""
	},
	{
		200131,
		"ui_battle_fail",
		"ui.acb",
		""
	},
	{
		200132,
		"ui_battle_win",
		"ui.acb",
		""
	},
	{
		200133,
		"ui_battle_win_gain_booty",
		"ui.acb",
		""
	},
	{
		200134,
		"ui_battle_win_gain_exp",
		"ui.acb",
		""
	},
	{
		200135,
		"ui_battle_win_gain_window",
		"ui.acb",
		""
	},
	{
		200136,
		"ui_paotuan_battle_button",
		"ui.acb",
		""
	},
	{
		200137,
		"ui_paotuan_battle_charscroll",
		"ui.acb",
		""
	},
	{
		200138,
		"ui_paotuan_battle_charstop",
		"ui.acb",
		""
	},
	{
		200139,
		"ui_paotuan_battle_diceattack1",
		"ui.acb",
		""
	},
	{
		200142,
		"ui_paotuan_battle_dicebattle1",
		"ui.acb",
		""
	},
	{
		200143,
		"ui_paotuan_battle_dicebattle2",
		"ui.acb",
		""
	},
	{
		200144,
		"ui_paotuan_battle_dicebattle3",
		"ui.acb",
		""
	},
	{
		200145,
		"ui_paotuan_battle_diceleave",
		"ui.acb",
		""
	},
	{
		200146,
		"ui_paotuan_battle_diceshow",
		"ui.acb",
		""
	},
	{
		200147,
		"ui_paotuan_chess_attack",
		"ui.acb",
		""
	},
	{
		200148,
		"ui_paotuan_chess_die",
		"ui.acb",
		""
	},
	{
		200149,
		"ui_paotuan_chess_fall",
		"ui.acb",
		""
	},
	{
		200150,
		"ui_paotuan_chess_rise",
		"ui.acb",
		""
	},
	{
		200151,
		"ui_paotuan_chess_run_jump_hit",
		"ui.acb",
		""
	},
	{
		200152,
		"ui_paotuan_chess_skill",
		"ui.acb",
		""
	},
	{
		200153,
		"ui_paotuan_chess_win",
		"ui.acb",
		""
	},
	{
		200154,
		"ui_paotuan_dreamarchives",
		"ui.acb",
		""
	},
	{
		200155,
		"ui_paotuan_dreamjourney",
		"ui.acb",
		""
	},
	{
		200156,
		"ui_paotuan_start",
		"ui.acb",
		""
	},
	{
		200157,
		"ui_generic_click_cancel",
		"ui.acb",
		""
	},
	{
		200158,
		"ui_generic_click_closed",
		"ui.acb",
		""
	},
	{
		200159,
		"ui_generic_click_daoju",
		"ui.acb",
		""
	},
	{
		200160,
		"ui_generic_error",
		"ui.acb",
		""
	},
	{
		200161,
		"ui_chouka_moji_a",
		"ui.acb",
		""
	},
	{
		200162,
		"ui_chouka_moji_s",
		"ui.acb",
		""
	},
	{
		200163,
		"ui_chouka_moji_reverse",
		"ui.acb",
		""
	},
	{
		200164,
		"ui_chouka_camera_move_1",
		"ui.acb",
		""
	},
	{
		200165,
		"ui_chouka_camera_move_2",
		"ui.acb",
		""
	},
	{
		200166,
		"ui_chouka_camera_move_3",
		"ui.acb",
		""
	},
	{
		200167,
		"ui_chouka_camera_move_4",
		"ui.acb",
		""
	},
	{
		200168,
		"ui_chouka_camera_sink",
		"ui.acb",
		""
	},
	{
		200170,
		"ui_chouka_keywords_1",
		"ui.acb",
		""
	},
	{
		200171,
		"ui_chouka_keywords_2",
		"ui.acb",
		""
	},
	{
		200172,
		"ui_chouka_keywords_3",
		"ui.acb",
		""
	},
	{
		200173,
		"ui_chouka_keywords_4",
		"ui.acb",
		""
	},
	{
		200174,
		"ui_chouka_keywords_5",
		"ui.acb",
		""
	},
	{
		200176,
		"ui_chouka_role_a",
		"ui.acb",
		""
	},
	{
		200177,
		"ui_chouka_role_a_camera_move",
		"ui.acb",
		""
	},
	{
		200178,
		"ui_chouka_role_a_effect",
		"ui.acb",
		""
	},
	{
		200179,
		"ui_chouka_role_b",
		"ui.acb",
		""
	},
	{
		200180,
		"ui_chouka_role_b_camera_move",
		"ui.acb",
		""
	},
	{
		200181,
		"ui_chouka_role_b_effect",
		"ui.acb",
		""
	},
	{
		200182,
		"ui_chouka_role_nametag",
		"ui.acb",
		""
	},
	{
		200183,
		"ui_chouka_role_s",
		"ui.acb",
		""
	},
	{
		200184,
		"ui_chouka_role_s_camere_move",
		"ui.acb",
		""
	},
	{
		200185,
		"ui_chouka_role_s_effect",
		"ui.acb",
		""
	},
	{
		200186,
		"ui_chouka_role_faction_baiyinliming",
		"ui.acb",
		""
	},
	{
		200187,
		"ui_chouka_role_faction_oad",
		"ui.acb",
		""
	},
	{
		200188,
		"ui_chouka_role_faction_shuidijieshe",
		"ui.acb",
		""
	},
	{
		200189,
		"ui_chouka_role_faction_xingkongjiaohui",
		"ui.acb",
		""
	},
	{
		200190,
		"ui_main_zhuguanmingpian",
		"ui.acb",
		""
	},
	{
		200193,
		"ui_battle_lvlup",
		"ui.acb",
		""
	},
	{
		200194,
		"ui_battle_break_bonus",
		"ui.acb",
		""
	},
	{
		200195,
		"ui_battle_break_freeze",
		"ui.acb",
		""
	},
	{
		200196,
		"ui_battle_buff_link",
		"ui.acb",
		""
	},
	{
		200197,
		"ui_battle_buff_link_cut",
		"ui.acb",
		""
	},
	{
		200198,
		"ui_battle_camera_switch",
		"ui.acb",
		""
	},
	{
		200199,
		"ui_battle_dead",
		"ui.acb",
		""
	},
	{
		200200,
		"ui_battle_get_coins",
		"ui.acb",
		""
	},
	{
		200203,
		"ui_battle_san_0_burst",
		"ui.acb",
		""
	},
	{
		200204,
		"ui_battle_san_1_burst",
		"ui.acb",
		""
	},
	{
		200205,
		"ui_battle_team_windows",
		"ui.acb",
		""
	},
	{
		200206,
		"ui_battle_teambuff_windows",
		"ui.acb",
		""
	},
	{
		200207,
		"ui_battle_san_minus1_burst",
		"ui.acb",
		""
	},
	{
		200208,
		"ui_battle_san_minus1_dead",
		"ui.acb",
		""
	},
	{
		200209,
		"ui_generic_gain",
		"ui.acb",
		""
	},
	{
		200210,
		"ui_login_clock_change",
		"ui.acb",
		""
	},
	{
		200211,
		"ui_login_clock_tick",
		"ui.acb",
		""
	},
	{
		200212,
		"ui_login_echoclock_tick",
		"ui.acb",
		""
	},
	{
		200217,
		"ui_window_close",
		"ui.acb",
		""
	},
	{
		200218,
		"ui_battle_yinmiTurn",
		"ui.acb",
		""
	},
	{
		200220,
		"ui_generic_window_close",
		"ui.acb",
		""
	},
	{
		200221,
		"ui_generic_window_open",
		"ui.acb",
		""
	},
	{
		200222,
		"ui_main_into_echotime",
		"ui.acb",
		""
	},
	{
		200223,
		"ui_main_into_realtime",
		"ui.acb",
		""
	},
	{
		200224,
		"ui_paotuan_scenery_battleplacearise",
		"ui.acb",
		""
	},
	{
		200225,
		"ui_paotuan_scenery_initplace",
		"ui.acb",
		""
	},
	{
		200226,
		"ui_paotuan_scenery_monoblockarise",
		"ui.acb",
		""
	},
	{
		200227,
		"ui_paotuan_scenery_monoblockfall",
		"ui.acb",
		""
	},
	{
		200228,
		"ui_paotuan_scenery_monoblockmove",
		"ui.acb",
		""
	},
	{
		200229,
		"ui_paotuan_chess_forward",
		"ui.acb",
		""
	},
	{
		200230,
		"ui_battle_lizhi_burst",
		"ui.acb",
		""
	},
	{
		200231,
		"ui_battle_lizhi_scene_switch",
		"ui.acb",
		""
	},
	{
		200232,
		"skill_biaoqian_zhendang1",
		"ui.acb",
		""
	},
	{
		200233,
		"skill_biaoqian_zhendang2",
		"ui.acb",
		""
	},
	{
		200234,
		"skill_biaoqian_zhendang3",
		"ui.acb",
		""
	},
	{
		200235,
		"ui_shoumiren_character",
		"ui.acb",
		""
	},
	{
		200236,
		"ui_shoumiren_xiangqing",
		"ui.acb",
		""
	},
	{
		200237,
		"ui_shoumiren_xinxi",
		"ui.acb",
		""
	},
	{
		200238,
		"ui_shoumiren_qinhedu",
		"ui.acb",
		""
	},
	{
		200239,
		"ui_shoumiren_jiaoshiqi",
		"ui.acb",
		""
	},
	{
		200240,
		"ui_shoumiren_canxiang",
		"ui.acb",
		""
	},
	{
		200241,
		"ui_shoumiren_siwei",
		"ui.acb",
		""
	},
	{
		200242,
		"ui_shoumiren_dengjishengji",
		"ui.acb",
		""
	},
	{
		200243,
		"ui_shoumiren_tuozhuai",
		"ui.acb",
		""
	},
	{
		200244,
		"ui_shoumiren_dengjitisheng",
		"ui.acb",
		""
	},
	{
		200245,
		"ui_shoumiren_gongming",
		"ui.acb",
		""
	},
	{
		200246,
		"ui_shoumiren_gongmingshengji",
		"ui.acb",
		""
	},
	{
		200247,
		"ui_shoumiren_yinxiang",
		"ui.acb",
		""
	},
	{
		200248,
		"ui_shoumiren_yinxiangdangan",
		"ui.acb",
		""
	},
	{
		200249,
		"ui_shoumiren_yinxianglicheng",
		"ui.acb",
		""
	},
	{
		200250,
		"ui_shoumiren_yinxiangjieduan",
		"ui.acb",
		""
	},
	{
		200251,
		"ui_shoumiren_yinxiangjiesuo",
		"ui.acb",
		""
	},
	{
		200252,
		"ui_shoumiren_yinxiangyuyin",
		"ui.acb",
		""
	},
	{
		200253,
		"ui_shoumiren_yinxiangyuyinbofang",
		"ui.acb",
		""
	},
	{
		200254,
		"ui_shoumiren_qinhedushengji",
		"ui.acb",
		""
	},
	{
		200255,
		"ui_shoumiren_qinhedujiesuo",
		"ui.acb",
		""
	},
	{
		200256,
		"ui_shoumiren_qinhedujieduanxuanze",
		"ui.acb",
		""
	},
	{
		200257,
		"ui_shoumiren_qinhedugundong",
		"ui.acb",
		""
	},
	{
		200258,
		"ui_shoumiren_jiaoshiqigenghuan",
		"ui.acb",
		""
	},
	{
		200259,
		"ui_shoumiren_jiaoshiqishiyong",
		"ui.acb",
		""
	},
	{
		200260,
		"ui_shoumiren_jiaoshiqijiechu",
		"ui.acb",
		""
	},
	{
		200261,
		"ui_shoumiren_jiaoshiqisuoding",
		"ui.acb",
		""
	},
	{
		200262,
		"ui_shoumiren_jiaoshiqijiesuo",
		"ui.acb",
		""
	},
	{
		200263,
		"ui_shoumiren_jiaoshiqiqianghua",
		"ui.acb",
		""
	},
	{
		200264,
		"ui_shoumiren_mubiaodengji",
		"ui.acb",
		""
	},
	{
		200265,
		"ui_shoumiren_jiaoshiqidengjitisheng",
		"ui.acb",
		""
	},
	{
		200266,
		"ui_shoumiren_jiaoshiqijiedianjiesuo",
		"ui.acb",
		""
	},
	{
		200267,
		"ui_shoumiren_jiaoshiqijiediantiaojiao1",
		"ui.acb",
		""
	},
	{
		200268,
		"ui_shoumiren_jiaoshiqijiediantiaojiao2",
		"ui.acb",
		""
	},
	{
		200269,
		"ui_shoumiren_jiaoshiqijiediantiaojiao3",
		"ui.acb",
		""
	},
	{
		200270,
		"ui_shoumiren_canxiangtupo",
		"ui.acb",
		""
	},
	{
		200271,
		"ui_shoumiren_canxiangtupozhong",
		"ui.acb",
		""
	},
	{
		200272,
		"ui_shoumiren_canxiangtupowancheng",
		"ui.acb",
		""
	},
	{
		200273,
		"ui_shoumiren_canxiangsuoding",
		"ui.acb",
		""
	},
	{
		200274,
		"ui_shoumiren_canxianggenghuan",
		"ui.acb",
		""
	},
	{
		200275,
		"ui_battle_below_init",
		"ui.acb",
		""
	},
	{
		200276,
		"ui_battle_diaochashibai",
		"ui.acb",
		""
	},
	{
		200277,
		"ui_battle_diaochawancheng",
		"ui.acb",
		""
	},
	{
		200278,
		"ui_battle_difanghuihe",
		"ui.acb",
		""
	},
	{
		200279,
		"ui_battle_juesexinxi",
		"ui.acb",
		""
	},
	{
		200280,
		"ui_battle_kezhiguanxi",
		"ui.acb",
		""
	},
	{
		200282,
		"ui_battle_querenzhandou",
		"ui.acb",
		""
	},
	{
		200283,
		"ui_battle_wofanghuihe",
		"ui.acb",
		""
	},
	{
		200284,
		"ui_battle_yinxiangpanbofang",
		"ui.acb",
		""
	},
	{
		200285,
		"ui_battle_shenglitiaojian",
		"ui.acb",
		""
	},
	{
		200286,
		"ui_battle_biandui",
		"ui.acb",
		""
	},
	{
		200287,
		"ui_battle_jueseshaixuan",
		"ui.acb",
		""
	},
	{
		200288,
		"ui_battle_skillselect",
		"ui.acb",
		""
	},
	{
		200289,
		"ui_battle_querenshifang",
		"ui.acb",
		""
	},
	{
		200290,
		"ui_battle_mishi",
		"ui.acb",
		""
	},
	{
		200291,
		"ui_battle_zhijitisheng",
		"ui.acb",
		""
	},
	{
		200292,
		"ui_login_into",
		"ui.acb",
		""
	},
	{
		200293,
		"ui_diaocha_mengjingdanganshi",
		"ui.acb",
		""
	},
	{
		200294,
		"ui_diaocha_zhanshupeixun",
		"ui.acb",
		""
	},
	{
		200295,
		"ui_diaocha_guanzhixingdong",
		"ui.acb",
		""
	},
	{
		200296,
		"ui_diaocha_hongwuquyu",
		"ui.acb",
		""
	},
	{
		200297,
		"ui_diaocha_andingquyu",
		"ui.acb",
		""
	},
	{
		200298,
		"ui_diaocha_zhuxianwending",
		"ui.acb",
		""
	},
	{
		200299,
		"ui_diaocha_zhuxianyichang",
		"ui.acb",
		""
	},
	{
		200300,
		"ui_diaocha_zhuxianjiesuo",
		"ui.acb",
		""
	},
	{
		200301,
		"ui_diaocha_guanqia",
		"ui.acb",
		""
	},
	{
		200302,
		"ui_diaocha_guanzhixingdongdakai",
		"ui.acb",
		""
	},
	{
		200303,
		"ui_diaocha_guanzhixingdongguanbi",
		"ui.acb",
		""
	},
	{
		200304,
		"ui_diaocha_guanzhixingdong_click",
		"ui.acb",
		""
	},
	{
		200305,
		"ui_diaocha_guanzhixingdong_close",
		"ui.acb",
		""
	},
	{
		200306,
		"ui_diaocha_guanzhixingdong_open",
		"ui.acb",
		""
	},
	{
		200307,
		"ui_chouka_kachizhanshi",
		"ui.acb",
		""
	},
	{
		200308,
		"ui_chouka_canxiangkachi",
		"ui.acb",
		""
	},
	{
		200309,
		"ui_chouka_jinruchoumirenchouka",
		"ui.acb",
		""
	},
	{
		200310,
		"ui_chouka_jinrucanxiangchouka",
		"ui.acb",
		""
	},
	{
		200311,
		"ui_main_yinxiangpandakai",
		"ui.acb",
		""
	},
	{
		200312,
		"ui_main_yinxiangpanzhuangshang",
		"ui.acb",
		""
	},
	{
		200313,
		"ui_main_yinxiangpanxiexia",
		"ui.acb",
		""
	},
	{
		200314,
		"ui_main_yinxiangpanguanbi",
		"ui.acb",
		""
	},
	{
		200315,
		"ui_paotuan_cardattack",
		"ui.acb",
		""
	},
	{
		200316,
		"ui_juqing_holdqte",
		"ui.acb",
		""
	},
	{
		200318,
		"ui_juqing_dialogselect_side",
		"ui.acb",
		""
	},
	{
		200319,
		"ui_diaocha_zhuxian",
		"ui.acb",
		""
	},
	{
		200320,
		"ui_login",
		"ui.acb",
		""
	},
	{
		200321,
		"ui_chuangjue_xuanxiang",
		"ui.acb",
		""
	},
	{
		200322,
		"ui_chuangjue_dianjimianju",
		"ui.acb",
		""
	},
	{
		200323,
		"ui_main_zhuguanshengji",
		"ui.acb",
		""
	},
	{
		200324,
		"ui_battle_jiesuan",
		"ui.acb",
		""
	},
	{
		200325,
		"ui_chouka_popup",
		"ui.acb",
		""
	},
	{
		200326,
		"ui_chouka_doubledash",
		"ui.acb",
		""
	},
	{
		200327,
		"ui_chouka_result_conversion",
		"ui.acb",
		""
	},
	{
		200328,
		"ui_battle_mission_goal",
		"ui.acb",
		""
	},
	{
		200329,
		"ui_diaocha_guanzhixingdong_error",
		"ui.acb",
		""
	},
	{
		200330,
		"ui_diaocha_guanzhixingdong_jiankong_flash",
		"ui.acb",
		""
	},
	{
		200331,
		"ui_rediandianshi_off",
		"ui.acb",
		""
	},
	{
		200332,
		"ui_rediandianshi_on",
		"ui.acb",
		""
	},
	{
		200333,
		"ui_battle_fight",
		"ui.acb",
		""
	},
	{
		200334,
		"ui_battle_jiesuan1",
		"ui.acb",
		""
	},
	{
		200335,
		"ui_battle_jiesuan2",
		"ui.acb",
		""
	},
	{
		200336,
		"ui_battle_jiesuan2_lvup",
		"ui.acb",
		""
	},
	{
		200337,
		"ui_battle_jiesuan3",
		"ui.acb",
		""
	},
	{
		200338,
		"ui_battle_select",
		"ui.acb",
		""
	},
	{
		200339,
		"ui_diaocha_andingquyu_select1",
		"ui.acb",
		""
	},
	{
		200340,
		"ui_diaocha_andingquyu_select2",
		"ui.acb",
		""
	},
	{
		200341,
		"ui_diaocha_hongwuquyu_select1",
		"ui.acb",
		""
	},
	{
		200342,
		"ui_diaocha_hongwuquyu_select2",
		"ui.acb",
		""
	},
	{
		200343,
		"ui_paotuan_check_selectcard",
		"ui.acb",
		""
	},
	{
		200344,
		"ui_paotuan_chess_step_special",
		"ui.acb",
		""
	},
	{
		200345,
		"ui_paotuan_cutphoto",
		"ui.acb",
		""
	},
	{
		200346,
		"ui_paotuan_dikuaishengqi",
		"ui.acb",
		""
	},
	{
		200347,
		"ui_paotuan_fanmaiji",
		"ui.acb",
		""
	},
	{
		200348,
		"ui_paotuan_fanmaiji_gain",
		"ui.acb",
		""
	},
	{
		200349,
		"ui_paotuan_pachinko_gain",
		"ui.acb",
		""
	},
	{
		200350,
		"ui_paotuan_pachinko_impact1",
		"ui.acb",
		""
	},
	{
		200351,
		"ui_paotuan_pachinko_impact2",
		"ui.acb",
		""
	},
	{
		200352,
		"ui_paotuan_pachinko_impact3",
		"ui.acb",
		""
	},
	{
		200353,
		"ui_paotuan_pachinko_impact4",
		"ui.acb",
		""
	},
	{
		200354,
		"ui_paotuan_pachinko_impact5",
		"ui.acb",
		""
	},
	{
		200355,
		"ui_paotuan_pachinko_light",
		"ui.acb",
		""
	},
	{
		200356,
		"ui_paotuan_pachinko_lightbonus",
		"ui.acb",
		""
	},
	{
		200357,
		"ui_paotuan_pachinko_move1",
		"ui.acb",
		""
	},
	{
		200358,
		"ui_paotuan_pachinko_move2",
		"ui.acb",
		""
	},
	{
		200359,
		"ui_paotuan_pachinko_release",
		"ui.acb",
		""
	},
	{
		200360,
		"ui_paotuan_pachinko_startbutton",
		"ui.acb",
		""
	},
	{
		200361,
		"ui_paotuan_shijiantanchuang",
		"ui.acb",
		""
	},
	{
		200362,
		"ui_paotuan_yuditanchuang",
		"ui.acb",
		""
	},
	{
		200363,
		"ui_main_2436",
		"ui.acb",
		""
	},
	{
		200364,
		"ui_zhuguan_shenfen",
		"ui.acb",
		""
	},
	{
		200365,
		"ui_battle_jiasu",
		"ui.acb",
		""
	},
	{
		200366,
		"ui_battle_weixianfanwei",
		"ui.acb",
		""
	},
	{
		200367,
		"ui_chuangjue_mianju_finalconfirm",
		"ui.acb",
		""
	},
	{
		200368,
		"ui_generic_click_2",
		"ui.acb",
		""
	},
	{
		200369,
		"shouchong_yiyun_loop",
		"ui.acb",
		""
	},
	{
		200370,
		"shouchong_yiyun",
		"ui.acb",
		""
	},
	{
		200371,
		"ui_zhaomu_anjian0",
		"ui.acb",
		""
	},
	{
		200372,
		"ui_zhaomu_anjian1",
		"ui.acb",
		""
	},
	{
		200373,
		"ui_zhaomu_anjian2",
		"ui.acb",
		""
	},
	{
		200374,
		"ui_zhaomu_anjian3",
		"ui.acb",
		""
	},
	{
		200375,
		"ui_zhaomu_anjian4",
		"ui.acb",
		""
	},
	{
		200376,
		"ui_zhaomu_anjian5",
		"ui.acb",
		""
	},
	{
		200377,
		"ui_zhaomu_anjian6",
		"ui.acb",
		""
	},
	{
		200378,
		"ui_zhaomu_anjian7",
		"ui.acb",
		""
	},
	{
		200379,
		"ui_zhaomu_anjian8",
		"ui.acb",
		""
	},
	{
		200380,
		"ui_zhaomu_anjian9",
		"ui.acb",
		""
	},
	{
		200381,
		"ui_zhaomu_anjianbohao",
		"ui.acb",
		""
	},
	{
		200382,
		"ui_zhaomu_anjianfanhui",
		"ui.acb",
		""
	},
	{
		200383,
		"ui_zhaomu_chenjin",
		"ui.acb",
		""
	},
	{
		200384,
		"ui_canxiang_a",
		"ui.acb",
		""
	},
	{
		200385,
		"ui_canxiang_b",
		"ui.acb",
		""
	},
	{
		200386,
		"ui_canxiang_cutin_s",
		"ui.acb",
		""
	},
	{
		200387,
		"ui_canxiang_dakai_a",
		"ui.acb",
		""
	},
	{
		200388,
		"ui_canxiang_dakai_b",
		"ui.acb",
		""
	},
	{
		200389,
		"ui_canxiang_dakai_s",
		"ui.acb",
		""
	},
	{
		200390,
		"ui_canxiang_huadong",
		"ui.acb",
		""
	},
	{
		200391,
		"ui_canxiang_jiesuan",
		"ui.acb",
		""
	},
	{
		200392,
		"ui_canxiang_s",
		"ui.acb",
		""
	},
	{
		200393,
		"ui_canxiang_zhanshi_a",
		"ui.acb",
		""
	},
	{
		200394,
		"ui_canxiang_zhanshi_b",
		"ui.acb",
		""
	},
	{
		200395,
		"ui_canxiang_zhanshi_s",
		"ui.acb",
		""
	},
	{
		200396,
		"ui_canxiangkabao_into",
		"ui.acb",
		""
	},
	{
		400000,
		"speech_001105",
		"speech.acb",
		"speech.awb"
	},
	{
		400001,
		"speech_100039_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400002,
		"speech_100039_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400003,
		"speech_100039_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400004,
		"speech_100039_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400005,
		"speech_100039_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400006,
		"speech_100039_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400007,
		"speech_100039_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400008,
		"speech_100039_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400009,
		"speech_100039_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400010,
		"speech_100039_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400011,
		"speech_100039_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400012,
		"speech_100039_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400013,
		"speech_100039_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400014,
		"speech_100039_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400015,
		"speech_100039_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400016,
		"speech_100039_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400017,
		"speech_100039_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400018,
		"speech_100039_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400019,
		"speech_100039_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400020,
		"speech_100039_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400021,
		"speech_100039_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400022,
		"speech_100039_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400023,
		"speech_100039_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400024,
		"speech_100039_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400025,
		"speech_100039_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400026,
		"speech_100039_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400027,
		"speech_100039_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400028,
		"speech_100039_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400029,
		"speech_100039_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400030,
		"speech_100039_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		400031,
		"speech_100039_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400032,
		"speech_100039_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400033,
		"speech_100039_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400034,
		"speech_100039_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400035,
		"speech_100039_elishabai_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400036,
		"speech_100039_elishabai_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400037,
		"speech_100039_elishabai_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400038,
		"speech_100011_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400039,
		"speech_100011_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400040,
		"speech_100011_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400041,
		"speech_100011_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400042,
		"speech_100011_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400043,
		"speech_100011_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400044,
		"speech_100011_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400045,
		"speech_100011_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400046,
		"speech_100011_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400047,
		"speech_100011_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400048,
		"speech_100011_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400049,
		"speech_100011_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400050,
		"speech_100011_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400051,
		"speech_100011_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400052,
		"speech_100011_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400053,
		"speech_100011_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400054,
		"speech_100011_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400055,
		"speech_100011_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400056,
		"speech_100011_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400057,
		"speech_100011_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400058,
		"speech_100011_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400059,
		"speech_100011_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400060,
		"speech_100011_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400061,
		"speech_100011_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400062,
		"speech_100011_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400063,
		"speech_100011_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400064,
		"speech_100011_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400065,
		"speech_100011_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400066,
		"speech_100011_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400067,
		"speech_100011_caidan_06",
		"speech.acb",
		"speech.awb"
	},
	{
		400068,
		"speech_100011_caidan_05",
		"speech.acb",
		"speech.awb"
	},
	{
		400069,
		"speech_100011_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		400070,
		"speech_100011_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400071,
		"speech_100011_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400072,
		"speech_100011_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400073,
		"speech_100011_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400074,
		"speech_100011_yiyun_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400075,
		"speech_100011_yiyun_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400076,
		"speech_100011_yiyun_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400077,
		"speech_2000016_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400078,
		"speech_2000016_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400079,
		"speech_2000016_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400080,
		"speech_2000016_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400081,
		"speech_2000016_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400082,
		"speech_2000016_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400083,
		"speech_2000016_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400084,
		"speech_2000016_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400085,
		"speech_2000016_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400086,
		"speech_2000016_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400087,
		"speech_2000016_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400088,
		"speech_2000016_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400089,
		"speech_2000016_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400090,
		"speech_2000016_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400091,
		"speech_2000016_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400092,
		"speech_2000016_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400093,
		"speech_2000016_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400094,
		"speech_2000016_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400095,
		"speech_2000016_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400096,
		"speech_2000016_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400097,
		"speech_2000016_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400098,
		"speech_2000016_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400099,
		"speech_2000016_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400100,
		"speech_2000016_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400101,
		"speech_2000016_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400102,
		"speech_2000016_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400103,
		"speech_2000016_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400104,
		"speech_2000016_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400105,
		"speech_2000016_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400106,
		"speech_2000016_caidan_05",
		"speech.acb",
		"speech.awb"
	},
	{
		400107,
		"speech_2000016_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		400108,
		"speech_2000016_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400109,
		"speech_2000016_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400110,
		"speech_2000016_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400111,
		"speech_2000016_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400112,
		"speech_2000016_unique",
		"speech.acb",
		"speech.awb"
	},
	{
		400113,
		"speech_2000016_special",
		"speech.acb",
		"speech.awb"
	},
	{
		400114,
		"speech_2000016_attack",
		"speech.acb",
		"speech.awb"
	},
	{
		400115,
		"speech_100016_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400116,
		"speech_100016_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400117,
		"speech_100016_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400118,
		"speech_100016_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400119,
		"speech_100016_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400120,
		"speech_100016_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400121,
		"speech_100016_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400122,
		"speech_100016_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400123,
		"speech_100016_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400124,
		"speech_100016_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400125,
		"speech_100016_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400126,
		"speech_100016_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400127,
		"speech_100016_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400128,
		"speech_100016_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400129,
		"speech_100016_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400130,
		"speech_100016_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400131,
		"speech_100016_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400132,
		"speech_100016_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400133,
		"speech_100016_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400134,
		"speech_100016_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400135,
		"speech_100016_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400136,
		"speech_100016_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400137,
		"speech_100016_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400138,
		"speech_100016_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400139,
		"speech_100016_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400140,
		"speech_100016_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400141,
		"speech_100016_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400142,
		"speech_100016_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400143,
		"speech_100016_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400144,
		"speech_100016_caidan_05",
		"speech.acb",
		"speech.awb"
	},
	{
		400145,
		"speech_100016_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		400146,
		"speech_100016_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400147,
		"speech_100016_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400148,
		"speech_100016_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400149,
		"speech_100016_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400150,
		"speech_100016_yanhuo_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400151,
		"speech_100016_yanhuo_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400152,
		"speech_100016_yanhuo_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400153,
		"speech_100041_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400154,
		"speech_100041_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400155,
		"speech_100041_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400156,
		"speech_100041_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400157,
		"speech_100041_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400158,
		"speech_100041_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400159,
		"speech_100041_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400160,
		"speech_100041_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400161,
		"speech_100041_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400162,
		"speech_100041_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400163,
		"speech_100041_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400164,
		"speech_100041_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400165,
		"speech_100041_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400166,
		"speech_100041_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400167,
		"speech_100041_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400168,
		"speech_100041_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400169,
		"speech_100041_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400170,
		"speech_100041_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400171,
		"speech_100041_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400172,
		"speech_100041_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400173,
		"speech_100041_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400174,
		"speech_100041_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400175,
		"speech_100041_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400176,
		"speech_100041_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400177,
		"speech_100041_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400178,
		"speech_100041_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400179,
		"speech_100041_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400180,
		"speech_100041_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400181,
		"speech_100041_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400182,
		"speech_100041_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		400183,
		"speech_100041_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400184,
		"speech_100041_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400185,
		"speech_100041_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400186,
		"speech_100041_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400187,
		"speech_100041_xinderuila_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400188,
		"speech_100041_xinderuila_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400189,
		"speech_100041_xinderuila_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400190,
		"speech_100021_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400191,
		"speech_100021_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400192,
		"speech_100021_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400193,
		"speech_100021_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400194,
		"speech_100021_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400195,
		"speech_100021_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400196,
		"speech_100021_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400197,
		"speech_100021_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400198,
		"speech_100021_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400199,
		"speech_100021_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400200,
		"speech_100021_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400201,
		"speech_100021_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400202,
		"speech_100021_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400203,
		"speech_100021_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400204,
		"speech_100021_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400205,
		"speech_100021_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400206,
		"speech_100021_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400207,
		"speech_100021_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400208,
		"speech_100021_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400209,
		"speech_100021_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400210,
		"speech_100021_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400211,
		"speech_100021_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400212,
		"speech_100021_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400213,
		"speech_100021_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400214,
		"speech_100021_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400215,
		"speech_100021_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400216,
		"speech_100021_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400217,
		"speech_100021_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400218,
		"speech_100021_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400219,
		"speech_100021_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400220,
		"speech_100021_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400221,
		"speech_100021_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400222,
		"speech_100021_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400223,
		"speech_100021_muxue_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400224,
		"speech_100021_muxue_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400225,
		"speech_100021_muxue_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400226,
		"speech_2000055_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400227,
		"speech_2000055_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400228,
		"speech_2000055_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400229,
		"speech_2000055_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400230,
		"speech_2000055_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400231,
		"speech_2000055_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400232,
		"speech_2000055_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400233,
		"speech_2000055_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400234,
		"speech_2000055_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400235,
		"speech_2000055_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400236,
		"speech_2000055_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400237,
		"speech_2000055_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400238,
		"speech_2000055_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400239,
		"speech_2000055_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400240,
		"speech_2000055_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400241,
		"speech_2000055_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400242,
		"speech_2000055_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400243,
		"speech_2000055_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400244,
		"speech_2000055_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400245,
		"speech_2000055_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400246,
		"speech_2000055_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400247,
		"speech_2000055_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400248,
		"speech_2000055_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400249,
		"speech_2000055_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400250,
		"speech_2000055_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400251,
		"speech_2000055_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400252,
		"speech_2000055_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400253,
		"speech_2000055_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400254,
		"speech_2000055_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400255,
		"speech_2000055_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400256,
		"speech_2000055_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400257,
		"speech_2000055_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400258,
		"speech_2000055_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400259,
		"speech_2000055_unique",
		"speech.acb",
		"speech.awb"
	},
	{
		400260,
		"speech_2000055_special",
		"speech.acb",
		"speech.awb"
	},
	{
		400261,
		"speech_2000055_attack",
		"speech.acb",
		"speech.awb"
	},
	{
		400262,
		"speech_100055_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400263,
		"speech_100055_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400264,
		"speech_100055_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400265,
		"speech_100055_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400266,
		"speech_100055_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400267,
		"speech_100055_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400268,
		"speech_100055_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400269,
		"speech_100055_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400270,
		"speech_100055_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400271,
		"speech_100055_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400272,
		"speech_100055_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400273,
		"speech_100055_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400274,
		"speech_100055_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400275,
		"speech_100055_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400276,
		"speech_100055_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400277,
		"speech_100055_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400278,
		"speech_100055_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400279,
		"speech_100055_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400280,
		"speech_100055_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400281,
		"speech_100055_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400282,
		"speech_100055_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400283,
		"speech_100055_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400284,
		"speech_100055_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400285,
		"speech_100055_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400286,
		"speech_100055_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400287,
		"speech_100055_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400288,
		"speech_100055_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400289,
		"speech_100055_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400290,
		"speech_100055_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400291,
		"speech_100055_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400292,
		"speech_100055_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400293,
		"speech_100055_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400294,
		"speech_100055_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400295,
		"speech_100055_geligaolie_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400296,
		"speech_100055_geligaolie_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400297,
		"speech_100055_geligaolie_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400298,
		"speech_2000012_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400299,
		"speech_2000012_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400300,
		"speech_2000012_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400301,
		"speech_2000012_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400302,
		"speech_2000012_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400303,
		"speech_2000012_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400304,
		"speech_2000012_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400305,
		"speech_2000012_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400306,
		"speech_2000012_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400307,
		"speech_2000012_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400308,
		"speech_2000012_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400309,
		"speech_2000012_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400310,
		"speech_2000012_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400311,
		"speech_2000012_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400312,
		"speech_2000012_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400313,
		"speech_2000012_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400314,
		"speech_2000012_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400315,
		"speech_2000012_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400316,
		"speech_2000012_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400317,
		"speech_2000012_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400318,
		"speech_2000012_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400319,
		"speech_2000012_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400320,
		"speech_2000012_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400321,
		"speech_2000012_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400322,
		"speech_2000012_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400323,
		"speech_2000012_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400324,
		"speech_2000012_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400325,
		"speech_2000012_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400326,
		"speech_2000012_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400327,
		"speech_2000012_caidan_05",
		"speech.acb",
		"speech.awb"
	},
	{
		400328,
		"speech_2000012_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		400329,
		"speech_2000012_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400330,
		"speech_2000012_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400331,
		"speech_2000012_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400332,
		"speech_2000012_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400333,
		"speech_2000012_unique",
		"speech.acb",
		"speech.awb"
	},
	{
		400334,
		"speech_2000012_special",
		"speech.acb",
		"speech.awb"
	},
	{
		400335,
		"speech_2000012_attack",
		"speech.acb",
		"speech.awb"
	},
	{
		400336,
		"speech_100012_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400337,
		"speech_100012_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400338,
		"speech_100012_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400339,
		"speech_100012_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400340,
		"speech_100012_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400341,
		"speech_100012_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400342,
		"speech_100012_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400343,
		"speech_100012_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400344,
		"speech_100012_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400345,
		"speech_100012_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400346,
		"speech_100012_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400347,
		"speech_100012_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400348,
		"speech_100012_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400349,
		"speech_100012_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400350,
		"speech_100012_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400351,
		"speech_100012_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400352,
		"speech_100012_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400353,
		"speech_100012_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400354,
		"speech_100012_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400355,
		"speech_100012_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400356,
		"speech_100012_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400357,
		"speech_100012_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400358,
		"speech_100012_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400359,
		"speech_100012_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400360,
		"speech_100012_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400361,
		"speech_100012_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400362,
		"speech_100012_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400363,
		"speech_100012_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400364,
		"speech_100012_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400365,
		"speech_100012_caidan_05",
		"speech.acb",
		"speech.awb"
	},
	{
		400366,
		"speech_100012_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		400367,
		"speech_100012_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400368,
		"speech_100012_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400369,
		"speech_100012_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400370,
		"speech_100012_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400371,
		"speech_100012_fenlier_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400372,
		"speech_100012_fenlier_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400373,
		"speech_100012_fenlier_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400374,
		"speech_2000022_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400375,
		"speech_2000022_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400376,
		"speech_2000022_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400377,
		"speech_2000022_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400378,
		"speech_2000022_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400379,
		"speech_2000022_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400380,
		"speech_2000022_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400381,
		"speech_2000022_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400382,
		"speech_2000022_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400383,
		"speech_2000022_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400384,
		"speech_2000022_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400385,
		"speech_2000022_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400386,
		"speech_2000022_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400387,
		"speech_2000022_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400388,
		"speech_2000022_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400389,
		"speech_2000022_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400390,
		"speech_2000022_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400391,
		"speech_2000022_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400392,
		"speech_2000022_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400393,
		"speech_2000022_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400394,
		"speech_2000022_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400395,
		"speech_2000022_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400396,
		"speech_2000022_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400397,
		"speech_2000022_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400398,
		"speech_2000022_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400399,
		"speech_2000022_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400400,
		"speech_2000022_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400401,
		"speech_2000022_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400402,
		"speech_2000022_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400403,
		"speech_2000022_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		400404,
		"speech_2000022_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400405,
		"speech_2000022_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400406,
		"speech_2000022_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400407,
		"speech_2000022_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400408,
		"speech_2000022_unique",
		"speech.acb",
		"speech.awb"
	},
	{
		400409,
		"speech_2000022_special",
		"speech.acb",
		"speech.awb"
	},
	{
		400410,
		"speech_2000022_attack",
		"speech.acb",
		"speech.awb"
	},
	{
		400411,
		"speech_100022_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400412,
		"speech_100022_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400413,
		"speech_100022_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400414,
		"speech_100022_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400415,
		"speech_100022_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400416,
		"speech_100022_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400417,
		"speech_100022_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400418,
		"speech_100022_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400419,
		"speech_100022_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400420,
		"speech_100022_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400421,
		"speech_100022_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400422,
		"speech_100022_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400423,
		"speech_100022_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400424,
		"speech_100022_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400425,
		"speech_100022_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400426,
		"speech_100022_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400427,
		"speech_100022_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400428,
		"speech_100022_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400429,
		"speech_100022_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400430,
		"speech_100022_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400431,
		"speech_100022_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400432,
		"speech_100022_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400433,
		"speech_100022_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400434,
		"speech_100022_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400435,
		"speech_100022_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400436,
		"speech_100022_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400437,
		"speech_100022_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400438,
		"speech_100022_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400439,
		"speech_100022_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400440,
		"speech_100022_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		400441,
		"speech_100022_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400442,
		"speech_100022_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400443,
		"speech_100022_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400444,
		"speech_100022_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400445,
		"speech_100022_feiniao_unique_1_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400446,
		"speech_100022_feiniao_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400447,
		"speech_100022_feiniao_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400448,
		"speech_100057_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400449,
		"speech_100057_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400450,
		"speech_100057_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400451,
		"speech_100057_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400452,
		"speech_100057_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400453,
		"speech_100057_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400454,
		"speech_100057_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400455,
		"speech_100057_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400456,
		"speech_100057_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400457,
		"speech_100057_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400458,
		"speech_100057_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400459,
		"speech_100057_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400460,
		"speech_100057_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400461,
		"speech_100057_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400462,
		"speech_100057_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400463,
		"speech_100057_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400464,
		"speech_100057_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400465,
		"speech_100057_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400466,
		"speech_100057_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400467,
		"speech_100057_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400468,
		"speech_100057_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400469,
		"speech_100057_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400470,
		"speech_100057_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400471,
		"speech_100057_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400472,
		"speech_100057_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400473,
		"speech_100057_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400474,
		"speech_100057_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400475,
		"speech_100057_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400476,
		"speech_100057_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400477,
		"speech_100057_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		400478,
		"speech_100057_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400479,
		"speech_100057_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400480,
		"speech_100057_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400481,
		"speech_100057_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400482,
		"speech_100057_edipusi_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400483,
		"speech_100057_edipusi_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400484,
		"speech_100057_edipusi_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400485,
		"speech_2000036_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400486,
		"speech_2000036_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400487,
		"speech_2000036_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400488,
		"speech_2000036_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400489,
		"speech_2000036_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400490,
		"speech_2000036_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400491,
		"speech_2000036_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400492,
		"speech_2000036_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400493,
		"speech_2000036_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400494,
		"speech_2000036_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400495,
		"speech_2000036_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400496,
		"speech_2000036_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400497,
		"speech_2000036_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400498,
		"speech_2000036_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400499,
		"speech_2000036_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400500,
		"speech_2000036_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400501,
		"speech_2000036_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400502,
		"speech_2000036_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400503,
		"speech_2000036_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400504,
		"speech_2000036_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400505,
		"speech_2000036_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400506,
		"speech_2000036_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400507,
		"speech_2000036_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400508,
		"speech_2000036_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400509,
		"speech_2000036_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400510,
		"speech_2000036_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400511,
		"speech_2000036_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400512,
		"speech_2000036_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400513,
		"speech_2000036_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400514,
		"speech_2000036_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400515,
		"speech_2000036_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400516,
		"speech_2000036_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400517,
		"speech_2000036_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400518,
		"speech_2000036_unique",
		"speech.acb",
		"speech.awb"
	},
	{
		400519,
		"speech_2000036_special",
		"speech.acb",
		"speech.awb"
	},
	{
		400520,
		"speech_2000036_attack",
		"speech.acb",
		"speech.awb"
	},
	{
		400521,
		"speech_100036_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400522,
		"speech_100036_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400523,
		"speech_100036_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400524,
		"speech_100036_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400525,
		"speech_100036_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400526,
		"speech_100036_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400527,
		"speech_100036_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400528,
		"speech_100036_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400529,
		"speech_100036_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400530,
		"speech_100036_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400531,
		"speech_100036_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400532,
		"speech_100036_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400533,
		"speech_100036_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400534,
		"speech_100036_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400535,
		"speech_100036_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400536,
		"speech_100036_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400537,
		"speech_100036_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400538,
		"speech_100036_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400539,
		"speech_100036_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400540,
		"speech_100036_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400541,
		"speech_100036_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400542,
		"speech_100036_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400543,
		"speech_100036_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400544,
		"speech_100036_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400545,
		"speech_100036_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400546,
		"speech_100036_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400547,
		"speech_100036_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400548,
		"speech_100036_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400549,
		"speech_100036_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400550,
		"speech_100036_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400551,
		"speech_100036_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400552,
		"speech_100036_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400553,
		"speech_100036_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400554,
		"speech_100036_duoluoxi_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400555,
		"speech_100036_duoluoxi_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400556,
		"speech_100036_duoluoxi_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400557,
		"speech_100019_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400558,
		"speech_100019_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400559,
		"speech_100019_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400560,
		"speech_100019_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400561,
		"speech_100019_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400562,
		"speech_100019_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400563,
		"speech_100019_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400564,
		"speech_100019_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400565,
		"speech_100019_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400566,
		"speech_100019_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400567,
		"speech_100019_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400568,
		"speech_100019_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400569,
		"speech_100019_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400570,
		"speech_100019_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400571,
		"speech_100019_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400572,
		"speech_100019_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400573,
		"speech_100019_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400574,
		"speech_100019_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400575,
		"speech_100019_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400576,
		"speech_100019_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400577,
		"speech_100019_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400578,
		"speech_100019_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400579,
		"speech_100019_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400580,
		"speech_100019_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400581,
		"speech_100019_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400582,
		"speech_100019_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400583,
		"speech_100019_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400584,
		"speech_100019_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400585,
		"speech_100019_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400586,
		"speech_100019_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		400587,
		"speech_100019_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400588,
		"speech_100019_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400589,
		"speech_100019_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400590,
		"speech_100019_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400591,
		"speech_100019_duolian_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400592,
		"speech_100019_duolian_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400593,
		"speech_100019_duolian_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400594,
		"speech_2000028_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400595,
		"speech_2000028_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400596,
		"speech_2000028_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400597,
		"speech_2000028_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400598,
		"speech_2000028_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400599,
		"speech_2000028_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400600,
		"speech_2000028_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400601,
		"speech_2000028_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400602,
		"speech_2000028_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400603,
		"speech_2000028_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400604,
		"speech_2000028_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400605,
		"speech_2000028_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400606,
		"speech_2000028_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400607,
		"speech_2000028_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400608,
		"speech_2000028_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400609,
		"speech_2000028_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400610,
		"speech_2000028_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400611,
		"speech_2000028_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400612,
		"speech_2000028_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400613,
		"speech_2000028_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400614,
		"speech_2000028_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400615,
		"speech_2000028_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400616,
		"speech_2000028_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400617,
		"speech_2000028_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400618,
		"speech_2000028_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400619,
		"speech_2000028_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400620,
		"speech_2000028_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400621,
		"speech_2000028_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400622,
		"speech_2000028_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400623,
		"speech_2000028_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400624,
		"speech_2000028_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400625,
		"speech_2000028_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400626,
		"speech_2000028_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400627,
		"speech_2000028_unique",
		"speech.acb",
		"speech.awb"
	},
	{
		400628,
		"speech_2000028_special",
		"speech.acb",
		"speech.awb"
	},
	{
		400629,
		"speech_2000028_attack",
		"speech.acb",
		"speech.awb"
	},
	{
		400630,
		"speech_100028_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400631,
		"speech_100028_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400632,
		"speech_100028_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400633,
		"speech_100028_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400634,
		"speech_100028_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400635,
		"speech_100028_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400636,
		"speech_100028_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400637,
		"speech_100028_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400638,
		"speech_100028_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400639,
		"speech_100028_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400640,
		"speech_100028_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400641,
		"speech_100028_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400642,
		"speech_100028_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400643,
		"speech_100028_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400644,
		"speech_100028_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400645,
		"speech_100028_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400646,
		"speech_100028_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400647,
		"speech_100028_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400648,
		"speech_100028_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400649,
		"speech_100028_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400650,
		"speech_100028_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400651,
		"speech_100028_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400652,
		"speech_100028_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400653,
		"speech_100028_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400654,
		"speech_100028_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400655,
		"speech_100028_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400656,
		"speech_100028_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400657,
		"speech_100028_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400658,
		"speech_100028_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400659,
		"speech_100028_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400660,
		"speech_100028_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400661,
		"speech_100028_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400662,
		"speech_100028_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400663,
		"speech_100028_chuang_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400664,
		"speech_100028_chuang_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400665,
		"speech_100028_chuang_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400666,
		"speech_2000020_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400667,
		"speech_2000020_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400668,
		"speech_2000020_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400669,
		"speech_2000020_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400670,
		"speech_2000020_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400671,
		"speech_2000020_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400672,
		"speech_2000020_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400673,
		"speech_2000020_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400674,
		"speech_2000020_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400675,
		"speech_2000020_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400676,
		"speech_2000020_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400677,
		"speech_2000020_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400678,
		"speech_2000020_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400679,
		"speech_2000020_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400680,
		"speech_2000020_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400681,
		"speech_2000020_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400682,
		"speech_2000020_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400683,
		"speech_2000020_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400684,
		"speech_2000020_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400685,
		"speech_2000020_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400686,
		"speech_2000020_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400687,
		"speech_2000020_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400688,
		"speech_2000020_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400689,
		"speech_2000020_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400690,
		"speech_2000020_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400691,
		"speech_2000020_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400692,
		"speech_2000020_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400693,
		"speech_2000020_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400694,
		"speech_2000020_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400695,
		"speech_2000020_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		400696,
		"speech_2000020_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400697,
		"speech_2000020_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400698,
		"speech_2000020_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400699,
		"speech_2000020_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400700,
		"speech_2000020_unique",
		"speech.acb",
		"speech.awb"
	},
	{
		400701,
		"speech_2000020_special",
		"speech.acb",
		"speech.awb"
	},
	{
		400702,
		"speech_2000020_attack",
		"speech.acb",
		"speech.awb"
	},
	{
		400703,
		"speech_100020_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400704,
		"speech_100020_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400705,
		"speech_100020_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400706,
		"speech_100020_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400707,
		"speech_100020_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400708,
		"speech_100020_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400709,
		"speech_100020_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400710,
		"speech_100020_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400711,
		"speech_100020_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400712,
		"speech_100020_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400713,
		"speech_100020_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400714,
		"speech_100020_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400715,
		"speech_100020_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400716,
		"speech_100020_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400717,
		"speech_100020_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400718,
		"speech_100020_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400719,
		"speech_100020_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400720,
		"speech_100020_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400721,
		"speech_100020_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400722,
		"speech_100020_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400723,
		"speech_100020_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400724,
		"speech_100020_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400725,
		"speech_100020_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400726,
		"speech_100020_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400727,
		"speech_100020_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400728,
		"speech_100020_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400729,
		"speech_100020_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400730,
		"speech_100020_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400731,
		"speech_100020_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400732,
		"speech_100020_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		400733,
		"speech_100020_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400734,
		"speech_100020_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400735,
		"speech_100020_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400736,
		"speech_100020_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400737,
		"speech_100020_anbuleila_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400738,
		"speech_100020_anbuleila_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400739,
		"speech_100020_anbuleila_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400740,
		"speech_100056_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400741,
		"speech_100056_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400742,
		"speech_100056_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400743,
		"speech_100056_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400744,
		"speech_100056_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400745,
		"speech_100056_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400746,
		"speech_100056_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400747,
		"speech_100056_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400748,
		"speech_100056_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400749,
		"speech_100056_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400750,
		"speech_100056_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400751,
		"speech_100056_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400752,
		"speech_100056_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400753,
		"speech_100056_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400754,
		"speech_100056_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400755,
		"speech_100056_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400756,
		"speech_100056_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400757,
		"speech_100056_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400758,
		"speech_100056_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400759,
		"speech_100056_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400760,
		"speech_100056_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400761,
		"speech_100056_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400762,
		"speech_100056_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400763,
		"speech_100056_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400764,
		"speech_100056_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400765,
		"speech_100056_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400766,
		"speech_100056_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400767,
		"speech_100056_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400768,
		"speech_100056_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400769,
		"speech_100056_caidan_05",
		"speech.acb",
		"speech.awb"
	},
	{
		400770,
		"speech_100056_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		400771,
		"speech_100056_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400772,
		"speech_100056_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400773,
		"speech_100056_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400774,
		"speech_100056_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400775,
		"speech_100056_tiya_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400776,
		"speech_100056_tiya_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400777,
		"speech_100056_tiya_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400778,
		"speech_100013_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400779,
		"speech_100013_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400780,
		"speech_100013_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400781,
		"speech_100013_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400782,
		"speech_100013_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400783,
		"speech_100013_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400784,
		"speech_100013_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400785,
		"speech_100013_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400786,
		"speech_100013_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400787,
		"speech_100013_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400788,
		"speech_100013_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400789,
		"speech_100013_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400790,
		"speech_100013_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400791,
		"speech_100013_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400792,
		"speech_100013_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400793,
		"speech_100013_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400794,
		"speech_100013_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400795,
		"speech_100013_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400796,
		"speech_100013_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400797,
		"speech_100013_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400798,
		"speech_100013_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400799,
		"speech_100013_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400800,
		"speech_100013_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400801,
		"speech_100013_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400802,
		"speech_100013_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400803,
		"speech_100013_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400804,
		"speech_100013_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400805,
		"speech_100013_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400806,
		"speech_100013_chouka_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400807,
		"speech_100013_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		400808,
		"speech_100013_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400809,
		"speech_100013_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400810,
		"speech_100013_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400811,
		"speech_100013_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400812,
		"speech_100013_anniwei_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400813,
		"speech_100013_anniwei_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400814,
		"speech_100013_anniwei_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400815,
		"speech_2000013_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400816,
		"speech_2000013_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400817,
		"speech_2000013_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400818,
		"speech_2000013_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400819,
		"speech_2000013_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400820,
		"speech_2000013_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400821,
		"speech_2000013_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400822,
		"speech_2000013_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400823,
		"speech_2000013_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400824,
		"speech_2000013_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400825,
		"speech_2000013_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400826,
		"speech_2000013_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400827,
		"speech_2000039_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400828,
		"speech_2000013_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400829,
		"speech_2000039_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400830,
		"speech_2000013_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400831,
		"speech_2000039_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400832,
		"speech_2000013_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400833,
		"speech_2000013_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400834,
		"speech_2000013_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400835,
		"speech_2000013_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400836,
		"speech_2000039_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400837,
		"speech_2000013_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400838,
		"speech_2000039_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400839,
		"speech_2000013_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400840,
		"speech_2000039_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400841,
		"speech_2000041_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400842,
		"speech_2000013_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		400843,
		"speech_2000041_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400844,
		"speech_2000013_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		400845,
		"speech_2000041_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400846,
		"speech_2000019_unique",
		"speech.acb",
		"speech.awb"
	},
	{
		400847,
		"speech_2000013_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		400848,
		"speech_2000039_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400849,
		"speech_2000011_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400850,
		"speech_2000021_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400851,
		"speech_2000057_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400852,
		"speech_2000019_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400853,
		"speech_2000056_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400854,
		"speech_2000013_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		400855,
		"speech_2000011_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400856,
		"speech_2000021_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400857,
		"speech_2000057_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400858,
		"speech_2000019_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400859,
		"speech_2000056_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400860,
		"speech_2000013_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400861,
		"speech_2000011_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400862,
		"speech_2000041_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400863,
		"speech_2000021_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400864,
		"speech_2000057_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400865,
		"speech_2000019_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400866,
		"speech_2000056_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400867,
		"speech_2000013_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		400868,
		"speech_2000039_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400869,
		"speech_2000041_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400870,
		"speech_2000019_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400871,
		"speech_2000013_death",
		"speech.acb",
		"speech.awb"
	},
	{
		400872,
		"speech_2000039_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400873,
		"speech_2000041_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400874,
		"speech_2000013_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		400875,
		"speech_2000039_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400876,
		"speech_2000011_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400877,
		"speech_2000021_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400878,
		"speech_2000057_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400879,
		"speech_2000056_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400880,
		"speech_2000013_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		400881,
		"speech_2000011_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400882,
		"speech_2000021_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400883,
		"speech_2000057_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400884,
		"speech_2000019_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400885,
		"speech_2000056_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400886,
		"speech_2000013_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		400887,
		"speech_2000011_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400888,
		"speech_2000041_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400889,
		"speech_2000021_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400890,
		"speech_2000057_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400891,
		"speech_2000019_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400892,
		"speech_2000056_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400893,
		"speech_2000013_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		400894,
		"speech_2000019_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400895,
		"speech_2000013_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		400896,
		"speech_2000041_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400897,
		"speech_2000013_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		400898,
		"speech_2000011_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400899,
		"speech_2000041_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400900,
		"speech_2000021_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400901,
		"speech_2000057_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400902,
		"speech_2000056_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400903,
		"speech_2000013_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		400904,
		"speech_2000041_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400905,
		"speech_2000019_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400906,
		"speech_2000013_unique",
		"speech.acb",
		"speech.awb"
	},
	{
		400907,
		"speech_2000011_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400908,
		"speech_2000021_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400909,
		"speech_2000057_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400910,
		"speech_2000056_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400911,
		"speech_2000013_special",
		"speech.acb",
		"speech.awb"
	},
	{
		400912,
		"speech_2000039_unique",
		"speech.acb",
		"speech.awb"
	},
	{
		400913,
		"speech_2000011_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400914,
		"speech_2000021_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400915,
		"speech_2000057_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400916,
		"speech_2000019_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400917,
		"speech_2000056_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400918,
		"speech_2000013_attack",
		"speech.acb",
		"speech.awb"
	},
	{
		400919,
		"speech_2000039_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400920,
		"speech_2000011_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400921,
		"speech_2000021_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400922,
		"speech_2000057_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400923,
		"speech_2000019_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400924,
		"speech_2000056_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400925,
		"speech_100053_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		400926,
		"speech_2000041_unique",
		"speech.acb",
		"speech.awb"
	},
	{
		400927,
		"speech_2000019_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400928,
		"speech_100053_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		400929,
		"speech_2000039_special",
		"speech.acb",
		"speech.awb"
	},
	{
		400930,
		"speech_2000041_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400931,
		"speech_100053_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		400932,
		"speech_2000039_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400933,
		"speech_2000057_unique",
		"speech.acb",
		"speech.awb"
	},
	{
		400934,
		"speech_100053_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		400935,
		"speech_2000039_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400936,
		"speech_2000011_unique",
		"speech.acb",
		"speech.awb"
	},
	{
		400937,
		"speech_2000041_special",
		"speech.acb",
		"speech.awb"
	},
	{
		400938,
		"speech_2000021_unique",
		"speech.acb",
		"speech.awb"
	},
	{
		400939,
		"speech_2000057_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400940,
		"speech_2000056_unique",
		"speech.acb",
		"speech.awb"
	},
	{
		400941,
		"speech_100053_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		400942,
		"speech_2000039_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400943,
		"speech_2000011_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400944,
		"speech_2000041_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400945,
		"speech_2000021_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400946,
		"speech_2000056_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400947,
		"speech_100053_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		400948,
		"speech_2000039_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400949,
		"speech_2000041_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400950,
		"speech_2000057_special",
		"speech.acb",
		"speech.awb"
	},
	{
		400951,
		"speech_2000019_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400952,
		"speech_100053_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		400953,
		"speech_2000039_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400954,
		"speech_2000011_special",
		"speech.acb",
		"speech.awb"
	},
	{
		400955,
		"speech_2000041_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400956,
		"speech_2000057_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400957,
		"speech_2000056_special",
		"speech.acb",
		"speech.awb"
	},
	{
		400958,
		"speech_100053_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		400959,
		"speech_2000011_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400960,
		"speech_2000041_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400961,
		"speech_2000021_special",
		"speech.acb",
		"speech.awb"
	},
	{
		400962,
		"speech_2000057_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400963,
		"speech_2000019_special",
		"speech.acb",
		"speech.awb"
	},
	{
		400964,
		"speech_2000056_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400965,
		"speech_100053_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		400966,
		"speech_2000039_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400967,
		"speech_2000011_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400968,
		"speech_2000041_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400969,
		"speech_2000021_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400970,
		"speech_2000057_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400971,
		"speech_2000019_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		400972,
		"speech_2000056_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400973,
		"speech_100053_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		400974,
		"speech_2000039_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400975,
		"speech_2000011_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400976,
		"speech_2000041_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400977,
		"speech_2000021_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400978,
		"speech_2000057_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400979,
		"speech_2000019_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		400980,
		"speech_2000056_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400981,
		"speech_100053_aniya_unique_1_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400982,
		"speech_2000039_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400983,
		"speech_2000011_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400984,
		"speech_2000041_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		400985,
		"speech_2000021_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400986,
		"speech_2000057_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400987,
		"speech_2000019_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		400988,
		"speech_2000056_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400989,
		"speech_100053_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		400990,
		"speech_2000011_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400991,
		"speech_2000041_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		400992,
		"speech_2000021_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400993,
		"speech_2000057_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400994,
		"speech_2000019_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		400995,
		"speech_2000056_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		400996,
		"speech_100053_aniya_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		400997,
		"speech_2000011_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		400998,
		"speech_2000041_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		400999,
		"speech_2000021_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		401000,
		"speech_2000057_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		401001,
		"speech_2000019_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		401002,
		"speech_2000056_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		401003,
		"speech_100053_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401004,
		"speech_2000011_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		401005,
		"speech_2000041_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		401006,
		"speech_2000021_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		401007,
		"speech_2000057_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		401008,
		"speech_2000019_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		401009,
		"speech_2000056_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		401010,
		"speech_100053_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		401011,
		"speech_2000039_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		401012,
		"speech_2000011_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		401013,
		"speech_2000041_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		401014,
		"speech_2000021_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		401015,
		"speech_2000057_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		401016,
		"speech_2000019_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		401017,
		"speech_2000056_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		401018,
		"speech_100053_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		401019,
		"speech_2000039_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		401020,
		"speech_2000011_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		401021,
		"speech_2000041_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		401022,
		"speech_2000021_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		401023,
		"speech_2000057_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		401024,
		"speech_2000019_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		401025,
		"speech_2000056_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		401026,
		"speech_100053_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		401027,
		"speech_2000039_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		401028,
		"speech_2000011_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		401029,
		"speech_2000041_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		401030,
		"speech_2000021_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		401031,
		"speech_2000057_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		401032,
		"speech_2000019_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		401033,
		"speech_2000056_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		401034,
		"speech_100053_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		401035,
		"speech_2000039_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		401036,
		"speech_2000011_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		401037,
		"speech_2000041_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401038,
		"speech_2000021_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		401039,
		"speech_2000057_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		401040,
		"speech_2000019_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		401041,
		"speech_2000056_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		401042,
		"speech_100053_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		401043,
		"speech_2000011_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		401044,
		"speech_2000041_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401045,
		"speech_2000021_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		401046,
		"speech_2000057_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		401047,
		"speech_2000019_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		401048,
		"speech_2000056_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		401049,
		"speech_100053_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		401050,
		"speech_2000039_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		401051,
		"speech_2000011_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		401052,
		"speech_2000021_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		401053,
		"speech_2000057_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401054,
		"speech_2000019_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		401055,
		"speech_2000056_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		401056,
		"speech_100053_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		401057,
		"speech_2000039_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401058,
		"speech_2000011_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401059,
		"speech_2000041_death",
		"speech.acb",
		"speech.awb"
	},
	{
		401060,
		"speech_2000021_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		401061,
		"speech_2000019_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		401062,
		"speech_2000056_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401063,
		"speech_100053_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		401064,
		"speech_2000039_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401065,
		"speech_2000011_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401066,
		"speech_2000041_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		401067,
		"speech_2000021_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401068,
		"speech_2000057_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401069,
		"speech_2000019_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401070,
		"speech_2000056_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401071,
		"speech_100053_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		401072,
		"speech_2000041_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		401073,
		"speech_2000021_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401074,
		"speech_2000019_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401075,
		"speech_100053_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		401076,
		"speech_2000039_death",
		"speech.acb",
		"speech.awb"
	},
	{
		401077,
		"speech_2000011_death",
		"speech.acb",
		"speech.awb"
	},
	{
		401078,
		"speech_2000041_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		401079,
		"speech_2000056_death",
		"speech.acb",
		"speech.awb"
	},
	{
		401080,
		"speech_100053_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		401081,
		"speech_2000039_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		401082,
		"speech_2000011_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		401083,
		"speech_2000021_death",
		"speech.acb",
		"speech.awb"
	},
	{
		401084,
		"speech_2000057_death",
		"speech.acb",
		"speech.awb"
	},
	{
		401085,
		"speech_2000019_death",
		"speech.acb",
		"speech.awb"
	},
	{
		401086,
		"speech_2000056_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		401087,
		"speech_100053_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		401088,
		"speech_2000011_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		401089,
		"speech_2000041_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401090,
		"speech_2000021_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		401091,
		"speech_2000057_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		401092,
		"speech_2000019_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		401093,
		"speech_2000056_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		401094,
		"speech_100053_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401095,
		"speech_2000011_caidan_06",
		"speech.acb",
		"speech.awb"
	},
	{
		401096,
		"speech_2000041_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401097,
		"speech_2000021_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		401098,
		"speech_2000019_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		401099,
		"speech_2000056_caidan_05",
		"speech.acb",
		"speech.awb"
	},
	{
		401100,
		"speech_100053_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401101,
		"speech_2000039_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		401102,
		"speech_2000011_caidan_05",
		"speech.acb",
		"speech.awb"
	},
	{
		401103,
		"speech_2000041_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401104,
		"speech_2000021_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401105,
		"speech_2000057_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		401106,
		"speech_2000019_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		401107,
		"speech_2000056_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		401108,
		"speech_100053_death",
		"speech.acb",
		"speech.awb"
	},
	{
		401109,
		"speech_2000039_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		401110,
		"speech_2000011_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		401111,
		"speech_2000041_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		401112,
		"speech_2000021_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401113,
		"speech_2000057_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		401114,
		"speech_2000019_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401115,
		"speech_2000056_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401116,
		"speech_100053_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		401117,
		"speech_2000039_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401118,
		"speech_2000011_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401119,
		"speech_2000021_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401120,
		"speech_2000057_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401121,
		"speech_2000019_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401122,
		"speech_2000056_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401123,
		"speech_100053_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		401124,
		"speech_2000039_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401125,
		"speech_2000011_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401126,
		"speech_2000021_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		401127,
		"speech_2000057_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401128,
		"speech_2000019_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401129,
		"speech_2000056_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401130,
		"speech_100053_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401131,
		"speech_2000039_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401132,
		"speech_2000011_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401133,
		"speech_2000057_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401134,
		"speech_2000056_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		401135,
		"speech_100053_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401136,
		"speech_2000039_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		401137,
		"speech_2000011_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		401138,
		"speech_2000057_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		401139,
		"speech_100053_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401140,
		"speech_100053_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		401141,
		"speech_2000039_attack",
		"speech.acb",
		"speech.awb"
	},
	{
		401142,
		"speech_2000011_attack",
		"speech.acb",
		"speech.awb"
	},
	{
		401143,
		"speech_2000041_attack",
		"speech.acb",
		"speech.awb"
	},
	{
		401144,
		"speech_2000021_attack",
		"speech.acb",
		"speech.awb"
	},
	{
		401145,
		"speech_2000057_attack",
		"speech.acb",
		"speech.awb"
	},
	{
		401146,
		"speech_2000019_attack",
		"speech.acb",
		"speech.awb"
	},
	{
		401147,
		"speech_2000056_attack",
		"speech.acb",
		"speech.awb"
	},
	{
		401148,
		"speech_100053_aniya_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		401149,
		"speech_2000053_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		401150,
		"speech_2000053_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		401151,
		"speech_2000053_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		401152,
		"speech_2000053_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		401153,
		"speech_2000053_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		401154,
		"speech_2000053_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		401155,
		"speech_2000053_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		401156,
		"speech_2000053_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		401157,
		"speech_2000053_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		401158,
		"speech_2000053_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		401159,
		"speech_2000053_unique",
		"speech.acb",
		"speech.awb"
	},
	{
		401160,
		"speech_2000053_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		401161,
		"speech_2000053_special",
		"speech.acb",
		"speech.awb"
	},
	{
		401162,
		"speech_2000053_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401163,
		"speech_2000053_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		401164,
		"speech_2000053_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		401165,
		"speech_2000053_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		401166,
		"speech_2000053_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		401167,
		"speech_2000053_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		401168,
		"speech_2000053_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		401169,
		"speech_2000053_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		401170,
		"speech_2000053_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		401171,
		"speech_2000053_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		401172,
		"speech_2000053_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		401173,
		"speech_2000053_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		401174,
		"speech_2000053_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		401175,
		"speech_2000053_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401176,
		"speech_2000053_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401177,
		"speech_2000053_death",
		"speech.acb",
		"speech.awb"
	},
	{
		401178,
		"speech_2000053_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		401179,
		"speech_2000053_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		401180,
		"speech_2000053_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401181,
		"speech_2000053_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401182,
		"speech_2000053_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401183,
		"speech_2000053_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		401184,
		"speech_2000053_attack",
		"speech.acb",
		"speech.awb"
	},
	{
		401185,
		"speech_001108",
		"speech.acb",
		"speech.awb"
	},
	{
		401186,
		"speech_001107",
		"speech.acb",
		"speech.awb"
	},
	{
		401187,
		"speech_001106",
		"speech.acb",
		"speech.awb"
	},
	{
		401188,
		"speech_2000053_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401189,
		"speech_2000053_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401190,
		"speech_2000053_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401191,
		"speech_2000053_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401192,
		"speech_2000053_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401193,
		"speech_2000053_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401194,
		"speech_2000053_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401195,
		"speech_2000053_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401196,
		"speech_2000053_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401197,
		"speech_2000053_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401198,
		"speech_2000053_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401199,
		"speech_2000053_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401200,
		"speech_2000053_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401201,
		"speech_2000053_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401202,
		"speech_2000053_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401203,
		"speech_2000053_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401204,
		"speech_2000053_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401205,
		"speech_2000053_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401206,
		"speech_2000053_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401207,
		"speech_2000013_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401208,
		"speech_2000013_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401209,
		"speech_2000013_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401210,
		"speech_2000013_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401211,
		"speech_2000013_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401212,
		"speech_2000013_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401213,
		"speech_2000013_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401214,
		"speech_2000013_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401215,
		"speech_2000013_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401216,
		"speech_2000013_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401217,
		"speech_2000013_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401218,
		"speech_2000013_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401219,
		"speech_2000013_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401220,
		"speech_2000013_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401221,
		"speech_2000013_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401222,
		"speech_2000013_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401223,
		"speech_2000013_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401224,
		"speech_2000013_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401225,
		"speech_2000013_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401226,
		"speech_2000056_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401227,
		"speech_2000056_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401228,
		"speech_2000056_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401229,
		"speech_2000056_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401230,
		"speech_2000056_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401231,
		"speech_2000056_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401232,
		"speech_2000056_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401233,
		"speech_2000056_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401234,
		"speech_2000056_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401235,
		"speech_2000056_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401236,
		"speech_2000056_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401237,
		"speech_2000056_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401238,
		"speech_2000056_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401239,
		"speech_2000056_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401240,
		"speech_2000056_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401241,
		"speech_2000056_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401242,
		"speech_2000056_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401243,
		"speech_2000056_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401244,
		"speech_2000056_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401245,
		"speech_2000020_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401246,
		"speech_2000020_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401247,
		"speech_2000020_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401248,
		"speech_2000020_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401249,
		"speech_2000020_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401250,
		"speech_2000020_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401251,
		"speech_2000020_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401252,
		"speech_2000020_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401253,
		"speech_2000020_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401254,
		"speech_2000020_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401255,
		"speech_2000020_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401256,
		"speech_2000020_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401257,
		"speech_2000020_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401258,
		"speech_2000020_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401259,
		"speech_2000020_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401260,
		"speech_2000020_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401261,
		"speech_2000020_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401262,
		"speech_2000028_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401263,
		"speech_2000028_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401264,
		"speech_2000028_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401265,
		"speech_2000028_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401266,
		"speech_2000028_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401267,
		"speech_2000028_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401268,
		"speech_2000028_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401269,
		"speech_2000028_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401270,
		"speech_2000028_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401271,
		"speech_2000028_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401272,
		"speech_2000028_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401273,
		"speech_2000028_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401274,
		"speech_2000028_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401275,
		"speech_2000028_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401276,
		"speech_2000028_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401277,
		"speech_2000028_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401278,
		"speech_2000028_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401279,
		"speech_2000028_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401280,
		"speech_2000028_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401281,
		"speech_2000019_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401282,
		"speech_2000019_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401283,
		"speech_2000019_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401284,
		"speech_2000019_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401285,
		"speech_2000019_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401286,
		"speech_2000019_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401287,
		"speech_2000019_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401288,
		"speech_2000019_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401289,
		"speech_2000019_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401290,
		"speech_2000019_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401291,
		"speech_2000019_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401292,
		"speech_2000019_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401293,
		"speech_2000019_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401294,
		"speech_2000019_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401295,
		"speech_2000019_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401296,
		"speech_2000019_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401297,
		"speech_2000019_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401298,
		"speech_2000019_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401299,
		"speech_2000019_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401300,
		"speech_2000036_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401301,
		"speech_2000036_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401302,
		"speech_2000036_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401303,
		"speech_2000036_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401304,
		"speech_2000036_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401305,
		"speech_2000036_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401306,
		"speech_2000036_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401307,
		"speech_2000036_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401308,
		"speech_2000036_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401309,
		"speech_2000036_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401310,
		"speech_2000036_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401311,
		"speech_2000036_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401312,
		"speech_2000036_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401313,
		"speech_2000036_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401314,
		"speech_2000036_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401315,
		"speech_2000036_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401316,
		"speech_2000036_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401317,
		"speech_2000036_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401318,
		"speech_2000036_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401319,
		"speech_2000057_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401320,
		"speech_2000057_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401321,
		"speech_2000057_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401322,
		"speech_2000057_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401323,
		"speech_2000057_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401324,
		"speech_2000057_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401325,
		"speech_2000057_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401326,
		"speech_2000057_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401327,
		"speech_2000057_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401328,
		"speech_2000057_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401329,
		"speech_2000057_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401330,
		"speech_2000057_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401331,
		"speech_2000057_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401332,
		"speech_2000057_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401333,
		"speech_2000057_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401334,
		"speech_2000057_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401335,
		"speech_2000057_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401336,
		"speech_2000057_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401337,
		"speech_2000057_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401338,
		"speech_2000022_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401339,
		"speech_2000022_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401340,
		"speech_2000022_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401341,
		"speech_2000022_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401342,
		"speech_2000022_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401343,
		"speech_2000022_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401344,
		"speech_2000022_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401345,
		"speech_2000022_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401346,
		"speech_2000022_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401347,
		"speech_2000022_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401348,
		"speech_2000022_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401349,
		"speech_2000022_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401350,
		"speech_2000022_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401351,
		"speech_2000022_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401352,
		"speech_2000022_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401353,
		"speech_2000022_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401354,
		"speech_2000022_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401355,
		"speech_2000022_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401356,
		"speech_2000022_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401357,
		"speech_2000012_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401358,
		"speech_2000012_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401359,
		"speech_2000012_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401360,
		"speech_2000012_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401361,
		"speech_2000012_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401362,
		"speech_2000012_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401363,
		"speech_2000012_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401364,
		"speech_2000012_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401365,
		"speech_2000012_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401366,
		"speech_2000012_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401367,
		"speech_2000012_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401368,
		"speech_2000012_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401369,
		"speech_2000012_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401370,
		"speech_2000012_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401371,
		"speech_2000012_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401372,
		"speech_2000012_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401373,
		"speech_2000012_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401374,
		"speech_2000012_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401375,
		"speech_2000012_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401376,
		"speech_2000055_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401377,
		"speech_2000055_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401378,
		"speech_2000055_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401379,
		"speech_2000055_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401380,
		"speech_2000055_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401381,
		"speech_2000055_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401382,
		"speech_2000055_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401383,
		"speech_2000055_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401384,
		"speech_2000055_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401385,
		"speech_2000055_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401386,
		"speech_2000055_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401387,
		"speech_2000055_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401388,
		"speech_2000055_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401389,
		"speech_2000055_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401390,
		"speech_2000055_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401391,
		"speech_2000055_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401392,
		"speech_2000055_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401393,
		"speech_2000055_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401394,
		"speech_2000055_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401395,
		"speech_2000021_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401396,
		"speech_2000021_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401397,
		"speech_2000021_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401398,
		"speech_2000021_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401399,
		"speech_2000021_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401400,
		"speech_2000021_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401401,
		"speech_2000021_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401402,
		"speech_2000021_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401403,
		"speech_2000021_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401404,
		"speech_2000021_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401405,
		"speech_2000021_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401406,
		"speech_2000021_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401407,
		"speech_2000021_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401408,
		"speech_2000021_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401409,
		"speech_2000021_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401410,
		"speech_2000021_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401411,
		"speech_2000021_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401412,
		"speech_2000021_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401413,
		"speech_2000021_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401414,
		"speech_2000041_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401415,
		"speech_2000041_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401416,
		"speech_2000041_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401417,
		"speech_2000041_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401418,
		"speech_2000041_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401419,
		"speech_2000041_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401420,
		"speech_2000041_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401421,
		"speech_2000041_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401422,
		"speech_2000041_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401423,
		"speech_2000041_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401424,
		"speech_2000041_unique_04",
		"speech.acb",
		"speech.awb"
	},
	{
		401425,
		"speech_2000041_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401426,
		"speech_2000041_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401427,
		"speech_2000041_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401428,
		"speech_2000041_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401429,
		"speech_2000041_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401430,
		"speech_2000041_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401431,
		"speech_2000041_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401432,
		"speech_2000041_attack_04",
		"speech.acb",
		"speech.awb"
	},
	{
		401433,
		"speech_2000041_attack_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401434,
		"speech_2000041_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401435,
		"speech_2000041_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401436,
		"speech_2000016_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401437,
		"speech_2000016_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401438,
		"speech_2000016_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401439,
		"speech_2000016_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401440,
		"speech_2000016_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401441,
		"speech_2000016_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401442,
		"speech_2000016_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401443,
		"speech_2000016_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401444,
		"speech_2000016_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401445,
		"speech_2000016_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401446,
		"speech_2000016_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401447,
		"speech_2000016_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401448,
		"speech_2000016_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401449,
		"speech_2000016_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401450,
		"speech_2000016_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401451,
		"speech_2000016_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401452,
		"speech_2000016_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401453,
		"speech_2000016_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401454,
		"speech_2000016_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401455,
		"speech_2000011_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401456,
		"speech_2000011_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401457,
		"speech_2000011_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401458,
		"speech_2000011_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401459,
		"speech_2000011_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401460,
		"speech_2000011_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401461,
		"speech_2000011_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401462,
		"speech_2000011_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401463,
		"speech_2000011_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401464,
		"speech_2000011_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401465,
		"speech_2000011_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401466,
		"speech_2000011_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401467,
		"speech_2000011_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401468,
		"speech_2000011_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401469,
		"speech_2000011_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401470,
		"speech_2000011_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401471,
		"speech_2000011_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401472,
		"speech_2000011_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401473,
		"speech_2000011_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401474,
		"speech_2000039_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401475,
		"speech_2000039_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401476,
		"speech_2000039_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401477,
		"speech_2000039_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401478,
		"speech_2000039_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401479,
		"speech_2000039_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401480,
		"speech_2000039_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401481,
		"speech_2000039_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401482,
		"speech_2000039_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401483,
		"speech_2000039_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401484,
		"speech_2000039_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401485,
		"speech_2000039_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401486,
		"speech_2000039_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401487,
		"speech_2000039_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401488,
		"speech_2000039_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401489,
		"speech_2000039_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401490,
		"speech_2000039_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401491,
		"speech_2000039_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401492,
		"speech_2000039_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401493,
		"speech_2000020_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401494,
		"speech_2000020_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401495,
		"speech_2000030_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401496,
		"speech_2000030_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401497,
		"speech_2000030_attack_skip_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401498,
		"speech_2000030_attack_skip_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401499,
		"speech_2000030_attack_skip_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401500,
		"speech_2000030_attack_skip_04",
		"speech.acb",
		"speech.awb"
	},
	{
		401501,
		"speech_2000030_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		401502,
		"speech_2000030_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401503,
		"speech_2000030_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401504,
		"speech_2000030_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		401505,
		"speech_2000030_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		401506,
		"speech_2000030_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		401507,
		"speech_2000030_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401508,
		"speech_2000030_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401509,
		"speech_2000030_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401510,
		"speech_2000030_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401511,
		"speech_2000030_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		401512,
		"speech_2000030_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401513,
		"speech_2000030_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		401514,
		"speech_2000030_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		401515,
		"speech_2000030_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		401527,
		"speech_2000030_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		401528,
		"speech_2000030_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401529,
		"speech_2000030_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		401530,
		"speech_2000030_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		401531,
		"speech_2000030_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		401532,
		"speech_2000030_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		401533,
		"speech_2000030_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		401534,
		"speech_2000030_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		401535,
		"speech_2000030_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		401536,
		"speech_2000030_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		401537,
		"speech_2000030_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401538,
		"speech_2000030_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401539,
		"speech_2000030_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401540,
		"speech_2000030_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		401541,
		"speech_2000030_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401542,
		"speech_2000030_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401543,
		"speech_2000030_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401544,
		"speech_2000030_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		401545,
		"speech_2000030_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		401546,
		"speech_2000030_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401547,
		"speech_2000030_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401548,
		"speech_2000030_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401549,
		"speech_2000030_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401550,
		"speech_2000030_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401551,
		"speech_2000030_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		401552,
		"speech_2000030_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		401553,
		"speech_2000030_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401554,
		"speech_2000030_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401555,
		"speech_2000030_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401556,
		"speech_2000030_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401557,
		"speech_2000030_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401558,
		"speech_100030_bobosha_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		401560,
		"speech_100030_bobosha_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		401564,
		"speech_100030_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		401565,
		"speech_100030_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401566,
		"speech_100030_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401567,
		"speech_100030_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		401568,
		"speech_100030_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		401569,
		"speech_100030_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		401570,
		"speech_100030_death",
		"speech.acb",
		"speech.awb"
	},
	{
		401572,
		"speech_100030_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401573,
		"speech_100030_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401574,
		"speech_100030_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		401575,
		"speech_100030_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401576,
		"speech_100030_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		401577,
		"speech_100030_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		401578,
		"speech_100030_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		401579,
		"speech_100030_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		401585,
		"speech_100030_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		401586,
		"speech_100030_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		401590,
		"speech_100030_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		401591,
		"speech_100030_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401592,
		"speech_100030_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		401593,
		"speech_100030_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		401594,
		"speech_100030_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		401595,
		"speech_100030_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		401596,
		"speech_100030_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		401597,
		"speech_100030_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		401598,
		"speech_100030_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		401599,
		"speech_100030_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		401600,
		"speech_100030_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401601,
		"speech_100030_bobosha_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		401603,
		"speech_100030_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		401604,
		"speech_100030_bobosha_unique_1_p",
		"speech.acb",
		"speech.awb"
	},
	{
		401607,
		"speech_100030_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		401608,
		"speech_100030_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		401609,
		"speech_100030_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		401611,
		"speech_100030_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		401614,
		"speech_100030_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		401615,
		"speech_100030_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		401616,
		"speech_100030_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		401617,
		"speech_2000010_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401618,
		"speech_2000010_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401619,
		"speech_2000010_attack_skip_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401620,
		"speech_2000010_attack_skip_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401621,
		"speech_2000010_attack_skip_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401622,
		"speech_2000010_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		401623,
		"speech_2000010_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401624,
		"speech_2000010_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401625,
		"speech_2000010_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		401626,
		"speech_2000010_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		401627,
		"speech_2000010_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		401628,
		"speech_2000010_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401629,
		"speech_2000010_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401630,
		"speech_2000010_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401631,
		"speech_2000010_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401633,
		"speech_2000010_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		401634,
		"speech_2000010_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401635,
		"speech_2000010_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		401636,
		"speech_2000010_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		401637,
		"speech_2000010_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		401647,
		"speech_2000010_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401648,
		"speech_2000010_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401649,
		"speech_2000010_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		401650,
		"speech_2000010_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401651,
		"speech_2000010_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		401652,
		"speech_2000010_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		401653,
		"speech_2000010_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		401654,
		"speech_2000010_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		401655,
		"speech_2000010_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		401656,
		"speech_2000010_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		401657,
		"speech_2000010_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		401658,
		"speech_2000010_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		401659,
		"speech_2000010_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401660,
		"speech_2000010_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401661,
		"speech_2000010_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401662,
		"speech_2000010_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		401663,
		"speech_2000010_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401664,
		"speech_2000010_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401665,
		"speech_2000010_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401666,
		"speech_2000010_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		401667,
		"speech_2000010_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		401668,
		"speech_2000010_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401669,
		"speech_2000010_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401670,
		"speech_2000010_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401671,
		"speech_2000010_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401672,
		"speech_2000010_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401673,
		"speech_2000010_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		401674,
		"speech_2000010_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		401675,
		"speech_2000010_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401676,
		"speech_2000010_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401677,
		"speech_2000010_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401678,
		"speech_100010_linxiao_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		401680,
		"speech_100010_linxiao_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		401683,
		"speech_100010_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		401684,
		"speech_100010_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401685,
		"speech_100010_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401686,
		"speech_100010_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		401687,
		"speech_100010_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		401688,
		"speech_100010_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		401689,
		"speech_100010_death",
		"speech.acb",
		"speech.awb"
	},
	{
		401691,
		"speech_100010_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401692,
		"speech_100010_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401693,
		"speech_100010_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		401694,
		"speech_100010_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401695,
		"speech_100010_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		401696,
		"speech_100010_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		401697,
		"speech_100010_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		401698,
		"speech_100010_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		401704,
		"speech_100010_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		401705,
		"speech_100010_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		401709,
		"speech_100010_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		401710,
		"speech_100010_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401711,
		"speech_100010_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		401712,
		"speech_100010_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		401713,
		"speech_100010_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		401714,
		"speech_100010_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		401715,
		"speech_100010_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		401716,
		"speech_100010_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		401717,
		"speech_100010_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		401718,
		"speech_100010_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		401719,
		"speech_100010_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401720,
		"speech_100010_linxiao_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		401722,
		"speech_100010_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		401723,
		"speech_100010_linxiao_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		401726,
		"speech_100010_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		401727,
		"speech_100010_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		401728,
		"speech_100010_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		401730,
		"speech_100010_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		401733,
		"speech_100010_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		401734,
		"speech_100010_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		401735,
		"speech_100010_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		401736,
		"speech_2000025_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401737,
		"speech_2000025_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401738,
		"speech_2000025_attack_skip_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401739,
		"speech_2000025_attack_skip_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401740,
		"speech_2000025_attack_skip_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401741,
		"speech_2000025_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		401742,
		"speech_2000025_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401743,
		"speech_2000025_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401744,
		"speech_2000025_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401745,
		"speech_2000025_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		401746,
		"speech_2000025_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		401747,
		"speech_2000025_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401748,
		"speech_2000025_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401749,
		"speech_2000025_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401750,
		"speech_2000025_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401751,
		"speech_2000025_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		401752,
		"speech_2000025_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401753,
		"speech_2000025_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		401754,
		"speech_2000025_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		401755,
		"speech_2000025_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		401765,
		"speech_2000025_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401766,
		"speech_2000025_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401767,
		"speech_2000025_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		401769,
		"speech_2000025_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401770,
		"speech_2000025_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		401771,
		"speech_2000025_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		401772,
		"speech_2000025_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		401773,
		"speech_2000025_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		401774,
		"speech_2000025_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		401775,
		"speech_2000025_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		401776,
		"speech_2000025_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		401777,
		"speech_2000025_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		401778,
		"speech_2000025_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401779,
		"speech_2000025_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401780,
		"speech_2000025_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401781,
		"speech_2000025_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		401782,
		"speech_2000025_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401783,
		"speech_2000025_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401784,
		"speech_2000025_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401785,
		"speech_2000025_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		401786,
		"speech_2000025_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		401787,
		"speech_2000025_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401788,
		"speech_2000025_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401789,
		"speech_2000025_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401790,
		"speech_2000025_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401791,
		"speech_2000025_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401792,
		"speech_2000025_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		401793,
		"speech_2000025_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		401794,
		"speech_2000025_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401795,
		"speech_2000025_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401796,
		"speech_2000025_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401797,
		"speech_100025_linhuo_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		401799,
		"speech_100025_linhuo_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		401802,
		"speech_100025_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		401803,
		"speech_100025_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401804,
		"speech_100025_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401805,
		"speech_100025_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401806,
		"speech_100025_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		401807,
		"speech_100025_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		401808,
		"speech_100025_death",
		"speech.acb",
		"speech.awb"
	},
	{
		401810,
		"speech_100025_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401811,
		"speech_100025_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401812,
		"speech_100025_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		401813,
		"speech_100025_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401814,
		"speech_100025_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		401815,
		"speech_100025_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		401816,
		"speech_100025_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		401817,
		"speech_100025_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		401823,
		"speech_100025_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		401824,
		"speech_100025_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		401828,
		"speech_100025_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		401830,
		"speech_100025_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401831,
		"speech_100025_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		401832,
		"speech_100025_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		401833,
		"speech_100025_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		401834,
		"speech_100025_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		401835,
		"speech_100025_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		401836,
		"speech_100025_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		401837,
		"speech_100025_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		401838,
		"speech_100025_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		401839,
		"speech_100025_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401840,
		"speech_100025_linhuo_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		401842,
		"speech_100025_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		401843,
		"speech_100025_linhuo_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		401846,
		"speech_100025_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		401847,
		"speech_100025_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		401848,
		"speech_100025_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		401850,
		"speech_100025_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		401853,
		"speech_100025_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		401854,
		"speech_100025_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		401855,
		"speech_100025_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		401856,
		"speech_2000008_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401857,
		"speech_2000008_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401858,
		"speech_2000008_attack_skip_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401859,
		"speech_2000008_attack_skip_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401860,
		"speech_2000008_attack_skip_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401861,
		"speech_2000008_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		401862,
		"speech_2000008_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401863,
		"speech_2000008_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401864,
		"speech_2000008_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401865,
		"speech_2000008_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		401866,
		"speech_2000008_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		401867,
		"speech_2000008_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401868,
		"speech_2000008_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401869,
		"speech_2000008_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401870,
		"speech_2000008_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401871,
		"speech_2000008_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		401872,
		"speech_2000008_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401873,
		"speech_2000008_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		401874,
		"speech_2000008_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		401875,
		"speech_2000008_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		401885,
		"speech_2000008_hit_10",
		"speech.acb",
		"speech.awb"
	},
	{
		401886,
		"speech_2000008_hit_11",
		"speech.acb",
		"speech.awb"
	},
	{
		401887,
		"speech_2000008_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		401888,
		"speech_2000008_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401889,
		"speech_2000008_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		401890,
		"speech_2000008_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		401891,
		"speech_2000008_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		401892,
		"speech_2000008_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		401893,
		"speech_2000008_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		401894,
		"speech_2000008_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		401895,
		"speech_2000008_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		401896,
		"speech_2000008_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		401897,
		"speech_2000008_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401898,
		"speech_2000008_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401899,
		"speech_2000008_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401900,
		"speech_2000008_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		401901,
		"speech_2000008_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401902,
		"speech_2000008_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401903,
		"speech_2000008_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401904,
		"speech_2000008_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		401905,
		"speech_2000008_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		401906,
		"speech_2000008_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401907,
		"speech_2000008_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401908,
		"speech_2000008_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401909,
		"speech_2000008_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401910,
		"speech_2000008_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401911,
		"speech_2000008_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		401912,
		"speech_2000008_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		401913,
		"speech_2000008_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401914,
		"speech_2000008_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401915,
		"speech_2000008_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401916,
		"speech_100008_liufenyi_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		401918,
		"speech_100008_liufenyi_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		401921,
		"speech_100008_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		401922,
		"speech_100008_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401923,
		"speech_100008_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401924,
		"speech_100008_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401925,
		"speech_100008_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		401926,
		"speech_100008_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		401927,
		"speech_100008_death",
		"speech.acb",
		"speech.awb"
	},
	{
		401929,
		"speech_100008_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401930,
		"speech_100008_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401931,
		"speech_100008_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		401932,
		"speech_100008_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401933,
		"speech_100008_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		401934,
		"speech_100008_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		401935,
		"speech_100008_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		401936,
		"speech_100008_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		401942,
		"speech_100008_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		401943,
		"speech_100008_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		401947,
		"speech_100008_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		401948,
		"speech_100008_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401949,
		"speech_100008_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		401950,
		"speech_100008_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		401951,
		"speech_100008_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		401952,
		"speech_100008_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		401953,
		"speech_100008_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		401954,
		"speech_100008_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		401955,
		"speech_100008_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		401956,
		"speech_100008_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		401957,
		"speech_100008_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401958,
		"speech_100008_liufenyi_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		401960,
		"speech_100008_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		401961,
		"speech_100008_liufenyi_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		401964,
		"speech_100008_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		401965,
		"speech_100008_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		401966,
		"speech_100008_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		401968,
		"speech_100008_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		401971,
		"speech_100008_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		401972,
		"speech_100008_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		401973,
		"speech_100008_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		401974,
		"speech_2000007_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401975,
		"speech_2000007_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401976,
		"speech_2000007_attack_skip_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401977,
		"speech_2000007_attack_skip_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401978,
		"speech_2000007_attack_skip_03",
		"speech.acb",
		"speech.awb"
	},
	{
		401979,
		"speech_2000007_attack_skip_04",
		"speech.acb",
		"speech.awb"
	},
	{
		401980,
		"speech_2000007_attack_skip_05",
		"speech.acb",
		"speech.awb"
	},
	{
		401981,
		"speech_2000007_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		401982,
		"speech_2000007_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401983,
		"speech_2000007_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		401984,
		"speech_2000007_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		401985,
		"speech_2000007_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		401986,
		"speech_2000007_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		401987,
		"speech_2000007_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		401988,
		"speech_2000007_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401990,
		"speech_2000007_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		401991,
		"speech_2000007_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		401992,
		"speech_2000007_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		401993,
		"speech_2000007_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		401994,
		"speech_2000007_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		401995,
		"speech_2000007_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		402005,
		"speech_2000007_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402006,
		"speech_2000007_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402007,
		"speech_2000007_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		402008,
		"speech_2000007_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402009,
		"speech_2000007_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		402010,
		"speech_2000007_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		402011,
		"speech_2000007_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		402012,
		"speech_2000007_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		402013,
		"speech_2000007_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		402014,
		"speech_2000007_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		402015,
		"speech_2000007_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		402016,
		"speech_2000007_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		402017,
		"speech_2000007_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402018,
		"speech_2000007_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402019,
		"speech_2000007_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402020,
		"speech_2000007_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		402021,
		"speech_2000007_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402022,
		"speech_2000007_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402023,
		"speech_2000007_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402024,
		"speech_2000007_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		402025,
		"speech_2000007_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		402026,
		"speech_2000007_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402027,
		"speech_2000007_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402028,
		"speech_2000007_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402029,
		"speech_2000007_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402030,
		"speech_2000007_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402031,
		"speech_2000007_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		402032,
		"speech_2000007_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		402033,
		"speech_2000007_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402034,
		"speech_2000007_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402035,
		"speech_2000007_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402036,
		"speech_100007_oujilide_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402038,
		"speech_100007_oujilide_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402043,
		"speech_100007_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		402044,
		"speech_100007_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402045,
		"speech_100007_caidan_04",
		"speech.acb",
		"speech.awb"
	},
	{
		402046,
		"speech_100007_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		402047,
		"speech_100007_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		402048,
		"speech_100007_death",
		"speech.acb",
		"speech.awb"
	},
	{
		402050,
		"speech_100007_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402051,
		"speech_100007_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402052,
		"speech_100007_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402053,
		"speech_100007_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402054,
		"speech_100007_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		402055,
		"speech_100007_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		402056,
		"speech_100007_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		402057,
		"speech_100007_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		402063,
		"speech_100007_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		402064,
		"speech_100007_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		402068,
		"speech_100007_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		402069,
		"speech_100007_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402070,
		"speech_100007_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		402071,
		"speech_100007_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		402072,
		"speech_100007_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		402073,
		"speech_100007_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		402074,
		"speech_100007_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		402075,
		"speech_100007_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		402076,
		"speech_100007_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		402077,
		"speech_100007_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		402078,
		"speech_100007_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402079,
		"speech_100007_oujilide_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402081,
		"speech_100007_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		402083,
		"speech_100007_oujilide_unique_1_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402085,
		"speech_100007_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		402086,
		"speech_100007_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		402087,
		"speech_100007_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		402089,
		"speech_100007_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		402092,
		"speech_100007_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		402093,
		"speech_100007_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		402094,
		"speech_100007_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		402095,
		"speech_2000005_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402096,
		"speech_2000005_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402097,
		"speech_2000005_attack_skip_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402098,
		"speech_2000005_attack_skip_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402099,
		"speech_2000005_attack_skip_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402100,
		"speech_2000005_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		402101,
		"speech_2000005_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402102,
		"speech_2000005_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402103,
		"speech_2000005_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402104,
		"speech_2000005_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		402105,
		"speech_2000005_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		402106,
		"speech_2000005_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402107,
		"speech_2000005_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402108,
		"speech_2000005_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402109,
		"speech_2000005_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402110,
		"speech_2000005_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402111,
		"speech_2000005_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402112,
		"speech_2000005_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		402113,
		"speech_2000005_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		402114,
		"speech_2000005_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		402124,
		"speech_2000005_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402125,
		"speech_2000005_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402126,
		"speech_2000005_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		402127,
		"speech_2000005_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402128,
		"speech_2000005_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		402129,
		"speech_2000005_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		402130,
		"speech_2000005_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		402131,
		"speech_2000005_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		402132,
		"speech_2000005_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		402133,
		"speech_2000005_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		402134,
		"speech_2000005_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		402135,
		"speech_2000005_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		402136,
		"speech_2000005_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402137,
		"speech_2000005_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402138,
		"speech_2000005_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402139,
		"speech_2000005_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		402140,
		"speech_2000005_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402141,
		"speech_2000005_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402142,
		"speech_2000005_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402143,
		"speech_2000005_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		402144,
		"speech_2000005_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		402145,
		"speech_2000005_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402146,
		"speech_2000005_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402147,
		"speech_2000005_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402148,
		"speech_2000005_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402149,
		"speech_2000005_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402150,
		"speech_2000005_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		402151,
		"speech_2000005_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		402152,
		"speech_2000005_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402153,
		"speech_2000005_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402154,
		"speech_2000005_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402155,
		"speech_100005_huanxing_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402157,
		"speech_100005_huanxing_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402160,
		"speech_100005_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		402161,
		"speech_100005_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402162,
		"speech_100005_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402163,
		"speech_100005_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402164,
		"speech_100005_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		402165,
		"speech_100005_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		402166,
		"speech_100005_death",
		"speech.acb",
		"speech.awb"
	},
	{
		402168,
		"speech_100005_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402169,
		"speech_100005_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402170,
		"speech_100005_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402171,
		"speech_100005_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402172,
		"speech_100005_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		402173,
		"speech_100005_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		402174,
		"speech_100005_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		402175,
		"speech_100005_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		402181,
		"speech_100005_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		402182,
		"speech_100005_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		402186,
		"speech_100005_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		402187,
		"speech_100005_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402188,
		"speech_100005_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		402189,
		"speech_100005_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		402190,
		"speech_100005_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		402191,
		"speech_100005_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		402192,
		"speech_100005_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		402193,
		"speech_100005_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		402194,
		"speech_100005_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		402195,
		"speech_100005_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		402196,
		"speech_100005_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402197,
		"speech_100005_huanxing_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402199,
		"speech_100005_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		402200,
		"speech_100005_huanxing_unique_1_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402203,
		"speech_100005_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		402204,
		"speech_100005_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		402205,
		"speech_100005_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		402207,
		"speech_100005_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		402210,
		"speech_100005_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		402211,
		"speech_100005_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		402212,
		"speech_100005_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		402213,
		"speech_100013_anniwei_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402214,
		"speech_2000013_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402215,
		"speech_2000013_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402216,
		"speech_2000013_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402217,
		"speech_100013_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402218,
		"speech_100013_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402219,
		"speech_100013_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402220,
		"speech_100057_edipusi_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402221,
		"speech_2000057_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402222,
		"speech_2000057_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402223,
		"speech_2000057_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402224,
		"speech_100057_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402225,
		"speech_100057_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402226,
		"speech_100057_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402227,
		"speech_100016_yanhuo_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402228,
		"speech_2000016_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402229,
		"speech_2000016_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402230,
		"speech_2000016_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402231,
		"speech_100016_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402232,
		"speech_100016_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402233,
		"speech_100016_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402234,
		"speech_100053_aniya_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402235,
		"speech_2000053_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402236,
		"speech_2000053_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402237,
		"speech_2000053_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402238,
		"speech_100053_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402239,
		"speech_100053_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402240,
		"speech_100053_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402241,
		"speech_2000047_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402242,
		"speech_2000047_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402243,
		"speech_2000047_attack_skip_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402244,
		"speech_2000047_attack_skip_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402245,
		"speech_2000047_attack_skip_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402246,
		"speech_2000047_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		402247,
		"speech_2000047_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402248,
		"speech_2000047_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402249,
		"speech_2000047_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402250,
		"speech_2000047_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		402251,
		"speech_2000047_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		402254,
		"speech_2000047_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402255,
		"speech_2000047_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402256,
		"speech_2000047_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402257,
		"speech_2000047_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402258,
		"speech_2000047_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		402259,
		"speech_2000047_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		402260,
		"speech_2000047_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		402270,
		"speech_2000047_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402271,
		"speech_2000047_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402272,
		"speech_2000047_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		402273,
		"speech_2000047_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402274,
		"speech_2000047_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		402275,
		"speech_2000047_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		402276,
		"speech_2000047_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		402277,
		"speech_2000047_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		402278,
		"speech_2000047_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		402279,
		"speech_2000047_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		402280,
		"speech_2000047_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		402281,
		"speech_2000047_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		402282,
		"speech_2000047_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402283,
		"speech_2000047_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402284,
		"speech_2000047_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402285,
		"speech_2000047_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		402286,
		"speech_2000047_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402287,
		"speech_2000047_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402288,
		"speech_2000047_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402289,
		"speech_2000047_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		402290,
		"speech_2000047_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		402291,
		"speech_2000047_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402292,
		"speech_2000047_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402293,
		"speech_2000047_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402294,
		"speech_2000047_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402295,
		"speech_2000047_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402296,
		"speech_2000047_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		402297,
		"speech_2000047_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		402298,
		"speech_2000047_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402299,
		"speech_2000047_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402300,
		"speech_2000047_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402301,
		"speech_2000047_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402302,
		"speech_2000047_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402303,
		"speech_100047_aojieta_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402305,
		"speech_100047_aojieta_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402308,
		"speech_100047_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		402309,
		"speech_100047_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402310,
		"speech_100047_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402311,
		"speech_100047_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402312,
		"speech_100047_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		402313,
		"speech_100047_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		402314,
		"speech_100047_death",
		"speech.acb",
		"speech.awb"
	},
	{
		402316,
		"speech_100047_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402317,
		"speech_100047_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402318,
		"speech_100047_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402319,
		"speech_100047_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402320,
		"speech_100047_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		402321,
		"speech_100047_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		402322,
		"speech_100047_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		402323,
		"speech_100047_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		402334,
		"speech_100047_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		402335,
		"speech_100047_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402336,
		"speech_100047_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		402337,
		"speech_100047_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		402338,
		"speech_100047_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		402339,
		"speech_100047_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		402340,
		"speech_100047_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		402341,
		"speech_100047_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		402342,
		"speech_100047_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		402343,
		"speech_100047_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		402344,
		"speech_100047_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402345,
		"speech_100047_aojieta_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402347,
		"speech_100047_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		402348,
		"speech_100047_aojieta_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402351,
		"speech_100047_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		402352,
		"speech_100047_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		402353,
		"speech_100047_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		402355,
		"speech_2000047_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		402358,
		"speech_100047_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		402359,
		"speech_100047_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		402360,
		"speech_2000047_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		402361,
		"speech_100047_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		402362,
		"speech_100047_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		402363,
		"speech_100028_chuang_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402364,
		"speech_2000028_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402365,
		"speech_2000028_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402366,
		"speech_2000028_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402367,
		"speech_100028_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402368,
		"speech_100028_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402369,
		"speech_100028_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402370,
		"speech_100022_feiniao_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402371,
		"speech_2000022_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402372,
		"speech_2000022_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402373,
		"speech_2000022_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402374,
		"speech_100022_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402375,
		"speech_100022_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402376,
		"speech_100022_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402377,
		"speech_100012_fenlier_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402378,
		"speech_2000012_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402379,
		"speech_2000012_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402380,
		"speech_2000012_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402381,
		"speech_100012_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402382,
		"speech_100012_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402383,
		"speech_100012_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402384,
		"speech_2000031_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402385,
		"speech_2000031_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402386,
		"speech_2000031_attack_skip_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402387,
		"speech_2000031_attack_skip_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402388,
		"speech_2000031_attack_skip_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402389,
		"speech_2000031_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		402390,
		"speech_2000031_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402391,
		"speech_2000031_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402392,
		"speech_2000031_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402393,
		"speech_2000031_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		402394,
		"speech_2000031_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		402395,
		"speech_2000031_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402396,
		"speech_2000031_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402397,
		"speech_2000031_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402398,
		"speech_2000031_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402399,
		"speech_2000031_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402400,
		"speech_2000031_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402401,
		"speech_2000031_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		402402,
		"speech_2000031_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		402403,
		"speech_2000031_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		402413,
		"speech_2000031_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402414,
		"speech_2000031_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402415,
		"speech_2000031_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		402416,
		"speech_2000031_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402417,
		"speech_2000031_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		402418,
		"speech_2000031_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		402419,
		"speech_2000031_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		402420,
		"speech_2000031_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		402421,
		"speech_2000031_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		402422,
		"speech_2000031_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		402423,
		"speech_2000031_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		402424,
		"speech_2000031_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		402425,
		"speech_2000031_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402426,
		"speech_2000031_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402427,
		"speech_2000031_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402428,
		"speech_2000031_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		402429,
		"speech_2000031_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402430,
		"speech_2000031_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402431,
		"speech_2000031_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402432,
		"speech_2000031_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		402433,
		"speech_2000031_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		402434,
		"speech_2000031_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402435,
		"speech_2000031_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402436,
		"speech_2000031_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402437,
		"speech_2000031_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402438,
		"speech_2000031_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402439,
		"speech_2000031_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		402440,
		"speech_2000031_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		402441,
		"speech_2000031_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402442,
		"speech_2000031_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402443,
		"speech_2000031_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402444,
		"speech_100031_kabuqinuo_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402446,
		"speech_100031_kabuqinuo_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402449,
		"speech_100031_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		402450,
		"speech_100031_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402451,
		"speech_100031_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402452,
		"speech_100031_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402453,
		"speech_100031_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		402454,
		"speech_100031_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		402455,
		"speech_100031_death",
		"speech.acb",
		"speech.awb"
	},
	{
		402457,
		"speech_100031_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402458,
		"speech_100031_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402459,
		"speech_100031_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402460,
		"speech_100031_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402461,
		"speech_100031_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		402462,
		"speech_100031_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		402463,
		"speech_100031_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		402464,
		"speech_100031_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		402470,
		"speech_100031_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		402471,
		"speech_100031_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		402475,
		"speech_100031_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		402476,
		"speech_100031_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402477,
		"speech_100031_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		402478,
		"speech_100031_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		402479,
		"speech_100031_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		402480,
		"speech_100031_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		402481,
		"speech_100031_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		402482,
		"speech_100031_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		402483,
		"speech_100031_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		402484,
		"speech_100031_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		402485,
		"speech_100031_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402486,
		"speech_100031_kabuqinuo_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402488,
		"speech_100031_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		402490,
		"speech_100031_kabuqinuo_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402492,
		"speech_100031_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		402493,
		"speech_100031_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		402494,
		"speech_100031_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		402496,
		"speech_2000031_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		402499,
		"speech_100031_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		402500,
		"speech_100031_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		402501,
		"speech_2000031_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		402502,
		"speech_2000043_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402503,
		"speech_2000043_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402507,
		"speech_2000043_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		402508,
		"speech_2000043_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402509,
		"speech_2000043_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402510,
		"speech_2000043_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		402511,
		"speech_2000043_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		402512,
		"speech_2000043_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402513,
		"speech_2000043_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402514,
		"speech_2000043_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402515,
		"speech_2000043_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402516,
		"speech_2000043_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402517,
		"speech_2000043_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402518,
		"speech_2000043_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		402519,
		"speech_2000043_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		402520,
		"speech_2000043_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		402530,
		"speech_2000043_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402531,
		"speech_2000043_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402532,
		"speech_2000043_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		402533,
		"speech_2000043_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402534,
		"speech_2000043_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		402535,
		"speech_2000043_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		402536,
		"speech_2000043_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		402537,
		"speech_2000043_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		402538,
		"speech_2000043_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		402539,
		"speech_2000043_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		402540,
		"speech_2000043_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		402541,
		"speech_2000043_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		402542,
		"speech_2000043_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402543,
		"speech_2000043_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402544,
		"speech_2000043_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402545,
		"speech_2000043_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		402546,
		"speech_2000043_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402547,
		"speech_2000043_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402548,
		"speech_2000043_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402549,
		"speech_2000043_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		402550,
		"speech_2000043_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		402552,
		"speech_2000043_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402553,
		"speech_2000043_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402554,
		"speech_2000043_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402555,
		"speech_2000043_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402556,
		"speech_2000043_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402557,
		"speech_2000043_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		402558,
		"speech_2000043_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		402559,
		"speech_2000043_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402560,
		"speech_2000043_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402561,
		"speech_2000043_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402562,
		"speech_100043_ya_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402564,
		"speech_100043_ya_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402567,
		"speech_100043_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		402568,
		"speech_100043_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402569,
		"speech_100043_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402570,
		"speech_100043_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		402571,
		"speech_100043_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		402572,
		"speech_100043_death",
		"speech.acb",
		"speech.awb"
	},
	{
		402574,
		"speech_100043_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402575,
		"speech_100043_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402576,
		"speech_100043_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402577,
		"speech_100043_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402578,
		"speech_100043_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		402579,
		"speech_100043_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		402580,
		"speech_100043_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		402581,
		"speech_100043_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		402587,
		"speech_100043_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		402588,
		"speech_100043_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		402592,
		"speech_100043_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		402593,
		"speech_100043_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402594,
		"speech_100043_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		402595,
		"speech_100043_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		402596,
		"speech_100043_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		402597,
		"speech_100043_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		402598,
		"speech_100043_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		402599,
		"speech_100043_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		402600,
		"speech_100043_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		402601,
		"speech_100043_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		402602,
		"speech_100043_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402603,
		"speech_100043_ya_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402605,
		"speech_100043_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		402606,
		"speech_100043_ya_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402609,
		"speech_100043_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		402610,
		"speech_100043_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		402612,
		"speech_100043_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		402614,
		"speech_2000043_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		402617,
		"speech_100043_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		402618,
		"speech_100043_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		402619,
		"speech_2000043_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		402620,
		"speech_2000015_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402621,
		"speech_2000015_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402622,
		"speech_2000015_attack_skip_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402623,
		"speech_2000015_attack_skip_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402624,
		"speech_2000015_attack_skip_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402625,
		"speech_2000015_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		402626,
		"speech_2000015_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402627,
		"speech_2000015_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402628,
		"speech_2000015_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402629,
		"speech_2000015_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		402630,
		"speech_2000015_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		402631,
		"speech_2000015_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402632,
		"speech_2000015_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402633,
		"speech_2000015_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402634,
		"speech_2000015_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402635,
		"speech_2000015_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402636,
		"speech_2000015_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402637,
		"speech_2000015_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		402638,
		"speech_2000015_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		402639,
		"speech_2000015_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		402649,
		"speech_2000015_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402650,
		"speech_2000015_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402651,
		"speech_2000015_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		402652,
		"speech_2000015_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402653,
		"speech_2000015_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		402654,
		"speech_2000015_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		402655,
		"speech_2000015_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		402656,
		"speech_2000015_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		402657,
		"speech_2000015_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		402658,
		"speech_2000015_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		402659,
		"speech_2000015_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		402660,
		"speech_2000015_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		402661,
		"speech_2000015_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402662,
		"speech_2000015_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402663,
		"speech_2000015_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402664,
		"speech_2000015_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		402665,
		"speech_2000015_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402666,
		"speech_2000015_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402667,
		"speech_2000015_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402668,
		"speech_2000015_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		402669,
		"speech_2000015_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		402670,
		"speech_2000015_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402671,
		"speech_2000015_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402672,
		"speech_2000015_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402673,
		"speech_2000015_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402674,
		"speech_2000015_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402675,
		"speech_2000015_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		402676,
		"speech_2000015_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		402677,
		"speech_2000015_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402678,
		"speech_2000015_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402679,
		"speech_2000015_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402680,
		"speech_100015_qimangxing_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402682,
		"speech_100015_qimangxing_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402685,
		"speech_100015_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		402686,
		"speech_100015_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402687,
		"speech_100015_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402688,
		"speech_100015_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402689,
		"speech_100015_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		402690,
		"speech_100015_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		402691,
		"speech_100015_death",
		"speech.acb",
		"speech.awb"
	},
	{
		402693,
		"speech_100015_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402694,
		"speech_100015_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402695,
		"speech_100015_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402696,
		"speech_100015_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402697,
		"speech_100015_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		402698,
		"speech_100015_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		402699,
		"speech_100015_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		402700,
		"speech_100015_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		402706,
		"speech_100015_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		402707,
		"speech_100015_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		402711,
		"speech_100015_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		402712,
		"speech_100015_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402713,
		"speech_100015_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		402714,
		"speech_100015_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		402715,
		"speech_100015_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		402716,
		"speech_100015_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		402717,
		"speech_100015_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		402718,
		"speech_100015_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		402719,
		"speech_100015_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		402720,
		"speech_100015_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		402721,
		"speech_100015_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402722,
		"speech_100015_qimangxing_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402724,
		"speech_100015_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		402725,
		"speech_100015_qimangxing_unique_1_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402728,
		"speech_100015_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		402729,
		"speech_100015_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		402730,
		"speech_100015_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		402732,
		"speech_2000015_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		402735,
		"speech_100015_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		402736,
		"speech_100015_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		402737,
		"speech_2000015_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		402738,
		"speech_100021_attack_skip",
		"speech.acb",
		"speech.awb"
	},
	{
		402739,
		"speech_2000029_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402740,
		"speech_2000029_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402741,
		"speech_2000029_attack_skip_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402742,
		"speech_2000029_attack_skip_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402743,
		"speech_2000029_attack_skip_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402744,
		"speech_2000029_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		402745,
		"speech_2000029_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402746,
		"speech_2000029_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402747,
		"speech_2000029_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402748,
		"speech_2000029_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		402749,
		"speech_2000029_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		402750,
		"speech_2000029_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402751,
		"speech_2000029_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402752,
		"speech_2000029_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402753,
		"speech_2000029_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402754,
		"speech_2000029_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402755,
		"speech_2000029_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402756,
		"speech_2000029_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		402757,
		"speech_2000029_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		402758,
		"speech_2000029_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		402768,
		"speech_2000029_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402769,
		"speech_2000029_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402770,
		"speech_2000029_huanzhaung",
		"speech.acb",
		"speech.awb"
	},
	{
		402771,
		"speech_2000029_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402772,
		"speech_2000029_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		402773,
		"speech_2000029_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		402774,
		"speech_2000029_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		402775,
		"speech_2000029_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		402776,
		"speech_2000029_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		402777,
		"speech_2000029_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		402778,
		"speech_2000029_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		402779,
		"speech_2000029_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		402780,
		"speech_2000029_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402781,
		"speech_2000029_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402782,
		"speech_2000029_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402783,
		"speech_2000029_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		402784,
		"speech_2000029_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402785,
		"speech_2000029_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402786,
		"speech_2000029_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402787,
		"speech_2000029_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		402788,
		"speech_2000029_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		402789,
		"speech_2000029_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402790,
		"speech_2000029_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402791,
		"speech_2000029_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402792,
		"speech_2000029_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402793,
		"speech_2000029_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402794,
		"speech_2000029_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		402795,
		"speech_2000029_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		402796,
		"speech_2000029_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402797,
		"speech_2000029_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402798,
		"speech_2000029_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402799,
		"speech_100029_hansaier_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402801,
		"speech_100029_hansaierattack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402804,
		"speech_100029_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		402805,
		"speech_100029_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402806,
		"speech_100029_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402807,
		"speech_100029_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402808,
		"speech_100029_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		402809,
		"speech_100029_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		402810,
		"speech_100029_death",
		"speech.acb",
		"speech.awb"
	},
	{
		402812,
		"speech_100029_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402813,
		"speech_100029_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402814,
		"speech_100029_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402815,
		"speech_100029_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402816,
		"speech_100029_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		402817,
		"speech_100029_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		402818,
		"speech_100029_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		402819,
		"speech_100029_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		402820,
		"speech_100029_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		402821,
		"speech_100029_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		402830,
		"speech_100029_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		402831,
		"speech_100029_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402832,
		"speech_100029_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		402833,
		"speech_100029_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		402834,
		"speech_100029_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		402835,
		"speech_100029_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		402836,
		"speech_100029_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		402837,
		"speech_100029_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		402838,
		"speech_100029_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		402839,
		"speech_100029_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		402840,
		"speech_100029_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402841,
		"speech_100029_hansaier_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402843,
		"speech_100029_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		402844,
		"speech_100029_hansaier_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402847,
		"speech_100029_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		402848,
		"speech_100029_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		402849,
		"speech_100029_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		402851,
		"speech_2000029_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		402854,
		"speech_100029_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		402855,
		"speech_100029_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		402856,
		"speech_2000029_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		402859,
		"speech_2000046_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402860,
		"speech_2000046_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402861,
		"speech_2000046_attack_skip_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402862,
		"speech_2000046_attack_skip_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402863,
		"speech_2000046_attack_skip_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402864,
		"speech_2000046_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		402865,
		"speech_2000046_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402866,
		"speech_2000046_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402867,
		"speech_2000046_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402868,
		"speech_2000046_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		402869,
		"speech_2000046_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		402870,
		"speech_2000046_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402871,
		"speech_2000046_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402872,
		"speech_2000046_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402873,
		"speech_2000046_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402874,
		"speech_2000046_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402875,
		"speech_2000046_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402876,
		"speech_2000046_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		402877,
		"speech_2000046_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		402878,
		"speech_2000046_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		402888,
		"speech_2000046_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402889,
		"speech_2000046_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402890,
		"speech_2000046_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		402891,
		"speech_2000046_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402892,
		"speech_2000046_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		402893,
		"speech_2000046_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		402894,
		"speech_2000046_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		402895,
		"speech_2000046_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		402896,
		"speech_2000046_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		402897,
		"speech_2000046_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		402898,
		"speech_2000046_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		402899,
		"speech_2000046_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		402900,
		"speech_2000046_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402901,
		"speech_2000046_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402902,
		"speech_2000046_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402903,
		"speech_2000046_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		402904,
		"speech_2000046_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402905,
		"speech_2000046_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402906,
		"speech_2000046_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402907,
		"speech_2000046_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		402908,
		"speech_2000046_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		402909,
		"speech_2000046_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402910,
		"speech_2000046_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402911,
		"speech_2000046_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402912,
		"speech_2000046_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402913,
		"speech_2000046_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402914,
		"speech_2000046_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		402915,
		"speech_2000046_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		402916,
		"speech_2000046_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402917,
		"speech_2000046_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402918,
		"speech_2000046_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402919,
		"speech_100046_yiwan_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402921,
		"speech_100046_yiwan_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402924,
		"speech_100046_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		402925,
		"speech_100046_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402926,
		"speech_100046_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402927,
		"speech_100046_caidan_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402928,
		"speech_100046_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		402929,
		"speech_100046_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		402930,
		"speech_100046_death",
		"speech.acb",
		"speech.awb"
	},
	{
		402932,
		"speech_100046_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402933,
		"speech_100046_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402934,
		"speech_100046_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402935,
		"speech_100046_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402936,
		"speech_100046_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		402937,
		"speech_100046_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		402938,
		"speech_100046_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		402939,
		"speech_100046_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		402940,
		"speech_100046_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		402941,
		"speech_100046_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		402950,
		"speech_100046_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		402951,
		"speech_100046_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402952,
		"speech_100046_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		402953,
		"speech_100046_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		402954,
		"speech_100046_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		402955,
		"speech_100046_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		402956,
		"speech_100046_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		402957,
		"speech_100046_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		402958,
		"speech_100046_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		402959,
		"speech_100046_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		402960,
		"speech_100046_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402961,
		"speech_100046_yiwan_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402963,
		"speech_100046_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		402964,
		"speech_100046_yiwan_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		402967,
		"speech_100046_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		402968,
		"speech_100046_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		402969,
		"speech_100046_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		402971,
		"speech_2000046_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		402974,
		"speech_100046_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		402975,
		"speech_100046_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		402976,
		"speech_2000046_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		402979,
		"speech_2000051_attack_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402980,
		"speech_2000051_attack_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402981,
		"speech_2000051_attack_skip_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402982,
		"speech_2000051_attack_skip_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402983,
		"speech_2000051_attack_skip_03",
		"speech.acb",
		"speech.awb"
	},
	{
		402984,
		"speech_2000051_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		402985,
		"speech_2000051_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402986,
		"speech_2000051_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402987,
		"speech_2000051_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		402988,
		"speech_2000051_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		402989,
		"speech_2000051_death_01",
		"speech.acb",
		"speech.awb"
	},
	{
		402990,
		"speech_2000051_death_02",
		"speech.acb",
		"speech.awb"
	},
	{
		402991,
		"speech_2000051_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402992,
		"speech_2000051_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		402993,
		"speech_2000051_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		402994,
		"speech_2000051_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		402995,
		"speech_2000051_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		402996,
		"speech_2000051_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		402997,
		"speech_2000051_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		403007,
		"speech_2000051_hit_02",
		"speech.acb",
		"speech.awb"
	},
	{
		403008,
		"speech_2000051_hit_01",
		"speech.acb",
		"speech.awb"
	},
	{
		403009,
		"speech_2000051_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		403010,
		"speech_2000051_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		403011,
		"speech_2000051_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		403012,
		"speech_2000051_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		403013,
		"speech_2000051_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		403014,
		"speech_2000051_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		403015,
		"speech_2000051_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		403016,
		"speech_2000051_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		403017,
		"speech_2000051_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		403018,
		"speech_2000051_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		403019,
		"speech_2000051_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		403020,
		"speech_2000051_special_01",
		"speech.acb",
		"speech.awb"
	},
	{
		403021,
		"speech_2000051_special_02",
		"speech.acb",
		"speech.awb"
	},
	{
		403022,
		"speech_2000051_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		403023,
		"speech_2000051_unique_01",
		"speech.acb",
		"speech.awb"
	},
	{
		403024,
		"speech_2000051_unique_02",
		"speech.acb",
		"speech.awb"
	},
	{
		403025,
		"speech_2000051_unique_03",
		"speech.acb",
		"speech.awb"
	},
	{
		403026,
		"speech_2000051_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		403027,
		"speech_2000051_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		403028,
		"speech_2000051_xuanzhong_01",
		"speech.acb",
		"speech.awb"
	},
	{
		403029,
		"speech_2000051_xuanzhong_02",
		"speech.acb",
		"speech.awb"
	},
	{
		403030,
		"speech_2000051_yangcheng_01",
		"speech.acb",
		"speech.awb"
	},
	{
		403031,
		"speech_2000051_yangcheng_02",
		"speech.acb",
		"speech.awb"
	},
	{
		403032,
		"speech_2000051_yangcheng_03",
		"speech.acb",
		"speech.awb"
	},
	{
		403033,
		"speech_2000051_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		403034,
		"speech_2000051_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		403035,
		"speech_2000051_zhujiemian_01",
		"speech.acb",
		"speech.awb"
	},
	{
		403036,
		"speech_2000051_zhujiemian_02",
		"speech.acb",
		"speech.awb"
	},
	{
		403037,
		"speech_2000051_zhujiemian_03",
		"speech.acb",
		"speech.awb"
	},
	{
		403038,
		"speech_100051_kalinna_attack_p",
		"speech.acb",
		"speech.awb"
	},
	{
		403040,
		"speech_100051_kalinna_attack_skip_p",
		"speech.acb",
		"speech.awb"
	},
	{
		403043,
		"speech_100051_beishang",
		"speech.acb",
		"speech.awb"
	},
	{
		403044,
		"speech_100051_caidan_01",
		"speech.acb",
		"speech.awb"
	},
	{
		403045,
		"speech_100051_caidan_02",
		"speech.acb",
		"speech.awb"
	},
	{
		403046,
		"speech_100051_chouka",
		"speech.acb",
		"speech.awb"
	},
	{
		403047,
		"speech_100051_dazhaohu",
		"speech.acb",
		"speech.awb"
	},
	{
		403048,
		"speech_100051_death",
		"speech.acb",
		"speech.awb"
	},
	{
		403050,
		"speech_100051_dilizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		403051,
		"speech_100051_gaolizhi",
		"speech.acb",
		"speech.awb"
	},
	{
		403052,
		"speech_100051_guanzhichenggong",
		"speech.acb",
		"speech.awb"
	},
	{
		403053,
		"speech_100051_guanzhishibai",
		"speech.acb",
		"speech.awb"
	},
	{
		403054,
		"speech_100051_haogan",
		"speech.acb",
		"speech.awb"
	},
	{
		403055,
		"speech_100051_haoganrenwu",
		"speech.acb",
		"speech.awb"
	},
	{
		403056,
		"speech_100051_heihezi",
		"speech.acb",
		"speech.awb"
	},
	{
		403057,
		"speech_100051_hit_light",
		"speech.acb",
		"speech.awb"
	},
	{
		403058,
		"speech_100051_hit_heavy",
		"speech.acb",
		"speech.awb"
	},
	{
		403059,
		"speech_100051_hit_heavy_vo",
		"speech.acb",
		"speech.awb"
	},
	{
		403068,
		"speech_100051_huanzhuan",
		"speech.acb",
		"speech.awb"
	},
	{
		403069,
		"speech_100051_kaishiguanzhi",
		"speech.acb",
		"speech.awb"
	},
	{
		403070,
		"speech_100051_kaixin",
		"speech.acb",
		"speech.awb"
	},
	{
		403071,
		"speech_100051_lizhiqianghua",
		"speech.acb",
		"speech.awb"
	},
	{
		403072,
		"speech_100051_meiri",
		"speech.acb",
		"speech.awb"
	},
	{
		403073,
		"speech_100051_qinhe",
		"speech.acb",
		"speech.awb"
	},
	{
		403074,
		"speech_100051_shangzhen",
		"speech.acb",
		"speech.awb"
	},
	{
		403075,
		"speech_100051_shengji",
		"speech.acb",
		"speech.awb"
	},
	{
		403076,
		"speech_100051_shengli",
		"speech.acb",
		"speech.awb"
	},
	{
		403077,
		"speech_100051_shengqi",
		"speech.acb",
		"speech.awb"
	},
	{
		403078,
		"speech_100051_shibai",
		"speech.acb",
		"speech.awb"
	},
	{
		403079,
		"speech_100051_kalinna_special_p",
		"speech.acb",
		"speech.awb"
	},
	{
		403081,
		"speech_100051_tupo",
		"speech.acb",
		"speech.awb"
	},
	{
		403082,
		"speech_100051_kalinna_unique_p",
		"speech.acb",
		"speech.awb"
	},
	{
		403085,
		"speech_100051_xiedai",
		"speech.acb",
		"speech.awb"
	},
	{
		403086,
		"speech_100051_xingge",
		"speech.acb",
		"speech.awb"
	},
	{
		403087,
		"speech_100051_xuanzhong",
		"speech.acb",
		"speech.awb"
	},
	{
		403089,
		"speech_2000051_yangcheng",
		"speech.acb",
		"speech.awb"
	},
	{
		403092,
		"speech_100051_yiwen",
		"speech.acb",
		"speech.awb"
	},
	{
		403093,
		"speech_100051_zhuaqu",
		"speech.acb",
		"speech.awb"
	},
	{
		403094,
		"speech_2000051_zhujiemian",
		"speech.acb",
		"speech.awb"
	},
	{
		521500,
		"speech_100050101",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521501,
		"speech_100050102",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521502,
		"speech_100050103",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521503,
		"juqing_1000501_01_hailang",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521504,
		"juqing_1000501_01_zayin",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521505,
		"juqing_1000501_02_chuangjue_01",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521506,
		"juqing_1000501_03_chenru_01",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521507,
		"juqing_1000501_03_chuangjue_02",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521508,
		"speech_100050101_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521509,
		"speech_100050102_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521510,
		"speech_100050103_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521511,
		"speech_100050104_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521512,
		"speech_100050105_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521513,
		"speech_100050106_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521514,
		"speech_100050107_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521515,
		"speech_100050108_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521516,
		"speech_100050109_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521517,
		"speech_100050110_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521518,
		"speech_100050111_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521519,
		"speech_100050112_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521520,
		"speech_100050113_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521521,
		"speech_100050114_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521522,
		"speech_100050115_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521523,
		"speech_100050116_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521524,
		"speech_100050117_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521525,
		"speech_100050118_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521526,
		"speech_100050119_v2",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		521527,
		"speech_ailisi_zhutiqu",
		"story_1000501.acb",
		"story_1000501.awb"
	},
	{
		522500,
		"speech_100060102",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522501,
		"speech_100060103",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522502,
		"speech_100060104",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522503,
		"speech_100060105",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522504,
		"speech_100060106",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522505,
		"speech_100060107",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522506,
		"speech_100060108",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522507,
		"speech_100060109",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522508,
		"speech_100060110",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522509,
		"speech_100060111",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522510,
		"speech_100060112",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522511,
		"speech_100060113",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522512,
		"speech_100060101",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522513,
		"juqing_1000601_02_shuidi",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522514,
		"juqing_1000601_01_chaoshui",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522515,
		"speech_100060101_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522516,
		"speech_100060102_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522517,
		"speech_100060103_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522518,
		"speech_100060104_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522519,
		"speech_100060105_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522520,
		"speech_100060106_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522521,
		"speech_100060107_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522522,
		"speech_100060108_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522523,
		"speech_100060109_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522524,
		"speech_100060110_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522525,
		"speech_100060111_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522526,
		"speech_100060112_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522527,
		"speech_100060113_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522528,
		"speech_100060114_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522529,
		"speech_100060115_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522530,
		"speech_100060116_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522531,
		"speech_100060117_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522532,
		"speech_100060118_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		522533,
		"speech_100060119_v2",
		"story_1000601.acb",
		"story_1000601.awb"
	},
	{
		523500,
		"speech_100070101",
		"story_1000701.acb",
		"story_1000701.awb"
	},
	{
		523501,
		"speech_100070102",
		"story_1000701.acb",
		"story_1000701.awb"
	},
	{
		523502,
		"speech_100070103",
		"story_1000701.acb",
		"story_1000701.awb"
	},
	{
		523503,
		"speech_100070104",
		"story_1000701.acb",
		"story_1000701.awb"
	},
	{
		523504,
		"speech_100070105",
		"story_1000701.acb",
		"story_1000701.awb"
	},
	{
		523505,
		"speech_100070106",
		"story_1000701.acb",
		"story_1000701.awb"
	},
	{
		523506,
		"speech_100070107",
		"story_1000701.acb",
		"story_1000701.awb"
	},
	{
		523507,
		"speech_100070108",
		"story_1000701.acb",
		"story_1000701.awb"
	},
	{
		523508,
		"speech_100070109",
		"story_1000701.acb",
		"story_1000701.awb"
	},
	{
		523509,
		"juqing_1000701_01_jiaobu_yanhuo",
		"story_1000701.acb",
		"story_1000701.awb"
	},
	{
		523510,
		"juqing_1000701_02_jiaobu_renqun",
		"story_1000701.acb",
		"story_1000701.awb"
	},
	{
		501000,
		"speech_101010101",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501001,
		"speech_101010102",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501002,
		"speech_101010103",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501003,
		"speech_101010104",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501004,
		"speech_101010105",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501005,
		"speech_101010106",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501006,
		"speech_101010107",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501007,
		"speech_101010108",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501008,
		"speech_101010109",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501009,
		"speech_101010110",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501010,
		"speech_101010112",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501011,
		"speech_101010113",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501012,
		"speech_101010114",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501013,
		"speech_101010115",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501014,
		"speech_101010118",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501015,
		"speech_101010119",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501016,
		"speech_101010120",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501017,
		"speech_101010121",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501018,
		"juqing_1010101_02_tongxunqi",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501019,
		"juqing_1010101_01_amb_shangyejie",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501020,
		"speech_101010101_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501021,
		"speech_101010102_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501022,
		"speech_101010103_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501023,
		"speech_101010104_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501024,
		"speech_101010105_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501025,
		"speech_101010106_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501026,
		"speech_101010107_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501027,
		"speech_101010109_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501028,
		"speech_101010110_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501029,
		"speech_101010111_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501030,
		"speech_101010112_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501031,
		"speech_101010113_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501032,
		"speech_101010114_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501033,
		"speech_101010115_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501034,
		"speech_101010116_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501035,
		"speech_101010117_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501036,
		"speech_101010118_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501037,
		"speech_101010119_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501038,
		"speech_101010120_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501039,
		"speech_101010121_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501040,
		"speech_101010122_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501041,
		"speech_101010123_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501042,
		"speech_101010124_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501043,
		"speech_101010125_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501044,
		"speech_101010126_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501045,
		"speech_101010127_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501046,
		"speech_101010128_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501047,
		"speech_101010129_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501048,
		"speech_101010130_v2",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501049,
		"speech_101010131",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		501050,
		"juqing_0000000_mishiyuantikaojin_01",
		"story_1010101.acb",
		"story_1010101.awb"
	},
	{
		502000,
		"speech_101020101",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502001,
		"speech_101020102",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502002,
		"speech_101020103",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502003,
		"speech_101020104",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502004,
		"speech_101020105",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502005,
		"speech_101020106",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502006,
		"speech_101020107",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502007,
		"speech_101020108",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502008,
		"speech_101020109",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502009,
		"speech_101020110",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502010,
		"speech_101020111",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502011,
		"speech_101020112",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502012,
		"speech_101020113",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502013,
		"speech_101020114",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502014,
		"speech_101020115",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502015,
		"speech_101020116",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502016,
		"speech_101020117",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502017,
		"speech_101020118",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502018,
		"speech_101020119",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502019,
		"speech_101020120",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502020,
		"speech_101020121",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502021,
		"speech_101020122",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502022,
		"speech_101020123",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502023,
		"speech_101020124",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502024,
		"speech_101020125",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502025,
		"speech_101020126",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502026,
		"speech_101020127",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502027,
		"speech_101020128",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502028,
		"speech_101020129",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502029,
		"juqing_1010201_01_jiaobu_renqun",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502030,
		"juqing_1010201_02_saomiao1",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502031,
		"juqing_1010201_02_saomiao2",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502032,
		"juqing_1010201_03_jiesuo",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502033,
		"speech_101020101_v2",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502034,
		"speech_101020102_v2",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502035,
		"speech_101020103_v2",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502036,
		"speech_101020104_v2",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		502037,
		"speech_101020105_v2",
		"story_1010201.acb",
		"story_1010201.awb"
	},
	{
		503000,
		"speech_101020201",
		"story_1010202.acb",
		"story_1010202.awb"
	},
	{
		503001,
		"speech_101020202",
		"story_1010202.acb",
		"story_1010202.awb"
	},
	{
		503002,
		"speech_101020203",
		"story_1010202.acb",
		"story_1010202.awb"
	},
	{
		503003,
		"speech_101020204",
		"story_1010202.acb",
		"story_1010202.awb"
	},
	{
		503004,
		"speech_101020205",
		"story_1010202.acb",
		"story_1010202.awb"
	},
	{
		503005,
		"speech_101020206",
		"story_1010202.acb",
		"story_1010202.awb"
	},
	{
		503006,
		"speech_101020207",
		"story_1010202.acb",
		"story_1010202.awb"
	},
	{
		503007,
		"speech_101020208",
		"story_1010202.acb",
		"story_1010202.awb"
	},
	{
		503008,
		"speech_101020209",
		"story_1010202.acb",
		"story_1010202.awb"
	},
	{
		503009,
		"speech_101020210",
		"story_1010202.acb",
		"story_1010202.awb"
	},
	{
		503010,
		"juqing_1010202_01_kaimen",
		"story_1010202.acb",
		"story_1010202.awb"
	},
	{
		503011,
		"juqing_1010202_02_tongxunqi_anjian",
		"story_1010202.acb",
		"story_1010202.awb"
	},
	{
		504000,
		"speech_101030101",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504001,
		"speech_101030102",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504002,
		"speech_101030104",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504003,
		"speech_101030105",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504004,
		"speech_101030106",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504005,
		"speech_101030107",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504006,
		"speech_101030108",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504007,
		"speech_101030109",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504008,
		"speech_101030110",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504009,
		"speech_101030111",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504010,
		"speech_101030113",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504011,
		"speech_101030114",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504012,
		"speech_101030115",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504013,
		"speech_101030116",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504014,
		"speech_101030117",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504015,
		"speech_101030120",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504016,
		"speech_101030121",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504017,
		"speech_101030122",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504018,
		"speech_101030123",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504019,
		"speech_101030125",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504020,
		"speech_101030127",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504021,
		"speech_101030128",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504022,
		"speech_101030131",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504023,
		"speech_101030132",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504024,
		"speech_101030133",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504025,
		"speech_101030134",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504026,
		"speech_101030135",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504027,
		"speech_101030136",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504028,
		"speech_101030138",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504029,
		"speech_101030139",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504030,
		"speech_101030140",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504031,
		"speech_101030142",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504032,
		"speech_101030143",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504033,
		"speech_101030144",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504034,
		"speech_101030145",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504035,
		"juqing_1010301_02_zayin",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		504036,
		"speech_101020210",
		"story_1010301.acb",
		"story_1010301.awb"
	},
	{
		505000,
		"speech_101030201",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505001,
		"speech_101030202",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505002,
		"speech_101030203",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505003,
		"speech_101030204",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505004,
		"speech_101030205",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505005,
		"speech_101030206",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505006,
		"speech_101030207",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505007,
		"speech_101030208",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505008,
		"speech_101030209",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505009,
		"speech_101030210",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505010,
		"speech_101030211",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505011,
		"speech_101030212",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505012,
		"speech_101030213",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505013,
		"speech_101030214",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505014,
		"speech_101030215",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505015,
		"speech_101030218",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505016,
		"speech_101030219",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505017,
		"speech_101030221",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505018,
		"speech_101030222",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505019,
		"speech_101030223",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505020,
		"speech_101030224",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505021,
		"speech_101030225",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505022,
		"speech_101030226",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505023,
		"speech_101030227",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505024,
		"speech_101030228",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505025,
		"speech_101030230",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505026,
		"speech_101030232",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505027,
		"speech_101030233",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505028,
		"speech_101030234",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505029,
		"speech_101030235",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505030,
		"speech_101030236",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505031,
		"speech_101030237",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505032,
		"speech_101030238",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505033,
		"speech_101030239",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505034,
		"speech_101030240",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505035,
		"speech_101030241",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505036,
		"speech_101030242",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505037,
		"speech_101030243",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505038,
		"speech_101030244",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505039,
		"speech_101030245",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505040,
		"speech_101030246",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505041,
		"speech_101030248",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505042,
		"speech_101030249",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505043,
		"speech_101030250",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505044,
		"speech_101030252",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505045,
		"speech_101030256",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505046,
		"juqing_1010302_01_amb_renqun",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505047,
		"juqing_1010302_02_act_fengtiao",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505048,
		"juqing_1010302_03_jingbao",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505049,
		"juqing_1010302_03_zayin",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505050,
		"juqing_1010302_04_fangyingji01",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505051,
		"juqing_1010302_05_amb_xveyuan01",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		505052,
		"speech_101030201_v2",
		"story_1010302.acb",
		"story_1010302.awb"
	},
	{
		506000,
		"speech_101040101",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506001,
		"speech_101040102",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506002,
		"speech_101040104",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506003,
		"speech_101040107",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506004,
		"speech_101040108",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506005,
		"speech_101040109",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506006,
		"speech_101040112",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506007,
		"speech_101040113",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506008,
		"speech_101040114",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506009,
		"speech_101040115",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506010,
		"speech_101040116",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506011,
		"speech_101040117",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506012,
		"speech_101040117_1",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506013,
		"speech_101040118",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506014,
		"speech_101040119",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506015,
		"speech_101040120",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506016,
		"speech_101040122",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506017,
		"speech_101040123",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506018,
		"speech_101040124",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506019,
		"speech_101040125",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506020,
		"speech_101040126",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506021,
		"speech_101040127",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506022,
		"speech_101040131",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506023,
		"juqing_1010401_01_amb_xveyuan02",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506024,
		"juqing_1010401_02_zayin",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506025,
		"speech_101040101_v2",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506026,
		"speech_101040102_v2",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506027,
		"speech_101040103_v2",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506028,
		"speech_101040104_v2",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506029,
		"speech_101040105_v2",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506030,
		"speech_101040106_v2",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		506031,
		"speech_101040107_v2",
		"story_1010401.acb",
		"story_1010401.awb"
	},
	{
		507000,
		"speech_101050101",
		"story_1010501.acb",
		"story_1010501.awb"
	},
	{
		507001,
		"speech_101050102",
		"story_1010501.acb",
		"story_1010501.awb"
	},
	{
		507002,
		"speech_101050103",
		"story_1010501.acb",
		"story_1010501.awb"
	},
	{
		507003,
		"speech_101050105",
		"story_1010501.acb",
		"story_1010501.awb"
	},
	{
		507004,
		"speech_101050106",
		"story_1010501.acb",
		"story_1010501.awb"
	},
	{
		507005,
		"speech_101050107",
		"story_1010501.acb",
		"story_1010501.awb"
	},
	{
		507006,
		"speech_101050108",
		"story_1010501.acb",
		"story_1010501.awb"
	},
	{
		507007,
		"speech_101050109",
		"story_1010501.acb",
		"story_1010501.awb"
	},
	{
		507008,
		"speech_101050110",
		"story_1010501.acb",
		"story_1010501.awb"
	},
	{
		507009,
		"speech_101050113",
		"story_1010501.acb",
		"story_1010501.awb"
	},
	{
		507010,
		"speech_101050115",
		"story_1010501.acb",
		"story_1010501.awb"
	},
	{
		507011,
		"speech_101050116",
		"story_1010501.acb",
		"story_1010501.awb"
	},
	{
		507012,
		"speech_101050117",
		"story_1010501.acb",
		"story_1010501.awb"
	},
	{
		507013,
		"juqing_1010501_02_lieche01",
		"story_1010501.acb",
		"story_1010501.awb"
	},
	{
		507014,
		"juqing_1010501_03_lieche02",
		"story_1010501.acb",
		"story_1010501.awb"
	},
	{
		507015,
		"juqing_1010501_01_amb_xveyuan02",
		"story_1010501.acb",
		"story_1010501.awb"
	},
	{
		508000,
		"speech_101050201",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508001,
		"speech_101050202",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508002,
		"speech_101050203",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508003,
		"speech_101050206",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508004,
		"speech_101050207",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508005,
		"speech_101050208",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508006,
		"speech_101050209",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508007,
		"speech_101050210",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508008,
		"speech_101050211",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508009,
		"speech_101050212",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508010,
		"speech_101050213",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508011,
		"speech_101050214",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508012,
		"speech_101050215",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508013,
		"speech_101050216",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508014,
		"speech_101050217",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508015,
		"speech_101050218",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508016,
		"speech_101050219",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508017,
		"speech_101050221",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508018,
		"speech_101050225",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508019,
		"juqing_1010502_01_amb_xveyuan02",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508020,
		"juqing_1010502_02_jiaobu",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508021,
		"juqing_1010502_03_zayin",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508022,
		"juqing_1010502_05_linggan02",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		508023,
		"speech_101050201_v2",
		"story_1010502.acb",
		"story_1010502.awb"
	},
	{
		544000,
		"speech_101060101_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544001,
		"speech_101060102_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544002,
		"speech_101060103_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544003,
		"speech_101060104_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544004,
		"speech_101060105_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544005,
		"speech_101060106_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544006,
		"speech_101060107_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544007,
		"speech_101060108_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544008,
		"speech_101060109_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544009,
		"speech_101060110_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544010,
		"speech_101060111_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544011,
		"speech_101060112_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544012,
		"speech_101060113_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544013,
		"speech_101060114_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544014,
		"speech_101060115_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544015,
		"speech_101060116_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544016,
		"speech_101060117_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544017,
		"speech_101060118_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544018,
		"speech_101060119_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544019,
		"speech_101060120_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544020,
		"speech_101060121_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544021,
		"speech_101060122_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544022,
		"speech_101060123_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544023,
		"speech_101060124_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544024,
		"speech_101060125_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544025,
		"speech_101060126_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544026,
		"speech_101060127_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544027,
		"speech_101060128_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544028,
		"speech_101060129_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544029,
		"speech_101060130_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544030,
		"speech_101060131_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544031,
		"speech_101060132_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544032,
		"speech_101060134_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544033,
		"speech_101060135_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544034,
		"speech_101060136_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544035,
		"speech_101060137_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544036,
		"speech_101060138_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544037,
		"speech_101060139_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544038,
		"speech_101060140_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		544039,
		"speech_101060141_v2",
		"story_1010601.acb",
		"story_1010601.awb"
	},
	{
		509000,
		"speech_101070101",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509001,
		"speech_101070102",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509002,
		"speech_101070104",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509003,
		"speech_101070106",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509004,
		"speech_101070107",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509005,
		"speech_101070110",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509006,
		"speech_101070115",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509007,
		"speech_101070116",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509008,
		"speech_101070117",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509009,
		"speech_101070118",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509010,
		"speech_101070119",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509011,
		"speech_101070120",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509012,
		"speech_101070122",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509013,
		"speech_101070123",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509014,
		"speech_101070124",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509015,
		"speech_101070125",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509016,
		"speech_101070130",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509017,
		"speech_101070131",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509018,
		"speech_101070132",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509019,
		"speech_101070134",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509020,
		"juqing_1010701_01_amb_xveyuan02",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		509021,
		"juqing_1010701_02_fangyingji01",
		"story_1010701.acb",
		"story_1010701.awb"
	},
	{
		510000,
		"speech_101070201",
		"story_1010702.acb",
		"story_1010702.awb"
	},
	{
		510001,
		"speech_101070203",
		"story_1010702.acb",
		"story_1010702.awb"
	},
	{
		510002,
		"speech_101070204",
		"story_1010702.acb",
		"story_1010702.awb"
	},
	{
		510003,
		"speech_101070205",
		"story_1010702.acb",
		"story_1010702.awb"
	},
	{
		510004,
		"speech_101070206",
		"story_1010702.acb",
		"story_1010702.awb"
	},
	{
		510005,
		"speech_101070209",
		"story_1010702.acb",
		"story_1010702.awb"
	},
	{
		510006,
		"speech_101070210",
		"story_1010702.acb",
		"story_1010702.awb"
	},
	{
		510007,
		"juqing_1010702_02_saomiao",
		"story_1010702.acb",
		"story_1010702.awb"
	},
	{
		510008,
		"juqing_1010702_01_fangyingji01",
		"story_1010702.acb",
		"story_1010702.awb"
	},
	{
		511000,
		"speech_101080101",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511001,
		"speech_101080102",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511002,
		"speech_101080103",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511003,
		"speech_101080104",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511004,
		"speech_101080106",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511005,
		"speech_101080107",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511006,
		"speech_101080110",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511007,
		"speech_101080113",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511008,
		"speech_101080114",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511009,
		"speech_101080115",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511010,
		"speech_101080116",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511011,
		"speech_101080117",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511012,
		"speech_101080122",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511013,
		"speech_101080125",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511014,
		"speech_101080126",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511015,
		"speech_101080127",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511016,
		"speech_101080128",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511017,
		"speech_101080130",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511018,
		"speech_101080131",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511019,
		"speech_101080133",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511020,
		"speech_101080137",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511021,
		"speech_101080138",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511022,
		"speech_101080141",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511023,
		"speech_101080142",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511024,
		"speech_101080143",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511025,
		"speech_101080144",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511026,
		"speech_101080145",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511027,
		"speech_101080150",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511028,
		"speech_101080153",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511029,
		"speech_101080154",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511030,
		"speech_101080155",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511031,
		"speech_101080156",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511032,
		"speech_101080157",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511033,
		"speech_101080159",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511034,
		"speech_101080160",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511035,
		"speech_101080161",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511036,
		"speech_101080162",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511037,
		"speech_101080163",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511038,
		"speech_101080165",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511039,
		"speech_101080166",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511040,
		"speech_101080167",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511041,
		"speech_101080168",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511042,
		"speech_101080169",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511043,
		"speech_101080170",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511044,
		"juqing_1010801_01_tongxunqi_wxying1",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511045,
		"juqing_1010801_01_tongxunqi_wxying2",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511046,
		"juqing_1010801_01_tongxunqi_wxying3",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		511047,
		"juqing_1010801_01_tongxunqi_wxying4",
		"story_1010801.acb",
		"story_1010801.awb"
	},
	{
		512000,
		"speech_101100101",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		512001,
		"speech_101100102",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		512002,
		"speech_101100103",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		512003,
		"speech_101100104",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		512004,
		"speech_101100105",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		512005,
		"speech_101100106",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		512006,
		"speech_101100107",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		512007,
		"speech_101100108",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		512008,
		"speech_101100109",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		512009,
		"speech_101100110",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		512010,
		"speech_101100111",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		512011,
		"speech_101100112",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		512012,
		"speech_101100114",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		512013,
		"speech_101100115",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		512014,
		"speech_101100116",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		512015,
		"speech_101100117",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		512016,
		"speech_101100118",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		512017,
		"speech_101100119",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		512018,
		"juqing_1011101_01_amb_yinan",
		"story_1011001.acb",
		"story_1011001.awb"
	},
	{
		513000,
		"speech_101120101",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513001,
		"speech_101120104",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513002,
		"speech_101120105",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513003,
		"speech_101120107",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513004,
		"speech_101120108",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513005,
		"speech_101120109",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513006,
		"speech_101120112",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513007,
		"speech_101120113",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513008,
		"speech_101120115",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513009,
		"speech_101120116",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513010,
		"speech_101120117",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513011,
		"speech_101120118",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513012,
		"speech_101120119",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513013,
		"speech_101120120",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513014,
		"speech_101120121",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513015,
		"speech_101120122",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513016,
		"speech_101120124",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513017,
		"speech_101120125",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513018,
		"speech_101120127",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513019,
		"speech_101120128",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513020,
		"speech_101120129",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513021,
		"speech_101120130",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513022,
		"speech_101120131",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513023,
		"speech_101120132",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513024,
		"speech_101120134",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513025,
		"speech_101120138",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513026,
		"speech_101120139",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513027,
		"speech_101120140",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513028,
		"speech_101120141",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513029,
		"speech_101120143",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513030,
		"speech_101120144",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513031,
		"speech_101120147",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513032,
		"speech_101120148",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513033,
		"speech_101120149",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513034,
		"speech_101120150",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513035,
		"speech_101120152",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513036,
		"speech_101120153",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513037,
		"speech_101120154",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513038,
		"juqing_1011201_01_tongxunqi_shoudao",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		513039,
		"juqing_1011201_02_tongxunqi_ganrao",
		"story_1011201.acb",
		"story_1011201.awb"
	},
	{
		514000,
		"speech_101120203",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514001,
		"speech_101120204",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514002,
		"speech_101120205",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514003,
		"speech_101120206",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514004,
		"speech_101120207",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514005,
		"speech_101120208",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514006,
		"speech_101120210",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514007,
		"speech_101120211",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514008,
		"speech_101120214",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514009,
		"speech_101120216",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514010,
		"speech_101120217",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514011,
		"speech_101120219",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514012,
		"speech_101120221",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514013,
		"speech_101120223",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514016,
		"speech_101120224",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514017,
		"speech_101120225",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514018,
		"speech_101120226",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514019,
		"speech_101120227",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514020,
		"speech_101120228",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		514021,
		"speech_101120229",
		"story_1011202.acb",
		"story_1011202.awb"
	},
	{
		515000,
		"speech_101130101",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515001,
		"speech_101130102",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515002,
		"speech_101130103",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515003,
		"speech_101130104",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515004,
		"speech_101130105",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515005,
		"speech_101130106",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515006,
		"speech_101130107",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515007,
		"speech_101130108",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515008,
		"speech_101130109",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515009,
		"speech_101130110",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515010,
		"speech_101130111",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515011,
		"speech_101130113",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515012,
		"speech_101130114",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515013,
		"speech_101130115",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515014,
		"speech_101130116",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515015,
		"speech_101130117",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515016,
		"speech_101130118",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515017,
		"speech_101130119",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515018,
		"speech_101130120",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515019,
		"speech_101130121",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515021,
		"speech_101130123",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515022,
		"speech_101130124",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515023,
		"speech_101130125",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515024,
		"speech_101130126",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515025,
		"speech_101130127",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515026,
		"speech_101130128",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515027,
		"speech_101130129",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515028,
		"speech_101130131",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515029,
		"speech_101130132",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515030,
		"speech_101130134",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515031,
		"speech_101130135",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515032,
		"speech_101130136",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515033,
		"juqing_1011301_02_amb_baofengxve01",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		515034,
		"juqing_1011301_01_buwending",
		"story_1011301.acb",
		"story_1011301.awb"
	},
	{
		516000,
		"speech_101130201",
		"story_1011302.acb",
		"story_1011302.awb"
	},
	{
		516001,
		"speech_101130202",
		"story_1011302.acb",
		"story_1011302.awb"
	},
	{
		516002,
		"speech_101130203",
		"story_1011302.acb",
		"story_1011302.awb"
	},
	{
		516003,
		"speech_101130204",
		"story_1011302.acb",
		"story_1011302.awb"
	},
	{
		516004,
		"speech_101130205",
		"story_1011302.acb",
		"story_1011302.awb"
	},
	{
		516005,
		"speech_101130206",
		"story_1011302.acb",
		"story_1011302.awb"
	},
	{
		516006,
		"speech_101130207",
		"story_1011302.acb",
		"story_1011302.awb"
	},
	{
		516007,
		"speech_101130208",
		"story_1011302.acb",
		"story_1011302.awb"
	},
	{
		516008,
		"speech_101130209",
		"story_1011302.acb",
		"story_1011302.awb"
	},
	{
		516009,
		"speech_101130210",
		"story_1011302.acb",
		"story_1011302.awb"
	},
	{
		516011,
		"speech_101130211",
		"story_1011302.acb",
		"story_1011302.awb"
	},
	{
		517000,
		"speech_101140101",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517001,
		"speech_101140103",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517002,
		"speech_101140105",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517003,
		"speech_101140106",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517004,
		"speech_101140108",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517005,
		"speech_101140109",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517006,
		"speech_101140110",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517007,
		"speech_101140111",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517008,
		"speech_101140112",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517009,
		"speech_101140113",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517010,
		"speech_101140115",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517011,
		"speech_101140116",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517012,
		"speech_101140117",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517013,
		"speech_101140122",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517014,
		"speech_101140123",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517015,
		"speech_101140128",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517016,
		"speech_101140129",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517017,
		"speech_101140130",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517018,
		"speech_101140136",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517019,
		"speech_101140145",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517020,
		"speech_101140146",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517021,
		"speech_101140147",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517022,
		"speech_101140148",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517023,
		"juqing_1011401_01_act",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517024,
		"juqing_1011401_02_gunshot",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517025,
		"juqing_1011401_03_xiaoshi",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517026,
		"juqing_1011401_04_amb_hundun",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517027,
		"juqing_1011401_06_linggan02",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517028,
		"juqing_1011401_07_sfx",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517029,
		"juqing_1011401_08_yuanti",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		517030,
		"juqing_1011401_05_linggan01",
		"story_1011401.acb",
		"story_1011401.awb"
	},
	{
		518000,
		"speech_101150101",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518001,
		"speech_101150102",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518002,
		"speech_101150103",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518003,
		"speech_101150104",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518005,
		"speech_101150105",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518006,
		"speech_101150106",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518007,
		"speech_101150107",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518008,
		"speech_101150108",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518009,
		"speech_101150109",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518010,
		"speech_101150110",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518011,
		"speech_101150111",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518012,
		"speech_101150112",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518013,
		"speech_101150113",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518014,
		"speech_101150114",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518015,
		"speech_101150115",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518016,
		"speech_101150116",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518017,
		"speech_101150117",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518018,
		"speech_101150118",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518019,
		"speech_101150119",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518020,
		"speech_101150120",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518021,
		"speech_101150121",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518022,
		"speech_101150122",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518023,
		"speech_101150123",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518024,
		"speech_101150124",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518025,
		"speech_101150125",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518026,
		"speech_101150126",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518027,
		"speech_101150127",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518028,
		"speech_101150128",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518029,
		"speech_101150129",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518030,
		"speech_101150130",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518031,
		"speech_101150131",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518032,
		"speech_101150132",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518033,
		"speech_101150134",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518034,
		"speech_101150135",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518035,
		"speech_101150136",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518036,
		"speech_101150137",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518037,
		"speech_101150138",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518038,
		"speech_101150139",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518039,
		"speech_101150140",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518040,
		"speech_101150141",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518041,
		"juqing_1011501_01_amb_baofengxve01",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518042,
		"juqing_1011501_02_yuanti",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518043,
		"juqing_1011502_01_liulangzhe",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		518044,
		"juqing_1011502_02_amb_baofengxve01",
		"story_1011501.acb",
		"story_1011501.awb"
	},
	{
		519000,
		"speech_101160101",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519001,
		"speech_101160102",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519002,
		"speech_101160103",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519003,
		"speech_101160104",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519004,
		"speech_101160105",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519005,
		"speech_101160106",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519006,
		"speech_101160108",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519007,
		"speech_101160109",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519008,
		"speech_101160110",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519009,
		"speech_101160111",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519010,
		"speech_101160112",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519011,
		"speech_101160113",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519012,
		"speech_101160114",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519014,
		"speech_101160115",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519015,
		"speech_101160116",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519016,
		"speech_101160117",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519017,
		"speech_101160118",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519018,
		"speech_101160120",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519019,
		"speech_101160123",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519020,
		"speech_101160126",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519021,
		"speech_101160127",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519022,
		"speech_101160128",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519023,
		"speech_101160129",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519024,
		"speech_101160131",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519025,
		"speech_101160132",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519026,
		"speech_101160133",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519027,
		"speech_101160134",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519028,
		"speech_101160135",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519029,
		"speech_101160136",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519030,
		"speech_101160137",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519031,
		"speech_101160138",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519032,
		"speech_101160139",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519033,
		"speech_101160140",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519034,
		"speech_101160141",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519035,
		"speech_101160142",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519036,
		"speech_101160143",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519037,
		"speech_101160144",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519038,
		"speech_101160146",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519039,
		"speech_101160147",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519040,
		"speech_101160148",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519041,
		"speech_101160149",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519042,
		"speech_101160150",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519043,
		"speech_101160151",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519044,
		"speech_101160152",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519045,
		"speech_101160153",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519046,
		"speech_101160154",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519047,
		"speech_101160157",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519048,
		"speech_101160160",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519049,
		"speech_101160161",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519050,
		"speech_101160164",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519051,
		"speech_101160165",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519052,
		"speech_101160166",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519053,
		"speech_101160167",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519054,
		"speech_101160168",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519055,
		"speech_101160171",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519056,
		"speech_101160172",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519057,
		"speech_101160173",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519058,
		"speech_101160175",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519059,
		"speech_101160176",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519060,
		"speech_101160177",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519061,
		"speech_101160179",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519062,
		"speech_101160180",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519063,
		"juqing_1011601_01_yuanti",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519064,
		"juqing_1011601_02_yuanti01",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		519065,
		"juqing_1011601_03_yuanti02",
		"story_1011601.acb",
		"story_1011601.awb"
	},
	{
		520000,
		"speech_101170101",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520001,
		"speech_101170104",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520002,
		"speech_101170106",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520003,
		"speech_101170108",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520004,
		"speech_101170109",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520005,
		"speech_101170110",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520006,
		"speech_101170111",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520007,
		"speech_101170113",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520008,
		"speech_101170114",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520009,
		"speech_101170115",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520010,
		"speech_101170116",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520011,
		"speech_101170118",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520012,
		"speech_101170119",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520013,
		"speech_101170120",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520014,
		"speech_101170121",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520015,
		"speech_101170123",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520016,
		"juqing_1011701_01_jiaobu",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520017,
		"speech_101170101_v2",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520018,
		"speech_101170102_v2",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520019,
		"speech_101170103_v2",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520020,
		"speech_101170104_v2",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520021,
		"speech_101170105_v2",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520022,
		"speech_101170106_v2",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520023,
		"speech_101170107_v2",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520024,
		"speech_101170108_v2",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520025,
		"speech_101170109_v2",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520026,
		"speech_101170110_v2",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520027,
		"speech_101170111_v2",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520028,
		"speech_101170112_v2",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520029,
		"speech_101170113_v2",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		520030,
		"speech_101170114_v2",
		"story_1011701.acb",
		"story_1011701.awb"
	},
	{
		543000,
		"speech_102010101",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543001,
		"speech_102010102",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543002,
		"speech_102010103",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543003,
		"speech_102010104",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543004,
		"speech_102010105",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543005,
		"speech_102010106",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543006,
		"speech_102010107",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543007,
		"speech_102010108",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543008,
		"speech_102010109",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543009,
		"speech_102010110",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543010,
		"speech_102010111",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543011,
		"speech_102010112",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543012,
		"speech_102010113",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543013,
		"speech_102010114",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543014,
		"speech_102010115",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543015,
		"speech_102010116",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543016,
		"speech_102010117",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543017,
		"speech_102010118",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543018,
		"speech_102010119",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543019,
		"speech_102010120",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543020,
		"speech_102010121",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543021,
		"speech_102010122",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543022,
		"speech_102010123",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543023,
		"speech_102010124",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543024,
		"speech_102010125",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543025,
		"speech_102010126",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543026,
		"speech_102010127",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543027,
		"speech_102010128",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543028,
		"speech_102010129",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543029,
		"speech_102010130",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543030,
		"speech_102010131",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543031,
		"speech_102010132",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543032,
		"speech_102010133",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543033,
		"speech_102010134",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543034,
		"speech_102010135",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543035,
		"speech_102010136",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543036,
		"speech_102010137",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543037,
		"speech_102010138",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543038,
		"speech_102010139",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543039,
		"speech_102010140",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543040,
		"speech_102010141",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543041,
		"speech_102010142",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543042,
		"speech_102010143",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543043,
		"speech_102010144",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543044,
		"speech_102010145",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543045,
		"speech_102010146",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543046,
		"speech_102010147",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543047,
		"speech_102010148",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543048,
		"speech_102010149",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543049,
		"speech_102010150",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543050,
		"speech_102010151",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543051,
		"speech_102010152",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543052,
		"speech_102010153",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543053,
		"speech_102010154",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543054,
		"speech_102010155",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543055,
		"speech_102010156",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543056,
		"speech_102010157",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543057,
		"speech_102010158",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543058,
		"speech_102010159",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543059,
		"speech_102010160",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543060,
		"speech_102010161",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543061,
		"speech_102010162",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		543062,
		"juqing_1020101_jinrunaoneiyishi_01",
		"story_1020101.acb",
		"story_1020101.awb"
	},
	{
		542000,
		"speech_102020101",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542001,
		"speech_102020102",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542002,
		"speech_102020103",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542003,
		"speech_102020104",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542004,
		"speech_102020105",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542005,
		"speech_102020106",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542006,
		"speech_102020107",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542007,
		"speech_102020108",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542008,
		"speech_102020109",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542009,
		"speech_102020110",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542010,
		"speech_102020111",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542011,
		"speech_102020112",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542012,
		"speech_102020113",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542013,
		"speech_102020114",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542014,
		"speech_102020115",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542015,
		"speech_102020116",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542016,
		"speech_102020117",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542017,
		"speech_102020118",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542018,
		"speech_102020119",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542019,
		"speech_102020120",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542020,
		"speech_102020121",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542021,
		"speech_102020122",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542022,
		"speech_102020123",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542023,
		"speech_102020124",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542024,
		"speech_102020125",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542025,
		"speech_102020126",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542026,
		"speech_102020127",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542027,
		"speech_102020128",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542028,
		"juqing_1020201_banyunxiangzi_yuanchu_01",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542029,
		"juqing_1020201_banyunxiangzi_yuanchu_huangdongguangxiao_01",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542030,
		"juqing_1020201_dianhuatingtongxunwuxiangying_01",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542031,
		"juqing_1020201_xuedihuanjingintro_01",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		542032,
		"juqing_1020201_xuedihuanjingloop_01",
		"story_1020201.acb",
		"story_1020201.awb"
	},
	{
		521000,
		"juqing_1020202_dianhualing_01",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521001,
		"speech_102020201",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521002,
		"speech_102020202",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521003,
		"speech_102020203",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521004,
		"speech_102020204",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521005,
		"speech_102020205",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521006,
		"speech_102020206",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521007,
		"speech_102020207",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521008,
		"speech_102020208",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521009,
		"speech_102020209",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521010,
		"speech_102020210",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521011,
		"speech_102020211",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521012,
		"speech_102020212",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521013,
		"speech_102020213",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521014,
		"speech_102020214",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521015,
		"speech_102020215",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521016,
		"speech_102020216",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521017,
		"speech_102020217",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521018,
		"speech_102020218",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521019,
		"speech_102020219",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521020,
		"speech_102020220",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521021,
		"juqing_1020202_anniweifeiti_01",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		521022,
		"juqing_1020202_zhunbeihuishoudaren_01",
		"story_1020202.acb",
		"story_1020202.awb"
	},
	{
		522000,
		"juqing_1020301_02_zayin",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522001,
		"speech_102030101",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522002,
		"speech_102030102",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522003,
		"speech_102030103",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522004,
		"speech_102030104",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522005,
		"speech_102030105",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522006,
		"speech_102030106",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522007,
		"speech_102030107",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522008,
		"speech_102030108",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522009,
		"speech_102030109",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522010,
		"speech_102030110",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522011,
		"speech_102030111",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522012,
		"speech_102030112",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522013,
		"speech_102030113",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522014,
		"speech_102030114",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522015,
		"speech_102030115",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522016,
		"speech_102030116",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522017,
		"speech_102030117",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522018,
		"speech_102030118",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522019,
		"speech_102030119",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522020,
		"speech_102030120",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522021,
		"speech_102030121",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522022,
		"speech_102030122",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522023,
		"speech_102030123",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522024,
		"speech_102030124",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522025,
		"speech_102030125",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522026,
		"speech_102030126",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522027,
		"speech_102030127",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522028,
		"speech_102030128",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522029,
		"speech_102030129",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522030,
		"speech_102030130",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522031,
		"speech_102030131",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522032,
		"juqing_1020301_dianhuatingtongxunwuxiangying_01",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522033,
		"juqing_1020301_xuedihuanjingintro_01",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522034,
		"juqing_1020301_xuedihuanjingloop_01",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		522035,
		"speech_102030129_1",
		"story_1020301.acb",
		"story_1020301.awb"
	},
	{
		541000,
		"speech_102030201",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541001,
		"speech_102030202",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541002,
		"speech_102030203",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541003,
		"speech_102030204",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541004,
		"speech_102030205",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541005,
		"speech_102030206",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541006,
		"speech_102030207",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541007,
		"speech_102030208",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541008,
		"speech_102030209",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541009,
		"speech_102030210",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541010,
		"speech_102030211",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541011,
		"speech_102030212",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541012,
		"speech_102030213",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541013,
		"speech_102030214_01",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541014,
		"speech_102030214_02",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541015,
		"speech_102030215",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541016,
		"speech_102030216",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541017,
		"speech_102030217",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541018,
		"speech_102030218",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541019,
		"speech_102030219",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541020,
		"speech_102030220",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541021,
		"speech_102030221",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541022,
		"speech_102030222",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541023,
		"speech_102030223",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541024,
		"speech_102030224",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541025,
		"speech_102030225",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541026,
		"speech_102030226",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541027,
		"speech_102030227",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541028,
		"speech_102030228",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541029,
		"speech_102030229",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541030,
		"speech_102030230",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541031,
		"speech_102030231",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541032,
		"speech_102030232",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541033,
		"speech_102030233",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541034,
		"speech_102030234",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541035,
		"speech_102030235",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541036,
		"speech_102030236",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541037,
		"juqing_1020302_feiniaoyanhuojingjie_01",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541038,
		"juqing_1020302_painaodai_01",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541039,
		"juqing_1020302_yanhuoxinshebeisouxunwancheng_01",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		541040,
		"juqing_1020302_yanhuoxinshebeisouxunzhong_01",
		"story_1020302.acb",
		"story_1020302.awb"
	},
	{
		523000,
		"juqing_1020401_dianhualing_01",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523001,
		"juqing_1020401_jiedianhua_01",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523002,
		"speech_102040101",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523003,
		"speech_102040102",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523004,
		"speech_102040103",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523005,
		"speech_102040104",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523006,
		"speech_102040105",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523007,
		"speech_102040106",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523008,
		"speech_102040107",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523009,
		"speech_102040108",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523010,
		"speech_102040109",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523011,
		"speech_102040110",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523012,
		"speech_102040111",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523013,
		"speech_102040112",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523014,
		"speech_102040113",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523015,
		"speech_102040114",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523016,
		"speech_102040115",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523017,
		"speech_102040116",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523018,
		"speech_102040117",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523019,
		"speech_102040118",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523020,
		"speech_102040119",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523021,
		"speech_102040120",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523022,
		"speech_102040121",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523023,
		"speech_102040122",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523024,
		"speech_102040123",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523025,
		"speech_102040124",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523026,
		"speech_102040125",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523027,
		"speech_102040126",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523028,
		"speech_102040127",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523029,
		"speech_102040128",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523030,
		"speech_102040129",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523031,
		"speech_102040130",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523032,
		"speech_102040131",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523033,
		"speech_102040132",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		523034,
		"juqing_1020401_wenzi_tuoru_01",
		"story_1020401.acb",
		"story_1020401.awb"
	},
	{
		540000,
		"speech_102040201",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540001,
		"speech_102040202",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540002,
		"speech_102040203",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540003,
		"speech_102040204",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540004,
		"speech_102040205",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540005,
		"speech_102040206",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540006,
		"speech_102040207",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540007,
		"speech_102040208",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540008,
		"speech_102040209",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540009,
		"speech_102040210",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540010,
		"speech_102040211",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540011,
		"speech_102040212",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540012,
		"speech_102040213",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540013,
		"speech_102040214",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540014,
		"speech_102040215",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540015,
		"speech_102040216",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540016,
		"speech_102040217",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540017,
		"speech_102040218",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540018,
		"speech_102040219",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540019,
		"speech_102040220",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540020,
		"speech_102040221",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540021,
		"speech_102040222",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540022,
		"speech_102040223",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540023,
		"speech_102040224",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540024,
		"speech_102040225",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540025,
		"speech_102040226",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540026,
		"speech_102040227",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540027,
		"speech_102040228",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540028,
		"speech_102040229",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540029,
		"speech_102040230",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540030,
		"speech_102040231",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540031,
		"speech_102040232",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540032,
		"speech_102040233",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540033,
		"speech_102040234",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540034,
		"speech_102040235",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540035,
		"speech_102040236",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540036,
		"speech_102040237",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540037,
		"speech_102040238",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		540038,
		"speech_102040239",
		"story_1020402.acb",
		"story_1020402.awb"
	},
	{
		539000,
		"speech_102050101",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539001,
		"speech_102050102",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539002,
		"speech_102050103",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539003,
		"speech_102050104",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539004,
		"speech_102050105",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539005,
		"speech_102050106",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539006,
		"speech_102050107",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539007,
		"speech_102050108",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539008,
		"speech_102050109",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539009,
		"speech_102050110",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539010,
		"speech_102050111",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539011,
		"speech_102050112",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539012,
		"speech_102050113",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539013,
		"speech_102050114",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539014,
		"speech_102050115",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539015,
		"speech_102050116",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539016,
		"speech_102050117",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539017,
		"speech_102050118",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539018,
		"speech_102050119",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539019,
		"speech_102050120",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539020,
		"speech_102050121",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539021,
		"speech_102050122",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539022,
		"speech_102050123",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539023,
		"speech_102050124",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539024,
		"speech_102050125",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539025,
		"speech_102050126",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539026,
		"speech_102050127",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539027,
		"speech_102050128",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539028,
		"speech_102050129",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539029,
		"speech_102050130",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539030,
		"speech_102050131",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539031,
		"speech_102050132",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539032,
		"speech_102050133",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539033,
		"speech_102050134",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539034,
		"speech_102050135",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539035,
		"speech_102050136",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539036,
		"speech_102050137",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539037,
		"speech_102050138",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539038,
		"speech_102050139",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539039,
		"speech_102050140",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539040,
		"speech_102050141",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539041,
		"speech_102050142",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539042,
		"speech_102050143",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539043,
		"speech_102050144",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539044,
		"speech_102050145",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539045,
		"speech_102050146",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539046,
		"speech_102050147",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539047,
		"speech_102050148",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539048,
		"speech_102050149",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539049,
		"speech_102050150",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539050,
		"speech_102050151",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539051,
		"speech_102050152",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539052,
		"speech_102050153",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539053,
		"speech_102050154",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539054,
		"speech_102050155",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539055,
		"speech_102050156",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539056,
		"speech_102050157",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539057,
		"speech_102050158",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539058,
		"speech_102050159",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539059,
		"speech_102050160",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539060,
		"speech_102050161",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539061,
		"speech_102050162",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539062,
		"speech_102050163",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539063,
		"speech_102050164",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539064,
		"speech_102050165",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539065,
		"speech_102050166",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539066,
		"speech_102050167",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539067,
		"speech_102050168",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539068,
		"juqing_1020501_dianhuatingchuansong_lv1_01",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539069,
		"juqing_1020501_dianhuatingchuansong_lv2_01",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539070,
		"juqing_1020501_dianhuatingchuansong_lv3_01",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539071,
		"juqing_1020501_jinrunaoneiyishi_01",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539072,
		"juqing_0000000_naqitingtong_01",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		539073,
		"juqing_1020301_02_zayin",
		"story_1020501.acb",
		"story_1020501.awb"
	},
	{
		524000,
		"juqing_1020601_02_zayin",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524001,
		"juqing_1020601_08_yuanti",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524002,
		"speech_102060101",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524003,
		"speech_102060102",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524004,
		"speech_102060103",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524005,
		"speech_102060104",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524006,
		"speech_102060105",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524007,
		"speech_102060106",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524008,
		"speech_102060107",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524009,
		"speech_102060108",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524010,
		"speech_102060109",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524011,
		"speech_102060110",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524012,
		"speech_102060111",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524013,
		"speech_102060112",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524014,
		"speech_102060113",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524015,
		"speech_102060114",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524016,
		"speech_102060115",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524017,
		"speech_102060116",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524018,
		"speech_102060117",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524019,
		"speech_102060118",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524020,
		"speech_102060119",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524021,
		"speech_102060120",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524022,
		"speech_102060121",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524023,
		"speech_102060122",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524024,
		"speech_102060123",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524025,
		"speech_102060124",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524026,
		"speech_102060125",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524027,
		"speech_102060126",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524028,
		"juqing_1020601_dichutuzhi_01",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524029,
		"juqing_1020601_langqiangbandao_01",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524030,
		"juqing_1020601_naqituzhizhankai_01",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		524031,
		"juqing_1020601_yanhuoxinshebeisouxunzhong_01",
		"story_1020601.acb",
		"story_1020601.awb"
	},
	{
		538000,
		"speech_102070101",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538001,
		"speech_102070102",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538002,
		"speech_102070103",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538003,
		"speech_102070104",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538004,
		"speech_102070105",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538005,
		"speech_102070106",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538006,
		"speech_102070107",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538007,
		"speech_102070108",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538008,
		"speech_102070109",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538009,
		"speech_102070110",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538010,
		"speech_102070111",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538011,
		"speech_102070112",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538012,
		"speech_102070113",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538013,
		"speech_102070114",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538014,
		"speech_102070115",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538015,
		"speech_102070116",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538016,
		"speech_102070117",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538017,
		"speech_102070118",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538018,
		"speech_102070119",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538019,
		"speech_102070120",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538020,
		"speech_102070121",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538021,
		"speech_102070122",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538022,
		"speech_102070123",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538023,
		"speech_102070124",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538024,
		"speech_102070125",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538025,
		"speech_102070126",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538026,
		"speech_102070127",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538027,
		"speech_102070128",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538028,
		"juqing_1020701_jinrunaoneiyishi_01",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		538029,
		"juqing_1020701_naoneiyishijieshu_01",
		"story_1020701.acb",
		"story_1020701.awb"
	},
	{
		525000,
		"juqing_1020801_dianhualing_01",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525001,
		"juqing_1020801_jiedianhua_01",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525002,
		"speech_102080102",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525003,
		"speech_102080103",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525004,
		"speech_102080104",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525005,
		"speech_102080105",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525006,
		"speech_102080106",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525007,
		"speech_102080107",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525008,
		"speech_102080108",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525009,
		"speech_102080109",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525010,
		"speech_102080110",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525011,
		"speech_102080111",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525012,
		"speech_102080112",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525013,
		"speech_102080113",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525014,
		"speech_102080114",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525015,
		"speech_102080115",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525016,
		"speech_102080116",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525017,
		"speech_102080117",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525018,
		"speech_102080118",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525019,
		"speech_102080119",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525020,
		"speech_102080120",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525021,
		"speech_102080121",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525022,
		"speech_102080122",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525023,
		"speech_102080123",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525024,
		"speech_102080124",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525025,
		"speech_102080125",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525026,
		"speech_102080126",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525027,
		"speech_102080127",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525028,
		"speech_102080128",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525029,
		"speech_102080129",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525030,
		"speech_102080130",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525031,
		"speech_102080131",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525032,
		"speech_102080132",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525033,
		"speech_102080133",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525034,
		"speech_102080134",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525035,
		"speech_102080135",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525036,
		"speech_102080136",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525037,
		"speech_102080137",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525038,
		"speech_102080138",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525039,
		"speech_102080139",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525040,
		"speech_102080140",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525041,
		"speech_102080141",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525042,
		"speech_102080142",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525043,
		"speech_102080143",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525044,
		"speech_102080144",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525045,
		"speech_102080145",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525046,
		"speech_102080146",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525047,
		"speech_102080147",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525048,
		"speech_102080148",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525049,
		"speech_102080149",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		525050,
		"speech_102080101",
		"story_1020801.acb",
		"story_1020801.awb"
	},
	{
		526000,
		"juqing_1020901_08_yuanti",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526001,
		"speech_102090101",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526002,
		"speech_102090102",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526003,
		"speech_102090103",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526004,
		"speech_102090104",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526005,
		"speech_102090105",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526006,
		"speech_102090106",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526007,
		"speech_102090107",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526008,
		"speech_102090108",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526009,
		"speech_102090109",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526010,
		"speech_102090110",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526011,
		"speech_102090111",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526012,
		"speech_102090112",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526013,
		"speech_102090113",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526014,
		"speech_102090114",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526015,
		"speech_102090115",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526016,
		"speech_102090116",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526017,
		"speech_102090117",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526018,
		"speech_102090118",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526019,
		"speech_102090119",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526020,
		"speech_102090120",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526021,
		"speech_102090121",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526022,
		"speech_102090122",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526023,
		"speech_102090123",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		526024,
		"speech_102090124",
		"story_1020901.acb",
		"story_1020901.awb"
	},
	{
		537000,
		"speech_102090226",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537001,
		"speech_102090227",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537002,
		"speech_102090228",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537003,
		"speech_102090229",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537004,
		"speech_102090230",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537005,
		"speech_102090231",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537006,
		"speech_102090232",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537007,
		"speech_102090233",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537008,
		"speech_102090234",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537009,
		"speech_102090235",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537010,
		"speech_102090236",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537011,
		"speech_102090237",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537012,
		"speech_102090238",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537013,
		"speech_102090239",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537014,
		"speech_102090240",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537015,
		"speech_102090241",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537016,
		"speech_102090242",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537017,
		"speech_102090243",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537018,
		"speech_102090244",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537019,
		"speech_102090245",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537020,
		"speech_102090246",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537021,
		"speech_102090247",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537022,
		"speech_102090248",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537023,
		"speech_102090249",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537024,
		"speech_102090250",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537025,
		"speech_102090251",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537026,
		"speech_102090252",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537027,
		"speech_102090253",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537028,
		"speech_102090254",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537029,
		"speech_102090255",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537030,
		"speech_102090256",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537031,
		"speech_102090257",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537032,
		"speech_102090258",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537033,
		"speech_102090259",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537034,
		"speech_102090260",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		537035,
		"juqing_1020902_jinrunaoneiyishi_01",
		"story_1020902.acb",
		"story_1020902.awb"
	},
	{
		527000,
		"juqing_1021001_02_zayin",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527001,
		"juqing_1021001_dianhualing_01",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527002,
		"juqing_1021001_jiedianhua_01",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527003,
		"juqing_1021001_shuidi",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527004,
		"speech_102100101",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527005,
		"speech_102100102",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527006,
		"speech_102100103",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527007,
		"speech_102100104",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527008,
		"speech_102100105",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527009,
		"speech_102100106",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527010,
		"speech_102100107",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527011,
		"speech_102100108",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527012,
		"speech_102100109",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527013,
		"speech_102100110",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527014,
		"speech_102100111",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527015,
		"speech_102100112",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527016,
		"speech_102100113",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527017,
		"speech_102100114",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527018,
		"speech_102100115",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527019,
		"speech_102100116",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527020,
		"speech_102100117",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527021,
		"speech_102100118",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527022,
		"speech_102100119",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527023,
		"speech_102100120",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527024,
		"speech_102100121",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527025,
		"speech_102100122",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527026,
		"speech_102100123",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527027,
		"speech_102100124",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527028,
		"speech_102100125",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527029,
		"speech_102100126",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527030,
		"speech_102100127",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527031,
		"speech_102100128",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527032,
		"speech_102100129",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527033,
		"speech_102100130",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527034,
		"speech_102100131",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527035,
		"speech_102100132",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527036,
		"speech_102100133",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527037,
		"speech_102100134",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527038,
		"speech_102100135",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527039,
		"speech_102100136",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527040,
		"speech_102100137",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527041,
		"speech_102100138",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527042,
		"speech_102100139",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527043,
		"speech_102100140",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527044,
		"speech_102100141",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527045,
		"speech_102100142",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527046,
		"speech_102100143",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527047,
		"speech_102100144",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527048,
		"speech_102100145",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527049,
		"speech_102100146",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527050,
		"speech_102100147",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527051,
		"speech_102100148",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527052,
		"speech_102100149",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527053,
		"speech_102100150",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527054,
		"speech_102100151",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527055,
		"speech_102100152",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527056,
		"speech_102100153",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527057,
		"speech_102100154",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527058,
		"speech_102100155",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527059,
		"speech_102100156",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527060,
		"juqing_1021001_guiyishuidi_01",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527061,
		"juqing_1021001_jinrunaoneiyishi_01",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		527062,
		"speech_102100134_1",
		"story_1021001.acb",
		"story_1021001.awb"
	},
	{
		528000,
		"juqing_1021101_mensuilie",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528001,
		"juqing_1021101_yitaijiejinjingyingguai",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528002,
		"juqing_1021101_zhuangmen",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528003,
		"speech_102110101",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528004,
		"speech_102110102",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528005,
		"speech_102110103",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528006,
		"speech_102110104",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528007,
		"speech_102110105",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528008,
		"speech_102110106",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528009,
		"speech_102110107",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528010,
		"speech_102110108",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528011,
		"speech_102110109",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528012,
		"speech_102110110",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528013,
		"speech_102110111",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528014,
		"speech_102110112",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528015,
		"speech_102110113",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528016,
		"speech_102110114",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528017,
		"speech_102110115",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528018,
		"speech_102110116",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528019,
		"speech_102110117",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528020,
		"speech_102110118",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528021,
		"speech_102110119",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528022,
		"speech_102110120",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528023,
		"speech_102110121",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528024,
		"speech_102110122",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528025,
		"speech_102110123",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528026,
		"speech_102110124",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528027,
		"speech_102110125",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528028,
		"speech_102110126",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528029,
		"speech_102110127",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528030,
		"speech_102110128",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528031,
		"speech_102110129",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528032,
		"speech_102110130",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528033,
		"speech_102110131",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528034,
		"speech_102110132",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528035,
		"speech_102110133",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528036,
		"speech_102110134",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528037,
		"speech_102110135",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528038,
		"speech_102110136",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528039,
		"speech_102110137",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528040,
		"speech_102110138",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528041,
		"speech_102110138_1",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528042,
		"speech_102110139",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528043,
		"speech_102110140",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528044,
		"speech_102110141",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528045,
		"speech_102110142",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528046,
		"juqing_1021101_fenlierdafeiyuanti_01",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528047,
		"juqing_1021101_fenlierpomenweisui_01",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528048,
		"juqing_1021101_fenlierxuligongjipomen_01",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528049,
		"juqing_1021101_pomenhoushachen_01",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528050,
		"juqing_1021101_qiaojijinshumen_01",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528051,
		"juqing_1021101_tiemenfuyuan_lv1_01",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528052,
		"juqing_1021101_tiemenfuyuan_lv2_01",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528053,
		"juqing_1021101_yitaijiejing_jin_bika_loop_01",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528054,
		"juqing_1021101_yitaijiejing_jin_maibo_loop_01",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528055,
		"juqing_1021101_yitaijiejing_yuan_bika_loop_01",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528056,
		"juqing_1021101_yitaijiejing_yuan_loop_01",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		528057,
		"juqing_0000000_mishiyuantikaojin_01",
		"story_1021101.acb",
		"story_1021101.awb"
	},
	{
		536000,
		"speech_102110201",
		"story_1021102.acb",
		"story_1021102.awb"
	},
	{
		536001,
		"speech_102110202",
		"story_1021102.acb",
		"story_1021102.awb"
	},
	{
		536002,
		"speech_102110203",
		"story_1021102.acb",
		"story_1021102.awb"
	},
	{
		536003,
		"speech_102110204",
		"story_1021102.acb",
		"story_1021102.awb"
	},
	{
		536004,
		"speech_102110205",
		"story_1021102.acb",
		"story_1021102.awb"
	},
	{
		536005,
		"speech_102110206",
		"story_1021102.acb",
		"story_1021102.awb"
	},
	{
		536006,
		"speech_102110207",
		"story_1021102.acb",
		"story_1021102.awb"
	},
	{
		536007,
		"speech_102110208",
		"story_1021102.acb",
		"story_1021102.awb"
	},
	{
		536008,
		"speech_102110209",
		"story_1021102.acb",
		"story_1021102.awb"
	},
	{
		536009,
		"speech_102110210",
		"story_1021102.acb",
		"story_1021102.awb"
	},
	{
		536010,
		"juqing_1021102_jinrunaoneiyishi_01",
		"story_1021102.acb",
		"story_1021102.awb"
	},
	{
		536011,
		"juqing_0000000_mishiyuantikaojin_01",
		"story_1021102.acb",
		"story_1021102.awb"
	},
	{
		535000,
		"speech_102120101",
		"story_1021201.acb",
		"story_1021201.awb"
	},
	{
		535001,
		"speech_102120102",
		"story_1021201.acb",
		"story_1021201.awb"
	},
	{
		535002,
		"speech_102120103",
		"story_1021201.acb",
		"story_1021201.awb"
	},
	{
		535003,
		"speech_102120104",
		"story_1021201.acb",
		"story_1021201.awb"
	},
	{
		535004,
		"speech_102120105",
		"story_1021201.acb",
		"story_1021201.awb"
	},
	{
		535005,
		"speech_102120106",
		"story_1021201.acb",
		"story_1021201.awb"
	},
	{
		535006,
		"speech_102120107",
		"story_1021201.acb",
		"story_1021201.awb"
	},
	{
		535007,
		"speech_102120108",
		"story_1021201.acb",
		"story_1021201.awb"
	},
	{
		535008,
		"speech_102120109",
		"story_1021201.acb",
		"story_1021201.awb"
	},
	{
		535009,
		"speech_102120110",
		"story_1021201.acb",
		"story_1021201.awb"
	},
	{
		535010,
		"speech_102120111",
		"story_1021201.acb",
		"story_1021201.awb"
	},
	{
		535011,
		"speech_102120112",
		"story_1021201.acb",
		"story_1021201.awb"
	},
	{
		535012,
		"speech_102120113",
		"story_1021201.acb",
		"story_1021201.awb"
	},
	{
		535013,
		"speech_102120114",
		"story_1021201.acb",
		"story_1021201.awb"
	},
	{
		535014,
		"speech_102120115",
		"story_1021201.acb",
		"story_1021201.awb"
	},
	{
		535015,
		"juqing_1021201_jinrunaoneiyishi_01",
		"story_1021201.acb",
		"story_1021201.awb"
	},
	{
		535016,
		"juqing_0000000_mishiyuantikaojin_01",
		"story_1021201.acb",
		"story_1021201.awb"
	},
	{
		534000,
		"speech_102120201",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534001,
		"speech_102120202",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534002,
		"speech_102120203",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534003,
		"speech_102120204",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534004,
		"speech_102120205",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534005,
		"speech_102120206",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534006,
		"speech_102120207",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534007,
		"speech_102120208",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534008,
		"speech_102120209",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534009,
		"speech_102120210",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534010,
		"speech_102120211",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534011,
		"speech_102120212",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534012,
		"speech_102120213",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534013,
		"speech_102120214",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534014,
		"speech_102120215",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534015,
		"speech_102120216",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534016,
		"speech_102120217",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534017,
		"speech_102120218",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534018,
		"speech_102120219",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534019,
		"speech_102120220",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534020,
		"speech_102120221",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534021,
		"speech_102120222",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534022,
		"speech_102120223",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534023,
		"speech_102120224",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534024,
		"speech_102120225",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534025,
		"speech_102120226",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534026,
		"speech_102120227",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		534027,
		"juqing_1021202_jinrunaoneiyishi_01",
		"story_1021202.acb",
		"story_1021202.awb"
	},
	{
		529000,
		"juqing_1021301_dianhualing_01",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529001,
		"speech_102130101",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529002,
		"speech_102130102",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529003,
		"speech_102130103",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529004,
		"speech_102130104",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529005,
		"speech_102130105",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529006,
		"speech_102130106",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529007,
		"speech_102130107",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529008,
		"speech_102130108",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529009,
		"speech_102130109",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529010,
		"speech_102130110",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529011,
		"speech_102130111",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529012,
		"speech_102130112",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529013,
		"speech_102130113",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529014,
		"speech_102130114",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529015,
		"speech_102130115",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529016,
		"speech_102130116",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529017,
		"speech_102130117",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529018,
		"speech_102130118",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529019,
		"speech_102130119",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529020,
		"speech_102130120",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529021,
		"speech_102130121",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529022,
		"speech_102130122",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529023,
		"speech_102130123",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529024,
		"speech_102130124",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529025,
		"speech_102130125",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529026,
		"speech_102130126",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529027,
		"speech_102130127",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529028,
		"speech_102130128",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529029,
		"speech_102130129",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529030,
		"speech_102130130",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529031,
		"speech_102130131",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529032,
		"speech_102130132",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529033,
		"speech_102130133",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529034,
		"speech_102130134",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529035,
		"speech_102130135",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529036,
		"speech_102130136",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529037,
		"speech_102130137",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529038,
		"speech_102130138",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529039,
		"speech_102130139",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529040,
		"speech_102130140",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529041,
		"speech_102130141",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529042,
		"speech_102130142",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529043,
		"speech_102130143",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529044,
		"speech_102130144",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529045,
		"speech_102130145",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529046,
		"speech_102130146",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529047,
		"speech_102130147",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529048,
		"speech_102130148",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529049,
		"speech_102130149",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529050,
		"speech_102130150",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529051,
		"speech_102130151",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529052,
		"speech_102130152",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529053,
		"speech_102130153",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529054,
		"speech_102130154",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529055,
		"speech_102130155",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529056,
		"juqing_1021301_fenlierchuzhaoxuli_01",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529057,
		"juqing_1021301_lanzhufenlier_01",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529058,
		"juqing_1021301_lanzhufenlierbingtaochuyaoji_01",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529059,
		"juqing_0000000_naqitingtong_01",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		529060,
		"juqing_1020101_jinrunaoneiyishi_01",
		"story_1021301.acb",
		"story_1021301.awb"
	},
	{
		533000,
		"speech_102130201",
		"story_1021302.acb",
		"story_1021302.awb"
	},
	{
		533001,
		"speech_102130202",
		"story_1021302.acb",
		"story_1021302.awb"
	},
	{
		533002,
		"speech_102130203",
		"story_1021302.acb",
		"story_1021302.awb"
	},
	{
		533003,
		"speech_102130204",
		"story_1021302.acb",
		"story_1021302.awb"
	},
	{
		533004,
		"speech_102130205",
		"story_1021302.acb",
		"story_1021302.awb"
	},
	{
		533005,
		"speech_102130206",
		"story_1021302.acb",
		"story_1021302.awb"
	},
	{
		533006,
		"speech_102130207",
		"story_1021302.acb",
		"story_1021302.awb"
	},
	{
		533007,
		"speech_102130208",
		"story_1021302.acb",
		"story_1021302.awb"
	},
	{
		533008,
		"speech_102130209",
		"story_1021302.acb",
		"story_1021302.awb"
	},
	{
		533009,
		"speech_102130210",
		"story_1021302.acb",
		"story_1021302.awb"
	},
	{
		533010,
		"speech_102130211",
		"story_1021302.acb",
		"story_1021302.awb"
	},
	{
		533011,
		"speech_102130212",
		"story_1021302.acb",
		"story_1021302.awb"
	},
	{
		530000,
		"juqing_1021401_dianhualing_01",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530001,
		"juqing_1021401_ding",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530002,
		"speech_102140101",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530003,
		"speech_102140102",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530004,
		"speech_102140103",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530005,
		"speech_102140104",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530006,
		"speech_102140105",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530007,
		"speech_102140106",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530008,
		"speech_102140107",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530009,
		"speech_102140108",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530010,
		"speech_102140109",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530011,
		"speech_102140110",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530012,
		"speech_102140111",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530013,
		"speech_102140112",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530014,
		"speech_102140113",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530015,
		"speech_102140114",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530016,
		"speech_102140115",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530017,
		"speech_102140116",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530018,
		"speech_102140117",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530019,
		"speech_102140118",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530020,
		"speech_102140119",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530021,
		"speech_102140120",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530022,
		"speech_102140121",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530023,
		"speech_102140122",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530024,
		"speech_102140122_1",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530025,
		"speech_102140123",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530026,
		"speech_102140124",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530027,
		"speech_102140125",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530028,
		"juqing_1021401_dianhuatingchuansong_lv1_01",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530029,
		"juqing_1021401_dianhuatingchuansong_lv2_01",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530030,
		"juqing_1021401_dianhuatingchuansong_lv3_01",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530031,
		"juqing_1021401_dianhuatingdingding_01",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530032,
		"juqing_1021401_dianhuatingxishouwujian_01",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530033,
		"juqing_1021401_wenzi_keshi_01",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530034,
		"juqing_1021401_wenzi_nali_01",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		530035,
		"juqing_1021401_wenzi_zhijue_01",
		"story_1021401.acb",
		"story_1021401.awb"
	},
	{
		532000,
		"speech_102140201",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532001,
		"speech_102140202",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532002,
		"speech_102140203",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532003,
		"speech_102140204",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532004,
		"speech_102140205",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532005,
		"speech_102140206",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532006,
		"speech_102140207",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532007,
		"speech_102140208",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532008,
		"speech_102140209",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532009,
		"speech_102140210",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532010,
		"speech_102140211",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532011,
		"speech_102140212",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532012,
		"speech_102140213",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532013,
		"speech_102140214",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532014,
		"speech_102140215",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532015,
		"speech_102140216",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532016,
		"speech_102140217",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532017,
		"speech_102140218",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532018,
		"speech_102140219",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532019,
		"speech_102140220",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532020,
		"speech_102140221",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532021,
		"speech_102140222",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532022,
		"speech_102140223",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532023,
		"speech_102140224",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532024,
		"speech_102140225",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532025,
		"speech_102140226",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532026,
		"speech_102140227",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532027,
		"speech_102140228",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532028,
		"speech_102140229",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532029,
		"speech_102140230",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532030,
		"speech_102140231",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532031,
		"speech_102140232",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532032,
		"speech_102140233",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532033,
		"speech_102140234",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532034,
		"speech_102140235",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532035,
		"speech_102140236",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532036,
		"speech_102140237",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532037,
		"speech_102140238",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532038,
		"speech_102140239",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532039,
		"speech_102140240",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532040,
		"speech_102140241",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532041,
		"speech_102140242",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532042,
		"speech_102140243",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532043,
		"juqing_1021402_anniweitouxi_01",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532044,
		"juqing_1021402_anniweixuanyun_01",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		532045,
		"juqing_1020301_02_zayin",
		"story_1021402.acb",
		"story_1021402.awb"
	},
	{
		531000,
		"speech_102150101",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531001,
		"speech_102150102",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531002,
		"speech_102150103",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531003,
		"speech_102150104",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531004,
		"speech_102150105",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531005,
		"speech_102150106",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531006,
		"speech_102150107",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531007,
		"speech_102150108",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531008,
		"speech_102150109",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531009,
		"speech_102150110",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531010,
		"speech_102150111",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531011,
		"speech_102150112",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531012,
		"speech_102150113",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531013,
		"speech_102150114",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531014,
		"speech_102150115",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531015,
		"speech_102150116",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531016,
		"speech_102150117",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531017,
		"speech_102150118",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531018,
		"speech_102150119",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531019,
		"speech_102150120",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531020,
		"speech_102150121",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531021,
		"speech_102150122",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531022,
		"speech_102150124",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531023,
		"speech_102150126",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531024,
		"juqing_1021501_xuedihuanjingintro_01",
		"story_1021501.acb",
		"story_1021501.awb"
	},
	{
		531025,
		"juqing_1021501_xuedihuanjingloop_01",
		"story_1021501.acb",
		"story_1021501.awb"
	}
}
local t_criware_audio = {
	[900001] = dataList[1],
	[900002] = dataList[2],
	[900003] = dataList[3],
	[900004] = dataList[4],
	[900005] = dataList[5],
	[900006] = dataList[6],
	[900007] = dataList[7],
	[900008] = dataList[8],
	[900009] = dataList[9],
	[900010] = dataList[10],
	[900011] = dataList[11],
	[900012] = dataList[12],
	[900013] = dataList[13],
	[900014] = dataList[14],
	[900015] = dataList[15],
	[900016] = dataList[16],
	[900017] = dataList[17],
	[900018] = dataList[18],
	[900019] = dataList[19],
	[900020] = dataList[20],
	[900021] = dataList[21],
	[900022] = dataList[22],
	[900023] = dataList[23],
	[900024] = dataList[24],
	[900025] = dataList[25],
	[900026] = dataList[26],
	[900027] = dataList[27],
	[900028] = dataList[28],
	[900029] = dataList[29],
	[100091] = dataList[30],
	[100100] = dataList[31],
	[100110] = dataList[32],
	[100111] = dataList[33],
	[100112] = dataList[34],
	[100113] = dataList[35],
	[100114] = dataList[36],
	[100115] = dataList[37],
	[100116] = dataList[38],
	[100117] = dataList[39],
	[100118] = dataList[40],
	[100119] = dataList[41],
	[100120] = dataList[42],
	[100121] = dataList[43],
	[100122] = dataList[44],
	[100123] = dataList[45],
	[100124] = dataList[46],
	[100125] = dataList[47],
	[100126] = dataList[48],
	[100127] = dataList[49],
	[100128] = dataList[50],
	[100129] = dataList[51],
	[100130] = dataList[52],
	[100131] = dataList[53],
	[100132] = dataList[54],
	[100133] = dataList[55],
	[100135] = dataList[56],
	[100136] = dataList[57],
	[100137] = dataList[58],
	[100138] = dataList[59],
	[100139] = dataList[60],
	[100140] = dataList[61],
	[100143] = dataList[62],
	[100144] = dataList[63],
	[100145] = dataList[64],
	[100146] = dataList[65],
	[100147] = dataList[66],
	[100148] = dataList[67],
	[100149] = dataList[68],
	[100150] = dataList[69],
	[100151] = dataList[70],
	[100152] = dataList[71],
	[100153] = dataList[72],
	[100154] = dataList[73],
	[100155] = dataList[74],
	[100156] = dataList[75],
	[100157] = dataList[76],
	[100158] = dataList[77],
	[100159] = dataList[78],
	[100160] = dataList[79],
	[100161] = dataList[80],
	[100162] = dataList[81],
	[100163] = dataList[82],
	[100164] = dataList[83],
	[100165] = dataList[84],
	[100166] = dataList[85],
	[100167] = dataList[86],
	[100168] = dataList[87],
	[100169] = dataList[88],
	[100170] = dataList[89],
	[100171] = dataList[90],
	[100172] = dataList[91],
	[100173] = dataList[92],
	[100174] = dataList[93],
	[100175] = dataList[94],
	[100176] = dataList[95],
	[100177] = dataList[96],
	[100178] = dataList[97],
	[100179] = dataList[98],
	[100180] = dataList[99],
	[100181] = dataList[100],
	[100182] = dataList[101],
	[100183] = dataList[102],
	[100184] = dataList[103],
	[100185] = dataList[104],
	[100186] = dataList[105],
	[100187] = dataList[106],
	[100188] = dataList[107],
	[100189] = dataList[108],
	[100190] = dataList[109],
	[100191] = dataList[110],
	[100192] = dataList[111],
	[100193] = dataList[112],
	[100194] = dataList[113],
	[100195] = dataList[114],
	[100196] = dataList[115],
	[100197] = dataList[116],
	[100198] = dataList[117],
	[100199] = dataList[118],
	[100200] = dataList[119],
	[100201] = dataList[120],
	[100202] = dataList[121],
	[100203] = dataList[122],
	[100204] = dataList[123],
	[100205] = dataList[124],
	[100206] = dataList[125],
	[100207] = dataList[126],
	[100208] = dataList[127],
	[100209] = dataList[128],
	[100210] = dataList[129],
	[100211] = dataList[130],
	[100212] = dataList[131],
	[100213] = dataList[132],
	[100214] = dataList[133],
	[100215] = dataList[134],
	[100216] = dataList[135],
	[100217] = dataList[136],
	[100219] = dataList[137],
	[100221] = dataList[138],
	[100222] = dataList[139],
	[100223] = dataList[140],
	[100224] = dataList[141],
	[100225] = dataList[142],
	[100226] = dataList[143],
	[100227] = dataList[144],
	[100228] = dataList[145],
	[100229] = dataList[146],
	[100230] = dataList[147],
	[100231] = dataList[148],
	[100232] = dataList[149],
	[100233] = dataList[150],
	[100234] = dataList[151],
	[100235] = dataList[152],
	[100238] = dataList[153],
	[100239] = dataList[154],
	[100240] = dataList[155],
	[100241] = dataList[156],
	[100242] = dataList[157],
	[100243] = dataList[158],
	[100244] = dataList[159],
	[100245] = dataList[160],
	[100246] = dataList[161],
	[100247] = dataList[162],
	[100274] = dataList[163],
	[100275] = dataList[164],
	[100276] = dataList[165],
	[100277] = dataList[166],
	[100278] = dataList[167],
	[100280] = dataList[168],
	[100281] = dataList[169],
	[100282] = dataList[170],
	[100283] = dataList[171],
	[100284] = dataList[172],
	[100285] = dataList[173],
	[100286] = dataList[174],
	[100287] = dataList[175],
	[100288] = dataList[176],
	[100289] = dataList[177],
	[100292] = dataList[178],
	[100293] = dataList[179],
	[100294] = dataList[180],
	[100295] = dataList[181],
	[100296] = dataList[182],
	[100297] = dataList[183],
	[100300] = dataList[184],
	[100301] = dataList[185],
	[100302] = dataList[186],
	[100303] = dataList[187],
	[100304] = dataList[188],
	[100307] = dataList[189],
	[100308] = dataList[190],
	[100309] = dataList[191],
	[100310] = dataList[192],
	[100311] = dataList[193],
	[100314] = dataList[194],
	[100322] = dataList[195],
	[100323] = dataList[196],
	[100324] = dataList[197],
	[100325] = dataList[198],
	[100328] = dataList[199],
	[100329] = dataList[200],
	[100330] = dataList[201],
	[100331] = dataList[202],
	[100332] = dataList[203],
	[100335] = dataList[204],
	[100336] = dataList[205],
	[100337] = dataList[206],
	[100338] = dataList[207],
	[100339] = dataList[208],
	[100342] = dataList[209],
	[100343] = dataList[210],
	[100344] = dataList[211],
	[100345] = dataList[212],
	[100346] = dataList[213],
	[100349] = dataList[214],
	[100350] = dataList[215],
	[100351] = dataList[216],
	[100352] = dataList[217],
	[100353] = dataList[218],
	[100356] = dataList[219],
	[100357] = dataList[220],
	[100358] = dataList[221],
	[100359] = dataList[222],
	[100360] = dataList[223],
	[100363] = dataList[224],
	[100364] = dataList[225],
	[100365] = dataList[226],
	[100366] = dataList[227],
	[100367] = dataList[228],
	[100370] = dataList[229],
	[100371] = dataList[230],
	[100372] = dataList[231],
	[100373] = dataList[232],
	[100374] = dataList[233],
	[100377] = dataList[234],
	[100378] = dataList[235],
	[100379] = dataList[236],
	[100380] = dataList[237],
	[100381] = dataList[238],
	[100384] = dataList[239],
	[100385] = dataList[240],
	[100386] = dataList[241],
	[100387] = dataList[242],
	[100388] = dataList[243],
	[100391] = dataList[244],
	[100392] = dataList[245],
	[100393] = dataList[246],
	[100394] = dataList[247],
	[100395] = dataList[248],
	[100398] = dataList[249],
	[100399] = dataList[250],
	[100400] = dataList[251],
	[100401] = dataList[252],
	[100402] = dataList[253],
	[100405] = dataList[254],
	[100406] = dataList[255],
	[100407] = dataList[256],
	[100408] = dataList[257],
	[100409] = dataList[258],
	[100412] = dataList[259],
	[100413] = dataList[260],
	[100414] = dataList[261],
	[100415] = dataList[262],
	[100416] = dataList[263],
	[100419] = dataList[264],
	[100420] = dataList[265],
	[100421] = dataList[266],
	[100422] = dataList[267],
	[100423] = dataList[268],
	[100426] = dataList[269],
	[100427] = dataList[270],
	[100428] = dataList[271],
	[100429] = dataList[272],
	[100430] = dataList[273],
	[100433] = dataList[274],
	[100435] = dataList[275],
	[100436] = dataList[276],
	[100437] = dataList[277],
	[100438] = dataList[278],
	[100439] = dataList[279],
	[100440] = dataList[280],
	[100441] = dataList[281],
	[100442] = dataList[282],
	[100443] = dataList[283],
	[100444] = dataList[284],
	[100445] = dataList[285],
	[100446] = dataList[286],
	[100447] = dataList[287],
	[100448] = dataList[288],
	[100449] = dataList[289],
	[100450] = dataList[290],
	[100451] = dataList[291],
	[100452] = dataList[292],
	[100453] = dataList[293],
	[100454] = dataList[294],
	[100455] = dataList[295],
	[100456] = dataList[296],
	[100457] = dataList[297],
	[100458] = dataList[298],
	[100459] = dataList[299],
	[100460] = dataList[300],
	[100461] = dataList[301],
	[100462] = dataList[302],
	[100463] = dataList[303],
	[100464] = dataList[304],
	[100465] = dataList[305],
	[100466] = dataList[306],
	[100467] = dataList[307],
	[100468] = dataList[308],
	[100469] = dataList[309],
	[100470] = dataList[310],
	[100471] = dataList[311],
	[100472] = dataList[312],
	[100473] = dataList[313],
	[100474] = dataList[314],
	[100475] = dataList[315],
	[100476] = dataList[316],
	[100477] = dataList[317],
	[100478] = dataList[318],
	[100479] = dataList[319],
	[100480] = dataList[320],
	[100481] = dataList[321],
	[100482] = dataList[322],
	[100483] = dataList[323],
	[100484] = dataList[324],
	[100485] = dataList[325],
	[100486] = dataList[326],
	[100487] = dataList[327],
	[100488] = dataList[328],
	[100489] = dataList[329],
	[100490] = dataList[330],
	[100491] = dataList[331],
	[100492] = dataList[332],
	[100493] = dataList[333],
	[100494] = dataList[334],
	[100495] = dataList[335],
	[100496] = dataList[336],
	[100497] = dataList[337],
	[100498] = dataList[338],
	[100499] = dataList[339],
	[100500] = dataList[340],
	[100501] = dataList[341],
	[100502] = dataList[342],
	[100503] = dataList[343],
	[100504] = dataList[344],
	[100505] = dataList[345],
	[100506] = dataList[346],
	[100507] = dataList[347],
	[100508] = dataList[348],
	[100509] = dataList[349],
	[100510] = dataList[350],
	[100511] = dataList[351],
	[100512] = dataList[352],
	[100513] = dataList[353],
	[100514] = dataList[354],
	[100515] = dataList[355],
	[100516] = dataList[356],
	[100517] = dataList[357],
	[100518] = dataList[358],
	[100519] = dataList[359],
	[100520] = dataList[360],
	[100521] = dataList[361],
	[100522] = dataList[362],
	[100523] = dataList[363],
	[100524] = dataList[364],
	[100525] = dataList[365],
	[100526] = dataList[366],
	[100527] = dataList[367],
	[100528] = dataList[368],
	[100529] = dataList[369],
	[100530] = dataList[370],
	[100531] = dataList[371],
	[100532] = dataList[372],
	[100533] = dataList[373],
	[100534] = dataList[374],
	[100535] = dataList[375],
	[100536] = dataList[376],
	[100537] = dataList[377],
	[100538] = dataList[378],
	[100540] = dataList[379],
	[100542] = dataList[380],
	[100543] = dataList[381],
	[100544] = dataList[382],
	[100545] = dataList[383],
	[100546] = dataList[384],
	[100549] = dataList[385],
	[100550] = dataList[386],
	[100551] = dataList[387],
	[100552] = dataList[388],
	[100553] = dataList[389],
	[100554] = dataList[390],
	[100555] = dataList[391],
	[100556] = dataList[392],
	[100557] = dataList[393],
	[100558] = dataList[394],
	[100559] = dataList[395],
	[100562] = dataList[396],
	[100563] = dataList[397],
	[100564] = dataList[398],
	[100565] = dataList[399],
	[100566] = dataList[400],
	[100567] = dataList[401],
	[100568] = dataList[402],
	[100569] = dataList[403],
	[100570] = dataList[404],
	[100571] = dataList[405],
	[100572] = dataList[406],
	[100573] = dataList[407],
	[100574] = dataList[408],
	[100575] = dataList[409],
	[100576] = dataList[410],
	[100577] = dataList[411],
	[100578] = dataList[412],
	[100579] = dataList[413],
	[100580] = dataList[414],
	[100581] = dataList[415],
	[100582] = dataList[416],
	[100583] = dataList[417],
	[100584] = dataList[418],
	[100585] = dataList[419],
	[100586] = dataList[420],
	[100587] = dataList[421],
	[100588] = dataList[422],
	[100589] = dataList[423],
	[100590] = dataList[424],
	[100591] = dataList[425],
	[100592] = dataList[426],
	[100593] = dataList[427],
	[100594] = dataList[428],
	[100595] = dataList[429],
	[100596] = dataList[430],
	[100597] = dataList[431],
	[100598] = dataList[432],
	[100599] = dataList[433],
	[100600] = dataList[434],
	[100601] = dataList[435],
	[100602] = dataList[436],
	[100603] = dataList[437],
	[100604] = dataList[438],
	[100605] = dataList[439],
	[100606] = dataList[440],
	[100607] = dataList[441],
	[100608] = dataList[442],
	[100609] = dataList[443],
	[100610] = dataList[444],
	[100611] = dataList[445],
	[100612] = dataList[446],
	[100613] = dataList[447],
	[100614] = dataList[448],
	[100615] = dataList[449],
	[100616] = dataList[450],
	[100617] = dataList[451],
	[100618] = dataList[452],
	[100619] = dataList[453],
	[100620] = dataList[454],
	[100621] = dataList[455],
	[100622] = dataList[456],
	[100623] = dataList[457],
	[100624] = dataList[458],
	[100625] = dataList[459],
	[100626] = dataList[460],
	[100627] = dataList[461],
	[100628] = dataList[462],
	[100629] = dataList[463],
	[100630] = dataList[464],
	[100631] = dataList[465],
	[100632] = dataList[466],
	[100633] = dataList[467],
	[100634] = dataList[468],
	[100635] = dataList[469],
	[100636] = dataList[470],
	[100637] = dataList[471],
	[100638] = dataList[472],
	[100639] = dataList[473],
	[100640] = dataList[474],
	[100641] = dataList[475],
	[100642] = dataList[476],
	[100643] = dataList[477],
	[100644] = dataList[478],
	[100645] = dataList[479],
	[100646] = dataList[480],
	[100647] = dataList[481],
	[100648] = dataList[482],
	[100649] = dataList[483],
	[100650] = dataList[484],
	[100651] = dataList[485],
	[100652] = dataList[486],
	[100653] = dataList[487],
	[100654] = dataList[488],
	[100655] = dataList[489],
	[100656] = dataList[490],
	[100657] = dataList[491],
	[100658] = dataList[492],
	[100659] = dataList[493],
	[100660] = dataList[494],
	[100661] = dataList[495],
	[100662] = dataList[496],
	[100663] = dataList[497],
	[100664] = dataList[498],
	[100665] = dataList[499],
	[100666] = dataList[500],
	[100667] = dataList[501],
	[100668] = dataList[502],
	[100669] = dataList[503],
	[100670] = dataList[504],
	[100671] = dataList[505],
	[100672] = dataList[506],
	[100673] = dataList[507],
	[100674] = dataList[508],
	[100675] = dataList[509],
	[100676] = dataList[510],
	[100677] = dataList[511],
	[100678] = dataList[512],
	[100679] = dataList[513],
	[100680] = dataList[514],
	[100681] = dataList[515],
	[100682] = dataList[516],
	[100683] = dataList[517],
	[100684] = dataList[518],
	[100685] = dataList[519],
	[100686] = dataList[520],
	[100687] = dataList[521],
	[100688] = dataList[522],
	[100689] = dataList[523],
	[100690] = dataList[524],
	[100691] = dataList[525],
	[100692] = dataList[526],
	[100693] = dataList[527],
	[100694] = dataList[528],
	[100695] = dataList[529],
	[100696] = dataList[530],
	[100697] = dataList[531],
	[100698] = dataList[532],
	[100699] = dataList[533],
	[100700] = dataList[534],
	[100701] = dataList[535],
	[100702] = dataList[536],
	[100703] = dataList[537],
	[100704] = dataList[538],
	[100705] = dataList[539],
	[100706] = dataList[540],
	[100707] = dataList[541],
	[100708] = dataList[542],
	[100709] = dataList[543],
	[100710] = dataList[544],
	[100711] = dataList[545],
	[100712] = dataList[546],
	[100713] = dataList[547],
	[100714] = dataList[548],
	[100715] = dataList[549],
	[100716] = dataList[550],
	[100717] = dataList[551],
	[100718] = dataList[552],
	[100719] = dataList[553],
	[100720] = dataList[554],
	[100721] = dataList[555],
	[100722] = dataList[556],
	[100723] = dataList[557],
	[100724] = dataList[558],
	[100725] = dataList[559],
	[100726] = dataList[560],
	[100727] = dataList[561],
	[100728] = dataList[562],
	[100729] = dataList[563],
	[100730] = dataList[564],
	[100731] = dataList[565],
	[100732] = dataList[566],
	[100733] = dataList[567],
	[100734] = dataList[568],
	[100735] = dataList[569],
	[100736] = dataList[570],
	[100737] = dataList[571],
	[100738] = dataList[572],
	[100739] = dataList[573],
	[100740] = dataList[574],
	[100741] = dataList[575],
	[100742] = dataList[576],
	[100743] = dataList[577],
	[100744] = dataList[578],
	[100745] = dataList[579],
	[100746] = dataList[580],
	[100747] = dataList[581],
	[100748] = dataList[582],
	[100749] = dataList[583],
	[100750] = dataList[584],
	[100751] = dataList[585],
	[100752] = dataList[586],
	[100753] = dataList[587],
	[100754] = dataList[588],
	[100755] = dataList[589],
	[100756] = dataList[590],
	[100757] = dataList[591],
	[100758] = dataList[592],
	[100759] = dataList[593],
	[100760] = dataList[594],
	[100761] = dataList[595],
	[100762] = dataList[596],
	[100763] = dataList[597],
	[100764] = dataList[598],
	[100765] = dataList[599],
	[100766] = dataList[600],
	[100767] = dataList[601],
	[100768] = dataList[602],
	[100769] = dataList[603],
	[100770] = dataList[604],
	[100771] = dataList[605],
	[100772] = dataList[606],
	[100773] = dataList[607],
	[100774] = dataList[608],
	[100775] = dataList[609],
	[100776] = dataList[610],
	[100777] = dataList[611],
	[100778] = dataList[612],
	[100779] = dataList[613],
	[100780] = dataList[614],
	[100781] = dataList[615],
	[100782] = dataList[616],
	[100783] = dataList[617],
	[100784] = dataList[618],
	[100785] = dataList[619],
	[100786] = dataList[620],
	[100787] = dataList[621],
	[100788] = dataList[622],
	[100789] = dataList[623],
	[100790] = dataList[624],
	[100791] = dataList[625],
	[100792] = dataList[626],
	[100793] = dataList[627],
	[100794] = dataList[628],
	[100795] = dataList[629],
	[100796] = dataList[630],
	[100797] = dataList[631],
	[100798] = dataList[632],
	[100799] = dataList[633],
	[100800] = dataList[634],
	[100801] = dataList[635],
	[100802] = dataList[636],
	[100803] = dataList[637],
	[100804] = dataList[638],
	[100805] = dataList[639],
	[100806] = dataList[640],
	[100807] = dataList[641],
	[100808] = dataList[642],
	[100809] = dataList[643],
	[100810] = dataList[644],
	[100811] = dataList[645],
	[100812] = dataList[646],
	[100813] = dataList[647],
	[100814] = dataList[648],
	[100815] = dataList[649],
	[100816] = dataList[650],
	[100817] = dataList[651],
	[100818] = dataList[652],
	[100819] = dataList[653],
	[100820] = dataList[654],
	[100821] = dataList[655],
	[100822] = dataList[656],
	[100823] = dataList[657],
	[100824] = dataList[658],
	[140009] = dataList[659],
	[140014] = dataList[660],
	[140015] = dataList[661],
	[140016] = dataList[662],
	[140017] = dataList[663],
	[140018] = dataList[664],
	[140019] = dataList[665],
	[140020] = dataList[666],
	[140021] = dataList[667],
	[140022] = dataList[668],
	[140023] = dataList[669],
	[140024] = dataList[670],
	[140025] = dataList[671],
	[140026] = dataList[672],
	[140027] = dataList[673],
	[140028] = dataList[674],
	[140029] = dataList[675],
	[140030] = dataList[676],
	[140032] = dataList[677],
	[140033] = dataList[678],
	[140034] = dataList[679],
	[140035] = dataList[680],
	[140036] = dataList[681],
	[140037] = dataList[682],
	[140038] = dataList[683],
	[140039] = dataList[684],
	[140040] = dataList[685],
	[140041] = dataList[686],
	[140042] = dataList[687],
	[110000] = dataList[688],
	[110001] = dataList[689],
	[110002] = dataList[690],
	[110003] = dataList[691],
	[120002] = dataList[692],
	[120003] = dataList[693],
	[120004] = dataList[694],
	[120005] = dataList[695],
	[120007] = dataList[696],
	[120008] = dataList[697],
	[120009] = dataList[698],
	[120010] = dataList[699],
	[120011] = dataList[700],
	[120012] = dataList[701],
	[120013] = dataList[702],
	[120014] = dataList[703],
	[120015] = dataList[704],
	[120016] = dataList[705],
	[120017] = dataList[706],
	[120018] = dataList[707],
	[120019] = dataList[708],
	[120020] = dataList[709],
	[120021] = dataList[710],
	[120022] = dataList[711],
	[120023] = dataList[712],
	[120024] = dataList[713],
	[130001] = dataList[714],
	[130004] = dataList[715],
	[130006] = dataList[716],
	[130007] = dataList[717],
	[130008] = dataList[718],
	[130009] = dataList[719],
	[130013] = dataList[720],
	[130014] = dataList[721],
	[130015] = dataList[722],
	[130016] = dataList[723],
	[130017] = dataList[724],
	[130018] = dataList[725],
	[130019] = dataList[726],
	[130020] = dataList[727],
	[130021] = dataList[728],
	[130022] = dataList[729],
	[130023] = dataList[730],
	[130024] = dataList[731],
	[130025] = dataList[732],
	[130026] = dataList[733],
	[130027] = dataList[734],
	[130028] = dataList[735],
	[700000] = dataList[736],
	[500000] = dataList[737],
	[500001] = dataList[738],
	[500002] = dataList[739],
	[500003] = dataList[740],
	[500004] = dataList[741],
	[500005] = dataList[742],
	[500006] = dataList[743],
	[500007] = dataList[744],
	[500008] = dataList[745],
	[500009] = dataList[746],
	[500010] = dataList[747],
	[500011] = dataList[748],
	[500012] = dataList[749],
	[500013] = dataList[750],
	[500014] = dataList[751],
	[500015] = dataList[752],
	[500016] = dataList[753],
	[500017] = dataList[754],
	[500018] = dataList[755],
	[500019] = dataList[756],
	[500020] = dataList[757],
	[500021] = dataList[758],
	[500022] = dataList[759],
	[500023] = dataList[760],
	[500024] = dataList[761],
	[500025] = dataList[762],
	[600000] = dataList[763],
	[600001] = dataList[764],
	[600002] = dataList[765],
	[610000] = dataList[766],
	[610001] = dataList[767],
	[610002] = dataList[768],
	[610003] = dataList[769],
	[610004] = dataList[770],
	[610005] = dataList[771],
	[610006] = dataList[772],
	[610007] = dataList[773],
	[610008] = dataList[774],
	[620000] = dataList[775],
	[620001] = dataList[776],
	[620002] = dataList[777],
	[620005] = dataList[778],
	[630000] = dataList[779],
	[640000] = dataList[780],
	[650000] = dataList[781],
	[521000] = dataList[782],
	[522000] = dataList[783],
	[523000] = dataList[784],
	[523001] = dataList[785],
	[524000] = dataList[786],
	[524001] = dataList[787],
	[525000] = dataList[788],
	[525001] = dataList[789],
	[526000] = dataList[790],
	[527000] = dataList[791],
	[527001] = dataList[792],
	[527002] = dataList[793],
	[527003] = dataList[794],
	[528000] = dataList[795],
	[528001] = dataList[796],
	[528002] = dataList[797],
	[529000] = dataList[798],
	[530000] = dataList[799],
	[530001] = dataList[800],
	[200021] = dataList[801],
	[200023] = dataList[802],
	[200024] = dataList[803],
	[200025] = dataList[804],
	[200026] = dataList[805],
	[200028] = dataList[806],
	[200029] = dataList[807],
	[200033] = dataList[808],
	[200035] = dataList[809],
	[200036] = dataList[810],
	[200037] = dataList[811],
	[200050] = dataList[812],
	[200051] = dataList[813],
	[200056] = dataList[814],
	[200060] = dataList[815],
	[200071] = dataList[816],
	[200072] = dataList[817],
	[200073] = dataList[818],
	[200074] = dataList[819],
	[200075] = dataList[820],
	[200076] = dataList[821],
	[200077] = dataList[822],
	[200078] = dataList[823],
	[200079] = dataList[824],
	[200080] = dataList[825],
	[200081] = dataList[826],
	[200082] = dataList[827],
	[200083] = dataList[828],
	[200084] = dataList[829],
	[200085] = dataList[830],
	[200086] = dataList[831],
	[200087] = dataList[832],
	[200088] = dataList[833],
	[200089] = dataList[834],
	[200090] = dataList[835],
	[200091] = dataList[836],
	[200092] = dataList[837],
	[200093] = dataList[838],
	[200094] = dataList[839],
	[200095] = dataList[840],
	[200096] = dataList[841],
	[200097] = dataList[842],
	[200098] = dataList[843],
	[200099] = dataList[844],
	[200100] = dataList[845],
	[200101] = dataList[846],
	[200102] = dataList[847],
	[200103] = dataList[848],
	[200104] = dataList[849],
	[200105] = dataList[850],
	[200106] = dataList[851],
	[200115] = dataList[852],
	[200116] = dataList[853],
	[200117] = dataList[854],
	[200121] = dataList[855],
	[200122] = dataList[856],
	[200123] = dataList[857],
	[200124] = dataList[858],
	[200125] = dataList[859],
	[200126] = dataList[860],
	[200127] = dataList[861],
	[200128] = dataList[862],
	[200129] = dataList[863],
	[200130] = dataList[864],
	[200131] = dataList[865],
	[200132] = dataList[866],
	[200133] = dataList[867],
	[200134] = dataList[868],
	[200135] = dataList[869],
	[200136] = dataList[870],
	[200137] = dataList[871],
	[200138] = dataList[872],
	[200139] = dataList[873],
	[200142] = dataList[874],
	[200143] = dataList[875],
	[200144] = dataList[876],
	[200145] = dataList[877],
	[200146] = dataList[878],
	[200147] = dataList[879],
	[200148] = dataList[880],
	[200149] = dataList[881],
	[200150] = dataList[882],
	[200151] = dataList[883],
	[200152] = dataList[884],
	[200153] = dataList[885],
	[200154] = dataList[886],
	[200155] = dataList[887],
	[200156] = dataList[888],
	[200157] = dataList[889],
	[200158] = dataList[890],
	[200159] = dataList[891],
	[200160] = dataList[892],
	[200161] = dataList[893],
	[200162] = dataList[894],
	[200163] = dataList[895],
	[200164] = dataList[896],
	[200165] = dataList[897],
	[200166] = dataList[898],
	[200167] = dataList[899],
	[200168] = dataList[900],
	[200170] = dataList[901],
	[200171] = dataList[902],
	[200172] = dataList[903],
	[200173] = dataList[904],
	[200174] = dataList[905],
	[200176] = dataList[906],
	[200177] = dataList[907],
	[200178] = dataList[908],
	[200179] = dataList[909],
	[200180] = dataList[910],
	[200181] = dataList[911],
	[200182] = dataList[912],
	[200183] = dataList[913],
	[200184] = dataList[914],
	[200185] = dataList[915],
	[200186] = dataList[916],
	[200187] = dataList[917],
	[200188] = dataList[918],
	[200189] = dataList[919],
	[200190] = dataList[920],
	[200193] = dataList[921],
	[200194] = dataList[922],
	[200195] = dataList[923],
	[200196] = dataList[924],
	[200197] = dataList[925],
	[200198] = dataList[926],
	[200199] = dataList[927],
	[200200] = dataList[928],
	[200203] = dataList[929],
	[200204] = dataList[930],
	[200205] = dataList[931],
	[200206] = dataList[932],
	[200207] = dataList[933],
	[200208] = dataList[934],
	[200209] = dataList[935],
	[200210] = dataList[936],
	[200211] = dataList[937],
	[200212] = dataList[938],
	[200217] = dataList[939],
	[200218] = dataList[940],
	[200220] = dataList[941],
	[200221] = dataList[942],
	[200222] = dataList[943],
	[200223] = dataList[944],
	[200224] = dataList[945],
	[200225] = dataList[946],
	[200226] = dataList[947],
	[200227] = dataList[948],
	[200228] = dataList[949],
	[200229] = dataList[950],
	[200230] = dataList[951],
	[200231] = dataList[952],
	[200232] = dataList[953],
	[200233] = dataList[954],
	[200234] = dataList[955],
	[200235] = dataList[956],
	[200236] = dataList[957],
	[200237] = dataList[958],
	[200238] = dataList[959],
	[200239] = dataList[960],
	[200240] = dataList[961],
	[200241] = dataList[962],
	[200242] = dataList[963],
	[200243] = dataList[964],
	[200244] = dataList[965],
	[200245] = dataList[966],
	[200246] = dataList[967],
	[200247] = dataList[968],
	[200248] = dataList[969],
	[200249] = dataList[970],
	[200250] = dataList[971],
	[200251] = dataList[972],
	[200252] = dataList[973],
	[200253] = dataList[974],
	[200254] = dataList[975],
	[200255] = dataList[976],
	[200256] = dataList[977],
	[200257] = dataList[978],
	[200258] = dataList[979],
	[200259] = dataList[980],
	[200260] = dataList[981],
	[200261] = dataList[982],
	[200262] = dataList[983],
	[200263] = dataList[984],
	[200264] = dataList[985],
	[200265] = dataList[986],
	[200266] = dataList[987],
	[200267] = dataList[988],
	[200268] = dataList[989],
	[200269] = dataList[990],
	[200270] = dataList[991],
	[200271] = dataList[992],
	[200272] = dataList[993],
	[200273] = dataList[994],
	[200274] = dataList[995],
	[200275] = dataList[996],
	[200276] = dataList[997],
	[200277] = dataList[998],
	[200278] = dataList[999],
	[200279] = dataList[1000],
	[200280] = dataList[1001],
	[200282] = dataList[1002],
	[200283] = dataList[1003],
	[200284] = dataList[1004],
	[200285] = dataList[1005],
	[200286] = dataList[1006],
	[200287] = dataList[1007],
	[200288] = dataList[1008],
	[200289] = dataList[1009],
	[200290] = dataList[1010],
	[200291] = dataList[1011],
	[200292] = dataList[1012],
	[200293] = dataList[1013],
	[200294] = dataList[1014],
	[200295] = dataList[1015],
	[200296] = dataList[1016],
	[200297] = dataList[1017],
	[200298] = dataList[1018],
	[200299] = dataList[1019],
	[200300] = dataList[1020],
	[200301] = dataList[1021],
	[200302] = dataList[1022],
	[200303] = dataList[1023],
	[200304] = dataList[1024],
	[200305] = dataList[1025],
	[200306] = dataList[1026],
	[200307] = dataList[1027],
	[200308] = dataList[1028],
	[200309] = dataList[1029],
	[200310] = dataList[1030],
	[200311] = dataList[1031],
	[200312] = dataList[1032],
	[200313] = dataList[1033],
	[200314] = dataList[1034],
	[200315] = dataList[1035],
	[200316] = dataList[1036],
	[200318] = dataList[1037],
	[200319] = dataList[1038],
	[200320] = dataList[1039],
	[200321] = dataList[1040],
	[200322] = dataList[1041],
	[200323] = dataList[1042],
	[200324] = dataList[1043],
	[200325] = dataList[1044],
	[200326] = dataList[1045],
	[200327] = dataList[1046],
	[200328] = dataList[1047],
	[200329] = dataList[1048],
	[200330] = dataList[1049],
	[200331] = dataList[1050],
	[200332] = dataList[1051],
	[200333] = dataList[1052],
	[200334] = dataList[1053],
	[200335] = dataList[1054],
	[200336] = dataList[1055],
	[200337] = dataList[1056],
	[200338] = dataList[1057],
	[200339] = dataList[1058],
	[200340] = dataList[1059],
	[200341] = dataList[1060],
	[200342] = dataList[1061],
	[200343] = dataList[1062],
	[200344] = dataList[1063],
	[200345] = dataList[1064],
	[200346] = dataList[1065],
	[200347] = dataList[1066],
	[200348] = dataList[1067],
	[200349] = dataList[1068],
	[200350] = dataList[1069],
	[200351] = dataList[1070],
	[200352] = dataList[1071],
	[200353] = dataList[1072],
	[200354] = dataList[1073],
	[200355] = dataList[1074],
	[200356] = dataList[1075],
	[200357] = dataList[1076],
	[200358] = dataList[1077],
	[200359] = dataList[1078],
	[200360] = dataList[1079],
	[200361] = dataList[1080],
	[200362] = dataList[1081],
	[200363] = dataList[1082],
	[200364] = dataList[1083],
	[200365] = dataList[1084],
	[200366] = dataList[1085],
	[200367] = dataList[1086],
	[200368] = dataList[1087],
	[200369] = dataList[1088],
	[200370] = dataList[1089],
	[200371] = dataList[1090],
	[200372] = dataList[1091],
	[200373] = dataList[1092],
	[200374] = dataList[1093],
	[200375] = dataList[1094],
	[200376] = dataList[1095],
	[200377] = dataList[1096],
	[200378] = dataList[1097],
	[200379] = dataList[1098],
	[200380] = dataList[1099],
	[200381] = dataList[1100],
	[200382] = dataList[1101],
	[200383] = dataList[1102],
	[200384] = dataList[1103],
	[200385] = dataList[1104],
	[200386] = dataList[1105],
	[200387] = dataList[1106],
	[200388] = dataList[1107],
	[200389] = dataList[1108],
	[200390] = dataList[1109],
	[200391] = dataList[1110],
	[200392] = dataList[1111],
	[200393] = dataList[1112],
	[200394] = dataList[1113],
	[200395] = dataList[1114],
	[200396] = dataList[1115],
	[400000] = dataList[1116],
	[400001] = dataList[1117],
	[400002] = dataList[1118],
	[400003] = dataList[1119],
	[400004] = dataList[1120],
	[400005] = dataList[1121],
	[400006] = dataList[1122],
	[400007] = dataList[1123],
	[400008] = dataList[1124],
	[400009] = dataList[1125],
	[400010] = dataList[1126],
	[400011] = dataList[1127],
	[400012] = dataList[1128],
	[400013] = dataList[1129],
	[400014] = dataList[1130],
	[400015] = dataList[1131],
	[400016] = dataList[1132],
	[400017] = dataList[1133],
	[400018] = dataList[1134],
	[400019] = dataList[1135],
	[400020] = dataList[1136],
	[400021] = dataList[1137],
	[400022] = dataList[1138],
	[400023] = dataList[1139],
	[400024] = dataList[1140],
	[400025] = dataList[1141],
	[400026] = dataList[1142],
	[400027] = dataList[1143],
	[400028] = dataList[1144],
	[400029] = dataList[1145],
	[400030] = dataList[1146],
	[400031] = dataList[1147],
	[400032] = dataList[1148],
	[400033] = dataList[1149],
	[400034] = dataList[1150],
	[400035] = dataList[1151],
	[400036] = dataList[1152],
	[400037] = dataList[1153],
	[400038] = dataList[1154],
	[400039] = dataList[1155],
	[400040] = dataList[1156],
	[400041] = dataList[1157],
	[400042] = dataList[1158],
	[400043] = dataList[1159],
	[400044] = dataList[1160],
	[400045] = dataList[1161],
	[400046] = dataList[1162],
	[400047] = dataList[1163],
	[400048] = dataList[1164],
	[400049] = dataList[1165],
	[400050] = dataList[1166],
	[400051] = dataList[1167],
	[400052] = dataList[1168],
	[400053] = dataList[1169],
	[400054] = dataList[1170],
	[400055] = dataList[1171],
	[400056] = dataList[1172],
	[400057] = dataList[1173],
	[400058] = dataList[1174],
	[400059] = dataList[1175],
	[400060] = dataList[1176],
	[400061] = dataList[1177],
	[400062] = dataList[1178],
	[400063] = dataList[1179],
	[400064] = dataList[1180],
	[400065] = dataList[1181],
	[400066] = dataList[1182],
	[400067] = dataList[1183],
	[400068] = dataList[1184],
	[400069] = dataList[1185],
	[400070] = dataList[1186],
	[400071] = dataList[1187],
	[400072] = dataList[1188],
	[400073] = dataList[1189],
	[400074] = dataList[1190],
	[400075] = dataList[1191],
	[400076] = dataList[1192],
	[400077] = dataList[1193],
	[400078] = dataList[1194],
	[400079] = dataList[1195],
	[400080] = dataList[1196],
	[400081] = dataList[1197],
	[400082] = dataList[1198],
	[400083] = dataList[1199],
	[400084] = dataList[1200],
	[400085] = dataList[1201],
	[400086] = dataList[1202],
	[400087] = dataList[1203],
	[400088] = dataList[1204],
	[400089] = dataList[1205],
	[400090] = dataList[1206],
	[400091] = dataList[1207],
	[400092] = dataList[1208],
	[400093] = dataList[1209],
	[400094] = dataList[1210],
	[400095] = dataList[1211],
	[400096] = dataList[1212],
	[400097] = dataList[1213],
	[400098] = dataList[1214],
	[400099] = dataList[1215],
	[400100] = dataList[1216],
	[400101] = dataList[1217],
	[400102] = dataList[1218],
	[400103] = dataList[1219],
	[400104] = dataList[1220],
	[400105] = dataList[1221],
	[400106] = dataList[1222],
	[400107] = dataList[1223],
	[400108] = dataList[1224],
	[400109] = dataList[1225],
	[400110] = dataList[1226],
	[400111] = dataList[1227],
	[400112] = dataList[1228],
	[400113] = dataList[1229],
	[400114] = dataList[1230],
	[400115] = dataList[1231],
	[400116] = dataList[1232],
	[400117] = dataList[1233],
	[400118] = dataList[1234],
	[400119] = dataList[1235],
	[400120] = dataList[1236],
	[400121] = dataList[1237],
	[400122] = dataList[1238],
	[400123] = dataList[1239],
	[400124] = dataList[1240],
	[400125] = dataList[1241],
	[400126] = dataList[1242],
	[400127] = dataList[1243],
	[400128] = dataList[1244],
	[400129] = dataList[1245],
	[400130] = dataList[1246],
	[400131] = dataList[1247],
	[400132] = dataList[1248],
	[400133] = dataList[1249],
	[400134] = dataList[1250],
	[400135] = dataList[1251],
	[400136] = dataList[1252],
	[400137] = dataList[1253],
	[400138] = dataList[1254],
	[400139] = dataList[1255],
	[400140] = dataList[1256],
	[400141] = dataList[1257],
	[400142] = dataList[1258],
	[400143] = dataList[1259],
	[400144] = dataList[1260],
	[400145] = dataList[1261],
	[400146] = dataList[1262],
	[400147] = dataList[1263],
	[400148] = dataList[1264],
	[400149] = dataList[1265],
	[400150] = dataList[1266],
	[400151] = dataList[1267],
	[400152] = dataList[1268],
	[400153] = dataList[1269],
	[400154] = dataList[1270],
	[400155] = dataList[1271],
	[400156] = dataList[1272],
	[400157] = dataList[1273],
	[400158] = dataList[1274],
	[400159] = dataList[1275],
	[400160] = dataList[1276],
	[400161] = dataList[1277],
	[400162] = dataList[1278],
	[400163] = dataList[1279],
	[400164] = dataList[1280],
	[400165] = dataList[1281],
	[400166] = dataList[1282],
	[400167] = dataList[1283],
	[400168] = dataList[1284],
	[400169] = dataList[1285],
	[400170] = dataList[1286],
	[400171] = dataList[1287],
	[400172] = dataList[1288],
	[400173] = dataList[1289],
	[400174] = dataList[1290],
	[400175] = dataList[1291],
	[400176] = dataList[1292],
	[400177] = dataList[1293],
	[400178] = dataList[1294],
	[400179] = dataList[1295],
	[400180] = dataList[1296],
	[400181] = dataList[1297],
	[400182] = dataList[1298],
	[400183] = dataList[1299],
	[400184] = dataList[1300],
	[400185] = dataList[1301],
	[400186] = dataList[1302],
	[400187] = dataList[1303],
	[400188] = dataList[1304],
	[400189] = dataList[1305],
	[400190] = dataList[1306],
	[400191] = dataList[1307],
	[400192] = dataList[1308],
	[400193] = dataList[1309],
	[400194] = dataList[1310],
	[400195] = dataList[1311],
	[400196] = dataList[1312],
	[400197] = dataList[1313],
	[400198] = dataList[1314],
	[400199] = dataList[1315],
	[400200] = dataList[1316],
	[400201] = dataList[1317],
	[400202] = dataList[1318],
	[400203] = dataList[1319],
	[400204] = dataList[1320],
	[400205] = dataList[1321],
	[400206] = dataList[1322],
	[400207] = dataList[1323],
	[400208] = dataList[1324],
	[400209] = dataList[1325],
	[400210] = dataList[1326],
	[400211] = dataList[1327],
	[400212] = dataList[1328],
	[400213] = dataList[1329],
	[400214] = dataList[1330],
	[400215] = dataList[1331],
	[400216] = dataList[1332],
	[400217] = dataList[1333],
	[400218] = dataList[1334],
	[400219] = dataList[1335],
	[400220] = dataList[1336],
	[400221] = dataList[1337],
	[400222] = dataList[1338],
	[400223] = dataList[1339],
	[400224] = dataList[1340],
	[400225] = dataList[1341],
	[400226] = dataList[1342],
	[400227] = dataList[1343],
	[400228] = dataList[1344],
	[400229] = dataList[1345],
	[400230] = dataList[1346],
	[400231] = dataList[1347],
	[400232] = dataList[1348],
	[400233] = dataList[1349],
	[400234] = dataList[1350],
	[400235] = dataList[1351],
	[400236] = dataList[1352],
	[400237] = dataList[1353],
	[400238] = dataList[1354],
	[400239] = dataList[1355],
	[400240] = dataList[1356],
	[400241] = dataList[1357],
	[400242] = dataList[1358],
	[400243] = dataList[1359],
	[400244] = dataList[1360],
	[400245] = dataList[1361],
	[400246] = dataList[1362],
	[400247] = dataList[1363],
	[400248] = dataList[1364],
	[400249] = dataList[1365],
	[400250] = dataList[1366],
	[400251] = dataList[1367],
	[400252] = dataList[1368],
	[400253] = dataList[1369],
	[400254] = dataList[1370],
	[400255] = dataList[1371],
	[400256] = dataList[1372],
	[400257] = dataList[1373],
	[400258] = dataList[1374],
	[400259] = dataList[1375],
	[400260] = dataList[1376],
	[400261] = dataList[1377],
	[400262] = dataList[1378],
	[400263] = dataList[1379],
	[400264] = dataList[1380],
	[400265] = dataList[1381],
	[400266] = dataList[1382],
	[400267] = dataList[1383],
	[400268] = dataList[1384],
	[400269] = dataList[1385],
	[400270] = dataList[1386],
	[400271] = dataList[1387],
	[400272] = dataList[1388],
	[400273] = dataList[1389],
	[400274] = dataList[1390],
	[400275] = dataList[1391],
	[400276] = dataList[1392],
	[400277] = dataList[1393],
	[400278] = dataList[1394],
	[400279] = dataList[1395],
	[400280] = dataList[1396],
	[400281] = dataList[1397],
	[400282] = dataList[1398],
	[400283] = dataList[1399],
	[400284] = dataList[1400],
	[400285] = dataList[1401],
	[400286] = dataList[1402],
	[400287] = dataList[1403],
	[400288] = dataList[1404],
	[400289] = dataList[1405],
	[400290] = dataList[1406],
	[400291] = dataList[1407],
	[400292] = dataList[1408],
	[400293] = dataList[1409],
	[400294] = dataList[1410],
	[400295] = dataList[1411],
	[400296] = dataList[1412],
	[400297] = dataList[1413],
	[400298] = dataList[1414],
	[400299] = dataList[1415],
	[400300] = dataList[1416],
	[400301] = dataList[1417],
	[400302] = dataList[1418],
	[400303] = dataList[1419],
	[400304] = dataList[1420],
	[400305] = dataList[1421],
	[400306] = dataList[1422],
	[400307] = dataList[1423],
	[400308] = dataList[1424],
	[400309] = dataList[1425],
	[400310] = dataList[1426],
	[400311] = dataList[1427],
	[400312] = dataList[1428],
	[400313] = dataList[1429],
	[400314] = dataList[1430],
	[400315] = dataList[1431],
	[400316] = dataList[1432],
	[400317] = dataList[1433],
	[400318] = dataList[1434],
	[400319] = dataList[1435],
	[400320] = dataList[1436],
	[400321] = dataList[1437],
	[400322] = dataList[1438],
	[400323] = dataList[1439],
	[400324] = dataList[1440],
	[400325] = dataList[1441],
	[400326] = dataList[1442],
	[400327] = dataList[1443],
	[400328] = dataList[1444],
	[400329] = dataList[1445],
	[400330] = dataList[1446],
	[400331] = dataList[1447],
	[400332] = dataList[1448],
	[400333] = dataList[1449],
	[400334] = dataList[1450],
	[400335] = dataList[1451],
	[400336] = dataList[1452],
	[400337] = dataList[1453],
	[400338] = dataList[1454],
	[400339] = dataList[1455],
	[400340] = dataList[1456],
	[400341] = dataList[1457],
	[400342] = dataList[1458],
	[400343] = dataList[1459],
	[400344] = dataList[1460],
	[400345] = dataList[1461],
	[400346] = dataList[1462],
	[400347] = dataList[1463],
	[400348] = dataList[1464],
	[400349] = dataList[1465],
	[400350] = dataList[1466],
	[400351] = dataList[1467],
	[400352] = dataList[1468],
	[400353] = dataList[1469],
	[400354] = dataList[1470],
	[400355] = dataList[1471],
	[400356] = dataList[1472],
	[400357] = dataList[1473],
	[400358] = dataList[1474],
	[400359] = dataList[1475],
	[400360] = dataList[1476],
	[400361] = dataList[1477],
	[400362] = dataList[1478],
	[400363] = dataList[1479],
	[400364] = dataList[1480],
	[400365] = dataList[1481],
	[400366] = dataList[1482],
	[400367] = dataList[1483],
	[400368] = dataList[1484],
	[400369] = dataList[1485],
	[400370] = dataList[1486],
	[400371] = dataList[1487],
	[400372] = dataList[1488],
	[400373] = dataList[1489],
	[400374] = dataList[1490],
	[400375] = dataList[1491],
	[400376] = dataList[1492],
	[400377] = dataList[1493],
	[400378] = dataList[1494],
	[400379] = dataList[1495],
	[400380] = dataList[1496],
	[400381] = dataList[1497],
	[400382] = dataList[1498],
	[400383] = dataList[1499],
	[400384] = dataList[1500],
	[400385] = dataList[1501],
	[400386] = dataList[1502],
	[400387] = dataList[1503],
	[400388] = dataList[1504],
	[400389] = dataList[1505],
	[400390] = dataList[1506],
	[400391] = dataList[1507],
	[400392] = dataList[1508],
	[400393] = dataList[1509],
	[400394] = dataList[1510],
	[400395] = dataList[1511],
	[400396] = dataList[1512],
	[400397] = dataList[1513],
	[400398] = dataList[1514],
	[400399] = dataList[1515],
	[400400] = dataList[1516],
	[400401] = dataList[1517],
	[400402] = dataList[1518],
	[400403] = dataList[1519],
	[400404] = dataList[1520],
	[400405] = dataList[1521],
	[400406] = dataList[1522],
	[400407] = dataList[1523],
	[400408] = dataList[1524],
	[400409] = dataList[1525],
	[400410] = dataList[1526],
	[400411] = dataList[1527],
	[400412] = dataList[1528],
	[400413] = dataList[1529],
	[400414] = dataList[1530],
	[400415] = dataList[1531],
	[400416] = dataList[1532],
	[400417] = dataList[1533],
	[400418] = dataList[1534],
	[400419] = dataList[1535],
	[400420] = dataList[1536],
	[400421] = dataList[1537],
	[400422] = dataList[1538],
	[400423] = dataList[1539],
	[400424] = dataList[1540],
	[400425] = dataList[1541],
	[400426] = dataList[1542],
	[400427] = dataList[1543],
	[400428] = dataList[1544],
	[400429] = dataList[1545],
	[400430] = dataList[1546],
	[400431] = dataList[1547],
	[400432] = dataList[1548],
	[400433] = dataList[1549],
	[400434] = dataList[1550],
	[400435] = dataList[1551],
	[400436] = dataList[1552],
	[400437] = dataList[1553],
	[400438] = dataList[1554],
	[400439] = dataList[1555],
	[400440] = dataList[1556],
	[400441] = dataList[1557],
	[400442] = dataList[1558],
	[400443] = dataList[1559],
	[400444] = dataList[1560],
	[400445] = dataList[1561],
	[400446] = dataList[1562],
	[400447] = dataList[1563],
	[400448] = dataList[1564],
	[400449] = dataList[1565],
	[400450] = dataList[1566],
	[400451] = dataList[1567],
	[400452] = dataList[1568],
	[400453] = dataList[1569],
	[400454] = dataList[1570],
	[400455] = dataList[1571],
	[400456] = dataList[1572],
	[400457] = dataList[1573],
	[400458] = dataList[1574],
	[400459] = dataList[1575],
	[400460] = dataList[1576],
	[400461] = dataList[1577],
	[400462] = dataList[1578],
	[400463] = dataList[1579],
	[400464] = dataList[1580],
	[400465] = dataList[1581],
	[400466] = dataList[1582],
	[400467] = dataList[1583],
	[400468] = dataList[1584],
	[400469] = dataList[1585],
	[400470] = dataList[1586],
	[400471] = dataList[1587],
	[400472] = dataList[1588],
	[400473] = dataList[1589],
	[400474] = dataList[1590],
	[400475] = dataList[1591],
	[400476] = dataList[1592],
	[400477] = dataList[1593],
	[400478] = dataList[1594],
	[400479] = dataList[1595],
	[400480] = dataList[1596],
	[400481] = dataList[1597],
	[400482] = dataList[1598],
	[400483] = dataList[1599],
	[400484] = dataList[1600],
	[400485] = dataList[1601],
	[400486] = dataList[1602],
	[400487] = dataList[1603],
	[400488] = dataList[1604],
	[400489] = dataList[1605],
	[400490] = dataList[1606],
	[400491] = dataList[1607],
	[400492] = dataList[1608],
	[400493] = dataList[1609],
	[400494] = dataList[1610],
	[400495] = dataList[1611],
	[400496] = dataList[1612],
	[400497] = dataList[1613],
	[400498] = dataList[1614],
	[400499] = dataList[1615],
	[400500] = dataList[1616],
	[400501] = dataList[1617],
	[400502] = dataList[1618],
	[400503] = dataList[1619],
	[400504] = dataList[1620],
	[400505] = dataList[1621],
	[400506] = dataList[1622],
	[400507] = dataList[1623],
	[400508] = dataList[1624],
	[400509] = dataList[1625],
	[400510] = dataList[1626],
	[400511] = dataList[1627],
	[400512] = dataList[1628],
	[400513] = dataList[1629],
	[400514] = dataList[1630],
	[400515] = dataList[1631],
	[400516] = dataList[1632],
	[400517] = dataList[1633],
	[400518] = dataList[1634],
	[400519] = dataList[1635],
	[400520] = dataList[1636],
	[400521] = dataList[1637],
	[400522] = dataList[1638],
	[400523] = dataList[1639],
	[400524] = dataList[1640],
	[400525] = dataList[1641],
	[400526] = dataList[1642],
	[400527] = dataList[1643],
	[400528] = dataList[1644],
	[400529] = dataList[1645],
	[400530] = dataList[1646],
	[400531] = dataList[1647],
	[400532] = dataList[1648],
	[400533] = dataList[1649],
	[400534] = dataList[1650],
	[400535] = dataList[1651],
	[400536] = dataList[1652],
	[400537] = dataList[1653],
	[400538] = dataList[1654],
	[400539] = dataList[1655],
	[400540] = dataList[1656],
	[400541] = dataList[1657],
	[400542] = dataList[1658],
	[400543] = dataList[1659],
	[400544] = dataList[1660],
	[400545] = dataList[1661],
	[400546] = dataList[1662],
	[400547] = dataList[1663],
	[400548] = dataList[1664],
	[400549] = dataList[1665],
	[400550] = dataList[1666],
	[400551] = dataList[1667],
	[400552] = dataList[1668],
	[400553] = dataList[1669],
	[400554] = dataList[1670],
	[400555] = dataList[1671],
	[400556] = dataList[1672],
	[400557] = dataList[1673],
	[400558] = dataList[1674],
	[400559] = dataList[1675],
	[400560] = dataList[1676],
	[400561] = dataList[1677],
	[400562] = dataList[1678],
	[400563] = dataList[1679],
	[400564] = dataList[1680],
	[400565] = dataList[1681],
	[400566] = dataList[1682],
	[400567] = dataList[1683],
	[400568] = dataList[1684],
	[400569] = dataList[1685],
	[400570] = dataList[1686],
	[400571] = dataList[1687],
	[400572] = dataList[1688],
	[400573] = dataList[1689],
	[400574] = dataList[1690],
	[400575] = dataList[1691],
	[400576] = dataList[1692],
	[400577] = dataList[1693],
	[400578] = dataList[1694],
	[400579] = dataList[1695],
	[400580] = dataList[1696],
	[400581] = dataList[1697],
	[400582] = dataList[1698],
	[400583] = dataList[1699],
	[400584] = dataList[1700],
	[400585] = dataList[1701],
	[400586] = dataList[1702],
	[400587] = dataList[1703],
	[400588] = dataList[1704],
	[400589] = dataList[1705],
	[400590] = dataList[1706],
	[400591] = dataList[1707],
	[400592] = dataList[1708],
	[400593] = dataList[1709],
	[400594] = dataList[1710],
	[400595] = dataList[1711],
	[400596] = dataList[1712],
	[400597] = dataList[1713],
	[400598] = dataList[1714],
	[400599] = dataList[1715],
	[400600] = dataList[1716],
	[400601] = dataList[1717],
	[400602] = dataList[1718],
	[400603] = dataList[1719],
	[400604] = dataList[1720],
	[400605] = dataList[1721],
	[400606] = dataList[1722],
	[400607] = dataList[1723],
	[400608] = dataList[1724],
	[400609] = dataList[1725],
	[400610] = dataList[1726],
	[400611] = dataList[1727],
	[400612] = dataList[1728],
	[400613] = dataList[1729],
	[400614] = dataList[1730],
	[400615] = dataList[1731],
	[400616] = dataList[1732],
	[400617] = dataList[1733],
	[400618] = dataList[1734],
	[400619] = dataList[1735],
	[400620] = dataList[1736],
	[400621] = dataList[1737],
	[400622] = dataList[1738],
	[400623] = dataList[1739],
	[400624] = dataList[1740],
	[400625] = dataList[1741],
	[400626] = dataList[1742],
	[400627] = dataList[1743],
	[400628] = dataList[1744],
	[400629] = dataList[1745],
	[400630] = dataList[1746],
	[400631] = dataList[1747],
	[400632] = dataList[1748],
	[400633] = dataList[1749],
	[400634] = dataList[1750],
	[400635] = dataList[1751],
	[400636] = dataList[1752],
	[400637] = dataList[1753],
	[400638] = dataList[1754],
	[400639] = dataList[1755],
	[400640] = dataList[1756],
	[400641] = dataList[1757],
	[400642] = dataList[1758],
	[400643] = dataList[1759],
	[400644] = dataList[1760],
	[400645] = dataList[1761],
	[400646] = dataList[1762],
	[400647] = dataList[1763],
	[400648] = dataList[1764],
	[400649] = dataList[1765],
	[400650] = dataList[1766],
	[400651] = dataList[1767],
	[400652] = dataList[1768],
	[400653] = dataList[1769],
	[400654] = dataList[1770],
	[400655] = dataList[1771],
	[400656] = dataList[1772],
	[400657] = dataList[1773],
	[400658] = dataList[1774],
	[400659] = dataList[1775],
	[400660] = dataList[1776],
	[400661] = dataList[1777],
	[400662] = dataList[1778],
	[400663] = dataList[1779],
	[400664] = dataList[1780],
	[400665] = dataList[1781],
	[400666] = dataList[1782],
	[400667] = dataList[1783],
	[400668] = dataList[1784],
	[400669] = dataList[1785],
	[400670] = dataList[1786],
	[400671] = dataList[1787],
	[400672] = dataList[1788],
	[400673] = dataList[1789],
	[400674] = dataList[1790],
	[400675] = dataList[1791],
	[400676] = dataList[1792],
	[400677] = dataList[1793],
	[400678] = dataList[1794],
	[400679] = dataList[1795],
	[400680] = dataList[1796],
	[400681] = dataList[1797],
	[400682] = dataList[1798],
	[400683] = dataList[1799],
	[400684] = dataList[1800],
	[400685] = dataList[1801],
	[400686] = dataList[1802],
	[400687] = dataList[1803],
	[400688] = dataList[1804],
	[400689] = dataList[1805],
	[400690] = dataList[1806],
	[400691] = dataList[1807],
	[400692] = dataList[1808],
	[400693] = dataList[1809],
	[400694] = dataList[1810],
	[400695] = dataList[1811],
	[400696] = dataList[1812],
	[400697] = dataList[1813],
	[400698] = dataList[1814],
	[400699] = dataList[1815],
	[400700] = dataList[1816],
	[400701] = dataList[1817],
	[400702] = dataList[1818],
	[400703] = dataList[1819],
	[400704] = dataList[1820],
	[400705] = dataList[1821],
	[400706] = dataList[1822],
	[400707] = dataList[1823],
	[400708] = dataList[1824],
	[400709] = dataList[1825],
	[400710] = dataList[1826],
	[400711] = dataList[1827],
	[400712] = dataList[1828],
	[400713] = dataList[1829],
	[400714] = dataList[1830],
	[400715] = dataList[1831],
	[400716] = dataList[1832],
	[400717] = dataList[1833],
	[400718] = dataList[1834],
	[400719] = dataList[1835],
	[400720] = dataList[1836],
	[400721] = dataList[1837],
	[400722] = dataList[1838],
	[400723] = dataList[1839],
	[400724] = dataList[1840],
	[400725] = dataList[1841],
	[400726] = dataList[1842],
	[400727] = dataList[1843],
	[400728] = dataList[1844],
	[400729] = dataList[1845],
	[400730] = dataList[1846],
	[400731] = dataList[1847],
	[400732] = dataList[1848],
	[400733] = dataList[1849],
	[400734] = dataList[1850],
	[400735] = dataList[1851],
	[400736] = dataList[1852],
	[400737] = dataList[1853],
	[400738] = dataList[1854],
	[400739] = dataList[1855],
	[400740] = dataList[1856],
	[400741] = dataList[1857],
	[400742] = dataList[1858],
	[400743] = dataList[1859],
	[400744] = dataList[1860],
	[400745] = dataList[1861],
	[400746] = dataList[1862],
	[400747] = dataList[1863],
	[400748] = dataList[1864],
	[400749] = dataList[1865],
	[400750] = dataList[1866],
	[400751] = dataList[1867],
	[400752] = dataList[1868],
	[400753] = dataList[1869],
	[400754] = dataList[1870],
	[400755] = dataList[1871],
	[400756] = dataList[1872],
	[400757] = dataList[1873],
	[400758] = dataList[1874],
	[400759] = dataList[1875],
	[400760] = dataList[1876],
	[400761] = dataList[1877],
	[400762] = dataList[1878],
	[400763] = dataList[1879],
	[400764] = dataList[1880],
	[400765] = dataList[1881],
	[400766] = dataList[1882],
	[400767] = dataList[1883],
	[400768] = dataList[1884],
	[400769] = dataList[1885],
	[400770] = dataList[1886],
	[400771] = dataList[1887],
	[400772] = dataList[1888],
	[400773] = dataList[1889],
	[400774] = dataList[1890],
	[400775] = dataList[1891],
	[400776] = dataList[1892],
	[400777] = dataList[1893],
	[400778] = dataList[1894],
	[400779] = dataList[1895],
	[400780] = dataList[1896],
	[400781] = dataList[1897],
	[400782] = dataList[1898],
	[400783] = dataList[1899],
	[400784] = dataList[1900],
	[400785] = dataList[1901],
	[400786] = dataList[1902],
	[400787] = dataList[1903],
	[400788] = dataList[1904],
	[400789] = dataList[1905],
	[400790] = dataList[1906],
	[400791] = dataList[1907],
	[400792] = dataList[1908],
	[400793] = dataList[1909],
	[400794] = dataList[1910],
	[400795] = dataList[1911],
	[400796] = dataList[1912],
	[400797] = dataList[1913],
	[400798] = dataList[1914],
	[400799] = dataList[1915],
	[400800] = dataList[1916],
	[400801] = dataList[1917],
	[400802] = dataList[1918],
	[400803] = dataList[1919],
	[400804] = dataList[1920],
	[400805] = dataList[1921],
	[400806] = dataList[1922],
	[400807] = dataList[1923],
	[400808] = dataList[1924],
	[400809] = dataList[1925],
	[400810] = dataList[1926],
	[400811] = dataList[1927],
	[400812] = dataList[1928],
	[400813] = dataList[1929],
	[400814] = dataList[1930],
	[400815] = dataList[1931],
	[400816] = dataList[1932],
	[400817] = dataList[1933],
	[400818] = dataList[1934],
	[400819] = dataList[1935],
	[400820] = dataList[1936],
	[400821] = dataList[1937],
	[400822] = dataList[1938],
	[400823] = dataList[1939],
	[400824] = dataList[1940],
	[400825] = dataList[1941],
	[400826] = dataList[1942],
	[400827] = dataList[1943],
	[400828] = dataList[1944],
	[400829] = dataList[1945],
	[400830] = dataList[1946],
	[400831] = dataList[1947],
	[400832] = dataList[1948],
	[400833] = dataList[1949],
	[400834] = dataList[1950],
	[400835] = dataList[1951],
	[400836] = dataList[1952],
	[400837] = dataList[1953],
	[400838] = dataList[1954],
	[400839] = dataList[1955],
	[400840] = dataList[1956],
	[400841] = dataList[1957],
	[400842] = dataList[1958],
	[400843] = dataList[1959],
	[400844] = dataList[1960],
	[400845] = dataList[1961],
	[400846] = dataList[1962],
	[400847] = dataList[1963],
	[400848] = dataList[1964],
	[400849] = dataList[1965],
	[400850] = dataList[1966],
	[400851] = dataList[1967],
	[400852] = dataList[1968],
	[400853] = dataList[1969],
	[400854] = dataList[1970],
	[400855] = dataList[1971],
	[400856] = dataList[1972],
	[400857] = dataList[1973],
	[400858] = dataList[1974],
	[400859] = dataList[1975],
	[400860] = dataList[1976],
	[400861] = dataList[1977],
	[400862] = dataList[1978],
	[400863] = dataList[1979],
	[400864] = dataList[1980],
	[400865] = dataList[1981],
	[400866] = dataList[1982],
	[400867] = dataList[1983],
	[400868] = dataList[1984],
	[400869] = dataList[1985],
	[400870] = dataList[1986],
	[400871] = dataList[1987],
	[400872] = dataList[1988],
	[400873] = dataList[1989],
	[400874] = dataList[1990],
	[400875] = dataList[1991],
	[400876] = dataList[1992],
	[400877] = dataList[1993],
	[400878] = dataList[1994],
	[400879] = dataList[1995],
	[400880] = dataList[1996],
	[400881] = dataList[1997],
	[400882] = dataList[1998],
	[400883] = dataList[1999],
	[400884] = dataList[2000],
	[400885] = dataList[2001],
	[400886] = dataList[2002],
	[400887] = dataList[2003],
	[400888] = dataList[2004],
	[400889] = dataList[2005],
	[400890] = dataList[2006],
	[400891] = dataList[2007],
	[400892] = dataList[2008],
	[400893] = dataList[2009],
	[400894] = dataList[2010],
	[400895] = dataList[2011],
	[400896] = dataList[2012],
	[400897] = dataList[2013],
	[400898] = dataList[2014],
	[400899] = dataList[2015],
	[400900] = dataList[2016],
	[400901] = dataList[2017],
	[400902] = dataList[2018],
	[400903] = dataList[2019],
	[400904] = dataList[2020],
	[400905] = dataList[2021],
	[400906] = dataList[2022],
	[400907] = dataList[2023],
	[400908] = dataList[2024],
	[400909] = dataList[2025],
	[400910] = dataList[2026],
	[400911] = dataList[2027],
	[400912] = dataList[2028],
	[400913] = dataList[2029],
	[400914] = dataList[2030],
	[400915] = dataList[2031],
	[400916] = dataList[2032],
	[400917] = dataList[2033],
	[400918] = dataList[2034],
	[400919] = dataList[2035],
	[400920] = dataList[2036],
	[400921] = dataList[2037],
	[400922] = dataList[2038],
	[400923] = dataList[2039],
	[400924] = dataList[2040],
	[400925] = dataList[2041],
	[400926] = dataList[2042],
	[400927] = dataList[2043],
	[400928] = dataList[2044],
	[400929] = dataList[2045],
	[400930] = dataList[2046],
	[400931] = dataList[2047],
	[400932] = dataList[2048],
	[400933] = dataList[2049],
	[400934] = dataList[2050],
	[400935] = dataList[2051],
	[400936] = dataList[2052],
	[400937] = dataList[2053],
	[400938] = dataList[2054],
	[400939] = dataList[2055],
	[400940] = dataList[2056],
	[400941] = dataList[2057],
	[400942] = dataList[2058],
	[400943] = dataList[2059],
	[400944] = dataList[2060],
	[400945] = dataList[2061],
	[400946] = dataList[2062],
	[400947] = dataList[2063],
	[400948] = dataList[2064],
	[400949] = dataList[2065],
	[400950] = dataList[2066],
	[400951] = dataList[2067],
	[400952] = dataList[2068],
	[400953] = dataList[2069],
	[400954] = dataList[2070],
	[400955] = dataList[2071],
	[400956] = dataList[2072],
	[400957] = dataList[2073],
	[400958] = dataList[2074],
	[400959] = dataList[2075],
	[400960] = dataList[2076],
	[400961] = dataList[2077],
	[400962] = dataList[2078],
	[400963] = dataList[2079],
	[400964] = dataList[2080],
	[400965] = dataList[2081],
	[400966] = dataList[2082],
	[400967] = dataList[2083],
	[400968] = dataList[2084],
	[400969] = dataList[2085],
	[400970] = dataList[2086],
	[400971] = dataList[2087],
	[400972] = dataList[2088],
	[400973] = dataList[2089],
	[400974] = dataList[2090],
	[400975] = dataList[2091],
	[400976] = dataList[2092],
	[400977] = dataList[2093],
	[400978] = dataList[2094],
	[400979] = dataList[2095],
	[400980] = dataList[2096],
	[400981] = dataList[2097],
	[400982] = dataList[2098],
	[400983] = dataList[2099],
	[400984] = dataList[2100],
	[400985] = dataList[2101],
	[400986] = dataList[2102],
	[400987] = dataList[2103],
	[400988] = dataList[2104],
	[400989] = dataList[2105],
	[400990] = dataList[2106],
	[400991] = dataList[2107],
	[400992] = dataList[2108],
	[400993] = dataList[2109],
	[400994] = dataList[2110],
	[400995] = dataList[2111],
	[400996] = dataList[2112],
	[400997] = dataList[2113],
	[400998] = dataList[2114],
	[400999] = dataList[2115],
	[401000] = dataList[2116],
	[401001] = dataList[2117],
	[401002] = dataList[2118],
	[401003] = dataList[2119],
	[401004] = dataList[2120],
	[401005] = dataList[2121],
	[401006] = dataList[2122],
	[401007] = dataList[2123],
	[401008] = dataList[2124],
	[401009] = dataList[2125],
	[401010] = dataList[2126],
	[401011] = dataList[2127],
	[401012] = dataList[2128],
	[401013] = dataList[2129],
	[401014] = dataList[2130],
	[401015] = dataList[2131],
	[401016] = dataList[2132],
	[401017] = dataList[2133],
	[401018] = dataList[2134],
	[401019] = dataList[2135],
	[401020] = dataList[2136],
	[401021] = dataList[2137],
	[401022] = dataList[2138],
	[401023] = dataList[2139],
	[401024] = dataList[2140],
	[401025] = dataList[2141],
	[401026] = dataList[2142],
	[401027] = dataList[2143],
	[401028] = dataList[2144],
	[401029] = dataList[2145],
	[401030] = dataList[2146],
	[401031] = dataList[2147],
	[401032] = dataList[2148],
	[401033] = dataList[2149],
	[401034] = dataList[2150],
	[401035] = dataList[2151],
	[401036] = dataList[2152],
	[401037] = dataList[2153],
	[401038] = dataList[2154],
	[401039] = dataList[2155],
	[401040] = dataList[2156],
	[401041] = dataList[2157],
	[401042] = dataList[2158],
	[401043] = dataList[2159],
	[401044] = dataList[2160],
	[401045] = dataList[2161],
	[401046] = dataList[2162],
	[401047] = dataList[2163],
	[401048] = dataList[2164],
	[401049] = dataList[2165],
	[401050] = dataList[2166],
	[401051] = dataList[2167],
	[401052] = dataList[2168],
	[401053] = dataList[2169],
	[401054] = dataList[2170],
	[401055] = dataList[2171],
	[401056] = dataList[2172],
	[401057] = dataList[2173],
	[401058] = dataList[2174],
	[401059] = dataList[2175],
	[401060] = dataList[2176],
	[401061] = dataList[2177],
	[401062] = dataList[2178],
	[401063] = dataList[2179],
	[401064] = dataList[2180],
	[401065] = dataList[2181],
	[401066] = dataList[2182],
	[401067] = dataList[2183],
	[401068] = dataList[2184],
	[401069] = dataList[2185],
	[401070] = dataList[2186],
	[401071] = dataList[2187],
	[401072] = dataList[2188],
	[401073] = dataList[2189],
	[401074] = dataList[2190],
	[401075] = dataList[2191],
	[401076] = dataList[2192],
	[401077] = dataList[2193],
	[401078] = dataList[2194],
	[401079] = dataList[2195],
	[401080] = dataList[2196],
	[401081] = dataList[2197],
	[401082] = dataList[2198],
	[401083] = dataList[2199],
	[401084] = dataList[2200],
	[401085] = dataList[2201],
	[401086] = dataList[2202],
	[401087] = dataList[2203],
	[401088] = dataList[2204],
	[401089] = dataList[2205],
	[401090] = dataList[2206],
	[401091] = dataList[2207],
	[401092] = dataList[2208],
	[401093] = dataList[2209],
	[401094] = dataList[2210],
	[401095] = dataList[2211],
	[401096] = dataList[2212],
	[401097] = dataList[2213],
	[401098] = dataList[2214],
	[401099] = dataList[2215],
	[401100] = dataList[2216],
	[401101] = dataList[2217],
	[401102] = dataList[2218],
	[401103] = dataList[2219],
	[401104] = dataList[2220],
	[401105] = dataList[2221],
	[401106] = dataList[2222],
	[401107] = dataList[2223],
	[401108] = dataList[2224],
	[401109] = dataList[2225],
	[401110] = dataList[2226],
	[401111] = dataList[2227],
	[401112] = dataList[2228],
	[401113] = dataList[2229],
	[401114] = dataList[2230],
	[401115] = dataList[2231],
	[401116] = dataList[2232],
	[401117] = dataList[2233],
	[401118] = dataList[2234],
	[401119] = dataList[2235],
	[401120] = dataList[2236],
	[401121] = dataList[2237],
	[401122] = dataList[2238],
	[401123] = dataList[2239],
	[401124] = dataList[2240],
	[401125] = dataList[2241],
	[401126] = dataList[2242],
	[401127] = dataList[2243],
	[401128] = dataList[2244],
	[401129] = dataList[2245],
	[401130] = dataList[2246],
	[401131] = dataList[2247],
	[401132] = dataList[2248],
	[401133] = dataList[2249],
	[401134] = dataList[2250],
	[401135] = dataList[2251],
	[401136] = dataList[2252],
	[401137] = dataList[2253],
	[401138] = dataList[2254],
	[401139] = dataList[2255],
	[401140] = dataList[2256],
	[401141] = dataList[2257],
	[401142] = dataList[2258],
	[401143] = dataList[2259],
	[401144] = dataList[2260],
	[401145] = dataList[2261],
	[401146] = dataList[2262],
	[401147] = dataList[2263],
	[401148] = dataList[2264],
	[401149] = dataList[2265],
	[401150] = dataList[2266],
	[401151] = dataList[2267],
	[401152] = dataList[2268],
	[401153] = dataList[2269],
	[401154] = dataList[2270],
	[401155] = dataList[2271],
	[401156] = dataList[2272],
	[401157] = dataList[2273],
	[401158] = dataList[2274],
	[401159] = dataList[2275],
	[401160] = dataList[2276],
	[401161] = dataList[2277],
	[401162] = dataList[2278],
	[401163] = dataList[2279],
	[401164] = dataList[2280],
	[401165] = dataList[2281],
	[401166] = dataList[2282],
	[401167] = dataList[2283],
	[401168] = dataList[2284],
	[401169] = dataList[2285],
	[401170] = dataList[2286],
	[401171] = dataList[2287],
	[401172] = dataList[2288],
	[401173] = dataList[2289],
	[401174] = dataList[2290],
	[401175] = dataList[2291],
	[401176] = dataList[2292],
	[401177] = dataList[2293],
	[401178] = dataList[2294],
	[401179] = dataList[2295],
	[401180] = dataList[2296],
	[401181] = dataList[2297],
	[401182] = dataList[2298],
	[401183] = dataList[2299],
	[401184] = dataList[2300],
	[401185] = dataList[2301],
	[401186] = dataList[2302],
	[401187] = dataList[2303],
	[401188] = dataList[2304],
	[401189] = dataList[2305],
	[401190] = dataList[2306],
	[401191] = dataList[2307],
	[401192] = dataList[2308],
	[401193] = dataList[2309],
	[401194] = dataList[2310],
	[401195] = dataList[2311],
	[401196] = dataList[2312],
	[401197] = dataList[2313],
	[401198] = dataList[2314],
	[401199] = dataList[2315],
	[401200] = dataList[2316],
	[401201] = dataList[2317],
	[401202] = dataList[2318],
	[401203] = dataList[2319],
	[401204] = dataList[2320],
	[401205] = dataList[2321],
	[401206] = dataList[2322],
	[401207] = dataList[2323],
	[401208] = dataList[2324],
	[401209] = dataList[2325],
	[401210] = dataList[2326],
	[401211] = dataList[2327],
	[401212] = dataList[2328],
	[401213] = dataList[2329],
	[401214] = dataList[2330],
	[401215] = dataList[2331],
	[401216] = dataList[2332],
	[401217] = dataList[2333],
	[401218] = dataList[2334],
	[401219] = dataList[2335],
	[401220] = dataList[2336],
	[401221] = dataList[2337],
	[401222] = dataList[2338],
	[401223] = dataList[2339],
	[401224] = dataList[2340],
	[401225] = dataList[2341],
	[401226] = dataList[2342],
	[401227] = dataList[2343],
	[401228] = dataList[2344],
	[401229] = dataList[2345],
	[401230] = dataList[2346],
	[401231] = dataList[2347],
	[401232] = dataList[2348],
	[401233] = dataList[2349],
	[401234] = dataList[2350],
	[401235] = dataList[2351],
	[401236] = dataList[2352],
	[401237] = dataList[2353],
	[401238] = dataList[2354],
	[401239] = dataList[2355],
	[401240] = dataList[2356],
	[401241] = dataList[2357],
	[401242] = dataList[2358],
	[401243] = dataList[2359],
	[401244] = dataList[2360],
	[401245] = dataList[2361],
	[401246] = dataList[2362],
	[401247] = dataList[2363],
	[401248] = dataList[2364],
	[401249] = dataList[2365],
	[401250] = dataList[2366],
	[401251] = dataList[2367],
	[401252] = dataList[2368],
	[401253] = dataList[2369],
	[401254] = dataList[2370],
	[401255] = dataList[2371],
	[401256] = dataList[2372],
	[401257] = dataList[2373],
	[401258] = dataList[2374],
	[401259] = dataList[2375],
	[401260] = dataList[2376],
	[401261] = dataList[2377],
	[401262] = dataList[2378],
	[401263] = dataList[2379],
	[401264] = dataList[2380],
	[401265] = dataList[2381],
	[401266] = dataList[2382],
	[401267] = dataList[2383],
	[401268] = dataList[2384],
	[401269] = dataList[2385],
	[401270] = dataList[2386],
	[401271] = dataList[2387],
	[401272] = dataList[2388],
	[401273] = dataList[2389],
	[401274] = dataList[2390],
	[401275] = dataList[2391],
	[401276] = dataList[2392],
	[401277] = dataList[2393],
	[401278] = dataList[2394],
	[401279] = dataList[2395],
	[401280] = dataList[2396],
	[401281] = dataList[2397],
	[401282] = dataList[2398],
	[401283] = dataList[2399],
	[401284] = dataList[2400],
	[401285] = dataList[2401],
	[401286] = dataList[2402],
	[401287] = dataList[2403],
	[401288] = dataList[2404],
	[401289] = dataList[2405],
	[401290] = dataList[2406],
	[401291] = dataList[2407],
	[401292] = dataList[2408],
	[401293] = dataList[2409],
	[401294] = dataList[2410],
	[401295] = dataList[2411],
	[401296] = dataList[2412],
	[401297] = dataList[2413],
	[401298] = dataList[2414],
	[401299] = dataList[2415],
	[401300] = dataList[2416],
	[401301] = dataList[2417],
	[401302] = dataList[2418],
	[401303] = dataList[2419],
	[401304] = dataList[2420],
	[401305] = dataList[2421],
	[401306] = dataList[2422],
	[401307] = dataList[2423],
	[401308] = dataList[2424],
	[401309] = dataList[2425],
	[401310] = dataList[2426],
	[401311] = dataList[2427],
	[401312] = dataList[2428],
	[401313] = dataList[2429],
	[401314] = dataList[2430],
	[401315] = dataList[2431],
	[401316] = dataList[2432],
	[401317] = dataList[2433],
	[401318] = dataList[2434],
	[401319] = dataList[2435],
	[401320] = dataList[2436],
	[401321] = dataList[2437],
	[401322] = dataList[2438],
	[401323] = dataList[2439],
	[401324] = dataList[2440],
	[401325] = dataList[2441],
	[401326] = dataList[2442],
	[401327] = dataList[2443],
	[401328] = dataList[2444],
	[401329] = dataList[2445],
	[401330] = dataList[2446],
	[401331] = dataList[2447],
	[401332] = dataList[2448],
	[401333] = dataList[2449],
	[401334] = dataList[2450],
	[401335] = dataList[2451],
	[401336] = dataList[2452],
	[401337] = dataList[2453],
	[401338] = dataList[2454],
	[401339] = dataList[2455],
	[401340] = dataList[2456],
	[401341] = dataList[2457],
	[401342] = dataList[2458],
	[401343] = dataList[2459],
	[401344] = dataList[2460],
	[401345] = dataList[2461],
	[401346] = dataList[2462],
	[401347] = dataList[2463],
	[401348] = dataList[2464],
	[401349] = dataList[2465],
	[401350] = dataList[2466],
	[401351] = dataList[2467],
	[401352] = dataList[2468],
	[401353] = dataList[2469],
	[401354] = dataList[2470],
	[401355] = dataList[2471],
	[401356] = dataList[2472],
	[401357] = dataList[2473],
	[401358] = dataList[2474],
	[401359] = dataList[2475],
	[401360] = dataList[2476],
	[401361] = dataList[2477],
	[401362] = dataList[2478],
	[401363] = dataList[2479],
	[401364] = dataList[2480],
	[401365] = dataList[2481],
	[401366] = dataList[2482],
	[401367] = dataList[2483],
	[401368] = dataList[2484],
	[401369] = dataList[2485],
	[401370] = dataList[2486],
	[401371] = dataList[2487],
	[401372] = dataList[2488],
	[401373] = dataList[2489],
	[401374] = dataList[2490],
	[401375] = dataList[2491],
	[401376] = dataList[2492],
	[401377] = dataList[2493],
	[401378] = dataList[2494],
	[401379] = dataList[2495],
	[401380] = dataList[2496],
	[401381] = dataList[2497],
	[401382] = dataList[2498],
	[401383] = dataList[2499],
	[401384] = dataList[2500],
	[401385] = dataList[2501],
	[401386] = dataList[2502],
	[401387] = dataList[2503],
	[401388] = dataList[2504],
	[401389] = dataList[2505],
	[401390] = dataList[2506],
	[401391] = dataList[2507],
	[401392] = dataList[2508],
	[401393] = dataList[2509],
	[401394] = dataList[2510],
	[401395] = dataList[2511],
	[401396] = dataList[2512],
	[401397] = dataList[2513],
	[401398] = dataList[2514],
	[401399] = dataList[2515],
	[401400] = dataList[2516],
	[401401] = dataList[2517],
	[401402] = dataList[2518],
	[401403] = dataList[2519],
	[401404] = dataList[2520],
	[401405] = dataList[2521],
	[401406] = dataList[2522],
	[401407] = dataList[2523],
	[401408] = dataList[2524],
	[401409] = dataList[2525],
	[401410] = dataList[2526],
	[401411] = dataList[2527],
	[401412] = dataList[2528],
	[401413] = dataList[2529],
	[401414] = dataList[2530],
	[401415] = dataList[2531],
	[401416] = dataList[2532],
	[401417] = dataList[2533],
	[401418] = dataList[2534],
	[401419] = dataList[2535],
	[401420] = dataList[2536],
	[401421] = dataList[2537],
	[401422] = dataList[2538],
	[401423] = dataList[2539],
	[401424] = dataList[2540],
	[401425] = dataList[2541],
	[401426] = dataList[2542],
	[401427] = dataList[2543],
	[401428] = dataList[2544],
	[401429] = dataList[2545],
	[401430] = dataList[2546],
	[401431] = dataList[2547],
	[401432] = dataList[2548],
	[401433] = dataList[2549],
	[401434] = dataList[2550],
	[401435] = dataList[2551],
	[401436] = dataList[2552],
	[401437] = dataList[2553],
	[401438] = dataList[2554],
	[401439] = dataList[2555],
	[401440] = dataList[2556],
	[401441] = dataList[2557],
	[401442] = dataList[2558],
	[401443] = dataList[2559],
	[401444] = dataList[2560],
	[401445] = dataList[2561],
	[401446] = dataList[2562],
	[401447] = dataList[2563],
	[401448] = dataList[2564],
	[401449] = dataList[2565],
	[401450] = dataList[2566],
	[401451] = dataList[2567],
	[401452] = dataList[2568],
	[401453] = dataList[2569],
	[401454] = dataList[2570],
	[401455] = dataList[2571],
	[401456] = dataList[2572],
	[401457] = dataList[2573],
	[401458] = dataList[2574],
	[401459] = dataList[2575],
	[401460] = dataList[2576],
	[401461] = dataList[2577],
	[401462] = dataList[2578],
	[401463] = dataList[2579],
	[401464] = dataList[2580],
	[401465] = dataList[2581],
	[401466] = dataList[2582],
	[401467] = dataList[2583],
	[401468] = dataList[2584],
	[401469] = dataList[2585],
	[401470] = dataList[2586],
	[401471] = dataList[2587],
	[401472] = dataList[2588],
	[401473] = dataList[2589],
	[401474] = dataList[2590],
	[401475] = dataList[2591],
	[401476] = dataList[2592],
	[401477] = dataList[2593],
	[401478] = dataList[2594],
	[401479] = dataList[2595],
	[401480] = dataList[2596],
	[401481] = dataList[2597],
	[401482] = dataList[2598],
	[401483] = dataList[2599],
	[401484] = dataList[2600],
	[401485] = dataList[2601],
	[401486] = dataList[2602],
	[401487] = dataList[2603],
	[401488] = dataList[2604],
	[401489] = dataList[2605],
	[401490] = dataList[2606],
	[401491] = dataList[2607],
	[401492] = dataList[2608],
	[401493] = dataList[2609],
	[401494] = dataList[2610],
	[401495] = dataList[2611],
	[401496] = dataList[2612],
	[401497] = dataList[2613],
	[401498] = dataList[2614],
	[401499] = dataList[2615],
	[401500] = dataList[2616],
	[401501] = dataList[2617],
	[401502] = dataList[2618],
	[401503] = dataList[2619],
	[401504] = dataList[2620],
	[401505] = dataList[2621],
	[401506] = dataList[2622],
	[401507] = dataList[2623],
	[401508] = dataList[2624],
	[401509] = dataList[2625],
	[401510] = dataList[2626],
	[401511] = dataList[2627],
	[401512] = dataList[2628],
	[401513] = dataList[2629],
	[401514] = dataList[2630],
	[401515] = dataList[2631],
	[401527] = dataList[2632],
	[401528] = dataList[2633],
	[401529] = dataList[2634],
	[401530] = dataList[2635],
	[401531] = dataList[2636],
	[401532] = dataList[2637],
	[401533] = dataList[2638],
	[401534] = dataList[2639],
	[401535] = dataList[2640],
	[401536] = dataList[2641],
	[401537] = dataList[2642],
	[401538] = dataList[2643],
	[401539] = dataList[2644],
	[401540] = dataList[2645],
	[401541] = dataList[2646],
	[401542] = dataList[2647],
	[401543] = dataList[2648],
	[401544] = dataList[2649],
	[401545] = dataList[2650],
	[401546] = dataList[2651],
	[401547] = dataList[2652],
	[401548] = dataList[2653],
	[401549] = dataList[2654],
	[401550] = dataList[2655],
	[401551] = dataList[2656],
	[401552] = dataList[2657],
	[401553] = dataList[2658],
	[401554] = dataList[2659],
	[401555] = dataList[2660],
	[401556] = dataList[2661],
	[401557] = dataList[2662],
	[401558] = dataList[2663],
	[401560] = dataList[2664],
	[401564] = dataList[2665],
	[401565] = dataList[2666],
	[401566] = dataList[2667],
	[401567] = dataList[2668],
	[401568] = dataList[2669],
	[401569] = dataList[2670],
	[401570] = dataList[2671],
	[401572] = dataList[2672],
	[401573] = dataList[2673],
	[401574] = dataList[2674],
	[401575] = dataList[2675],
	[401576] = dataList[2676],
	[401577] = dataList[2677],
	[401578] = dataList[2678],
	[401579] = dataList[2679],
	[401585] = dataList[2680],
	[401586] = dataList[2681],
	[401590] = dataList[2682],
	[401591] = dataList[2683],
	[401592] = dataList[2684],
	[401593] = dataList[2685],
	[401594] = dataList[2686],
	[401595] = dataList[2687],
	[401596] = dataList[2688],
	[401597] = dataList[2689],
	[401598] = dataList[2690],
	[401599] = dataList[2691],
	[401600] = dataList[2692],
	[401601] = dataList[2693],
	[401603] = dataList[2694],
	[401604] = dataList[2695],
	[401607] = dataList[2696],
	[401608] = dataList[2697],
	[401609] = dataList[2698],
	[401611] = dataList[2699],
	[401614] = dataList[2700],
	[401615] = dataList[2701],
	[401616] = dataList[2702],
	[401617] = dataList[2703],
	[401618] = dataList[2704],
	[401619] = dataList[2705],
	[401620] = dataList[2706],
	[401621] = dataList[2707],
	[401622] = dataList[2708],
	[401623] = dataList[2709],
	[401624] = dataList[2710],
	[401625] = dataList[2711],
	[401626] = dataList[2712],
	[401627] = dataList[2713],
	[401628] = dataList[2714],
	[401629] = dataList[2715],
	[401630] = dataList[2716],
	[401631] = dataList[2717],
	[401633] = dataList[2718],
	[401634] = dataList[2719],
	[401635] = dataList[2720],
	[401636] = dataList[2721],
	[401637] = dataList[2722],
	[401647] = dataList[2723],
	[401648] = dataList[2724],
	[401649] = dataList[2725],
	[401650] = dataList[2726],
	[401651] = dataList[2727],
	[401652] = dataList[2728],
	[401653] = dataList[2729],
	[401654] = dataList[2730],
	[401655] = dataList[2731],
	[401656] = dataList[2732],
	[401657] = dataList[2733],
	[401658] = dataList[2734],
	[401659] = dataList[2735],
	[401660] = dataList[2736],
	[401661] = dataList[2737],
	[401662] = dataList[2738],
	[401663] = dataList[2739],
	[401664] = dataList[2740],
	[401665] = dataList[2741],
	[401666] = dataList[2742],
	[401667] = dataList[2743],
	[401668] = dataList[2744],
	[401669] = dataList[2745],
	[401670] = dataList[2746],
	[401671] = dataList[2747],
	[401672] = dataList[2748],
	[401673] = dataList[2749],
	[401674] = dataList[2750],
	[401675] = dataList[2751],
	[401676] = dataList[2752],
	[401677] = dataList[2753],
	[401678] = dataList[2754],
	[401680] = dataList[2755],
	[401683] = dataList[2756],
	[401684] = dataList[2757],
	[401685] = dataList[2758],
	[401686] = dataList[2759],
	[401687] = dataList[2760],
	[401688] = dataList[2761],
	[401689] = dataList[2762],
	[401691] = dataList[2763],
	[401692] = dataList[2764],
	[401693] = dataList[2765],
	[401694] = dataList[2766],
	[401695] = dataList[2767],
	[401696] = dataList[2768],
	[401697] = dataList[2769],
	[401698] = dataList[2770],
	[401704] = dataList[2771],
	[401705] = dataList[2772],
	[401709] = dataList[2773],
	[401710] = dataList[2774],
	[401711] = dataList[2775],
	[401712] = dataList[2776],
	[401713] = dataList[2777],
	[401714] = dataList[2778],
	[401715] = dataList[2779],
	[401716] = dataList[2780],
	[401717] = dataList[2781],
	[401718] = dataList[2782],
	[401719] = dataList[2783],
	[401720] = dataList[2784],
	[401722] = dataList[2785],
	[401723] = dataList[2786],
	[401726] = dataList[2787],
	[401727] = dataList[2788],
	[401728] = dataList[2789],
	[401730] = dataList[2790],
	[401733] = dataList[2791],
	[401734] = dataList[2792],
	[401735] = dataList[2793],
	[401736] = dataList[2794],
	[401737] = dataList[2795],
	[401738] = dataList[2796],
	[401739] = dataList[2797],
	[401740] = dataList[2798],
	[401741] = dataList[2799],
	[401742] = dataList[2800],
	[401743] = dataList[2801],
	[401744] = dataList[2802],
	[401745] = dataList[2803],
	[401746] = dataList[2804],
	[401747] = dataList[2805],
	[401748] = dataList[2806],
	[401749] = dataList[2807],
	[401750] = dataList[2808],
	[401751] = dataList[2809],
	[401752] = dataList[2810],
	[401753] = dataList[2811],
	[401754] = dataList[2812],
	[401755] = dataList[2813],
	[401765] = dataList[2814],
	[401766] = dataList[2815],
	[401767] = dataList[2816],
	[401769] = dataList[2817],
	[401770] = dataList[2818],
	[401771] = dataList[2819],
	[401772] = dataList[2820],
	[401773] = dataList[2821],
	[401774] = dataList[2822],
	[401775] = dataList[2823],
	[401776] = dataList[2824],
	[401777] = dataList[2825],
	[401778] = dataList[2826],
	[401779] = dataList[2827],
	[401780] = dataList[2828],
	[401781] = dataList[2829],
	[401782] = dataList[2830],
	[401783] = dataList[2831],
	[401784] = dataList[2832],
	[401785] = dataList[2833],
	[401786] = dataList[2834],
	[401787] = dataList[2835],
	[401788] = dataList[2836],
	[401789] = dataList[2837],
	[401790] = dataList[2838],
	[401791] = dataList[2839],
	[401792] = dataList[2840],
	[401793] = dataList[2841],
	[401794] = dataList[2842],
	[401795] = dataList[2843],
	[401796] = dataList[2844],
	[401797] = dataList[2845],
	[401799] = dataList[2846],
	[401802] = dataList[2847],
	[401803] = dataList[2848],
	[401804] = dataList[2849],
	[401805] = dataList[2850],
	[401806] = dataList[2851],
	[401807] = dataList[2852],
	[401808] = dataList[2853],
	[401810] = dataList[2854],
	[401811] = dataList[2855],
	[401812] = dataList[2856],
	[401813] = dataList[2857],
	[401814] = dataList[2858],
	[401815] = dataList[2859],
	[401816] = dataList[2860],
	[401817] = dataList[2861],
	[401823] = dataList[2862],
	[401824] = dataList[2863],
	[401828] = dataList[2864],
	[401830] = dataList[2865],
	[401831] = dataList[2866],
	[401832] = dataList[2867],
	[401833] = dataList[2868],
	[401834] = dataList[2869],
	[401835] = dataList[2870],
	[401836] = dataList[2871],
	[401837] = dataList[2872],
	[401838] = dataList[2873],
	[401839] = dataList[2874],
	[401840] = dataList[2875],
	[401842] = dataList[2876],
	[401843] = dataList[2877],
	[401846] = dataList[2878],
	[401847] = dataList[2879],
	[401848] = dataList[2880],
	[401850] = dataList[2881],
	[401853] = dataList[2882],
	[401854] = dataList[2883],
	[401855] = dataList[2884],
	[401856] = dataList[2885],
	[401857] = dataList[2886],
	[401858] = dataList[2887],
	[401859] = dataList[2888],
	[401860] = dataList[2889],
	[401861] = dataList[2890],
	[401862] = dataList[2891],
	[401863] = dataList[2892],
	[401864] = dataList[2893],
	[401865] = dataList[2894],
	[401866] = dataList[2895],
	[401867] = dataList[2896],
	[401868] = dataList[2897],
	[401869] = dataList[2898],
	[401870] = dataList[2899],
	[401871] = dataList[2900],
	[401872] = dataList[2901],
	[401873] = dataList[2902],
	[401874] = dataList[2903],
	[401875] = dataList[2904],
	[401885] = dataList[2905],
	[401886] = dataList[2906],
	[401887] = dataList[2907],
	[401888] = dataList[2908],
	[401889] = dataList[2909],
	[401890] = dataList[2910],
	[401891] = dataList[2911],
	[401892] = dataList[2912],
	[401893] = dataList[2913],
	[401894] = dataList[2914],
	[401895] = dataList[2915],
	[401896] = dataList[2916],
	[401897] = dataList[2917],
	[401898] = dataList[2918],
	[401899] = dataList[2919],
	[401900] = dataList[2920],
	[401901] = dataList[2921],
	[401902] = dataList[2922],
	[401903] = dataList[2923],
	[401904] = dataList[2924],
	[401905] = dataList[2925],
	[401906] = dataList[2926],
	[401907] = dataList[2927],
	[401908] = dataList[2928],
	[401909] = dataList[2929],
	[401910] = dataList[2930],
	[401911] = dataList[2931],
	[401912] = dataList[2932],
	[401913] = dataList[2933],
	[401914] = dataList[2934],
	[401915] = dataList[2935],
	[401916] = dataList[2936],
	[401918] = dataList[2937],
	[401921] = dataList[2938],
	[401922] = dataList[2939],
	[401923] = dataList[2940],
	[401924] = dataList[2941],
	[401925] = dataList[2942],
	[401926] = dataList[2943],
	[401927] = dataList[2944],
	[401929] = dataList[2945],
	[401930] = dataList[2946],
	[401931] = dataList[2947],
	[401932] = dataList[2948],
	[401933] = dataList[2949],
	[401934] = dataList[2950],
	[401935] = dataList[2951],
	[401936] = dataList[2952],
	[401942] = dataList[2953],
	[401943] = dataList[2954],
	[401947] = dataList[2955],
	[401948] = dataList[2956],
	[401949] = dataList[2957],
	[401950] = dataList[2958],
	[401951] = dataList[2959],
	[401952] = dataList[2960],
	[401953] = dataList[2961],
	[401954] = dataList[2962],
	[401955] = dataList[2963],
	[401956] = dataList[2964],
	[401957] = dataList[2965],
	[401958] = dataList[2966],
	[401960] = dataList[2967],
	[401961] = dataList[2968],
	[401964] = dataList[2969],
	[401965] = dataList[2970],
	[401966] = dataList[2971],
	[401968] = dataList[2972],
	[401971] = dataList[2973],
	[401972] = dataList[2974],
	[401973] = dataList[2975],
	[401974] = dataList[2976],
	[401975] = dataList[2977],
	[401976] = dataList[2978],
	[401977] = dataList[2979],
	[401978] = dataList[2980],
	[401979] = dataList[2981],
	[401980] = dataList[2982],
	[401981] = dataList[2983],
	[401982] = dataList[2984],
	[401983] = dataList[2985],
	[401984] = dataList[2986],
	[401985] = dataList[2987],
	[401986] = dataList[2988],
	[401987] = dataList[2989],
	[401988] = dataList[2990],
	[401990] = dataList[2991],
	[401991] = dataList[2992],
	[401992] = dataList[2993],
	[401993] = dataList[2994],
	[401994] = dataList[2995],
	[401995] = dataList[2996],
	[402005] = dataList[2997],
	[402006] = dataList[2998],
	[402007] = dataList[2999],
	[402008] = dataList[3000],
	[402009] = dataList[3001],
	[402010] = dataList[3002],
	[402011] = dataList[3003],
	[402012] = dataList[3004],
	[402013] = dataList[3005],
	[402014] = dataList[3006],
	[402015] = dataList[3007],
	[402016] = dataList[3008],
	[402017] = dataList[3009],
	[402018] = dataList[3010],
	[402019] = dataList[3011],
	[402020] = dataList[3012],
	[402021] = dataList[3013],
	[402022] = dataList[3014],
	[402023] = dataList[3015],
	[402024] = dataList[3016],
	[402025] = dataList[3017],
	[402026] = dataList[3018],
	[402027] = dataList[3019],
	[402028] = dataList[3020],
	[402029] = dataList[3021],
	[402030] = dataList[3022],
	[402031] = dataList[3023],
	[402032] = dataList[3024],
	[402033] = dataList[3025],
	[402034] = dataList[3026],
	[402035] = dataList[3027],
	[402036] = dataList[3028],
	[402038] = dataList[3029],
	[402043] = dataList[3030],
	[402044] = dataList[3031],
	[402045] = dataList[3032],
	[402046] = dataList[3033],
	[402047] = dataList[3034],
	[402048] = dataList[3035],
	[402050] = dataList[3036],
	[402051] = dataList[3037],
	[402052] = dataList[3038],
	[402053] = dataList[3039],
	[402054] = dataList[3040],
	[402055] = dataList[3041],
	[402056] = dataList[3042],
	[402057] = dataList[3043],
	[402063] = dataList[3044],
	[402064] = dataList[3045],
	[402068] = dataList[3046],
	[402069] = dataList[3047],
	[402070] = dataList[3048],
	[402071] = dataList[3049],
	[402072] = dataList[3050],
	[402073] = dataList[3051],
	[402074] = dataList[3052],
	[402075] = dataList[3053],
	[402076] = dataList[3054],
	[402077] = dataList[3055],
	[402078] = dataList[3056],
	[402079] = dataList[3057],
	[402081] = dataList[3058],
	[402083] = dataList[3059],
	[402085] = dataList[3060],
	[402086] = dataList[3061],
	[402087] = dataList[3062],
	[402089] = dataList[3063],
	[402092] = dataList[3064],
	[402093] = dataList[3065],
	[402094] = dataList[3066],
	[402095] = dataList[3067],
	[402096] = dataList[3068],
	[402097] = dataList[3069],
	[402098] = dataList[3070],
	[402099] = dataList[3071],
	[402100] = dataList[3072],
	[402101] = dataList[3073],
	[402102] = dataList[3074],
	[402103] = dataList[3075],
	[402104] = dataList[3076],
	[402105] = dataList[3077],
	[402106] = dataList[3078],
	[402107] = dataList[3079],
	[402108] = dataList[3080],
	[402109] = dataList[3081],
	[402110] = dataList[3082],
	[402111] = dataList[3083],
	[402112] = dataList[3084],
	[402113] = dataList[3085],
	[402114] = dataList[3086],
	[402124] = dataList[3087],
	[402125] = dataList[3088],
	[402126] = dataList[3089],
	[402127] = dataList[3090],
	[402128] = dataList[3091],
	[402129] = dataList[3092],
	[402130] = dataList[3093],
	[402131] = dataList[3094],
	[402132] = dataList[3095],
	[402133] = dataList[3096],
	[402134] = dataList[3097],
	[402135] = dataList[3098],
	[402136] = dataList[3099],
	[402137] = dataList[3100],
	[402138] = dataList[3101],
	[402139] = dataList[3102],
	[402140] = dataList[3103],
	[402141] = dataList[3104],
	[402142] = dataList[3105],
	[402143] = dataList[3106],
	[402144] = dataList[3107],
	[402145] = dataList[3108],
	[402146] = dataList[3109],
	[402147] = dataList[3110],
	[402148] = dataList[3111],
	[402149] = dataList[3112],
	[402150] = dataList[3113],
	[402151] = dataList[3114],
	[402152] = dataList[3115],
	[402153] = dataList[3116],
	[402154] = dataList[3117],
	[402155] = dataList[3118],
	[402157] = dataList[3119],
	[402160] = dataList[3120],
	[402161] = dataList[3121],
	[402162] = dataList[3122],
	[402163] = dataList[3123],
	[402164] = dataList[3124],
	[402165] = dataList[3125],
	[402166] = dataList[3126],
	[402168] = dataList[3127],
	[402169] = dataList[3128],
	[402170] = dataList[3129],
	[402171] = dataList[3130],
	[402172] = dataList[3131],
	[402173] = dataList[3132],
	[402174] = dataList[3133],
	[402175] = dataList[3134],
	[402181] = dataList[3135],
	[402182] = dataList[3136],
	[402186] = dataList[3137],
	[402187] = dataList[3138],
	[402188] = dataList[3139],
	[402189] = dataList[3140],
	[402190] = dataList[3141],
	[402191] = dataList[3142],
	[402192] = dataList[3143],
	[402193] = dataList[3144],
	[402194] = dataList[3145],
	[402195] = dataList[3146],
	[402196] = dataList[3147],
	[402197] = dataList[3148],
	[402199] = dataList[3149],
	[402200] = dataList[3150],
	[402203] = dataList[3151],
	[402204] = dataList[3152],
	[402205] = dataList[3153],
	[402207] = dataList[3154],
	[402210] = dataList[3155],
	[402211] = dataList[3156],
	[402212] = dataList[3157],
	[402213] = dataList[3158],
	[402214] = dataList[3159],
	[402215] = dataList[3160],
	[402216] = dataList[3161],
	[402217] = dataList[3162],
	[402218] = dataList[3163],
	[402219] = dataList[3164],
	[402220] = dataList[3165],
	[402221] = dataList[3166],
	[402222] = dataList[3167],
	[402223] = dataList[3168],
	[402224] = dataList[3169],
	[402225] = dataList[3170],
	[402226] = dataList[3171],
	[402227] = dataList[3172],
	[402228] = dataList[3173],
	[402229] = dataList[3174],
	[402230] = dataList[3175],
	[402231] = dataList[3176],
	[402232] = dataList[3177],
	[402233] = dataList[3178],
	[402234] = dataList[3179],
	[402235] = dataList[3180],
	[402236] = dataList[3181],
	[402237] = dataList[3182],
	[402238] = dataList[3183],
	[402239] = dataList[3184],
	[402240] = dataList[3185],
	[402241] = dataList[3186],
	[402242] = dataList[3187],
	[402243] = dataList[3188],
	[402244] = dataList[3189],
	[402245] = dataList[3190],
	[402246] = dataList[3191],
	[402247] = dataList[3192],
	[402248] = dataList[3193],
	[402249] = dataList[3194],
	[402250] = dataList[3195],
	[402251] = dataList[3196],
	[402254] = dataList[3197],
	[402255] = dataList[3198],
	[402256] = dataList[3199],
	[402257] = dataList[3200],
	[402258] = dataList[3201],
	[402259] = dataList[3202],
	[402260] = dataList[3203],
	[402270] = dataList[3204],
	[402271] = dataList[3205],
	[402272] = dataList[3206],
	[402273] = dataList[3207],
	[402274] = dataList[3208],
	[402275] = dataList[3209],
	[402276] = dataList[3210],
	[402277] = dataList[3211],
	[402278] = dataList[3212],
	[402279] = dataList[3213],
	[402280] = dataList[3214],
	[402281] = dataList[3215],
	[402282] = dataList[3216],
	[402283] = dataList[3217],
	[402284] = dataList[3218],
	[402285] = dataList[3219],
	[402286] = dataList[3220],
	[402287] = dataList[3221],
	[402288] = dataList[3222],
	[402289] = dataList[3223],
	[402290] = dataList[3224],
	[402291] = dataList[3225],
	[402292] = dataList[3226],
	[402293] = dataList[3227],
	[402294] = dataList[3228],
	[402295] = dataList[3229],
	[402296] = dataList[3230],
	[402297] = dataList[3231],
	[402298] = dataList[3232],
	[402299] = dataList[3233],
	[402300] = dataList[3234],
	[402301] = dataList[3235],
	[402302] = dataList[3236],
	[402303] = dataList[3237],
	[402305] = dataList[3238],
	[402308] = dataList[3239],
	[402309] = dataList[3240],
	[402310] = dataList[3241],
	[402311] = dataList[3242],
	[402312] = dataList[3243],
	[402313] = dataList[3244],
	[402314] = dataList[3245],
	[402316] = dataList[3246],
	[402317] = dataList[3247],
	[402318] = dataList[3248],
	[402319] = dataList[3249],
	[402320] = dataList[3250],
	[402321] = dataList[3251],
	[402322] = dataList[3252],
	[402323] = dataList[3253],
	[402334] = dataList[3254],
	[402335] = dataList[3255],
	[402336] = dataList[3256],
	[402337] = dataList[3257],
	[402338] = dataList[3258],
	[402339] = dataList[3259],
	[402340] = dataList[3260],
	[402341] = dataList[3261],
	[402342] = dataList[3262],
	[402343] = dataList[3263],
	[402344] = dataList[3264],
	[402345] = dataList[3265],
	[402347] = dataList[3266],
	[402348] = dataList[3267],
	[402351] = dataList[3268],
	[402352] = dataList[3269],
	[402353] = dataList[3270],
	[402355] = dataList[3271],
	[402358] = dataList[3272],
	[402359] = dataList[3273],
	[402360] = dataList[3274],
	[402361] = dataList[3275],
	[402362] = dataList[3276],
	[402363] = dataList[3277],
	[402364] = dataList[3278],
	[402365] = dataList[3279],
	[402366] = dataList[3280],
	[402367] = dataList[3281],
	[402368] = dataList[3282],
	[402369] = dataList[3283],
	[402370] = dataList[3284],
	[402371] = dataList[3285],
	[402372] = dataList[3286],
	[402373] = dataList[3287],
	[402374] = dataList[3288],
	[402375] = dataList[3289],
	[402376] = dataList[3290],
	[402377] = dataList[3291],
	[402378] = dataList[3292],
	[402379] = dataList[3293],
	[402380] = dataList[3294],
	[402381] = dataList[3295],
	[402382] = dataList[3296],
	[402383] = dataList[3297],
	[402384] = dataList[3298],
	[402385] = dataList[3299],
	[402386] = dataList[3300],
	[402387] = dataList[3301],
	[402388] = dataList[3302],
	[402389] = dataList[3303],
	[402390] = dataList[3304],
	[402391] = dataList[3305],
	[402392] = dataList[3306],
	[402393] = dataList[3307],
	[402394] = dataList[3308],
	[402395] = dataList[3309],
	[402396] = dataList[3310],
	[402397] = dataList[3311],
	[402398] = dataList[3312],
	[402399] = dataList[3313],
	[402400] = dataList[3314],
	[402401] = dataList[3315],
	[402402] = dataList[3316],
	[402403] = dataList[3317],
	[402413] = dataList[3318],
	[402414] = dataList[3319],
	[402415] = dataList[3320],
	[402416] = dataList[3321],
	[402417] = dataList[3322],
	[402418] = dataList[3323],
	[402419] = dataList[3324],
	[402420] = dataList[3325],
	[402421] = dataList[3326],
	[402422] = dataList[3327],
	[402423] = dataList[3328],
	[402424] = dataList[3329],
	[402425] = dataList[3330],
	[402426] = dataList[3331],
	[402427] = dataList[3332],
	[402428] = dataList[3333],
	[402429] = dataList[3334],
	[402430] = dataList[3335],
	[402431] = dataList[3336],
	[402432] = dataList[3337],
	[402433] = dataList[3338],
	[402434] = dataList[3339],
	[402435] = dataList[3340],
	[402436] = dataList[3341],
	[402437] = dataList[3342],
	[402438] = dataList[3343],
	[402439] = dataList[3344],
	[402440] = dataList[3345],
	[402441] = dataList[3346],
	[402442] = dataList[3347],
	[402443] = dataList[3348],
	[402444] = dataList[3349],
	[402446] = dataList[3350],
	[402449] = dataList[3351],
	[402450] = dataList[3352],
	[402451] = dataList[3353],
	[402452] = dataList[3354],
	[402453] = dataList[3355],
	[402454] = dataList[3356],
	[402455] = dataList[3357],
	[402457] = dataList[3358],
	[402458] = dataList[3359],
	[402459] = dataList[3360],
	[402460] = dataList[3361],
	[402461] = dataList[3362],
	[402462] = dataList[3363],
	[402463] = dataList[3364],
	[402464] = dataList[3365],
	[402470] = dataList[3366],
	[402471] = dataList[3367],
	[402475] = dataList[3368],
	[402476] = dataList[3369],
	[402477] = dataList[3370],
	[402478] = dataList[3371],
	[402479] = dataList[3372],
	[402480] = dataList[3373],
	[402481] = dataList[3374],
	[402482] = dataList[3375],
	[402483] = dataList[3376],
	[402484] = dataList[3377],
	[402485] = dataList[3378],
	[402486] = dataList[3379],
	[402488] = dataList[3380],
	[402490] = dataList[3381],
	[402492] = dataList[3382],
	[402493] = dataList[3383],
	[402494] = dataList[3384],
	[402496] = dataList[3385],
	[402499] = dataList[3386],
	[402500] = dataList[3387],
	[402501] = dataList[3388],
	[402502] = dataList[3389],
	[402503] = dataList[3390],
	[402507] = dataList[3391],
	[402508] = dataList[3392],
	[402509] = dataList[3393],
	[402510] = dataList[3394],
	[402511] = dataList[3395],
	[402512] = dataList[3396],
	[402513] = dataList[3397],
	[402514] = dataList[3398],
	[402515] = dataList[3399],
	[402516] = dataList[3400],
	[402517] = dataList[3401],
	[402518] = dataList[3402],
	[402519] = dataList[3403],
	[402520] = dataList[3404],
	[402530] = dataList[3405],
	[402531] = dataList[3406],
	[402532] = dataList[3407],
	[402533] = dataList[3408],
	[402534] = dataList[3409],
	[402535] = dataList[3410],
	[402536] = dataList[3411],
	[402537] = dataList[3412],
	[402538] = dataList[3413],
	[402539] = dataList[3414],
	[402540] = dataList[3415],
	[402541] = dataList[3416],
	[402542] = dataList[3417],
	[402543] = dataList[3418],
	[402544] = dataList[3419],
	[402545] = dataList[3420],
	[402546] = dataList[3421],
	[402547] = dataList[3422],
	[402548] = dataList[3423],
	[402549] = dataList[3424],
	[402550] = dataList[3425],
	[402552] = dataList[3426],
	[402553] = dataList[3427],
	[402554] = dataList[3428],
	[402555] = dataList[3429],
	[402556] = dataList[3430],
	[402557] = dataList[3431],
	[402558] = dataList[3432],
	[402559] = dataList[3433],
	[402560] = dataList[3434],
	[402561] = dataList[3435],
	[402562] = dataList[3436],
	[402564] = dataList[3437],
	[402567] = dataList[3438],
	[402568] = dataList[3439],
	[402569] = dataList[3440],
	[402570] = dataList[3441],
	[402571] = dataList[3442],
	[402572] = dataList[3443],
	[402574] = dataList[3444],
	[402575] = dataList[3445],
	[402576] = dataList[3446],
	[402577] = dataList[3447],
	[402578] = dataList[3448],
	[402579] = dataList[3449],
	[402580] = dataList[3450],
	[402581] = dataList[3451],
	[402587] = dataList[3452],
	[402588] = dataList[3453],
	[402592] = dataList[3454],
	[402593] = dataList[3455],
	[402594] = dataList[3456],
	[402595] = dataList[3457],
	[402596] = dataList[3458],
	[402597] = dataList[3459],
	[402598] = dataList[3460],
	[402599] = dataList[3461],
	[402600] = dataList[3462],
	[402601] = dataList[3463],
	[402602] = dataList[3464],
	[402603] = dataList[3465],
	[402605] = dataList[3466],
	[402606] = dataList[3467],
	[402609] = dataList[3468],
	[402610] = dataList[3469],
	[402612] = dataList[3470],
	[402614] = dataList[3471],
	[402617] = dataList[3472],
	[402618] = dataList[3473],
	[402619] = dataList[3474],
	[402620] = dataList[3475],
	[402621] = dataList[3476],
	[402622] = dataList[3477],
	[402623] = dataList[3478],
	[402624] = dataList[3479],
	[402625] = dataList[3480],
	[402626] = dataList[3481],
	[402627] = dataList[3482],
	[402628] = dataList[3483],
	[402629] = dataList[3484],
	[402630] = dataList[3485],
	[402631] = dataList[3486],
	[402632] = dataList[3487],
	[402633] = dataList[3488],
	[402634] = dataList[3489],
	[402635] = dataList[3490],
	[402636] = dataList[3491],
	[402637] = dataList[3492],
	[402638] = dataList[3493],
	[402639] = dataList[3494],
	[402649] = dataList[3495],
	[402650] = dataList[3496],
	[402651] = dataList[3497],
	[402652] = dataList[3498],
	[402653] = dataList[3499],
	[402654] = dataList[3500],
	[402655] = dataList[3501],
	[402656] = dataList[3502],
	[402657] = dataList[3503],
	[402658] = dataList[3504],
	[402659] = dataList[3505],
	[402660] = dataList[3506],
	[402661] = dataList[3507],
	[402662] = dataList[3508],
	[402663] = dataList[3509],
	[402664] = dataList[3510],
	[402665] = dataList[3511],
	[402666] = dataList[3512],
	[402667] = dataList[3513],
	[402668] = dataList[3514],
	[402669] = dataList[3515],
	[402670] = dataList[3516],
	[402671] = dataList[3517],
	[402672] = dataList[3518],
	[402673] = dataList[3519],
	[402674] = dataList[3520],
	[402675] = dataList[3521],
	[402676] = dataList[3522],
	[402677] = dataList[3523],
	[402678] = dataList[3524],
	[402679] = dataList[3525],
	[402680] = dataList[3526],
	[402682] = dataList[3527],
	[402685] = dataList[3528],
	[402686] = dataList[3529],
	[402687] = dataList[3530],
	[402688] = dataList[3531],
	[402689] = dataList[3532],
	[402690] = dataList[3533],
	[402691] = dataList[3534],
	[402693] = dataList[3535],
	[402694] = dataList[3536],
	[402695] = dataList[3537],
	[402696] = dataList[3538],
	[402697] = dataList[3539],
	[402698] = dataList[3540],
	[402699] = dataList[3541],
	[402700] = dataList[3542],
	[402706] = dataList[3543],
	[402707] = dataList[3544],
	[402711] = dataList[3545],
	[402712] = dataList[3546],
	[402713] = dataList[3547],
	[402714] = dataList[3548],
	[402715] = dataList[3549],
	[402716] = dataList[3550],
	[402717] = dataList[3551],
	[402718] = dataList[3552],
	[402719] = dataList[3553],
	[402720] = dataList[3554],
	[402721] = dataList[3555],
	[402722] = dataList[3556],
	[402724] = dataList[3557],
	[402725] = dataList[3558],
	[402728] = dataList[3559],
	[402729] = dataList[3560],
	[402730] = dataList[3561],
	[402732] = dataList[3562],
	[402735] = dataList[3563],
	[402736] = dataList[3564],
	[402737] = dataList[3565],
	[402738] = dataList[3566],
	[402739] = dataList[3567],
	[402740] = dataList[3568],
	[402741] = dataList[3569],
	[402742] = dataList[3570],
	[402743] = dataList[3571],
	[402744] = dataList[3572],
	[402745] = dataList[3573],
	[402746] = dataList[3574],
	[402747] = dataList[3575],
	[402748] = dataList[3576],
	[402749] = dataList[3577],
	[402750] = dataList[3578],
	[402751] = dataList[3579],
	[402752] = dataList[3580],
	[402753] = dataList[3581],
	[402754] = dataList[3582],
	[402755] = dataList[3583],
	[402756] = dataList[3584],
	[402757] = dataList[3585],
	[402758] = dataList[3586],
	[402768] = dataList[3587],
	[402769] = dataList[3588],
	[402770] = dataList[3589],
	[402771] = dataList[3590],
	[402772] = dataList[3591],
	[402773] = dataList[3592],
	[402774] = dataList[3593],
	[402775] = dataList[3594],
	[402776] = dataList[3595],
	[402777] = dataList[3596],
	[402778] = dataList[3597],
	[402779] = dataList[3598],
	[402780] = dataList[3599],
	[402781] = dataList[3600],
	[402782] = dataList[3601],
	[402783] = dataList[3602],
	[402784] = dataList[3603],
	[402785] = dataList[3604],
	[402786] = dataList[3605],
	[402787] = dataList[3606],
	[402788] = dataList[3607],
	[402789] = dataList[3608],
	[402790] = dataList[3609],
	[402791] = dataList[3610],
	[402792] = dataList[3611],
	[402793] = dataList[3612],
	[402794] = dataList[3613],
	[402795] = dataList[3614],
	[402796] = dataList[3615],
	[402797] = dataList[3616],
	[402798] = dataList[3617],
	[402799] = dataList[3618],
	[402801] = dataList[3619],
	[402804] = dataList[3620],
	[402805] = dataList[3621],
	[402806] = dataList[3622],
	[402807] = dataList[3623],
	[402808] = dataList[3624],
	[402809] = dataList[3625],
	[402810] = dataList[3626],
	[402812] = dataList[3627],
	[402813] = dataList[3628],
	[402814] = dataList[3629],
	[402815] = dataList[3630],
	[402816] = dataList[3631],
	[402817] = dataList[3632],
	[402818] = dataList[3633],
	[402819] = dataList[3634],
	[402820] = dataList[3635],
	[402821] = dataList[3636],
	[402830] = dataList[3637],
	[402831] = dataList[3638],
	[402832] = dataList[3639],
	[402833] = dataList[3640],
	[402834] = dataList[3641],
	[402835] = dataList[3642],
	[402836] = dataList[3643],
	[402837] = dataList[3644],
	[402838] = dataList[3645],
	[402839] = dataList[3646],
	[402840] = dataList[3647],
	[402841] = dataList[3648],
	[402843] = dataList[3649],
	[402844] = dataList[3650],
	[402847] = dataList[3651],
	[402848] = dataList[3652],
	[402849] = dataList[3653],
	[402851] = dataList[3654],
	[402854] = dataList[3655],
	[402855] = dataList[3656],
	[402856] = dataList[3657],
	[402859] = dataList[3658],
	[402860] = dataList[3659],
	[402861] = dataList[3660],
	[402862] = dataList[3661],
	[402863] = dataList[3662],
	[402864] = dataList[3663],
	[402865] = dataList[3664],
	[402866] = dataList[3665],
	[402867] = dataList[3666],
	[402868] = dataList[3667],
	[402869] = dataList[3668],
	[402870] = dataList[3669],
	[402871] = dataList[3670],
	[402872] = dataList[3671],
	[402873] = dataList[3672],
	[402874] = dataList[3673],
	[402875] = dataList[3674],
	[402876] = dataList[3675],
	[402877] = dataList[3676],
	[402878] = dataList[3677],
	[402888] = dataList[3678],
	[402889] = dataList[3679],
	[402890] = dataList[3680],
	[402891] = dataList[3681],
	[402892] = dataList[3682],
	[402893] = dataList[3683],
	[402894] = dataList[3684],
	[402895] = dataList[3685],
	[402896] = dataList[3686],
	[402897] = dataList[3687],
	[402898] = dataList[3688],
	[402899] = dataList[3689],
	[402900] = dataList[3690],
	[402901] = dataList[3691],
	[402902] = dataList[3692],
	[402903] = dataList[3693],
	[402904] = dataList[3694],
	[402905] = dataList[3695],
	[402906] = dataList[3696],
	[402907] = dataList[3697],
	[402908] = dataList[3698],
	[402909] = dataList[3699],
	[402910] = dataList[3700],
	[402911] = dataList[3701],
	[402912] = dataList[3702],
	[402913] = dataList[3703],
	[402914] = dataList[3704],
	[402915] = dataList[3705],
	[402916] = dataList[3706],
	[402917] = dataList[3707],
	[402918] = dataList[3708],
	[402919] = dataList[3709],
	[402921] = dataList[3710],
	[402924] = dataList[3711],
	[402925] = dataList[3712],
	[402926] = dataList[3713],
	[402927] = dataList[3714],
	[402928] = dataList[3715],
	[402929] = dataList[3716],
	[402930] = dataList[3717],
	[402932] = dataList[3718],
	[402933] = dataList[3719],
	[402934] = dataList[3720],
	[402935] = dataList[3721],
	[402936] = dataList[3722],
	[402937] = dataList[3723],
	[402938] = dataList[3724],
	[402939] = dataList[3725],
	[402940] = dataList[3726],
	[402941] = dataList[3727],
	[402950] = dataList[3728],
	[402951] = dataList[3729],
	[402952] = dataList[3730],
	[402953] = dataList[3731],
	[402954] = dataList[3732],
	[402955] = dataList[3733],
	[402956] = dataList[3734],
	[402957] = dataList[3735],
	[402958] = dataList[3736],
	[402959] = dataList[3737],
	[402960] = dataList[3738],
	[402961] = dataList[3739],
	[402963] = dataList[3740],
	[402964] = dataList[3741],
	[402967] = dataList[3742],
	[402968] = dataList[3743],
	[402969] = dataList[3744],
	[402971] = dataList[3745],
	[402974] = dataList[3746],
	[402975] = dataList[3747],
	[402976] = dataList[3748],
	[402979] = dataList[3749],
	[402980] = dataList[3750],
	[402981] = dataList[3751],
	[402982] = dataList[3752],
	[402983] = dataList[3753],
	[402984] = dataList[3754],
	[402985] = dataList[3755],
	[402986] = dataList[3756],
	[402987] = dataList[3757],
	[402988] = dataList[3758],
	[402989] = dataList[3759],
	[402990] = dataList[3760],
	[402991] = dataList[3761],
	[402992] = dataList[3762],
	[402993] = dataList[3763],
	[402994] = dataList[3764],
	[402995] = dataList[3765],
	[402996] = dataList[3766],
	[402997] = dataList[3767],
	[403007] = dataList[3768],
	[403008] = dataList[3769],
	[403009] = dataList[3770],
	[403010] = dataList[3771],
	[403011] = dataList[3772],
	[403012] = dataList[3773],
	[403013] = dataList[3774],
	[403014] = dataList[3775],
	[403015] = dataList[3776],
	[403016] = dataList[3777],
	[403017] = dataList[3778],
	[403018] = dataList[3779],
	[403019] = dataList[3780],
	[403020] = dataList[3781],
	[403021] = dataList[3782],
	[403022] = dataList[3783],
	[403023] = dataList[3784],
	[403024] = dataList[3785],
	[403025] = dataList[3786],
	[403026] = dataList[3787],
	[403027] = dataList[3788],
	[403028] = dataList[3789],
	[403029] = dataList[3790],
	[403030] = dataList[3791],
	[403031] = dataList[3792],
	[403032] = dataList[3793],
	[403033] = dataList[3794],
	[403034] = dataList[3795],
	[403035] = dataList[3796],
	[403036] = dataList[3797],
	[403037] = dataList[3798],
	[403038] = dataList[3799],
	[403040] = dataList[3800],
	[403043] = dataList[3801],
	[403044] = dataList[3802],
	[403045] = dataList[3803],
	[403046] = dataList[3804],
	[403047] = dataList[3805],
	[403048] = dataList[3806],
	[403050] = dataList[3807],
	[403051] = dataList[3808],
	[403052] = dataList[3809],
	[403053] = dataList[3810],
	[403054] = dataList[3811],
	[403055] = dataList[3812],
	[403056] = dataList[3813],
	[403057] = dataList[3814],
	[403058] = dataList[3815],
	[403059] = dataList[3816],
	[403068] = dataList[3817],
	[403069] = dataList[3818],
	[403070] = dataList[3819],
	[403071] = dataList[3820],
	[403072] = dataList[3821],
	[403073] = dataList[3822],
	[403074] = dataList[3823],
	[403075] = dataList[3824],
	[403076] = dataList[3825],
	[403077] = dataList[3826],
	[403078] = dataList[3827],
	[403079] = dataList[3828],
	[403081] = dataList[3829],
	[403082] = dataList[3830],
	[403085] = dataList[3831],
	[403086] = dataList[3832],
	[403087] = dataList[3833],
	[403089] = dataList[3834],
	[403092] = dataList[3835],
	[403093] = dataList[3836],
	[403094] = dataList[3837],
	[521500] = dataList[3838],
	[521501] = dataList[3839],
	[521502] = dataList[3840],
	[521503] = dataList[3841],
	[521504] = dataList[3842],
	[521505] = dataList[3843],
	[521506] = dataList[3844],
	[521507] = dataList[3845],
	[521508] = dataList[3846],
	[521509] = dataList[3847],
	[521510] = dataList[3848],
	[521511] = dataList[3849],
	[521512] = dataList[3850],
	[521513] = dataList[3851],
	[521514] = dataList[3852],
	[521515] = dataList[3853],
	[521516] = dataList[3854],
	[521517] = dataList[3855],
	[521518] = dataList[3856],
	[521519] = dataList[3857],
	[521520] = dataList[3858],
	[521521] = dataList[3859],
	[521522] = dataList[3860],
	[521523] = dataList[3861],
	[521524] = dataList[3862],
	[521525] = dataList[3863],
	[521526] = dataList[3864],
	[521527] = dataList[3865],
	[522500] = dataList[3866],
	[522501] = dataList[3867],
	[522502] = dataList[3868],
	[522503] = dataList[3869],
	[522504] = dataList[3870],
	[522505] = dataList[3871],
	[522506] = dataList[3872],
	[522507] = dataList[3873],
	[522508] = dataList[3874],
	[522509] = dataList[3875],
	[522510] = dataList[3876],
	[522511] = dataList[3877],
	[522512] = dataList[3878],
	[522513] = dataList[3879],
	[522514] = dataList[3880],
	[522515] = dataList[3881],
	[522516] = dataList[3882],
	[522517] = dataList[3883],
	[522518] = dataList[3884],
	[522519] = dataList[3885],
	[522520] = dataList[3886],
	[522521] = dataList[3887],
	[522522] = dataList[3888],
	[522523] = dataList[3889],
	[522524] = dataList[3890],
	[522525] = dataList[3891],
	[522526] = dataList[3892],
	[522527] = dataList[3893],
	[522528] = dataList[3894],
	[522529] = dataList[3895],
	[522530] = dataList[3896],
	[522531] = dataList[3897],
	[522532] = dataList[3898],
	[522533] = dataList[3899],
	[523500] = dataList[3900],
	[523501] = dataList[3901],
	[523502] = dataList[3902],
	[523503] = dataList[3903],
	[523504] = dataList[3904],
	[523505] = dataList[3905],
	[523506] = dataList[3906],
	[523507] = dataList[3907],
	[523508] = dataList[3908],
	[523509] = dataList[3909],
	[523510] = dataList[3910],
	[501000] = dataList[3911],
	[501001] = dataList[3912],
	[501002] = dataList[3913],
	[501003] = dataList[3914],
	[501004] = dataList[3915],
	[501005] = dataList[3916],
	[501006] = dataList[3917],
	[501007] = dataList[3918],
	[501008] = dataList[3919],
	[501009] = dataList[3920],
	[501010] = dataList[3921],
	[501011] = dataList[3922],
	[501012] = dataList[3923],
	[501013] = dataList[3924],
	[501014] = dataList[3925],
	[501015] = dataList[3926],
	[501016] = dataList[3927],
	[501017] = dataList[3928],
	[501018] = dataList[3929],
	[501019] = dataList[3930],
	[501020] = dataList[3931],
	[501021] = dataList[3932],
	[501022] = dataList[3933],
	[501023] = dataList[3934],
	[501024] = dataList[3935],
	[501025] = dataList[3936],
	[501026] = dataList[3937],
	[501027] = dataList[3938],
	[501028] = dataList[3939],
	[501029] = dataList[3940],
	[501030] = dataList[3941],
	[501031] = dataList[3942],
	[501032] = dataList[3943],
	[501033] = dataList[3944],
	[501034] = dataList[3945],
	[501035] = dataList[3946],
	[501036] = dataList[3947],
	[501037] = dataList[3948],
	[501038] = dataList[3949],
	[501039] = dataList[3950],
	[501040] = dataList[3951],
	[501041] = dataList[3952],
	[501042] = dataList[3953],
	[501043] = dataList[3954],
	[501044] = dataList[3955],
	[501045] = dataList[3956],
	[501046] = dataList[3957],
	[501047] = dataList[3958],
	[501048] = dataList[3959],
	[501049] = dataList[3960],
	[501050] = dataList[3961],
	[502000] = dataList[3962],
	[502001] = dataList[3963],
	[502002] = dataList[3964],
	[502003] = dataList[3965],
	[502004] = dataList[3966],
	[502005] = dataList[3967],
	[502006] = dataList[3968],
	[502007] = dataList[3969],
	[502008] = dataList[3970],
	[502009] = dataList[3971],
	[502010] = dataList[3972],
	[502011] = dataList[3973],
	[502012] = dataList[3974],
	[502013] = dataList[3975],
	[502014] = dataList[3976],
	[502015] = dataList[3977],
	[502016] = dataList[3978],
	[502017] = dataList[3979],
	[502018] = dataList[3980],
	[502019] = dataList[3981],
	[502020] = dataList[3982],
	[502021] = dataList[3983],
	[502022] = dataList[3984],
	[502023] = dataList[3985],
	[502024] = dataList[3986],
	[502025] = dataList[3987],
	[502026] = dataList[3988],
	[502027] = dataList[3989],
	[502028] = dataList[3990],
	[502029] = dataList[3991],
	[502030] = dataList[3992],
	[502031] = dataList[3993],
	[502032] = dataList[3994],
	[502033] = dataList[3995],
	[502034] = dataList[3996],
	[502035] = dataList[3997],
	[502036] = dataList[3998],
	[502037] = dataList[3999],
	[503000] = dataList[4000],
	[503001] = dataList[4001],
	[503002] = dataList[4002],
	[503003] = dataList[4003],
	[503004] = dataList[4004],
	[503005] = dataList[4005],
	[503006] = dataList[4006],
	[503007] = dataList[4007],
	[503008] = dataList[4008],
	[503009] = dataList[4009],
	[503010] = dataList[4010],
	[503011] = dataList[4011],
	[504000] = dataList[4012],
	[504001] = dataList[4013],
	[504002] = dataList[4014],
	[504003] = dataList[4015],
	[504004] = dataList[4016],
	[504005] = dataList[4017],
	[504006] = dataList[4018],
	[504007] = dataList[4019],
	[504008] = dataList[4020],
	[504009] = dataList[4021],
	[504010] = dataList[4022],
	[504011] = dataList[4023],
	[504012] = dataList[4024],
	[504013] = dataList[4025],
	[504014] = dataList[4026],
	[504015] = dataList[4027],
	[504016] = dataList[4028],
	[504017] = dataList[4029],
	[504018] = dataList[4030],
	[504019] = dataList[4031],
	[504020] = dataList[4032],
	[504021] = dataList[4033],
	[504022] = dataList[4034],
	[504023] = dataList[4035],
	[504024] = dataList[4036],
	[504025] = dataList[4037],
	[504026] = dataList[4038],
	[504027] = dataList[4039],
	[504028] = dataList[4040],
	[504029] = dataList[4041],
	[504030] = dataList[4042],
	[504031] = dataList[4043],
	[504032] = dataList[4044],
	[504033] = dataList[4045],
	[504034] = dataList[4046],
	[504035] = dataList[4047],
	[504036] = dataList[4048],
	[505000] = dataList[4049],
	[505001] = dataList[4050],
	[505002] = dataList[4051],
	[505003] = dataList[4052],
	[505004] = dataList[4053],
	[505005] = dataList[4054],
	[505006] = dataList[4055],
	[505007] = dataList[4056],
	[505008] = dataList[4057],
	[505009] = dataList[4058],
	[505010] = dataList[4059],
	[505011] = dataList[4060],
	[505012] = dataList[4061],
	[505013] = dataList[4062],
	[505014] = dataList[4063],
	[505015] = dataList[4064],
	[505016] = dataList[4065],
	[505017] = dataList[4066],
	[505018] = dataList[4067],
	[505019] = dataList[4068],
	[505020] = dataList[4069],
	[505021] = dataList[4070],
	[505022] = dataList[4071],
	[505023] = dataList[4072],
	[505024] = dataList[4073],
	[505025] = dataList[4074],
	[505026] = dataList[4075],
	[505027] = dataList[4076],
	[505028] = dataList[4077],
	[505029] = dataList[4078],
	[505030] = dataList[4079],
	[505031] = dataList[4080],
	[505032] = dataList[4081],
	[505033] = dataList[4082],
	[505034] = dataList[4083],
	[505035] = dataList[4084],
	[505036] = dataList[4085],
	[505037] = dataList[4086],
	[505038] = dataList[4087],
	[505039] = dataList[4088],
	[505040] = dataList[4089],
	[505041] = dataList[4090],
	[505042] = dataList[4091],
	[505043] = dataList[4092],
	[505044] = dataList[4093],
	[505045] = dataList[4094],
	[505046] = dataList[4095],
	[505047] = dataList[4096],
	[505048] = dataList[4097],
	[505049] = dataList[4098],
	[505050] = dataList[4099],
	[505051] = dataList[4100],
	[505052] = dataList[4101],
	[506000] = dataList[4102],
	[506001] = dataList[4103],
	[506002] = dataList[4104],
	[506003] = dataList[4105],
	[506004] = dataList[4106],
	[506005] = dataList[4107],
	[506006] = dataList[4108],
	[506007] = dataList[4109],
	[506008] = dataList[4110],
	[506009] = dataList[4111],
	[506010] = dataList[4112],
	[506011] = dataList[4113],
	[506012] = dataList[4114],
	[506013] = dataList[4115],
	[506014] = dataList[4116],
	[506015] = dataList[4117],
	[506016] = dataList[4118],
	[506017] = dataList[4119],
	[506018] = dataList[4120],
	[506019] = dataList[4121],
	[506020] = dataList[4122],
	[506021] = dataList[4123],
	[506022] = dataList[4124],
	[506023] = dataList[4125],
	[506024] = dataList[4126],
	[506025] = dataList[4127],
	[506026] = dataList[4128],
	[506027] = dataList[4129],
	[506028] = dataList[4130],
	[506029] = dataList[4131],
	[506030] = dataList[4132],
	[506031] = dataList[4133],
	[507000] = dataList[4134],
	[507001] = dataList[4135],
	[507002] = dataList[4136],
	[507003] = dataList[4137],
	[507004] = dataList[4138],
	[507005] = dataList[4139],
	[507006] = dataList[4140],
	[507007] = dataList[4141],
	[507008] = dataList[4142],
	[507009] = dataList[4143],
	[507010] = dataList[4144],
	[507011] = dataList[4145],
	[507012] = dataList[4146],
	[507013] = dataList[4147],
	[507014] = dataList[4148],
	[507015] = dataList[4149],
	[508000] = dataList[4150],
	[508001] = dataList[4151],
	[508002] = dataList[4152],
	[508003] = dataList[4153],
	[508004] = dataList[4154],
	[508005] = dataList[4155],
	[508006] = dataList[4156],
	[508007] = dataList[4157],
	[508008] = dataList[4158],
	[508009] = dataList[4159],
	[508010] = dataList[4160],
	[508011] = dataList[4161],
	[508012] = dataList[4162],
	[508013] = dataList[4163],
	[508014] = dataList[4164],
	[508015] = dataList[4165],
	[508016] = dataList[4166],
	[508017] = dataList[4167],
	[508018] = dataList[4168],
	[508019] = dataList[4169],
	[508020] = dataList[4170],
	[508021] = dataList[4171],
	[508022] = dataList[4172],
	[508023] = dataList[4173],
	[544000] = dataList[4174],
	[544001] = dataList[4175],
	[544002] = dataList[4176],
	[544003] = dataList[4177],
	[544004] = dataList[4178],
	[544005] = dataList[4179],
	[544006] = dataList[4180],
	[544007] = dataList[4181],
	[544008] = dataList[4182],
	[544009] = dataList[4183],
	[544010] = dataList[4184],
	[544011] = dataList[4185],
	[544012] = dataList[4186],
	[544013] = dataList[4187],
	[544014] = dataList[4188],
	[544015] = dataList[4189],
	[544016] = dataList[4190],
	[544017] = dataList[4191],
	[544018] = dataList[4192],
	[544019] = dataList[4193],
	[544020] = dataList[4194],
	[544021] = dataList[4195],
	[544022] = dataList[4196],
	[544023] = dataList[4197],
	[544024] = dataList[4198],
	[544025] = dataList[4199],
	[544026] = dataList[4200],
	[544027] = dataList[4201],
	[544028] = dataList[4202],
	[544029] = dataList[4203],
	[544030] = dataList[4204],
	[544031] = dataList[4205],
	[544032] = dataList[4206],
	[544033] = dataList[4207],
	[544034] = dataList[4208],
	[544035] = dataList[4209],
	[544036] = dataList[4210],
	[544037] = dataList[4211],
	[544038] = dataList[4212],
	[544039] = dataList[4213],
	[509000] = dataList[4214],
	[509001] = dataList[4215],
	[509002] = dataList[4216],
	[509003] = dataList[4217],
	[509004] = dataList[4218],
	[509005] = dataList[4219],
	[509006] = dataList[4220],
	[509007] = dataList[4221],
	[509008] = dataList[4222],
	[509009] = dataList[4223],
	[509010] = dataList[4224],
	[509011] = dataList[4225],
	[509012] = dataList[4226],
	[509013] = dataList[4227],
	[509014] = dataList[4228],
	[509015] = dataList[4229],
	[509016] = dataList[4230],
	[509017] = dataList[4231],
	[509018] = dataList[4232],
	[509019] = dataList[4233],
	[509020] = dataList[4234],
	[509021] = dataList[4235],
	[510000] = dataList[4236],
	[510001] = dataList[4237],
	[510002] = dataList[4238],
	[510003] = dataList[4239],
	[510004] = dataList[4240],
	[510005] = dataList[4241],
	[510006] = dataList[4242],
	[510007] = dataList[4243],
	[510008] = dataList[4244],
	[511000] = dataList[4245],
	[511001] = dataList[4246],
	[511002] = dataList[4247],
	[511003] = dataList[4248],
	[511004] = dataList[4249],
	[511005] = dataList[4250],
	[511006] = dataList[4251],
	[511007] = dataList[4252],
	[511008] = dataList[4253],
	[511009] = dataList[4254],
	[511010] = dataList[4255],
	[511011] = dataList[4256],
	[511012] = dataList[4257],
	[511013] = dataList[4258],
	[511014] = dataList[4259],
	[511015] = dataList[4260],
	[511016] = dataList[4261],
	[511017] = dataList[4262],
	[511018] = dataList[4263],
	[511019] = dataList[4264],
	[511020] = dataList[4265],
	[511021] = dataList[4266],
	[511022] = dataList[4267],
	[511023] = dataList[4268],
	[511024] = dataList[4269],
	[511025] = dataList[4270],
	[511026] = dataList[4271],
	[511027] = dataList[4272],
	[511028] = dataList[4273],
	[511029] = dataList[4274],
	[511030] = dataList[4275],
	[511031] = dataList[4276],
	[511032] = dataList[4277],
	[511033] = dataList[4278],
	[511034] = dataList[4279],
	[511035] = dataList[4280],
	[511036] = dataList[4281],
	[511037] = dataList[4282],
	[511038] = dataList[4283],
	[511039] = dataList[4284],
	[511040] = dataList[4285],
	[511041] = dataList[4286],
	[511042] = dataList[4287],
	[511043] = dataList[4288],
	[511044] = dataList[4289],
	[511045] = dataList[4290],
	[511046] = dataList[4291],
	[511047] = dataList[4292],
	[512000] = dataList[4293],
	[512001] = dataList[4294],
	[512002] = dataList[4295],
	[512003] = dataList[4296],
	[512004] = dataList[4297],
	[512005] = dataList[4298],
	[512006] = dataList[4299],
	[512007] = dataList[4300],
	[512008] = dataList[4301],
	[512009] = dataList[4302],
	[512010] = dataList[4303],
	[512011] = dataList[4304],
	[512012] = dataList[4305],
	[512013] = dataList[4306],
	[512014] = dataList[4307],
	[512015] = dataList[4308],
	[512016] = dataList[4309],
	[512017] = dataList[4310],
	[512018] = dataList[4311],
	[513000] = dataList[4312],
	[513001] = dataList[4313],
	[513002] = dataList[4314],
	[513003] = dataList[4315],
	[513004] = dataList[4316],
	[513005] = dataList[4317],
	[513006] = dataList[4318],
	[513007] = dataList[4319],
	[513008] = dataList[4320],
	[513009] = dataList[4321],
	[513010] = dataList[4322],
	[513011] = dataList[4323],
	[513012] = dataList[4324],
	[513013] = dataList[4325],
	[513014] = dataList[4326],
	[513015] = dataList[4327],
	[513016] = dataList[4328],
	[513017] = dataList[4329],
	[513018] = dataList[4330],
	[513019] = dataList[4331],
	[513020] = dataList[4332],
	[513021] = dataList[4333],
	[513022] = dataList[4334],
	[513023] = dataList[4335],
	[513024] = dataList[4336],
	[513025] = dataList[4337],
	[513026] = dataList[4338],
	[513027] = dataList[4339],
	[513028] = dataList[4340],
	[513029] = dataList[4341],
	[513030] = dataList[4342],
	[513031] = dataList[4343],
	[513032] = dataList[4344],
	[513033] = dataList[4345],
	[513034] = dataList[4346],
	[513035] = dataList[4347],
	[513036] = dataList[4348],
	[513037] = dataList[4349],
	[513038] = dataList[4350],
	[513039] = dataList[4351],
	[514000] = dataList[4352],
	[514001] = dataList[4353],
	[514002] = dataList[4354],
	[514003] = dataList[4355],
	[514004] = dataList[4356],
	[514005] = dataList[4357],
	[514006] = dataList[4358],
	[514007] = dataList[4359],
	[514008] = dataList[4360],
	[514009] = dataList[4361],
	[514010] = dataList[4362],
	[514011] = dataList[4363],
	[514012] = dataList[4364],
	[514013] = dataList[4365],
	[514016] = dataList[4366],
	[514017] = dataList[4367],
	[514018] = dataList[4368],
	[514019] = dataList[4369],
	[514020] = dataList[4370],
	[514021] = dataList[4371],
	[515000] = dataList[4372],
	[515001] = dataList[4373],
	[515002] = dataList[4374],
	[515003] = dataList[4375],
	[515004] = dataList[4376],
	[515005] = dataList[4377],
	[515006] = dataList[4378],
	[515007] = dataList[4379],
	[515008] = dataList[4380],
	[515009] = dataList[4381],
	[515010] = dataList[4382],
	[515011] = dataList[4383],
	[515012] = dataList[4384],
	[515013] = dataList[4385],
	[515014] = dataList[4386],
	[515015] = dataList[4387],
	[515016] = dataList[4388],
	[515017] = dataList[4389],
	[515018] = dataList[4390],
	[515019] = dataList[4391],
	[515021] = dataList[4392],
	[515022] = dataList[4393],
	[515023] = dataList[4394],
	[515024] = dataList[4395],
	[515025] = dataList[4396],
	[515026] = dataList[4397],
	[515027] = dataList[4398],
	[515028] = dataList[4399],
	[515029] = dataList[4400],
	[515030] = dataList[4401],
	[515031] = dataList[4402],
	[515032] = dataList[4403],
	[515033] = dataList[4404],
	[515034] = dataList[4405],
	[516000] = dataList[4406],
	[516001] = dataList[4407],
	[516002] = dataList[4408],
	[516003] = dataList[4409],
	[516004] = dataList[4410],
	[516005] = dataList[4411],
	[516006] = dataList[4412],
	[516007] = dataList[4413],
	[516008] = dataList[4414],
	[516009] = dataList[4415],
	[516011] = dataList[4416],
	[517000] = dataList[4417],
	[517001] = dataList[4418],
	[517002] = dataList[4419],
	[517003] = dataList[4420],
	[517004] = dataList[4421],
	[517005] = dataList[4422],
	[517006] = dataList[4423],
	[517007] = dataList[4424],
	[517008] = dataList[4425],
	[517009] = dataList[4426],
	[517010] = dataList[4427],
	[517011] = dataList[4428],
	[517012] = dataList[4429],
	[517013] = dataList[4430],
	[517014] = dataList[4431],
	[517015] = dataList[4432],
	[517016] = dataList[4433],
	[517017] = dataList[4434],
	[517018] = dataList[4435],
	[517019] = dataList[4436],
	[517020] = dataList[4437],
	[517021] = dataList[4438],
	[517022] = dataList[4439],
	[517023] = dataList[4440],
	[517024] = dataList[4441],
	[517025] = dataList[4442],
	[517026] = dataList[4443],
	[517027] = dataList[4444],
	[517028] = dataList[4445],
	[517029] = dataList[4446],
	[517030] = dataList[4447],
	[518000] = dataList[4448],
	[518001] = dataList[4449],
	[518002] = dataList[4450],
	[518003] = dataList[4451],
	[518005] = dataList[4452],
	[518006] = dataList[4453],
	[518007] = dataList[4454],
	[518008] = dataList[4455],
	[518009] = dataList[4456],
	[518010] = dataList[4457],
	[518011] = dataList[4458],
	[518012] = dataList[4459],
	[518013] = dataList[4460],
	[518014] = dataList[4461],
	[518015] = dataList[4462],
	[518016] = dataList[4463],
	[518017] = dataList[4464],
	[518018] = dataList[4465],
	[518019] = dataList[4466],
	[518020] = dataList[4467],
	[518021] = dataList[4468],
	[518022] = dataList[4469],
	[518023] = dataList[4470],
	[518024] = dataList[4471],
	[518025] = dataList[4472],
	[518026] = dataList[4473],
	[518027] = dataList[4474],
	[518028] = dataList[4475],
	[518029] = dataList[4476],
	[518030] = dataList[4477],
	[518031] = dataList[4478],
	[518032] = dataList[4479],
	[518033] = dataList[4480],
	[518034] = dataList[4481],
	[518035] = dataList[4482],
	[518036] = dataList[4483],
	[518037] = dataList[4484],
	[518038] = dataList[4485],
	[518039] = dataList[4486],
	[518040] = dataList[4487],
	[518041] = dataList[4488],
	[518042] = dataList[4489],
	[518043] = dataList[4490],
	[518044] = dataList[4491],
	[519000] = dataList[4492],
	[519001] = dataList[4493],
	[519002] = dataList[4494],
	[519003] = dataList[4495],
	[519004] = dataList[4496],
	[519005] = dataList[4497],
	[519006] = dataList[4498],
	[519007] = dataList[4499],
	[519008] = dataList[4500],
	[519009] = dataList[4501],
	[519010] = dataList[4502],
	[519011] = dataList[4503],
	[519012] = dataList[4504],
	[519014] = dataList[4505],
	[519015] = dataList[4506],
	[519016] = dataList[4507],
	[519017] = dataList[4508],
	[519018] = dataList[4509],
	[519019] = dataList[4510],
	[519020] = dataList[4511],
	[519021] = dataList[4512],
	[519022] = dataList[4513],
	[519023] = dataList[4514],
	[519024] = dataList[4515],
	[519025] = dataList[4516],
	[519026] = dataList[4517],
	[519027] = dataList[4518],
	[519028] = dataList[4519],
	[519029] = dataList[4520],
	[519030] = dataList[4521],
	[519031] = dataList[4522],
	[519032] = dataList[4523],
	[519033] = dataList[4524],
	[519034] = dataList[4525],
	[519035] = dataList[4526],
	[519036] = dataList[4527],
	[519037] = dataList[4528],
	[519038] = dataList[4529],
	[519039] = dataList[4530],
	[519040] = dataList[4531],
	[519041] = dataList[4532],
	[519042] = dataList[4533],
	[519043] = dataList[4534],
	[519044] = dataList[4535],
	[519045] = dataList[4536],
	[519046] = dataList[4537],
	[519047] = dataList[4538],
	[519048] = dataList[4539],
	[519049] = dataList[4540],
	[519050] = dataList[4541],
	[519051] = dataList[4542],
	[519052] = dataList[4543],
	[519053] = dataList[4544],
	[519054] = dataList[4545],
	[519055] = dataList[4546],
	[519056] = dataList[4547],
	[519057] = dataList[4548],
	[519058] = dataList[4549],
	[519059] = dataList[4550],
	[519060] = dataList[4551],
	[519061] = dataList[4552],
	[519062] = dataList[4553],
	[519063] = dataList[4554],
	[519064] = dataList[4555],
	[519065] = dataList[4556],
	[520000] = dataList[4557],
	[520001] = dataList[4558],
	[520002] = dataList[4559],
	[520003] = dataList[4560],
	[520004] = dataList[4561],
	[520005] = dataList[4562],
	[520006] = dataList[4563],
	[520007] = dataList[4564],
	[520008] = dataList[4565],
	[520009] = dataList[4566],
	[520010] = dataList[4567],
	[520011] = dataList[4568],
	[520012] = dataList[4569],
	[520013] = dataList[4570],
	[520014] = dataList[4571],
	[520015] = dataList[4572],
	[520016] = dataList[4573],
	[520017] = dataList[4574],
	[520018] = dataList[4575],
	[520019] = dataList[4576],
	[520020] = dataList[4577],
	[520021] = dataList[4578],
	[520022] = dataList[4579],
	[520023] = dataList[4580],
	[520024] = dataList[4581],
	[520025] = dataList[4582],
	[520026] = dataList[4583],
	[520027] = dataList[4584],
	[520028] = dataList[4585],
	[520029] = dataList[4586],
	[520030] = dataList[4587],
	[543000] = dataList[4588],
	[543001] = dataList[4589],
	[543002] = dataList[4590],
	[543003] = dataList[4591],
	[543004] = dataList[4592],
	[543005] = dataList[4593],
	[543006] = dataList[4594],
	[543007] = dataList[4595],
	[543008] = dataList[4596],
	[543009] = dataList[4597],
	[543010] = dataList[4598],
	[543011] = dataList[4599],
	[543012] = dataList[4600],
	[543013] = dataList[4601],
	[543014] = dataList[4602],
	[543015] = dataList[4603],
	[543016] = dataList[4604],
	[543017] = dataList[4605],
	[543018] = dataList[4606],
	[543019] = dataList[4607],
	[543020] = dataList[4608],
	[543021] = dataList[4609],
	[543022] = dataList[4610],
	[543023] = dataList[4611],
	[543024] = dataList[4612],
	[543025] = dataList[4613],
	[543026] = dataList[4614],
	[543027] = dataList[4615],
	[543028] = dataList[4616],
	[543029] = dataList[4617],
	[543030] = dataList[4618],
	[543031] = dataList[4619],
	[543032] = dataList[4620],
	[543033] = dataList[4621],
	[543034] = dataList[4622],
	[543035] = dataList[4623],
	[543036] = dataList[4624],
	[543037] = dataList[4625],
	[543038] = dataList[4626],
	[543039] = dataList[4627],
	[543040] = dataList[4628],
	[543041] = dataList[4629],
	[543042] = dataList[4630],
	[543043] = dataList[4631],
	[543044] = dataList[4632],
	[543045] = dataList[4633],
	[543046] = dataList[4634],
	[543047] = dataList[4635],
	[543048] = dataList[4636],
	[543049] = dataList[4637],
	[543050] = dataList[4638],
	[543051] = dataList[4639],
	[543052] = dataList[4640],
	[543053] = dataList[4641],
	[543054] = dataList[4642],
	[543055] = dataList[4643],
	[543056] = dataList[4644],
	[543057] = dataList[4645],
	[543058] = dataList[4646],
	[543059] = dataList[4647],
	[543060] = dataList[4648],
	[543061] = dataList[4649],
	[543062] = dataList[4650],
	[542000] = dataList[4651],
	[542001] = dataList[4652],
	[542002] = dataList[4653],
	[542003] = dataList[4654],
	[542004] = dataList[4655],
	[542005] = dataList[4656],
	[542006] = dataList[4657],
	[542007] = dataList[4658],
	[542008] = dataList[4659],
	[542009] = dataList[4660],
	[542010] = dataList[4661],
	[542011] = dataList[4662],
	[542012] = dataList[4663],
	[542013] = dataList[4664],
	[542014] = dataList[4665],
	[542015] = dataList[4666],
	[542016] = dataList[4667],
	[542017] = dataList[4668],
	[542018] = dataList[4669],
	[542019] = dataList[4670],
	[542020] = dataList[4671],
	[542021] = dataList[4672],
	[542022] = dataList[4673],
	[542023] = dataList[4674],
	[542024] = dataList[4675],
	[542025] = dataList[4676],
	[542026] = dataList[4677],
	[542027] = dataList[4678],
	[542028] = dataList[4679],
	[542029] = dataList[4680],
	[542030] = dataList[4681],
	[542031] = dataList[4682],
	[542032] = dataList[4683],
	[521000] = dataList[4684],
	[521001] = dataList[4685],
	[521002] = dataList[4686],
	[521003] = dataList[4687],
	[521004] = dataList[4688],
	[521005] = dataList[4689],
	[521006] = dataList[4690],
	[521007] = dataList[4691],
	[521008] = dataList[4692],
	[521009] = dataList[4693],
	[521010] = dataList[4694],
	[521011] = dataList[4695],
	[521012] = dataList[4696],
	[521013] = dataList[4697],
	[521014] = dataList[4698],
	[521015] = dataList[4699],
	[521016] = dataList[4700],
	[521017] = dataList[4701],
	[521018] = dataList[4702],
	[521019] = dataList[4703],
	[521020] = dataList[4704],
	[521021] = dataList[4705],
	[521022] = dataList[4706],
	[522000] = dataList[4707],
	[522001] = dataList[4708],
	[522002] = dataList[4709],
	[522003] = dataList[4710],
	[522004] = dataList[4711],
	[522005] = dataList[4712],
	[522006] = dataList[4713],
	[522007] = dataList[4714],
	[522008] = dataList[4715],
	[522009] = dataList[4716],
	[522010] = dataList[4717],
	[522011] = dataList[4718],
	[522012] = dataList[4719],
	[522013] = dataList[4720],
	[522014] = dataList[4721],
	[522015] = dataList[4722],
	[522016] = dataList[4723],
	[522017] = dataList[4724],
	[522018] = dataList[4725],
	[522019] = dataList[4726],
	[522020] = dataList[4727],
	[522021] = dataList[4728],
	[522022] = dataList[4729],
	[522023] = dataList[4730],
	[522024] = dataList[4731],
	[522025] = dataList[4732],
	[522026] = dataList[4733],
	[522027] = dataList[4734],
	[522028] = dataList[4735],
	[522029] = dataList[4736],
	[522030] = dataList[4737],
	[522031] = dataList[4738],
	[522032] = dataList[4739],
	[522033] = dataList[4740],
	[522034] = dataList[4741],
	[522035] = dataList[4742],
	[541000] = dataList[4743],
	[541001] = dataList[4744],
	[541002] = dataList[4745],
	[541003] = dataList[4746],
	[541004] = dataList[4747],
	[541005] = dataList[4748],
	[541006] = dataList[4749],
	[541007] = dataList[4750],
	[541008] = dataList[4751],
	[541009] = dataList[4752],
	[541010] = dataList[4753],
	[541011] = dataList[4754],
	[541012] = dataList[4755],
	[541013] = dataList[4756],
	[541014] = dataList[4757],
	[541015] = dataList[4758],
	[541016] = dataList[4759],
	[541017] = dataList[4760],
	[541018] = dataList[4761],
	[541019] = dataList[4762],
	[541020] = dataList[4763],
	[541021] = dataList[4764],
	[541022] = dataList[4765],
	[541023] = dataList[4766],
	[541024] = dataList[4767],
	[541025] = dataList[4768],
	[541026] = dataList[4769],
	[541027] = dataList[4770],
	[541028] = dataList[4771],
	[541029] = dataList[4772],
	[541030] = dataList[4773],
	[541031] = dataList[4774],
	[541032] = dataList[4775],
	[541033] = dataList[4776],
	[541034] = dataList[4777],
	[541035] = dataList[4778],
	[541036] = dataList[4779],
	[541037] = dataList[4780],
	[541038] = dataList[4781],
	[541039] = dataList[4782],
	[541040] = dataList[4783],
	[523000] = dataList[4784],
	[523001] = dataList[4785],
	[523002] = dataList[4786],
	[523003] = dataList[4787],
	[523004] = dataList[4788],
	[523005] = dataList[4789],
	[523006] = dataList[4790],
	[523007] = dataList[4791],
	[523008] = dataList[4792],
	[523009] = dataList[4793],
	[523010] = dataList[4794],
	[523011] = dataList[4795],
	[523012] = dataList[4796],
	[523013] = dataList[4797],
	[523014] = dataList[4798],
	[523015] = dataList[4799],
	[523016] = dataList[4800],
	[523017] = dataList[4801],
	[523018] = dataList[4802],
	[523019] = dataList[4803],
	[523020] = dataList[4804],
	[523021] = dataList[4805],
	[523022] = dataList[4806],
	[523023] = dataList[4807],
	[523024] = dataList[4808],
	[523025] = dataList[4809],
	[523026] = dataList[4810],
	[523027] = dataList[4811],
	[523028] = dataList[4812],
	[523029] = dataList[4813],
	[523030] = dataList[4814],
	[523031] = dataList[4815],
	[523032] = dataList[4816],
	[523033] = dataList[4817],
	[523034] = dataList[4818],
	[540000] = dataList[4819],
	[540001] = dataList[4820],
	[540002] = dataList[4821],
	[540003] = dataList[4822],
	[540004] = dataList[4823],
	[540005] = dataList[4824],
	[540006] = dataList[4825],
	[540007] = dataList[4826],
	[540008] = dataList[4827],
	[540009] = dataList[4828],
	[540010] = dataList[4829],
	[540011] = dataList[4830],
	[540012] = dataList[4831],
	[540013] = dataList[4832],
	[540014] = dataList[4833],
	[540015] = dataList[4834],
	[540016] = dataList[4835],
	[540017] = dataList[4836],
	[540018] = dataList[4837],
	[540019] = dataList[4838],
	[540020] = dataList[4839],
	[540021] = dataList[4840],
	[540022] = dataList[4841],
	[540023] = dataList[4842],
	[540024] = dataList[4843],
	[540025] = dataList[4844],
	[540026] = dataList[4845],
	[540027] = dataList[4846],
	[540028] = dataList[4847],
	[540029] = dataList[4848],
	[540030] = dataList[4849],
	[540031] = dataList[4850],
	[540032] = dataList[4851],
	[540033] = dataList[4852],
	[540034] = dataList[4853],
	[540035] = dataList[4854],
	[540036] = dataList[4855],
	[540037] = dataList[4856],
	[540038] = dataList[4857],
	[539000] = dataList[4858],
	[539001] = dataList[4859],
	[539002] = dataList[4860],
	[539003] = dataList[4861],
	[539004] = dataList[4862],
	[539005] = dataList[4863],
	[539006] = dataList[4864],
	[539007] = dataList[4865],
	[539008] = dataList[4866],
	[539009] = dataList[4867],
	[539010] = dataList[4868],
	[539011] = dataList[4869],
	[539012] = dataList[4870],
	[539013] = dataList[4871],
	[539014] = dataList[4872],
	[539015] = dataList[4873],
	[539016] = dataList[4874],
	[539017] = dataList[4875],
	[539018] = dataList[4876],
	[539019] = dataList[4877],
	[539020] = dataList[4878],
	[539021] = dataList[4879],
	[539022] = dataList[4880],
	[539023] = dataList[4881],
	[539024] = dataList[4882],
	[539025] = dataList[4883],
	[539026] = dataList[4884],
	[539027] = dataList[4885],
	[539028] = dataList[4886],
	[539029] = dataList[4887],
	[539030] = dataList[4888],
	[539031] = dataList[4889],
	[539032] = dataList[4890],
	[539033] = dataList[4891],
	[539034] = dataList[4892],
	[539035] = dataList[4893],
	[539036] = dataList[4894],
	[539037] = dataList[4895],
	[539038] = dataList[4896],
	[539039] = dataList[4897],
	[539040] = dataList[4898],
	[539041] = dataList[4899],
	[539042] = dataList[4900],
	[539043] = dataList[4901],
	[539044] = dataList[4902],
	[539045] = dataList[4903],
	[539046] = dataList[4904],
	[539047] = dataList[4905],
	[539048] = dataList[4906],
	[539049] = dataList[4907],
	[539050] = dataList[4908],
	[539051] = dataList[4909],
	[539052] = dataList[4910],
	[539053] = dataList[4911],
	[539054] = dataList[4912],
	[539055] = dataList[4913],
	[539056] = dataList[4914],
	[539057] = dataList[4915],
	[539058] = dataList[4916],
	[539059] = dataList[4917],
	[539060] = dataList[4918],
	[539061] = dataList[4919],
	[539062] = dataList[4920],
	[539063] = dataList[4921],
	[539064] = dataList[4922],
	[539065] = dataList[4923],
	[539066] = dataList[4924],
	[539067] = dataList[4925],
	[539068] = dataList[4926],
	[539069] = dataList[4927],
	[539070] = dataList[4928],
	[539071] = dataList[4929],
	[539072] = dataList[4930],
	[539073] = dataList[4931],
	[524000] = dataList[4932],
	[524001] = dataList[4933],
	[524002] = dataList[4934],
	[524003] = dataList[4935],
	[524004] = dataList[4936],
	[524005] = dataList[4937],
	[524006] = dataList[4938],
	[524007] = dataList[4939],
	[524008] = dataList[4940],
	[524009] = dataList[4941],
	[524010] = dataList[4942],
	[524011] = dataList[4943],
	[524012] = dataList[4944],
	[524013] = dataList[4945],
	[524014] = dataList[4946],
	[524015] = dataList[4947],
	[524016] = dataList[4948],
	[524017] = dataList[4949],
	[524018] = dataList[4950],
	[524019] = dataList[4951],
	[524020] = dataList[4952],
	[524021] = dataList[4953],
	[524022] = dataList[4954],
	[524023] = dataList[4955],
	[524024] = dataList[4956],
	[524025] = dataList[4957],
	[524026] = dataList[4958],
	[524027] = dataList[4959],
	[524028] = dataList[4960],
	[524029] = dataList[4961],
	[524030] = dataList[4962],
	[524031] = dataList[4963],
	[538000] = dataList[4964],
	[538001] = dataList[4965],
	[538002] = dataList[4966],
	[538003] = dataList[4967],
	[538004] = dataList[4968],
	[538005] = dataList[4969],
	[538006] = dataList[4970],
	[538007] = dataList[4971],
	[538008] = dataList[4972],
	[538009] = dataList[4973],
	[538010] = dataList[4974],
	[538011] = dataList[4975],
	[538012] = dataList[4976],
	[538013] = dataList[4977],
	[538014] = dataList[4978],
	[538015] = dataList[4979],
	[538016] = dataList[4980],
	[538017] = dataList[4981],
	[538018] = dataList[4982],
	[538019] = dataList[4983],
	[538020] = dataList[4984],
	[538021] = dataList[4985],
	[538022] = dataList[4986],
	[538023] = dataList[4987],
	[538024] = dataList[4988],
	[538025] = dataList[4989],
	[538026] = dataList[4990],
	[538027] = dataList[4991],
	[538028] = dataList[4992],
	[538029] = dataList[4993],
	[525000] = dataList[4994],
	[525001] = dataList[4995],
	[525002] = dataList[4996],
	[525003] = dataList[4997],
	[525004] = dataList[4998],
	[525005] = dataList[4999],
	[525006] = dataList[5000],
	[525007] = dataList[5001],
	[525008] = dataList[5002],
	[525009] = dataList[5003],
	[525010] = dataList[5004],
	[525011] = dataList[5005],
	[525012] = dataList[5006],
	[525013] = dataList[5007],
	[525014] = dataList[5008],
	[525015] = dataList[5009],
	[525016] = dataList[5010],
	[525017] = dataList[5011],
	[525018] = dataList[5012],
	[525019] = dataList[5013],
	[525020] = dataList[5014],
	[525021] = dataList[5015],
	[525022] = dataList[5016],
	[525023] = dataList[5017],
	[525024] = dataList[5018],
	[525025] = dataList[5019],
	[525026] = dataList[5020],
	[525027] = dataList[5021],
	[525028] = dataList[5022],
	[525029] = dataList[5023],
	[525030] = dataList[5024],
	[525031] = dataList[5025],
	[525032] = dataList[5026],
	[525033] = dataList[5027],
	[525034] = dataList[5028],
	[525035] = dataList[5029],
	[525036] = dataList[5030],
	[525037] = dataList[5031],
	[525038] = dataList[5032],
	[525039] = dataList[5033],
	[525040] = dataList[5034],
	[525041] = dataList[5035],
	[525042] = dataList[5036],
	[525043] = dataList[5037],
	[525044] = dataList[5038],
	[525045] = dataList[5039],
	[525046] = dataList[5040],
	[525047] = dataList[5041],
	[525048] = dataList[5042],
	[525049] = dataList[5043],
	[525050] = dataList[5044],
	[526000] = dataList[5045],
	[526001] = dataList[5046],
	[526002] = dataList[5047],
	[526003] = dataList[5048],
	[526004] = dataList[5049],
	[526005] = dataList[5050],
	[526006] = dataList[5051],
	[526007] = dataList[5052],
	[526008] = dataList[5053],
	[526009] = dataList[5054],
	[526010] = dataList[5055],
	[526011] = dataList[5056],
	[526012] = dataList[5057],
	[526013] = dataList[5058],
	[526014] = dataList[5059],
	[526015] = dataList[5060],
	[526016] = dataList[5061],
	[526017] = dataList[5062],
	[526018] = dataList[5063],
	[526019] = dataList[5064],
	[526020] = dataList[5065],
	[526021] = dataList[5066],
	[526022] = dataList[5067],
	[526023] = dataList[5068],
	[526024] = dataList[5069],
	[537000] = dataList[5070],
	[537001] = dataList[5071],
	[537002] = dataList[5072],
	[537003] = dataList[5073],
	[537004] = dataList[5074],
	[537005] = dataList[5075],
	[537006] = dataList[5076],
	[537007] = dataList[5077],
	[537008] = dataList[5078],
	[537009] = dataList[5079],
	[537010] = dataList[5080],
	[537011] = dataList[5081],
	[537012] = dataList[5082],
	[537013] = dataList[5083],
	[537014] = dataList[5084],
	[537015] = dataList[5085],
	[537016] = dataList[5086],
	[537017] = dataList[5087],
	[537018] = dataList[5088],
	[537019] = dataList[5089],
	[537020] = dataList[5090],
	[537021] = dataList[5091],
	[537022] = dataList[5092],
	[537023] = dataList[5093],
	[537024] = dataList[5094],
	[537025] = dataList[5095],
	[537026] = dataList[5096],
	[537027] = dataList[5097],
	[537028] = dataList[5098],
	[537029] = dataList[5099],
	[537030] = dataList[5100],
	[537031] = dataList[5101],
	[537032] = dataList[5102],
	[537033] = dataList[5103],
	[537034] = dataList[5104],
	[537035] = dataList[5105],
	[527000] = dataList[5106],
	[527001] = dataList[5107],
	[527002] = dataList[5108],
	[527003] = dataList[5109],
	[527004] = dataList[5110],
	[527005] = dataList[5111],
	[527006] = dataList[5112],
	[527007] = dataList[5113],
	[527008] = dataList[5114],
	[527009] = dataList[5115],
	[527010] = dataList[5116],
	[527011] = dataList[5117],
	[527012] = dataList[5118],
	[527013] = dataList[5119],
	[527014] = dataList[5120],
	[527015] = dataList[5121],
	[527016] = dataList[5122],
	[527017] = dataList[5123],
	[527018] = dataList[5124],
	[527019] = dataList[5125],
	[527020] = dataList[5126],
	[527021] = dataList[5127],
	[527022] = dataList[5128],
	[527023] = dataList[5129],
	[527024] = dataList[5130],
	[527025] = dataList[5131],
	[527026] = dataList[5132],
	[527027] = dataList[5133],
	[527028] = dataList[5134],
	[527029] = dataList[5135],
	[527030] = dataList[5136],
	[527031] = dataList[5137],
	[527032] = dataList[5138],
	[527033] = dataList[5139],
	[527034] = dataList[5140],
	[527035] = dataList[5141],
	[527036] = dataList[5142],
	[527037] = dataList[5143],
	[527038] = dataList[5144],
	[527039] = dataList[5145],
	[527040] = dataList[5146],
	[527041] = dataList[5147],
	[527042] = dataList[5148],
	[527043] = dataList[5149],
	[527044] = dataList[5150],
	[527045] = dataList[5151],
	[527046] = dataList[5152],
	[527047] = dataList[5153],
	[527048] = dataList[5154],
	[527049] = dataList[5155],
	[527050] = dataList[5156],
	[527051] = dataList[5157],
	[527052] = dataList[5158],
	[527053] = dataList[5159],
	[527054] = dataList[5160],
	[527055] = dataList[5161],
	[527056] = dataList[5162],
	[527057] = dataList[5163],
	[527058] = dataList[5164],
	[527059] = dataList[5165],
	[527060] = dataList[5166],
	[527061] = dataList[5167],
	[527062] = dataList[5168],
	[528000] = dataList[5169],
	[528001] = dataList[5170],
	[528002] = dataList[5171],
	[528003] = dataList[5172],
	[528004] = dataList[5173],
	[528005] = dataList[5174],
	[528006] = dataList[5175],
	[528007] = dataList[5176],
	[528008] = dataList[5177],
	[528009] = dataList[5178],
	[528010] = dataList[5179],
	[528011] = dataList[5180],
	[528012] = dataList[5181],
	[528013] = dataList[5182],
	[528014] = dataList[5183],
	[528015] = dataList[5184],
	[528016] = dataList[5185],
	[528017] = dataList[5186],
	[528018] = dataList[5187],
	[528019] = dataList[5188],
	[528020] = dataList[5189],
	[528021] = dataList[5190],
	[528022] = dataList[5191],
	[528023] = dataList[5192],
	[528024] = dataList[5193],
	[528025] = dataList[5194],
	[528026] = dataList[5195],
	[528027] = dataList[5196],
	[528028] = dataList[5197],
	[528029] = dataList[5198],
	[528030] = dataList[5199],
	[528031] = dataList[5200],
	[528032] = dataList[5201],
	[528033] = dataList[5202],
	[528034] = dataList[5203],
	[528035] = dataList[5204],
	[528036] = dataList[5205],
	[528037] = dataList[5206],
	[528038] = dataList[5207],
	[528039] = dataList[5208],
	[528040] = dataList[5209],
	[528041] = dataList[5210],
	[528042] = dataList[5211],
	[528043] = dataList[5212],
	[528044] = dataList[5213],
	[528045] = dataList[5214],
	[528046] = dataList[5215],
	[528047] = dataList[5216],
	[528048] = dataList[5217],
	[528049] = dataList[5218],
	[528050] = dataList[5219],
	[528051] = dataList[5220],
	[528052] = dataList[5221],
	[528053] = dataList[5222],
	[528054] = dataList[5223],
	[528055] = dataList[5224],
	[528056] = dataList[5225],
	[528057] = dataList[5226],
	[536000] = dataList[5227],
	[536001] = dataList[5228],
	[536002] = dataList[5229],
	[536003] = dataList[5230],
	[536004] = dataList[5231],
	[536005] = dataList[5232],
	[536006] = dataList[5233],
	[536007] = dataList[5234],
	[536008] = dataList[5235],
	[536009] = dataList[5236],
	[536010] = dataList[5237],
	[536011] = dataList[5238],
	[535000] = dataList[5239],
	[535001] = dataList[5240],
	[535002] = dataList[5241],
	[535003] = dataList[5242],
	[535004] = dataList[5243],
	[535005] = dataList[5244],
	[535006] = dataList[5245],
	[535007] = dataList[5246],
	[535008] = dataList[5247],
	[535009] = dataList[5248],
	[535010] = dataList[5249],
	[535011] = dataList[5250],
	[535012] = dataList[5251],
	[535013] = dataList[5252],
	[535014] = dataList[5253],
	[535015] = dataList[5254],
	[535016] = dataList[5255],
	[534000] = dataList[5256],
	[534001] = dataList[5257],
	[534002] = dataList[5258],
	[534003] = dataList[5259],
	[534004] = dataList[5260],
	[534005] = dataList[5261],
	[534006] = dataList[5262],
	[534007] = dataList[5263],
	[534008] = dataList[5264],
	[534009] = dataList[5265],
	[534010] = dataList[5266],
	[534011] = dataList[5267],
	[534012] = dataList[5268],
	[534013] = dataList[5269],
	[534014] = dataList[5270],
	[534015] = dataList[5271],
	[534016] = dataList[5272],
	[534017] = dataList[5273],
	[534018] = dataList[5274],
	[534019] = dataList[5275],
	[534020] = dataList[5276],
	[534021] = dataList[5277],
	[534022] = dataList[5278],
	[534023] = dataList[5279],
	[534024] = dataList[5280],
	[534025] = dataList[5281],
	[534026] = dataList[5282],
	[534027] = dataList[5283],
	[529000] = dataList[5284],
	[529001] = dataList[5285],
	[529002] = dataList[5286],
	[529003] = dataList[5287],
	[529004] = dataList[5288],
	[529005] = dataList[5289],
	[529006] = dataList[5290],
	[529007] = dataList[5291],
	[529008] = dataList[5292],
	[529009] = dataList[5293],
	[529010] = dataList[5294],
	[529011] = dataList[5295],
	[529012] = dataList[5296],
	[529013] = dataList[5297],
	[529014] = dataList[5298],
	[529015] = dataList[5299],
	[529016] = dataList[5300],
	[529017] = dataList[5301],
	[529018] = dataList[5302],
	[529019] = dataList[5303],
	[529020] = dataList[5304],
	[529021] = dataList[5305],
	[529022] = dataList[5306],
	[529023] = dataList[5307],
	[529024] = dataList[5308],
	[529025] = dataList[5309],
	[529026] = dataList[5310],
	[529027] = dataList[5311],
	[529028] = dataList[5312],
	[529029] = dataList[5313],
	[529030] = dataList[5314],
	[529031] = dataList[5315],
	[529032] = dataList[5316],
	[529033] = dataList[5317],
	[529034] = dataList[5318],
	[529035] = dataList[5319],
	[529036] = dataList[5320],
	[529037] = dataList[5321],
	[529038] = dataList[5322],
	[529039] = dataList[5323],
	[529040] = dataList[5324],
	[529041] = dataList[5325],
	[529042] = dataList[5326],
	[529043] = dataList[5327],
	[529044] = dataList[5328],
	[529045] = dataList[5329],
	[529046] = dataList[5330],
	[529047] = dataList[5331],
	[529048] = dataList[5332],
	[529049] = dataList[5333],
	[529050] = dataList[5334],
	[529051] = dataList[5335],
	[529052] = dataList[5336],
	[529053] = dataList[5337],
	[529054] = dataList[5338],
	[529055] = dataList[5339],
	[529056] = dataList[5340],
	[529057] = dataList[5341],
	[529058] = dataList[5342],
	[529059] = dataList[5343],
	[529060] = dataList[5344],
	[533000] = dataList[5345],
	[533001] = dataList[5346],
	[533002] = dataList[5347],
	[533003] = dataList[5348],
	[533004] = dataList[5349],
	[533005] = dataList[5350],
	[533006] = dataList[5351],
	[533007] = dataList[5352],
	[533008] = dataList[5353],
	[533009] = dataList[5354],
	[533010] = dataList[5355],
	[533011] = dataList[5356],
	[530000] = dataList[5357],
	[530001] = dataList[5358],
	[530002] = dataList[5359],
	[530003] = dataList[5360],
	[530004] = dataList[5361],
	[530005] = dataList[5362],
	[530006] = dataList[5363],
	[530007] = dataList[5364],
	[530008] = dataList[5365],
	[530009] = dataList[5366],
	[530010] = dataList[5367],
	[530011] = dataList[5368],
	[530012] = dataList[5369],
	[530013] = dataList[5370],
	[530014] = dataList[5371],
	[530015] = dataList[5372],
	[530016] = dataList[5373],
	[530017] = dataList[5374],
	[530018] = dataList[5375],
	[530019] = dataList[5376],
	[530020] = dataList[5377],
	[530021] = dataList[5378],
	[530022] = dataList[5379],
	[530023] = dataList[5380],
	[530024] = dataList[5381],
	[530025] = dataList[5382],
	[530026] = dataList[5383],
	[530027] = dataList[5384],
	[530028] = dataList[5385],
	[530029] = dataList[5386],
	[530030] = dataList[5387],
	[530031] = dataList[5388],
	[530032] = dataList[5389],
	[530033] = dataList[5390],
	[530034] = dataList[5391],
	[530035] = dataList[5392],
	[532000] = dataList[5393],
	[532001] = dataList[5394],
	[532002] = dataList[5395],
	[532003] = dataList[5396],
	[532004] = dataList[5397],
	[532005] = dataList[5398],
	[532006] = dataList[5399],
	[532007] = dataList[5400],
	[532008] = dataList[5401],
	[532009] = dataList[5402],
	[532010] = dataList[5403],
	[532011] = dataList[5404],
	[532012] = dataList[5405],
	[532013] = dataList[5406],
	[532014] = dataList[5407],
	[532015] = dataList[5408],
	[532016] = dataList[5409],
	[532017] = dataList[5410],
	[532018] = dataList[5411],
	[532019] = dataList[5412],
	[532020] = dataList[5413],
	[532021] = dataList[5414],
	[532022] = dataList[5415],
	[532023] = dataList[5416],
	[532024] = dataList[5417],
	[532025] = dataList[5418],
	[532026] = dataList[5419],
	[532027] = dataList[5420],
	[532028] = dataList[5421],
	[532029] = dataList[5422],
	[532030] = dataList[5423],
	[532031] = dataList[5424],
	[532032] = dataList[5425],
	[532033] = dataList[5426],
	[532034] = dataList[5427],
	[532035] = dataList[5428],
	[532036] = dataList[5429],
	[532037] = dataList[5430],
	[532038] = dataList[5431],
	[532039] = dataList[5432],
	[532040] = dataList[5433],
	[532041] = dataList[5434],
	[532042] = dataList[5435],
	[532043] = dataList[5436],
	[532044] = dataList[5437],
	[532045] = dataList[5438],
	[531000] = dataList[5439],
	[531001] = dataList[5440],
	[531002] = dataList[5441],
	[531003] = dataList[5442],
	[531004] = dataList[5443],
	[531005] = dataList[5444],
	[531006] = dataList[5445],
	[531007] = dataList[5446],
	[531008] = dataList[5447],
	[531009] = dataList[5448],
	[531010] = dataList[5449],
	[531011] = dataList[5450],
	[531012] = dataList[5451],
	[531013] = dataList[5452],
	[531014] = dataList[5453],
	[531015] = dataList[5454],
	[531016] = dataList[5455],
	[531017] = dataList[5456],
	[531018] = dataList[5457],
	[531019] = dataList[5458],
	[531020] = dataList[5459],
	[531021] = dataList[5460],
	[531022] = dataList[5461],
	[531023] = dataList[5462],
	[531024] = dataList[5463],
	[531025] = dataList[5464]
}

t_criware_audio.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			return value
		else
			error(string.format("the field name[% s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_criware_audio
