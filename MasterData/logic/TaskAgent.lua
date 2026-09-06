-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/agent/TaskAgent.lua

module("logic.extensions.task.agent.TaskAgent", package.seeall)

local TaskAgent = class("TaskAgent", BaseAgent)

function TaskAgent:sendLoadUserTasksReq()
	local req = TaskExtension_pb.LoadUserTasksReq()

	self:sendMsg(req)
end

function TaskAgent:handleLoadUserTasksRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadTask===back")

	if status == 0 then
		local tasks = msg.tasks
		local avaliabletasks = msg.avaliableTasks
		local everDoneOneShotTasks = msg.everDoneOneShotTasks

		TaskController.instance:onTaskListRespond(tasks, avaliabletasks, everDoneOneShotTasks)
		GuideController.instance:loadGuideInfo()
		ColorfulEggsController.instance:onTaskListRespond()
		FuncOpenController.instance:loadOpenFuncInfo()
	end
end

function TaskAgent:sendOpenTaskStarterReq(taskId)
	local req = TaskExtension_pb.OpenTaskStarterReq()

	req.taskId = taskId

	self:sendMsg(req)
end

function TaskAgent:handleOpenTaskStarterRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function TaskAgent:sendOpenTaskStartersReq(taskIds)
	local req = TaskExtension_pb.OpenTaskStartersReq()

	req.taskIds = taskIds

	self:sendMsg(req)
end

function TaskAgent:handleOpenTaskStartersRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function TaskAgent:sendRunTaskStepReq(taskId, stepId, targetIndex, extData)
	local req = TaskExtension_pb.RunTaskStepReq()

	req.taskId = taskId
	req.stepId = stepId
	req.targetIndex = targetIndex
	req.extData = extData

	self:sendMsg(req)
end

function TaskAgent:handleRunTaskStepRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function TaskAgent:sendGiveUpTaskReq(taskId)
	local req = TaskExtension_pb.GiveUpTaskReq()

	req.taskId = taskId

	self:sendMsg(req)
end

function TaskAgent:handleGiveUpTaskRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function TaskAgent:sendSaveClientDataReq(taskId, stepId, targetIndex, clientData)
	local req = TaskExtension_pb.SaveClientDataReq()

	req.taskId = taskId
	req.stepId = stepId
	req.targetIndex = targetIndex
	req.clientData = clientData

	self:sendMsg(req)
end

function TaskAgent:handleSaveClientDataRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function TaskAgent:handleNotifyUserTaskStateChangedRes(status, msg)
	if status == 0 then
		self:_doHandleNotifyUserTaskStateChanged({
			msg
		})
	end
end

function TaskAgent:handleBatchNotifyUserTaskStateChangedRes(status, msg)
	if status == 0 then
		for _, taskId in ipairs(msg.finishTaskIds) do
			TaskController.instance:finishTaskAllStep(taskId)
		end

		self:_doHandleNotifyUserTaskStateChanged(msg.taskChange)
	end
end

function TaskAgent:_doHandleNotifyUserTaskStateChanged(infos)
	TaskController.instance:startCheckAutoCommit()
	TaskController.instance:startCheckAutoTask()

	for _, info in ipairs(infos) do
		local task = info.task
		local changetype = info.changeType

		if changetype == 1 then
			TaskController.instance:onAccpetTask(task)
			TaskController.instance:recordTaskUpdateOnBattle(task.taskId)
		elseif changetype == 2 then
			TaskController.instance:onTaskDataUpdate(task, task.curStepId, info.targetIndex)
			TaskController.instance:recordTaskUpdateOnBattle(task.taskId)
		elseif changetype == 3 then
			TaskController.instance:finishTask(task.taskId)
		elseif changetype == 4 then
			TaskController.instance:deletaTask(task.taskId)
		end

		local changeSetId = info.changeSetId
		local task = info.task

		if changeSetId and checknumber(changeSetId) > 0 and task then
			print(">>>>>>>>>>>>>>>>>>>>> MaterialController:onUserTaskChange(msg) changeSetId", changeSetId, task.taskId, task.curStepId, task.state)

			if task.state == 3 and task.taskId == 1 then
				local items = MaterialController.instance:getItemsByChangeSetId(changeSetId)
			end
		end
	end

	TaskController.instance:endCheckAutoCommit()
	TaskController.instance:endCheckAutoTask()
end

function TaskAgent:handleNotifyTaskHandleFailureRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function TaskAgent:sendFinishTaskStepReq(taskId, stepId)
	local req = TaskExtension_pb.FinishTaskStepReq()

	req.taskId = taskId
	req.stepId = stepId

	self:sendMsg(req)
end

function TaskAgent:handleFinishTaskStepRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function TaskAgent:handleNotifyTaskAvaliableChangedRes(status, msg)
	if status == 0 then
		local new = msg.new

		TaskController.instance:onTaskTriggerNotify(new)
	end
end

function TaskAgent:sendTaskFightMonsterReq(fightMasterId, battleResultType)
	local req = TaskExtension_pb.TaskFightMonsterReq()

	req.fightMasterId = fightMasterId

	BattleFacade.instance:startFightPvE(fightMasterId)
	self:sendMsg(req)
end

function TaskAgent:handleTaskFightMonsterRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

function TaskAgent:sendTaskEVEMonsterFightReq(teamAId, teamBId)
	local req = TaskExtension_pb.TaskEVEMonsterFightReq()

	req.teamAId = teamAId
	req.teamBId = teamBId

	BattleFacade.instance:startFightEvE(teamAId, teamBId)
	self:sendMsg(req)
end

function TaskAgent:handleTaskEVEMonsterFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function TaskAgent:handleNotifyTaskFightEndRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function TaskAgent:showChangeSet(changeSetId, name)
	if name == "handleTaskFightMonsterRes" or name == "handleTaskEVEMonsterFightRes" or name == "handleNotifyTaskFightEndRes" then
		printInfo("任务设置changeSetId", changeSetId, name)
		BattleSettlementModel.instance:setChangeSetId(changeSetId)
	else
		TaskAgent.super.showChangeSet(self, changeSetId, name)
	end
end

TaskAgent.instance = TaskAgent.New()

return TaskAgent
