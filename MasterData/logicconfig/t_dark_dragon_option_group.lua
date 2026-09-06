-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dark_dragon_option_group.lua

module("logicconfig.config.t_dark_dragon_option_group", package.seeall)

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
		"10102",
		400,
		"敌阵更换I",
		"敌阵更换I",
		"expevents/icon_expedition_yadao"
	},
	{
		100001,
		2,
		1,
		"10103",
		800,
		"敌阵更换II",
		"敌阵更换II",
		"expevents/icon_expedition_yadao"
	},
	{
		100001,
		3,
		1,
		"10104",
		1200,
		"敌阵更换III",
		"敌阵更换III",
		"expevents/icon_expedition_yadao"
	},
	{
		100002,
		1,
		1,
		"10702",
		400,
		"敌阵更换I",
		"敌阵更换I",
		"expevents/icon_expedition_yadao"
	},
	{
		100002,
		2,
		1,
		"10703",
		800,
		"敌阵更换II",
		"敌阵更换II",
		"expevents/icon_expedition_yadao"
	},
	{
		100002,
		3,
		1,
		"10704",
		1200,
		"敌阵更换III",
		"敌阵更换III",
		"expevents/icon_expedition_yadao"
	},
	{
		200001,
		1,
		2,
		"20001059:99",
		200,
		"己方精灵攻击-8%",
		"限制 I",
		"expevents/icon_expedition_guijia01"
	},
	{
		200001,
		2,
		2,
		"20001060:99",
		300,
		"己方精灵攻击-12%",
		"限制 II",
		"expevents/icon_expedition_guijia01"
	},
	{
		200001,
		3,
		2,
		"20001061:99",
		400,
		"己方精灵攻击-16%",
		"限制 III",
		"expevents/icon_expedition_guijia01"
	},
	{
		200002,
		1,
		2,
		"20001071:99",
		200,
		"己方精灵防御-8%",
		"强袭 I",
		"expevents/icon_expedition_guijia"
	},
	{
		200002,
		2,
		2,
		"20001072:99",
		300,
		"己方精灵防御-12%",
		"强袭 II",
		"expevents/icon_expedition_guijia"
	},
	{
		200002,
		3,
		2,
		"20001073:99",
		400,
		"己方精灵防御-16%",
		"强袭 III",
		"expevents/icon_expedition_guijia"
	},
	{
		200003,
		1,
		2,
		"20001074:99",
		200,
		"己方精灵最大生命值-8%",
		"虚弱 I",
		"expevents/icon_expedition_ganran"
	},
	{
		200003,
		2,
		2,
		"20001075:99",
		300,
		"己方精灵最大生命值-12%",
		"虚弱 II",
		"expevents/icon_expedition_ganran"
	},
	{
		200003,
		3,
		2,
		"20001076:99",
		400,
		"己方精灵最大生命值-16%",
		"虚弱 III",
		"expevents/icon_expedition_ganran"
	},
	{
		200004,
		1,
		2,
		"20001062:99",
		200,
		"己方精灵命中率-8%",
		"炫目 I",
		"expevents/icon_expedition_numu01"
	},
	{
		200004,
		2,
		2,
		"20001063:99",
		300,
		"己方精灵命中率-12%",
		"炫目 II",
		"expevents/icon_expedition_numu01"
	},
	{
		200004,
		3,
		2,
		"20001064:99",
		400,
		"己方精灵命中率-16%",
		"炫目 III",
		"expevents/icon_expedition_numu01"
	},
	{
		200005,
		1,
		2,
		"20001065:99",
		200,
		"己方精灵暴击率-8%",
		"怯场 I",
		"expevents/icon_expedition_xueliangtishengshanghai"
	},
	{
		200005,
		2,
		2,
		"20001066:99",
		300,
		"己方精灵暴击率-12%",
		"怯场 II",
		"expevents/icon_expedition_xueliangtishengshanghai"
	},
	{
		200005,
		3,
		2,
		"20001067:99",
		400,
		"己方精灵暴击率-16%",
		"怯场 III",
		"expevents/icon_expedition_xueliangtishengshanghai"
	},
	{
		200006,
		1,
		2,
		"20001077:99",
		200,
		"己方精灵治疗效果-40%",
		"诅咒 I",
		"expevents/icon_expedition_bianyi"
	},
	{
		200006,
		2,
		2,
		"20001078:99",
		300,
		"己方精灵治疗效果-60%",
		"诅咒 II",
		"expevents/icon_expedition_bianyi"
	},
	{
		200006,
		3,
		2,
		"20001079:99",
		400,
		"己方精灵治疗效果-80%",
		"诅咒 III",
		"expevents/icon_expedition_bianyi"
	},
	{
		200007,
		1,
		2,
		"20001080:99",
		200,
		"己方精灵每次被暴击后防御-8%",
		"战损 I",
		"expevents/icon_expedition_yisun01"
	},
	{
		200007,
		2,
		2,
		"20001081:99",
		300,
		"己方精灵每次被暴击后防御-18%",
		"战损 II",
		"expevents/icon_expedition_yisun01"
	},
	{
		200007,
		3,
		2,
		"20001082:99",
		400,
		"己方精灵每次被暴击后防御-24%",
		"战损 III",
		"expevents/icon_expedition_yisun01"
	},
	{
		200008,
		1,
		2,
		"20001068:99",
		200,
		"己方精灵超杀伤害-8%",
		"意志消沉 I",
		"expevents/icon_expedition_liaoxiaojiangdi"
	},
	{
		200008,
		2,
		2,
		"20001069:99",
		300,
		"己方精灵超杀伤害-12%",
		"意志消沉 II",
		"expevents/icon_expedition_liaoxiaojiangdi"
	},
	{
		200008,
		3,
		2,
		"20001070:99",
		400,
		"己方精灵超杀伤害-16%",
		"意志消沉 III",
		"expevents/icon_expedition_liaoxiaojiangdi"
	},
	{
		300001,
		1,
		3,
		"20001001:99",
		200,
		"敌阵精灵攻击+10%",
		"邪力 I",
		"expevents/icon_expedition_wugong4"
	},
	{
		300001,
		2,
		3,
		"20001002:99",
		300,
		"敌阵精灵攻击+15%",
		"邪力 II",
		"expevents/icon_expedition_wugong4"
	},
	{
		300001,
		3,
		3,
		"20001003:99",
		400,
		"敌阵精灵攻击+20%",
		"邪力 III",
		"expevents/icon_expedition_wugong4"
	},
	{
		300002,
		1,
		3,
		"20001031:99",
		200,
		"敌阵精灵防御+10%",
		"屹立 I",
		"expevents/icon_expedition_mofang"
	},
	{
		300002,
		2,
		3,
		"20001032:99",
		300,
		"敌阵精灵防御+15%",
		"屹立 II",
		"expevents/icon_expedition_mofang"
	},
	{
		300002,
		3,
		3,
		"20001033:99",
		400,
		"敌阵精灵防御+20%",
		"屹立 III",
		"expevents/icon_expedition_mofang"
	},
	{
		300003,
		1,
		3,
		"20001034:99",
		200,
		"敌阵精灵最大生命值+10%",
		"长生 I",
		"expevents/icon_expedition_chixue01"
	},
	{
		300003,
		2,
		3,
		"20001035:99",
		300,
		"敌阵精灵最大生命值+15%",
		"长生 II",
		"expevents/icon_expedition_chixue01"
	},
	{
		300003,
		3,
		3,
		"20001036:99",
		400,
		"敌阵精灵最大生命值+20%",
		"长生 III",
		"expevents/icon_expedition_chixue01"
	},
	{
		300004,
		1,
		3,
		"20001022:99",
		200,
		"敌阵精灵命中率+10%",
		"精准 I",
		"expevents/icon_expedition_baojilv"
	},
	{
		300004,
		2,
		3,
		"20001023:99",
		300,
		"敌阵精灵命中率+15%",
		"精准 II",
		"expevents/icon_expedition_baojilv"
	},
	{
		300004,
		3,
		3,
		"20001024:99",
		400,
		"敌阵精灵命中率+20%",
		"精准 III",
		"expevents/icon_expedition_baojilv"
	},
	{
		300005,
		1,
		3,
		"20001007:99",
		200,
		"敌阵精灵暴击率+10%",
		"怒目 I",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300005,
		2,
		3,
		"20001008:99",
		300,
		"敌阵精灵暴击率+15%",
		"怒目 II",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300005,
		3,
		3,
		"20001009:99",
		400,
		"敌阵精灵暴击率+20%",
		"怒目 III",
		"expevents/icon_expedition_baojilv1"
	},
	{
		300006,
		1,
		3,
		"20001049:99",
		200,
		"敌阵精灵闪避率+10%",
		"闪避 I",
		"expevents/icon_expedition_jihuo"
	},
	{
		300006,
		2,
		3,
		"20001050:99",
		300,
		"敌阵精灵闪避率+15%",
		"闪避 II",
		"expevents/icon_expedition_jihuo"
	},
	{
		300006,
		3,
		3,
		"20001051:99",
		400,
		"敌阵精灵闪避率+20%",
		"闪避 III",
		"expevents/icon_expedition_jihuo"
	},
	{
		300007,
		1,
		3,
		"20001025:99",
		200,
		"敌阵精灵无视防御8%",
		"易损 I",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		300007,
		2,
		3,
		"20001026:99",
		300,
		"敌阵精灵无视防御12%",
		"易损 II",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		300007,
		3,
		3,
		"20001027:99",
		400,
		"敌阵精灵无视防御16%",
		"易损 III",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		300008,
		1,
		3,
		"20001019:99",
		200,
		"敌阵精灵属性克制时伤害+10%",
		"精通 I",
		"expevents/icon_expedition_kezhizengqiang"
	},
	{
		300008,
		2,
		3,
		"20001020:99",
		300,
		"敌阵精灵属性克制时伤害+15%",
		"精通 II",
		"expevents/icon_expedition_kezhizengqiang"
	},
	{
		300008,
		3,
		3,
		"20001021:99",
		400,
		"敌阵精灵属性克制时伤害+20%",
		"精通 III",
		"expevents/icon_expedition_kezhizengqiang"
	},
	{
		300009,
		1,
		3,
		"20001010:99",
		200,
		"敌阵精灵超杀伤害+10%",
		"杀意 I",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		300009,
		2,
		3,
		"20001011:99",
		300,
		"敌阵精灵超杀伤害+15%",
		"杀意 II",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		300009,
		3,
		3,
		"20001012:99",
		400,
		"敌阵精灵超杀伤害+20%",
		"杀意 III",
		"expevents/icon_expedition_6huihezhongjie"
	},
	{
		300010,
		1,
		3,
		"20001037:99",
		200,
		"敌阵精灵在超杀后恢复自身最大生命值20%",
		"嗜血 I",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		300010,
		2,
		3,
		"20001039:99",
		300,
		"敌阵精灵在超杀后恢复自身最大生命值30%",
		"嗜血 II",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		300010,
		3,
		3,
		"20001041:99",
		400,
		"敌阵精灵在超杀后恢复自身最大生命值40%",
		"嗜血 III",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		300011,
		1,
		3,
		"20001013:99",
		200,
		"敌阵每有一只精灵死亡，敌阵其余精灵攻击+5%",
		"变异 I",
		"expevents/icon_expedition_bianyi01"
	},
	{
		300011,
		2,
		3,
		"20001014:99",
		300,
		"敌阵每有一只精灵死亡，敌阵其余精灵攻击+8%",
		"变异 II",
		"expevents/icon_expedition_bianyi01"
	},
	{
		300011,
		3,
		3,
		"20001015:99",
		400,
		"敌阵每有一只精灵死亡，敌阵其余精灵攻击+10%",
		"变异 III",
		"expevents/icon_expedition_bianyi01"
	},
	{
		300012,
		1,
		3,
		"20001043:99",
		200,
		"敌阵每有一只精灵死亡，敌阵其余精灵防御+5%",
		"抵抗 I",
		"expevents/icon_expedition_buqu"
	},
	{
		300012,
		2,
		3,
		"20001044:99",
		300,
		"敌阵每有一只精灵死亡，敌阵其余精灵防御+8%",
		"抵抗 II",
		"expevents/icon_expedition_buqu"
	},
	{
		300012,
		3,
		3,
		"20001045:99",
		400,
		"敌阵每有一只精灵死亡，敌阵其余精灵防御+10%",
		"抵抗 III",
		"expevents/icon_expedition_buqu"
	},
	{
		300013,
		1,
		3,
		"20001086:99",
		400,
		"必须在4回合内结束战斗",
		"速攻 I",
		"expevents/icon_expedition_zhuiji"
	},
	{
		300013,
		2,
		3,
		"20001087:99",
		800,
		"必须在3回合内结束战斗",
		"速攻 II",
		"expevents/icon_expedition_zhuiji"
	},
	{
		300013,
		3,
		3,
		"20001088:99",
		1200,
		"必须在2回合内结束战斗",
		"速攻 III",
		"expevents/icon_expedition_zhuiji"
	},
	{
		300014,
		1,
		3,
		"20001028:99",
		400,
		"敌方精灵开局气势+80",
		"气势 I",
		"expevents/icon_expedition_yadao01"
	},
	{
		300014,
		2,
		3,
		"20001029:99",
		800,
		"敌方精灵开局气势+100",
		"气势 II",
		"expevents/icon_expedition_yadao01"
	},
	{
		300014,
		3,
		3,
		"20001030:99",
		1200,
		"敌方精灵开局气势+150",
		"气势 III",
		"expevents/icon_expedition_yadao01"
	},
	{
		300015,
		1,
		2,
		"20001089:99",
		400,
		"己方精灵无法回血和复活",
		"驱逐",
		"expevents/icon_expedition_bianyi02"
	},
	{
		300015,
		2,
		3,
		"20001057:99",
		800,
		"敌方精灵平均抗伤",
		"同生共死",
		"expevents/icon_expedition_changsheng01"
	},
	{
		300015,
		3,
		3,
		"20001055:99",
		1200,
		"敌方精灵攻击生命值低于25%的目标将造成100倍伤害",
		"斩杀",
		"expevents/icon_expedition_zhansha"
	},
	{
		400001,
		1,
		4,
		"15",
		200,
		"至少上阵2只疾速或利爪职业的精灵",
		"职业限制 I",
		"expevents/icon_expedition_chaoshafanshi"
	},
	{
		400001,
		2,
		4,
		"16",
		300,
		"至少上阵3只疾速或利爪职业的精灵",
		"职业限制 II",
		"expevents/icon_expedition_chaoshafanshi"
	},
	{
		400001,
		3,
		4,
		"17",
		400,
		"至少上阵4只疾速或利爪职业的精灵",
		"职业限制 III",
		"expevents/icon_expedition_chaoshafanshi"
	},
	{
		400002,
		1,
		4,
		"23",
		200,
		"至少上阵2只肉盾或平衡职业的精灵",
		"职业限制 I",
		"expevents/icon_expedition_wufang"
	},
	{
		400002,
		2,
		4,
		"24",
		300,
		"至少上阵3只肉盾或平衡职业的精灵",
		"职业限制 II",
		"expevents/icon_expedition_wufang"
	},
	{
		400002,
		3,
		4,
		"25",
		400,
		"至少上阵4只肉盾或平衡职业的精灵",
		"职业限制 III",
		"expevents/icon_expedition_wufang"
	},
	{
		400003,
		1,
		4,
		"31",
		200,
		"至少上阵2只魔法或治疗职业的精灵",
		"职业限制 I",
		"expevents/icon_expedition_chixue"
	},
	{
		400003,
		2,
		4,
		"32",
		300,
		"至少上阵3只魔法或治疗职业的精灵",
		"职业限制 II",
		"expevents/icon_expedition_chixue"
	},
	{
		400003,
		3,
		4,
		"33",
		400,
		"至少上阵4只魔法或治疗职业的精灵",
		"职业限制 III",
		"expevents/icon_expedition_chixue"
	},
	{
		400004,
		1,
		4,
		"34",
		200,
		"至少上阵2只水属性精灵",
		"元素限制 I",
		"expevents/icon_expedition_suijidebuff"
	},
	{
		400004,
		2,
		4,
		"35",
		300,
		"至少上阵3只水属性精灵",
		"元素限制 II",
		"expevents/icon_expedition_suijidebuff"
	},
	{
		400004,
		3,
		4,
		"36",
		400,
		"至少上阵4只水属性精灵",
		"元素限制 III",
		"expevents/icon_expedition_suijidebuff"
	},
	{
		400005,
		1,
		4,
		"37",
		200,
		"至少上阵2只火属性精灵",
		"元素限制 I",
		"expevents/icon_expedition_suijidebuff"
	},
	{
		400005,
		2,
		4,
		"38",
		300,
		"至少上阵3只火属性精灵",
		"元素限制 II",
		"expevents/icon_expedition_suijidebuff"
	},
	{
		400005,
		3,
		4,
		"39",
		400,
		"至少上阵4只火属性精灵",
		"元素限制 III",
		"expevents/icon_expedition_suijidebuff"
	},
	{
		400006,
		1,
		4,
		"40",
		200,
		"至少上阵2只草属性精灵",
		"元素限制 I",
		"expevents/icon_expedition_suijidebuff"
	},
	{
		400006,
		2,
		4,
		"41",
		300,
		"至少上阵3只草属性精灵",
		"元素限制 II",
		"expevents/icon_expedition_suijidebuff"
	},
	{
		400006,
		3,
		4,
		"42",
		400,
		"至少上阵4只草属性精灵",
		"元素限制 III",
		"expevents/icon_expedition_suijidebuff"
	},
	{
		400007,
		1,
		4,
		"43",
		200,
		"至少上阵2只光属性精灵",
		"元素限制 I",
		"expevents/icon_expedition_suijidebuff"
	},
	{
		400007,
		2,
		4,
		"44",
		300,
		"至少上阵3只光属性精灵",
		"元素限制 II",
		"expevents/icon_expedition_suijidebuff"
	},
	{
		400007,
		3,
		4,
		"45",
		400,
		"至少上阵4只光属性精灵",
		"元素限制 III",
		"expevents/icon_expedition_suijidebuff"
	},
	{
		400008,
		1,
		4,
		"46",
		200,
		"至少上阵2只暗属性精灵",
		"元素限制 I",
		"expevents/icon_expedition_suijidebuff"
	},
	{
		400008,
		2,
		4,
		"47",
		300,
		"至少上阵3只暗属性精灵",
		"元素限制 II",
		"expevents/icon_expedition_suijidebuff"
	},
	{
		400008,
		3,
		4,
		"48",
		400,
		"至少上阵4只暗属性精灵",
		"元素限制 III",
		"expevents/icon_expedition_suijidebuff"
	},
	{
		310015,
		1,
		3,
		"3003:99",
		100,
		"敌阵精灵每回合恢复xx%生命值",
		"抵抗 I",
		"expevents/icon_expedition_yuzhanyuyong"
	},
	{
		310015,
		2,
		3,
		"3003:99",
		100,
		"敌阵精灵每回合恢复xx%生命值",
		"抵抗 II",
		"expevents/icon_expedition_yuzhanyuyong"
	},
	{
		310015,
		3,
		3,
		"3003:99",
		100,
		"敌阵精灵每回合恢复xx%生命值",
		"抵抗 III",
		"expevents/icon_expedition_yuzhanyuyong"
	},
	{
		310002,
		1,
		3,
		"20001004:99",
		100,
		"敌阵精灵伤害+50%",
		"怪力 I",
		"expevents/icon_expedition_yuzhanyuyong"
	},
	{
		310002,
		2,
		3,
		"20001004:99",
		100,
		"敌阵精灵伤害+50%",
		"怪力 II",
		"expevents/icon_expedition_yuzhanyuyong"
	},
	{
		310002,
		3,
		3,
		"20001004:99",
		100,
		"敌阵精灵伤害+50%",
		"怪力 III",
		"expevents/icon_expedition_yuzhanyuyong"
	},
	{
		210008,
		1,
		2,
		"3003:99",
		100,
		"己方精灵伤害加深50%",
		"恶毒 I",
		"expevents/icon_expedition_yuzhanyuyong"
	},
	{
		210008,
		2,
		2,
		"3003:99",
		100,
		"己方精灵伤害加深50%",
		"恶毒 II",
		"expevents/icon_expedition_yuzhanyuyong"
	},
	{
		210008,
		3,
		2,
		"3003:99",
		100,
		"己方精灵伤害加深50%",
		"恶毒 III",
		"expevents/icon_expedition_yuzhanyuyong"
	}
}
local t_dark_dragon_option_group = {
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
	[200001] = {
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[200002] = {
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[200003] = {
		dataList[13],
		dataList[14],
		dataList[15]
	},
	[200004] = {
		dataList[16],
		dataList[17],
		dataList[18]
	},
	[200005] = {
		dataList[19],
		dataList[20],
		dataList[21]
	},
	[200006] = {
		dataList[22],
		dataList[23],
		dataList[24]
	},
	[200007] = {
		dataList[25],
		dataList[26],
		dataList[27]
	},
	[200008] = {
		dataList[28],
		dataList[29],
		dataList[30]
	},
	[300001] = {
		dataList[31],
		dataList[32],
		dataList[33]
	},
	[300002] = {
		dataList[34],
		dataList[35],
		dataList[36]
	},
	[300003] = {
		dataList[37],
		dataList[38],
		dataList[39]
	},
	[300004] = {
		dataList[40],
		dataList[41],
		dataList[42]
	},
	[300005] = {
		dataList[43],
		dataList[44],
		dataList[45]
	},
	[300006] = {
		dataList[46],
		dataList[47],
		dataList[48]
	},
	[300007] = {
		dataList[49],
		dataList[50],
		dataList[51]
	},
	[300008] = {
		dataList[52],
		dataList[53],
		dataList[54]
	},
	[300009] = {
		dataList[55],
		dataList[56],
		dataList[57]
	},
	[300010] = {
		dataList[58],
		dataList[59],
		dataList[60]
	},
	[300011] = {
		dataList[61],
		dataList[62],
		dataList[63]
	},
	[300012] = {
		dataList[64],
		dataList[65],
		dataList[66]
	},
	[300013] = {
		dataList[67],
		dataList[68],
		dataList[69]
	},
	[300014] = {
		dataList[70],
		dataList[71],
		dataList[72]
	},
	[300015] = {
		dataList[73],
		dataList[74],
		dataList[75]
	},
	[400001] = {
		dataList[76],
		dataList[77],
		dataList[78]
	},
	[400002] = {
		dataList[79],
		dataList[80],
		dataList[81]
	},
	[400003] = {
		dataList[82],
		dataList[83],
		dataList[84]
	},
	[400004] = {
		dataList[85],
		dataList[86],
		dataList[87]
	},
	[400005] = {
		dataList[88],
		dataList[89],
		dataList[90]
	},
	[400006] = {
		dataList[91],
		dataList[92],
		dataList[93]
	},
	[400007] = {
		dataList[94],
		dataList[95],
		dataList[96]
	},
	[400008] = {
		dataList[97],
		dataList[98],
		dataList[99]
	},
	[310015] = {
		dataList[100],
		dataList[101],
		dataList[102]
	},
	[310002] = {
		dataList[103],
		dataList[104],
		dataList[105]
	},
	[210008] = {
		dataList[106],
		dataList[107],
		dataList[108]
	}
}

t_dark_dragon_option_group.dataList = dataList

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

return t_dark_dragon_option_group
