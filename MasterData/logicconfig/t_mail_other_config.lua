-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mail_other_config.lua

module("logicconfig.config.t_mail_other_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MAIL_MAX_SIZE",
		"200"
	},
	{
		"OUT_DATE_NUM",
		"30"
	}
}
local t_mail_other_config = {
	MAIL_MAX_SIZE = dataList[1],
	OUT_DATE_NUM = dataList[2]
}

t_mail_other_config.dataList = dataList

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

return t_mail_other_config
