-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_waken_const.lua

module("logicconfig.config.t_goddess_waken_const", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"ACTIVITYID",
		"130001"
	}
}
local t_goddess_waken_const = {
	ACTIVITYID = dataList[1]
}

t_goddess_waken_const.dataList = dataList

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

return t_goddess_waken_const
