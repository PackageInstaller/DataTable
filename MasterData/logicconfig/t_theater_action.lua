-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_theater_action.lua

module("logicconfig.config.t_theater_action", package.seeall)

local title = {
	id = 1,
	name = 2
}
local dataList = {
	{
		1,
		"dream_shake"
	},
	{
		2,
		"dream_beat"
	}
}
local t_theater_action = {
	dataList[1],
	dataList[2]
}

t_theater_action.dataList = dataList

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

return t_theater_action
