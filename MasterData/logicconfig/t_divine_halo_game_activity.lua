-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_halo_game_activity.lua

module("logicconfig.config.t_divine_halo_game_activity", package.seeall)

local title = {
	storeTimesLimit = 4,
	ruleId = 5,
	dailyRegisterGainTimes = 2,
	dailyBuyTimesLimit = 3,
	jumpTo = 6,
	skinId = 7,
	activityId = 1,
	ruleKey = 8
}
local dataList = {
	{
		476001,
		5,
		15,
		15,
		1,
		{
			"func#618#14035",
			"mibao#shenyaolibao",
			"func#545#20",
			"ui#lottery",
			"mibao#shengqiyangcheng"
		},
		14035,
		"shenyaoguanglungame_rule"
	}
}
local t_divine_halo_game_activity = {
	[476001] = dataList[1]
}

t_divine_halo_game_activity.dataList = dataList

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

return t_divine_halo_game_activity
