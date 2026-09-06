-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_show_down_match_rule.lua

module("logicconfig.config.t_show_down_match_rule", package.seeall)

local title = {
	matchId = 2,
	matchPlanId = 1
}
local dataList = {
	{
		1,
		1
	},
	{
		1,
		2
	},
	{
		1,
		3
	},
	{
		1,
		4
	},
	{
		2,
		1
	},
	{
		2,
		2
	},
	{
		2,
		3
	},
	{
		2,
		4
	}
}
local t_show_down_match_rule = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_show_down_match_rule.dataList = dataList

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

return t_show_down_match_rule
