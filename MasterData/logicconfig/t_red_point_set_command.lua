-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_red_point_set_command.lua

module("logicconfig.config.t_red_point_set_command", package.seeall)

local title = {
	params = 3,
	commandType = 2,
	commandId = 1
}
local dataList = {
	{
		1,
		1,
		{
			mainuiArea = "TopRight_1"
		}
	},
	{
		2,
		1,
		{
			mainuiArea = "TopRight_2"
		}
	},
	{
		3,
		1,
		{
			mainuiArea = "BomRight_Vertical"
		}
	},
	{
		4,
		1,
		{
			mainuiArea = "BomRight_Horizontal"
		}
	},
	{
		5,
		2
	},
	{
		6,
		3
	}
}
local t_red_point_set_command = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_red_point_set_command.dataList = dataList

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

return t_red_point_set_command
