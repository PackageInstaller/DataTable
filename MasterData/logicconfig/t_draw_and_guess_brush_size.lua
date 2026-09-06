-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_draw_and_guess_brush_size.lua

module("logicconfig.config.t_draw_and_guess_brush_size", package.seeall)

local title = {
	id = 1,
	size = 2
}
local dataList = {
	{
		1,
		3
	},
	{
		2,
		5
	},
	{
		3,
		8
	}
}
local t_draw_and_guess_brush_size = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_draw_and_guess_brush_size.dataList = dataList

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

return t_draw_and_guess_brush_size
