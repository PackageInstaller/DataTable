-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ice_qibu_game_activity.lua

module("logicconfig.config.t_ice_qibu_game_activity", package.seeall)

local title = {
	activityId = 1,
	ruleKeyMain = 4,
	dailyGameTimes = 2,
	redPointId = 3
}
local dataList = {
	{
		507001,
		3,
		721,
		"iceqibugamemainview_rule"
	}
}
local t_ice_qibu_game_activity = {
	[507001] = dataList[1]
}

t_ice_qibu_game_activity.dataList = dataList

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

return t_ice_qibu_game_activity
