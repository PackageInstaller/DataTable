-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_auto_chess_fetters.lua

module("logicconfig.config.t_auto_chess_fetters", package.seeall)

local title = {
	fettersId = 1,
	name = 2,
	iconPath = 3,
	buffDesc = 4
}
local dataList = {
	{
		1,
		"水之羁绊",
		"com_icon_tuteng_jineng06",
		"己阵上阵的水属性精灵达到2/4/6只时全阵获得对应效果"
	},
	{
		2,
		"火之羁绊",
		"com_icon_tuteng_jineng03",
		"己阵上阵的火属性精灵达到2/4/6只时全阵获得对应效果"
	},
	{
		3,
		"草之羁绊",
		"com_icon_tuteng_jineng09",
		"己阵上阵的草属性精灵达到2/4/6只时全阵获得对应效果"
	},
	{
		4,
		"光之羁绊",
		"com_icon_tuteng_jineng12",
		"己阵上阵的光属性精灵达到2/4/6只时全阵获得对应效果"
	},
	{
		5,
		"暗之羁绊",
		"com_icon_tuteng_jineng15",
		"己阵上阵的暗属性精灵达到2/4/6只时全阵获得对应效果"
	},
	{
		6,
		"空创羁绊",
		"com_icon_tuteng_jineng18",
		"己阵上阵空创属性精灵达到2/4/6只时全阵获得对应效果"
	}
}
local t_auto_chess_fetters = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_auto_chess_fetters.dataList = dataList

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

return t_auto_chess_fetters
