-- chunkname: @IQIGame\\Module\\Task\\TaskModule.lua

TaskModule = {}
TaskModule.CurrentTasksTable = {}
TaskModule.FinishTasksTable = {}
TaskModule.FailTasksTable = {}
TaskModule.TaskType = {
	HORIZONTAL_RPG_TASK = 39,
	SIGN_TASK = 19,
	EXPLORE_POINT_TASK = 2,
	ROOKIE_TASK = 9,
	PICTURE_PUZZLE_TASK = 21,
	ACTIVITY_SIGN = 25,
	WEEK_ACTIVE_TASK = 14,
	PAID_CHALLENGE_TASK = 27,
	AMUSEMENT_PARK_TASK = 38,
	FREE_REWARD_TASK = 34,
	NATIONAL_DAY = 22,
	GUILD_TASK = 35,
	MOON_TASK = 20,
	FIRST_RECHARGE_TASK = 16,
	DUAL_TEAM_EXPLORE = 29,
	LIBRARY_TASK = 13,
	DREAM_LAND_TASK = 26,
	MAZE_CHALLENGE_BONUS_TASK = 36,
	MAGIC_TOWER_TASK = 30,
	RECHARGE_TASK = 15,
	GROWTH_FUND_TASK = 31,
	LUNA_BATTLE_LINE_TASK = 24,
	RESTAURANT_OPERATION_TASK = 37,
	MONSTER_ACADEMY_TASK = 32,
	DOLL_TASK = 23,
	ACTIVE_TASK = 3,
	FISHING_ACTIVITY_TASK = 40,
	RPG_TASK = 18,
	NORMAL_TASK = 1,
	NEW_PLAYER_GROW_UP_TASK = 17,
	WELCOME_BACK_TASK = 28,
	LIMITED_TURNTABLE_TASK = 33
}
TaskModule.NormalTaskType = {
	MAIN_TASK = 1,
	BRANCH_TASK = 2
}
TaskModule.TaskStatus = {
	FINISH_TASK = 3,
	LOCK_SHOW_TASK = 4,
	CURRENT_TASK = 1
}
TaskModule.Achievement_KeyEnum = {}

function TaskModule.ReloadTask(tasks, finishQuestList, failQuestList)
	TaskModule.CurrentTasksTable = {}
	TaskModule.FinishTasksTable = {}
	TaskModule.FailTasksTable = {}
	TaskModule.Achievement_KeyEnum = {}

	for i, v in pairs(tasks) do
		TaskModule.CurrentTasksTable[v.cid] = TaskServerPodData.New(v)
	end

	for i, v in pairs(finishQuestList) do
		TaskModule.FinishTasksTable[v] = v
	end

	for i, v in pairs(failQuestList) do
		TaskModule.FailTasksTable[v] = v
	end

	TaskModule.Achievement_KeyEnum[1] = "Achievement_1" .. PlayerModule.PlayerInfo.baseInfo.pid
	TaskModule.Achievement_KeyEnum[2] = "Achievement_2" .. PlayerModule.PlayerInfo.baseInfo.pid
end

function TaskModule.ResponseUpdateTaskMsg(taskPOD, isRemove)
	if isRemove then
		TaskModule.CurrentTasksTable[taskPOD.cid] = nil
	else
		TaskModule.CurrentTasksTable[taskPOD.cid] = TaskServerPodData.New(taskPOD)

		if CfgMainQuestTable[taskPOD.cid].Type == TaskModule.TaskType.ACHIEVEMENT_TASK and taskPOD.finNum >= taskPOD.tgtNum then
			local data1 = PlayerPrefsUtil.GetString(PlayerModule.PlayerInfo.baseInfo.pid, TaskModule.Achievement_KeyEnum[1])

			PlayerPrefsUtil.SetString(PlayerModule.PlayerInfo.baseInfo.pid, TaskModule.Achievement_KeyEnum[2], data1)
			PlayerPrefsUtil.SetString(PlayerModule.PlayerInfo.baseInfo.pid, TaskModule.Achievement_KeyEnum[1], taskPOD.cid)
			NoticeModule.AddQueueTipData(taskPOD.cid, NoticeModule.QueueTip.tipTypeEnum.Achievement)
			EventDispatcher.Dispatch(EventID.FinishedAchievement)
		end
	end

	EventDispatcher.Dispatch(EventID.TaskUpdate, taskPOD.cid)
end

function TaskModule.ResponseUpdateFinishTaskMsg(cid, isRemove)
	if isRemove then
		TaskModule.FinishTasksTable[cid] = nil
	else
		TaskModule.FinishTasksTable[cid] = cid
	end

	EventDispatcher.Dispatch(EventID.TaskUpdate, cid)
	EventDispatcher.Dispatch(EventID.UpdateFinishedTaskOver, cid)
end

function TaskModule.ResponseUpdateFailTaskMsg(cid, isRemove)
	if isRemove then
		TaskModule.FailTasksTable[cid] = nil
	else
		TaskModule.FailTasksTable[cid] = cid
	end

	EventDispatcher.Dispatch(EventID.TaskUpdate, cid)
end

function TaskModule.SendCommitTaskMsg(taskId)
	net_quest.commitQuest({
		taskId
	})
end

function TaskModule.SendCommitTaskMsgBatch(taskIds)
	if #taskIds ~= 0 then
		net_quest.commitQuest(taskIds)
	end
end

function TaskModule.ResponseCommitTaskMsg(cids, awards)
	EventDispatcher.Dispatch(EventID.TaskCommitResponse, cids, awards)
end

function TaskModule.SendGiveUpTaskMsg(taskId)
	net_quest.giveUpQuest(taskId)
end

function TaskModule.ResponseGiveUpTaskMsg(cid)
	NoticeModule.ShowNotice(1005023)
end

function TaskModule.GetTaskProcessing(type, typeParam)
	local tasks = {}

	for cid, taskServerPodData in pairs(TaskModule.CurrentTasksTable) do
		local cfgMainQuestData = CfgMainQuestTable[cid]

		if cfgMainQuestData ~= nil and cfgMainQuestData.Type == type and TaskModule.IsTypeParamMatched(cfgMainQuestData.TypeParam, typeParam) then
			table.insert(tasks, taskServerPodData)
		end
	end

	return tasks
end

function TaskModule.GetTaskFinished(type, typeParam)
	local tasks = {}

	for cid, cid in pairs(TaskModule.FinishTasksTable) do
		local cfgMainQuestData = CfgMainQuestTable[cid]

		if cfgMainQuestData.Type == type and TaskModule.IsTypeParamMatched(cfgMainQuestData.TypeParam, typeParam) then
			table.insert(tasks, cid)
		end
	end

	return tasks
end

function TaskModule.GetTaskFailed(type, typeParam)
	local tasks = {}

	for cid, cid in pairs(TaskModule.FailTasksTable) do
		local cfgMainQuestData = CfgMainQuestTable[cid]

		if cfgMainQuestData.Type == type and TaskModule.IsTypeParamMatched(cfgMainQuestData.TypeParam, typeParam) then
			table.insert(tasks, cid)
		end
	end

	return tasks
end

function TaskModule.IsTypeParamMatched(cfgTypeParam, typeParam)
	if typeParam == nil then
		return true
	end

	for i = 1, #typeParam do
		if typeParam[i] ~= cfgTypeParam[i] then
			return false
		end
	end

	return true
end

function TaskModule.GetProcessingTaskByCid(taskCid)
	return TaskModule.CurrentTasksTable[taskCid]
end
