-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fetter_common.lua

module("logicconfig.config.t_fetter_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"GLOBAL_FETTER_LIMIT",
		"999999"
	},
	{
		"BUDDY_LOGIN_NOTIFY_FETTER",
		"300"
	},
	{
		"INTI_FETTER",
		"1"
	}
}
local t_fetter_common = {
	GLOBAL_FETTER_LIMIT = dataList[1],
	BUDDY_LOGIN_NOTIFY_FETTER = dataList[2],
	INTI_FETTER = dataList[3]
}

t_fetter_common.dataList = dataList

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

return t_fetter_common
