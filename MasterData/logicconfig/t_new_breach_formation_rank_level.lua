-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_breach_formation_rank_level.lua

module("logicconfig.config.t_new_breach_formation_rank_level", package.seeall)

local title = {
	score = 3,
	name = 4,
	rankId = 2,
	resImg = 5,
	rankLevelPlanId = 1
}
local dataList = {
	{
		1,
		1,
		0,
		"青铜",
		"board_pztx_badge01"
	},
	{
		1,
		2,
		500,
		"青铜",
		"board_pztx_badge01"
	},
	{
		1,
		3,
		1000,
		"白银",
		"board_pztx_badge02"
	},
	{
		1,
		4,
		1500,
		"黄金",
		"board_pztx_badge03"
	},
	{
		1,
		5,
		2000,
		"白金",
		"board_pztx_badge04"
	},
	{
		1,
		6,
		2500,
		"钻石",
		"board_pztx_badge01"
	},
	{
		1,
		7,
		3000,
		"青光",
		"board_pztx_badge02"
	},
	{
		1,
		8,
		4000,
		"传说",
		"board_pztx_badge03"
	},
	{
		1,
		9,
		5000,
		"无敌",
		"board_pztx_badge04"
	}
}
local t_new_breach_formation_rank_level = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_new_breach_formation_rank_level.dataList = dataList

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

return t_new_breach_formation_rank_level
