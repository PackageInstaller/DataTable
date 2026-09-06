-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_surround_by_dream_girl_invest_plan.lua

module("logicconfig.config.t_surround_by_dream_girl_invest_plan", package.seeall)

local title = {
	cost = 4,
	fetterLimit = 5,
	investPlanId = 1,
	shopSizeDesc = 3,
	propName = 8,
	moneyAddSpeed = 6,
	prize = 7,
	level = 2
}
local dataList = {
	{
		1,
		0,
		"未建设",
		0,
		0,
		0,
		"",
		""
	},
	{
		1,
		1,
		"地摊",
		2500,
		1,
		10,
		"10:453001:200",
		"木质桌椅"
	},
	{
		1,
		2,
		"工作室",
		6000,
		200,
		25,
		"10:459001:75",
		"皮质桌椅"
	},
	{
		1,
		3,
		"小型连锁",
		12000,
		500,
		50,
		"10:453001:250",
		"电动桌椅"
	},
	{
		1,
		4,
		"大型企业",
		20000,
		1000,
		80,
		"10:459001:100",
		"镶银棋牌"
	},
	{
		1,
		5,
		"跨国企业",
		30000,
		3000,
		120,
		"10:453001:300",
		"金玉棋牌"
	},
	{
		2,
		0,
		"未建设",
		0,
		0,
		0,
		"",
		""
	},
	{
		2,
		1,
		"地摊",
		7000,
		1,
		30,
		"10:453001:200",
		"简易工作台"
	},
	{
		2,
		2,
		"工作室",
		15000,
		200,
		60,
		"10:459002:75",
		"标准工作台"
	},
	{
		2,
		3,
		"小型连锁",
		25000,
		500,
		100,
		"10:453001:250",
		"智能工作台"
	},
	{
		2,
		4,
		"大型企业",
		40000,
		1000,
		160,
		"10:459002:100",
		"数控系统"
	},
	{
		2,
		5,
		"跨国企业",
		60000,
		3000,
		250,
		"10:453001:300",
		"全息投影"
	},
	{
		3,
		0,
		"未建设",
		0,
		0,
		0,
		"",
		""
	},
	{
		3,
		1,
		"地摊",
		10000,
		1,
		40,
		"10:453001:200",
		"纸质星图"
	},
	{
		3,
		2,
		"工作室",
		20000,
		200,
		80,
		"10:459003:75",
		"皮质星图"
	},
	{
		3,
		3,
		"小型连锁",
		40000,
		500,
		160,
		"10:453001:250",
		"电子星图"
	},
	{
		3,
		4,
		"大型企业",
		65000,
		1000,
		270,
		"10:459003:100",
		"3D星空投影"
	},
	{
		3,
		5,
		"跨国企业",
		100000,
		3000,
		400,
		"10:453001:300",
		"全息星空模拟仓"
	},
	{
		4,
		0,
		"未建设",
		0,
		0,
		0,
		"",
		""
	},
	{
		4,
		1,
		"地摊",
		25000,
		1,
		100,
		"10:453001:200",
		"塑料蜘蛛装饰"
	},
	{
		4,
		2,
		"工作室",
		60000,
		200,
		250,
		"10:459004:75",
		"骷髅装饰"
	},
	{
		4,
		3,
		"小型连锁",
		95000,
		500,
		400,
		"10:453001:250",
		"电动鬼怪人偶"
	},
	{
		4,
		4,
		"大型企业",
		150000,
		1000,
		600,
		"10:459004:100",
		"VR/AR设备"
	},
	{
		4,
		5,
		"跨国企业",
		250000,
		3000,
		1000,
		"10:453001:300",
		"AI仿生人"
	}
}
local t_surround_by_dream_girl_invest_plan = {
	{
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		[0] = dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
		[0] = dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	},
	{
		[0] = dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24]
	}
}

t_surround_by_dream_girl_invest_plan.dataList = dataList

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

return t_surround_by_dream_girl_invest_plan
