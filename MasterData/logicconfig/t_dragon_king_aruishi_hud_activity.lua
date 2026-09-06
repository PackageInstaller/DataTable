-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_king_aruishi_hud_activity.lua

module("logicconfig.config.t_dragon_king_aruishi_hud_activity", package.seeall)

local title = {
	showNum = 7,
	deductTime = 6,
	activityId = 1,
	skinId = 3,
	totalTime = 5,
	questionBank = 8,
	prize = 2,
	ruleKey = 4
}
local dataList = {
	{
		506001,
		"9:1300025:1",
		14036,
		"aruishi_hud_rule_tips",
		60,
		2,
		6,
		1
	},
	{
		506002,
		"4:36:10",
		17024,
		"aruishi_hud_rule_tips",
		60,
		2,
		6,
		2
	},
	{
		506003,
		"4:31:5",
		15041,
		"aruishi_hud_rule_tips",
		60,
		2,
		6,
		3
	}
}
local t_dragon_king_aruishi_hud_activity = {
	[506001] = dataList[1],
	[506002] = dataList[2],
	[506003] = dataList[3]
}

t_dragon_king_aruishi_hud_activity.dataList = dataList

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

return t_dragon_king_aruishi_hud_activity
