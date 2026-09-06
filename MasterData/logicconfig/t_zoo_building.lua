-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_building.lua

module("logicconfig.config.t_zoo_building", package.seeall)

local title = {
	optionsPos = 6,
	name = 3,
	unlockCost = 8,
	desc = 4,
	workProduction = 9,
	buildingType = 2,
	unlockNeedMainLv = 7,
	id = 1,
	icon = 5
}
local dataList = {
	{
		1000,
		1,
		"主城",
		"建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息",
		"ui/icon/headicon/com_piayer_xmw.png",
		{
			-1,
			-0.5
		},
		0,
		"",
		""
	},
	{
		1001,
		2,
		"餐厅",
		"建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息",
		"ui/icon/headicon/com_piayer_xmw.png",
		{
			-1,
			-0.5
		},
		0,
		"",
		"8:1:1"
	},
	{
		1002,
		3,
		"商店",
		"建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息",
		"ui/icon/headicon/com_piayer_xmw.png",
		{
			-1,
			-0.5
		},
		0,
		"",
		""
	},
	{
		1003,
		4,
		"咖啡厅",
		"建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息",
		"ui/icon/headicon/com_piayer_xmw.png",
		{
			-1,
			-0.5
		},
		0,
		"",
		"8:1:1"
	},
	{
		1004,
		5,
		"游乐园",
		"建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息",
		"ui/icon/headicon/com_piayer_xmw.png",
		{
			-1,
			-0.5
		},
		0,
		"",
		"8:1:1"
	},
	{
		1005,
		6,
		"化石场",
		"建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息",
		"ui/icon/headicon/com_piayer_xmw.png",
		{
			-1,
			-0.5
		},
		0,
		"",
		"4:2:1"
	},
	{
		1006,
		7,
		"远古巨树",
		"建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息",
		"ui/icon/headicon/com_piayer_xmw.png",
		{
			-1,
			-0.5
		},
		0,
		"",
		""
	},
	{
		1007,
		8,
		"孵蛋机",
		"建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息",
		"ui/icon/headicon/com_piayer_xmw.png",
		{
			-1,
			-0.5
		},
		0,
		"",
		""
	},
	{
		1008,
		9,
		"传送门",
		"建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息",
		"ui/icon/headicon/com_piayer_xmw.png",
		{
			-1,
			-0.5
		},
		2,
		"8:1:1",
		""
	},
	{
		1009,
		10,
		"旅人",
		"建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息",
		"ui/icon/headicon/com_piayer_xmw.png",
		{
			-1,
			-0.5
		},
		0,
		"",
		""
	},
	{
		1010,
		11,
		"水池",
		"建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息",
		"ui/icon/headicon/com_piayer_xmw.png",
		{
			-1,
			-0.5
		},
		0,
		"",
		""
	},
	{
		1011,
		12,
		"传送位置",
		"建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息建筑信息",
		"ui/icon/headicon/com_piayer_xmw.png",
		{
			-1,
			-0.5
		},
		0,
		"",
		""
	}
}
local t_zoo_building = {
	[1000] = dataList[1],
	[1001] = dataList[2],
	[1002] = dataList[3],
	[1003] = dataList[4],
	[1004] = dataList[5],
	[1005] = dataList[6],
	[1006] = dataList[7],
	[1007] = dataList[8],
	[1008] = dataList[9],
	[1009] = dataList[10],
	[1010] = dataList[11],
	[1011] = dataList[12]
}

t_zoo_building.dataList = dataList

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

return t_zoo_building
