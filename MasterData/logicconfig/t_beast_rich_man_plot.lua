-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_plot.lua

module("logicconfig.config.t_beast_rich_man_plot", package.seeall)

local title = {
	plotId = 2,
	content = 3,
	activityId = 1
}
local dataList = {
	{
		558001,
		1,
		"描述1"
	},
	{
		558001,
		2,
		"描述2"
	},
	{
		558001,
		3,
		"描述3"
	},
	{
		558001,
		4,
		""
	},
	{
		558001,
		5,
		""
	},
	{
		558001,
		6,
		""
	},
	{
		558001,
		7,
		""
	},
	{
		558001,
		8,
		""
	},
	{
		558001,
		9,
		""
	},
	{
		558001,
		10,
		""
	}
}
local t_beast_rich_man_plot = {
	[558001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_beast_rich_man_plot.dataList = dataList

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

return t_beast_rich_man_plot
