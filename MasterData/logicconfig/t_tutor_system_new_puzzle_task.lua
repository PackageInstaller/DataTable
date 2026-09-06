-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tutor_system_new_puzzle_task.lua

module("logicconfig.config.t_tutor_system_new_puzzle_task", package.seeall)

local title = {
	cur = 3,
	key = 1,
	max = 4,
	desc = 2
}
local dataList = {
	{
		1,
		"每日登录（%s/%s）",
		"DaySign",
		1
	},
	{
		2,
		"活跃度达到60(%s/%s)",
		"Activation",
		60
	},
	{
		3,
		"活跃度达到120(%s/%s)",
		"Activation",
		120
	}
}
local t_tutor_system_new_puzzle_task = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_tutor_system_new_puzzle_task.dataList = dataList

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

return t_tutor_system_new_puzzle_task
