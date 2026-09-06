-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_touch.lua

module("logicconfig.config.t_goddess_touch", package.seeall)

local title = {
	feeling = 2,
	prize = 3,
	planId = 1
}
local dataList = {
	{
		1,
		10,
		"8:1:1000"
	}
}
local t_goddess_touch = {
	dataList[1]
}

t_goddess_touch.dataList = dataList

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

return t_goddess_touch
