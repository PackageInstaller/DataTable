-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_buff_effect.lua

module("logicconfig.config.t_buff_effect", package.seeall)

local title = {
	mountPointName = 4,
	turningShow = 5,
	id = 1,
	duration = 3,
	showOrder = 6,
	path = 2
}
local dataList = {
	{
		2,
		"common/buff/fx_buff_miehuo",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		31,
		"common/buff/fx_buff_31_hunluan",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		34,
		"common/buff/fx_buff_34_moyandun",
		0,
		"hangPoints/front",
		false,
		0
	},
	{
		37,
		"common/buff/fx_buff_xuanwudun",
		0,
		"hangPoints/front",
		false,
		0
	},
	{
		39,
		"common/buff/fx_buff_shan",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		41,
		"common/buff/fx_buff_huodun",
		0,
		"hangPoints/front",
		false,
		0
	},
	{
		44,
		"common/buff/fx_buff_jianshanghudun",
		0,
		"hangPoints/front",
		false,
		0
	},
	{
		45,
		"common/buff/fx_buff_45_chaofeng",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		46,
		"common/buff/fx_buff_46_xuanyun",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		52,
		"common/buff/fx_buff_52_mianyi",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		162,
		"common/buff/fx_buff_bianshen",
		1,
		"hangPoints/foot",
		false,
		0
	},
	{
		167,
		"jingling/fx_10029_shengguangbaojian/fx_10029_hit02_shengguangbaojian",
		1.3,
		"hangPoints/foot",
		false,
		0
	},
	{
		187,
		"common/buff/fx_buff_187_xuwu",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		228,
		"common/buff/fx_buff_228_xishanghudun",
		0,
		"hangPoints/front",
		false,
		0
	},
	{
		250,
		"common/buff/fx_buff_chongsheng",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		251,
		"common/buff/fx_buff_chongsheng_fuhuo",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		260,
		"common/buff/fx_buff_wufahuixue",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		298,
		"common/buff/fx_buff_feiying",
		0,
		"hangPoints/foot",
		false,
		1
	},
	{
		303,
		"common/buff/fx_buff_qianjibuff",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		307,
		"common/buff/fx_buff_shuishengzhubuff",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		367,
		"common/buff/fx_buff_bingxiang",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		455,
		"common/buff/fx_buff_shoushangjiashen",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		485,
		"common/buff/fx_buff_shuxing_huo",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		489,
		"common/buff/fx_buff_shuxing_cao",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		493,
		"common/buff/fx_buff_shuxing_shui",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		519,
		"common/buff/fx_buff_shuxing_guang",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		523,
		"common/buff/fx_buff_shuxing_an",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		764,
		"common/buff/fx_buff_jiaqishi",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		787,
		"common/buff/fx_buff_feng",
		1,
		"hangPoints/center",
		false,
		0
	},
	{
		879,
		"common/buff/fx_buff_didangzhimingshanghai",
		0,
		"hangPoints/front",
		false,
		0
	},
	{
		1001,
		"common/buff/fx_buff_shoushangjianshao",
		0,
		"hangPoints/front",
		false,
		0
	},
	{
		1002,
		"common/buff/fx_buff_hudun",
		0,
		"hangPoints/front",
		false,
		2
	},
	{
		1003,
		"common/buff/fx_buff_hudunposui",
		0,
		"hangPoints/front",
		false,
		0
	},
	{
		1004,
		"common/buff/fx_buff_momian",
		0,
		"hangPoints/front",
		false,
		0
	},
	{
		1007,
		"common/buff/fx_buff_longhuang",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1009,
		"common/buff/fx_buff_chengzhu",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1055,
		"common/buff/fx_buff_nvwushen",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1056,
		"common/buff/fx_buff_zhongdu",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1057,
		"common/buff/fx_buff_huoxishanghaijiashen",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1058,
		"common/buff/fx_buff_longyan",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1059,
		"common/buff/fx_buff_zuanshishouji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1060,
		"common/buff/fx_buff_zuanshisiwang",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1061,
		"common/buff/fx_buff_jinbishouji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1062,
		"common/buff/fx_buff_jinbisiwang",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1063,
		"common/buff/fx_buff_jingyanguoshouji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1064,
		"common/buff/fx_buff_jingyanguosiwang",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1065,
		"common/buff/fx_buff_panduolazhongdu",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1066,
		"common/buff/fx_buff_tiaozhanzengqiang",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1067,
		"common/buff/fx_buff_zhuoshao",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1068,
		"common/buff/fx_buff_shuizhiyinji",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1069,
		"common/buff/fx_buff_tianlongzhinu",
		1.3,
		"hangPoints/center",
		false,
		0
	},
	{
		1070,
		"common/buff/fx_buff_baguadun",
		0,
		"hangPoints/front",
		false,
		0
	},
	{
		1071,
		"common/buff/fx_buff_jinjizhizhen",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1072,
		"common/buff/fx_buff_zhenlongshouhu",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1073,
		"common/buff/fx_buff_leiji",
		1.3,
		"hangPoints/center",
		false,
		0
	},
	{
		1074,
		"common/buff/fx_buff_zibao",
		1.3,
		"hangPoints/foot",
		false,
		0
	},
	{
		1075,
		"common/buff/fx_buff_dangdangtiaoxin",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1076,
		"common/buff/fx_buff_jinghua",
		1.5,
		"hangPoints/foot",
		false,
		0
	},
	{
		1077,
		"common/buff/fx_buff_wulidun",
		0,
		"hangPoints/front",
		false,
		0
	},
	{
		1078,
		"common/buff/fx_buff_shijianzhilun",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1079,
		"common/buff/fx_buff_shijianzhilunyichu",
		1.5,
		"hangPoints/foot",
		false,
		0
	},
	{
		1080,
		"common/buff/fx_buff_chenmo",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1081,
		"common/buff/fx_buff_luoshiqihudun",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1082,
		"common/buff/fx_buff_miyazengyi",
		1.5,
		"hangPoints/foot",
		false,
		0
	},
	{
		1083,
		"common/buff/fx_buff_duolahudun",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1084,
		"common/buff/fx_buff_antianshiyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1085,
		"common/buff/fx_buff_guangmingwangshouhu",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1086,
		"common/buff/fx_buff_guanglonghudun",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1087,
		"jingling/fx_10380_fengbaobao/fx_10380_skill03_buff_fengbaobao",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1088,
		"common/buff/fx_buff_yilishabaibeidong",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1089,
		"common/buff/fx_buff_yilishabaifuhuo",
		3,
		"hangPoints/foot",
		false,
		0
	},
	{
		1090,
		"common/buff/fx_buff_anlongbumie",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1091,
		"common/buff/fx_buff_anlongjianshe",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1092,
		"common/buff/fx_buff_bingjia",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1093,
		"common/buff/fx_buff_yichufumianxiaoguo3",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1094,
		"common/buff/fx_buff_kanbujian",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1095,
		"common/buff/fx_buff_tianjiahudun3",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1096,
		"common/buff/fx_buff_qishijiejing2",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1097,
		"common/buff/fx_buff_qishijiejing2_01",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1098,
		"common/buff/fx_buff_meihuolan",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1099,
		"common/buff/fx_buff_xinianercishanghai",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1100,
		"common/buff/fx_buff_meihuohong",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1101,
		"common/buff/fx_buff_xinianhuixue",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1102,
		"common/buff/fx_buff_longhun01",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1103,
		"common/buff/fx_buff_longhun01_01",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1104,
		"common/buff/fx_buff_shanshuoyinji",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1105,
		"common/buff/fx_buff_jinjizhizhen4",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1106,
		"common/buff/fx_buff_fengyin4",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1107,
		"common/buff/fx_buff_shuimian",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1108,
		"common/buff/fx_buff_caiguang",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1109,
		"common/buff/fx_buff_caiguangbaokai",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1110,
		"common/buff/fx_buff_guanghe",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1111,
		"common/buff/fx_buff_guanghebaozha",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1112,
		"common/buff/fx_buff_huisu",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1113,
		"common/buff/fx_buff_shenpan",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1114,
		"common/buff/fx_buff_silie",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1115,
		"common/buff/fx_buff_mingyunzhisuo",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1116,
		"common/buff/fx_buff_tianjiahudun6",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1117,
		"common/buff/fx_buff_juedou",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1118,
		"common/buff/fx_buff_yu",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1119,
		"common/buff/fx_buff_yu1",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1120,
		"common/buff/fx_buff_tianjiahudun7",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1121,
		"common/buff/fx_buff_fuhuo5",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1122,
		"common/buff/fx_buff_mohunzhou",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1123,
		"common/buff/fx_buff_wangxulonghun",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1124,
		"common/buff/fx_buff_wangxulonghun01",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1125,
		"common/buff/fx_buff_ruohua",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1126,
		"common/buff/fx_buff_weilaiyinji",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1127,
		"common/buff/fx_buff_baguaxinxi",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1128,
		"common/buff/fx_buff_tangguozhadan",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1129,
		"common/buff/fx_buff_tangguobaozha",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1130,
		"common/buff/fx_buff_xinghunzhuiluo",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1131,
		"common/buff/fx_buff_rujiangganglin",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1132,
		"common/buff/fx_buff_meiguimengjing",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1133,
		"common/buff/fx_buff_liexinhonglian",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1134,
		"common/buff/fx_buff_guanglun",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1135,
		"common/buff/fx_buff_miemo",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1136,
		"common/buff/fx_buff_chongsheng2",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1137,
		"common/buff/fx_buff_longhun02",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1138,
		"common/buff/fx_buff_wanxiang",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1139,
		"common/buff/fx_buff_zhiliao3",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1140,
		"common/buff/fx_buff_shenqiarui_02",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1141,
		"common/buff/fx_buff_shenqiarui01_02",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1142,
		"common/buff/fx_buff_kuangbao",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1143,
		"common/buff/fx_buff_longgudao",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1144,
		"common/buff/fx_buff_longgudao01",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1145,
		"common/buff/fx_buff_chengzhuenergy",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1146,
		"common/buff/fx_buff_longzhupingzhang",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1147,
		"common/buff/fx_buff_longzhupingzhang01",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1148,
		"common/buff/fx_buff_qinggu_hudun1_01",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1149,
		"common/buff/fx_buff_qinggu_hudun1_02",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1150,
		"common/buff/fx_buff_qinggu_hudun1_03",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1151,
		"common/buff/fx_buff_qinggu_hudun1_hit",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1152,
		"common/buff/fx_buff_qinggu_hudun1_buff",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1153,
		"common/buff/fx_buff_qinggu_hudun2_01",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1154,
		"common/buff/fx_buff_qinggu_hudun2_02",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1155,
		"common/buff/fx_buff_qinggu_hudun2_03",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1156,
		"common/buff/fx_buff_qinggu_hudun2_hit",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1157,
		"common/buff/fx_buff_qinggu_hudun2_buff",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1158,
		"common/buff/fx_buff_qinggu_hudun3_01",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1159,
		"common/buff/fx_buff_qinggu_hudun3_02",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1160,
		"common/buff/fx_buff_qinggu_hudun3_03",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1161,
		"common/buff/fx_buff_qinggu_hudun3_hit",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1162,
		"common/buff/fx_buff_qinggu_hudun3_buff",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1163,
		"common/buff/fx_buff_chuandao",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1164,
		"common/buff/fx_buff_xingluo03",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1165,
		"common/buff/fx_buff_ximoshuangzi",
		0,
		"hangPoints/center",
		true,
		0
	},
	{
		1166,
		"common/buff/fx_buff_yanmie",
		0,
		"hangPoints/center",
		true,
		0
	},
	{
		1167,
		"common/buff/fx_buff_beiduo_03_01",
		0,
		"hangPoints/foot",
		true,
		0
	},
	{
		1168,
		"common/buff/fx_buff_beiduo_03_02",
		0,
		"hangPoints/foot",
		true,
		0
	},
	{
		1169,
		"common/buff/fx_buff_beiduo_03_03",
		0,
		"hangPoints/foot",
		true,
		0
	},
	{
		1170,
		"common/buff/fx_buff_mingyunzhisuo01",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1171,
		"common/buff/fx_buff_huisuyinji",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1172,
		"common/buff/fx_buff_shiguangyinji",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1173,
		"common/buff/fx_buff_guizeniuqu01",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1174,
		"common/buff/fx_buff_guizeniuqu",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1175,
		"common/buff/fx_buff_lingwen_zjys01",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1176,
		"common/buff/fx_buff_lingwen_zjys02",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1177,
		"common/buff/fx_buff_jimo",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1178,
		"common/buff/fx_buff_jimo01",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1179,
		"common/buff/fx_buff_wufafuhuo",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1180,
		"common/buff/fx_buff_zuzhou",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1181,
		"common/buff/fx_buff_yishimianyi",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1182,
		"common/buff/fx_buff_bailongfuhuo",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1183,
		"common/buff/fx_buff_zhuanyishanghai",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1184,
		"common/buff/fx_buff_shenyaobiaoji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1185,
		"common/buff/fx_buff_fenjin",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1186,
		"common/buff/fx_buff_konghuangcs",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1187,
		"common/buff/fx_buff_tuntianbd",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1188,
		"common/buff/fx_buff_shenyaozhixulonghun",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1189,
		"common/buff/fx_buff_shenyaozhixunvpilonghun",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1190,
		"common/buff/fx_buff_tuntianbd01",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1191,
		"common/buff/fx_buff_yonghengshenglongfc",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1192,
		"common/buff/fx_buff_yonghengshenglong01fc",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1193,
		"common/buff/fx_buff_fanruimianyi",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1194,
		"common/buff/fx_buff_jiehuangtenwan",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1195,
		"common/buff/fx_buff_wangzhejisp",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1196,
		"common/buff/fx_buff_4399mengchongsp",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1197,
		"common/buff/fx_buff_longhuangfantian",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1198,
		"common/buff/fx_buff_longhuangfantian01",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1199,
		"common/buff/fx_buff_sada",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1200,
		"common/buff/fx_buff_sada01",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1201,
		"common/buff/fx_buff_salaluosi",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1202,
		"common/buff/fx_buff_salaluosi_01",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1203,
		"common/buff/fx_buff_shenyaowangzhelong",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1204,
		"common/buff/fx_buff_shenyaowangzhelong01",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1205,
		"common/buff/fx_buff_shenyaowangzhenuoya_bd",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1206,
		"common/buff/fx_buff_shenyaowangzhenuoya04_bd",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1207,
		"common/buff/fx_buff_yuanhuang_bd",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1208,
		"common/buff/fx_buff_yuanhuang_bd02",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1209,
		"common/buff/fx_buff_fanerweisijy",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1210,
		"common/buff/fx_buff_fanerweisijy01",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1211,
		"common/buff/fx_buff_yuanchushenglongjy",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1212,
		"common/buff/fx_buff_shenyaoyueyingwang",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1213,
		"common/buff/fx_buff_removehealing",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1214,
		"common/buff/fx_buff_fanerweisi",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1215,
		"common/buff/fx_buff_fanerweisi01",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1216,
		"common/buff/fx_buff_newmianyi",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1217,
		"common/buff/fx_buff_fanerweisizhongzi",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1218,
		"common/buff/fx_buff_fanerweisi01zhongzi",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1219,
		"common/buff/fx_buff_anchaoshenlongbeidong",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1220,
		"common/buff/fx_buff_miukebeidong",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1221,
		"common/buff/fx_buff_minghuangbeidong",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1222,
		"common/buff/fx_buff_shenyaowangzhenuoya06_bd",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1223,
		"common/buff/fx_buff_shenyaolongzunshengzhu",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1224,
		"common/buff/fx_buff_shenyaolongzunshengzhu02",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1225,
		"common/buff/fx_buff_shenyaozhengli",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1226,
		"common/buff/fx_buff_shenyaozhengli02",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1227,
		"common/buff/fx_buff_shenyaowangzhezhixulonghun",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1228,
		"common/buff/fx_buff_shenyaowangzhezhixulonghun02",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1229,
		"common/buff/fx_buff_divinegasirishui",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1230,
		"common/buff/fx_buff_divinegasirihuo",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1231,
		"common/buff/fx_buff_divinegasiricao",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1232,
		"common/buff/fx_buff_longhuangaruisi",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1233,
		"common/buff/fx_buff_wangzhekaya",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1234,
		"common/buff/fx_buff_wuwen",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1235,
		"common/buff/fx_buff_shenyaoqinggu",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1236,
		"common/buff/fx_buff_longhuangaruisi01",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1237,
		"common/buff/fx_buff_fanerweisi02",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1238,
		"common/buff/fx_buff_fanerweisi02zhongzi",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1239,
		"common/buff/fx_buff_fanerweisijy02",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1240,
		"common/buff/fx_buff_yu",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1241,
		"common/buff/fx_buff_yu3",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1242,
		"common/buff/fx_buff_jimo02",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1243,
		"common/buff/fx_buff_luosiwenyi",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1244,
		"common/buff/fx_buff_anmimengli",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1245,
		"common/buff/fx_buff_shenyaofantian02",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1246,
		"common/buff/fx_buff_benyuan",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1247,
		"common/buff/fx_buff_huanlian",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1248,
		"common/buff/fx_buff_huanlian01",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1249,
		"common/buff/fx_buff_honglian",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1250,
		"common/buff/fx_buff_honglian01",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1251,
		"common/buff/fx_buff_heidong",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1252,
		"common/buff/fx_buff_shengmingyuanquan",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1253,
		"common/buff/fx_buff_shenglongbiaoji",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1254,
		"common/buff/fx_buff_zhuiji",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1255,
		"common/buff/fx_buff_zhuiji01",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1256,
		"common/buff/fx_buff_xujiaxinxi",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1257,
		"common/buff/fx_buff_shenyaobaguaxinxi",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1258,
		"common/buff/fx_buff_miansixinxi",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1259,
		"common/buff/fx_buff_xuanwo",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1260,
		"common/buff/fx_buff_zidian",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1261,
		"common/buff/fx_buff_yanjiang",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1262,
		"common/buff/fx_buff_canjinchallenge01",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1263,
		"common/buff/fx_buff_canjinchallenge02",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1264,
		"common/buff/fx_buff_fanerweisi03zhongzi",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1265,
		"common/buff/fx_buff_caijuezhili",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1266,
		"common/buff/fx_buff_shenyaotianshan",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1267,
		"common/buff/fx_buff_shenyaoguanglun",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1268,
		"common/buff/fx_buff_shenyaoliexin",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1269,
		"common/buff/fx_buff_shenyaomizong",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1270,
		"common/buff/fx_buff_shenyaoyanshen",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1271,
		"common/buff/fx_buff_shenyaoyanluo",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1272,
		"common/buff/fx_buff_shenyaolongzunshengzhu03",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1273,
		"common/buff/fx_buff_huanlian03",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1274,
		"common/buff/fx_buff_shenyaotuntianbd",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1275,
		"common/buff/fx_buff_shenyaoguizeniuqu",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1276,
		"common/buff/fx_buff_guizeniuqu03",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1277,
		"common/buff/fx_buff_anchaoshenlongbeidong02",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1278,
		"common/buff/fx_buff_mozhuzhige",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1279,
		"common/buff/fx_buff_jisha",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1280,
		"common/buff/fx_buff_chushouchubei",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1281,
		"common/buff/fx_buff_xiangmoyin",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1282,
		"common/buff/fx_buff_fengmoyin",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1283,
		"common/buff/fx_buff_jiguangjian",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1284,
		"common/buff/fx_buff_jiguangdun",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1285,
		"common/buff/fx_buff_yqfuchou",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1286,
		"common/buff/fx_buff_yqfuchou03",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1287,
		"common/buff/fx_buff_yqzhixulonghun",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1288,
		"common/buff/fx_buff_yqzhixulonghun04",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1289,
		"common/buff/fx_buff_yqwangzhezhixulonghun",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1290,
		"common/buff/fx_buff_yqwangzhezhixulonghun03",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1291,
		"common/buff/fx_buff_yqbojiaqiushilngchixu",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1292,
		"common/buff/fx_buff_yqbojiaqiushilngchixu01",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1293,
		"common/buff/fx_buff_yuanqilongzhupingzhang",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1294,
		"common/buff/fx_buff_yuanqilongzhupingzhang04",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		1295,
		"common/buff/fx_buff_yqbojiaqiushilngchixu03",
		0,
		"hangPoints/center",
		false,
		0
	},
	{
		1296,
		"common/buff/fx_buff_huanlian04",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		1297,
		"common/buff/fx_buff_yuanqicaijuezhili",
		0,
		"hangPoints/head",
		false,
		0
	},
	{
		20003,
		"common/buff/fx_buff_fire_sr",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20004,
		"common/buff/fx_buff_cao_sr",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20005,
		"common/buff/fx_buff_shui_sr",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20006,
		"common/buff/fx_buff_guang_sr",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20007,
		"common/buff/fx_buff_an_sr",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20008,
		"common/buff/fx_buff_shuxing_gongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20009,
		"common/buff/fx_buff_shuxing_fangyu",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20011,
		"common/buff/fx_buff_shuxing_cao_ssr",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20012,
		"common/buff/fx_buff_shuxing_shui_ssr",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20013,
		"common/buff/fx_buff_shuxing_huo_ssr",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20039,
		"common/buff/fx_buff_dishitianyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20040,
		"common/buff/fx_buff_longyanyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20041,
		"common/buff/fx_buff_aruisiyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20042,
		"common/buff/fx_buff_longnvyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20043,
		"common/buff/fx_buff_xinxiyayingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20044,
		"common/buff/fx_buff_tongyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20045,
		"common/buff/fx_buff_mimengliyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20046,
		"common/buff/fx_buff_niumeiyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20047,
		"common/buff/fx_buff_yadiannayingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20048,
		"common/buff/fx_buff_guangtianshiyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20049,
		"common/buff/fx_buff_fantianyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20050,
		"common/buff/fx_buff_longzunyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20051,
		"common/buff/fx_buff_wangxuyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20052,
		"common/buff/fx_buff_liliangshenghunyxj",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20053,
		"common/buff/fx_buff_zhihuishenghunyxj",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20054,
		"common/buff/fx_buff_guanglunyxj",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20055,
		"common/buff/fx_buff_liexinyxj",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20056,
		"common/buff/fx_buff_shengmingshenghunyxj",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20057,
		"common/buff/fx_buff_lounayxj",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20058,
		"common/buff/fx_buff_xiunuoyxj",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20059,
		"common/buff/fx_buff_shifeishenghunyxj",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20060,
		"common/buff/fx_buff_wangzheciyuanlongyxj",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20061,
		"common/buff/fx_buff_yishiyxj",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20062,
		"common/buff/fx_buff_shenyaoshengguangfeilongyxj",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20063,
		"common/buff/fx_buff_yuhuiyxj",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20064,
		"common/buff/fx_buff_huoqilinyxj",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20065,
		"common/buff/fx_buff_shenyaoduolamengmengyxj",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20066,
		"common/buff/fx_buff_wangzhemengmengyxj",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20067,
		"common/buff/fx_buff_konghuangyxj",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20068,
		"common/buff/fx_buff_teshamuyxj",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20069,
		"common/buff/fx_buff_shenyaoaruisiyxj",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20070,
		"common/buff/fx_buff_wangzheji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20071,
		"common/buff/fx_buff_shenyaowangzhenuoya",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20072,
		"common/buff/fx_buff_wangzhenuoya",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20073,
		"common/buff/fx_buff_shenyaowangzhexiuer",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20074,
		"common/buff/fx_buff_anchaoshenlong",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20075,
		"common/buff/fx_buff_wangzheyisa",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20076,
		"common/buff/fx_buff_shenyaolongyan",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20077,
		"common/buff/fx_buff_wangzheshikonglong",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20078,
		"common/buff/fx_buff_shenyaowangzhezhixu",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20079,
		"common/buff/fx_buff_shenyaodishitian",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20080,
		"common/buff/fx_buff_wangzhekayayingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20081,
		"common/buff/fx_buff_qijinuoyayingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20082,
		"common/buff/fx_buff_quantianshiyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20083,
		"common/buff/fx_buff_shenyaoxiunuoyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20084,
		"common/buff/fx_buff_shenyaowangzheciyuanlongyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20085,
		"common/buff/fx_buff_guangandatianshiyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20086,
		"common/buff/fx_buff_shenyaoanshikonglongyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20087,
		"common/buff/fx_buff_longmainuoyayingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20088,
		"common/buff/fx_buff_shenyaofantianyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20089,
		"common/buff/fx_buff_shenyaolounayingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20090,
		"common/buff/fx_buff_wangzhemoyanyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20091,
		"common/buff/fx_buff_wangzhewujinyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20092,
		"common/buff/fx_buff_shenyaomimengliyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20093,
		"common/buff/fx_buff_shenyaowangzhejiyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20094,
		"common/buff/fx_buff_shenyaowangzhenuoyammyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20095,
		"common/buff/fx_buff_shenyaoguanglunyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20096,
		"common/buff/fx_buff_shenyaoliexinyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20097,
		"common/buff/fx_buff_shenyaowangzheyisayingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20098,
		"common/buff/fx_buff_yinzhiyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20099,
		"common/buff/fx_buff_shenyaoyuhuiyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20100,
		"common/buff/fx_buff_yushenyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20101,
		"common/buff/fx_buff_shenyaoteshamuyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20102,
		"common/buff/fx_buff_shenyaowangshiyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20103,
		"common/buff/fx_buff_shenyaoyemengjiadeyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20104,
		"common/buff/fx_buff_shenyaoanwangchaoyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20105,
		"common/buff/fx_buff_yuanqinuoyayingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20106,
		"common/buff/fx_buff_yuanqixiueryingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20107,
		"common/buff/fx_buff_yuanqiwangzheciyuanyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20108,
		"common/buff/fx_buff_yuanqifantianyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20109,
		"common/buff/fx_buff_yuanqilmnuoyayingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20110,
		"common/buff/fx_buff_yuanqiaruisiyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20111,
		"common/buff/fx_buff_yuanqiwangzhekayayingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20112,
		"common/buff/fx_buff_yuanqilongyanyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20113,
		"common/buff/fx_buff_yuanqiwangzhemoyanyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20114,
		"common/buff/fx_buff_yuanqidishitianyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20115,
		"common/buff/fx_buff_yuanqiwangzhezhixuyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20116,
		"common/buff/fx_buff_yuanqiquantianshiyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20117,
		"common/buff/fx_buff_yuanqishikonglongyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20118,
		"common/buff/fx_buff_yuanqiantianshiyingxiongji",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20119,
		"common/buff/fx_buff_yuanqiwangzhemengmeng",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20120,
		"common/buff/fx_buff_yuanqiduolamengmeng",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20121,
		"common/buff/fx_buff_yuanqishengguangfeilong",
		0,
		"hangPoints/foot",
		false,
		0
	},
	{
		20122,
		"common/buff/fx_buff_yuanqimimengli",
		0,
		"hangPoints/foot",
		false,
		0
	}
}
local t_buff_effect = {
	[2] = dataList[1],
	[31] = dataList[2],
	[34] = dataList[3],
	[37] = dataList[4],
	[39] = dataList[5],
	[41] = dataList[6],
	[44] = dataList[7],
	[45] = dataList[8],
	[46] = dataList[9],
	[52] = dataList[10],
	[162] = dataList[11],
	[167] = dataList[12],
	[187] = dataList[13],
	[228] = dataList[14],
	[250] = dataList[15],
	[251] = dataList[16],
	[260] = dataList[17],
	[298] = dataList[18],
	[303] = dataList[19],
	[307] = dataList[20],
	[367] = dataList[21],
	[455] = dataList[22],
	[485] = dataList[23],
	[489] = dataList[24],
	[493] = dataList[25],
	[519] = dataList[26],
	[523] = dataList[27],
	[764] = dataList[28],
	[787] = dataList[29],
	[879] = dataList[30],
	[1001] = dataList[31],
	[1002] = dataList[32],
	[1003] = dataList[33],
	[1004] = dataList[34],
	[1007] = dataList[35],
	[1009] = dataList[36],
	[1055] = dataList[37],
	[1056] = dataList[38],
	[1057] = dataList[39],
	[1058] = dataList[40],
	[1059] = dataList[41],
	[1060] = dataList[42],
	[1061] = dataList[43],
	[1062] = dataList[44],
	[1063] = dataList[45],
	[1064] = dataList[46],
	[1065] = dataList[47],
	[1066] = dataList[48],
	[1067] = dataList[49],
	[1068] = dataList[50],
	[1069] = dataList[51],
	[1070] = dataList[52],
	[1071] = dataList[53],
	[1072] = dataList[54],
	[1073] = dataList[55],
	[1074] = dataList[56],
	[1075] = dataList[57],
	[1076] = dataList[58],
	[1077] = dataList[59],
	[1078] = dataList[60],
	[1079] = dataList[61],
	[1080] = dataList[62],
	[1081] = dataList[63],
	[1082] = dataList[64],
	[1083] = dataList[65],
	[1084] = dataList[66],
	[1085] = dataList[67],
	[1086] = dataList[68],
	[1087] = dataList[69],
	[1088] = dataList[70],
	[1089] = dataList[71],
	[1090] = dataList[72],
	[1091] = dataList[73],
	[1092] = dataList[74],
	[1093] = dataList[75],
	[1094] = dataList[76],
	[1095] = dataList[77],
	[1096] = dataList[78],
	[1097] = dataList[79],
	[1098] = dataList[80],
	[1099] = dataList[81],
	[1100] = dataList[82],
	[1101] = dataList[83],
	[1102] = dataList[84],
	[1103] = dataList[85],
	[1104] = dataList[86],
	[1105] = dataList[87],
	[1106] = dataList[88],
	[1107] = dataList[89],
	[1108] = dataList[90],
	[1109] = dataList[91],
	[1110] = dataList[92],
	[1111] = dataList[93],
	[1112] = dataList[94],
	[1113] = dataList[95],
	[1114] = dataList[96],
	[1115] = dataList[97],
	[1116] = dataList[98],
	[1117] = dataList[99],
	[1118] = dataList[100],
	[1119] = dataList[101],
	[1120] = dataList[102],
	[1121] = dataList[103],
	[1122] = dataList[104],
	[1123] = dataList[105],
	[1124] = dataList[106],
	[1125] = dataList[107],
	[1126] = dataList[108],
	[1127] = dataList[109],
	[1128] = dataList[110],
	[1129] = dataList[111],
	[1130] = dataList[112],
	[1131] = dataList[113],
	[1132] = dataList[114],
	[1133] = dataList[115],
	[1134] = dataList[116],
	[1135] = dataList[117],
	[1136] = dataList[118],
	[1137] = dataList[119],
	[1138] = dataList[120],
	[1139] = dataList[121],
	[1140] = dataList[122],
	[1141] = dataList[123],
	[1142] = dataList[124],
	[1143] = dataList[125],
	[1144] = dataList[126],
	[1145] = dataList[127],
	[1146] = dataList[128],
	[1147] = dataList[129],
	[1148] = dataList[130],
	[1149] = dataList[131],
	[1150] = dataList[132],
	[1151] = dataList[133],
	[1152] = dataList[134],
	[1153] = dataList[135],
	[1154] = dataList[136],
	[1155] = dataList[137],
	[1156] = dataList[138],
	[1157] = dataList[139],
	[1158] = dataList[140],
	[1159] = dataList[141],
	[1160] = dataList[142],
	[1161] = dataList[143],
	[1162] = dataList[144],
	[1163] = dataList[145],
	[1164] = dataList[146],
	[1165] = dataList[147],
	[1166] = dataList[148],
	[1167] = dataList[149],
	[1168] = dataList[150],
	[1169] = dataList[151],
	[1170] = dataList[152],
	[1171] = dataList[153],
	[1172] = dataList[154],
	[1173] = dataList[155],
	[1174] = dataList[156],
	[1175] = dataList[157],
	[1176] = dataList[158],
	[1177] = dataList[159],
	[1178] = dataList[160],
	[1179] = dataList[161],
	[1180] = dataList[162],
	[1181] = dataList[163],
	[1182] = dataList[164],
	[1183] = dataList[165],
	[1184] = dataList[166],
	[1185] = dataList[167],
	[1186] = dataList[168],
	[1187] = dataList[169],
	[1188] = dataList[170],
	[1189] = dataList[171],
	[1190] = dataList[172],
	[1191] = dataList[173],
	[1192] = dataList[174],
	[1193] = dataList[175],
	[1194] = dataList[176],
	[1195] = dataList[177],
	[1196] = dataList[178],
	[1197] = dataList[179],
	[1198] = dataList[180],
	[1199] = dataList[181],
	[1200] = dataList[182],
	[1201] = dataList[183],
	[1202] = dataList[184],
	[1203] = dataList[185],
	[1204] = dataList[186],
	[1205] = dataList[187],
	[1206] = dataList[188],
	[1207] = dataList[189],
	[1208] = dataList[190],
	[1209] = dataList[191],
	[1210] = dataList[192],
	[1211] = dataList[193],
	[1212] = dataList[194],
	[1213] = dataList[195],
	[1214] = dataList[196],
	[1215] = dataList[197],
	[1216] = dataList[198],
	[1217] = dataList[199],
	[1218] = dataList[200],
	[1219] = dataList[201],
	[1220] = dataList[202],
	[1221] = dataList[203],
	[1222] = dataList[204],
	[1223] = dataList[205],
	[1224] = dataList[206],
	[1225] = dataList[207],
	[1226] = dataList[208],
	[1227] = dataList[209],
	[1228] = dataList[210],
	[1229] = dataList[211],
	[1230] = dataList[212],
	[1231] = dataList[213],
	[1232] = dataList[214],
	[1233] = dataList[215],
	[1234] = dataList[216],
	[1235] = dataList[217],
	[1236] = dataList[218],
	[1237] = dataList[219],
	[1238] = dataList[220],
	[1239] = dataList[221],
	[1240] = dataList[222],
	[1241] = dataList[223],
	[1242] = dataList[224],
	[1243] = dataList[225],
	[1244] = dataList[226],
	[1245] = dataList[227],
	[1246] = dataList[228],
	[1247] = dataList[229],
	[1248] = dataList[230],
	[1249] = dataList[231],
	[1250] = dataList[232],
	[1251] = dataList[233],
	[1252] = dataList[234],
	[1253] = dataList[235],
	[1254] = dataList[236],
	[1255] = dataList[237],
	[1256] = dataList[238],
	[1257] = dataList[239],
	[1258] = dataList[240],
	[1259] = dataList[241],
	[1260] = dataList[242],
	[1261] = dataList[243],
	[1262] = dataList[244],
	[1263] = dataList[245],
	[1264] = dataList[246],
	[1265] = dataList[247],
	[1266] = dataList[248],
	[1267] = dataList[249],
	[1268] = dataList[250],
	[1269] = dataList[251],
	[1270] = dataList[252],
	[1271] = dataList[253],
	[1272] = dataList[254],
	[1273] = dataList[255],
	[1274] = dataList[256],
	[1275] = dataList[257],
	[1276] = dataList[258],
	[1277] = dataList[259],
	[1278] = dataList[260],
	[1279] = dataList[261],
	[1280] = dataList[262],
	[1281] = dataList[263],
	[1282] = dataList[264],
	[1283] = dataList[265],
	[1284] = dataList[266],
	[1285] = dataList[267],
	[1286] = dataList[268],
	[1287] = dataList[269],
	[1288] = dataList[270],
	[1289] = dataList[271],
	[1290] = dataList[272],
	[1291] = dataList[273],
	[1292] = dataList[274],
	[1293] = dataList[275],
	[1294] = dataList[276],
	[1295] = dataList[277],
	[1296] = dataList[278],
	[1297] = dataList[279],
	[20003] = dataList[280],
	[20004] = dataList[281],
	[20005] = dataList[282],
	[20006] = dataList[283],
	[20007] = dataList[284],
	[20008] = dataList[285],
	[20009] = dataList[286],
	[20011] = dataList[287],
	[20012] = dataList[288],
	[20013] = dataList[289],
	[20039] = dataList[290],
	[20040] = dataList[291],
	[20041] = dataList[292],
	[20042] = dataList[293],
	[20043] = dataList[294],
	[20044] = dataList[295],
	[20045] = dataList[296],
	[20046] = dataList[297],
	[20047] = dataList[298],
	[20048] = dataList[299],
	[20049] = dataList[300],
	[20050] = dataList[301],
	[20051] = dataList[302],
	[20052] = dataList[303],
	[20053] = dataList[304],
	[20054] = dataList[305],
	[20055] = dataList[306],
	[20056] = dataList[307],
	[20057] = dataList[308],
	[20058] = dataList[309],
	[20059] = dataList[310],
	[20060] = dataList[311],
	[20061] = dataList[312],
	[20062] = dataList[313],
	[20063] = dataList[314],
	[20064] = dataList[315],
	[20065] = dataList[316],
	[20066] = dataList[317],
	[20067] = dataList[318],
	[20068] = dataList[319],
	[20069] = dataList[320],
	[20070] = dataList[321],
	[20071] = dataList[322],
	[20072] = dataList[323],
	[20073] = dataList[324],
	[20074] = dataList[325],
	[20075] = dataList[326],
	[20076] = dataList[327],
	[20077] = dataList[328],
	[20078] = dataList[329],
	[20079] = dataList[330],
	[20080] = dataList[331],
	[20081] = dataList[332],
	[20082] = dataList[333],
	[20083] = dataList[334],
	[20084] = dataList[335],
	[20085] = dataList[336],
	[20086] = dataList[337],
	[20087] = dataList[338],
	[20088] = dataList[339],
	[20089] = dataList[340],
	[20090] = dataList[341],
	[20091] = dataList[342],
	[20092] = dataList[343],
	[20093] = dataList[344],
	[20094] = dataList[345],
	[20095] = dataList[346],
	[20096] = dataList[347],
	[20097] = dataList[348],
	[20098] = dataList[349],
	[20099] = dataList[350],
	[20100] = dataList[351],
	[20101] = dataList[352],
	[20102] = dataList[353],
	[20103] = dataList[354],
	[20104] = dataList[355],
	[20105] = dataList[356],
	[20106] = dataList[357],
	[20107] = dataList[358],
	[20108] = dataList[359],
	[20109] = dataList[360],
	[20110] = dataList[361],
	[20111] = dataList[362],
	[20112] = dataList[363],
	[20113] = dataList[364],
	[20114] = dataList[365],
	[20115] = dataList[366],
	[20116] = dataList[367],
	[20117] = dataList[368],
	[20118] = dataList[369],
	[20119] = dataList[370],
	[20120] = dataList[371],
	[20121] = dataList[372],
	[20122] = dataList[373]
}

t_buff_effect.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_buff_effect
