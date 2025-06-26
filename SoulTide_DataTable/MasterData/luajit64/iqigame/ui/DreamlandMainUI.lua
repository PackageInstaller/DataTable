-- chunkname: @IQIGame\\UI\\DreamlandMainUI.lua

local DreamlandMainUI = {
	CurrencyControllers = {}
}

DreamlandMainUI = Base:Extend("DreamlandMainUI", "IQIGame.Onigao.UI.DreamlandMainUI", DreamlandMainUI)

require("IQIGame.UIExternalApi.DreamlandMainUIApi")

local DreamlandUIComboController = require("IQIGame.UI.Dreamland.DreamlandUIComboController")

function DreamlandMainUI:OnInit()
	function self.DelegateOnClickExitBtn()
		self:OnClickExitBtn()
	end

	function self.DelegateOnClickResetBtn()
		self:OnClickResetBtn()
	end

	function self.DelegateOnClickTaskBtn()
		self:OnClickTaskBtn()
	end

	function self.DelegateOnUpdateMovePoint()
		self:OnUpdateMovePoint()
	end

	function self.DelegateOnUnlockTask(taskCid)
		self:OnUnlockTask(taskCid)
	end

	function self.DelegateOnOpenCellConfirmed()
		self:OnDreamlandOpenCellConfirmed()
	end

	function self.DelegateOnPerfectExplore()
		self:OnPerfectExplore()
	end

	function self.DelegateOnClickSpeRewardBtn()
		self:OnClickSpeRewardBtn()
	end

	function self.DelegateOnClickOpenCellBtn()
		self:OnClickOpenCellBtn()
	end

	function self.DelegateOnClickMarkBtn()
		self:OnClickMarkBtn()
	end

	function self.DelegateOnClickRemoveMarkBtn()
		self:OnClickRemoveMarkBtn()
	end

	function self.DelegateOnHeroArriveNode(x, y)
		self:OnHeroArriveNode(x, y)
	end

	function self.DelegateOnRefreshCellData(x, y)
		self:OnRefreshCellData(x, y)
	end

	function self.DelegateOnLockInput(lockSrc, isLock)
		self:OnLockInput(lockSrc, isLock)
	end

	function self.DelegateOnTaskUpdate(taskCid)
		self:OnTaskUpdate(taskCid)
	end

	function self.DelegateOnClickGuideTipBtn()
		self:OnBtnGuideTip()
	end

	function self.DelegateOnClickMovePointBtn()
		self:OnClickMovePointBtn()
	end

	function self.DelegateOnClickSpeedBtn()
		self:OnClickSpeedBtn()
	end

	self.ComboController = DreamlandUIComboController.New(self.ComboView)
	self.EnergyCell = EnergyCell.New(self.EnergyCom)

	local cfgDreamMapGlobalData = CfgDreamMapGlobalTable[DreamlandModule.GlobalCid]

	self:AddCurrencyCell(cfgDreamMapGlobalData.MallMoney)
	self:AddCurrencyCell(Constant.ItemID.TREASURE)
	UGUIUtil.SetTextInChildren(self.OpenCellBtn, DreamlandMainUIApi:GetString("OpenCellBtnText"))
	UGUIUtil.SetTextInChildren(self.MarkBtn, DreamlandMainUIApi:GetString("MarkBtnText"))
	UGUIUtil.SetTextInChildren(self.RemoveMarkBtn, DreamlandMainUIApi:GetString("RemoveMarkBtnText"))
	UGUIUtil.SetTextInChildren(self.SpeRewardBtn, DreamlandMainUIApi:GetString("SpeRewardBtnText"))
	UGUIUtil.SetTextInChildren(self.ResetBtn, DreamlandMainUIApi:GetString("ResetBtnText"))
	UGUIUtil.SetTextInChildren(self.TaskBtn, DreamlandMainUIApi:GetString("TaskBtnText"))
	UGUIUtil.SetText(self.SpeedBtnLabel, DreamlandMainUIApi:GetString("SpeedBtnLabel"))
	UGUIUtil.SetText(self.LeftGoodNodeLabel, DreamlandMainUIApi:GetString("LeftGoodNodeLabel"))
end

function DreamlandMainUI:GetPreloadAssetPaths()
	local paths = {
		AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")
	}

	return paths
end

function DreamlandMainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DreamlandMainUI:IsManualShowOnOpen(userData)
	return false
end

function DreamlandMainUI:GetBGM(userData)
	return nil
end

function DreamlandMainUI:OnOpen(userData)
	if DreamlandModule.MapData == nil then
		return
	end

	self:UpdateView()
end

function DreamlandMainUI:OnClose(userData)
	return
end

function DreamlandMainUI:OnAddListeners()
	self.ExitBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickExitBtn)
	self.ResetBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickResetBtn)
	self.TaskBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTaskBtn)
	self.SpeRewardBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSpeRewardBtn)
	self.OpenCellBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickOpenCellBtn)
	self.MarkBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMarkBtn)
	self.RemoveMarkBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRemoveMarkBtn)
	self.BtnGuideTip:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGuideTipBtn)
	self.MovePointBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMovePointBtn)
	self.SpeedBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSpeedBtn)
	EventDispatcher.AddEventListener(EventID.DreamlandUpdateMovePoint, self.DelegateOnUpdateMovePoint)
	EventDispatcher.AddEventListener(EventID.DreamlandLevelUnlockTask, self.DelegateOnUnlockTask)
	EventDispatcher.AddEventListener(EventID.DreamlandOpenCellConfirmed, self.DelegateOnOpenCellConfirmed)
	EventDispatcher.AddEventListener(EventID.DreamlandPerfectExplore, self.DelegateOnPerfectExplore)
	EventDispatcher.AddEventListener(EventID.DreamlandHeroArriveNode, self.DelegateOnHeroArriveNode)
	EventDispatcher.AddEventListener(EventID.DreamlandRefreshCellData, self.DelegateOnRefreshCellData)
	EventDispatcher.AddEventListener(EventID.LockInput, self.DelegateOnLockInput)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
end

function DreamlandMainUI:OnRemoveListeners()
	self.ExitBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickExitBtn)
	self.ResetBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickResetBtn)
	self.TaskBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTaskBtn)
	self.SpeRewardBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSpeRewardBtn)
	self.OpenCellBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickOpenCellBtn)
	self.MarkBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMarkBtn)
	self.RemoveMarkBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRemoveMarkBtn)
	self.BtnGuideTip:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGuideTipBtn)
	self.MovePointBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMovePointBtn)
	self.SpeedBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSpeedBtn)
	EventDispatcher.RemoveEventListener(EventID.DreamlandUpdateMovePoint, self.DelegateOnUpdateMovePoint)
	EventDispatcher.RemoveEventListener(EventID.DreamlandLevelUnlockTask, self.DelegateOnUnlockTask)
	EventDispatcher.RemoveEventListener(EventID.DreamlandOpenCellConfirmed, self.DelegateOnOpenCellConfirmed)
	EventDispatcher.RemoveEventListener(EventID.DreamlandPerfectExplore, self.DelegateOnPerfectExplore)
	EventDispatcher.RemoveEventListener(EventID.DreamlandHeroArriveNode, self.DelegateOnHeroArriveNode)
	EventDispatcher.RemoveEventListener(EventID.DreamlandRefreshCellData, self.DelegateOnRefreshCellData)
	EventDispatcher.RemoveEventListener(EventID.LockInput, self.DelegateOnLockInput)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnTaskUpdate)
end

function DreamlandMainUI:OnPause()
	return
end

function DreamlandMainUI:OnResume()
	return
end

function DreamlandMainUI:OnCover()
	return
end

function DreamlandMainUI:OnReveal()
	return
end

function DreamlandMainUI:OnRefocus(userData)
	return
end

function DreamlandMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.ComboController ~= nil then
		self.ComboController:OnUpdate(elapseSeconds, realElapseSeconds)
	end
end

function DreamlandMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DreamlandMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DreamlandMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DreamlandMainUI:OnDestroy()
	self.ComboController:Dispose()
	self.EnergyCell:Dispose()

	for i = 1, #self.CurrencyControllers do
		self.CurrencyControllers[i]:Dispose()
	end
end

function DreamlandMainUI:AddCurrencyCell(currencyCid)
	local currencyModule = UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")))

	currencyModule.transform:SetParent(self.CurrencyContainer.transform, false)
	table.insert(self.CurrencyControllers, CurrencyCell.New(currencyModule, currencyCid))
end

function DreamlandMainUI:UpdateView()
	local cfgDreamMapListData = CfgDreamMapListTable[DreamlandModule.MapData.mapId]

	UGUIUtil.SetText(self.TitleText, cfgDreamMapListData.Name)
	self:RefreshMovePoint()
	self:RefreshPerfectExploreShow()
	self:RefreshOperationOfCell(DreamlandModule.GetHeroNodeData())
	self:UpdateTaskRedPoint()
	self:RefreshLeftGoodNode()
end

function DreamlandMainUI:OnClickExitBtn()
	DreamlandModule.ExitDreamland()
end

function DreamlandMainUI:OnClickResetBtn()
	if DreamlandModule.DreamlandScene.InputMgr:IsLock() then
		return
	end

	local cfgDailyDupData = CfgDailyDupTable[DreamlandModule.DailyDupPOD.common.cid]
	local currentServerTime = PlayerModule.GetServerTime()
	local accessEndTime = DreamlandModule.DailyDupPOD.common.openDate + cfgDailyDupData.AccessibleTime

	if accessEndTime <= currentServerTime then
		NoticeModule.ShowNotice(21063004)

		return
	end

	local cfgDreamMapListData = CfgDreamMapListTable[DreamlandModule.MapData.mapId]

	NoticeModule.ShowNotice(21063003, function()
		if WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY) < cfgDreamMapListData.ResetEnergy then
			NoticeModule.ShowNotice(21045026)

			return
		end

		DreamlandModule.SendResetMap()
	end, nil, self, tostring(cfgDreamMapListData.ResetEnergy))
end

function DreamlandMainUI:OnClickTaskBtn()
	UIModule.Open(Constant.UIControllerName.DreamlandLevelMissionUI, Constant.UILayer.UI)
end

function DreamlandMainUI:RefreshMovePoint()
	UGUIUtil.SetText(self.MovePointText, DreamlandModule.MapData.movePoint)
end

function DreamlandMainUI:OnUpdateMovePoint()
	self:RefreshMovePoint()
end

function DreamlandMainUI:OnUnlockTask(taskCid)
	GameEntry.Effect:PlayUIEffect(2010003, self.TaskBtn.transform.position, self.UIController:GetComponent(typeof(UnityEngine.Canvas)).sortingOrder + 1, 1)
end

function DreamlandMainUI:OnDreamlandOpenCellConfirmed()
	self.ComboController:ShowCombo(DreamlandModule.MapData.combo)
end

function DreamlandMainUI:RefreshPerfectExploreShow()
	local isPrefectExplore = DreamlandModule.IsPerfectExplore()

	self.ResetBtn:SetActive(isPrefectExplore or DreamlandModule.MapData.resetCount > 0)

	local speed = DreamlandModule.GetLevelSpeedRatio()

	UGUIUtil.SetText(self.SpeedText, DreamlandMainUIApi:GetString("SpeedText", speed))
end

function DreamlandMainUI:OnPerfectExplore()
	self:RefreshPerfectExploreShow()
end

function DreamlandMainUI:OnClickSpeRewardBtn()
	UIModule.Open(Constant.UIControllerName.DreamlandRewardListUI, Constant.UILayer.UI)
end

function DreamlandMainUI:RefreshOperationOfCell(cellData)
	self.OpenCellBtn:SetActive(not cellData.isOpen)
	self.MarkBtn:SetActive(cellData.markType == 0)
	self.RemoveMarkBtn:SetActive(cellData.markType == 1)
end

function DreamlandMainUI:OnClickOpenCellBtn()
	self.OpenCellBtn:SetActive(false)
	DreamlandModule.OpenHeroCell()
end

function DreamlandMainUI:OnClickMarkBtn()
	if DreamlandModule.DreamlandScene.InputMgr:IsLock() then
		return
	end

	DreamlandModule.MarkCell(DreamlandModule.MapData.roleX, DreamlandModule.MapData.roleY, 1)
end

function DreamlandMainUI:OnClickRemoveMarkBtn()
	if DreamlandModule.DreamlandScene.InputMgr:IsLock() then
		return
	end

	DreamlandModule.MarkCell(DreamlandModule.MapData.roleX, DreamlandModule.MapData.roleY, 0)
end

function DreamlandMainUI:OnHeroArriveNode(x, y)
	local cellPOD = DreamlandModule.GetCellPODByXY(x, y)

	self:RefreshOperationOfCell(cellPOD)
end

function DreamlandMainUI:OnRefreshCellData(x, y)
	if x == DreamlandModule.MapData.roleX and y == DreamlandModule.MapData.roleY then
		local cellPOD = DreamlandModule.GetCellPODByXY(x, y)

		self:RefreshOperationOfCell(cellPOD)
		self:RefreshLeftGoodNode()
	end
end

function DreamlandMainUI:OnLockInput(lockSrc, isLock)
	if lockSrc == Constant.LockInputReason.DreamlandMove or lockSrc == Constant.LockInputReason.DreamlandExecution then
		self.CellOperationView:SetActive(not isLock)
	end
end

function DreamlandMainUI:UpdateTaskRedPoint()
	local hasReward = false
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.DREAM_LAND_TASK, {
		2
	})

	processing = table.addAll(processing, TaskModule.GetTaskProcessing(TaskModule.TaskType.DREAM_LAND_TASK, {
		3
	}))

	for i = 1, #processing do
		local taskData = processing[i]

		if taskData.finNum >= taskData.tgtNum then
			hasReward = true

			break
		end
	end

	self.TaskBtnRedPoint:SetActive(hasReward)
end

function DreamlandMainUI:OnTaskUpdate(taskCid)
	self:UpdateTaskRedPoint()
end

function DreamlandMainUI:OnBtnGuideTip()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 10000)
end

function DreamlandMainUI:OnClickMovePointBtn()
	UIModule.Open(Constant.UIControllerName.MoneyPanelInfoUI, Constant.UILayer.UI, {
		204,
		self.MovePointBtn.transform
	})
end

function DreamlandMainUI:OnClickSpeedBtn()
	local speed = DreamlandModule.GetLevelSpeedRatio()
	local speeds = DreamlandSceneApi:GetString("LevelSpeedRatios")
	local index = table.indexOf(speeds, speed)

	if index == -1 then
		logError("切换速度错误，当前速度：" .. tostring(speed))

		return
	end

	index = index + 1

	if index > #speeds then
		index = 1
	end

	local newSpeed = speeds[index]

	DreamlandModule.SetLevelSpeedRatio(newSpeed)
	UGUIUtil.SetText(self.SpeedText, DreamlandMainUIApi:GetString("SpeedText", newSpeed))
end

function DreamlandMainUI:RefreshLeftGoodNode()
	local leftNum = 0

	for i = 1, #DreamlandModule.MapData.cells do
		local cellData = DreamlandModule.MapData.cells[i]

		if cellData.dataId ~= 0 then
			local cfgDreamMapCellDataData = CfgDreamMapCellDataTable[cellData.dataId]

			if cfgDreamMapCellDataData.Type == 1 and not cellData.isOpen then
				leftNum = leftNum + 1
			end
		end
	end

	UGUIUtil.SetText(self.LeftGoodNodeValueText, DreamlandMainUIApi:GetString("LeftGoodNodeValueText", leftNum))
end

return DreamlandMainUI
