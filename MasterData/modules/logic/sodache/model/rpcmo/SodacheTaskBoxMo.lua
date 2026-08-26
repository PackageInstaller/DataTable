-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheTaskBoxMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheTaskBoxMo", package.seeall)

local SodacheTaskBoxMo = pureTable("SodacheTaskBoxMo")

function SodacheTaskBoxMo:init(data)
	self.tasks, self.taskMap = GameUtil.rpcInfosToListAndMap(data.tasks, SodacheTaskMo, "id")

	table.sort(self.tasks, function(a, b)
		return a.id < b.id
	end)
end

function SodacheTaskBoxMo:updateTasks(tasks)
	for _, task in ipairs(tasks) do
		local taskMo = self.taskMap[task.id]

		if taskMo then
			taskMo:update(task)
		else
			taskMo = SodacheTaskMo.New()

			taskMo:init(task)
			table.insert(self.tasks, taskMo)

			self.taskMap[task.id] = taskMo
		end
	end

	table.sort(self.tasks, function(a, b)
		return a.id < b.id
	end)
	SodacheController.instance:dispatchEvent(SodacheEvent.OnTaskChange)
end

function SodacheTaskBoxMo:abandonTasks(ids)
	for _, id in ipairs(ids) do
		local taskMo = self.taskMap[id]

		if taskMo then
			tabletool.removeValue(self.tasks, taskMo)

			self.taskMap[id] = nil
		end
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnTaskChange)
end

function SodacheTaskBoxMo:getInsideTasks()
	local tasks = {}
	local mainTask, subTask

	for _, taskMo in ipairs(self.tasks) do
		if taskMo:isShowInside() then
			if taskMo.config.type == SodacheEnum.TaskType.Main then
				mainTask = taskMo
			else
				subTask = taskMo
			end
		end
	end

	table.insert(tasks, mainTask)
	table.insert(tasks, subTask)

	return tasks
end

function SodacheTaskBoxMo:hasRewardToGet()
	for _, taskMo in ipairs(self.tasks) do
		if taskMo.state == SodacheEnum.TaskState.Finished then
			return true
		end
	end

	return false
end

function SodacheTaskBoxMo:getShowTasks()
	local list = {}

	for _, taskMo in ipairs(self.tasks) do
		if taskMo.state ~= SodacheEnum.TaskState.Received or taskMo.config.remove ~= 1 then
			table.insert(list, taskMo)
		end
	end

	return list
end

return SodacheTaskBoxMo
