-- chunkname: @IQIGame\\UI\\ActivityPassUI.lua

local ActivityPassUI = {
	curTaskType = 0,
	passScrollViewCell = {},
	taskScrollViewCell = {}
}

ActivityPassUI = Base:Extend("ActivityPassUI", "IQIGame.Onigao.UI.ActivityPassUI", ActivityPassUI)

local buyLevelPanel = require("IQIGame.UI.ActivityPassUI.BuyLevelPanel")
local passGetTipPanel = require("IQIGame.UI.ActivityPassUI.PassGetTipPanel")
local actionDescPanel = require("IQIGame.UI.ActivityPassUI.ActionDescPanel")
local passScrollItem = require("IQIGame.UI.ActivityPassUI.passScrollItem")
local taskScrollItem = require("IQIGame.UI.ActivityPassUI.taskScrollItem")
local extraRewardItem = require("IQIGame.UI.ActivityPassUI.extraRewardItem")
local maxRewardItem = require("IQIGame.UI.ActivityPassUI.maxRewardItem")
local LotterySkillNameTemplate = require("IQIGame/UI/Lottery/Template/LotterySkillNameTemplate")
local showType = {
	pass = 1,
	task = 2
}

function ActivityPassUI:OnInit()
	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:InitComponent()
	self:InitDelegate()
end

function ActivityPassUI:InitComponent()
	local taskScroll = self.taskScroll:GetComponent("ScrollAreaList")

	function taskScroll.onRenderCell(gridCell)
		self:OnTaskScrollRenderGridCell(gridCell)
	end

	self.buyLevelPanel = buyLevelPanel.New(self.buyLevelPanel, self)
	self.passGetTipPanel = passGetTipPanel.New(self.passGetTipPanel, self)
	self.actionDescPanel = actionDescPanel.New(self.actionDescPanel)
	self.extraRewardItem = extraRewardItem.New(self.extraReward)
	self.maxRewardItem = maxRewardItem.New(self.maxReward)
	self.commonReturnBtn = CommonReturnBtn.New(self.btnReturn, self)
	self.skillNameView = LotterySkillNameTemplate.New(self.skillNameTemplate)
	self.expImg = self.expImg:GetComponent("Image")
	self.optimizedPassScroll = self.optimizedPassScroll:GetComponent("OptimizedScrollRect")

	self.optimizedPassScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdatePassScroll(OptimizedParams, OptimizedViewsHolder)
	end)
end

function ActivityPassUI:InitDelegate()
	function self.buttonPassDelegate()
		self:OnButtonPassClick()
	end

	function self.buttonTaskDelegate()
		self:OnButtonTaskClick()
	end

	function self.buttonGetLevelDelegate()
		self:OnButtonGetLevelClick()
	end

	function self.buttonHelpDelegate()
		self:OnButtonHelpClick()
	end

	function self.buttonDailyDelegate()
		self:OnButtonDailyClick()
	end

	function self.buttonWeakenDelegate()
		self:OnButtonWeakenClick()
	end

	function self.buttonNormalDelegate()
		self:OnButtonNormalClick()
	end

	function self.buttonUnlockPassDelegate()
		self:OnButtonUnlockPassClick()
	end

	function self.buttonGetAllDelegate()
		self:OnButtonGetAllClick()
	end

	function self.EventRefreshDelegate()
		self:RefreshShow()
	end

	function self.refreshBaseInfoEvent()
		self:RefreshInfo()
	end

	function self.BuyLevelPanelCloseDelegate()
		self:BuyLevelPanelClose()
	end
end

function ActivityPassUI:OnAddListeners()
	self.buttonPass:GetComponent("Button").onClick:AddListener(self.buttonPassDelegate)
	self.buttonTask:GetComponent("Button").onClick:AddListener(self.buttonTaskDelegate)
	self.buttonGetLevel:GetComponent("Button").onClick:AddListener(self.buttonGetLevelDelegate)
	self.buttonHelp:GetComponent("Button").onClick:AddListener(self.buttonHelpDelegate)
	self.buttonDaily:GetComponent("Button").onClick:AddListener(self.buttonDailyDelegate)
	self.buttonWeaken:GetComponent("Button").onClick:AddListener(self.buttonWeakenDelegate)
	self.buttonNormal:GetComponent("Button").onClick:AddListener(self.buttonNormalDelegate)
	self.buttonUnlockPass:GetComponent("Button").onClick:AddListener(self.buttonUnlockPassDelegate)
	self.buttonGetAll:GetComponent("Button").onClick:AddListener(self.buttonGetAllDelegate)
	EventDispatcher.AddEventListener(EventID.ActivityPassUIRefreshPassInfo, self.EventRefreshDelegate)
	EventDispatcher.AddEventListener(EventID.RefreshPassUIBaseInfo, self.refreshBaseInfoEvent)
	RedDotModule.Subscribe(Constant.E_RedDotPath.PassActivity_TaskTab, self.taskTabRedDot)
	RedDotModule.Subscribe(Constant.E_RedDotPath.PassActivity_Daily, self.dailyRedDot)
	RedDotModule.Subscribe(Constant.E_RedDotPath.PassActivity_Week, self.weeklyRedDot)
	RedDotModule.Subscribe(Constant.E_RedDotPath.PassActivity_Normal, self.normalRedDot)
	RedDotModule.Subscribe(Constant.E_RedDotPath.PassActivity_RewardTab, self.awardTaskRedDot)
end

function ActivityPassUI:OnRemoveListeners()
	self.buttonPass:GetComponent("Button").onClick:RemoveListener(self.buttonPassDelegate)
	self.buttonTask:GetComponent("Button").onClick:RemoveListener(self.buttonTaskDelegate)
	self.buttonGetLevel:GetComponent("Button").onClick:RemoveListener(self.buttonGetLevelDelegate)
	self.buttonHelp:GetComponent("Button").onClick:RemoveListener(self.buttonHelpDelegate)
	self.buttonDaily:GetComponent("Button").onClick:RemoveListener(self.buttonDailyDelegate)
	self.buttonWeaken:GetComponent("Button").onClick:RemoveListener(self.buttonWeakenDelegate)
	self.buttonNormal:GetComponent("Button").onClick:RemoveListener(self.buttonNormalDelegate)
	self.buttonUnlockPass:GetComponent("Button").onClick:RemoveListener(self.buttonUnlockPassDelegate)
	self.buttonGetAll:GetComponent("Button").onClick:RemoveListener(self.buttonGetAllDelegate)
	EventDispatcher.RemoveEventListener(EventID.ActivityPassUIRefreshPassInfo, self.EventRefreshDelegate)
	EventDispatcher.RemoveEventListener(EventID.RefreshPassUIBaseInfo, self.refreshBaseInfoEvent)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.PassActivity_TaskTab, self.taskTabRedDot)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.PassActivity_Daily, self.dailyRedDot)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.PassActivity_Week, self.weeklyRedDot)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.PassActivity_Normal, self.normalRedDot)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.PassActivity_RewardTab, self.awardTaskRedDot)
end

function ActivityPassUI:OnOpen(userData)
	ShopModule.RefreshShop()

	if self.Timer == nil then
		self.Timer = Timer.New(function()
			self:RefreshTime()
		end, 1, -1)

		self.Timer:Start()
	end

	self:OnButtonPassClick()
	self:RefreshInfo()
	LuaUtility.SetGameObjectShow(self.MainPanel, true)
	LuaUtility.PlayAnimation(self.gameObject, "ActivityPassUI_In")

	if userData ~= nil and userData.openBuyView ~= nil and userData.openBuyView == true then
		self:OnButtonUnlockPassClick()
	end

	local activityPods = ActivityModule.GetActivityPodByActivityType({
		Constant.ActivityType.ActivityType_Normal
	})

	if ActivityModule.GetMultipleActivityIsOpenByActivityPod(activityPods) then
		self.skillNameView:Show(CfgActivityTable[activityPods[1].cid].ExtraParam[1])
	else
		self.skillNameView:Hide()
	end
end

function ActivityPassUI:OnClose(userData)
	if self.Timer then
		self.Timer:Stop()

		self.Timer = nil
	end
end

function ActivityPassUI:GetPreloadAssetPaths()
	return nil
end

function ActivityPassUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ActivityPassUI:IsManualShowOnOpen(userData)
	return false
end

function ActivityPassUI:GetBGM(userData)
	return nil
end

function ActivityPassUI:OnPause()
	return
end

function ActivityPassUI:OnResume()
	return
end

function ActivityPassUI:OnCover()
	return
end

function ActivityPassUI:OnReveal()
	return
end

function ActivityPassUI:OnRefocus(userData)
	return
end

function ActivityPassUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ActivityPassUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ActivityPassUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ActivityPassUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ActivityPassUI:OnDestroy()
	self.commonReturnBtn:Dispose()
	self.buyLevelPanel:Dispose()
	self.passGetTipPanel:Dispose()
	self.actionDescPanel:Dispose()
	self.extraRewardItem:Dispose()
	self.maxRewardItem:Dispose()

	for _, v in pairs(self.taskScrollViewCell) do
		v:Dispose()
	end

	for _, v in pairs(self.passScrollViewCell) do
		v:Dispose()
	end

	self.expImg = nil

	self.skillNameView:Dispose()
	AssetUtil.UnloadAsset(self)
end

function ActivityPassUI:OnButtonPassClick()
	self:SetCurrentTaskType(Constant.ExtendTaskType.Pass_NormalLevelReward)
	self:ResetSelectState()

	self.curShowType = showType.pass

	LuaUtility.SetGameObjectShow(self.passPanel, true)
	LuaUtility.SetGameObjectShow(self.taskPanel, false)
	LuaUtility.SetGameObjectShow(self.AwardPitchState, true)
	LuaUtility.SetText(self.AwardText, ActivityPassApi:GetActivityPassText(true))
	LuaUtility.SetText(self.TaskText, ActivityPassApi:GetActivityTaskText(false))
	self:RefreshPassScroll(false)
end

function ActivityPassUI:OnButtonTaskClick()
	self:ResetSelectState()

	self.curShowType = showType.task

	LuaUtility.SetGameObjectShow(self.passPanel, false)
	LuaUtility.SetGameObjectShow(self.taskPanel, true)
	LuaUtility.SetGameObjectShow(self.TaskPitchState, true)
	LuaUtility.SetText(self.AwardText, ActivityPassApi:GetActivityPassText(false))
	LuaUtility.SetText(self.TaskText, ActivityPassApi:GetActivityTaskText(true))
	self:OnButtonDailyClick()
	self:RefreshTaskScroll()
end

function ActivityPassUI:OnButtonGetLevelClick()
	self.buyLevelPanel:Show(true)
	LuaUtility.SetGameObjectShow(self.passPanel, false)
	LuaUtility.SetGameObjectShow(self.buttonGetAll, false)
end

function ActivityPassUI:OnButtonHelpClick()
	self.actionDescPanel:Show(true)
	self.actionDescPanel:Refresh(Constant.passCfgHelpTipsID)
end

function ActivityPassUI:ButtonStatus()
	LuaUtility.SetGameObjectShow(self.dailySelectImg.gameObject, false)
	LuaUtility.SetGameObjectShow(self.weakenSelectImg.gameObject, false)
	LuaUtility.SetGameObjectShow(self.normalSelectImg.gameObject, false)
	LuaUtility.SetTextColor(self.DailyText, 1, 1, 1, 1)
	LuaUtility.SetTextColor(self.WeakenText, 1, 1, 1, 1)
	LuaUtility.SetTextColor(self.NormalText, 1, 1, 1, 1)

	if self.curTaskType == Constant.ExtendTaskType.Pass_DailyMission then
		LuaUtility.SetGameObjectShow(self.dailySelectImg.gameObject, true)
		LuaUtility.SetTextColor(self.DailyText, 0, 0, 0, 1)
	elseif self.curTaskType == Constant.ExtendTaskType.Pass_WeeklyMission then
		LuaUtility.SetGameObjectShow(self.weakenSelectImg.gameObject, true)
		LuaUtility.SetTextColor(self.WeakenText, 0, 0, 0, 1)
	elseif self.curTaskType == Constant.ExtendTaskType.Pass_NormalMission then
		LuaUtility.SetGameObjectShow(self.normalSelectImg.gameObject, true)
		LuaUtility.SetTextColor(self.NormalText, 0, 0, 0, 1)
	end
end

function ActivityPassUI:OnButtonDailyClick()
	if self.curTaskType == Constant.ExtendTaskType.Pass_DailyMission then
		return
	end

	self:SetCurrentTaskType(Constant.ExtendTaskType.Pass_DailyMission)
	self:RefreshTaskScroll()
end

function ActivityPassUI:OnButtonWeakenClick()
	if self.curTaskType == Constant.ExtendTaskType.Pass_WeeklyMission then
		return
	end

	self:SetCurrentTaskType(Constant.ExtendTaskType.Pass_WeeklyMission)
	self:RefreshTaskScroll()
end

function ActivityPassUI:OnButtonNormalClick()
	if self.curTaskType == Constant.ExtendTaskType.Pass_NormalMission then
		return
	end

	self:SetCurrentTaskType(Constant.ExtendTaskType.Pass_NormalMission)
	self:RefreshTaskScroll()
end

function ActivityPassUI:OnButtonUnlockPassClick()
	self.passGetTipPanel:Show(true)
	self.passGetTipPanel:RefreshShow()
end

function ActivityPassUI:OnButtonGetAllClick()
	if not self.isCanGetAll then
		NoticeModule.ShowNoticeByType(Constant.NoticeType.FloatTips, ActivityPassApi:NotingCanGet())

		return
	end

	local list_String = {}

	if self.curTaskType == Constant.ExtendTaskType.Pass_NormalLevelReward then
		if ActivityPassModule.GetIsPay() then
			list_String = {
				TaskSystemModule.CombineContent(Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_NormalLevelReward),
				TaskSystemModule.CombineContent(Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_PaidLevelReward)
			}
		else
			list_String = {
				TaskSystemModule.CombineContent(Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_NormalLevelReward)
			}
		end

		if ActivityPassModule.GetPassLvIsMax() then
			table.insert(list_String, TaskSystemModule.CombineContent(Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_ApexLevelReward))
		end
	else
		list_String = {
			TaskSystemModule.CombineContent(Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_NormalMission),
			TaskSystemModule.CombineContent(Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_DailyMission),
			TaskSystemModule.CombineContent(Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_WeeklyMission)
		}
	end

	ActivityPassModule.submitTypePassTask(list_String)
end

function ActivityPassUI:Close()
	UIModule.Close(Constant.UIControllerName.ActivityPassUI)
end

function ActivityPassUI:ResetSelectState()
	LuaUtility.SetGameObjectShow(self.AwardPitchState, false)
	LuaUtility.SetGameObjectShow(self.TaskPitchState, false)
	self.buyLevelPanel:Show(false)
	self.passGetTipPanel:Show(false)
	self.actionDescPanel:Show(false)
	LuaUtility.SetGameObjectShow(self.buttonGetAll, true)
end

function ActivityPassUI:UpdatePassScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local cfg = ActivityPassModule.GetPassLevelTaskList()
	local data = cfg[index + 1]

	if not self.passScrollViewCell[instanceID] then
		self.passScrollViewCell[instanceID] = passScrollItem.New(viewGameObject, self)
	end

	self.passScrollViewCell[instanceID]:Refresh(data)

	local viewsHolder = self.optimizedPassScroll:GetItemViewsHolder(0)
	local extraIndex = ActivityPassModule.GetExtraLv(viewsHolder.ItemIndex)
	local extraData = cfg[extraIndex]

	self.extraRewardItem:Show(true)
	self.maxRewardItem:Show(false)
	self.extraRewardItem:Refresh(extraData, false, true)
end

function ActivityPassUI:OnTaskScrollRenderGridCell(gridCell)
	local index = gridCell.index + 1
	local insID = gridCell.gameObject:GetInstanceID()
	local cfg = TaskSystemModule.GetTaskListByPlayer(Constant.MainTaskType.Pass, self.curTaskType)
	local data = cfg[index]

	if self.taskScrollViewCell[insID] == nil then
		local taskItem = taskScrollItem.New(gridCell.gameObject)

		self.taskScrollViewCell[insID] = taskItem
	end

	self.taskScrollViewCell[insID]:Refresh(data)

	gridCell.transform.parent.gameObject.name = index
end

function ActivityPassUI:RefreshPassScroll(isDynamic)
	local cfg = ActivityPassModule.GetPassLevelTaskList()
	local itemCount = #cfg

	self.optimizedPassScroll:RefreshByItemCount(itemCount)

	local idx = 0
	local buyHigh = ActivityPassModule.GetHadBuyPassTypes_MultipleReturn()

	for i, v in ipairs(cfg) do
		idx = i - 1

		if v.status ~= Constant.TaskStatus.hadGot then
			break
		end

		if buyHigh then
			local highTask = ActivityPassModule.GetHighLevelTaskWithNormalID(v.cid)

			if highTask.status ~= Constant.TaskStatus.hadGot then
				break
			end
		end
	end

	self.optimizedPassScroll:ScrollTo(idx)
end

function ActivityPassUI:RefreshTaskScroll(isDynamic)
	local cfg = TaskSystemModule.GetTaskListByPlayer(Constant.MainTaskType.Pass, self.curTaskType)
	local taskScroll = self.taskScroll:GetComponent("ScrollAreaList")

	if isDynamic then
		taskScroll:RenderCellsDynamic(#cfg)
	else
		taskScroll:Refresh(#cfg)
	end

	self:ButtonStatus()
end

function ActivityPassUI:RefreshTime()
	UGUIUtil.SetText(self.textResidue, DateStandardFormation(ActivityPassModule.GetResidueTime()))
end

function ActivityPassUI:BuyLevelPanelClose()
	LuaUtility.SetGameObjectShow(self.passPanel, true)
	LuaUtility.SetGameObjectShow(self.buttonGetAll, true)
end

function ActivityPassUI:RefreshInfo()
	local maxExp = 0
	local curExp = 0

	if ActivityPassModule.GetPassLvIsMax() then
		self.buttonGetLevel:GetComponent("Button").interactable = false

		LuaUtility.SetGameObjectShow(self.buttonGetLevel.gameObject, false)
	else
		curExp = ActivityPassModule.passExp
		maxExp = ActivityPassModule.GetLvExp(ActivityPassModule.passLevel)
		self.buttonGetLevel:GetComponent("Button").interactable = true

		LuaUtility.SetGameObjectShow(self.buttonGetLevel.gameObject, true)
	end

	UGUIUtil.SetText(self.textTaskExp, ActivityPassApi:GetPassExp(maxExp < curExp and maxExp or curExp, maxExp))

	local maxLevel = #ActivityPassModule.GetPassLevelTaskList()

	self.expImg.fillAmount = curExp / maxExp

	UGUIUtil.SetText(self.textLevel, ActivityPassModule.passLevel)
	self:RefreshTime()
	LuaUtility.SetGameObjectShow(self.buttonUnlockPass.gameObject, false)

	local buyHigh, buySuper = ActivityPassModule.GetHadBuyPassTypes_MultipleReturn()

	if buyHigh or buySuper then
		LuaUtility.SetGameObjectShow(self.payLockImg.gameObject, false)
	else
		LuaUtility.SetGameObjectShow(self.payLockImg.gameObject, true)
	end

	LuaUtility.SetGameObjectShow(self.buttonUnlockPass.gameObject, not buySuper)
	self:CheckCanGetAll()

	if self.passGetTipPanel:GetPanelIsShow() then
		self.passGetTipPanel:RefreshShow()
	end

	EventDispatcher.Dispatch(EventID.BuyPassAnimationEvent)
end

function ActivityPassUI:RefreshShow()
	if TaskSystemModule.isGettingAll then
		return
	end

	self:RefreshInfo()

	if self.curShowType == showType.pass then
		self:RefreshPassScroll(true)
	elseif self.curShowType == showType.task then
		self:RefreshTaskScroll(true)
	end

	self.passGetTipPanel:RefreshShow()

	if self.buyLevelPanel:IsShow() then
		self.buyLevelPanel:Show(true)
	end
end

function ActivityPassUI:CheckCanGetAll()
	local taskData

	if self.curTaskType == Constant.ExtendTaskType.Pass_NormalLevelReward then
		if ActivityPassModule.GetIsPay() then
			taskData = TaskSystemModule.GetTaskListByPlayer(Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_PaidLevelReward)

			for i = 1, #taskData do
				if taskData[i].status == Constant.TaskStatus.hasDone then
					self.isCanGetAll = true

					return
				end
			end
		end

		taskData = TaskSystemModule.GetTaskListByPlayer(Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_NormalLevelReward)

		for i = 1, #taskData do
			if taskData[i].status == Constant.TaskStatus.hasDone then
				self.isCanGetAll = true

				return
			end
		end

		if ActivityPassModule.GetPassLvIsMax() then
			local maxData = ActivityPassModule.GetExtraRewardTaskData()

			if maxData ~= nil and maxData.count >= 1 then
				self.isCanGetAll = true

				return
			end
		end
	else
		taskData = TaskSystemModule.GetTaskListByPlayer(Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_NormalMission)

		for i = 1, #taskData do
			if taskData[i].status == Constant.TaskStatus.hasDone then
				self.isCanGetAll = true

				return
			end
		end

		taskData = TaskSystemModule.GetTaskListByPlayer(Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_DailyMission)

		for i = 1, #taskData do
			if taskData[i].status == Constant.TaskStatus.hasDone then
				self.isCanGetAll = true

				return
			end
		end

		taskData = TaskSystemModule.GetTaskListByPlayer(Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_WeeklyMission)

		for i = 1, #taskData do
			if taskData[i].status == Constant.TaskStatus.hasDone then
				self.isCanGetAll = true

				return
			end
		end
	end

	self.isCanGetAll = false
end

function ActivityPassUI:SetCurrentTaskType(type)
	self.curTaskType = type

	self:CheckCanGetAll()
end

return ActivityPassUI
