-- chunkname: @IQIGame\\UI\\ExploreHall\\MazePanelController.lua

local m = {
	IsShow = false,
	EndlessMazeEffectId = 0
}
local MainMazeBtnController = require("IQIGame.UI.ExploreHall.MainMazeBtnController")
local EndlessMazeBtnController = require("IQIGame.UI.ExploreHall.EndlessMazeBtnController")
local SpaceTreasureBtnController = require("IQIGame.UI.ExploreHall.SpaceTreasureBtnController")

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickMainMazeBtn()
		self:OnClickMainMazeBtn()
	end

	function self.DelegateOnClickEndlessMazeBtn()
		self:OnClickEndlessMazeBtn()
	end

	function self.DelegateOnClickSpaceTreasureBtn()
		self:OnClickSpaceTreasureBtn()
	end

	function self.DelegateOnClickClaimAllRewardBtn()
		self:OnClickClaimAllRewardBtn()
	end

	function self.DelegateOnCommitTaskSuccess(cids, rewards)
		self:OnCommitTaskSuccess(cids, rewards)
	end

	function self.DelegateOnTaskUpdate(cid)
		self:OnTaskUpdate(cid)
	end

	function self.DelegateOnEffectShow(sender, args)
		self:OnEffectShow(sender, args)
	end

	function self.DelegateOnUpdateMaze()
		self:Show()
	end

	self.MainMazeBtnController = MainMazeBtnController.New(self.MainMazeBtn, self.Host)
	self.EndlessMazeBtnController = EndlessMazeBtnController.New(self.EndlessMazeBtn)
	self.SpaceTreasureBtnController = SpaceTreasureBtnController.New(self.SpaceTreasureBtn)

	UGUIUtil.SetTextInChildren(self.ClaimAllRewardBtn, ExploreHallUIApi:GetString("ClaimAllRewardBtn"))
end

function m:Show()
	self.IsShow = true

	self.View:SetActive(true)
	self:AddListeners()

	local cfgChapterData, cfgMazeInstanceData, unfinishedMazeCid = PlayerModule.GetNormalMazeExploreProgressData()
	local unfinishedEndlessMazeCid = PlayerModule.GetUnfinishedMazeCid(Constant.Maze.ChapterTypeEndless)

	self.ChapterCid = cfgChapterData.Id

	self.MainMazeBtnController:SetData(cfgChapterData, cfgMazeInstanceData, unfinishedMazeCid)
	self.EndlessMazeBtnController:SetData(UnlockFunctionModule.IsUnlock(Constant.UnlockType.ENDLESS_MAZE), unfinishedEndlessMazeCid)
	self.SpaceTreasureBtnController:Refresh()

	if self.jumpIndex then
		self:DoJumpPanel(self.jumpIndex)

		self.jumpIndex = nil
	end

	self.TaskCids = self:GetExploreTasks()

	self.ClaimAllRewardBtn:SetActive(#self.TaskCids > 0)
end

function m:JumpPanel(tabIndex)
	self.jumpIndex = tabIndex
end

function m:DoJumpPanel(tabIndex)
	if tabIndex == 1 then
		self:OnClickMainMazeBtn()
	elseif tabIndex == 2 then
		self:OnClickEndlessMazeBtn()
	elseif tabIndex == 3 then
		self:OnClickSpaceTreasureBtn()
	end
end

function m:Hide()
	self.IsShow = false

	self:RemoveListeners()
	self.View:SetActive(false)
end

function m:AddListeners()
	self.MainMazeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMainMazeBtn)
	self.EndlessMazeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEndlessMazeBtn)
	self.SpaceTreasureBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSpaceTreasureBtn)
	self.ClaimAllRewardBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClaimAllRewardBtn)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.DelegateOnCommitTaskSuccess)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
	EventDispatcher.AddEventListener(EventID.UpdateMaze, self.DelegateOnUpdateMaze)
end

function m:RemoveListeners()
	self.MainMazeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMainMazeBtn)
	self.EndlessMazeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEndlessMazeBtn)
	self.SpaceTreasureBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSpaceTreasureBtn)
	self.ClaimAllRewardBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClaimAllRewardBtn)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.DelegateOnCommitTaskSuccess)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
	EventDispatcher.RemoveEventListener(EventID.UpdateMaze, self.DelegateOnUpdateMaze)
end

function m:GetExploreTasks()
	local taskCids = {}

	for id, cfgChapterData in pairsCfg(CfgChapterTable) do
		local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.EXPLORE_POINT_TASK, {
			id
		})

		for i = 1, #processing do
			local taskData = processing[i]

			if taskData.finNum >= taskData.tgtNum then
				table.insert(taskCids, taskData.cid)
			end
		end
	end

	return taskCids
end

function m:OnClickMainMazeBtn()
	local unfinishedMazeCid = PlayerModule.GetUnfinishedMazeCid(Constant.Maze.ChapterTypeNormal)

	if unfinishedMazeCid ~= nil then
		MazeModule.SendRestore(unfinishedMazeCid)
	else
		UIModule.Open(Constant.UIControllerName.MazeSelectLevelUI, Constant.UILayer.UI, {
			chapterCid = self.ChapterCid
		})
	end
end

function m:OnClickEndlessMazeBtn()
	local unfinishedMazeCid = PlayerModule.GetUnfinishedMazeCid(Constant.Maze.ChapterTypeEndless)

	if unfinishedMazeCid ~= nil then
		MazeModule.SendRestore(unfinishedMazeCid)
	else
		if self.EndlessMazeEffectId ~= 0 or UIModule.HasUI(Constant.UIControllerName.EndlessMazeEntryUI) or UIModule.IsLoadingUI(Constant.UIControllerName.EndlessMazeEntryUI) then
			return
		end

		GameEntry.LuaEvent:Subscribe(EffectShowEventArgs.EventId, self.DelegateOnEffectShow)

		self.EndlessMazeEffectId = GameEntry.Effect:PlayUIEffect(9007001, Vector3.zero, self.Host.UIController:GetComponentInParent(typeof(UnityEngine.Canvas)).sortingOrder + 20)
	end
end

function m:OnEffectShow(sender, args)
	if args.EffectPlayID == self.EndlessMazeEffectId then
		GameEntry.LuaEvent:Unsubscribe(EffectShowEventArgs.EventId, self.DelegateOnEffectShow)

		self.EndlessMazeEffectId = 0

		UIModule.Open(Constant.UIControllerName.EndlessMazeEntryUI, Constant.UILayer.UI)
	end
end

function m:OnClickSpaceTreasureBtn()
	UIModule.Open(Constant.UIControllerName.MazeHiddenMazeUI, Constant.UILayer.UI)
end

function m:OnClickClaimAllRewardBtn()
	if self.TaskCids ~= nil and #self.TaskCids > 0 then
		self.SendingCommitTask = true

		TaskModule.SendCommitTaskMsgBatch(self.TaskCids)

		self.TaskCids = nil
	end
end

function m:OnCommitTaskSuccess(cids, rewards)
	if self.SendingCommitTask then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end

	self.SendingCommitTask = false
end

function m:OnTaskUpdate(cid)
	self.TaskCids = self:GetExploreTasks()

	self.ClaimAllRewardBtn:SetActive(#self.TaskCids > 0)
end

function m:Dispose()
	self.MainMazeBtnController:Dispose()
	self.EndlessMazeBtnController:Dispose()
	self.SpaceTreasureBtnController:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
	self.TaskCids = nil
end

return m
