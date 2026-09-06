-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_draw_and_guess_color.lua

module("logicconfig.config.t_draw_and_guess_color", package.seeall)

local title = {
	id = 1,
	color = 2
}
local dataList = {
	{
		1,
		"#4ECDC4"
	},
	{
		2,
		"#FF6B6B"
	},
	{
		3,
		"#C44569"
	},
	{
		4,
		"#FDCB6E"
	},
	{
		5,
		"#786FA6"
	},
	{
		6,
		"#00B894"
	}
}
local t_draw_and_guess_color = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_draw_and_guess_color.dataList = dataList

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

return t_draw_and_guess_color
