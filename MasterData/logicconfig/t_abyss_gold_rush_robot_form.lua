-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_abyss_gold_rush_robot_form.lua

module("logicconfig.config.t_abyss_gold_rush_robot_form", package.seeall)

local title = {
	creepsMasterId = 3,
	robotId = 1,
	formId = 2
}
local dataList = {
	{
		1,
		1,
		1001
	},
	{
		1,
		2,
		1002
	},
	{
		1,
		3,
		1003
	},
	{
		1,
		4,
		1004
	},
	{
		1,
		5,
		1005
	},
	{
		1,
		6,
		1006
	},
	{
		1,
		7,
		1007
	},
	{
		1,
		8,
		1008
	},
	{
		1,
		9,
		1009
	},
	{
		1,
		10,
		1010
	},
	{
		1,
		11,
		1011
	}
}
local t_abyss_gold_rush_robot_form = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11]
	}
}

t_abyss_gold_rush_robot_form.dataList = dataList

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

return t_abyss_gold_rush_robot_form
