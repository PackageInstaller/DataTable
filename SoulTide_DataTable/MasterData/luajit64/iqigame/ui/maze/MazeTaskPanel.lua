-- chunkname: @IQIGame\\UI\\Maze\\MazeTaskPanel.lua

local m = {
	FOLD_DURATION = 0.3,
	FoldStartTime = 0,
	IsFold = true,
	TaskItems = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MazeTaskItem = require("IQIGame.UI.Maze.MazeTaskItem")
local MazeTaskTargetItem = require("IQIGame.UI.Maze.MazeTaskTargetItem")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickFoldBtn()
		self:OnClickFoldBtn()
	end

	function self.DelegateOnClickUnfoldBtn()
		self:OnClickUnfoldBtn()
	end

	function self.DelegateOnPreUpdateMazeTask(cid, oldProgresses, progresses)
		self:OnPreUpdateMazeTask(cid, oldProgresses, progresses)
	end

	self.FoldBtn:SetActive(true)
	self.UnfoldBtn:SetActive(false)

	self.TaskTargetItemPool = UIObjectPool.New(20, function()
		return MazeTaskTargetItem.New(UnityEngine.Object.Instantiate(self.TaskTargetItemPrefab))
	end, function(item)
		local v = item.View

		item:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.TaskItemPool = UIObjectPool.New(10, function()
		return MazeTaskItem.New(UnityEngine.Object.Instantiate(self.TaskItemPrefab), self.TaskTargetItemPool)
	end, function(item)
		local v = item.View

		item:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
end

function m:OnAddListeners()
	self.FoldBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFoldBtn)
	self.UnfoldBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUnfoldBtn)
	EventDispatcher.AddEventListener(EventID.PreUpdateMazeTask, self.DelegateOnPreUpdateMazeTask)
end

function m:OnRemoveListeners()
	self.FoldBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFoldBtn)
	self.UnfoldBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUnfoldBtn)
	EventDispatcher.RemoveEventListener(EventID.PreUpdateMazeTask, self.DelegateOnPreUpdateMazeTask)
end

function m:OnClickFoldBtn()
	self:Fold()
end

function m:Fold()
	self.IsFold = true

	self:PlayFold()
end

function m:Unfold()
	self.IsFold = false

	self:PlayFold()
end

function m:OnClickUnfoldBtn()
	self:Unfold()
end

function m:PlayFold()
	if self.FoldTimer ~= nil then
		self.FoldTimer:Stop()
	end

	local frameInterval = 0.02

	self.FoldStartTime = UnityEngine.Time.realtimeSinceStartup
	self.FoldTimer = Timer.New(function()
		local elapsedTime = UnityEngine.Time.realtimeSinceStartup - self.FoldStartTime
		local timeRatio = elapsedTime / m.FOLD_DURATION

		if timeRatio > 1 then
			timeRatio = 1
		end

		if self.FoldTimer.loop == 1 then
			self.FoldTimer = nil
			self.FoldStartTime = 0
			timeRatio = 1
		end

		self:OnUpdateFold(timeRatio)
		self.FoldBtn:SetActive(not self.IsFold)
		self.UnfoldBtn:SetActive(self.IsFold)
	end, frameInterval, m.FOLD_DURATION / frameInterval)

	self.FoldTimer:Start()
end

function m:OnUpdateFold(timeRatio)
	local position = self.View.transform.anchoredPosition
	local exitBtnTransparentGap = 9
	local virtualWidth = self.View.transform.sizeDelta.x + 100
	local initPos = self.IsFold and exitBtnTransparentGap or -virtualWidth
	local direction = self.IsFold and -1 or 1

	position.x = initPos + timeRatio * virtualWidth * direction + exitBtnTransparentGap
	self.View.transform.anchoredPosition = position
end

function m:Refresh(newTaskCid)
	self:ClearTasks()

	local tasks = {}

	if MazeDataModule.PlayerInfo then
		for cid, progresses in pairs(MazeDataModule.PlayerInfo.MazeTasks) do
			local cfgMazeTaskData = CfgMazeTaskTable[cid]
			local isFinish = self:CalcIsTaskFinish(cfgMazeTaskData, progresses)

			if not isFinish or cfgMazeTaskData.TaskType == 1 then
				table.insert(tasks, {
					cid = cid,
					progresses = progresses,
					isFinish = isFinish
				})
			end
		end

		table.sort(tasks, function(data1, data2)
			if data1.type == data2.type then
				return data1.cid < data2.cid
			end

			return data1.type < data2.type
		end)

		for i = 1, #tasks do
			local data = tasks[i]
			local cid = data.cid
			local progresses = data.progresses
			local isFinish = data.isFinish
			local taskItem = self.TaskItemPool:Obtain()

			taskItem.View:SetActive(true)
			taskItem.View.transform:SetParent(self.TaskItemParent.transform, false)
			taskItem.View.transform:SetSiblingIndex(self.TaskItemParent.transform.childCount - 1)
			taskItem:SetData(cid, progresses, isFinish, cid == newTaskCid)
			table.insert(self.TaskItems, taskItem)
		end

		if self.IsFold then
			self:Unfold()
		end

		self.View:SetActive(#tasks > 0)
	end
end

function m:CalcIsTaskFinish(cfgMazeTaskData, progresses)
	local allNecessaryFinished = true
	local finishTargetNum = 0

	for i = 1, #cfgMazeTaskData.TargetId do
		local cfgMazeTargetData = CfgMazeTargetTable[cfgMazeTaskData.TargetId[i]]
		local progress = progresses[i]
		local isFinish = progress >= cfgMazeTargetData.TotalProgress

		if isFinish then
			finishTargetNum = finishTargetNum + 1
		elseif cfgMazeTargetData.IsRequire and not isFinish then
			allNecessaryFinished = false
		end
	end

	return allNecessaryFinished and finishTargetNum >= cfgMazeTaskData.TargetNeedFinishCount
end

function m:ClearTasks(isDestroy)
	for i = 1, #self.TaskItems do
		local taskItem = self.TaskItems[i]

		taskItem.View:SetActive(false)

		if isDestroy then
			taskItem.View.transform:SetParent(self.View.transform.parent, false)
		end

		self.TaskItemPool:Release(taskItem)
	end

	self.TaskItems = {}
end

function m:OnPreUpdateMazeTask(cid, oldProgresses, progresses)
	local updateTaskItem

	for i = 1, #self.TaskItems do
		local taskItem = self.TaskItems[i]

		if taskItem.CfgMazeTaskData.Id == cid then
			updateTaskItem = taskItem

			break
		end
	end

	local newTaskCid

	if updateTaskItem == nil then
		newTaskCid = cid
	end

	local waitForRemove = false

	if progresses == nil then
		if updateTaskItem == nil then
			logError("删除迷宫任务失败。任务" .. cid .. "已经被删除。")
		else
			updateTaskItem:PlayRemoveEffect()

			waitForRemove = true
		end
	end

	if waitForRemove then
		if self.DelayRefreshTimer ~= nil then
			self.DelayRefreshTimer:Stop()
		end

		self.DelayRefreshTimer = Timer.New(function()
			self.DelayRefreshTimer = nil

			self:Refresh()
		end, 1)

		self.DelayRefreshTimer:Start()
	else
		self:Refresh(newTaskCid)
	end
end

function m:Dispose()
	if self.FoldTimer ~= nil then
		self.FoldTimer:Stop()

		self.FoldTimer = nil
	end

	if self.DelayRefreshTimer ~= nil then
		self.DelayRefreshTimer:Stop()

		self.DelayRefreshTimer = nil
	end

	self:ClearTasks(true)
	self.TaskItemPool:Dispose()
	self.TaskTargetItemPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
