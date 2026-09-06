-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_effect.lua

module("logicconfig.config.t_effect", package.seeall)

local title = {
	resName = 2,
	follow = 5,
	loopMode = 3,
	mountPointName = 6,
	id = 1,
	duration = 4,
	flix = 8,
	camera = 7
}
local dataList = {
	{
		1,
		"common/skill/fx_chaosha01",
		1,
		0.7,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		2,
		"common/buff/fx_buff_miehuo",
		0,
		0,
		1,
		"hangPoints/head",
		"",
		1
	},
	{
		3,
		"common/buff/fx_buff_xuanwudun",
		0,
		0,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		6,
		"common/buff/fx_buff_huodun",
		0,
		0,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		8,
		"common/buff/fx_buff_shan",
		0,
		0,
		1,
		"hangPoints/head",
		"",
		0
	},
	{
		2100031,
		"jingling/fx_10003_shennuoya/fx_10003_bullet02_shennuoya",
		0,
		0,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		2100042,
		"jingling/fx_10004_baobaolong/fx_10004_bullet01_baobaolong",
		0,
		0,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		2100082,
		"jingling/fx_10008_zhuque/fx_10008_bullet01_zhuque",
		0,
		0,
		0,
		"hangPoints/center",
		"",
		1
	},
	{
		3100021,
		"jingling/fx_10002_nuoya/fx_10002_hit02_nuoya",
		1,
		1,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		3100022,
		"jingling/fx_10002_nuoya/fx_10002_hit01_nuoya",
		1,
		2,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		3100031,
		"jingling/fx_10003_shennuoya/fx_10003_hit02_shennuoya",
		1,
		2,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		3100032,
		"jingling/fx_10003_shennuoya/fx_10003_hit01_shennuoya",
		1,
		2,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		3100041,
		"jingling/fx_10004_baobaolong/fx_10004_hit02_baobaolong",
		1,
		1.5,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		3100042,
		"jingling/fx_10004_baobaolong/fx_10004_hit01_baobaolong",
		1,
		1.5,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		3100051,
		"jingling/fx_10005_moyan/fx_10005_hit02_moyan",
		1,
		1,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		3100052,
		"jingling/fx_10005_moyan/fx_10005_hit01_moyan",
		1,
		4,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		3100061,
		"jingling/fx_10006_xuanwu/fx_10006_hit02_xuanwu",
		1,
		1,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		3100062,
		"jingling/fx_10006_xuanwu/fx_10006_hit01_xuanwu",
		1,
		1.1,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		3100071,
		"jingling/fx_10007_baihu/fx_10007_hit02_baihu",
		1,
		0.8,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		3100072,
		"jingling/fx_10007_baihu/fx_10007_hit01_baihu",
		1,
		1.5,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		3100081,
		"jingling/fx_10008_zhuque/fx_10008_hit02_zhuque",
		1,
		0.9,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		3100082,
		"jingling/fx_10008_zhuque/fx_10008_hit01_zhuque",
		1,
		0.6,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		3100141,
		"jingling/fx_10014_xiaobaolong/fx_10014_hit02_xiaobaolong",
		1,
		1.5,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		3100142,
		"jingling/fx_10014_xiaobaolong/fx_10014_hit01_xiaobaolong",
		1,
		1.5,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		4100031,
		"jingling/fx_10003_shennuoya/fx_10003_skill02_shennuoya",
		1,
		1.5,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		4100032,
		"jingling/fx_10003_shennuoya/fx_10003_skill01_shennuoya",
		1,
		11,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		4100034,
		"jingling/fx_10003_shennuoya/fx_10003_chaping01_shennuoya",
		1,
		3.5,
		1,
		"effectPoint",
		"SkillAnimation",
		1
	},
	{
		4100041,
		"jingling/fx_10004_baobaolong/fx_10004_skill02_baobaolong",
		1,
		1.5,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		4100042,
		"jingling/fx_10004_baobaolong/fx_10004_skill01_baobaolong",
		1,
		2.5,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		4100051,
		"jingling/fx_10005_moyan/fx_10005_skill02_moyan",
		1,
		2.5,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		4100052,
		"jingling/fx_10005_moyan/fx_10005_skill01_moyan",
		1,
		2.3,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		4100062,
		"jingling/fx_10006_xuanwu/fx_10006_skill01_xuanwu",
		1,
		1.8,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		4100071,
		"jingling/fx_10007_baihu/fx_10007_skill02_baihu",
		1,
		1,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		4100072,
		"jingling/fx_10007_baihu/fx_10007_skill01_baihu",
		1,
		2.1,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		3100151,
		"jingling/fx_10015_xinglanlong/fx_10015_hit02_xinglanlong_01",
		1,
		1,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		3100153,
		"jingling/fx_10015_xinglanlong/fx_10015_hit02_xinglanlong_02",
		1,
		2.1,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		3100152,
		"jingling/fx_10015_xinglanlong/fx_10015_hit01_xinglanlong",
		1,
		2,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		4100151,
		"jingling/fx_10015_xinglanlong/fx_10015_skill02_xinglanlong",
		1,
		2,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		4100152,
		"jingling/fx_10015_xinglanlong/fx_10015_skill01_xinglanlong_01",
		1,
		2.5,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		4100153,
		"jingling/fx_10015_xinglanlong/fx_10015_skill01_xinglanlong_02",
		1,
		1.5,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		6100151,
		"jingling/fx_10015_xinglanlong/fx_10015_chaping01_xinglanlong_01",
		1,
		1.6,
		1,
		"effectPoint",
		"SkillAnimation",
		1
	},
	{
		6100152,
		"jingling/fx_10015_xinglanlong/fx_10015_chaping01_xinglanlong_02",
		1,
		1.3,
		1,
		"effectPoint",
		"SkillAnimation",
		1
	},
	{
		7100151,
		"jingling/fx_10015_xinglanlong/fx_10015_fullscreen01_xinglanlong",
		1,
		0.8,
		1,
		"effectPoint",
		"SkillAnimation",
		1
	},
	{
		8100151,
		"jingling/fx_10015_xinglanlong/fx_10015_fxbigbg01_xinglanlong",
		1,
		5.5,
		1,
		"effectPoint",
		"",
		1
	},
	{
		101,
		"jingling/fx_10016_sagute/fx_10016_hit02_sagute",
		1,
		1.1,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		102,
		"jingling/fx_10016_sagute/fx_10016_skill01_sagute",
		1,
		2,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		103,
		"jingling/fx_10016_sagute/fx_10016_hit01_sagute",
		1,
		1.2,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		104,
		"jingling/fx_10016_sagute/fx_10016_chaping01_sagute",
		1,
		2,
		1,
		"effectPoint",
		"SkillAnimation",
		1
	},
	{
		105,
		"jingling/fx_10020_yundulingbao/fx_10020_skill02_yuandulingbao",
		1,
		1.8,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		106,
		"jingling/fx_10020_yundulingbao/fx_10020_hit02_yuandulingbao",
		1,
		1.6,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		107,
		"jingling/fx_10020_yundulingbao/fx_10020_skill01_yuandulingbao",
		1,
		2.6,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		108,
		"jingling/fx_10020_yundulingbao/fx_10020_hit01_yuandulingbao_01",
		1,
		2,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		109,
		"jingling/fx_10020_yundulingbao/fx_10020_hit01_yuandulingbao_02",
		1,
		1.1,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		110,
		"jingling/fx_10018_baojiajisi/fx_10018_skill02_baojiajisi",
		1,
		2,
		0,
		"hangPoints/foot",
		"",
		1
	},
	{
		111,
		"jingling/fx_10018_baojiajisi/fx_10018_skill01_baojiajisi",
		1,
		2.2,
		0,
		"hangPoints/foot",
		"",
		1
	},
	{
		112,
		"jingling/fx_10018_baojiajisi/fx_10018_hit01_baojiajisi_01",
		1,
		0.5,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		113,
		"jingling/fx_10018_baojiajisi/fx_10018_hit01_baojiajisi_02",
		1,
		0.5,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		114,
		"jingling/fx_10016_sagute/fx_10016_bullet02_sagute",
		0,
		0,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		115,
		"jingling/fx_10020_yundulingbao/fx_10020_bullet02_yuandulingbao",
		0,
		0,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		116,
		"jingling/fx_10006_xuanwu/fx_10006_bullet01_xuanwu",
		0,
		0,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		117,
		"jingling/fx_10019_kayagongzhu/fx_10019_skill02_kayagongzhu",
		1,
		1.1,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		118,
		"jingling/fx_10019_kayagongzhu/fx_10019_hit02_kayagongzhu",
		1,
		0.9,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		119,
		"jingling/fx_10019_kayagongzhu/fx_10019_skill01_kayagongzhu",
		1,
		3,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		120,
		"jingling/fx_10019_kayagongzhu/fx_10019_hit01_kayagongzhu",
		1,
		1.7,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		121,
		"jingling/fx_10019_kayagongzhu/fx_10019_bullet02_kayagongzhu",
		0,
		0,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		122,
		"jingling/fx_10014_xiaobaolong/fx_10014_skill01_xiaobaolong",
		1,
		2,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		123,
		"jingling/fx_10014_xiaobaolong/fx_10014_bullet01_xiaobaolong",
		0,
		0,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		124,
		"jingling/fx_10005_moyan/fx_10005_bullet02_moyan",
		0,
		0,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		125,
		"jingling/fx_10005_moyan/fx_10005_bullet01_moyan",
		0,
		0,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		126,
		"ui/fx_ui_buzhuo/win/fx_ui_win",
		1,
		2,
		1,
		"agent",
		"",
		1
	},
	{
		127,
		"ui/fx_ui_buzhuo/win/fx_ui_win_zi",
		1,
		1.7,
		1,
		"effectPoint",
		"SkillAnimation",
		1
	},
	{
		128,
		"ui/fx_ui_buzhuo/fx_ui_kebuzhuo",
		0,
		0,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		129,
		"ui/fx_ui_buzhuo/lose/fx_ui_lose",
		1,
		2,
		1,
		"agent",
		"",
		1
	},
	{
		130,
		"ui/fx_ui_buzhuo/lose/fx_ui_lose_zi",
		1,
		1.7,
		1,
		"effectPoint",
		"SkillAnimation",
		1
	},
	{
		131,
		"ui/fx_ui_buzhuo/fx_ui_bejin",
		0,
		0,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		132,
		"scene/fx_scene_jinhua",
		1,
		0,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		133,
		"common/hit/fx_hit_tongyong_0001_pugong",
		1,
		0.4,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		134,
		"common/hit/fx_hit_tongyong_0002_pugong02",
		1,
		0.4,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		135,
		"common/hit/fx_hit_tongyong_0003_huoyan",
		1,
		1.2,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		136,
		"common/hit/fx_hit_tongyong_0004_xuehua",
		1,
		1.2,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		137,
		"common/hit/fx_hit_tongyong_0005_shuye",
		1,
		1.2,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		138,
		"common/hit/fx_hit_tongyong_0006_guihun",
		1,
		1.2,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		139,
		"common/hit/fx_hit_tongyong_0007_ruiji",
		1,
		0.4,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		140,
		"common/hit/fx_hit_tongyong_0008_shuihua",
		1,
		1,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		141,
		"common/fx_hit_tongyong_0009_kehuan",
		1,
		1,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		142,
		"common/hit/fx_hit_tongyong_0010_shandian",
		1,
		1.1,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		143,
		"jingling/fx_10026_sanyeshou/fx_10026_bullet01_sanyeshou",
		0,
		0,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		144,
		"jingling/fx_10017_hanbingqishi/fx_10017_skill02_hanbingqishi_01",
		1,
		0.5,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		145,
		"jingling/fx_10017_hanbingqishi/fx_10017_skill02_hanbingqishi_02",
		1,
		1,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		146,
		"jingling/fx_10017_hanbingqishi/fx_10017_hit02_hanbingqishi",
		1,
		1,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		147,
		"jingling/fx_10017_hanbingqishi/fx_10017_skill01_hanbingqishi",
		1,
		3,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		148,
		"jingling/fx_10017_hanbingqishi/fx_10017_hit01_hanbingqishi",
		1,
		3,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		149,
		"jingling/fx_10028_shengguangfeilong/fx_10028_skill02_shengguangfeilong_01",
		1,
		2,
		0,
		"hangPoints/foot",
		"",
		1
	},
	{
		150,
		"jingling/fx_10028_shengguangfeilong/fx_10028_hit02_shengguangfeilong",
		1,
		0.6,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		151,
		"jingling/fx_10028_shengguangfeilong/fx_10028_skill01_shengguangfeilong_01",
		1,
		1.5,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		152,
		"jingling/fx_10028_shengguangfeilong/fx_10028_skill01_shengguangfeilong_01_camera",
		1,
		1.65,
		1,
		"effectPoint",
		"SkillAnimation",
		1
	},
	{
		153,
		"jingling/fx_10028_shengguangfeilong/fx_10028_skill01_shengguangfeilong_02_texie",
		1,
		3,
		1,
		"effectPoint",
		"",
		1
	},
	{
		155,
		"jingling/fx_10028_shengguangfeilong/fx_10028_hit01_shengguangfeilong02",
		1,
		4,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		157,
		"common/buff/fx_buff_31_hunluan",
		0,
		0,
		1,
		"hangPoints/head",
		"",
		0
	},
	{
		158,
		"common/buff/fx_buff_34_moyandun",
		0,
		0,
		1,
		"hangPoints/center",
		"",
		1
	},
	{
		159,
		"common/buff/fx_buff_45_chaofeng",
		0,
		0,
		1,
		"hangPoints/head",
		"",
		1
	},
	{
		160,
		"common/buff/fx_buff_46_xuanyun",
		0,
		0,
		1,
		"hangPoints/head",
		"",
		1
	},
	{
		161,
		"common/buff/fx_buff_52_mianyi",
		0,
		0,
		1,
		"hangPoints/center",
		"",
		0
	},
	{
		162,
		"common/buff/fx_buff_bianshen",
		1,
		3,
		0,
		"hangPoints/foot",
		"",
		1
	},
	{
		163,
		"jingling/fx_10028_shengguangfeilong/fx_10028_skill02_shengguangfeilong_02",
		1,
		1,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		164,
		"jingling/fx_10028_shengguangfeilong/fx_10028_skill02_shengguangfeilong_03",
		1,
		1,
		0,
		"hangPoints/foot",
		"",
		1
	},
	{
		165,
		"jingling/fx_10029_shengguangbaojian/fx_10029_skill02_shengguangbaojian_02",
		1,
		1.5,
		0,
		"hangPoints/foot",
		"",
		0
	},
	{
		166,
		"jingling/fx_10029_shengguangbaojian/fx_10029_skill01_shengguangbaojian",
		1,
		2,
		0,
		"hangPoints/foot",
		"",
		0
	},
	{
		167,
		"jingling/fx_10029_shengguangbaojian/fx_10029_hit02_shengguangbaojian",
		1,
		1.3,
		1,
		"hangPoints/foot",
		"",
		1
	},
	{
		168,
		"common/fullscreen/fx_fullscreen_tongyong_0001_posui",
		0,
		1,
		0,
		"effectPoint",
		"SkillAnimation",
		1
	}
}
local t_effect = {
	dataList[1],
	dataList[2],
	dataList[3],
	[6] = dataList[4],
	[8] = dataList[5],
	[2100031] = dataList[6],
	[2100042] = dataList[7],
	[2100082] = dataList[8],
	[3100021] = dataList[9],
	[3100022] = dataList[10],
	[3100031] = dataList[11],
	[3100032] = dataList[12],
	[3100041] = dataList[13],
	[3100042] = dataList[14],
	[3100051] = dataList[15],
	[3100052] = dataList[16],
	[3100061] = dataList[17],
	[3100062] = dataList[18],
	[3100071] = dataList[19],
	[3100072] = dataList[20],
	[3100081] = dataList[21],
	[3100082] = dataList[22],
	[3100141] = dataList[23],
	[3100142] = dataList[24],
	[4100031] = dataList[25],
	[4100032] = dataList[26],
	[4100034] = dataList[27],
	[4100041] = dataList[28],
	[4100042] = dataList[29],
	[4100051] = dataList[30],
	[4100052] = dataList[31],
	[4100062] = dataList[32],
	[4100071] = dataList[33],
	[4100072] = dataList[34],
	[3100151] = dataList[35],
	[3100153] = dataList[36],
	[3100152] = dataList[37],
	[4100151] = dataList[38],
	[4100152] = dataList[39],
	[4100153] = dataList[40],
	[6100151] = dataList[41],
	[6100152] = dataList[42],
	[7100151] = dataList[43],
	[8100151] = dataList[44],
	[101] = dataList[45],
	[102] = dataList[46],
	[103] = dataList[47],
	[104] = dataList[48],
	[105] = dataList[49],
	[106] = dataList[50],
	[107] = dataList[51],
	[108] = dataList[52],
	[109] = dataList[53],
	[110] = dataList[54],
	[111] = dataList[55],
	[112] = dataList[56],
	[113] = dataList[57],
	[114] = dataList[58],
	[115] = dataList[59],
	[116] = dataList[60],
	[117] = dataList[61],
	[118] = dataList[62],
	[119] = dataList[63],
	[120] = dataList[64],
	[121] = dataList[65],
	[122] = dataList[66],
	[123] = dataList[67],
	[124] = dataList[68],
	[125] = dataList[69],
	[126] = dataList[70],
	[127] = dataList[71],
	[128] = dataList[72],
	[129] = dataList[73],
	[130] = dataList[74],
	[131] = dataList[75],
	[132] = dataList[76],
	[133] = dataList[77],
	[134] = dataList[78],
	[135] = dataList[79],
	[136] = dataList[80],
	[137] = dataList[81],
	[138] = dataList[82],
	[139] = dataList[83],
	[140] = dataList[84],
	[141] = dataList[85],
	[142] = dataList[86],
	[143] = dataList[87],
	[144] = dataList[88],
	[145] = dataList[89],
	[146] = dataList[90],
	[147] = dataList[91],
	[148] = dataList[92],
	[149] = dataList[93],
	[150] = dataList[94],
	[151] = dataList[95],
	[152] = dataList[96],
	[153] = dataList[97],
	[155] = dataList[98],
	[157] = dataList[99],
	[158] = dataList[100],
	[159] = dataList[101],
	[160] = dataList[102],
	[161] = dataList[103],
	[162] = dataList[104],
	[163] = dataList[105],
	[164] = dataList[106],
	[165] = dataList[107],
	[166] = dataList[108],
	[167] = dataList[109],
	[168] = dataList[110]
}

t_effect.dataList = dataList

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

return t_effect
