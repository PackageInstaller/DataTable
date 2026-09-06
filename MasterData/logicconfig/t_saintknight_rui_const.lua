-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saintknight_rui_const.lua

module("logicconfig.config.t_saintknight_rui_const", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"ACTIVITY_ID",
		"172001"
	}
}
local t_saintknight_rui_const = {
	ACTIVITY_ID = dataList[1]
}

t_saintknight_rui_const.dataList = dataList

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

return t_saintknight_rui_const
