-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_auto_chess_star_level.lua

module("logicconfig.config.t_auto_chess_star_level", package.seeall)

local title = {
	sellMoney = 2,
	starLevel = 1,
	decHp = 3
}
local dataList = {
	{
		0,
		1,
		1
	},
	{
		1,
		2,
		2
	},
	{
		2,
		3,
		3
	},
	{
		3,
		4,
		4
	},
	{
		4,
		5,
		5
	},
	{
		5,
		6,
		6
	}
}
local t_auto_chess_star_level = {
	[0] = dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_auto_chess_star_level.dataList = dataList

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

return t_auto_chess_star_level
