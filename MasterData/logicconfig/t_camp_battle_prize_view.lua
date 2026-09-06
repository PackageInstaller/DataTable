-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_battle_prize_view.lua

module("logicconfig.config.t_camp_battle_prize_view", package.seeall)

local title = {
	param = 2,
	prizeViewPlanId = 1,
	prizeView = 3
}
local dataList = {
	{
		1,
		"PRIZE_INSPIRE1",
		"10:187002#4:510075"
	},
	{
		1,
		"PRIZE_INSPIRE2",
		"10:187002#4:510075"
	},
	{
		1,
		"PRIZE_BATTLE1",
		"10:187002#4:510076"
	},
	{
		1,
		"PRIZE_BATTLE2",
		"10:187002#4:510076"
	},
	{
		1,
		"PRIZE_BATTLE3",
		"10:187002#4:510076"
	},
	{
		1,
		"PRIZE_BATTLE4",
		"10:187002#4:510076"
	},
	{
		1,
		"PRIZE_INTRUDER",
		"10:187002#4:510076"
	},
	{
		2,
		"PRIZE_INSPIRE1",
		"10:187002#4:510075"
	},
	{
		2,
		"PRIZE_INSPIRE2",
		"10:187002#4:510075"
	},
	{
		2,
		"PRIZE_BATTLE1",
		"10:187002#4:510076"
	},
	{
		2,
		"PRIZE_BATTLE2",
		"10:187002#4:510076"
	},
	{
		2,
		"PRIZE_BATTLE3",
		"10:187002#4:510076"
	},
	{
		2,
		"PRIZE_BATTLE4",
		"10:187002#4:510076"
	},
	{
		2,
		"PRIZE_INTRUDER",
		"10:187002#4:510076"
	}
}
local t_camp_battle_prize_view = {
	{
		PRIZE_INSPIRE1 = dataList[1],
		PRIZE_INSPIRE2 = dataList[2],
		PRIZE_BATTLE1 = dataList[3],
		PRIZE_BATTLE2 = dataList[4],
		PRIZE_BATTLE3 = dataList[5],
		PRIZE_BATTLE4 = dataList[6],
		PRIZE_INTRUDER = dataList[7]
	},
	{
		PRIZE_INSPIRE1 = dataList[8],
		PRIZE_INSPIRE2 = dataList[9],
		PRIZE_BATTLE1 = dataList[10],
		PRIZE_BATTLE2 = dataList[11],
		PRIZE_BATTLE3 = dataList[12],
		PRIZE_BATTLE4 = dataList[13],
		PRIZE_INTRUDER = dataList[14]
	}
}

t_camp_battle_prize_view.dataList = dataList

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

return t_camp_battle_prize_view
