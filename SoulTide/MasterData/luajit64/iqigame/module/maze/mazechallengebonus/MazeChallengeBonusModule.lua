-- chunkname: @IQIGame\\Module\\Maze\\MazeChallengeBonus\\MazeChallengeBonusModule.lua

local m = {
	mazeChallengeBonusDataTab = {}
}
local MazeChallengeBonusData = require("IQIGame.Module.Maze.MazeChallengeBonus.MazeChallengeBonusData")
local TaskUIData = require("IQIGame.Module.Task.TaskUIData")

function m.Reload()
	m.mazeChallengeBonusDataTab = {}
	PlayerModule.PlayerInfo.unlockChapterTasks = PlayerModule.PlayerInfo.unlockChapterTasks or {}

	for i, v in pairsCfg(CfgMazeChallengeBonusTable) do
		local state = 1

		if table.indexOf(PlayerModule.PlayerInfo.unlockChapterTasks, v.Id) ~= -1 then
			state = 2
		end

		local tasks = m.GetMazeChallengeBonesTasks(v.Id)
		local data = MazeChallengeBonusData.New(v.Id, state, tasks)

		table.insert(m.mazeChallengeBonusDataTab, data)
	end

	m.AddListeners()
end

function m.AddListeners()
	EventDispatcher.AddEventListener(EventID.TaskUpdate, m.OnTaskUpdate)
end

function m.RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, m.OnTaskUpdate)
end

function m.OnTaskUpdate()
	m.RefreshMazeChallengeBonusData()
end

function m.IsBuyChallengeBonusByChapter(chapterID)
	for i, v in pairs(m.mazeChallengeBonusDataTab) do
		if v:GetConfig().Chapter == chapterID and v.state == 2 then
			return true
		end
	end

	return false
end

function m.RefreshMazeChallengeBonusData()
	for i, v in pairs(m.mazeChallengeBonusDataTab) do
		local state = 1

		if table.indexOf(PlayerModule.PlayerInfo.unlockChapterTasks, v.cid) ~= -1 then
			state = 2
		end

		m.mazeChallengeBonusDataTab[i].buyState = state

		local tasks = m.GetMazeChallengeBonesTasks(v.cid)

		m.mazeChallengeBonusDataTab[i].tasks = tasks
	end

	EventDispatcher.Dispatch(EventID.UnlockChapterTasksEvent)
end

function m.GetMazeChallengeBonesTasks(cid)
	local taskTab = {}
	local cfgMazeChallengeBonusData = CfgMazeChallengeBonusTable[cid]

	for i = 1, #cfgMazeChallengeBonusData.Quest do
		local taskCid = cfgMazeChallengeBonusData.Quest[i]
		local targetNum = 0
		local state = 0
		local taskUIData
		local cfgMainQuestData = CfgMainQuestTable[taskCid]
		local cfgTargetData = CfgTargetTable[cfgMainQuestData.TargetId]
		local currentTaskServerPodData = TaskModule.GetProcessingTaskByCid(taskCid)

		if currentTaskServerPodData then
			taskUIData = TaskUIData.New(taskCid, currentTaskServerPodData.finNum, currentTaskServerPodData.tgtNum, TaskModule.TaskStatus.CURRENT_TASK, currentTaskServerPodData.createTime)
		end

		local finished = TaskModule.GetTaskFinished(TaskModule.TaskType.MAZE_CHALLENGE_BONUS_TASK, {})

		if table.indexOf(finished, taskCid) ~= -1 then
			targetNum = cfgTargetData.TargetNum
			state = TaskModule.TaskStatus.FINISH_TASK
		end

		if taskUIData == nil then
			taskUIData = TaskUIData.New(taskCid, targetNum, cfgTargetData.TargetNum, state)
		end

		table.insert(taskTab, taskUIData)
	end

	return taskTab
end

function m.GetUnlockChapters()
	local unlockChapterTasks = PlayerModule.PlayerInfo.unlockChapterTasks or {}
	local num = #unlockChapterTasks
	local totalNum = #m.mazeChallengeBonusDataTab

	return num, totalNum
end

function m.GetTaskNumsInChapter(chapterID)
	local num = 0
	local totalNum = 0

	for i, v in pairs(m.mazeChallengeBonusDataTab) do
		if v:GetConfig().Chapter == chapterID then
			num = #v:GetFinishTasks()
			totalNum = #v.tasks

			break
		end
	end

	return num, totalNum
end

function m.GetTaskNums()
	local num = 0
	local totalNum = 0

	for i, v in pairs(m.mazeChallengeBonusDataTab) do
		local n, m = m.GetTaskNumsInChapter(v:GetConfig().Chapter)

		num = num + n
		totalNum = totalNum + m
	end

	return num, totalNum
end

function m.CanGetRewardChapters()
	local tab = {}

	for i, v in pairs(m.mazeChallengeBonusDataTab) do
		local state = v:GetState()

		if state == 3 then
			table.insert(tab, v.cid)
		end
	end

	return tab
end

function m.Shutdown()
	m.RemoveListeners()
end

function m.UnlockChapterTasks(ids)
	net_quest.unlockChapterTasks(ids)
end

function m.UnlockChapterTasksResult(ids)
	PlayerModule.PlayerInfo.unlockChapterTasks = PlayerModule.PlayerInfo.unlockChapterTasks or {}

	for i, v in pairs(ids) do
		if table.indexOf(PlayerModule.PlayerInfo.unlockChapterTasks, v) == -1 then
			table.insert(PlayerModule.PlayerInfo.unlockChapterTasks, v)
		end
	end

	m.RefreshMazeChallengeBonusData()
end

MazeChallengeBonusModule = m
