-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_verification_task_prize_task.lua

module("logicconfig.config.t_verification_task_prize_task", package.seeall)

local title = {
	enterName = 6,
	taskDesc = 5,
	goToParam = 4,
	progress = 3,
	taskPlanId = 1,
	taskId = 2
}
local dataList = {
	{
		1,
		1,
		50,
		"func#19",
		"竞技场排名达到前50名",
		"竞技场"
	},
	{
		1,
		2,
		50,
		"func#171",
		"高阶竞技场排名达到前80名",
		"高阶竞技场"
	},
	{
		1,
		3,
		50,
		"func#15",
		"空属性塔通关80层",
		"勇者之塔-空属性"
	}
}
local t_verification_task_prize_task = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_verification_task_prize_task.dataList = dataList

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

return t_verification_task_prize_task
