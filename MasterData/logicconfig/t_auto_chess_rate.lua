-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_auto_chess_rate.lua

module("logicconfig.config.t_auto_chess_rate", package.seeall)

local title = {
	cardNum = 6,
	money = 4,
	maxStarLevel = 3,
	rate = 1,
	fullLevel = 5,
	initStarLevel = 2
}
local dataList = {
	{
		1,
		0,
		5,
		1,
		false,
		30
	},
	{
		2,
		1,
		5,
		2,
		false,
		20
	},
	{
		3,
		2,
		5,
		3,
		false,
		12
	},
	{
		4,
		3,
		5,
		4,
		false,
		9
	},
	{
		5,
		4,
		5,
		5,
		false,
		4
	}
}
local t_auto_chess_rate = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_auto_chess_rate.dataList = dataList

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

return t_auto_chess_rate
