-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wisdom_courage_clg_boss.lua

module("logicconfig.config.t_wisdom_courage_clg_boss", package.seeall)

local title = {
	bossId = 2,
	skinId = 4,
	creepsMasterId = 3,
	activityId = 1,
	desc = 5
}
local dataList = {
	{
		456001,
		1,
		2001,
		14000,
		"1.挑战过程中，将在三个大回合后结束战斗。\n2.战斗结束后将记录历史最高伤害"
	},
	{
		456001,
		2,
		2002,
		16015,
		"1.挑战过程中，将在五个大回合后结束战斗。\n2.战斗结束后将记录历史最高伤害"
	},
	{
		456001,
		3,
		2003,
		17016,
		"1.挑战过程中，将在七个大回合后结束战斗。\n2.战斗结束后将记录历史最高伤害"
	}
}
local t_wisdom_courage_clg_boss = {
	[456001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_wisdom_courage_clg_boss.dataList = dataList

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

return t_wisdom_courage_clg_boss
