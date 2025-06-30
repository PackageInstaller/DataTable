-- chunkname: @IQIGame\\Module\\ActiveWelcomeBack\\ActiveWelcomeBackModule.lua

local m = {}
local TaskUIData = require("IQIGame.Module.Task.TaskUIData")

function m.Reload()
	m.AddListeners()

	if m.ActiveWelcomeBackIsOpen() then
		m.timer = Timer.New(function()
			m.TimerUpdate()
		end, 1, -1)

		m.timer:Start()
	end
end

function m.TimerUpdate()
	local now = PlayerModule.GetServerTime()

	if now >= PlayerModule.PlayerInfo.backflowTime then
		PlayerModule.PlayerInfo.backflowTime = 0

		m.timer:Stop()

		m.timer = nil

		EventDispatcher.Dispatch(EventID.UpdateWelcomeBackEvent)
	end
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.ActiveWelcomeBackIsOpen()
	if PlayerModule.PlayerInfo.backflowTime ~= nil then
		return PlayerModule.PlayerInfo.backflowTime > 0
	end

	return false
end

function m.HaveTaskGetReward()
	local taskDatum = m.GetWelcomeBackTaskData()

	for i, v in pairs(taskDatum) do
		if v.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK then
			return false
		end
	end

	return true
end

function m.CheckWelcomeBackRedPoint()
	local taskDatum = m.GetWelcomeBackTaskData()

	for i, v in pairs(taskDatum) do
		if v.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and v.CurrentNum >= v.TargetNum then
			return true
		end
	end

	return false
end

function m.GetWelcomeBackTaskData(TypeParam)
	local ret = {}
	local subType = -1
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.WELCOME_BACK_TASK, TypeParam)
	local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.WELCOME_BACK_TASK, TypeParam)

	for i = 1, #processing do
		local taskData = processing[i]

		if subType == -1 then
			subType = CfgMainQuestTable[taskData.cid].TypeParam[1]
		end

		local uiTaskData = TaskUIData.New(taskData.cid, taskData.finNum, taskData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, taskData.createTime)

		table.insert(ret, uiTaskData)
	end

	for i = 1, #finished do
		local taskCid = finished[i]
		local cfgTaskData = CfgMainQuestTable[taskCid]

		if subType == -1 then
			subType = cfgTaskData.TypeParam[1]
		end

		local cfgTargetData = CfgTargetTable[cfgTaskData.TargetId]
		local uiTaskData = TaskUIData.New(taskCid, cfgTargetData.TargetNum, cfgTargetData.TargetNum, TaskModule.TaskStatus.FINISH_TASK)

		table.insert(ret, uiTaskData)
	end

	for i, v in pairsCfg(CfgMainQuestTable) do
		if v.Type == TaskModule.TaskType.WELCOME_BACK_TASK and v.TypeParam[1] == subType then
			local have, data = m.GetShowUnlockTask(v.Id, ret)

			if have == false and data ~= nil then
				table.insert(ret, data)
			end
		end
	end

	table.sort(ret, function(a, b)
		return a.cid < b.cid
	end)

	return ret, processing, finished
end

function m.GetShowUnlockTask(taskId, ret)
	for i, v in ipairs(ret) do
		if taskId == v.cid then
			return true, nil
		end
	end

	local cfgTaskData = CfgMainQuestTable[taskId]
	local cfgTargetData = CfgTargetTable[cfgTaskData.TargetId]
	local uiTaskData = TaskUIData.New(taskId, 0, cfgTargetData.TargetNum, TaskModule.TaskStatus.CURRENT_TASK)

	return false, uiTaskData
end

function m.GetReward(taskCid)
	TaskModule.SendCommitTaskMsg(taskCid)
end

function m.Shutdown()
	m.RemoveListeners()

	if m.timer then
		m.timer:Stop()

		m.timer = nil
	end
end

ActiveWelcomeBackModule = m
