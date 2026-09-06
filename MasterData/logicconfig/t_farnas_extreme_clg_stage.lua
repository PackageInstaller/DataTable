-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_farnas_extreme_clg_stage.lua

module("logicconfig.config.t_farnas_extreme_clg_stage", package.seeall)

local title = {
	stageId = 2,
	iconPath = 5,
	pos = 6,
	enemyBuffDesc = 7,
	creepsMasterId = 3,
	dodgeCount = 4,
	activityId = 1
}
local dataList = {
	{
		333001,
		1,
		1001,
		10,
		"ui/icon/character/icon_14020_wangzhenuoya",
		{
			-191,
			230
		},
		"敌阵精灵拥有额外的50%命中率"
	},
	{
		333001,
		2,
		1002,
		10,
		"ui/icon/character/icon_11014_tuntian",
		{
			-17,
			127
		},
		"敌阵精灵拥有额外的50%命中率"
	},
	{
		333001,
		3,
		1003,
		10,
		"ui/icon/character/icon_13013_kunlun",
		{
			115,
			-18
		},
		"敌阵精灵拥有额外的50%命中率"
	},
	{
		333001,
		4,
		1004,
		10,
		"ui/icon/character/icon_14017_wudi",
		{
			-2,
			-178
		},
		"敌阵精灵拥有额外的50%命中率"
	},
	{
		333001,
		5,
		1005,
		10,
		"ui/icon/character/icon_13009_shenyaoaruisi",
		{
			-191,
			-257
		},
		"敌阵精灵拥有额外的50%命中率"
	},
	{
		333001,
		6,
		1006,
		10,
		"ui/icon/character/icon_11010_wangzhemengmeng",
		{
			-360,
			-178
		},
		"敌阵精灵拥有额外的50%命中率"
	},
	{
		333002,
		1,
		1001,
		10,
		"ui/icon/character/icon_14020_wangzhenuoya",
		{
			-191,
			230
		},
		"敌阵精灵拥有额外的50%命中率"
	},
	{
		333002,
		2,
		1002,
		10,
		"ui/icon/character/icon_11014_tuntian",
		{
			-17,
			127
		},
		"敌阵精灵拥有额外的50%命中率"
	},
	{
		333002,
		3,
		1003,
		10,
		"ui/icon/character/icon_13013_kunlun",
		{
			115,
			-18
		},
		"敌阵精灵拥有额外的50%命中率"
	},
	{
		333002,
		4,
		1004,
		10,
		"ui/icon/character/icon_14017_wudi",
		{
			-2,
			-178
		},
		"敌阵精灵拥有额外的50%命中率"
	},
	{
		333002,
		5,
		1005,
		10,
		"ui/icon/character/icon_13009_shenyaoaruisi",
		{
			-191,
			-257
		},
		"敌阵精灵拥有额外的50%命中率"
	},
	{
		333002,
		6,
		1006,
		10,
		"ui/icon/character/icon_11010_wangzhemengmeng",
		{
			-360,
			-178
		},
		"敌阵精灵拥有额外的50%命中率"
	}
}
local t_farnas_extreme_clg_stage = {
	[333001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[333002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_farnas_extreme_clg_stage.dataList = dataList

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

return t_farnas_extreme_clg_stage
