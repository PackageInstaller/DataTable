-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tun_tian_help_rule.lua

module("logicconfig.config.t_tun_tian_help_rule", package.seeall)

local title = {
	rulePlanId = 1,
	picturePath = 4,
	ruleId = 2,
	desc = 3
}
local dataList = {
	{
		1,
		1,
		"文字111111111222222222223333333333333333",
		"activitypopup/board_tc01"
	},
	{
		1,
		2,
		"文字33333333333444444444444555555555555555",
		"activitypopup/board_tc02"
	},
	{
		1,
		3,
		"文字677777476777777777777",
		"activitypopup/board_tc03"
	},
	{
		1,
		4,
		"文字33333333333444444444444555555555555555",
		"activitypopup/board_tc04"
	},
	{
		1,
		5,
		"文字677777476777777777777",
		"activitypopup/board_tc05"
	}
}
local t_tun_tian_help_rule = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_tun_tian_help_rule.dataList = dataList

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

return t_tun_tian_help_rule
