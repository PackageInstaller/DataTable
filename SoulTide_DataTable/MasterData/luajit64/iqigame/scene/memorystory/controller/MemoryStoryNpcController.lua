-- chunkname: @IQIGame\\Scene\\MemoryStory\\Controller\\MemoryStoryNpcController.lua

local MemoryStoryElementController = require("IQIGame.Scene.MemoryStory.Controller.MemoryStoryElementController")
local m = {
	bindingTasks = {}
}

m = extend(MemoryStoryElementController, m)

function m.New(elementId, cacheData)
	local obj = Clone(m)

	obj:__OnInit(elementId, cacheData)

	return obj
end

function m:__OnInit(elementId, cacheData)
	self:__Init(elementId)

	local _bindingTasks

	if cacheData ~= nil then
		_bindingTasks = cacheData.bindingTasks
	end

	self:__InitBindingTasks(_bindingTasks)
end

function m:__OnMemoryStoryPlayerReceiveTaskEventHandler(taskId)
	self:ExecuteReceiveTaskServices()

	if self:HasBindingTask(taskId) then
		MemoryStoryModule.RefreshElementTaskTagByController(self)
	end
end

function m:__OnMemoryStoryPlayerTaskProgressChangeEventHandler(taskId, targetId)
	if self:HasBindingTask(taskId) then
		MemoryStoryModule.RefreshElementTaskTagByController(self)
	end
end

function m:__OnMemoryStoryPlayerSubmitTaskEventHandler(taskId)
	self:ExecuteSubmitTaskServices()
	self:RemoveBindingTask()
end

function m:__InitBindingTasks(_bindingTasks)
	if _bindingTasks == nil then
		for _, taskId in pairs(self.CfgData.TaskId) do
			table.insert(self.bindingTasks, taskId)
		end
	else
		for _, taskId in pairs(_bindingTasks) do
			table.insert(self.bindingTasks, taskId)
		end
	end
end

function m:HasBindingTask(taskId)
	local index = table.indexOf(self.bindingTasks, taskId)

	return index ~= -1
end

function m:AddBindingTask(taskId)
	local inBinding = self:HasBindingTask(taskId)

	if inBinding then
		return
	end

	table.insert(self.bindingTasks, taskId)
	MemoryStoryModule.RefreshElementTaskTagByController(self)
end

function m:RemoveBindingTask(taskId)
	local index = table.indexOf(self.bindingTasks, taskId)

	if index == -1 then
		return
	end

	table.remove(self.bindingTasks, index)
	MemoryStoryModule.RefreshElementTaskTagByController(self)
end

function m:GetCurrentShowTagTas()
	local cacheTaskId = -1
	local cacheState = MemoryStoryPlayerModule.TaskState.None

	for index, taskId in pairs(self.bindingTasks) do
		local tmpState = MemoryStoryPlayerModule.GetTaskState(taskId, true)

		if tmpState == MemoryStoryPlayerModule.TaskState.Succeed then
			return taskId, tmpState
		end

		if cacheState ~= MemoryStoryPlayerModule.TaskState.Available then
			if tmpState == MemoryStoryPlayerModule.TaskState.Available then
				cacheTaskId = taskId
				cacheState = MemoryStoryPlayerModule.TaskState.Available
			elseif tmpState == MemoryStoryPlayerModule.TaskState.Receive then
				cacheTaskId = taskId
				cacheState = MemoryStoryPlayerModule.TaskState.Receive
			end
		end
	end

	return cacheTaskId, cacheState
end

function m:ExecuteColliderEnterServices()
	local type = MemoryStoryModule.ServiceTriggerType.ColliderEnter_Normal

	self:__ExecuteServices(type, nil)

	type = MemoryStoryModule.ServiceTriggerType.ColliderEnter_HighPriority

	local hasPriority = self:__ExecuteServices(type, true)

	type = MemoryStoryModule.ServiceTriggerType.ColliderEnter_LowPriority

	if #hasPriority == 0 then
		self:__ExecuteServices(type, nil)
	end
end

function m:ExecuteColliderExitServices()
	local type = MemoryStoryModule.ServiceTriggerType.ColliderExit_Normal

	self:__ExecuteServices(type, nil)

	type = MemoryStoryModule.ServiceTriggerType.ColliderExit_HighPriority

	local hasPriority = self:__ExecuteServices(type, true)

	type = MemoryStoryModule.ServiceTriggerType.ColliderExit_LowPriority

	if #hasPriority == 0 then
		self:__ExecuteServices(type, nil)
	end
end

function m:ExecuteMouseClickServices()
	local type = MemoryStoryModule.ServiceTriggerType.MouseClicked_Normal

	self:__ExecuteServices(type, nil)

	type = MemoryStoryModule.ServiceTriggerType.MouseClicked_HighPriority

	local hasPriority = self:__ExecuteServices(type, true)

	type = MemoryStoryModule.ServiceTriggerType.MouseClicked_LowPriority

	if #hasPriority == 0 then
		self:__ExecuteServices(type, nil)
	end
end

return m
