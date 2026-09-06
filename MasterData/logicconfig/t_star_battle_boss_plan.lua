-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_battle_boss_plan.lua

module("logicconfig.config.t_star_battle_boss_plan", package.seeall)

local title = {
	bossId = 2,
	bossPlanId = 1,
	showSort = 5,
	bossLihui = 6,
	creepsMasterId = 3,
	bossCreepsId = 4
}
local dataList = {
	{
		1,
		1,
		1041,
		1,
		{
			1,
			7,
			2,
			3,
			8,
			4,
			5,
			9,
			6
		},
		11030
	},
	{
		2,
		1,
		1042,
		2,
		nil,
		11033
	},
	{
		3,
		1,
		1043,
		1,
		nil,
		14036
	},
	{
		4,
		1,
		1044,
		1,
		nil,
		11021
	},
	{
		4,
		2,
		1045,
		1,
		nil,
		12018
	}
}
local t_star_battle_boss_plan = {
	{
		dataList[1]
	},
	{
		dataList[2]
	},
	{
		dataList[3]
	},
	{
		dataList[4],
		dataList[5]
	}
}

t_star_battle_boss_plan.dataList = dataList

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

return t_star_battle_boss_plan
