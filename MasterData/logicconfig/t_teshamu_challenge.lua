-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_teshamu_challenge.lua

module("logicconfig.config.t_teshamu_challenge", package.seeall)

local title = {
	jump_give = 3,
	signInBuffPlanId = 8,
	jump_exchange = 5,
	coin = 7,
	jump_shop = 4,
	raceId = 6,
	activityId = 1,
	jump_rank = 2
}
local dataList = {
	{
		288001,
		"func#618#11012",
		"func#926",
		"func#191#288#288001",
		"",
		11012,
		"4:510208:1",
		0
	},
	{
		288002,
		"func#618#14029",
		"mibao#shenyaonuoya5",
		"func#545#22",
		"func#191#288#288002",
		14029,
		"4:253:1",
		288002
	}
}
local t_teshamu_challenge = {
	[288001] = dataList[1],
	[288002] = dataList[2]
}

t_teshamu_challenge.dataList = dataList

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

return t_teshamu_challenge
