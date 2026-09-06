-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_war_plot.lua

module("logicconfig.config.t_ultimate_war_plot", package.seeall)

local title = {
	plotId = 2,
	name = 4,
	activityId = 1,
	storyId = 3
}
local dataList = {
	{
		434001,
		1,
		4750002,
		"剧情A"
	},
	{
		434001,
		2,
		4750003,
		"二阶段"
	},
	{
		434001,
		3,
		4750004,
		"强化斐希司"
	},
	{
		434001,
		4,
		4750005,
		"最终决战"
	},
	{
		434001,
		5,
		4750006,
		"最终决战"
	}
}
local t_ultimate_war_plot = {
	[434001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_ultimate_war_plot.dataList = dataList

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

return t_ultimate_war_plot
