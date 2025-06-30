-- chunkname: @IQIGame\\UI\\DualTeamExplore\\ActivityUI\\DualTeamExploreLevelEntryUIController.lua

require("IQIGame.UIExternalApi.DualTeamExploreLevelEntryUIApi")

local DualTeamExploreLevelEntryCell = require("IQIGame.UI.DualTeamExplore.DualTeamExploreLevelEntryCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local DualTeamExploreTicketCell = require("IQIGame.UI.DualTeamExplore.DualTeamExploreTicketCell")
local DualTeamExploreLevelEntryUIController = {
	ROLLING_DURATION = 0.3,
	RollingElapsedTime = 0,
	NotShowEasyModeNoticeOnce = false,
	LevelCells = {},
	LevelToggles = {},
	DelegateOnClickLevelToggleBtns = {},
	CurrencyControllers = {}
}

function DualTeamExploreLevelEntryUIController.New(uiController)
	local obj = Clone(DualTeamExploreLevelEntryUIController)

	obj:__Init(uiController)

	return obj
end

function DualTeamExploreLevelEntryUIController:__Init(uiController)
	self.UIController = uiController
end

function DualTeamExploreLevelEntryUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DualTeamExploreLevelEntryUIController:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnEasyModeToggleChanged(isOn)
		self:OnEasyModeToggleChanged(isOn)
	end

	function self.DelegateOnClickShopBtn()
		self:OnClickShopBtn()
	end

	function self.DelegateOnUpdatePlayerParams()
		self:OnUpdatePlayerParams()
	end

	function self.DelegateOnUpdateDailyDupEvent()
		self:OnUpdateDailyDupEvent()
	end

	self.TicketCell = DualTeamExploreTicketCell.New(self.TicketGo)
	self.WeakCellPool = UIObjectPool.New(5, function()
		return UnityEngine.Object.Instantiate(self.WeakCellPrefab)
	end, function(view)
		UnityEngine.Object.Destroy(view)
	end)
	self.LevelCellPool = UIObjectPool.New(20, function()
		return DualTeamExploreLevelEntryCell.New(UnityEngine.Object.Instantiate(self.LevelCellPrefab), self.WeakCellPool, function(cell)
			self:OnLevelCellSelect(cell)
		end, function(cell)
			self:OnEnterLevel(cell)
		end)
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.LevelTogglePool = UIObjectPool.New(20, function()
		return UnityEngine.Object.Instantiate(self.LevelTogglePrefab)
	end, function(go)
		UnityEngine.Object.Destroy(go)
	end)

	local easyModeToggleTests = DualTeamExploreLevelEntryUIApi:GetString("EasyModeToggleTests")
	local toggleHelper = self.EasyModeToggle:GetComponent("ToggleHelperComponent")

	toggleHelper:SetTexts(easyModeToggleTests)

	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	self:AddCurrencyCell(cfgDualTeamExploreControlData.ShopVoucher)
	UGUIUtil.SetText(self.TitleText, DualTeamExploreLevelEntryUIApi:GetString("TitleText", DualTeamExploreModule.DailyDupPOD.common.openCount))
	UGUIUtil.SetTextInChildren(self.ShopBtn, DualTeamExploreLevelEntryUIApi:GetString("ShopBtnText", DualTeamExploreModule.DailyDupPOD.common.openCount))
end

function DualTeamExploreLevelEntryUIController:GetPreloadAssetPaths()
	return {
		AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")
	}
end

function DualTeamExploreLevelEntryUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreLevelEntryUIController:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreLevelEntryUIController:GetBGM(userData)
	return nil
end

function DualTeamExploreLevelEntryUIController:OnOpen(userData)
	self.Block:SetActive(false)

	self.NotShowEasyModeNoticeOnce = true

	local isEasyMode

	if userData ~= nil then
		isEasyMode = userData.isEasyMode
	end

	self:UpdateView(isEasyMode)
end

function DualTeamExploreLevelEntryUIController:OnClose(userData)
	return
end

function DualTeamExploreLevelEntryUIController:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.EasyModeToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnEasyModeToggleChanged)
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShopBtn)
	EventDispatcher.AddEventListener(EventID.UpdatePlayerParams, self.DelegateOnUpdatePlayerParams)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateOnUpdateDailyDupEvent)
end

function DualTeamExploreLevelEntryUIController:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.EasyModeToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnEasyModeToggleChanged)
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShopBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdatePlayerParams, self.DelegateOnUpdatePlayerParams)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateOnUpdateDailyDupEvent)
end

function DualTeamExploreLevelEntryUIController:OnPause()
	return
end

function DualTeamExploreLevelEntryUIController:OnResume()
	return
end

function DualTeamExploreLevelEntryUIController:OnCover()
	return
end

function DualTeamExploreLevelEntryUIController:OnReveal()
	return
end

function DualTeamExploreLevelEntryUIController:OnRefocus(userData)
	return
end

function DualTeamExploreLevelEntryUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.RollingStartX ~= nil and self.RollingTargetX ~= nil then
		self.RollingElapsedTime = self.RollingElapsedTime + elapseSeconds

		local lerpValue = self.RollingElapsedTime / DualTeamExploreLevelEntryUIController.ROLLING_DURATION

		if lerpValue > 1 then
			lerpValue = 1
		end

		local curX = self.RollingStartX + (self.RollingTargetX - self.RollingStartX) * lerpValue
		local anchoredPosition = self.ScrollAreaNode.transform.anchoredPosition

		anchoredPosition.x = curX
		self.ScrollAreaNode.transform.anchoredPosition = anchoredPosition

		if lerpValue == 1 then
			self:RollingComplete()
		end
	end
end

function DualTeamExploreLevelEntryUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreLevelEntryUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreLevelEntryUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreLevelEntryUIController:OnDestroy()
	self.TicketCell:Dispose()

	self.CurrentCell = nil

	self:ClearAllCells()
	self.LevelCellPool:Dispose()
	self.LevelTogglePool:Dispose()
	self.WeakCellPool:Dispose()

	for i = 1, #self.CurrencyControllers do
		self.CurrencyControllers[i]:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function DualTeamExploreLevelEntryUIController:AddCurrencyCell(currencyCid)
	local currencyModule = UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")))

	currencyModule.transform:SetParent(self.CurrencyCom.transform, false)
	table.insert(self.CurrencyControllers, CurrencyCell.New(currencyModule, currencyCid))
end

function DualTeamExploreLevelEntryUIController:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function DualTeamExploreLevelEntryUIController:OnEasyModeToggleChanged(isOn)
	if self.NotShowEasyModeNoticeOnce then
		self.NotShowEasyModeNoticeOnce = false

		return
	end

	NoticeModule.ShowNotice(isOn and 84500000 or 84500001)

	local isEasyModeInt = isOn and 1 or 2

	PlayerPrefsUtil.SetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.DualTeamExploreEasyMode, isEasyModeInt)
	self:RefreshLevelCells()
end

function DualTeamExploreLevelEntryUIController:UpdateView(isEasyMode)
	self.TicketCell:Refresh()

	local isParamSpecified = isEasyMode ~= nil
	local isEasyModeToggleOn = self.EasyModeToggle:GetComponent("Toggle").isOn

	if not isParamSpecified then
		isEasyMode = false

		local isEasyModeStr = PlayerPrefsUtil.GetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.DualTeamExploreEasyMode)

		if isEasyModeStr == 1 then
			isEasyMode = true
		end
	end

	if isEasyModeToggleOn == isEasyMode then
		self.NotShowEasyModeNoticeOnce = false

		if isParamSpecified then
			local isEasyModeInt = isEasyMode and 1 or 2

			PlayerPrefsUtil.SetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.DualTeamExploreEasyMode, isEasyModeInt)
		end
	else
		self.EasyModeToggle:GetComponent("Toggle").isOn = isEasyMode
	end

	self:RefreshLevelCells()
end

function DualTeamExploreLevelEntryUIController:RefreshLevelCells()
	local isEasyMode = self.EasyModeToggle:GetComponent("Toggle").isOn
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	self:ClearAllCells()

	for i = 1, #cfgDualTeamExploreControlData.Level do
		local cell = self.LevelCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.ScrollAreaNode.transform, false)
		cell:SetData(cfgDualTeamExploreControlData.Level[i], i, isEasyMode)

		self.LevelCells[i] = cell

		local toggleGO = self.LevelTogglePool:Obtain()

		toggleGO:SetActive(true)
		toggleGO.transform:SetParent(self.LevelToggleNode.transform, false)

		toggleGO:GetComponent("ToggleHelperComponent").text = DualTeamExploreLevelEntryUIApi:GetString("LevelCellIndexText", i)
		self.DelegateOnClickLevelToggleBtns[i] = function()
			self:OnClickLevelToggleBtn(i)
		end

		toggleGO:GetComponentInChildren(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.DelegateOnClickLevelToggleBtns[i])

		self.LevelToggles[i] = toggleGO
	end
end

function DualTeamExploreLevelEntryUIController:ClearAllCells()
	for i = 1, #self.LevelCells do
		local cell = self.LevelCells[i]

		cell:Reset()
		cell.View.transform:SetParent(self.UIController.gameObject.transform, false)
		cell.View:SetActive(false)
		self.LevelCellPool:Release(cell)
	end

	self.LevelCells = {}

	for i = 1, #self.LevelToggles do
		local toggleGO = self.LevelToggles[i]

		toggleGO:GetComponent("Toggle").isOn = false

		toggleGO:GetComponentInChildren(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.DelegateOnClickLevelToggleBtns[i])
		toggleGO.transform:SetParent(self.UIController.gameObject.transform, false)
		toggleGO:SetActive(false)
		self.LevelTogglePool:Release(toggleGO)
	end

	self.LevelToggles = {}
	self.DelegateOnClickLevelToggleBtns = {}
	self.CurrentCell = nil
end

function DualTeamExploreLevelEntryUIController:OnLevelCellSelect(cell)
	if self.CurrentCell ~= nil then
		self.CurrentCell:Reset()
	end

	self.CurrentCell = cell
	self.LevelToggles[cell.Index]:GetComponent("Toggle").isOn = true

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ScrollAreaNode.transform)
	self:RollCellToCenter(cell.View.transform.anchoredPosition.x, -30)
end

function DualTeamExploreLevelEntryUIController:RollCellToCenter(cellX, offset)
	self.Block:SetActive(true)

	local rectTransform = self.ScrollAreaNode:GetComponentInParent(typeof(UnityEngine.UI.ScrollRect)).transform
	local rollingTargetX = rectTransform.rect.w / 2 - (cellX + offset)
	local minX = rectTransform.rect.w - self.ScrollAreaNode.transform.rect.w

	if rollingTargetX < minX then
		rollingTargetX = minX
	end

	if rollingTargetX > 0 then
		rollingTargetX = 0
	end

	self.RollingStartX = self.ScrollAreaNode.transform.anchoredPosition.x
	self.RollingTargetX = rollingTargetX
end

function DualTeamExploreLevelEntryUIController:RollingComplete()
	self.RollingElapsedTime = 0
	self.RollingStartX = nil
	self.RollingTargetX = nil

	self.Block:SetActive(false)
end

function DualTeamExploreLevelEntryUIController:OnClickLevelToggleBtn(index)
	local cell = self.LevelCells[index]

	cell:Select()
end

function DualTeamExploreLevelEntryUIController:OnEnterLevel(cell)
	local isEasyMode = self.EasyModeToggle:GetComponent("Toggle").isOn

	if cell.CfgLevelData.DialogId ~= 0 then
		DualTeamExploreModule.EnterPlotLevel(cell.CfgLevelData.Id, isEasyMode)

		return
	end

	UIModule.Open(Constant.UIControllerName.DualTeamExploreLevelFormationUI, Constant.UILayer.UI, {
		levelCid = cell.CfgLevelData.Id,
		isEasyMode = isEasyMode
	})
end

function DualTeamExploreLevelEntryUIController:OnClickShopBtn()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.DualTeamExploreShop, DualTeamExploreModule.GetMallCidList())
end

function DualTeamExploreLevelEntryUIController:OnUpdatePlayerParams()
	self:RefreshLevelCells()
end

function DualTeamExploreLevelEntryUIController:OnUpdateDailyDupEvent()
	self:RefreshLevelCells()
end

return DualTeamExploreLevelEntryUIController
