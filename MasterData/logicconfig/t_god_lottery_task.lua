-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_lottery_task.lua

module("logicconfig.config.t_god_lottery_task", package.seeall)

local title = {
	activityId = 1,
	redPointId = 3,
	taskPlanId = 2
}
local dataList = {
	{
		116001,
		1,
		204
	},
	{
		116002,
		2,
		204
	},
	{
		116003,
		3,
		204
	},
	{
		116004,
		4,
		204
	},
	{
		116005,
		5,
		204
	}
}
local t_god_lottery_task = {
	[116001] = dataList[1],
	[116002] = dataList[2],
	[116003] = dataList[3],
	[116004] = dataList[4],
	[116005] = dataList[5]
}

t_god_lottery_task.dataList = dataList

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

return t_god_lottery_task
