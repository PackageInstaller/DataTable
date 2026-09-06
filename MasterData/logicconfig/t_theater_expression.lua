-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_theater_expression.lua

module("logicconfig.config.t_theater_expression", package.seeall)

local title = {
	id = 1,
	url = 2
}
local dataList = {
	{
		1,
		"board_antishi_04"
	},
	{
		2,
		"board_antishi_05"
	},
	{
		3,
		"board_antishi_06"
	},
	{
		4,
		"board_antishi_07"
	}
}
local t_theater_expression = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_theater_expression.dataList = dataList

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

return t_theater_expression
