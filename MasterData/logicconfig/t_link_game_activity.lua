-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_link_game_activity.lua

module("logicconfig.config.t_link_game_activity", package.seeall)

local title = {
	activityId = 1,
	ruleId = 2,
	jumpTo = 3
}
local dataList = {
	{
		303001,
		1,
		"func#191#303#303001"
	},
	{
		303002,
		1,
		"func#191#303#303001"
	},
	{
		303003,
		1,
		""
	},
	{
		303004,
		1,
		""
	}
}
local t_link_game_activity = {
	[303001] = dataList[1],
	[303002] = dataList[2],
	[303003] = dataList[3],
	[303004] = dataList[4]
}

t_link_game_activity.dataList = dataList

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

return t_link_game_activity
