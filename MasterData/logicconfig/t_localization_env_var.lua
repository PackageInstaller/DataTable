-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_localization_env_var.lua

module("logicconfig.config.t_localization_env_var", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DATA_APP_ID",
		"100044"
	},
	{
		"FORBIDDEN_IP_SWITCH",
		"false"
	},
	{
		"TEXT_DETECT_CHAT_CHECK_SWITCH",
		"true"
	},
	{
		"TEXT_DETECTION_CHAT_CHECK_BAN_SWITCH",
		"false"
	},
	{
		"APP_CODE",
		"aqsy"
	},
	{
		"DEFAULT_LOCATION",
		"奥奇城"
	}
}
local t_localization_env_var = {
	DATA_APP_ID = dataList[1],
	FORBIDDEN_IP_SWITCH = dataList[2],
	TEXT_DETECT_CHAT_CHECK_SWITCH = dataList[3],
	TEXT_DETECTION_CHAT_CHECK_BAN_SWITCH = dataList[4],
	APP_CODE = dataList[5],
	DEFAULT_LOCATION = dataList[6]
}

t_localization_env_var.dataList = dataList

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

return t_localization_env_var
