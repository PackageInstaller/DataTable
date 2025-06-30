-- chunkname: @IQIGame\\UI\\ExploreHall\\Dreamland\\ExploreDreamlandController.lua

local ExploreDreamLevelBtnController = require("IQIGame.UI.ExploreHall.Dreamland.ExploreDreamLevelBtnController")
local m = {
	CHAPTER_NUM = 3,
	IsShow = false,
	LevelBtnComList = {}
}

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickTaskBtn()
		self:OnClickTaskBtn()
	end

	function self.DelegateOnClickShopBtn()
		self:OnClickShopBtn()
	end

	function self.DelegateOnTaskUpdate(taskCid)
		self:OnTaskUpdate(taskCid)
	end

	function self.DelegateOnClickTipBtn()
		self:OnClickTipBtn()
	end

	function self.DelegateOnClickLevelBtn(index)
		self:OnClickLevelBtn(index)
	end

	for i = 1, m.CHAPTER_NUM do
		local com = ExploreDreamLevelBtnController.New(self["LevelBtnCom" .. i], i, self.DelegateOnClickLevelBtn)

		self.LevelBtnComList[i] = com
	end

	local cfgDreamMapGlobalData = CfgDreamMapGlobalTable[DreamlandModule.GlobalCid]

	self.CurrencyCell = CurrencyCell.New(self.CurrencyCellGO, cfgDreamMapGlobalData.MallMoney)
end

function m:Show()
	if self.IsShow and self.View.activeSelf then
		return
	end

	self.IsShow = true

	self.View:SetActive(true)
	self:AddListeners()
	self:UpdateView()

	local cfgDreamMapGlobalData = CfgDreamMapGlobalTable[DreamlandModule.GlobalCid]

	self.Host.UIController:ChangeBGM(cfgDreamMapGlobalData.UIBGM)
	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "ExploreHallUIDreamlandTab")
end

function m:Hide()
	if not self.IsShow and not self.View.activeSelf then
		return
	end

	self.IsShow = false

	self.View:SetActive(false)
	self:RemoveListeners()
	self.Host.UIController:ChangeBGM(7)
end

function m:AddListeners()
	for i = 1, #self.LevelBtnComList do
		local com = self.LevelBtnComList[i]

		com:AddListeners()
	end

	self.TaskBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTaskBtn)
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShopBtn)
	self.TipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTipBtn)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
end

function m:RemoveListeners()
	for i = 1, #self.LevelBtnComList do
		local com = self.LevelBtnComList[i]

		com:RemoveListeners()
	end

	self.TaskBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTaskBtn)
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShopBtn)
	self.TipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTipBtn)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
end

function m:UpdateView()
	local cfgDreamMapGlobalData = CfgDreamMapGlobalTable[DreamlandModule.GlobalCid]

	UGUIUtil.SetText(self.ShopBtnText, cfgDreamMapGlobalData.MallName)
	UGUIUtil.SetText(self.TaskBtnText, cfgDreamMapGlobalData.QuestName)
	self:UpdateTaskRedPoint()

	local cfgDailyDupData = CfgDailyDupTable[DreamlandModule.DailyDupPOD.common.cid]
	local currentServerTime = PlayerModule.GetServerTime()
	local openDate = DreamlandModule.DailyDupPOD.common.openDate
	local accessEndTime = openDate + cfgDailyDupData.AccessibleTime
	local activityEndTime = openDate + cfgDailyDupData.Duration
	local label, startTimeText, endTimeText = ExploreHallUIApi:GetString("DreamLimitTimeTexts", currentServerTime, openDate, accessEndTime, activityEndTime)

	UGUIUtil.SetText(self.LimitTimeLabel, label)
	UGUIUtil.SetText(self.StartTimeText, startTimeText)
	UGUIUtil.SetText(self.EndTimeText, endTimeText)

	for i = 1, #self.LevelBtnComList do
		local com = self.LevelBtnComList[i]

		com:Refresh()
	end
end

function m:OnClickLevelBtn(index)
	local cfgDreamMapGlobalData = CfgDreamMapGlobalTable[DreamlandModule.GlobalCid]
	local dreamMapListCid = cfgDreamMapGlobalData.DreamMapList[index]

	DreamlandModule.SendEnterMap(dreamMapListCid)
end

function m:OnClickTaskBtn()
	UIModule.Open(Constant.UIControllerName.DreamlandSystemMissionUI, Constant.UILayer.UI)
end

function m:OnClickShopBtn()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.Dreamland, DreamlandModule.GetMallCidList())
end

function m:UpdateTaskRedPoint()
	local hasReward = false
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.DREAM_LAND_TASK, {
		1
	})

	for i = 1, #processing do
		local taskData = processing[i]

		if taskData.finNum >= taskData.tgtNum then
			hasReward = true

			break
		end
	end

	self.TaskBtnRedPoint:SetActive(hasReward)
end

function m:OnTaskUpdate(taskCid)
	self:UpdateTaskRedPoint()
end

function m:OnClickTipBtn()
	local cfgDreamMapGlobalData = CfgDreamMapGlobalTable[DreamlandModule.GlobalCid]

	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, cfgDreamMapGlobalData.Desc)
end

function m:Dispose()
	for i = 1, #self.LevelBtnComList do
		local com = self.LevelBtnComList[i]

		com:Dispose()
	end

	self.CurrencyCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
end

return m
