-- chunkname: @IQIGame\\UI\\DualTeamExplore\\ActivityUI\\DualTeamExploreMainUIController.lua

require("IQIGame.UIExternalApi.DualTeamExploreMainUIApi")

local DualTeamExploreLevelUIDollCell = require("IQIGame.UI.DualTeamExplore.DualTeamExploreLevelUIDollCell")
local DualTeamExploreMainUIController = {
	CurrencyControllers = {},
	TeamDollCells = {}
}

function DualTeamExploreMainUIController.New(uiController)
	local obj = Clone(DualTeamExploreMainUIController)

	obj:__Init(uiController)

	return obj
end

function DualTeamExploreMainUIController:__Init(uiController)
	self.UIController = uiController
end

function DualTeamExploreMainUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DualTeamExploreMainUIController:OnInit()
	function self.DelegateOnClickExitBtn()
		self:OnClickExitBtn()
	end

	function self.DelegateOnTeamToggleValueChanged1(isOn)
		self:OnTeamToggleValueChanged(isOn, 1)
	end

	function self.DelegateOnTeamToggleValueChanged2(isOn)
		self:OnTeamToggleValueChanged(isOn, 2)
	end

	function self.DelegateOnClickTeamToggleMaskBtn1()
		self:OnClickTeamToggleMaskBtn(1)
	end

	function self.DelegateOnClickTeamToggleMaskBtn2()
		self:OnClickTeamToggleMaskBtn(2)
	end

	function self.DelegateOnSeparateOrUnite()
		self:OnSeparateOrUnite()
	end

	function self.DelegateOnCurrentTeamAutoChange()
		self:OnCurrentTeamAutoChange()
	end

	function self.DelegateOnClickBagBtn()
		self:OnClickBagBtn()
	end

	function self.DelegateOnUpdateItem()
		self:OnUpdateItem()
	end

	function self.DelegateOnClickHealBtn()
		self:OnClickHealBtn()
	end

	function self.DelegateOnClickHideTeamBtn()
		self:OnClickHideTeamBtn()
	end

	function self.DelegateOnClickShowTeamBtn()
		self:OnClickShowTeamBtn()
	end

	self.EnergyCell = EnergyCell.New(self.EnergyCom)

	self:AddCurrencyCell(Constant.ItemID.TREASURE)

	for teamIndex = 1, 2 do
		local parentNode = self["TeamDollCellGrid" .. teamIndex]

		self.TeamDollCells[teamIndex] = {}

		for cellIndex = 1, 5 do
			local cell = DualTeamExploreLevelUIDollCell.New(UnityEngine.Object.Instantiate(self.DollCellPrefab), teamIndex, cellIndex)

			cell.View.transform:SetParent(parentNode.transform, false)

			self.TeamDollCells[teamIndex][cellIndex] = cell
		end
	end

	UGUIUtil.SetTextInChildren(self.HideTeamBtn, DualTeamExploreMainUIApi:GetString("HideTeamBtnText"))
	UGUIUtil.SetTextInChildren(self.ShowTeamBtn, DualTeamExploreMainUIApi:GetString("ShowTeamBtnText"))
	UGUIUtil.SetTextInChildren(self.TeamViewLabel1, DualTeamExploreMainUIApi:GetString("TeamViewLabel", 1))
	UGUIUtil.SetTextInChildren(self.TeamViewLabel2, DualTeamExploreMainUIApi:GetString("TeamViewLabel", 2))

	local teamToggleTexts = DualTeamExploreMainUIApi:GetString("TeamToggleTexts")
	local toggleHelper = self.TeamView1:GetComponentInChildren(typeof(IQIGame.Onigao.Game.ToggleHelperComponent))

	toggleHelper:SetTexts(teamToggleTexts)

	toggleHelper = self.TeamView2:GetComponentInChildren(typeof(IQIGame.Onigao.Game.ToggleHelperComponent))

	toggleHelper:SetTexts(teamToggleTexts)

	local toggle1 = self.TeamView1:GetComponentInChildren(typeof(UnityEngine.UI.Toggle))
	local toggle2 = self.TeamView2:GetComponentInChildren(typeof(UnityEngine.UI.Toggle))

	toggle1.interactable = false
	toggle2.interactable = false
end

function DualTeamExploreMainUIController:GetPreloadAssetPaths()
	local paths = {
		AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")
	}

	return paths
end

function DualTeamExploreMainUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreMainUIController:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreMainUIController:GetBGM(userData)
	return nil
end

function DualTeamExploreMainUIController:OnOpen(userData)
	self.HideTeamBtn:SetActive(true)
	self.ShowTeamBtn:SetActive(false)
	UIUtil.StopAnimationAt(self.TeamViewContainer, 0)

	local timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.DualTeamExploreMainUI, function()
		self:OnClickHideTeamBtn()
	end, 0.5)

	timer:Start()
	self:UpdateView()
end

function DualTeamExploreMainUIController:OnClose(userData)
	ModuleTimerUtil.Stop(Constant.UIControllerName.DualTeamExploreMainUI)
end

function DualTeamExploreMainUIController:OnAddListeners()
	self.ExitBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickExitBtn)
	self.TeamView1:GetComponentInChildren(typeof(UnityEngine.UI.Toggle)).onValueChanged:AddListener(self.DelegateOnTeamToggleValueChanged1)
	self.TeamView2:GetComponentInChildren(typeof(UnityEngine.UI.Toggle)).onValueChanged:AddListener(self.DelegateOnTeamToggleValueChanged2)
	self.TeamView1:GetComponentInChildren(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.DelegateOnClickTeamToggleMaskBtn1)
	self.TeamView2:GetComponentInChildren(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.DelegateOnClickTeamToggleMaskBtn2)
	self.BagBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBagBtn)
	self.HealBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickHealBtn)
	self.HideTeamBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickHideTeamBtn)
	self.ShowTeamBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShowTeamBtn)
	EventDispatcher.AddEventListener(EventID.DualTeamExploreSeparateOrUnite, self.DelegateOnSeparateOrUnite)
	EventDispatcher.AddEventListener(EventID.DualTeamExploreCurrentTeamAutoChange, self.DelegateOnCurrentTeamAutoChange)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function DualTeamExploreMainUIController:OnRemoveListeners()
	self.ExitBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickExitBtn)
	self.TeamView1:GetComponentInChildren(typeof(UnityEngine.UI.Toggle)).onValueChanged:RemoveListener(self.DelegateOnTeamToggleValueChanged1)
	self.TeamView2:GetComponentInChildren(typeof(UnityEngine.UI.Toggle)).onValueChanged:RemoveListener(self.DelegateOnTeamToggleValueChanged2)
	self.TeamView1:GetComponentInChildren(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.DelegateOnClickTeamToggleMaskBtn1)
	self.TeamView2:GetComponentInChildren(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.DelegateOnClickTeamToggleMaskBtn2)
	self.BagBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBagBtn)
	self.HealBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickHealBtn)
	self.HideTeamBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickHideTeamBtn)
	self.ShowTeamBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShowTeamBtn)
	EventDispatcher.RemoveEventListener(EventID.DualTeamExploreSeparateOrUnite, self.DelegateOnSeparateOrUnite)
	EventDispatcher.RemoveEventListener(EventID.DualTeamExploreCurrentTeamAutoChange, self.DelegateOnCurrentTeamAutoChange)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function DualTeamExploreMainUIController:OnPause()
	return
end

function DualTeamExploreMainUIController:OnResume()
	return
end

function DualTeamExploreMainUIController:OnCover()
	return
end

function DualTeamExploreMainUIController:OnReveal()
	return
end

function DualTeamExploreMainUIController:OnRefocus(userData)
	return
end

function DualTeamExploreMainUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DualTeamExploreMainUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreMainUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreMainUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreMainUIController:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.EnergyCell:Dispose()

	for i = 1, #self.CurrencyControllers do
		self.CurrencyControllers[i]:Dispose()
	end

	for teamIndex = 1, #self.TeamDollCells do
		local cells = self.TeamDollCells[teamIndex]

		for cellIndex = 1, #cells do
			local cell = cells[cellIndex]

			cell:Dispose()
		end
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function DualTeamExploreMainUIController:AddCurrencyCell(currencyCid)
	local currencyModule = UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")))

	currencyModule.transform:SetParent(self.CurrencyContainer.transform, false)
	table.insert(self.CurrencyControllers, CurrencyCell.New(currencyModule, currencyCid))
end

function DualTeamExploreMainUIController:UpdateView()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]
	local cfgItemData = CfgItemTable[cfgDualTeamExploreControlData.UseItem]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.HealItemIcon:GetComponent("Image"))

	local cfgDualTeamExploreLevelData = CfgDualTeamExploreLevelTable[DualTeamExploreModule.LevelPOD.levelCid]

	UGUIUtil.SetText(self.TitleText, DualTeamExploreMainUIApi:GetString("TitleText", cfgDualTeamExploreLevelData.Title))
	self:RefreshTeamToggleState()
	self:RefreshHealItemBtn()
	self:RefreshDollCells()
end

function DualTeamExploreMainUIController:RefreshTeamToggleState()
	local toggle1 = self.TeamView1:GetComponentInChildren(typeof(UnityEngine.UI.Toggle))
	local toggle2 = self.TeamView2:GetComponentInChildren(typeof(UnityEngine.UI.Toggle))
	local isSeparate = DualTeamExploreModule.IsSeparate()
	local curTeamIndex = DualTeamExploreModule.GetCurrentTeamIndex()

	toggle1.isOn = not isSeparate or curTeamIndex == 1
	toggle2.isOn = not isSeparate or curTeamIndex == 2

	local button1 = self.TeamView1:GetComponentInChildren(typeof(UnityEngine.UI.Button))
	local button2 = self.TeamView2:GetComponentInChildren(typeof(UnityEngine.UI.Button))

	button1.interactable = isSeparate
	button2.interactable = isSeparate
end

function DualTeamExploreMainUIController:OnClickExitBtn()
	UIModule.Open(Constant.UIControllerName.DualTeamExploreLevelExitUI, Constant.UILayer.UI, {
		onGiveUp = DualTeamExploreModule.GiveUp,
		onAFK = DualTeamExploreModule.ExitScene
	})
end

function DualTeamExploreMainUIController:OnBtnGuideTip()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 10000)
end

function DualTeamExploreMainUIController:OnTeamToggleValueChanged(isOn, index)
	if isOn then
		DualTeamExploreModule.SetCurrentTeam(index, true)
	end
end

function DualTeamExploreMainUIController:OnClickTeamToggleMaskBtn(index)
	if DualTeamExploreModule.IsLockingInput() then
		return
	end

	local team = DualTeamExploreModule.GetTeam(index)

	if team.stop then
		return
	end

	local toggle = self["TeamView" .. index]:GetComponentInChildren(typeof(UnityEngine.UI.Toggle))

	if toggle.isOn then
		return
	end

	toggle.isOn = true

	local otherIndex = index == 1 and 2 or 1
	local otherToggle = self["TeamView" .. otherIndex]:GetComponentInChildren(typeof(UnityEngine.UI.Toggle))

	otherToggle.isOn = false
end

function DualTeamExploreMainUIController:OnSeparateOrUnite()
	self:RefreshTeamToggleState()
end

function DualTeamExploreMainUIController:OnCurrentTeamAutoChange()
	self:RefreshTeamToggleState()
end

function DualTeamExploreMainUIController:OnClickBagBtn()
	if DualTeamExploreModule.IsLockingInput() then
		NoticeModule.ShowNotice(84500020)

		return
	end

	UIModule.Open(Constant.UIControllerName.DualTeamExploreBagUI, Constant.UILayer.UI)
end

function DualTeamExploreMainUIController:RefreshHealItemBtn()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]
	local itemNum = WarehouseModule.GetItemNumByCfgID(cfgDualTeamExploreControlData.UseItem, true)

	UGUIUtil.SetText(self.HealItemNumText, itemNum)
end

function DualTeamExploreMainUIController:OnUpdateItem()
	self:RefreshHealItemBtn()
end

function DualTeamExploreMainUIController:RefreshDollCells()
	for teamIndex = 1, #self.TeamDollCells do
		local cells = self.TeamDollCells[teamIndex]
		local teamPOD = DualTeamExploreModule.GetTeam(teamIndex)

		for cellIndex = 1, #cells do
			local cell = cells[cellIndex]

			cell:SetData(teamPOD.formationInfo.soulPrefabs[cellIndex])
		end
	end
end

function DualTeamExploreMainUIController:OnClickHealBtn()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]
	local itemNum = WarehouseModule.GetItemNumByCfgID(cfgDualTeamExploreControlData.UseItem, true)

	if itemNum <= 0 then
		return
	end

	net_dualTeamExplore.useItem(cfgDualTeamExploreControlData.UseItem)
end

function DualTeamExploreMainUIController:OnClickHideTeamBtn()
	self.HideTeamBtn:SetActive(false)
	self.ShowTeamBtn:SetActive(true)
	UIUtil.PlayOrRewindDefaultAnim(self.TeamViewContainer, false)
end

function DualTeamExploreMainUIController:OnClickShowTeamBtn()
	self.HideTeamBtn:SetActive(true)
	self.ShowTeamBtn:SetActive(false)
	UIUtil.PlayOrRewindDefaultAnim(self.TeamViewContainer, true)
end

return DualTeamExploreMainUIController
