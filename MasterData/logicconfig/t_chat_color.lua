-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chat_color.lua

module("logicconfig.config.t_chat_color", package.seeall)

local title = {
	chatMyColor = 3,
	friendMyColor = 5,
	mainColor = 2,
	id = 1,
	chatOther = 4,
	friendOtherColor = 6
}
local dataList = {
	{
		1,
		"ebad32",
		"d56d08",
		"d56d08",
		"d56d08",
		"d56d08"
	}
}
local t_chat_color = {
	dataList[1]
}

t_chat_color.dataList = dataList

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

return t_chat_color
