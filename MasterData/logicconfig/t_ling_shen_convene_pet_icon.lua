-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ling_shen_convene_pet_icon.lua

module("logicconfig.config.t_ling_shen_convene_pet_icon", package.seeall)

local title = {
	sortId = 5,
	startUnlockTime = 4,
	lihuiPos = 8,
	unlockCost = 3,
	lihuiResPath = 7,
	iconPlanId = 1,
	pos = 6,
	iconId = 2,
	lihuiScale = 9,
	detailId = 10
}
local dataList = {
	{
		1,
		1,
		"10:375001:30",
		"2024-05-31T05:00:00",
		1,
		{
			-264,
			-21
		},
		"btn_lsjj_07",
		{
			24,
			-15
		},
		1,
		7
	},
	{
		1,
		2,
		"10:375001:30",
		"2024-06-14T05:00:00",
		2,
		{
			39,
			146
		},
		"btn_lsjj_08",
		{
			30,
			13
		},
		1,
		8
	},
	{
		1,
		3,
		"10:375001:30",
		"2024-06-14T05:00:00",
		3,
		{
			319,
			-4
		},
		"btn_lsjj_13",
		{
			-20,
			-2
		},
		1,
		9
	},
	{
		2,
		1,
		"10:375001:40",
		"2024-06-14T05:00:00",
		1,
		{
			-302,
			-37
		},
		"btn_lsjj_02",
		{
			13,
			-30
		},
		1,
		4
	},
	{
		2,
		2,
		"10:375001:40",
		"2024-05-31T05:00:00",
		2,
		{
			-174,
			203
		},
		"btn_lsjj_01",
		{
			-1,
			-25
		},
		1,
		5
	},
	{
		2,
		3,
		"10:375001:40",
		"2024-05-31T05:00:00",
		3,
		{
			48,
			16
		},
		"btn_lsjj_03",
		{
			14,
			-5
		},
		1,
		3
	},
	{
		2,
		4,
		"10:375001:40",
		"2024-05-31T05:00:00",
		4,
		{
			297,
			192
		},
		"btn_lsjj_04",
		{
			6,
			-3
		},
		1,
		6
	},
	{
		3,
		1,
		"10:375001:50",
		"2024-05-31T05:00:00",
		1,
		{
			-205,
			48
		},
		"btn_lsjj_09",
		{
			35,
			3
		},
		1,
		1
	},
	{
		3,
		2,
		"10:375001:50",
		"2024-05-31T05:00:00",
		2,
		{
			270,
			50
		},
		"btn_lsjj_10",
		{
			14,
			3
		},
		1,
		2
	}
}
local t_ling_shen_convene_pet_icon = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	{
		dataList[8],
		dataList[9]
	}
}

t_ling_shen_convene_pet_icon.dataList = dataList

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

return t_ling_shen_convene_pet_icon
