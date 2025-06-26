-- chunkname: @IQIGame\\UI\\LunaBattleLineFormationUI.lua

local LunaBattleLineFormationUI = {
	TogglePage = 1,
	FormationIndex = 0,
	SoulCells = {},
	TabToggles = {}
}

LunaBattleLineFormationUI = Base:Extend("LunaBattleLineFormationUI", "IQIGame.Onigao.UI.LunaBattleLineFormationUI", LunaBattleLineFormationUI)

require("IQIGame.UIExternalApi.LunaBattleLineFormationUIApi")

local FormationSoulCell = require("IQIGame.UI.FormationUI.FormationSoulCell")

function LunaBattleLineFormationUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickFullScreenCloseBtn()
		self:OnClickFullScreenCloseBtn()
	end

	function self.DelegateOnClickSwitchInfoViewBtn()
		self:OnClickSwitchInfoViewBtn()
	end

	function self.DelegateOnClickSwitchTogglePageBtn()
		self:OnClickSwitchTogglePageBtn()
	end

	for i = 1, 5 do
		local soulGo = UnityEngine.Object.Instantiate(self.SoulCellPrefab)

		soulGo.name = "FormationSoulCell_" .. i

		local cell = FormationSoulCell.New(soulGo, i, self)

		soulGo.transform:SetParent(self.SoulGrid.transform, false)
		cell:SetToShowMode(true)
		cell:ShowPosToggle(false)
		cell:SetCustomClickHandler(function(soulCell)
			self:OnSelectSoulPrefab(soulCell.SoulPrefabData.id)
		end)
		table.insert(self.SoulCells, cell)
	end

	for i = 1, 10 do
		local toggle = UnityEngine.Object.Instantiate(self.TabTogglePrefab)

		toggle.transform:SetParent(self.TabToggleGrid.transform, false)

		self.TabToggles[i] = toggle
		self["DelegateOnTabToggleValueChanged" .. i] = function()
			self:OnTabToggleValueChanged(i)
		end
	end

	UGUIUtil.SetText(self.TitleText, LunaBattleLineFormationUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.TipText, LunaBattleLineFormationUIApi:GetString("TipText"))
	UGUIUtil.SetTextInChildren(self.SwitchInfoViewBtn, LunaBattleLineFormationUIApi:GetString("SwitchInfoViewBtnText"))
end

function LunaBattleLineFormationUI:GetPreloadAssetPaths()
	return nil
end

function LunaBattleLineFormationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LunaBattleLineFormationUI:IsManualShowOnOpen(userData)
	return false
end

function LunaBattleLineFormationUI:GetBGM(userData)
	return nil
end

function LunaBattleLineFormationUI:OnOpen(userData)
	self.OnCompleteCallback = userData.onComplete

	self:UpdateView(userData.index)
end

function LunaBattleLineFormationUI:OnClose(userData)
	return
end

function LunaBattleLineFormationUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.FullScreenCloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFullScreenCloseBtn)
	self.SwitchInfoViewBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSwitchInfoViewBtn)
	self.SwitchPageBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSwitchTogglePageBtn)

	for i = 1, #self.TabToggles do
		self.TabToggles[i]:GetComponent("Toggle").onValueChanged:AddListener(self["DelegateOnTabToggleValueChanged" .. i])
	end
end

function LunaBattleLineFormationUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.FullScreenCloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFullScreenCloseBtn)
	self.SwitchInfoViewBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSwitchInfoViewBtn)
	self.SwitchPageBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSwitchTogglePageBtn)

	for i = 1, #self.TabToggles do
		self.TabToggles[i]:GetComponent("Toggle").onValueChanged:RemoveListener(self["DelegateOnTabToggleValueChanged" .. i])
	end
end

function LunaBattleLineFormationUI:OnPause()
	return
end

function LunaBattleLineFormationUI:OnResume()
	return
end

function LunaBattleLineFormationUI:OnCover()
	return
end

function LunaBattleLineFormationUI:OnReveal()
	return
end

function LunaBattleLineFormationUI:OnRefocus(userData)
	return
end

function LunaBattleLineFormationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LunaBattleLineFormationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LunaBattleLineFormationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LunaBattleLineFormationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LunaBattleLineFormationUI:OnDestroy()
	return
end

function LunaBattleLineFormationUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function LunaBattleLineFormationUI:OnClickFullScreenCloseBtn()
	UIModule.CloseSelf(self)
end

function LunaBattleLineFormationUI:OnTabToggleValueChanged(toggleIndex)
	local formationIndex = self:GetFormationIndexByToggle(toggleIndex)

	self:ShowFormation(formationIndex)
end

function LunaBattleLineFormationUI:ShowFormation(index)
	self.FormationIndex = index

	local formationPOD = FormationModule.GetFormationByIndex(self.FormationIndex)

	UGUIUtil.SetText(self.NameText, FormationUIApi:GetString("DefaultFormationName", self.FormationIndex, formationPOD.name))

	local soulList = {}

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		soulList[prefabIndex] = prefabId
	end

	for i = 1, #self.SoulCells do
		local cell = self.SoulCells[i]

		cell:SetData(soulList[i], self.FormationIndex)
	end
end

function LunaBattleLineFormationUI:UpdateView(formationIndex)
	if formationIndex <= 0 and formationIndex > #PlayerModule.PlayerInfo.formations then
		logError("TabIndex out of bounds. " .. formationIndex .. " range: 1-" .. #PlayerModule.PlayerInfo.formations)

		formationIndex = 1
	end

	self:RefreshTogglePageShow(formationIndex)

	for i = 1, #self.SoulCells do
		local cell = self.SoulCells[i]

		cell:ResetInfoView()
	end
end

function LunaBattleLineFormationUI:OnClickSwitchInfoViewBtn()
	for i = 1, #self.SoulCells do
		local cell = self.SoulCells[i]

		cell:NextInfoView()
	end
end

function LunaBattleLineFormationUI:OnSelectSoulPrefab(prefabId)
	UIModule.CloseSelf(self)

	if self.OnCompleteCallback ~= nil then
		self.OnCompleteCallback(prefabId)

		self.OnCompleteCallback = nil
	end
end

function LunaBattleLineFormationUI:GetToggleIndexByFormation(formationIndex)
	return (formationIndex - 1) % 10 + 1
end

function LunaBattleLineFormationUI:GetFormationIndexByToggle(toggleIndex)
	return (self.TogglePage - 1) * 10 + toggleIndex
end

function LunaBattleLineFormationUI:OnClickSwitchTogglePageBtn()
	local togglePage = math.ceil(#PlayerModule.PlayerInfo.formations / 10)

	self.TogglePage = self.TogglePage % togglePage + 1

	local toggleIndex = self:GetToggleIndexByFormation(self.FormationIndex)
	local newFormationIndex = self:GetFormationIndexByToggle(toggleIndex)

	self:RefreshTogglePageShow(newFormationIndex)
end

function LunaBattleLineFormationUI:RefreshTogglePageShow(formationIndex)
	if formationIndex ~= nil then
		self.TogglePage = math.floor((formationIndex - 1) / 10) + 1

		local toggleIndex = self:GetToggleIndexByFormation(formationIndex)
		local tabToggle = self.TabToggles[toggleIndex]:GetComponent("Toggle")
		local oldToggleIsOn = tabToggle.isOn

		tabToggle.isOn = true

		if oldToggleIsOn then
			self:ShowFormation(formationIndex)
		end
	end

	local togglePage = math.ceil(#PlayerModule.PlayerInfo.formations / 10)

	UGUIUtil.SetTextInChildren(self.SwitchPageBtn, FormationUIApi:GetString("SwitchPageBtnText", self.TogglePage, togglePage))
end

return LunaBattleLineFormationUI
