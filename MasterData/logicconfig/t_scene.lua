-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scene.lua

module("logicconfig.config.t_scene", package.seeall)

local title = {
	bgmIds = 6,
	eng_scene_name = 2,
	showImage = 9,
	type = 5,
	sceneCls = 16,
	ambientColor = 12,
	scene_name = 3,
	sceneParams = 13,
	resName = 4,
	mapViewId = 14,
	scenePic = 7,
	screenEff = 10,
	id = 1,
	bornScene = 15,
	fitFullScreen = 11,
	magicLevel = 8
}
local dataList = {
	{
		1001,
		"aoqicheng",
		"奥奇城",
		{
			"aoqicheng"
		},
		1,
		{
			10101,
			10102
		},
		0,
		1,
		"aoqicheng.png",
		"",
		false,
		{
			255,
			255,
			255
		},
		nil,
		0,
		true,
		""
	},
	{
		103,
		"library",
		"图书馆",
		{
			"library"
		},
		1,
		{
			10301
		},
		0,
		1,
		"tushuguan.png",
		"",
		false,
		nil,
		nil,
		1001,
		true,
		""
	},
	{
		104,
		"zhanshuzhongxin",
		"阵法空间",
		{
			"zhanshuzhongxin"
		},
		1,
		{
			10400
		},
		0,
		1,
		"zhenfakongjian.png",
		"",
		false,
		nil,
		nil,
		1001,
		true,
		""
	},
	{
		105,
		"jingjichang",
		"竞技场",
		{
			"jingjichang"
		},
		1,
		{
			10501
		},
		0,
		1,
		"jingjichang.png",
		"",
		false,
		nil,
		nil,
		1001,
		true,
		""
	},
	{
		106,
		"mengzhidao",
		"梦之岛",
		{
			"mengzhidao"
		},
		1,
		{
			12000
		},
		0,
		1,
		"mengzhidao.png",
		"",
		false,
		nil,
		nil,
		0,
		true,
		""
	},
	{
		107,
		"zhaohuanshidalu",
		"召唤师大陆",
		{
			"zhaohuanshidalu"
		},
		1,
		{
			11300
		},
		0,
		1,
		"zhaohuanshidalu.png",
		"",
		false,
		nil,
		nil,
		0,
		true,
		""
	},
	{
		108,
		"wujinzhihai",
		"无尽之海",
		{
			"wujinzhihai"
		},
		1,
		{
			11000
		},
		0,
		1,
		"wujinzhihai.png",
		"",
		false,
		nil,
		nil,
		0,
		true,
		""
	},
	{
		111,
		"shazhimicheng",
		"砂之迷城",
		{
			"shazhimicheng"
		},
		1,
		{
			11800
		},
		0,
		10,
		"shazhimicheng.png",
		"",
		false,
		nil,
		nil,
		118,
		true,
		""
	},
	{
		114,
		"lanlongwan",
		"蓝龙湾",
		{
			"lanlongwan"
		},
		1,
		{
			11400
		},
		0,
		1,
		"lanlongwan.png",
		"fx_scene_binghaihuanjing/prefab/fx_scene_bhhj_huanjing_01",
		false,
		nil,
		nil,
		0,
		true,
		""
	},
	{
		117,
		"shuguangsenlin_01",
		"曙光森林",
		{
			"shuguangsenlin_01"
		},
		1,
		{
			11700
		},
		0,
		1,
		"shuguangsenlin.png",
		"",
		false,
		nil,
		nil,
		0,
		true,
		""
	},
	{
		118,
		"shazhiguo",
		"砂之国",
		{
			"shazhiguo"
		},
		1,
		{
			11800
		},
		0,
		1,
		"shazhiguo.png",
		"",
		false,
		nil,
		nil,
		0,
		true,
		""
	},
	{
		119,
		"xingshenjie_01",
		"星神界",
		{
			"xingshenjie_01"
		},
		1,
		{
			11500
		},
		0,
		1,
		"xingshenjie.png",
		"",
		false,
		nil,
		nil,
		0,
		true,
		""
	},
	{
		120,
		"shuzuizhexiagu",
		"赎罪者峡谷",
		{
			"shuzuizhexiagu"
		},
		1,
		{
			11900
		},
		0,
		1,
		"shuzuizhexiagu.png",
		"",
		false,
		nil,
		nil,
		0,
		true,
		""
	},
	{
		121,
		"caoxishendian",
		"生命神殿",
		{
			"caoxishendian"
		},
		1,
		{
			10200
		},
		0,
		1,
		"caoxishendian.png",
		"",
		false,
		nil,
		nil,
		117,
		true,
		""
	},
	{
		122,
		"ciyuanliefeng",
		"次元裂缝",
		{
			"ciyuanliefeng"
		},
		1,
		{
			10700
		},
		0,
		10,
		"ciyuanliefeng.png",
		"",
		false,
		nil,
		nil,
		117,
		true,
		""
	},
	{
		123,
		"liliangshendian",
		"力量神殿",
		{
			"liliangshendian"
		},
		1,
		{
			10200
		},
		0,
		1,
		"liliangshendian.png",
		"",
		false,
		nil,
		nil,
		118,
		true,
		""
	},
	{
		124,
		"suhuixukong",
		"溯回虚空",
		{
			"suhuixukong"
		},
		1,
		{
			10200
		},
		0,
		1,
		"youkongzhicheng.png",
		"",
		false,
		nil,
		nil,
		117,
		true,
		""
	},
	{
		125,
		"datichangjing",
		"答题场景",
		{
			"answerscene"
		},
		1,
		{
			10200
		},
		0,
		1,
		"youkongzhicheng.png",
		"",
		false,
		nil,
		nil,
		117,
		false,
		"CORoadAnswerScene"
	},
	{
		126,
		"yelancheng",
		"夜阑城",
		{
			"yelancheng"
		},
		1,
		{
			11000
		},
		0,
		1,
		"yelancheng.png",
		"",
		false,
		nil,
		nil,
		117,
		false,
		""
	},
	{
		127,
		"jingxiangshijie",
		"镜像世界",
		{
			"jingxiangshijie"
		},
		1,
		{
			11000
		},
		0,
		1,
		"jingxiangshijie.png",
		"",
		false,
		nil,
		nil,
		117,
		false,
		""
	},
	{
		128,
		"shengqidao",
		"流离之屿",
		{
			"shengqidao"
		},
		1,
		{
			11000
		},
		0,
		1,
		"liulizhidao.png",
		"",
		false,
		nil,
		nil,
		0,
		true,
		""
	},
	{
		129,
		"yuejuliandong",
		"粤剧联动",
		{
			"yuejuliandong"
		},
		1,
		{
			12001
		},
		0,
		1,
		"jingxiangshijie.png",
		"",
		false,
		nil,
		nil,
		0,
		true,
		""
	}
}
local t_scene = {
	[1001] = dataList[1],
	[103] = dataList[2],
	[104] = dataList[3],
	[105] = dataList[4],
	[106] = dataList[5],
	[107] = dataList[6],
	[108] = dataList[7],
	[111] = dataList[8],
	[114] = dataList[9],
	[117] = dataList[10],
	[118] = dataList[11],
	[119] = dataList[12],
	[120] = dataList[13],
	[121] = dataList[14],
	[122] = dataList[15],
	[123] = dataList[16],
	[124] = dataList[17],
	[125] = dataList[18],
	[126] = dataList[19],
	[127] = dataList[20],
	[128] = dataList[21],
	[129] = dataList[22]
}

t_scene.dataList = dataList

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

return t_scene
