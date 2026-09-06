-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_form_team_common_config.lua

module("logicconfig.config.t_form_team_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"INVITE_EXPIRE_SEC",
		"30"
	},
	{
		"VIEW_TEAMS_SIZE",
		"20"
	},
	{
		"REFRESH_CD",
		"5"
	},
	{
		"CHAT_CD",
		"1"
	},
	{
		"CHAT_SHOW_TIME",
		"5"
	},
	{
		"AUTO_MATCH_TIME",
		"30"
	},
	{
		"AUTO_MATCH_TIME_INTERVAL",
		"5"
	},
	{
		"INVITE_TIP_CLOSE_SEC",
		"10"
	},
	{
		"AUTO_READY_TIME",
		"20"
	},
	{
		"ACTIVITY_ITEM_ID",
		"170001"
	}
}
local t_form_team_common_config = {
	INVITE_EXPIRE_SEC = dataList[1],
	VIEW_TEAMS_SIZE = dataList[2],
	REFRESH_CD = dataList[3],
	CHAT_CD = dataList[4],
	CHAT_SHOW_TIME = dataList[5],
	AUTO_MATCH_TIME = dataList[6],
	AUTO_MATCH_TIME_INTERVAL = dataList[7],
	INVITE_TIP_CLOSE_SEC = dataList[8],
	AUTO_READY_TIME = dataList[9],
	ACTIVITY_ITEM_ID = dataList[10]
}

t_form_team_common_config.dataList = dataList

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

return t_form_team_common_config
