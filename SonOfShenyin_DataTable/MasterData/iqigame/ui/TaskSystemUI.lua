-- chunkname: @IQIGame\\UI\\TaskSystemUI.lua

local TaskSystemUI = Base:Extend("TaskSystemUI", "IQIGame.Onigao.UI.TaskSystemUI", {
	cellList = {
		ActivitycellList = {},
		DaycellList = {},
		BranchcellList = {}
	},
	taskTypeTap = {
		achievement = 5,
		branch = 2,
		main = 1,
		week = 4,
		day = 3
	}
})
local TaskSystemCell = require("IQIGame.UI.TaskSystem.TaskSystemCell")
local TaskDayCell = require("IQIGame.UI.TaskSystem.TaskDayCell")
local TaskTrunkView = require("IQIGame.UI.TaskSystem.TaskTrunkView")
local TaskDayAwardCell = require("IQIGame.UI.TaskSystem.TaskDayAwardCell")
local taskAwardShowTipsPanel = require("IQIGame.UI.TaskSystem.TaskAwardShowTipsPanel")
local mainTaskPanel = require("IQIGame/UI/TaskSystem/TaskSystemUI_mainTaskPanel")
local achievementPanel = require("IQIGame/UI/TaskSystem/TaskSystemUI_achievementPanel")

function TaskSystemUI:OnInit()
	LuaCodeInterface.BindOutlet(self.View, self)
	self:InitDelegates()
	self:Initialize()
end

function TaskSystemUI:InitDelegates()
	function self.delegateOnTogglePartChanged(index, isOn)
		self:OnTogglePartChanged(index, isOn)
	end

	function self.OnBranchAllGetButtonClicked()
		self:OnClickBranchAllGet()
	end

	function self.OnDayAllGetButtonClicked()
		self:OnClickDayAllGet()
	end

	function self.OnWeekAllGetButtonClicked()
		self:OnClickWeekAllGet()
	end

	function self.OnTaskSubmitSucceedDelegate(ItemShowPODList)
		self:OnTaskSubmitSucceed(ItemShowPODList)
	end

	function self.delegateOnNotifyTask(tasks)
		self:OnTaskNotifyTask(tasks)
	end

	function self.delegateOnNotifyRemove(ItemShowPODList)
		self:OnTaskNotifyRemove(ItemShowPODList)
	end

	function self.taskAwardShowEvent(data)
		self:OnTaskAwardShow(data)
	end

	function self.delegateOnNotifyRedDotTaskMain()
		self:UpdateRedDotTaskMain()
	end

	function self.delegateOnNotifyRedDotTaskBranch()
		self:UpdateRedDotTaskBranch()
	end

	function self.delegateOnNotifyRedDotTaskDaily()
		self:UpdateRedDotTaskDaily()
	end

	function self.delegateOnNotifyRedDotTaskWeekly()
		self:UpdateRedDotTaskWeekly()
	end
end

function TaskSystemUI:Initialize()
	self.taskTapContent = TapContents:New()

	self.taskTapContent:Init(self.tapContent.gameObject, self.delegateOnTogglePartChanged)

	self.trunkTaskContentScroll = self.branchScroll:GetComponent("ScrollAreaList")

	function self.trunkTaskContentScroll.onRenderCell(gridCell)
		self:OnTrunkTaskRenderGridCell(gridCell)
	end

	self.myDayAwardContentScroll = self.dayAwardContentScroll:GetComponent("ScrollAreaList")

	function self.myDayAwardContentScroll.onRenderCell(gridCell)
		self:OnDayTaskAwardRenderGridCell(gridCell)
	end

	self.dayContentScroll = self.dayContentScroll:GetComponent("ScrollAreaList")

	function self.dayContentScroll.onRenderCell(gridCell)
		self:OnDayTaskRenderGridCell(gridCell)
	end

	self.branchAllGetButton = self.branchAllGet:GetComponent("Button")
	self.dayAllGetButton = self.dayAllGetBtn:GetComponent("Button")
	self.weekAllGetButton = self.weekAllGetBtn:GetComponent("Button")
	self.imageFill = self.imageFill:GetComponent("Image")
	self.taskAwardShowTipsPanel = taskAwardShowTipsPanel.New(self.awardShowTipsPanel)

	self.taskAwardShowTipsPanel:Show(false)

	self.dayAwardBoxItemList = {}

	for i = 1, self.dayAwardBoxRoot.transform.childCount do
		local transformDayAwardBox = self.dayAwardBoxRoot.transform:GetChild(i - 1)
		local dayAwardBoxItem = TaskDayAwardCell.New(transformDayAwardBox.gameObject, self)

		table.insert(self.dayAwardBoxItemList, dayAwardBoxItem)
	end

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	if self.Timer == nil then
		self.Timer = Timer.New(function()
			self:RefreshTime()
		end, 1, -1)

		self.Timer:Start()
	end

	self.mainTaskPanel = mainTaskPanel.New(self.mainTaskPanel, self)

	self.mainTaskPanel:Hide()

	self.achievementPanel = achievementPanel.New(self.AchieveRoot, self)

	self.achievementPanel:Hide()
end

function TaskSystemUI:InitStaticText()
	self:InitSetStaticText(self.tapBranchNdes, TaskUIApi:GetTipsMainTaskDes())
	self:InitSetStaticText(self.tapBranchHdes, TaskUIApi:GetTipsMainTaskDes())
	self:InitSetStaticText(self.tapDayNdes, TaskUIApi:GetTipsDayTaskDes())
	self:InitSetStaticText(self.tapDayHdes, TaskUIApi:GetTipsDayTaskDes())
	self:InitSetStaticText(self.tapWeekNdes, TaskUIApi:GetTipsWeekTaskDes())
	self:InitSetStaticText(self.tapWeekHdes, TaskUIApi:GetTipsWeekTaskDes())
	self:InitSetStaticText(self.tapPeriodNdes, TaskUIApi:GetTipsPeriodTaskDes())
	self:InitSetStaticText(self.tapPeriodHdes, TaskUIApi:GetTipsPeriodTaskDes())
	self:InitSetStaticText(self.allFinishdesText, TaskUIApi:GetTipsNoMainTaskDes())
end

function TaskSystemUI:InitSetStaticText(obj, text)
	local objText = obj:GetComponent("Text")

	objText.text = text
end

function TaskSystemUI:GetChooseType()
	return self.curChooseType, self.curChooseExtendType
end

function TaskSystemUI:SetChooseType(mainType, extendType)
	self.curChooseType = mainType
	self.curChooseExtendType = extendType
end

function TaskSystemUI:CompareChooseType(mainType, extendType)
	return self.curChooseType == mainType and self.curChooseExtendType == extendType
end

function TaskSystemUI:OnTogglePartChanged(index)
	self.ToggleName = index

	self.mainTaskPanel:Hide()
	self.achievementPanel:Hide()

	if index == self.taskTypeTap.main then
		self.trunkRoot:SetActive(false)
		self.dayRoot:SetActive(false)

		self.contentScroll = self.trunkTaskContentScroll

		self.mainTaskPanel:Show(Constant.MainTaskType.RPGMain)

		return
	elseif index == self.taskTypeTap.branch then
		self.trunkRoot:SetActive(false)
		self.dayRoot:SetActive(false)

		self.contentScroll = self.trunkTaskContentScroll

		self.mainTaskPanel:Show(Constant.MainTaskType.RPGBranch)

		return
	elseif index == self.taskTypeTap.day then
		if UnlockFunctionModule.OnClickInterceptor(Constant.UnlockType.FUNC_DayTask) then
			return
		end

		self.trunkRoot:SetActive(false)
		self.dayRoot:SetActive(true)
		LuaUtility.SetGameObjectShow(self.dailyImg, true)
		LuaUtility.SetGameObjectShow(self.weekImg, false)
		self:SetChooseType(Constant.MainTaskType.Daily, nil)

		self.contentScroll = self.dayContentScroll
		self.ActivityMainType = Constant.MainTaskType.Daily
		self.ActivityExtendType = Constant.ExtendTaskType.Daily_Activity
	elseif index == self.taskTypeTap.week then
		if UnlockFunctionModule.OnClickInterceptor(Constant.UnlockType.FUNC_WeekTask) then
			return
		end

		self.trunkRoot:SetActive(false)
		self.dayRoot:SetActive(true)
		LuaUtility.SetGameObjectShow(self.weekImg, true)
		LuaUtility.SetGameObjectShow(self.dailyImg, false)
		self:SetChooseType(Constant.MainTaskType.Weekly, nil)

		self.contentScroll = self.dayContentScroll
		self.ActivityMainType = Constant.MainTaskType.Weekly
		self.ActivityExtendType = Constant.ExtendTaskType.Weekly_Activity
	elseif index == self.taskTypeTap.achievement then
		self.trunkRoot:SetActive(false)
		self.dayRoot:SetActive(false)
		self.achievementPanel:Show(Constant.MainTaskType.Achievement)
	end

	if self:CompareChooseType(Constant.MainTaskType.Daily, nil) or self:CompareChooseType(Constant.MainTaskType.Weekly, nil) then
		self:RefreshBoxRewardProgress()
		self:RefreshTime()
	end

	self:RefreshData()
end

function TaskSystemUI:RefreshData()
	if TaskSystemModule.GetIsGettingAll() then
		return
	end

	self:RefreshScrollData()
	self:RefreshAllBtn()
end

function TaskSystemUI:PlayUIEffect()
	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)
	end

	self.effectID = GameEntry.Effect:PlayUIMountPointEffect(10008, 50000, 0, self.EffectParent, 0)
end

function TaskSystemUI:RefreshAllBtn()
	local isShow

	if self:CompareChooseType(Constant.MainTaskType.Main, Constant.ExtendTaskType.Main_Branch) then
		isShow = TaskSystemModule.IsCanGetAward(self:GetChooseType())

		local trunkIsShow = TaskSystemModule.IsCanGetAward(Constant.MainTaskType.Main, Constant.ExtendTaskType.Main_Branch)

		self.allGetRoot:SetActive(isShow or trunkIsShow)
	elseif self:CompareChooseType(Constant.MainTaskType.Daily, nil) then
		isShow = TaskSystemModule.IsCanGetAwards(Constant.MainTaskType.Daily, Constant.ExtendTaskType.Daily_Mission)

		self.dayAllGetRoot:SetActive(isShow)
	elseif self:CompareChooseType(Constant.MainTaskType.Weekly, nil) then
		isShow = TaskSystemModule.IsCanGetAwards(Constant.MainTaskType.Weekly, Constant.ExtendTaskType.Weekly_Mission)

		self.dayAllGetRoot:SetActive(isShow)
	end
end

function TaskSystemUI:RefreshBoxRewardProgress()
	local allSchedule = TaskSystemModule.GetActivityTotalSchedule(self.ActivityMainType, self.ActivityExtendType)

	UGUIUtil.SetText(self.AllProgressText, allSchedule)

	local curSchedule, itemData

	if self:CompareChooseType(Constant.MainTaskType.Daily, nil) then
		itemData = WarehouseModule.GetItemDataByCfgID(Constant.ItemCid.DayActivity)
	elseif self:CompareChooseType(Constant.MainTaskType.Weekly, nil) then
		itemData = WarehouseModule.GetItemDataByCfgID(Constant.ItemCid.WeeklyActivity)
	end

	curSchedule = not itemData and 0 or itemData.num

	UGUIUtil.SetText(self.ProgressText, curSchedule)
	self:RefreshBoxFillAmount(curSchedule)
end

function TaskSystemUI:RefreshBoxFillAmount(currentActivity)
	local activeList = TaskSystemModule.GetSortForTypeDataList(self.ActivityMainType, self.ActivityExtendType, TaskSystemModule.sortType.Schedule, true)
	local average = 1 / getCfgTableLength(activeList)
	local n = 1
	local currentMax = 0

	for i = 1, getCfgTableLength(activeList) do
		if currentActivity <= activeList[i].needSchedule then
			n = i
			currentMax = activeList[i].needSchedule

			break
		end
	end

	local fill = n * average / currentMax * currentActivity

	self.imageFill.fillAmount = fill
end

function TaskSystemUI:RefreshBoxItemShow()
	for i = 1, getCfgTableLength(self.dayAwardBoxItemList) do
		local data = self.activityList[i]

		self.dayAwardBoxItemList[i]:Refresh(data, self.UIController)
	end
end

function TaskSystemUI:OnTrunkTaskRenderGridCell(gridCellData)
	local data = self.scrollDataList[gridCellData.index + 1]
	local insID = gridCellData.gameObject:GetInstanceID()
	local cell = self.cellList.BranchcellList[insID]

	data.insID = insID

	if cell == nil then
		cell = TaskSystemCell.New(gridCellData.gameObject, self)
		self.cellList.BranchcellList[insID] = cell
	end

	cell:Refresh(data, self.UIController)

	gridCellData.gameObject.name = data.cid
	gridCellData.transform.parent.gameObject.name = "Index" .. gridCellData.index + 1
end

function TaskSystemUI:OnDayTaskAwardRenderGridCell(gridCellData)
	local data = self.activityList[gridCellData.index + 1]
	local insID = gridCellData.gameObject:GetInstanceID()
	local cell = self.cellList.ActivitycellList[insID]

	data.insID = insID

	if cell == nil then
		cell = TaskDayAwardCell.New(gridCellData.gameObject, self)
		self.cellList.ActivitycellList[insID] = cell
	end

	cell:Refresh(data, self.UIController)

	gridCellData.gameObject.name = data.cid
	gridCellData.transform.parent.gameObject.name = "Index" .. gridCellData.index + 1
end

function TaskSystemUI:OnDayTaskRenderGridCell(gridCellData)
	local data = self.scrollDataList[gridCellData.index + 1]
	local insID = gridCellData.gameObject:GetInstanceID()
	local cell = self.cellList.DaycellList[insID]

	data.insID = insID

	if cell == nil then
		cell = TaskDayCell.New(gridCellData.gameObject, self)
		self.cellList.DaycellList[insID] = cell
	end

	cell:Refresh(data, self.UIController)

	gridCellData.gameObject.name = data.cid
	gridCellData.transform.parent.gameObject.name = "Index" .. gridCellData.index + 1
end

function TaskSystemUI:GetPreloadAssetPaths()
	return nil
end

function TaskSystemUI:GetOpenPreloadAssetPaths(userData)
	local _t = {}

	self.trunkList = TaskSystemModule.GetSortForTypeDataList(Constant.MainTaskType.Main, Constant.ExtendTaskType.Main_Main, TaskSystemModule.sortType.Weight_ID)

	if #self.trunkList > 0 then
		self.forewordpath = TaskUIApi:GetForWardPath(self.trunkList[1].BaseData.TrunkPath)
	else
		self.forewordpath = TaskUIApi:GetForWardPath()
	end

	table.insert(_t, self.forewordpath)

	return _t
end

function TaskSystemUI:IsManualShowOnOpen(userData)
	return false
end

function TaskSystemUI:GetBGM(userData)
	return nil
end

function TaskSystemUI:OnOpen(userData)
	if self.taskTrunkView == nil then
		self.taskTrunkView = TaskTrunkView.New(self.trunkRoot, self)
	end

	local taskTypeTap = self.taskTypeTap.main

	if userData and userData.TaskTypeTap then
		taskTypeTap = userData.TaskTypeTap
	end

	self.taskTapContent:ToggleEvent(taskTypeTap)

	local funcList = {}

	funcList[Constant.UnlockType.FUNC_DayTask] = self.Day
	funcList[Constant.UnlockType.FUNC_WeekTask] = self.Week
	funcList[Constant.UnlockType.FUNC_Branch] = self.Period
	funcList[Constant.UnlockType.FUNC_AchievementTask] = self.Achieve

	UnlockFunctionModule.FuncSwitchHandler(funcList)
end

function TaskSystemUI:RefreshScrollData()
	if self:CompareChooseType(Constant.MainTaskType.Main, Constant.ExtendTaskType.Main_Branch) then
		local curChooseType, curChooseExtendType = self:GetChooseType()

		self.scrollDataList = TaskSystemModule.GetSortForTypeDataList(curChooseType, curChooseExtendType, nil, true, true)

		self.taskTrunkView:Refresh()
	elseif self:CompareChooseType(Constant.MainTaskType.Daily, nil) or self:CompareChooseType(Constant.MainTaskType.Weekly, nil) then
		local mainType, extendType = self:GetChooseType()

		if mainType == Constant.MainTaskType.Daily then
			extendType = Constant.ExtendTaskType.Daily_Mission
		elseif mainType == Constant.MainTaskType.Weekly then
			extendType = Constant.ExtendTaskType.Weekly_Mission
		end

		self.scrollDataList = TaskSystemModule.GetSortForTypeDataList(mainType, extendType, nil, true)
		self.activityList = TaskSystemModule.GetSortForTypeDataList(self.ActivityMainType, self.ActivityExtendType, TaskSystemModule.sortType.Id, true)

		self:RefreshBoxItemShow()
		self:RefreshBoxRewardProgress()
	end

	if self.scrollDataList then
		self.contentScroll:Refresh(#self.scrollDataList)
	end

	if self.achievementPanel.gameObject.activeSelf then
		self.achievementPanel:RefreshByServerNotify()
	end
end

function TaskSystemUI:OnTaskSubmitSucceed()
	self:RefreshData()
end

function TaskSystemUI:OnTaskNotifyTask()
	if TaskSystemModule:GetSubmitTaskMark() == true then
		return
	end

	self:RefreshData()
end

function TaskSystemUI:OnTaskNotifyRemove()
	if TaskSystemModule:GetSubmitTaskMark() == true then
		return
	end

	self:RefreshData()
end

function TaskSystemUI:OnTaskAwardShow(data)
	self.taskAwardShowTipsPanel:Show(true, data)
end

function TaskSystemUI:OnCloseBtn()
	UIModule.Close(Constant.UIControllerName.TaskSystemUI)
end

function TaskSystemUI:GetAllAwardsForTypeFunction()
	local SubmitTypes = {}
	local chooseMainType, chooseExtendType = self:GetChooseType()

	if chooseMainType == Constant.MainTaskType.Main and chooseExtendType == Constant.ExtendTaskType.Main_Branch then
		table.insert(SubmitTypes, TaskSystemModule.CombineContent(Constant.MainTaskType.Main, Constant.ExtendTaskType.Main_Branch))
		self.allGetRoot:SetActive(false)
	elseif chooseMainType == Constant.MainTaskType.Daily then
		table.insert(SubmitTypes, TaskSystemModule.CombineContent(Constant.MainTaskType.Daily, Constant.ExtendTaskType.Daily_Mission))
		table.insert(SubmitTypes, TaskSystemModule.CombineContent(Constant.MainTaskType.Daily, Constant.ExtendTaskType.Daily_Activity))
		self.dayAllGetRoot:SetActive(false)
	elseif chooseMainType == Constant.MainTaskType.Weekly then
		table.insert(SubmitTypes, TaskSystemModule.CombineContent(Constant.MainTaskType.Weekly, Constant.ExtendTaskType.Weekly_Mission))
		table.insert(SubmitTypes, TaskSystemModule.CombineContent(Constant.MainTaskType.Weekly, Constant.ExtendTaskType.Weekly_Activity))
		self.dayAllGetRoot:SetActive(false)
	end

	TaskSystemModule.SubmitTaskForType(SubmitTypes)
end

function TaskSystemUI:OnClickBranchAllGet()
	self:GetAllAwardsForTypeFunction()
end

function TaskSystemUI:OnClickDayAllGet()
	self:GetAllAwardsForTypeFunction()
end

function TaskSystemUI:OnClickWeekAllGet()
	self:GetAllAwardsForTypeFunction()
end

function TaskSystemUI:OnClose(userData)
	self.mainTaskPanel:OnClose()
	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "CloseTaskSystemUI")

	if self.Timer then
		self.Timer:Stop()

		self.Timer = nil
	end
end

function TaskSystemUI:OnAddListeners()
	self.branchAllGetButton.onClick:AddListener(self.OnBranchAllGetButtonClicked)
	self.dayAllGetButton.onClick:AddListener(self.OnDayAllGetButtonClicked)
	self.weekAllGetButton.onClick:AddListener(self.OnWeekAllGetButtonClicked)
	EventDispatcher.AddEventListener(EventID.TaskSubmitSucceed, self.OnTaskSubmitSucceedDelegate)
	EventDispatcher.AddEventListener(EventID.TaskNotifyTask, self.delegateOnNotifyTask)
	EventDispatcher.AddEventListener(EventID.TaskNotifyRemove, self.delegateOnNotifyRemove)
	EventDispatcher.AddEventListener(EventID.TaskAwardShow, self.taskAwardShowEvent)
	RedDotModule.Subscribe(Constant.E_RedDotPath.Task_Main, self.RedDot_10002)
	RedDotModule.Subscribe(Constant.E_RedDotPath.Task_Daily, self.RedDot_10004)
	RedDotModule.Subscribe(Constant.E_RedDotPath.Task_Weekly, self.RedDot_10005)
	RedDotModule.Subscribe(Constant.E_RedDotPath.Task_Achieve, self.redDotAchieve)
end

function TaskSystemUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.TaskSubmitSucceed, self.OnTaskSubmitSucceedDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyTask, self.delegateOnNotifyTask)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyRemove, self.delegateOnNotifyRemove)
	EventDispatcher.RemoveEventListener(EventID.TaskAwardShow, self.taskAwardShowEvent)
	self.branchAllGetButton.onClick:RemoveListener(self.OnBranchAllGetButtonClicked)
	self.dayAllGetButton.onClick:RemoveListener(self.OnDayAllGetButtonClicked)
	self.weekAllGetButton.onClick:RemoveListener(self.OnWeekAllGetButtonClicked)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Task_Main, self.RedDot_10002)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Task_Daily, self.RedDot_10004)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Task_Weekly, self.RedDot_10005)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Task_Achieve, self.redDotAchieve)
end

function TaskSystemUI:OnPause()
	return
end

function TaskSystemUI:OnResume()
	return
end

function TaskSystemUI:OnCover()
	return
end

function TaskSystemUI:OnReveal()
	return
end

function TaskSystemUI:OnRefocus(userData)
	return
end

function TaskSystemUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function TaskSystemUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function TaskSystemUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function TaskSystemUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function TaskSystemUI:OnDestroy()
	if self.taskAwardShowTipsPanel ~= nil then
		self.taskAwardShowTipsPanel:Dispose()

		self.taskAwardShowTipsPanel = nil
	end

	if self.taskTrunkView == nil then
		self.taskTrunkView:OnDestroy()
	end

	for i, v in pairs(self.cellList.ActivitycellList) do
		v:OnDestroy()
	end

	for i, v in pairs(self.cellList.DaycellList) do
		v:OnDestroy()
	end

	for i, v in pairs(self.cellList.BranchcellList) do
		v:OnDestroy()
	end

	self.cellList = {
		ActivitycellList = {},
		DaycellList = {},
		BranchcellList = {}
	}

	self.commonReturnBtn:Dispose()

	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)
	end

	AssetUtil.UnloadAsset(self)
end

function TaskSystemUI:RefreshTime()
	if self.curChooseType ~= Constant.MainTaskType.Daily and self.curChooseType == Constant.MainTaskType.Weekly then
		-- block empty
	end

	if self.curChooseType == Constant.MainTaskType.Daily then
		LuaUtility.SetText(self.TimeText, TaskUIApi:GetDayTimeTipsText())
	elseif self.curChooseType == Constant.MainTaskType.Weekly then
		LuaUtility.SetText(self.TimeText, TaskUIApi:GetWeeklyTimeTipsText())
	end
end

return TaskSystemUI
