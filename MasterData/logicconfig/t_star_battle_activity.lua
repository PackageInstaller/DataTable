-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_battle_activity.lua

module("logicconfig.config.t_star_battle_activity", package.seeall)

local title = {
	dailyChallengeBossTimes = 2,
	isBeginnerDays = 3,
	showItem = 9,
	changeJump = 8,
	transformBuffId = 4,
	petValidator = 5,
	redPointId = 6,
	activityId = 1,
	ruleKey = 7
}
local dataList = {
	{
		510001,
		5,
		30,
		30000025,
		"StrengthenRaceType$水|StrengthenRaceType$火",
		723,
		"star_battle_rule_key",
		"func#191#510#510001",
		"1004:1553"
	}
}
local t_star_battle_activity = {
	[510001] = dataList[1]
}

t_star_battle_activity.dataList = dataList

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

return t_star_battle_activity
