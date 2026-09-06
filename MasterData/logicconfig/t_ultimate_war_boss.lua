-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_war_boss.lua

module("logicconfig.config.t_ultimate_war_boss", package.seeall)

local title = {
	supportPetPlanId = 4,
	bossId = 2,
	pos = 6,
	skinId = 5,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		434001,
		1,
		6002,
		6,
		14023,
		{
			-530,
			-65
		}
	},
	{
		434001,
		2,
		6003,
		6,
		15027,
		{
			-270,
			-140
		}
	},
	{
		434001,
		3,
		6004,
		6,
		16026,
		{
			0,
			-165
		}
	},
	{
		434001,
		4,
		6005,
		6,
		17012,
		{
			270,
			-140
		}
	},
	{
		434001,
		5,
		6006,
		6,
		11012,
		{
			530,
			-65
		}
	}
}
local t_ultimate_war_boss = {
	[434001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_ultimate_war_boss.dataList = dataList

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

return t_ultimate_war_boss
