-- chunkname: @IQIGame\\UI\\ExploreHall\\MagicTower\\ExploreMagicTowerController.lua

local m = {
	IsShow = false
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

	function self.DelegateOnClickLevelBtn()
		self:OnClickLevelBtn()
	end

	function self.DelegateOnClickShopBtn()
		self:OnClickShopBtn()
	end

	function self.DelegateOnClickTaskBtn()
		self:OnClickTaskBtn()
	end

	function self.DelegateOnClickTipBtn()
		self:OnClickTipBtn()
	end

	function self.DelegateOnTaskUpdate(taskCid)
		self:OnTaskUpdate(taskCid)
	end

	local cfgMagicTowerMapGlobalData = CfgMagicTowerMapGlobalTable[MagicTowerModule.GlobalCid]

	self.CurrencyCell = CurrencyCell.New(self.CurrencyCellGO, cfgMagicTowerMapGlobalData.MallMoney)

	UGUIUtil.SetText(self.LevelBtnLabel, ExploreHallUIApi:GetString("MagicTowerLevelBtn"))
	UGUIUtil.SetTextInChildren(self.TipBtn, ExploreHallUIApi:GetString("MagicTowerTipBtn"))
end

function m:Show()
	if self.IsShow and self.View.activeSelf then
		return
	end

	self.IsShow = true

	self.View:SetActive(true)
	self:AddListeners()
	self:UpdateView()

	local cfgMagicTowerMapGlobalData = CfgMagicTowerMapGlobalTable[MagicTowerModule.GlobalCid]

	self.Host.UIController:ChangeBGM(cfgMagicTowerMapGlobalData.UIBGM)
	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "ExploreHallUIMagicTowerTab")
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
	self.LevelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickLevelBtn)
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShopBtn)
	self.TaskBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTaskBtn)
	self.TipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTipBtn)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
end

function m:RemoveListeners()
	self.LevelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickLevelBtn)
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShopBtn)
	self.TaskBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTaskBtn)
	self.TipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTipBtn)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
end

function m:UpdateView()
	local cfgMagicTowerMapGlobalData = CfgMagicTowerMapGlobalTable[MagicTowerModule.GlobalCid]

	UGUIUtil.SetTextInChildren(self.ShopBtn, cfgMagicTowerMapGlobalData.MallName)
	UGUIUtil.SetTextInChildren(self.TaskBtn, cfgMagicTowerMapGlobalData.QuestName)
	self:UpdateTaskRedPoint()

	local cfgDailyDupData = CfgDailyDupTable[MagicTowerModule.DailyDupPOD.common.cid]
	local currentServerTime = PlayerModule.GetServerTime()
	local openDate = MagicTowerModule.DailyDupPOD.common.openDate
	local accessEndTime = openDate + cfgDailyDupData.AccessibleTime
	local activityEndTime = openDate + cfgDailyDupData.Duration
	local limitTimeText = ExploreHallUIApi:GetString("MagicTowerLimitTimeTexts", currentServerTime, openDate, accessEndTime, activityEndTime)

	UGUIUtil.SetText(self.LimitTimeText, limitTimeText)

	local isUnlock = openDate <= currentServerTime and currentServerTime < accessEndTime

	self.LevelBtn:SetActive(isUnlock)
	self.DisabledLevelBtn:SetActive(not isUnlock)

	if not isUnlock then
		UGUIUtil.SetText(self.DisabledLevelBtnLabel, ExploreHallUIApi:GetString("MagicTowerDisabledLevelBtn", currentServerTime, openDate, accessEndTime, activityEndTime))
	end
end

function m:OnClickLevelBtn()
	local cfgDailyDupData = CfgDailyDupTable[MagicTowerModule.DailyDupPOD.common.cid]
	local currentServerTime = PlayerModule.GetServerTime()
	local openDate = MagicTowerModule.DailyDupPOD.common.openDate
	local accessEndTime = openDate + cfgDailyDupData.AccessibleTime
	local isUnlock = openDate <= currentServerTime and currentServerTime < accessEndTime

	if not isUnlock then
		return
	end

	local cfgMagicTowerMapGlobalData = CfgMagicTowerMapGlobalTable[MagicTowerModule.GlobalCid]

	MagicTowerModule.SendEnterMap(cfgMagicTowerMapGlobalData.MagicTowerMap[1])
end

function m:OnClickShopBtn()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.MagicTower)
end

function m:OnClickTaskBtn()
	UIModule.Open(Constant.UIControllerName.MagicTowerSystemMissionUI, Constant.UILayer.UI)
end

function m:OnClickTipBtn()
	local cfgMagicTowerMapGlobalData = CfgMagicTowerMapGlobalTable[MagicTowerModule.GlobalCid]

	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, cfgMagicTowerMapGlobalData.Desc)
end

function m:UpdateTaskRedPoint()
	local hasReward = false
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.MAGIC_TOWER_TASK, nil)

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

function m:Dispose()
	self.CurrencyCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
end

return m
