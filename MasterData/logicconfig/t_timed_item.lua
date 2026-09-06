-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_item.lua

module("logicconfig.config.t_timed_item", package.seeall)

local title = {
	name = 2,
	quality = 3,
	buffId = 6,
	id = 1,
	icon = 5,
	desc = 4
}
local dataList = {
	{
		1,
		82037265,
		2,
		"PVE场景中己方暴击+10%，buff生效时间：自获得时起至次日5:00失效",
		"icon_buff_baoji",
		20006001
	},
	{
		2,
		82037266,
		3,
		"PVE场景中，己方生命和生命上限+10%，限时buff生效时间：自签到时起至5:00失效；签到获得的buff无法叠加",
		"icon_buff_shengming",
		20006002
	},
	{
		3,
		82037267,
		3,
		"PVE场景中，莱莉丝暴击率增加35%，限时buff生效时间：自获得该精灵时起至7月15日5:00失效；",
		"icon_buff_baoji",
		20014004
	},
	{
		4,
		82037268,
		3,
		"PVE场景中，莱莉丝生命和生命上限增加20%，限时buff生效时间：自获得该精灵时起至7月15日5:00失效；",
		"icon_buff_shengming",
		20014005
	},
	{
		5,
		82037269,
		3,
		"PVE场景中，神启帝释天生命+20%，限时buff生效时间：自获得该精灵时起至7月29日5:00失效；",
		"icon_buff_shengming",
		20014005
	},
	{
		6,
		82037270,
		3,
		"PVE场景中，神启帝释天暴击率+35%，限时buff生效时间：自获得该精灵时起至7月29日5:00失效；",
		"icon_buff_baoji",
		20014004
	},
	{
		7,
		82037271,
		3,
		"PVE场景中，圣骑的暴击率和生命值提高，上阵圣骑越多，加成越强，最高提升暴击率20%和10%最大生命值，限时buff生效时间：7月29日5:00-9月2日5:00",
		"icon_buff_baoji",
		20034127
	},
	{
		8,
		82037272,
		3,
		"PVE场景中，神启阿瑞斯暴击率增加35%，限时buff生效时间：自获得该精灵时起至7月15日5:00失效；",
		"icon_buff_baoji",
		20014004
	},
	{
		9,
		82037273,
		3,
		"PVE场景中，神启阿瑞斯生命和生命上限增加20%，限时buff生效时间：自获得该精灵时起至7月15日5:00失效；",
		"icon_buff_shengming",
		20014005
	},
	{
		10,
		82037274,
		3,
		"PVE场景中，生命圣魂暴击率增加35%，限时buff生效时间：自获得该精灵时起至7月15日5:00失效；",
		"icon_buff_baoji",
		20014004
	},
	{
		11,
		82037275,
		3,
		"PVE场景中，生命圣魂生命和生命上限增加20%，限时buff生效时间：自获得该精灵时起至7月15日5:00失效；",
		"icon_buff_shengming",
		20014005
	},
	{
		12,
		82037276,
		3,
		"PVE场景中，王者圣龙暴击率增加35%，限时buff生效时间：自获得该精灵时起至7月15日5:00失效；",
		"icon_buff_baoji",
		20014004
	},
	{
		13,
		82037277,
		3,
		"PVE场景中，王者圣龙生命和生命上限增加20%，限时buff生效时间：自获得该精灵时起至7月15日5:00失效；",
		"icon_buff_shengming",
		20014005
	},
	{
		14,
		82037278,
		3,
		"PVE场景中，楼那暴击率增加35%，限时buff生效时间：自获得该精灵时起至7月15日5:00失效；",
		"icon_buff_baoji",
		20014004
	},
	{
		15,
		82037279,
		3,
		"PVE场景中，楼那生命和生命上限增加20%，限时buff生效时间：自获得该精灵时起至7月15日5:00失效；",
		"icon_buff_shengming",
		20014005
	},
	{
		16,
		82037280,
		3,
		"PVE场景中，盖西瑞暴击率增加35%，限时buff生效时间：自获得该精灵时起至10月7日5:00失效；",
		"icon_buff_baoji",
		20014004
	},
	{
		17,
		82037281,
		3,
		"PVE场景中，盖西瑞生命和生命上限增加20%，限时buff生效时间：自获得该精灵时起至10月7日5:00失效；",
		"icon_buff_shengming",
		20014005
	},
	{
		18,
		82037282,
		3,
		"PVE场景中，龙尊圣主暴击率增加35%，限时buff生效时间：自获得该精灵时起至10月7日5:00失效；",
		"icon_buff_baoji",
		20014004
	},
	{
		19,
		82037283,
		3,
		"PVE场景中，龙尊圣主生命和生命上限增加20%，限时buff生效时间：自获得该精灵时起至10月7日5:00失效；",
		"icon_buff_shengming",
		20014005
	},
	{
		20,
		82037284,
		3,
		"PVE场景中，青骨暴击率增加35%，限时buff生效时间：自获得该精灵时起至10月14日5:00失效；",
		"icon_buff_baoji",
		20014004
	},
	{
		21,
		82037285,
		3,
		"PVE场景中，青骨生命和生命上限增加20%，限时buff生效时间：自获得该精灵时起至10月14日5:00失效；",
		"icon_buff_shengming",
		20014005
	},
	{
		22,
		82037286,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		23,
		82037287,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		24,
		82037288,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		25,
		82037289,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		26,
		82037290,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		27,
		82037291,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		28,
		82037292,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		29,
		82037293,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		30,
		82037294,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		31,
		82037295,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		32,
		82037296,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		33,
		82037297,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		34,
		82037298,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		35,
		82037299,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		36,
		82037300,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		37,
		82037301,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		38,
		82037302,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		39,
		82037303,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		40,
		82037304,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		41,
		82037305,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		42,
		82037306,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		43,
		82037307,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		44,
		82037308,
		3,
		"提升暴击率20%",
		"icon_buff_shengming",
		20034127
	},
	{
		45,
		82037309,
		3,
		"提升暴击率20%",
		"icon_buff_shengming",
		20034127
	},
	{
		46,
		82037310,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		47,
		82037311,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		48,
		82037312,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		49,
		82037313,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		50,
		82037314,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		51,
		82037315,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		56,
		82037316,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		57,
		82037317,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		58,
		82037318,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		59,
		82037319,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		60,
		82037320,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		61,
		82037321,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		62,
		82037322,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		63,
		82037323,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		64,
		82037324,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		65,
		82037325,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		66,
		82037326,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		67,
		82037327,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		68,
		82037328,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		69,
		82037329,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		70,
		82037330,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		71,
		82037331,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		72,
		82037332,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		73,
		82037333,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		74,
		82037334,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		75,
		82037335,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		76,
		82037336,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		77,
		82037337,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		78,
		82037338,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		79,
		82037339,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		80,
		82037340,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		81,
		82037341,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		82,
		82037342,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		83,
		82037343,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		84,
		82037344,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		85,
		82037345,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		86,
		82037346,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		87,
		82037347,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		88,
		82037348,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		89,
		82037349,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		90,
		82037350,
		3,
		"PVE场景中，神曜梦队的暴击率和生命值提高，上阵神曜梦梦/王者梦梦越多，加成越强，最高提升暴击率20%和10%最大生命值，限时buff生效时间：6月30日5:00-7月28日5:00",
		"icon_buff_baoji",
		20034245
	},
	{
		91,
		82037351,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		92,
		82037352,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		93,
		82037353,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		94,
		82037354,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		95,
		82037355,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		96,
		82037356,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		97,
		82037357,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		98,
		82037358,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		99,
		82037359,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		100,
		82037360,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		101,
		82037361,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		102,
		82037362,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		103,
		82037363,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		104,
		82037364,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		105,
		82037365,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		106,
		82037366,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		107,
		82037367,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		108,
		82037368,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		109,
		82037369,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		110,
		82037370,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		111,
		82037371,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		112,
		82037372,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		113,
		82037373,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		114,
		82037374,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		115,
		82037375,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		116,
		82037376,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		117,
		82037377,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		118,
		82037378,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		119,
		82037379,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		120,
		82037380,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		121,
		82037381,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		122,
		82037382,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		123,
		82037383,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		124,
		82037384,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		125,
		82037385,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		126,
		82037386,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		127,
		82037387,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		128,
		82037388,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		129,
		82037389,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		130,
		82037390,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		131,
		82037391,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		132,
		82037392,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		133,
		82037393,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		134,
		82037394,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		135,
		82037395,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		136,
		82037396,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		137,
		82037397,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		138,
		82037398,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		139,
		82037399,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		140,
		82037400,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		141,
		82037401,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		142,
		82037402,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		143,
		82037403,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		144,
		82037404,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		145,
		82037405,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		146,
		82037406,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		147,
		82037407,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		148,
		82037408,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		149,
		82037409,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		150,
		82037410,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		151,
		82037608,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		152,
		82037609,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		153,
		82037610,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		154,
		82037611,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		155,
		82037612,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		156,
		82037613,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		157,
		82037614,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		158,
		82037614,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		159,
		82037652,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		160,
		82037653,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		161,
		82037654,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		162,
		82037655,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		163,
		82037656,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		164,
		82037657,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		165,
		82037658,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		166,
		82037659,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		167,
		82037770,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		168,
		82037771,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		169,
		82037772,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		170,
		82037773,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		171,
		82037774,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		172,
		82037775,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		173,
		82037776,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		174,
		82037777,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		175,
		82037778,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		176,
		82037779,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		177,
		82038710,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		178,
		82038711,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		179,
		82038712,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		180,
		82038713,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		181,
		82038714,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		182,
		82038715,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		183,
		82038716,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		184,
		82038717,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		185,
		82038718,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		186,
		82038719,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		187,
		82038720,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		188,
		82038721,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		189,
		82039174,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		190,
		82039175,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		191,
		82039176,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		192,
		82039177,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		193,
		82039178,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		194,
		82039179,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		195,
		82039180,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		196,
		82039181,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		197,
		82039182,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		198,
		82039183,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		199,
		82039681,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		200,
		82039682,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		201,
		82039683,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		202,
		82039684,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		203,
		82039685,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		204,
		82039686,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		205,
		82039687,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		206,
		82039688,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		207,
		82039689,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		208,
		82039690,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		209,
		82039789,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		210,
		82039790,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		211,
		82039791,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		212,
		82039792,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		213,
		82039793,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		214,
		82039794,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		215,
		82039795,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		216,
		82039796,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		217,
		82039797,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		218,
		82039798,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		219,
		82039799,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		220,
		82039800,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		221,
		82040861,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		222,
		82040862,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		223,
		82040863,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		224,
		82040864,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		225,
		82040865,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		226,
		82040866,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		227,
		82040867,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		228,
		82040868,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		229,
		82041258,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		230,
		82041259,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		231,
		82041260,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		232,
		82041261,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		233,
		82041262,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		234,
		82041263,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		235,
		82041264,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		236,
		82041265,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		237,
		82041266,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		238,
		82041267,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		239,
		82041672,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		240,
		82041673,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		241,
		82041674,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		242,
		82041675,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		243,
		82041676,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		244,
		82041677,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		245,
		82041678,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		246,
		82041679,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		247,
		82041680,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		248,
		82041681,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		249,
		82041682,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		250,
		82041683,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		251,
		82042518,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		252,
		82042519,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		253,
		82042520,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		254,
		82042521,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		255,
		82042522,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		256,
		82042523,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		257,
		82042524,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		258,
		82042525,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		259,
		82042526,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		260,
		82042527,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		261,
		82042542,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		262,
		82042543,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		263,
		82042544,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		264,
		82042545,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		265,
		82042546,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		266,
		82042547,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		267,
		82042548,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		268,
		82042549,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		269,
		82043435,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		270,
		82043436,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		271,
		82043437,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		272,
		82043438,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		273,
		82043439,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		274,
		82043440,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		275,
		82043441,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		276,
		82043442,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		277,
		82043443,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		278,
		82043444,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		279,
		82043445,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		280,
		82043446,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		281,
		82043447,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		282,
		82043448,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		283,
		82043449,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		284,
		82043450,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		285,
		82043451,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		286,
		82043452,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		287,
		82043453,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		288,
		82043454,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		289,
		82043455,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		290,
		82043456,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		291,
		82043457,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		292,
		82043458,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		293,
		82043459,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		294,
		82043460,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		295,
		82044439,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		296,
		82044440,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		297,
		82044441,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		298,
		82044442,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		299,
		82044443,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		300,
		82044444,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		301,
		82044445,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		302,
		82044446,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		303,
		82044447,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		304,
		82044448,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		305,
		82045485,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		306,
		82045486,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		307,
		82045487,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		308,
		82045488,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		309,
		82045489,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		310,
		82045490,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		311,
		82045491,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		312,
		82045492,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		313,
		82045493,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		314,
		82045494,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		315,
		82045495,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		316,
		82045496,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		317,
		82046928,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		318,
		82046929,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		319,
		82046930,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		320,
		82046931,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		321,
		82046932,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		322,
		82046933,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		323,
		82046934,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		324,
		82046935,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		325,
		82046936,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		326,
		82046937,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		327,
		82047952,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		328,
		82047953,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		329,
		82047954,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		330,
		82047955,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		331,
		82047956,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		332,
		82047957,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		333,
		82047958,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		334,
		82047959,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		335,
		82047960,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		336,
		82047961,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		337,
		82047962,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		338,
		82047963,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		339,
		82047964,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		340,
		82047965,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		341,
		82047966,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		342,
		82047967,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		343,
		82047968,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		344,
		82047969,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		345,
		82047970,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		346,
		82047971,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		347,
		82047972,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		348,
		82047973,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		349,
		82047974,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		350,
		82047975,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		351,
		82047976,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		352,
		82047977,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		353,
		82047978,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		354,
		82047979,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		355,
		82047980,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		356,
		82047981,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		357,
		82047982,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		358,
		82047983,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		359,
		82048224,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		360,
		82048225,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		361,
		82048226,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		362,
		82048227,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		363,
		82048228,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		364,
		82048229,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		365,
		82048230,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		366,
		82048231,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		367,
		82048232,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		368,
		82048233,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		369,
		82048234,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		370,
		82048235,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		371,
		82049707,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		372,
		82049708,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		373,
		82049709,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		374,
		82049710,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		375,
		82049711,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		376,
		82049712,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		377,
		82049713,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		378,
		82049714,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		379,
		82049715,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		380,
		82049716,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		381,
		82049717,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		382,
		82049718,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		383,
		82050714,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		384,
		82050715,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		385,
		82050716,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		386,
		82050717,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		387,
		82050718,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		388,
		82050719,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		389,
		82050720,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		390,
		82050721,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		391,
		82050722,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		392,
		82050723,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		393,
		82050724,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		394,
		82050725,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		395,
		82050726,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		396,
		82050727,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		397,
		82050728,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		398,
		82050729,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		399,
		82050730,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		400,
		82050731,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		401,
		82050732,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		402,
		82050733,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		403,
		82050734,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		404,
		82050735,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		405,
		82051212,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		406,
		82051213,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		407,
		82051214,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		408,
		82051215,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		409,
		82051216,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		410,
		82051217,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		411,
		82051218,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		412,
		82051219,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		413,
		82051220,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		414,
		82051221,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		415,
		82051222,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		416,
		82051223,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		417,
		82052558,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		418,
		82052559,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		419,
		82052560,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		420,
		82052561,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		421,
		82052562,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		422,
		82052563,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		423,
		82052564,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		424,
		82052565,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		425,
		82052566,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		426,
		82052567,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		427,
		82052568,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		428,
		82052569,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		429,
		82052570,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		430,
		82052571,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		431,
		82053801,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		432,
		82053802,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		433,
		82053803,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		434,
		82053804,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		435,
		82053805,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		436,
		82053806,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		437,
		82053807,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		438,
		82053808,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		439,
		82053809,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		440,
		82053810,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		441,
		82053811,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		442,
		82053812,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		443,
		82053881,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		444,
		82053882,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		445,
		82053883,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		446,
		82053884,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		447,
		82053885,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		448,
		82053886,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		449,
		82053887,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		450,
		82053888,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		451,
		82053889,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		452,
		82053890,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		453,
		82055774,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		454,
		82055775,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		455,
		82055776,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		456,
		82055777,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		457,
		82055778,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		458,
		82055779,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		459,
		82055780,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		460,
		82055781,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		461,
		82055782,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		462,
		82055783,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		463,
		82055784,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		464,
		82055785,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		465,
		82056236,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		466,
		82056237,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		467,
		82056238,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		468,
		82056239,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		469,
		82056240,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		470,
		82056241,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		471,
		82056242,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		472,
		82056243,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		473,
		82056244,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		474,
		82056245,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		475,
		82056246,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		476,
		82056247,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		477,
		82056677,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		478,
		82056678,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		479,
		82056679,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		480,
		82056680,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		481,
		82056681,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		482,
		82056682,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		483,
		82056683,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		484,
		82056684,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		485,
		82056685,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		486,
		82056686,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		487,
		82056687,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		488,
		82056688,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		489,
		82057633,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		490,
		82057634,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		491,
		82057635,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		492,
		82057636,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		493,
		82057637,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		494,
		82057638,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		495,
		82057639,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		496,
		82057640,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		497,
		82057641,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		498,
		82057642,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		499,
		82058008,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		500,
		82058009,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		501,
		82058010,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		502,
		82058011,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		503,
		82058012,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		504,
		82058013,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		505,
		82058014,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		506,
		82058015,
		3,
		"",
		"icon_buff_shengming",
		20014005
	},
	{
		507,
		82058016,
		3,
		"",
		"icon_buff_baoji",
		20014004
	},
	{
		508,
		82058017,
		3,
		"",
		"icon_buff_shengming",
		20014005
	}
}
local t_timed_item = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20],
	dataList[21],
	dataList[22],
	dataList[23],
	dataList[24],
	dataList[25],
	dataList[26],
	dataList[27],
	dataList[28],
	dataList[29],
	dataList[30],
	dataList[31],
	dataList[32],
	dataList[33],
	dataList[34],
	dataList[35],
	dataList[36],
	dataList[37],
	dataList[38],
	dataList[39],
	dataList[40],
	dataList[41],
	dataList[42],
	dataList[43],
	dataList[44],
	dataList[45],
	dataList[46],
	dataList[47],
	dataList[48],
	dataList[49],
	dataList[50],
	dataList[51],
	[56] = dataList[52],
	[57] = dataList[53],
	[58] = dataList[54],
	[59] = dataList[55],
	[60] = dataList[56],
	[61] = dataList[57],
	[62] = dataList[58],
	[63] = dataList[59],
	[64] = dataList[60],
	[65] = dataList[61],
	[66] = dataList[62],
	[67] = dataList[63],
	[68] = dataList[64],
	[69] = dataList[65],
	[70] = dataList[66],
	[71] = dataList[67],
	[72] = dataList[68],
	[73] = dataList[69],
	[74] = dataList[70],
	[75] = dataList[71],
	[76] = dataList[72],
	[77] = dataList[73],
	[78] = dataList[74],
	[79] = dataList[75],
	[80] = dataList[76],
	[81] = dataList[77],
	[82] = dataList[78],
	[83] = dataList[79],
	[84] = dataList[80],
	[85] = dataList[81],
	[86] = dataList[82],
	[87] = dataList[83],
	[88] = dataList[84],
	[89] = dataList[85],
	[90] = dataList[86],
	[91] = dataList[87],
	[92] = dataList[88],
	[93] = dataList[89],
	[94] = dataList[90],
	[95] = dataList[91],
	[96] = dataList[92],
	[97] = dataList[93],
	[98] = dataList[94],
	[99] = dataList[95],
	[100] = dataList[96],
	[101] = dataList[97],
	[102] = dataList[98],
	[103] = dataList[99],
	[104] = dataList[100],
	[105] = dataList[101],
	[106] = dataList[102],
	[107] = dataList[103],
	[108] = dataList[104],
	[109] = dataList[105],
	[110] = dataList[106],
	[111] = dataList[107],
	[112] = dataList[108],
	[113] = dataList[109],
	[114] = dataList[110],
	[115] = dataList[111],
	[116] = dataList[112],
	[117] = dataList[113],
	[118] = dataList[114],
	[119] = dataList[115],
	[120] = dataList[116],
	[121] = dataList[117],
	[122] = dataList[118],
	[123] = dataList[119],
	[124] = dataList[120],
	[125] = dataList[121],
	[126] = dataList[122],
	[127] = dataList[123],
	[128] = dataList[124],
	[129] = dataList[125],
	[130] = dataList[126],
	[131] = dataList[127],
	[132] = dataList[128],
	[133] = dataList[129],
	[134] = dataList[130],
	[135] = dataList[131],
	[136] = dataList[132],
	[137] = dataList[133],
	[138] = dataList[134],
	[139] = dataList[135],
	[140] = dataList[136],
	[141] = dataList[137],
	[142] = dataList[138],
	[143] = dataList[139],
	[144] = dataList[140],
	[145] = dataList[141],
	[146] = dataList[142],
	[147] = dataList[143],
	[148] = dataList[144],
	[149] = dataList[145],
	[150] = dataList[146],
	[151] = dataList[147],
	[152] = dataList[148],
	[153] = dataList[149],
	[154] = dataList[150],
	[155] = dataList[151],
	[156] = dataList[152],
	[157] = dataList[153],
	[158] = dataList[154],
	[159] = dataList[155],
	[160] = dataList[156],
	[161] = dataList[157],
	[162] = dataList[158],
	[163] = dataList[159],
	[164] = dataList[160],
	[165] = dataList[161],
	[166] = dataList[162],
	[167] = dataList[163],
	[168] = dataList[164],
	[169] = dataList[165],
	[170] = dataList[166],
	[171] = dataList[167],
	[172] = dataList[168],
	[173] = dataList[169],
	[174] = dataList[170],
	[175] = dataList[171],
	[176] = dataList[172],
	[177] = dataList[173],
	[178] = dataList[174],
	[179] = dataList[175],
	[180] = dataList[176],
	[181] = dataList[177],
	[182] = dataList[178],
	[183] = dataList[179],
	[184] = dataList[180],
	[185] = dataList[181],
	[186] = dataList[182],
	[187] = dataList[183],
	[188] = dataList[184],
	[189] = dataList[185],
	[190] = dataList[186],
	[191] = dataList[187],
	[192] = dataList[188],
	[193] = dataList[189],
	[194] = dataList[190],
	[195] = dataList[191],
	[196] = dataList[192],
	[197] = dataList[193],
	[198] = dataList[194],
	[199] = dataList[195],
	[200] = dataList[196],
	[201] = dataList[197],
	[202] = dataList[198],
	[203] = dataList[199],
	[204] = dataList[200],
	[205] = dataList[201],
	[206] = dataList[202],
	[207] = dataList[203],
	[208] = dataList[204],
	[209] = dataList[205],
	[210] = dataList[206],
	[211] = dataList[207],
	[212] = dataList[208],
	[213] = dataList[209],
	[214] = dataList[210],
	[215] = dataList[211],
	[216] = dataList[212],
	[217] = dataList[213],
	[218] = dataList[214],
	[219] = dataList[215],
	[220] = dataList[216],
	[221] = dataList[217],
	[222] = dataList[218],
	[223] = dataList[219],
	[224] = dataList[220],
	[225] = dataList[221],
	[226] = dataList[222],
	[227] = dataList[223],
	[228] = dataList[224],
	[229] = dataList[225],
	[230] = dataList[226],
	[231] = dataList[227],
	[232] = dataList[228],
	[233] = dataList[229],
	[234] = dataList[230],
	[235] = dataList[231],
	[236] = dataList[232],
	[237] = dataList[233],
	[238] = dataList[234],
	[239] = dataList[235],
	[240] = dataList[236],
	[241] = dataList[237],
	[242] = dataList[238],
	[243] = dataList[239],
	[244] = dataList[240],
	[245] = dataList[241],
	[246] = dataList[242],
	[247] = dataList[243],
	[248] = dataList[244],
	[249] = dataList[245],
	[250] = dataList[246],
	[251] = dataList[247],
	[252] = dataList[248],
	[253] = dataList[249],
	[254] = dataList[250],
	[255] = dataList[251],
	[256] = dataList[252],
	[257] = dataList[253],
	[258] = dataList[254],
	[259] = dataList[255],
	[260] = dataList[256],
	[261] = dataList[257],
	[262] = dataList[258],
	[263] = dataList[259],
	[264] = dataList[260],
	[265] = dataList[261],
	[266] = dataList[262],
	[267] = dataList[263],
	[268] = dataList[264],
	[269] = dataList[265],
	[270] = dataList[266],
	[271] = dataList[267],
	[272] = dataList[268],
	[273] = dataList[269],
	[274] = dataList[270],
	[275] = dataList[271],
	[276] = dataList[272],
	[277] = dataList[273],
	[278] = dataList[274],
	[279] = dataList[275],
	[280] = dataList[276],
	[281] = dataList[277],
	[282] = dataList[278],
	[283] = dataList[279],
	[284] = dataList[280],
	[285] = dataList[281],
	[286] = dataList[282],
	[287] = dataList[283],
	[288] = dataList[284],
	[289] = dataList[285],
	[290] = dataList[286],
	[291] = dataList[287],
	[292] = dataList[288],
	[293] = dataList[289],
	[294] = dataList[290],
	[295] = dataList[291],
	[296] = dataList[292],
	[297] = dataList[293],
	[298] = dataList[294],
	[299] = dataList[295],
	[300] = dataList[296],
	[301] = dataList[297],
	[302] = dataList[298],
	[303] = dataList[299],
	[304] = dataList[300],
	[305] = dataList[301],
	[306] = dataList[302],
	[307] = dataList[303],
	[308] = dataList[304],
	[309] = dataList[305],
	[310] = dataList[306],
	[311] = dataList[307],
	[312] = dataList[308],
	[313] = dataList[309],
	[314] = dataList[310],
	[315] = dataList[311],
	[316] = dataList[312],
	[317] = dataList[313],
	[318] = dataList[314],
	[319] = dataList[315],
	[320] = dataList[316],
	[321] = dataList[317],
	[322] = dataList[318],
	[323] = dataList[319],
	[324] = dataList[320],
	[325] = dataList[321],
	[326] = dataList[322],
	[327] = dataList[323],
	[328] = dataList[324],
	[329] = dataList[325],
	[330] = dataList[326],
	[331] = dataList[327],
	[332] = dataList[328],
	[333] = dataList[329],
	[334] = dataList[330],
	[335] = dataList[331],
	[336] = dataList[332],
	[337] = dataList[333],
	[338] = dataList[334],
	[339] = dataList[335],
	[340] = dataList[336],
	[341] = dataList[337],
	[342] = dataList[338],
	[343] = dataList[339],
	[344] = dataList[340],
	[345] = dataList[341],
	[346] = dataList[342],
	[347] = dataList[343],
	[348] = dataList[344],
	[349] = dataList[345],
	[350] = dataList[346],
	[351] = dataList[347],
	[352] = dataList[348],
	[353] = dataList[349],
	[354] = dataList[350],
	[355] = dataList[351],
	[356] = dataList[352],
	[357] = dataList[353],
	[358] = dataList[354],
	[359] = dataList[355],
	[360] = dataList[356],
	[361] = dataList[357],
	[362] = dataList[358],
	[363] = dataList[359],
	[364] = dataList[360],
	[365] = dataList[361],
	[366] = dataList[362],
	[367] = dataList[363],
	[368] = dataList[364],
	[369] = dataList[365],
	[370] = dataList[366],
	[371] = dataList[367],
	[372] = dataList[368],
	[373] = dataList[369],
	[374] = dataList[370],
	[375] = dataList[371],
	[376] = dataList[372],
	[377] = dataList[373],
	[378] = dataList[374],
	[379] = dataList[375],
	[380] = dataList[376],
	[381] = dataList[377],
	[382] = dataList[378],
	[383] = dataList[379],
	[384] = dataList[380],
	[385] = dataList[381],
	[386] = dataList[382],
	[387] = dataList[383],
	[388] = dataList[384],
	[389] = dataList[385],
	[390] = dataList[386],
	[391] = dataList[387],
	[392] = dataList[388],
	[393] = dataList[389],
	[394] = dataList[390],
	[395] = dataList[391],
	[396] = dataList[392],
	[397] = dataList[393],
	[398] = dataList[394],
	[399] = dataList[395],
	[400] = dataList[396],
	[401] = dataList[397],
	[402] = dataList[398],
	[403] = dataList[399],
	[404] = dataList[400],
	[405] = dataList[401],
	[406] = dataList[402],
	[407] = dataList[403],
	[408] = dataList[404],
	[409] = dataList[405],
	[410] = dataList[406],
	[411] = dataList[407],
	[412] = dataList[408],
	[413] = dataList[409],
	[414] = dataList[410],
	[415] = dataList[411],
	[416] = dataList[412],
	[417] = dataList[413],
	[418] = dataList[414],
	[419] = dataList[415],
	[420] = dataList[416],
	[421] = dataList[417],
	[422] = dataList[418],
	[423] = dataList[419],
	[424] = dataList[420],
	[425] = dataList[421],
	[426] = dataList[422],
	[427] = dataList[423],
	[428] = dataList[424],
	[429] = dataList[425],
	[430] = dataList[426],
	[431] = dataList[427],
	[432] = dataList[428],
	[433] = dataList[429],
	[434] = dataList[430],
	[435] = dataList[431],
	[436] = dataList[432],
	[437] = dataList[433],
	[438] = dataList[434],
	[439] = dataList[435],
	[440] = dataList[436],
	[441] = dataList[437],
	[442] = dataList[438],
	[443] = dataList[439],
	[444] = dataList[440],
	[445] = dataList[441],
	[446] = dataList[442],
	[447] = dataList[443],
	[448] = dataList[444],
	[449] = dataList[445],
	[450] = dataList[446],
	[451] = dataList[447],
	[452] = dataList[448],
	[453] = dataList[449],
	[454] = dataList[450],
	[455] = dataList[451],
	[456] = dataList[452],
	[457] = dataList[453],
	[458] = dataList[454],
	[459] = dataList[455],
	[460] = dataList[456],
	[461] = dataList[457],
	[462] = dataList[458],
	[463] = dataList[459],
	[464] = dataList[460],
	[465] = dataList[461],
	[466] = dataList[462],
	[467] = dataList[463],
	[468] = dataList[464],
	[469] = dataList[465],
	[470] = dataList[466],
	[471] = dataList[467],
	[472] = dataList[468],
	[473] = dataList[469],
	[474] = dataList[470],
	[475] = dataList[471],
	[476] = dataList[472],
	[477] = dataList[473],
	[478] = dataList[474],
	[479] = dataList[475],
	[480] = dataList[476],
	[481] = dataList[477],
	[482] = dataList[478],
	[483] = dataList[479],
	[484] = dataList[480],
	[485] = dataList[481],
	[486] = dataList[482],
	[487] = dataList[483],
	[488] = dataList[484],
	[489] = dataList[485],
	[490] = dataList[486],
	[491] = dataList[487],
	[492] = dataList[488],
	[493] = dataList[489],
	[494] = dataList[490],
	[495] = dataList[491],
	[496] = dataList[492],
	[497] = dataList[493],
	[498] = dataList[494],
	[499] = dataList[495],
	[500] = dataList[496],
	[501] = dataList[497],
	[502] = dataList[498],
	[503] = dataList[499],
	[504] = dataList[500],
	[505] = dataList[501],
	[506] = dataList[502],
	[507] = dataList[503],
	[508] = dataList[504]
}

t_timed_item.dataList = dataList

local multiLanguageCells = {
	name = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_timed_item
