-- chunkname: @IQIGame\\Module\\MemoryStory\\MemoryStoryPlayerModule.lua

MemoryStoryPlayerModule = {
	ReceiveTask = {},
	SubmitTask = {},
	BagTable = {}
}
MemoryStoryPlayerModule.TaskState = {
	Available = 0,
	Succeed = 2,
	Submit = 3,
	Receive = 1,
	None = -1
}

function MemoryStoryPlayerModule.Reset()
	MemoryStoryPlayerModule.ReceiveTask = {}
	MemoryStoryPlayerModule.SubmitTask = {}
	MemoryStoryPlayerModule.BagTable = {}
end

function MemoryStoryPlayerModule.GetTaskState(taskId, hasBingNpc)
	local index = table.indexOf(MemoryStoryPlayerModule.SubmitTask, taskId)

	if index ~= -1 then
		return MemoryStoryPlayerModule.TaskState.Submit
	end

	if MemoryStoryPlayerModule.ReceiveTask[taskId] == nil then
		return hasBingNpc and MemoryStoryPlayerModule.TaskState.Available or MemoryStoryPlayerModule.TaskState.None
	end

	local succeed = MemoryStoryPlayerModule.HasTaskSucceed(taskId)

	return succeed and MemoryStoryPlayerModule.TaskState.Succeed or MemoryStoryPlayerModule.TaskState.Receive
end

function MemoryStoryPlayerModule.OnReceiveTask(taskId)
	local taskCfg = CfgMemoryStoryTaskTable[taskId]

	if not taskCfg then
		return
	end

	local taskInfo = MemoryStoryPlayerModule.ReceiveTask[taskId]

	if taskInfo ~= nil then
		logError("接取任务出错[任务已接取]" .. tostring(taskId))

		return
	end

	if MemoryStoryPlayerModule.HasSubmitTask(taskId) then
		logError("接取任务出错[任务已提交] " .. tostring(taskId))

		return
	end

	MemoryStoryPlayerModule:__DoReceiveTask(taskCfg)
end

function MemoryStoryPlayerModule.OnAddTaskProgress(taskId, targetId, progress)
	local taskCfg = CfgMemoryStoryTaskTable[taskId]

	if not taskCfg then
		return
	end

	if MemoryStoryPlayerModule.ReceiveTask[taskId] == nil then
		logError("增加任务进度出错[任务未接取或者已完成]" .. tostring(taskId))

		return
	end

	if MemoryStoryPlayerModule.ReceiveTask[taskId][targetId] == nil then
		logError("增加任务进度出错[找不到目标id]" .. tostring(targetId))

		return
	end

	MemoryStoryPlayerModule:__DoAddTaskProgress(taskCfg, targetId, progress)
end

function MemoryStoryPlayerModule.OnSubmitTask(taskId)
	MemoryStoryPlayerModule:__DoSubmitTask(taskId)
end

function MemoryStoryPlayerModule.GetAllReceiveTask()
	local result = {}

	for id, _ in pairs(MemoryStoryPlayerModule.ReceiveTask) do
		table.insert(result, id)
	end

	return result
end

function MemoryStoryPlayerModule.GetReceiveTaskData(taskId)
	return MemoryStoryPlayerModule.ReceiveTask[taskId]
end

function MemoryStoryPlayerModule.HasTaskSucceed(taskId)
	local taskCfg = CfgMemoryStoryTaskTable[taskId]

	if not taskCfg then
		return false
	end

	local progressTab = MemoryStoryPlayerModule.ReceiveTask[taskId]

	if not progressTab then
		return false
	end

	return MemoryStoryPlayerModule.__CheckTaskSucceed(taskCfg, progressTab)
end

function MemoryStoryPlayerModule.HasSubmitTask(taskId)
	for _, v in pairs(MemoryStoryPlayerModule.SubmitTask) do
		if v == taskId then
			return true
		end
	end

	return false
end

function MemoryStoryPlayerModule:__DoReceiveTask(taskCfg)
	local taskInfo = {}

	for _, v in pairs(taskCfg.TargetId) do
		local target = CfgMemoryStoryTargetTable[v]

		if target then
			taskInfo[v] = target.InitialProgress
		end
	end

	local taskId = taskCfg.Id

	self.ReceiveTask[taskId] = taskInfo

	EventDispatcher.Dispatch(EventID.MemoryStoryPlayerReceiveTaskEvent, taskId)
end

function MemoryStoryPlayerModule:__DoAddTaskProgress(taskCfg, targetId, progress)
	local taskId = taskCfg.Id
	local lProgress = self.ReceiveTask[taskId][targetId] or 0

	lProgress = lProgress + progress

	if lProgress < 0 then
		lProgress = 0
	end

	local cfgMemoryStoryTargetData = CfgMemoryStoryTargetTable[targetId]

	if lProgress > cfgMemoryStoryTargetData.TotalProgress then
		lProgress = cfgMemoryStoryTargetData.TotalProgress
	end

	self.ReceiveTask[taskId][targetId] = lProgress

	if taskCfg.AutoSubmit and self.__CheckTaskSucceed(taskCfg, self.ReceiveTask[taskId]) then
		self:__DoSubmitTask(taskId)

		return
	end

	EventDispatcher.Dispatch(EventID.MemoryStoryPlayerTaskProgressChangeEvent, taskId, targetId)
end

function MemoryStoryPlayerModule:__DoSubmitTask(taskId)
	if self.ReceiveTask[taskId] == nil then
		return
	end

	self.ReceiveTask[taskId] = nil

	table.insert(self.SubmitTask, taskId)
	EventDispatcher.Dispatch(EventID.MemoryStoryPlayerSubmitTaskEvent, taskId)
end

function MemoryStoryPlayerModule.__CheckTaskSucceed(taskCfg, progressTab)
	for _, v in pairs(taskCfg.TargetId) do
		local target = CfgMemoryStoryTargetTable[v]
		local num = progressTab[v]

		if target.TotalProgress ~= num then
			return false
		end
	end

	return true
end

function MemoryStoryPlayerModule.GetItemCount(itemId)
	return MemoryStoryPlayerModule:__GetItemCount(itemId)
end

function MemoryStoryPlayerModule.SetItemCount(itemId, count)
	MemoryStoryPlayerModule.BagTable[itemId] = count
end

function MemoryStoryPlayerModule.AddItem(itemId, count)
	MemoryStoryPlayerModule:__AddItem(itemId, count)
end

function MemoryStoryPlayerModule.RemoveItem(itemId, count)
	MemoryStoryPlayerModule:__RemoveItem(itemId, count)
end

function MemoryStoryPlayerModule:__GetItemCount(itemId)
	if self.BagTable[itemId] == nil then
		return -1
	end

	return MemoryStoryPlayerModule.BagTable[itemId]
end

function MemoryStoryPlayerModule:__AddItem(itemId, cnt)
	local ownerCnt = self:__GetItemCount(itemId)

	self.BagTable[itemId] = ownerCnt + cnt
end

function MemoryStoryPlayerModule:__RemoveItem(itemId, cnt)
	local ownerCnt = self:__GetItemCount(itemId)

	if ownerCnt < 0 then
		return
	end

	local last = ownerCnt - cnt

	last = last < 0 and 0 or last
	self.BagTable[itemId] = last
end

function MemoryStoryPlayerModule:__ClearBag()
	self.BagTable = {}
end
