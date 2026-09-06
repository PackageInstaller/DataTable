-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_draw_and_guess_brush.lua

module("logicconfig.config.t_draw_and_guess_brush", package.seeall)

local title = {
	id = 1,
	size = 2
}
local dataList = {
	{
		1,
		10
	},
	{
		2,
		20
	},
	{
		3,
		30
	},
	{
		4,
		40
	},
	{
		5,
		50
	},
	{
		6,
		60
	}
}
local t_draw_and_guess_brush = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_draw_and_guess_brush.dataList = dataList

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

return t_draw_and_guess_brush
