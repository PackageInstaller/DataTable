-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_operation_plot_trial.lua

module("logicconfig.config.t_operation_plot_trial", package.seeall)

local title = {
	typeId = 2,
	trialId = 1,
	buffPlanId = 3
}
local dataList = {
	{
		1,
		13,
		1
	},
	{
		2,
		17,
		1
	},
	{
		3,
		45,
		2
	}
}
local t_operation_plot_trial = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_operation_plot_trial.dataList = dataList

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

return t_operation_plot_trial
