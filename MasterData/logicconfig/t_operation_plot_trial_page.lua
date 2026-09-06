-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_operation_plot_trial_page.lua

module("logicconfig.config.t_operation_plot_trial_page", package.seeall)

local title = {
	id = 2,
	trialId = 1,
	typeId = 3,
	examName = 4
}
local dataList = {
	{
		1,
		1,
		13,
		"初心试炼"
	},
	{
		1,
		2,
		13,
		"成长试炼"
	},
	{
		1,
		3,
		13,
		"终极试炼"
	},
	{
		2,
		1,
		17,
		"<size=28>曦</size>光试炼"
	},
	{
		2,
		2,
		17,
		"<size=28>破</size>晓试炼"
	},
	{
		2,
		3,
		17,
		"<size=28>极</size>耀试炼"
	},
	{
		3,
		1,
		45,
		"<size=28>镜</size>像试炼1"
	},
	{
		3,
		2,
		45,
		"<size=28>镜</size>像试炼2"
	},
	{
		3,
		3,
		45,
		"<size=28>镜</size>像试炼3"
	},
	{
		3,
		4,
		45,
		"<size=28>镜</size>像试炼4"
	},
	{
		3,
		5,
		45,
		"<size=28>镜</size>像试炼5"
	}
}
local t_operation_plot_trial_page = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11]
	}
}

t_operation_plot_trial_page.dataList = dataList

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

return t_operation_plot_trial_page
