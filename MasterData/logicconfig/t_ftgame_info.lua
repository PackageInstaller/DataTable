-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ftgame_info.lua

module("logicconfig.config.t_ftgame_info", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"baseSpeedx",
		8
	},
	{
		"speedy",
		10
	},
	{
		"gravity",
		-20
	},
	{
		"dashSpeedx",
		16
	},
	{
		"rang",
		100
	}
}
local t_ftgame_info = {
	baseSpeedx = dataList[1],
	speedy = dataList[2],
	gravity = dataList[3],
	dashSpeedx = dataList[4],
	rang = dataList[5]
}

t_ftgame_info.dataList = dataList

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

return t_ftgame_info
