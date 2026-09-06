-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_moon_shadow_king_challenge_option_group.lua

module("logicconfig.config.t_moon_shadow_king_challenge_option_group", package.seeall)

local title = {
	param = 4,
	name = 7,
	desc = 6,
	type = 3,
	score = 5,
	icon = 8,
	optionId = 2,
	optionGroup = 1
}
local dataList = {
	{
		100001,
		1,
		1,
		"20001059:99",
		200,
		"己方精灵攻击-8%",
		"限制 I",
		"expevents/icon_expedition_guijia01"
	},
	{
		100001,
		2,
		1,
		"20001060:99",
		300,
		"己方精灵攻击-12%",
		"限制 II",
		"expevents/icon_expedition_guijia01"
	},
	{
		100001,
		3,
		1,
		"20001061:99",
		400,
		"己方精灵攻击-16%",
		"限制 III",
		"expevents/icon_expedition_guijia01"
	},
	{
		100002,
		1,
		1,
		"20001071:99",
		200,
		"己方精灵防御-8%",
		"强袭 I",
		"expevents/icon_expedition_guijia"
	},
	{
		100002,
		2,
		1,
		"20001072:99",
		300,
		"己方精灵防御-12%",
		"强袭 II",
		"expevents/icon_expedition_guijia"
	},
	{
		100002,
		3,
		1,
		"20001073:99",
		400,
		"己方精灵防御-16%",
		"强袭 III",
		"expevents/icon_expedition_guijia"
	},
	{
		100003,
		1,
		1,
		"20001074:99",
		200,
		"己方精灵最大生命值-8%",
		"虚弱 I",
		"expevents/icon_expedition_ganran"
	},
	{
		100003,
		2,
		1,
		"20001075:99",
		300,
		"己方精灵最大生命值-12%",
		"虚弱 II",
		"expevents/icon_expedition_ganran"
	},
	{
		100003,
		3,
		1,
		"20001076:99",
		400,
		"己方精灵最大生命值-16%",
		"虚弱 III",
		"expevents/icon_expedition_ganran"
	},
	{
		100004,
		1,
		1,
		"20001062:99",
		200,
		"己方精灵命中率-8%",
		"炫目 I",
		"expevents/icon_expedition_numu01"
	},
	{
		100004,
		2,
		1,
		"20001063:99",
		300,
		"己方精灵命中率-12%",
		"炫目 II",
		"expevents/icon_expedition_numu01"
	},
	{
		100004,
		3,
		1,
		"20001064:99",
		400,
		"己方精灵命中率-16%",
		"炫目 III",
		"expevents/icon_expedition_numu01"
	},
	{
		100005,
		1,
		1,
		"20001065:99",
		200,
		"己方精灵暴击率-8%",
		"怯场 I",
		"expevents/icon_expedition_xueliangtishengshanghai"
	},
	{
		100005,
		2,
		1,
		"20001066:99",
		300,
		"己方精灵暴击率-12%",
		"怯场 II",
		"expevents/icon_expedition_xueliangtishengshanghai"
	},
	{
		100005,
		3,
		1,
		"20001067:99",
		400,
		"己方精灵暴击率-16%",
		"怯场 III",
		"expevents/icon_expedition_xueliangtishengshanghai"
	},
	{
		100006,
		1,
		1,
		"20001077:99",
		200,
		"己方精灵治疗效果-40%",
		"诅咒 I",
		"expevents/icon_expedition_bianyi"
	},
	{
		100006,
		2,
		1,
		"20001078:99",
		300,
		"己方精灵治疗效果-60%",
		"诅咒 II",
		"expevents/icon_expedition_bianyi"
	},
	{
		100006,
		3,
		1,
		"20001079:99",
		400,
		"己方精灵治疗效果-80%",
		"诅咒 III",
		"expevents/icon_expedition_bianyi"
	},
	{
		100007,
		1,
		1,
		"20001080:99",
		200,
		"己方精灵每次被暴击后防御-8%",
		"战损 I",
		"expevents/icon_expedition_yisun01"
	},
	{
		100007,
		2,
		1,
		"20001081:99",
		300,
		"己方精灵每次被暴击后防御-18%",
		"战损 II",
		"expevents/icon_expedition_yisun01"
	},
	{
		100007,
		3,
		1,
		"20001082:99",
		400,
		"己方精灵每次被暴击后防御-24%",
		"战损 III",
		"expevents/icon_expedition_yisun01"
	},
	{
		100008,
		1,
		1,
		"20001068:99",
		200,
		"己方精灵超杀伤害-8%",
		"意志消沉 I",
		"expevents/icon_expedition_liaoxiaojiangdi"
	},
	{
		100008,
		2,
		1,
		"20001069:99",
		300,
		"己方精灵超杀伤害-12%",
		"意志消沉 II",
		"expevents/icon_expedition_liaoxiaojiangdi"
	},
	{
		100008,
		3,
		1,
		"20001070:99",
		400,
		"己方精灵超杀伤害-16%",
		"意志消沉 III",
		"expevents/icon_expedition_liaoxiaojiangdi"
	},
	{
		200001,
		1,
		2,
		"20001001:99",
		200,
		"敌阵精灵攻击+10%",
		"邪力 I",
		"expevents/icon_expedition_wugong4"
	},
	{
		200001,
		2,
		2,
		"20001002:99",
		300,
		"敌阵精灵攻击+15%",
		"邪力 II",
		"expevents/icon_expedition_wugong4"
	},
	{
		200001,
		3,
		2,
		"20001003:99",
		400,
		"敌阵精灵攻击+20%",
		"邪力 III",
		"expevents/icon_expedition_wugong4"
	},
	{
		200002,
		1,
		2,
		"20001031:99",
		200,
		"敌阵精灵防御+10%",
		"屹立 I",
		"expevents/icon_expedition_mofang"
	},
	{
		200002,
		2,
		2,
		"20001032:99",
		300,
		"敌阵精灵防御+15%",
		"屹立 II",
		"expevents/icon_expedition_mofang"
	},
	{
		200002,
		3,
		2,
		"20001033:99",
		400,
		"敌阵精灵防御+20%",
		"屹立 III",
		"expevents/icon_expedition_mofang"
	},
	{
		200003,
		1,
		2,
		"20001034:99",
		200,
		"敌阵精灵最大生命值+10%",
		"长生 I",
		"expevents/icon_expedition_chixue01"
	},
	{
		200003,
		2,
		2,
		"20001035:99",
		300,
		"敌阵精灵最大生命值+15%",
		"长生 II",
		"expevents/icon_expedition_chixue01"
	},
	{
		200003,
		3,
		2,
		"20001036:99",
		400,
		"敌阵精灵最大生命值+20%",
		"长生 III",
		"expevents/icon_expedition_chixue01"
	},
	{
		200004,
		1,
		2,
		"20001022:99",
		200,
		"敌阵精灵命中率+10%",
		"精准 I",
		"expevents/icon_expedition_baojilv"
	},
	{
		200004,
		2,
		2,
		"20001023:99",
		300,
		"敌阵精灵命中率+15%",
		"精准 II",
		"expevents/icon_expedition_baojilv"
	},
	{
		200004,
		3,
		2,
		"20001024:99",
		400,
		"敌阵精灵命中率+20%",
		"精准 III",
		"expevents/icon_expedition_baojilv"
	},
	{
		200005,
		1,
		2,
		"20001007:99",
		200,
		"敌阵精灵暴击率+10%",
		"怒目 I",
		"expevents/icon_expedition_baojilv1"
	},
	{
		200005,
		2,
		2,
		"20001008:99",
		300,
		"敌阵精灵暴击率+15%",
		"怒目 II",
		"expevents/icon_expedition_baojilv1"
	},
	{
		200005,
		3,
		2,
		"20001009:99",
		400,
		"敌阵精灵暴击率+20%",
		"怒目 III",
		"expevents/icon_expedition_baojilv1"
	},
	{
		200006,
		1,
		2,
		"20001049:99",
		200,
		"敌阵精灵闪避率+10%",
		"闪避 I",
		"expevents/icon_expedition_jihuo"
	},
	{
		200006,
		2,
		2,
		"20001050:99",
		300,
		"敌阵精灵闪避率+15%",
		"闪避 II",
		"expevents/icon_expedition_jihuo"
	},
	{
		200006,
		3,
		2,
		"20001051:99",
		400,
		"敌阵精灵闪避率+20%",
		"闪避 III",
		"expevents/icon_expedition_jihuo"
	},
	{
		200007,
		1,
		2,
		"20001025:99",
		200,
		"敌阵精灵无视防御8%",
		"易损 I",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		200007,
		2,
		2,
		"20001026:99",
		300,
		"敌阵精灵无视防御12%",
		"易损 II",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		200007,
		3,
		2,
		"20001027:99",
		400,
		"敌阵精灵无视防御16%",
		"易损 III",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		200008,
		1,
		2,
		"20001019:99",
		200,
		"敌阵精灵属性克制时伤害+10%",
		"精通 I",
		"expevents/icon_expedition_kezhizengqiang"
	},
	{
		200008,
		2,
		2,
		"20001020:99",
		300,
		"敌阵精灵属性克制时伤害+15%",
		"精通 II",
		"expevents/icon_expedition_kezhizengqiang"
	},
	{
		200008,
		3,
		2,
		"20001021:99",
		400,
		"敌阵精灵属性克制时伤害+20%",
		"精通 III",
		"expevents/icon_expedition_kezhizengqiang"
	},
	{
		200009,
		1,
		2,
		"20001010:99",
		200,
		"敌阵精灵超杀伤害+10%",
		"杀意 I",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		200009,
		2,
		2,
		"20001011:99",
		300,
		"敌阵精灵超杀伤害+15%",
		"杀意 II",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		200009,
		3,
		2,
		"20001012:99",
		400,
		"敌阵精灵超杀伤害+20%",
		"杀意 III",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		200010,
		1,
		2,
		"20001037:99",
		200,
		"敌阵精灵在超杀后恢复自身最大生命值20%",
		"嗜血 I",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		200010,
		2,
		2,
		"20001039:99",
		300,
		"敌阵精灵在超杀后恢复自身最大生命值30%",
		"嗜血 II",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		200010,
		3,
		2,
		"20001041:99",
		400,
		"敌阵精灵在超杀后恢复自身最大生命值40%",
		"嗜血 III",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		200011,
		1,
		2,
		"20001013:99",
		200,
		"敌阵每有一只精灵死亡，敌阵其余精灵攻击+5%",
		"变异 I",
		"expevents/icon_expedition_bianyi01"
	},
	{
		200011,
		2,
		2,
		"20001014:99",
		300,
		"敌阵每有一只精灵死亡，敌阵其余精灵攻击+8%",
		"变异 II",
		"expevents/icon_expedition_bianyi01"
	},
	{
		200011,
		3,
		2,
		"20001015:99",
		400,
		"敌阵每有一只精灵死亡，敌阵其余精灵攻击+10%",
		"变异 III",
		"expevents/icon_expedition_bianyi01"
	},
	{
		200012,
		1,
		2,
		"20001043:99",
		200,
		"敌阵每有一只精灵死亡，敌阵其余精灵防御+5%",
		"抵抗 I",
		"expevents/icon_expedition_buqu"
	},
	{
		200012,
		2,
		2,
		"20001044:99",
		300,
		"敌阵每有一只精灵死亡，敌阵其余精灵防御+8%",
		"抵抗 II",
		"expevents/icon_expedition_buqu"
	},
	{
		200012,
		3,
		2,
		"20001045:99",
		400,
		"敌阵每有一只精灵死亡，敌阵其余精灵防御+10%",
		"抵抗 III",
		"expevents/icon_expedition_buqu"
	},
	{
		200013,
		1,
		2,
		"20001086:99",
		400,
		"必须在4回合内结束战斗",
		"速攻 I",
		"expevents/icon_expedition_zhuiji"
	},
	{
		200013,
		2,
		2,
		"20001087:99",
		800,
		"必须在3回合内结束战斗",
		"速攻 II",
		"expevents/icon_expedition_zhuiji"
	},
	{
		200013,
		3,
		2,
		"20001088:99",
		1200,
		"必须在2回合内结束战斗",
		"速攻 III",
		"expevents/icon_expedition_zhuiji"
	},
	{
		200014,
		1,
		2,
		"20001028:99",
		400,
		"敌方精灵开局气势+80",
		"气势 I",
		"expevents/icon_expedition_yadao01"
	},
	{
		200014,
		2,
		2,
		"20001029:99",
		800,
		"敌方精灵开局气势+100",
		"气势 II",
		"expevents/icon_expedition_yadao01"
	},
	{
		200014,
		3,
		2,
		"20001030:99",
		1200,
		"敌方精灵开局气势+150",
		"气势 III",
		"expevents/icon_expedition_yadao01"
	},
	{
		300001,
		1,
		2,
		"20001001:99",
		20,
		"敌阵精灵攻击+10%",
		"邪力 I",
		"expevents/icon_expedition_wugong4"
	},
	{
		300001,
		2,
		2,
		"20001002:99",
		40,
		"敌阵精灵攻击+15%",
		"邪力 II",
		"expevents/icon_expedition_wugong4"
	},
	{
		300001,
		3,
		2,
		"20001003:99",
		60,
		"敌阵精灵攻击+20%",
		"邪力 III",
		"expevents/icon_expedition_wugong4"
	},
	{
		300002,
		1,
		2,
		"20001022:99",
		20,
		"敌阵精灵命中率+10%",
		"精准 I",
		"expevents/icon_expedition_baojilv"
	},
	{
		300002,
		2,
		2,
		"20001023:99",
		40,
		"敌阵精灵命中率+15%",
		"精准 II",
		"expevents/icon_expedition_baojilv"
	},
	{
		300002,
		3,
		2,
		"20001024:99",
		60,
		"敌阵精灵命中率+20%",
		"精准 III",
		"expevents/icon_expedition_baojilv"
	},
	{
		300003,
		1,
		2,
		"20001001:99",
		20,
		"敌阵精灵攻击+10%",
		"邪力 I",
		"expevents/icon_expedition_wugong4"
	},
	{
		300003,
		2,
		2,
		"20001002:99",
		40,
		"敌阵精灵攻击+15%",
		"邪力 II",
		"expevents/icon_expedition_wugong4"
	},
	{
		300003,
		3,
		2,
		"20001003:99",
		60,
		"敌阵精灵攻击+20%",
		"邪力 III",
		"expevents/icon_expedition_wugong4"
	},
	{
		300004,
		1,
		2,
		"20001022:99",
		20,
		"敌阵精灵命中率+10%",
		"精准 I",
		"expevents/icon_expedition_baojilv"
	},
	{
		300004,
		2,
		2,
		"20001023:99",
		40,
		"敌阵精灵命中率+15%",
		"精准 II",
		"expevents/icon_expedition_baojilv"
	},
	{
		300004,
		3,
		2,
		"20001024:99",
		60,
		"敌阵精灵命中率+20%",
		"精准 III",
		"expevents/icon_expedition_baojilv"
	},
	{
		300005,
		1,
		2,
		"20001034:99",
		20,
		"敌阵精灵最大生命值+10%",
		"长生 I",
		"expevents/icon_expedition_chixue01"
	},
	{
		300005,
		2,
		2,
		"20001035:99",
		40,
		"敌阵精灵最大生命值+15%",
		"长生 II",
		"expevents/icon_expedition_chixue01"
	},
	{
		300005,
		3,
		2,
		"20001036:99",
		60,
		"敌阵精灵最大生命值+20%",
		"长生 III",
		"expevents/icon_expedition_chixue01"
	},
	{
		300006,
		1,
		2,
		"20001001:99",
		20,
		"敌阵精灵攻击+10%",
		"邪力 I",
		"expevents/icon_expedition_wugong4"
	},
	{
		300006,
		2,
		2,
		"20001002:99",
		40,
		"敌阵精灵攻击+15%",
		"邪力 II",
		"expevents/icon_expedition_wugong4"
	},
	{
		300006,
		3,
		2,
		"20001003:99",
		60,
		"敌阵精灵攻击+20%",
		"邪力 III",
		"expevents/icon_expedition_wugong4"
	},
	{
		300007,
		1,
		2,
		"20001034:99",
		20,
		"敌阵精灵最大生命值+10%",
		"长生 I",
		"expevents/icon_expedition_chixue01"
	},
	{
		300007,
		2,
		2,
		"20001035:99",
		40,
		"敌阵精灵最大生命值+15%",
		"长生 II",
		"expevents/icon_expedition_chixue01"
	},
	{
		300007,
		3,
		2,
		"20001036:99",
		60,
		"敌阵精灵最大生命值+20%",
		"长生 III",
		"expevents/icon_expedition_chixue01"
	},
	{
		300008,
		1,
		2,
		"20001031:99",
		20,
		"敌阵精灵防御+10%",
		"屹立 I",
		"expevents/icon_expedition_mofang"
	},
	{
		300008,
		2,
		2,
		"20001032:99",
		40,
		"敌阵精灵防御+15%",
		"屹立 II",
		"expevents/icon_expedition_mofang"
	},
	{
		300008,
		3,
		2,
		"20001033:99",
		60,
		"敌阵精灵防御+20%",
		"屹立 III",
		"expevents/icon_expedition_mofang"
	},
	{
		300009,
		1,
		2,
		"20001007:99",
		20,
		"敌阵精灵暴击率+10%",
		"怒目 I",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300009,
		2,
		2,
		"20001008:99",
		40,
		"敌阵精灵暴击率+15%",
		"怒目 II",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300009,
		3,
		2,
		"20001009:99",
		60,
		"敌阵精灵暴击率+20%",
		"怒目 III",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300010,
		1,
		2,
		"20001001:99",
		20,
		"敌阵精灵攻击+10%",
		"邪力 I",
		"expevents/icon_expedition_wugong4"
	},
	{
		300010,
		2,
		2,
		"20001002:99",
		40,
		"敌阵精灵攻击+15%",
		"邪力 II",
		"expevents/icon_expedition_wugong4"
	},
	{
		300010,
		3,
		2,
		"20001003:99",
		60,
		"敌阵精灵攻击+20%",
		"邪力 III",
		"expevents/icon_expedition_wugong4"
	},
	{
		300011,
		1,
		2,
		"20001034:99",
		20,
		"敌阵精灵最大生命值+10%",
		"长生 I",
		"expevents/icon_expedition_chixue01"
	},
	{
		300011,
		2,
		2,
		"20001035:99",
		40,
		"敌阵精灵最大生命值+15%",
		"长生 II",
		"expevents/icon_expedition_chixue01"
	},
	{
		300011,
		3,
		2,
		"20001036:99",
		60,
		"敌阵精灵最大生命值+20%",
		"长生 III",
		"expevents/icon_expedition_chixue01"
	},
	{
		300012,
		1,
		2,
		"20001031:99",
		20,
		"敌阵精灵防御+10%",
		"屹立 I",
		"expevents/icon_expedition_mofang"
	},
	{
		300012,
		2,
		2,
		"20001032:99",
		40,
		"敌阵精灵防御+15%",
		"屹立 II",
		"expevents/icon_expedition_mofang"
	},
	{
		300012,
		3,
		2,
		"20001033:99",
		60,
		"敌阵精灵防御+20%",
		"屹立 III",
		"expevents/icon_expedition_mofang"
	},
	{
		300013,
		1,
		2,
		"20001007:99",
		20,
		"敌阵精灵暴击率+10%",
		"怒目 I",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300013,
		2,
		2,
		"20001008:99",
		40,
		"敌阵精灵暴击率+15%",
		"怒目 II",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300013,
		3,
		2,
		"20001009:99",
		60,
		"敌阵精灵暴击率+20%",
		"怒目 III",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300014,
		1,
		2,
		"20001049:99",
		20,
		"敌阵精灵闪避率+10%",
		"闪避 I",
		"expevents/icon_expedition_jihuo"
	},
	{
		300014,
		2,
		2,
		"20001050:99",
		40,
		"敌阵精灵闪避率+15%",
		"闪避 II",
		"expevents/icon_expedition_jihuo"
	},
	{
		300014,
		3,
		2,
		"20001051:99",
		60,
		"敌阵精灵闪避率+20%",
		"闪避 III",
		"expevents/icon_expedition_jihuo"
	},
	{
		300015,
		1,
		2,
		"20001025:99",
		30,
		"敌阵精灵无视防御8%",
		"易损 I",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		300015,
		2,
		2,
		"20001026:99",
		60,
		"敌阵精灵无视防御12%",
		"易损 II",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		300015,
		3,
		2,
		"20001027:99",
		90,
		"敌阵精灵无视防御16%",
		"易损 III",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		300016,
		1,
		2,
		"20001001:99",
		20,
		"敌阵精灵攻击+10%",
		"邪力 I",
		"expevents/icon_expedition_wugong4"
	},
	{
		300016,
		2,
		2,
		"20001002:99",
		40,
		"敌阵精灵攻击+15%",
		"邪力 II",
		"expevents/icon_expedition_wugong4"
	},
	{
		300016,
		3,
		2,
		"20001003:99",
		60,
		"敌阵精灵攻击+20%",
		"邪力 III",
		"expevents/icon_expedition_wugong4"
	},
	{
		300017,
		1,
		2,
		"20001034:99",
		20,
		"敌阵精灵最大生命值+10%",
		"长生 I",
		"expevents/icon_expedition_chixue01"
	},
	{
		300017,
		2,
		2,
		"20001035:99",
		40,
		"敌阵精灵最大生命值+15%",
		"长生 II",
		"expevents/icon_expedition_chixue01"
	},
	{
		300017,
		3,
		2,
		"20001036:99",
		60,
		"敌阵精灵最大生命值+20%",
		"长生 III",
		"expevents/icon_expedition_chixue01"
	},
	{
		300018,
		1,
		2,
		"20001031:99",
		20,
		"敌阵精灵防御+10%",
		"屹立 I",
		"expevents/icon_expedition_mofang"
	},
	{
		300018,
		2,
		2,
		"20001032:99",
		40,
		"敌阵精灵防御+15%",
		"屹立 II",
		"expevents/icon_expedition_mofang"
	},
	{
		300018,
		3,
		2,
		"20001033:99",
		60,
		"敌阵精灵防御+20%",
		"屹立 III",
		"expevents/icon_expedition_mofang"
	},
	{
		300019,
		1,
		2,
		"20001007:99",
		20,
		"敌阵精灵暴击率+10%",
		"怒目 I",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300019,
		2,
		2,
		"20001008:99",
		40,
		"敌阵精灵暴击率+15%",
		"怒目 II",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300019,
		3,
		2,
		"20001009:99",
		60,
		"敌阵精灵暴击率+20%",
		"怒目 III",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300020,
		1,
		2,
		"20001049:99",
		20,
		"敌阵精灵闪避率+10%",
		"闪避 I",
		"expevents/icon_expedition_jihuo"
	},
	{
		300020,
		2,
		2,
		"20001050:99",
		40,
		"敌阵精灵闪避率+15%",
		"闪避 II",
		"expevents/icon_expedition_jihuo"
	},
	{
		300020,
		3,
		2,
		"20001051:99",
		60,
		"敌阵精灵闪避率+20%",
		"闪避 III",
		"expevents/icon_expedition_jihuo"
	},
	{
		300021,
		1,
		2,
		"20001025:99",
		30,
		"敌阵精灵无视防御8%",
		"易损 I",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		300021,
		2,
		2,
		"20001026:99",
		60,
		"敌阵精灵无视防御12%",
		"易损 II",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		300021,
		3,
		2,
		"20001027:99",
		90,
		"敌阵精灵无视防御16%",
		"易损 III",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		300022,
		1,
		2,
		"20001019:99",
		30,
		"敌阵精灵属性克制时伤害+10%",
		"精通 I",
		"expevents/icon_expedition_kezhizengqiang"
	},
	{
		300022,
		2,
		2,
		"20001020:99",
		60,
		"敌阵精灵属性克制时伤害+15%",
		"精通 II",
		"expevents/icon_expedition_kezhizengqiang"
	},
	{
		300022,
		3,
		2,
		"20001021:99",
		90,
		"敌阵精灵属性克制时伤害+20%",
		"精通 III",
		"expevents/icon_expedition_kezhizengqiang"
	},
	{
		300023,
		1,
		2,
		"20001010:99",
		30,
		"敌阵精灵超杀伤害+10%",
		"杀意 I",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		300023,
		2,
		2,
		"20001011:99",
		60,
		"敌阵精灵超杀伤害+15%",
		"杀意 II",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		300023,
		3,
		2,
		"20001012:99",
		90,
		"敌阵精灵超杀伤害+20%",
		"杀意 III",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		300024,
		1,
		2,
		"20001001:99",
		20,
		"敌阵精灵攻击+10%",
		"邪力 I",
		"expevents/icon_expedition_wugong4"
	},
	{
		300024,
		2,
		2,
		"20001002:99",
		40,
		"敌阵精灵攻击+15%",
		"邪力 II",
		"expevents/icon_expedition_wugong4"
	},
	{
		300024,
		3,
		2,
		"20001003:99",
		60,
		"敌阵精灵攻击+20%",
		"邪力 III",
		"expevents/icon_expedition_wugong4"
	},
	{
		300025,
		1,
		2,
		"20001034:99",
		20,
		"敌阵精灵最大生命值+10%",
		"长生 I",
		"expevents/icon_expedition_chixue01"
	},
	{
		300025,
		2,
		2,
		"20001035:99",
		40,
		"敌阵精灵最大生命值+15%",
		"长生 II",
		"expevents/icon_expedition_chixue01"
	},
	{
		300025,
		3,
		2,
		"20001036:99",
		60,
		"敌阵精灵最大生命值+20%",
		"长生 III",
		"expevents/icon_expedition_chixue01"
	},
	{
		300026,
		1,
		2,
		"20001031:99",
		20,
		"敌阵精灵防御+10%",
		"屹立 I",
		"expevents/icon_expedition_mofang"
	},
	{
		300026,
		2,
		2,
		"20001032:99",
		40,
		"敌阵精灵防御+15%",
		"屹立 II",
		"expevents/icon_expedition_mofang"
	},
	{
		300026,
		3,
		2,
		"20001033:99",
		60,
		"敌阵精灵防御+20%",
		"屹立 III",
		"expevents/icon_expedition_mofang"
	},
	{
		300027,
		1,
		2,
		"20001007:99",
		20,
		"敌阵精灵暴击率+10%",
		"怒目 I",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300027,
		2,
		2,
		"20001008:99",
		40,
		"敌阵精灵暴击率+15%",
		"怒目 II",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300027,
		3,
		2,
		"20001009:99",
		60,
		"敌阵精灵暴击率+20%",
		"怒目 III",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300028,
		1,
		2,
		"20001049:99",
		20,
		"敌阵精灵闪避率+10%",
		"闪避 I",
		"expevents/icon_expedition_jihuo"
	},
	{
		300028,
		2,
		2,
		"20001050:99",
		40,
		"敌阵精灵闪避率+15%",
		"闪避 II",
		"expevents/icon_expedition_jihuo"
	},
	{
		300028,
		3,
		2,
		"20001051:99",
		60,
		"敌阵精灵闪避率+20%",
		"闪避 III",
		"expevents/icon_expedition_jihuo"
	},
	{
		300029,
		1,
		2,
		"20001028:99",
		30,
		"敌方精灵开局气势+80",
		"气势 I",
		"expevents/icon_expedition_yadao01"
	},
	{
		300029,
		2,
		2,
		"20001029:99",
		60,
		"敌方精灵开局气势+100",
		"气势 II",
		"expevents/icon_expedition_yadao01"
	},
	{
		300029,
		3,
		2,
		"20001030:99",
		90,
		"敌方精灵开局气势+150",
		"气势 III",
		"expevents/icon_expedition_yadao01"
	},
	{
		300030,
		1,
		2,
		"20001001:99",
		20,
		"敌阵精灵攻击+10%",
		"邪力 I",
		"expevents/icon_expedition_wugong4"
	},
	{
		300030,
		2,
		2,
		"20001002:99",
		40,
		"敌阵精灵攻击+15%",
		"邪力 II",
		"expevents/icon_expedition_wugong4"
	},
	{
		300030,
		3,
		2,
		"20001003:99",
		60,
		"敌阵精灵攻击+20%",
		"邪力 III",
		"expevents/icon_expedition_wugong4"
	},
	{
		300031,
		1,
		2,
		"20001034:99",
		20,
		"敌阵精灵最大生命值+10%",
		"长生 I",
		"expevents/icon_expedition_chixue01"
	},
	{
		300031,
		2,
		2,
		"20001035:99",
		40,
		"敌阵精灵最大生命值+15%",
		"长生 II",
		"expevents/icon_expedition_chixue01"
	},
	{
		300031,
		3,
		2,
		"20001036:99",
		60,
		"敌阵精灵最大生命值+20%",
		"长生 III",
		"expevents/icon_expedition_chixue01"
	},
	{
		300032,
		1,
		2,
		"20001031:99",
		20,
		"敌阵精灵防御+10%",
		"屹立 I",
		"expevents/icon_expedition_mofang"
	},
	{
		300032,
		2,
		2,
		"20001032:99",
		40,
		"敌阵精灵防御+15%",
		"屹立 II",
		"expevents/icon_expedition_mofang"
	},
	{
		300032,
		3,
		2,
		"20001033:99",
		60,
		"敌阵精灵防御+20%",
		"屹立 III",
		"expevents/icon_expedition_mofang"
	},
	{
		300033,
		1,
		2,
		"20001007:99",
		20,
		"敌阵精灵暴击率+10%",
		"怒目 I",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300033,
		2,
		2,
		"20001008:99",
		40,
		"敌阵精灵暴击率+15%",
		"怒目 II",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300033,
		3,
		2,
		"20001009:99",
		60,
		"敌阵精灵暴击率+20%",
		"怒目 III",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300034,
		1,
		2,
		"20001049:99",
		20,
		"敌阵精灵闪避率+10%",
		"闪避 I",
		"expevents/icon_expedition_jihuo"
	},
	{
		300034,
		2,
		2,
		"20001050:99",
		40,
		"敌阵精灵闪避率+15%",
		"闪避 II",
		"expevents/icon_expedition_jihuo"
	},
	{
		300034,
		3,
		2,
		"20001051:99",
		60,
		"敌阵精灵闪避率+20%",
		"闪避 III",
		"expevents/icon_expedition_jihuo"
	},
	{
		300035,
		1,
		2,
		"20001028:99",
		30,
		"敌方精灵开局气势+80",
		"气势 I",
		"expevents/icon_expedition_yadao01"
	},
	{
		300035,
		2,
		2,
		"20001029:99",
		60,
		"敌方精灵开局气势+100",
		"气势 II",
		"expevents/icon_expedition_yadao01"
	},
	{
		300035,
		3,
		2,
		"20001030:99",
		90,
		"敌方精灵开局气势+150",
		"气势 III",
		"expevents/icon_expedition_yadao01"
	},
	{
		300036,
		1,
		2,
		"20001013:99",
		30,
		"敌阵每有一只精灵死亡，敌阵其余精灵攻击+5%",
		"变异 I",
		"expevents/icon_expedition_bianyi01"
	},
	{
		300036,
		2,
		2,
		"20001014:99",
		60,
		"敌阵每有一只精灵死亡，敌阵其余精灵攻击+8%",
		"变异 II",
		"expevents/icon_expedition_bianyi01"
	},
	{
		300036,
		3,
		2,
		"20001015:99",
		90,
		"敌阵每有一只精灵死亡，敌阵其余精灵攻击+10%",
		"变异 III",
		"expevents/icon_expedition_bianyi01"
	},
	{
		300037,
		1,
		2,
		"20001043:99",
		30,
		"敌阵每有一只精灵死亡，敌阵其余精灵防御+5%",
		"抵抗 I",
		"expevents/icon_expedition_buqu"
	},
	{
		300037,
		2,
		2,
		"20001044:99",
		60,
		"敌阵每有一只精灵死亡，敌阵其余精灵防御+8%",
		"抵抗 II",
		"expevents/icon_expedition_buqu"
	},
	{
		300037,
		3,
		2,
		"20001045:99",
		90,
		"敌阵每有一只精灵死亡，敌阵其余精灵防御+10%",
		"抵抗 III",
		"expevents/icon_expedition_buqu"
	},
	{
		300038,
		1,
		2,
		"20001001:99",
		10,
		"敌阵精灵攻击+10%",
		"邪力 I",
		"expevents/icon_expedition_wugong4"
	},
	{
		300038,
		2,
		2,
		"20001002:99",
		20,
		"敌阵精灵攻击+15%",
		"邪力 II",
		"expevents/icon_expedition_wugong4"
	},
	{
		300038,
		3,
		2,
		"20001003:99",
		30,
		"敌阵精灵攻击+20%",
		"邪力 III",
		"expevents/icon_expedition_wugong4"
	},
	{
		300039,
		1,
		2,
		"20001034:99",
		10,
		"敌阵精灵最大生命值+10%",
		"长生 I",
		"expevents/icon_expedition_chixue01"
	},
	{
		300039,
		2,
		2,
		"20001035:99",
		20,
		"敌阵精灵最大生命值+15%",
		"长生 II",
		"expevents/icon_expedition_chixue01"
	},
	{
		300039,
		3,
		2,
		"20001036:99",
		30,
		"敌阵精灵最大生命值+20%",
		"长生 III",
		"expevents/icon_expedition_chixue01"
	},
	{
		300040,
		1,
		2,
		"20001031:99",
		10,
		"敌阵精灵防御+10%",
		"屹立 I",
		"expevents/icon_expedition_mofang"
	},
	{
		300040,
		2,
		2,
		"20001032:99",
		20,
		"敌阵精灵防御+15%",
		"屹立 II",
		"expevents/icon_expedition_mofang"
	},
	{
		300040,
		3,
		2,
		"20001033:99",
		30,
		"敌阵精灵防御+20%",
		"屹立 III",
		"expevents/icon_expedition_mofang"
	},
	{
		300041,
		1,
		2,
		"20001007:99",
		10,
		"敌阵精灵暴击率+10%",
		"怒目 I",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300041,
		2,
		2,
		"20001008:99",
		20,
		"敌阵精灵暴击率+15%",
		"怒目 II",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300041,
		3,
		2,
		"20001009:99",
		30,
		"敌阵精灵暴击率+20%",
		"怒目 III",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300042,
		1,
		2,
		"20001049:99",
		10,
		"敌阵精灵闪避率+10%",
		"闪避 I",
		"expevents/icon_expedition_jihuo"
	},
	{
		300042,
		2,
		2,
		"20001050:99",
		20,
		"敌阵精灵闪避率+15%",
		"闪避 II",
		"expevents/icon_expedition_jihuo"
	},
	{
		300042,
		3,
		2,
		"20001051:99",
		30,
		"敌阵精灵闪避率+20%",
		"闪避 III",
		"expevents/icon_expedition_jihuo"
	},
	{
		300043,
		1,
		2,
		"20001086:99",
		80,
		"必须在4回合内结束战斗",
		"速攻 I",
		"expevents/icon_expedition_zhuiji"
	},
	{
		300043,
		2,
		2,
		"20001087:99",
		160,
		"必须在3回合内结束战斗",
		"速攻 II",
		"expevents/icon_expedition_zhuiji"
	},
	{
		300043,
		3,
		2,
		"20001088:99",
		240,
		"必须在2回合内结束战斗",
		"速攻 III",
		"expevents/icon_expedition_zhuiji"
	},
	{
		300044,
		1,
		2,
		"20001001:99",
		10,
		"敌阵精灵攻击+10%",
		"邪力 I",
		"expevents/icon_expedition_wugong4"
	},
	{
		300044,
		2,
		2,
		"20001002:99",
		20,
		"敌阵精灵攻击+15%",
		"邪力 II",
		"expevents/icon_expedition_wugong4"
	},
	{
		300044,
		3,
		2,
		"20001003:99",
		30,
		"敌阵精灵攻击+20%",
		"邪力 III",
		"expevents/icon_expedition_wugong4"
	},
	{
		300045,
		1,
		2,
		"20001034:99",
		10,
		"敌阵精灵最大生命值+10%",
		"长生 I",
		"expevents/icon_expedition_chixue01"
	},
	{
		300045,
		2,
		2,
		"20001035:99",
		20,
		"敌阵精灵最大生命值+15%",
		"长生 II",
		"expevents/icon_expedition_chixue01"
	},
	{
		300045,
		3,
		2,
		"20001036:99",
		30,
		"敌阵精灵最大生命值+20%",
		"长生 III",
		"expevents/icon_expedition_chixue01"
	},
	{
		300046,
		1,
		2,
		"20001031:99",
		10,
		"敌阵精灵防御+10%",
		"屹立 I",
		"expevents/icon_expedition_mofang"
	},
	{
		300046,
		2,
		2,
		"20001032:99",
		20,
		"敌阵精灵防御+15%",
		"屹立 II",
		"expevents/icon_expedition_mofang"
	},
	{
		300046,
		3,
		2,
		"20001033:99",
		30,
		"敌阵精灵防御+20%",
		"屹立 III",
		"expevents/icon_expedition_mofang"
	},
	{
		300047,
		1,
		2,
		"20001007:99",
		10,
		"敌阵精灵暴击率+10%",
		"怒目 I",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300047,
		2,
		2,
		"20001008:99",
		20,
		"敌阵精灵暴击率+15%",
		"怒目 II",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300047,
		3,
		2,
		"20001009:99",
		30,
		"敌阵精灵暴击率+20%",
		"怒目 III",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300048,
		1,
		2,
		"20001049:99",
		10,
		"敌阵精灵闪避率+10%",
		"闪避 I",
		"expevents/icon_expedition_jihuo"
	},
	{
		300048,
		2,
		2,
		"20001050:99",
		20,
		"敌阵精灵闪避率+15%",
		"闪避 II",
		"expevents/icon_expedition_jihuo"
	},
	{
		300048,
		3,
		2,
		"20001051:99",
		30,
		"敌阵精灵闪避率+20%",
		"闪避 III",
		"expevents/icon_expedition_jihuo"
	},
	{
		300049,
		1,
		2,
		"20001010:99",
		30,
		"敌阵精灵超杀伤害+10%",
		"杀意 I",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		300049,
		2,
		2,
		"20001011:99",
		60,
		"敌阵精灵超杀伤害+15%",
		"杀意 II",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		300049,
		3,
		2,
		"20001012:99",
		90,
		"敌阵精灵超杀伤害+20%",
		"杀意 III",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		300050,
		1,
		2,
		"20001086:99",
		80,
		"必须在4回合内结束战斗",
		"速攻 I",
		"expevents/icon_expedition_zhuiji"
	},
	{
		300050,
		2,
		2,
		"20001087:99",
		160,
		"必须在3回合内结束战斗",
		"速攻 II",
		"expevents/icon_expedition_zhuiji"
	},
	{
		300050,
		3,
		2,
		"20001088:99",
		240,
		"必须在2回合内结束战斗",
		"速攻 III",
		"expevents/icon_expedition_zhuiji"
	},
	{
		300051,
		1,
		2,
		"20001037:99",
		30,
		"敌阵精灵在超杀后恢复自身最大生命值20%",
		"嗜血 I",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		300051,
		2,
		2,
		"20001039:99",
		60,
		"敌阵精灵在超杀后恢复自身最大生命值30%",
		"嗜血 II",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		300051,
		3,
		2,
		"20001041:99",
		90,
		"敌阵精灵在超杀后恢复自身最大生命值40%",
		"嗜血 III",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		300052,
		1,
		2,
		"20001001:99",
		10,
		"敌阵精灵攻击+10%",
		"邪力 I",
		"expevents/icon_expedition_wugong4"
	},
	{
		300052,
		2,
		2,
		"20001002:99",
		20,
		"敌阵精灵攻击+15%",
		"邪力 II",
		"expevents/icon_expedition_wugong4"
	},
	{
		300052,
		3,
		2,
		"20001003:99",
		30,
		"敌阵精灵攻击+20%",
		"邪力 III",
		"expevents/icon_expedition_wugong4"
	},
	{
		300053,
		1,
		2,
		"20001034:99",
		10,
		"敌阵精灵最大生命值+10%",
		"长生 I",
		"expevents/icon_expedition_chixue01"
	},
	{
		300053,
		2,
		2,
		"20001035:99",
		20,
		"敌阵精灵最大生命值+15%",
		"长生 II",
		"expevents/icon_expedition_chixue01"
	},
	{
		300053,
		3,
		2,
		"20001036:99",
		30,
		"敌阵精灵最大生命值+20%",
		"长生 III",
		"expevents/icon_expedition_chixue01"
	},
	{
		300054,
		1,
		2,
		"20001031:99",
		10,
		"敌阵精灵防御+10%",
		"屹立 I",
		"expevents/icon_expedition_mofang"
	},
	{
		300054,
		2,
		2,
		"20001032:99",
		20,
		"敌阵精灵防御+15%",
		"屹立 II",
		"expevents/icon_expedition_mofang"
	},
	{
		300054,
		3,
		2,
		"20001033:99",
		30,
		"敌阵精灵防御+20%",
		"屹立 III",
		"expevents/icon_expedition_mofang"
	},
	{
		300055,
		1,
		2,
		"20001007:99",
		10,
		"敌阵精灵暴击率+10%",
		"怒目 I",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300055,
		2,
		2,
		"20001008:99",
		20,
		"敌阵精灵暴击率+15%",
		"怒目 II",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300055,
		3,
		2,
		"20001009:99",
		30,
		"敌阵精灵暴击率+20%",
		"怒目 III",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300056,
		1,
		2,
		"20001049:99",
		10,
		"敌阵精灵闪避率+10%",
		"闪避 I",
		"expevents/icon_expedition_jihuo"
	},
	{
		300056,
		2,
		2,
		"20001050:99",
		20,
		"敌阵精灵闪避率+15%",
		"闪避 II",
		"expevents/icon_expedition_jihuo"
	},
	{
		300056,
		3,
		2,
		"20001051:99",
		30,
		"敌阵精灵闪避率+20%",
		"闪避 III",
		"expevents/icon_expedition_jihuo"
	},
	{
		300057,
		1,
		2,
		"20001028:99",
		80,
		"敌方精灵开局气势+80",
		"气势 I",
		"expevents/icon_expedition_yadao01"
	},
	{
		300057,
		2,
		2,
		"20001029:99",
		160,
		"敌方精灵开局气势+100",
		"气势 II",
		"expevents/icon_expedition_yadao01"
	},
	{
		300057,
		3,
		2,
		"20001030:99",
		240,
		"敌方精灵开局气势+150",
		"气势 III",
		"expevents/icon_expedition_yadao01"
	},
	{
		300058,
		1,
		2,
		"20001001:99",
		10,
		"敌阵精灵攻击+10%",
		"邪力 I",
		"expevents/icon_expedition_wugong4"
	},
	{
		300058,
		2,
		2,
		"20001002:99",
		20,
		"敌阵精灵攻击+15%",
		"邪力 II",
		"expevents/icon_expedition_wugong4"
	},
	{
		300058,
		3,
		2,
		"20001003:99",
		30,
		"敌阵精灵攻击+20%",
		"邪力 III",
		"expevents/icon_expedition_wugong4"
	},
	{
		300059,
		1,
		2,
		"20001034:99",
		10,
		"敌阵精灵最大生命值+10%",
		"长生 I",
		"expevents/icon_expedition_chixue01"
	},
	{
		300059,
		2,
		2,
		"20001035:99",
		20,
		"敌阵精灵最大生命值+15%",
		"长生 II",
		"expevents/icon_expedition_chixue01"
	},
	{
		300059,
		3,
		2,
		"20001036:99",
		30,
		"敌阵精灵最大生命值+20%",
		"长生 III",
		"expevents/icon_expedition_chixue01"
	},
	{
		300060,
		1,
		2,
		"20001031:99",
		10,
		"敌阵精灵防御+10%",
		"屹立 I",
		"expevents/icon_expedition_mofang"
	},
	{
		300060,
		2,
		2,
		"20001032:99",
		20,
		"敌阵精灵防御+15%",
		"屹立 II",
		"expevents/icon_expedition_mofang"
	},
	{
		300060,
		3,
		2,
		"20001033:99",
		30,
		"敌阵精灵防御+20%",
		"屹立 III",
		"expevents/icon_expedition_mofang"
	},
	{
		300061,
		1,
		2,
		"20001007:99",
		10,
		"敌阵精灵暴击率+10%",
		"怒目 I",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300061,
		2,
		2,
		"20001008:99",
		20,
		"敌阵精灵暴击率+15%",
		"怒目 II",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300061,
		3,
		2,
		"20001009:99",
		30,
		"敌阵精灵暴击率+20%",
		"怒目 III",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300062,
		1,
		2,
		"20001049:99",
		10,
		"敌阵精灵闪避率+10%",
		"闪避 I",
		"expevents/icon_expedition_jihuo"
	},
	{
		300062,
		2,
		2,
		"20001050:99",
		20,
		"敌阵精灵闪避率+15%",
		"闪避 II",
		"expevents/icon_expedition_jihuo"
	},
	{
		300062,
		3,
		2,
		"20001051:99",
		30,
		"敌阵精灵闪避率+20%",
		"闪避 III",
		"expevents/icon_expedition_jihuo"
	},
	{
		300063,
		1,
		2,
		"20001028:99",
		80,
		"敌方精灵开局气势+80",
		"气势 I",
		"expevents/icon_expedition_yadao01"
	},
	{
		300063,
		2,
		2,
		"20001029:99",
		160,
		"敌方精灵开局气势+100",
		"气势 II",
		"expevents/icon_expedition_yadao01"
	},
	{
		300063,
		3,
		2,
		"20001030:99",
		240,
		"敌方精灵开局气势+150",
		"气势 III",
		"expevents/icon_expedition_yadao01"
	},
	{
		300064,
		1,
		2,
		"20001010:99",
		30,
		"敌阵精灵超杀伤害+10%",
		"杀意 I",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		300064,
		2,
		2,
		"20001011:99",
		60,
		"敌阵精灵超杀伤害+15%",
		"杀意 II",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		300064,
		3,
		2,
		"20001012:99",
		90,
		"敌阵精灵超杀伤害+20%",
		"杀意 III",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		300065,
		1,
		2,
		"20001037:99",
		30,
		"敌阵精灵在超杀后恢复自身最大生命值20%",
		"嗜血 I",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		300065,
		2,
		2,
		"20001039:99",
		60,
		"敌阵精灵在超杀后恢复自身最大生命值30%",
		"嗜血 II",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		300065,
		3,
		2,
		"20001041:99",
		90,
		"敌阵精灵在超杀后恢复自身最大生命值40%",
		"嗜血 III",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		400001,
		1,
		2,
		"20034174:99",
		5,
		"敌阵精灵命中率+10%",
		"精准 I",
		"expevents/icon_expedition_baojilv"
	},
	{
		400001,
		2,
		2,
		"20034175:99",
		10,
		"敌阵精灵命中率+20%",
		"精准 II",
		"expevents/icon_expedition_baojilv"
	},
	{
		400001,
		3,
		2,
		"20034176:99",
		15,
		"敌阵精灵命中率+30%",
		"精准 III",
		"expevents/icon_expedition_baojilv"
	},
	{
		400002,
		1,
		2,
		"20034177:99",
		5,
		"敌阵精灵破击率+10%",
		"破击 I",
		"expevents/icon_expedition_baojilv1"
	},
	{
		400002,
		2,
		2,
		"20034178:99",
		10,
		"敌阵精灵破击率+20%",
		"破击 II",
		"expevents/icon_expedition_baojilv1"
	},
	{
		400002,
		3,
		2,
		"20034179:99",
		15,
		"敌阵精灵破击率+30%",
		"破击 III",
		"expevents/icon_expedition_baojilv1"
	},
	{
		400003,
		1,
		2,
		"20034174:99",
		10,
		"敌阵精灵命中率+10%",
		"精准 I",
		"expevents/icon_expedition_baojilv"
	},
	{
		400003,
		2,
		2,
		"20034175:99",
		20,
		"敌阵精灵命中率+20%",
		"精准 II",
		"expevents/icon_expedition_baojilv"
	},
	{
		400003,
		3,
		2,
		"20034176:99",
		30,
		"敌阵精灵命中率+30%",
		"精准 III",
		"expevents/icon_expedition_baojilv"
	},
	{
		400004,
		1,
		2,
		"20034180:99",
		10,
		"敌阵精灵暴击率+10%",
		"怒目 I",
		"expevents/icon_expedition_baojilv1"
	},
	{
		400004,
		2,
		2,
		"20034181:99",
		20,
		"敌阵精灵暴击率+20%",
		"怒目 II",
		"expevents/icon_expedition_baojilv1"
	},
	{
		400004,
		3,
		2,
		"20034182:99",
		30,
		"敌阵精灵暴击率+30%",
		"怒目 III",
		"expevents/icon_expedition_baojilv1"
	},
	{
		400005,
		1,
		2,
		"20034183:99",
		15,
		"敌阵精灵生命上限+5%",
		"长生 I",
		"expevents/icon_expedition_chixue01"
	},
	{
		400005,
		2,
		2,
		"20034184:99",
		30,
		"敌阵精灵生命上限+10%",
		"长生 II",
		"expevents/icon_expedition_chixue01"
	},
	{
		400005,
		3,
		2,
		"20034185:99",
		45,
		"敌阵精灵生命上限+15%",
		"长生 III",
		"expevents/icon_expedition_chixue01"
	},
	{
		400006,
		1,
		2,
		"20034186:99",
		15,
		"敌阵精灵无视防御+5%",
		"易损 I",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		400006,
		2,
		2,
		"20034187:99",
		30,
		"敌阵精灵无视防御+10%",
		"易损 II",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		400006,
		3,
		2,
		"20034188:99",
		45,
		"敌阵精灵无视防御+15%",
		"易损 III",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		400007,
		1,
		2,
		"20034189:99",
		30,
		"敌阵精灵起始气势+10",
		"气势 I",
		"expevents/icon_expedition_yadao01"
	},
	{
		400007,
		2,
		2,
		"20034190:99",
		60,
		"敌阵精灵起始气势+30",
		"气势 II",
		"expevents/icon_expedition_yadao01"
	},
	{
		400007,
		3,
		2,
		"20034191:99",
		90,
		"敌阵精灵起始气势+50",
		"气势 III",
		"expevents/icon_expedition_yadao01"
	},
	{
		400008,
		1,
		2,
		"20034192:99",
		20,
		"敌阵精灵全属性+5%",
		"邪力 I",
		"expevents/icon_expedition_wugong4"
	},
	{
		400008,
		2,
		2,
		"20034193:99",
		40,
		"敌阵精灵全属性+10%",
		"邪力 II",
		"expevents/icon_expedition_wugong4"
	},
	{
		400008,
		3,
		2,
		"20034194:99",
		60,
		"敌阵精灵全属性+15%",
		"邪力 III",
		"expevents/icon_expedition_wugong4"
	},
	{
		400009,
		1,
		2,
		"20034195:99",
		20,
		"敌阵精灵超杀伤害+5%",
		"杀意 I",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		400009,
		2,
		2,
		"20034196:99",
		40,
		"敌阵精灵超杀伤害+10%",
		"杀意 II",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		400009,
		3,
		2,
		"20034197:99",
		60,
		"敌阵精灵超杀伤害+15%",
		"杀意 III",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		400010,
		1,
		2,
		"20034189:99",
		40,
		"敌阵精灵起始气势+10",
		"气势 I",
		"expevents/icon_expedition_yadao01"
	},
	{
		400010,
		2,
		2,
		"20034190:99",
		80,
		"敌阵精灵起始气势+30",
		"气势 II",
		"expevents/icon_expedition_yadao01"
	},
	{
		400010,
		3,
		2,
		"20034191:99",
		120,
		"敌阵精灵起始气势+50",
		"气势 III",
		"expevents/icon_expedition_yadao01"
	},
	{
		400011,
		1,
		2,
		"20034198:99",
		25,
		"敌阵精灵受到的非直接伤害减少30%",
		"屹立 I",
		"expevents/icon_expedition_mofang"
	},
	{
		400011,
		2,
		2,
		"20034199:99",
		50,
		"敌阵精灵受到的非直接伤害减少50%",
		"屹立 II",
		"expevents/icon_expedition_mofang"
	},
	{
		400011,
		3,
		2,
		"20034200:99",
		75,
		"敌阵精灵受到的非直接伤害减少70%",
		"屹立 III",
		"expevents/icon_expedition_mofang"
	},
	{
		400012,
		1,
		2,
		"20034201:99",
		25,
		"敌阵精灵攻击时回复自身5%最大生命值",
		"嗜血 I",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		400012,
		2,
		2,
		"20034203:99",
		50,
		"敌阵精灵攻击时回复自身10%最大生命值",
		"嗜血 II",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		400012,
		3,
		2,
		"20034205:99",
		75,
		"敌阵精灵攻击时回复自身15%最大生命值",
		"嗜血 III",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		400013,
		1,
		2,
		"20034207:99",
		50,
		"敌阵精灵攻击时有10%额外出手1次",
		"连击 I",
		"expevents/icon_expedition_zhuiji"
	},
	{
		400013,
		2,
		2,
		"20034208:99",
		100,
		"敌阵精灵攻击时有20%额外出手1次",
		"连击 II",
		"expevents/icon_expedition_zhuiji"
	},
	{
		400013,
		3,
		2,
		"20034209:99",
		150,
		"敌阵精灵攻击时有30%额外出手1次",
		"连击 III",
		"expevents/icon_expedition_zhuiji"
	},
	{
		400014,
		1,
		2,
		"20034211:99",
		75,
		"敌阵精灵攻击时对目标造成目标5%最大生命值的伤害",
		"附伤 I",
		"expevents/icon_expedition_meicigongjizengshang"
	},
	{
		400014,
		2,
		2,
		"20034213:99",
		150,
		"敌阵精灵攻击时对目标造成目标10%最大生命值的伤害",
		"附伤 II",
		"expevents/icon_expedition_meicigongjizengshang"
	},
	{
		400014,
		3,
		2,
		"20034215:99",
		250,
		"敌阵精灵攻击时对目标造成目标15%最大生命值的伤害",
		"附伤 III",
		"expevents/icon_expedition_meicigongjizengshang"
	},
	{
		500001,
		1,
		2,
		"20034189:99",
		25,
		"敌阵精灵起始气势+10",
		"气势 I",
		"expevents/icon_expedition_yadao01"
	},
	{
		500001,
		2,
		2,
		"20034190:99",
		50,
		"敌阵精灵起始气势+30",
		"气势 II",
		"expevents/icon_expedition_yadao01"
	},
	{
		500001,
		3,
		2,
		"20034191:99",
		75,
		"敌阵精灵起始气势+50",
		"气势 III",
		"expevents/icon_expedition_yadao01"
	},
	{
		500002,
		1,
		1,
		"20048911:99",
		25,
		"己阵精灵受到的伤害增加10%",
		"嗜血 I",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		500002,
		2,
		1,
		"20048913:99",
		50,
		"己阵精灵受到的伤害增加30%",
		"嗜血 II",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		500002,
		3,
		1,
		"20048914:99",
		75,
		"己阵精灵受到的伤害增加50%",
		"嗜血 III",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		500003,
		1,
		1,
		"20048916:99",
		50,
		"己阵精灵每次出手后受到自身攻击*60%伤害",
		"连击 I",
		"expevents/icon_expedition_zhuiji"
	},
	{
		500003,
		2,
		1,
		"20048918:99",
		100,
		"己阵精灵每次出手后受到自身攻击*100%伤害",
		"连击 II",
		"expevents/icon_expedition_zhuiji"
	},
	{
		500003,
		3,
		1,
		"20048919:99",
		150,
		"己阵精灵每次出手后受到自身攻击*180%伤害",
		"连击 III",
		"expevents/icon_expedition_zhuiji"
	},
	{
		500004,
		1,
		2,
		"20048921:99",
		75,
		"敌阵受到致命伤害时，令该次伤害归0（全阵最多触发1次）",
		"附伤 I",
		"expevents/icon_expedition_meicigongjizengshang"
	},
	{
		500004,
		2,
		2,
		"20048922:99",
		150,
		"敌阵受到致命伤害时，令该次伤害归0（全阵最多触发2次）",
		"附伤 II",
		"expevents/icon_expedition_meicigongjizengshang"
	},
	{
		500004,
		3,
		2,
		"20048924:99",
		250,
		"敌阵受到致命伤害时，令该次伤害归0（全阵最多触发4次）",
		"附伤 III",
		"expevents/icon_expedition_meicigongjizengshang"
	},
	{
		600001,
		1,
		2,
		"20034174:99",
		20,
		"敌阵精灵命中率+10%",
		"精准 I",
		"expevents/icon_expedition_baojilv"
	},
	{
		600001,
		2,
		2,
		"20034175:99",
		40,
		"敌阵精灵命中率+20%",
		"精准 II",
		"expevents/icon_expedition_baojilv"
	},
	{
		600001,
		3,
		2,
		"20034176:99",
		60,
		"敌阵精灵命中率+30%",
		"精准 III",
		"expevents/icon_expedition_baojilv"
	},
	{
		600002,
		1,
		2,
		"20034177:99",
		20,
		"敌阵精灵破击率+10%",
		"破击 I",
		"expevents/icon_expedition_baojilv1"
	},
	{
		600002,
		2,
		2,
		"20034178:99",
		40,
		"敌阵精灵破击率+20%",
		"破击 II",
		"expevents/icon_expedition_baojilv1"
	},
	{
		600002,
		3,
		2,
		"20034179:99",
		60,
		"敌阵精灵破击率+30%",
		"破击 III",
		"expevents/icon_expedition_baojilv1"
	},
	{
		600003,
		1,
		2,
		"20034174:99",
		40,
		"敌阵精灵命中率+10%",
		"精准 I",
		"expevents/icon_expedition_baojilv"
	},
	{
		600003,
		2,
		2,
		"20034175:99",
		80,
		"敌阵精灵命中率+20%",
		"精准 II",
		"expevents/icon_expedition_baojilv"
	},
	{
		600003,
		3,
		2,
		"20034176:99",
		120,
		"敌阵精灵命中率+30%",
		"精准 III",
		"expevents/icon_expedition_baojilv"
	},
	{
		600004,
		1,
		2,
		"20034180:99",
		40,
		"敌阵精灵暴击率+10%",
		"怒目 I",
		"expevents/icon_expedition_baojilv1"
	},
	{
		600004,
		2,
		2,
		"20034181:99",
		80,
		"敌阵精灵暴击率+20%",
		"怒目 II",
		"expevents/icon_expedition_baojilv1"
	},
	{
		600004,
		3,
		2,
		"20034182:99",
		120,
		"敌阵精灵暴击率+30%",
		"怒目 III",
		"expevents/icon_expedition_baojilv1"
	},
	{
		600005,
		1,
		2,
		"20034183:99",
		60,
		"敌阵精灵生命上限+5%",
		"长生 I",
		"expevents/icon_expedition_chixue01"
	},
	{
		600005,
		2,
		2,
		"20034184:99",
		120,
		"敌阵精灵生命上限+10%",
		"长生 II",
		"expevents/icon_expedition_chixue01"
	},
	{
		600005,
		3,
		2,
		"20034185:99",
		180,
		"敌阵精灵生命上限+15%",
		"长生 III",
		"expevents/icon_expedition_chixue01"
	},
	{
		600006,
		1,
		2,
		"20034186:99",
		60,
		"敌阵精灵无视防御+5%",
		"易损 I",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		600006,
		2,
		2,
		"20034187:99",
		120,
		"敌阵精灵无视防御+10%",
		"易损 II",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		600006,
		3,
		2,
		"20034188:99",
		180,
		"敌阵精灵无视防御+15%",
		"易损 III",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		600007,
		1,
		2,
		"20034189:99",
		120,
		"敌阵精灵起始气势+10",
		"气势 I",
		"expevents/icon_expedition_yadao01"
	},
	{
		600007,
		2,
		2,
		"20034190:99",
		240,
		"敌阵精灵起始气势+30",
		"气势 II",
		"expevents/icon_expedition_yadao01"
	},
	{
		600007,
		3,
		2,
		"20034191:99",
		360,
		"敌阵精灵起始气势+50",
		"气势 III",
		"expevents/icon_expedition_yadao01"
	},
	{
		600008,
		1,
		2,
		"20034192:99",
		80,
		"敌阵精灵全属性+5%",
		"邪力 I",
		"expevents/icon_expedition_wugong4"
	},
	{
		600008,
		2,
		2,
		"20034193:99",
		160,
		"敌阵精灵全属性+10%",
		"邪力 II",
		"expevents/icon_expedition_wugong4"
	},
	{
		600008,
		3,
		2,
		"20034194:99",
		240,
		"敌阵精灵全属性+15%",
		"邪力 III",
		"expevents/icon_expedition_wugong4"
	},
	{
		600009,
		1,
		2,
		"20034195:99",
		80,
		"敌阵精灵超杀伤害+5%",
		"杀意 I",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		600009,
		2,
		2,
		"20034196:99",
		160,
		"敌阵精灵超杀伤害+10%",
		"杀意 II",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		600009,
		3,
		2,
		"20034197:99",
		240,
		"敌阵精灵超杀伤害+15%",
		"杀意 III",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		600010,
		1,
		2,
		"20034189:99",
		160,
		"敌阵精灵起始气势+10",
		"气势 I",
		"expevents/icon_expedition_yadao01"
	},
	{
		600010,
		2,
		2,
		"20034190:99",
		320,
		"敌阵精灵起始气势+30",
		"气势 II",
		"expevents/icon_expedition_yadao01"
	},
	{
		600010,
		3,
		2,
		"20034191:99",
		480,
		"敌阵精灵起始气势+50",
		"气势 III",
		"expevents/icon_expedition_yadao01"
	},
	{
		600011,
		1,
		2,
		"20034189:99",
		100,
		"敌阵精灵起始气势+10",
		"气势 I",
		"expevents/icon_expedition_yadao01"
	},
	{
		600011,
		2,
		2,
		"20034190:99",
		200,
		"敌阵精灵起始气势+30",
		"气势 II",
		"expevents/icon_expedition_yadao01"
	},
	{
		600011,
		3,
		2,
		"20034191:99",
		300,
		"敌阵精灵起始气势+50",
		"气势 III",
		"expevents/icon_expedition_yadao01"
	},
	{
		600012,
		1,
		1,
		"20048911:99",
		100,
		"己阵精灵受到的伤害增加10%",
		"嗜血 I",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		600012,
		2,
		1,
		"20048913:99",
		200,
		"己阵精灵受到的伤害增加30%",
		"嗜血 II",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		600012,
		3,
		1,
		"20048914:99",
		300,
		"己阵精灵受到的伤害增加50%",
		"嗜血 III",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		600013,
		1,
		1,
		"20048916:99",
		200,
		"己阵精灵每次出手后受到自身攻击*60%伤害",
		"连击 I",
		"expevents/icon_expedition_zhuiji"
	},
	{
		600013,
		2,
		1,
		"20048918:99",
		400,
		"己阵精灵每次出手后受到自身攻击*100%伤害",
		"连击 II",
		"expevents/icon_expedition_zhuiji"
	},
	{
		600013,
		3,
		1,
		"20048919:99",
		600,
		"己阵精灵每次出手后受到自身攻击*180%伤害",
		"连击 III",
		"expevents/icon_expedition_zhuiji"
	},
	{
		600014,
		1,
		2,
		"20048921:99",
		300,
		"敌阵受到致命伤害时，令该次伤害归0（全阵最多触发1次）",
		"附伤 I",
		"expevents/icon_expedition_meicigongjizengshang"
	},
	{
		600014,
		2,
		2,
		"20048922:99",
		600,
		"敌阵受到致命伤害时，令该次伤害归0（全阵最多触发2次）",
		"附伤 II",
		"expevents/icon_expedition_meicigongjizengshang"
	},
	{
		600014,
		3,
		2,
		"20048924:99",
		1000,
		"敌阵受到致命伤害时，令该次伤害归0（全阵最多触发4次）",
		"附伤 III",
		"expevents/icon_expedition_meicigongjizengshang"
	}
}
local t_moon_shadow_king_challenge_option_group = {
	[100001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[100002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[100003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[100004] = {
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[100005] = {
		dataList[13],
		dataList[14],
		dataList[15]
	},
	[100006] = {
		dataList[16],
		dataList[17],
		dataList[18]
	},
	[100007] = {
		dataList[19],
		dataList[20],
		dataList[21]
	},
	[100008] = {
		dataList[22],
		dataList[23],
		dataList[24]
	},
	[200001] = {
		dataList[25],
		dataList[26],
		dataList[27]
	},
	[200002] = {
		dataList[28],
		dataList[29],
		dataList[30]
	},
	[200003] = {
		dataList[31],
		dataList[32],
		dataList[33]
	},
	[200004] = {
		dataList[34],
		dataList[35],
		dataList[36]
	},
	[200005] = {
		dataList[37],
		dataList[38],
		dataList[39]
	},
	[200006] = {
		dataList[40],
		dataList[41],
		dataList[42]
	},
	[200007] = {
		dataList[43],
		dataList[44],
		dataList[45]
	},
	[200008] = {
		dataList[46],
		dataList[47],
		dataList[48]
	},
	[200009] = {
		dataList[49],
		dataList[50],
		dataList[51]
	},
	[200010] = {
		dataList[52],
		dataList[53],
		dataList[54]
	},
	[200011] = {
		dataList[55],
		dataList[56],
		dataList[57]
	},
	[200012] = {
		dataList[58],
		dataList[59],
		dataList[60]
	},
	[200013] = {
		dataList[61],
		dataList[62],
		dataList[63]
	},
	[200014] = {
		dataList[64],
		dataList[65],
		dataList[66]
	},
	[300001] = {
		dataList[67],
		dataList[68],
		dataList[69]
	},
	[300002] = {
		dataList[70],
		dataList[71],
		dataList[72]
	},
	[300003] = {
		dataList[73],
		dataList[74],
		dataList[75]
	},
	[300004] = {
		dataList[76],
		dataList[77],
		dataList[78]
	},
	[300005] = {
		dataList[79],
		dataList[80],
		dataList[81]
	},
	[300006] = {
		dataList[82],
		dataList[83],
		dataList[84]
	},
	[300007] = {
		dataList[85],
		dataList[86],
		dataList[87]
	},
	[300008] = {
		dataList[88],
		dataList[89],
		dataList[90]
	},
	[300009] = {
		dataList[91],
		dataList[92],
		dataList[93]
	},
	[300010] = {
		dataList[94],
		dataList[95],
		dataList[96]
	},
	[300011] = {
		dataList[97],
		dataList[98],
		dataList[99]
	},
	[300012] = {
		dataList[100],
		dataList[101],
		dataList[102]
	},
	[300013] = {
		dataList[103],
		dataList[104],
		dataList[105]
	},
	[300014] = {
		dataList[106],
		dataList[107],
		dataList[108]
	},
	[300015] = {
		dataList[109],
		dataList[110],
		dataList[111]
	},
	[300016] = {
		dataList[112],
		dataList[113],
		dataList[114]
	},
	[300017] = {
		dataList[115],
		dataList[116],
		dataList[117]
	},
	[300018] = {
		dataList[118],
		dataList[119],
		dataList[120]
	},
	[300019] = {
		dataList[121],
		dataList[122],
		dataList[123]
	},
	[300020] = {
		dataList[124],
		dataList[125],
		dataList[126]
	},
	[300021] = {
		dataList[127],
		dataList[128],
		dataList[129]
	},
	[300022] = {
		dataList[130],
		dataList[131],
		dataList[132]
	},
	[300023] = {
		dataList[133],
		dataList[134],
		dataList[135]
	},
	[300024] = {
		dataList[136],
		dataList[137],
		dataList[138]
	},
	[300025] = {
		dataList[139],
		dataList[140],
		dataList[141]
	},
	[300026] = {
		dataList[142],
		dataList[143],
		dataList[144]
	},
	[300027] = {
		dataList[145],
		dataList[146],
		dataList[147]
	},
	[300028] = {
		dataList[148],
		dataList[149],
		dataList[150]
	},
	[300029] = {
		dataList[151],
		dataList[152],
		dataList[153]
	},
	[300030] = {
		dataList[154],
		dataList[155],
		dataList[156]
	},
	[300031] = {
		dataList[157],
		dataList[158],
		dataList[159]
	},
	[300032] = {
		dataList[160],
		dataList[161],
		dataList[162]
	},
	[300033] = {
		dataList[163],
		dataList[164],
		dataList[165]
	},
	[300034] = {
		dataList[166],
		dataList[167],
		dataList[168]
	},
	[300035] = {
		dataList[169],
		dataList[170],
		dataList[171]
	},
	[300036] = {
		dataList[172],
		dataList[173],
		dataList[174]
	},
	[300037] = {
		dataList[175],
		dataList[176],
		dataList[177]
	},
	[300038] = {
		dataList[178],
		dataList[179],
		dataList[180]
	},
	[300039] = {
		dataList[181],
		dataList[182],
		dataList[183]
	},
	[300040] = {
		dataList[184],
		dataList[185],
		dataList[186]
	},
	[300041] = {
		dataList[187],
		dataList[188],
		dataList[189]
	},
	[300042] = {
		dataList[190],
		dataList[191],
		dataList[192]
	},
	[300043] = {
		dataList[193],
		dataList[194],
		dataList[195]
	},
	[300044] = {
		dataList[196],
		dataList[197],
		dataList[198]
	},
	[300045] = {
		dataList[199],
		dataList[200],
		dataList[201]
	},
	[300046] = {
		dataList[202],
		dataList[203],
		dataList[204]
	},
	[300047] = {
		dataList[205],
		dataList[206],
		dataList[207]
	},
	[300048] = {
		dataList[208],
		dataList[209],
		dataList[210]
	},
	[300049] = {
		dataList[211],
		dataList[212],
		dataList[213]
	},
	[300050] = {
		dataList[214],
		dataList[215],
		dataList[216]
	},
	[300051] = {
		dataList[217],
		dataList[218],
		dataList[219]
	},
	[300052] = {
		dataList[220],
		dataList[221],
		dataList[222]
	},
	[300053] = {
		dataList[223],
		dataList[224],
		dataList[225]
	},
	[300054] = {
		dataList[226],
		dataList[227],
		dataList[228]
	},
	[300055] = {
		dataList[229],
		dataList[230],
		dataList[231]
	},
	[300056] = {
		dataList[232],
		dataList[233],
		dataList[234]
	},
	[300057] = {
		dataList[235],
		dataList[236],
		dataList[237]
	},
	[300058] = {
		dataList[238],
		dataList[239],
		dataList[240]
	},
	[300059] = {
		dataList[241],
		dataList[242],
		dataList[243]
	},
	[300060] = {
		dataList[244],
		dataList[245],
		dataList[246]
	},
	[300061] = {
		dataList[247],
		dataList[248],
		dataList[249]
	},
	[300062] = {
		dataList[250],
		dataList[251],
		dataList[252]
	},
	[300063] = {
		dataList[253],
		dataList[254],
		dataList[255]
	},
	[300064] = {
		dataList[256],
		dataList[257],
		dataList[258]
	},
	[300065] = {
		dataList[259],
		dataList[260],
		dataList[261]
	},
	[400001] = {
		dataList[262],
		dataList[263],
		dataList[264]
	},
	[400002] = {
		dataList[265],
		dataList[266],
		dataList[267]
	},
	[400003] = {
		dataList[268],
		dataList[269],
		dataList[270]
	},
	[400004] = {
		dataList[271],
		dataList[272],
		dataList[273]
	},
	[400005] = {
		dataList[274],
		dataList[275],
		dataList[276]
	},
	[400006] = {
		dataList[277],
		dataList[278],
		dataList[279]
	},
	[400007] = {
		dataList[280],
		dataList[281],
		dataList[282]
	},
	[400008] = {
		dataList[283],
		dataList[284],
		dataList[285]
	},
	[400009] = {
		dataList[286],
		dataList[287],
		dataList[288]
	},
	[400010] = {
		dataList[289],
		dataList[290],
		dataList[291]
	},
	[400011] = {
		dataList[292],
		dataList[293],
		dataList[294]
	},
	[400012] = {
		dataList[295],
		dataList[296],
		dataList[297]
	},
	[400013] = {
		dataList[298],
		dataList[299],
		dataList[300]
	},
	[400014] = {
		dataList[301],
		dataList[302],
		dataList[303]
	},
	[500001] = {
		dataList[304],
		dataList[305],
		dataList[306]
	},
	[500002] = {
		dataList[307],
		dataList[308],
		dataList[309]
	},
	[500003] = {
		dataList[310],
		dataList[311],
		dataList[312]
	},
	[500004] = {
		dataList[313],
		dataList[314],
		dataList[315]
	},
	[600001] = {
		dataList[316],
		dataList[317],
		dataList[318]
	},
	[600002] = {
		dataList[319],
		dataList[320],
		dataList[321]
	},
	[600003] = {
		dataList[322],
		dataList[323],
		dataList[324]
	},
	[600004] = {
		dataList[325],
		dataList[326],
		dataList[327]
	},
	[600005] = {
		dataList[328],
		dataList[329],
		dataList[330]
	},
	[600006] = {
		dataList[331],
		dataList[332],
		dataList[333]
	},
	[600007] = {
		dataList[334],
		dataList[335],
		dataList[336]
	},
	[600008] = {
		dataList[337],
		dataList[338],
		dataList[339]
	},
	[600009] = {
		dataList[340],
		dataList[341],
		dataList[342]
	},
	[600010] = {
		dataList[343],
		dataList[344],
		dataList[345]
	},
	[600011] = {
		dataList[346],
		dataList[347],
		dataList[348]
	},
	[600012] = {
		dataList[349],
		dataList[350],
		dataList[351]
	},
	[600013] = {
		dataList[352],
		dataList[353],
		dataList[354]
	},
	[600014] = {
		dataList[355],
		dataList[356],
		dataList[357]
	}
}

t_moon_shadow_king_challenge_option_group.dataList = dataList

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

return t_moon_shadow_king_challenge_option_group
