-- chunkname: @IQIGame\\UI\\RPGActivityUI\\RpgMazeTeamUIController.lua

local MazeTeamDollTabView = require("IQIGame.UI.MazeTeam.MazeTeamDollTabView")
local MazeTeamBaseInfoController = require("IQIGame.UI.MazeTeam.MazeTeamBaseInfoController")
local MazeTeamSkillPosController = require("IQIGame.UI.MazeTeam.MazeTeamSkillPosController")
local MazeTeamEquipController = require("IQIGame.UI.MazeTeam.MazeTeamEquipController")
local RpgMazeTeamUIController = {
	PortraitCache = {},
	SubPanelToggles = {},
	SubPanels = {}
}

function RpgMazeTeamUIController.New(uiController)
	local obj = Clone(RpgMazeTeamUIController)

	obj:__Init(uiController)

	return obj
end

function RpgMazeTeamUIController:__Init(uiController)
	self.UIController = uiController
end

function RpgMazeTeamUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function RpgMazeTeamUIController:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.DollTabs = {}

	for i = 1, 5 do
		local tab = MazeTeamDollTabView.New(UnityEngine.Object.Instantiate(self.DollTabPrefab), false)

		tab.View.transform:SetParent(self.TabGrid.transform, false)

		self.DollTabs[i] = tab
	end

	self.DelegateOnClickTabBtns = {}

	for i = 1, #self.DollTabs do
		self.DelegateOnClickTabBtns[i] = function(isOn)
			self:OnClickTabBtn(isOn, i)
		end
	end

	local subToggleNames = RpgMazeTeamUIApi:GetString("SubPanelToggleNameTexts")

	for i = 1, 3 do
		local toggleGo = self["SubPanelToggle" .. i]

		self.SubPanelToggles[i] = toggleGo:GetComponent("Toggle")
		toggleGo:GetComponent("ToggleHelperComponent").text = subToggleNames[i]
		self["DelegateOnClickSubPanelToggle" .. i] = function(isOn)
			if isOn then
				self:OnClickSubPanelToggle(i)
			end
		end
	end

	self:AddSubPanel(MazeTeamBaseInfoController, self.SubPanel1)
	self:AddSubPanel(MazeTeamSkillPosController, self.SubPanel2)
	self:AddSubPanel(MazeTeamEquipController, self.SubPanel3)
	UGUIUtil.SetText(self.TitleText, RpgMazeTeamUIApi:GetString("TitleText"))
end

function RpgMazeTeamUIController:GetPreloadAssetPaths()
	return nil
end

function RpgMazeTeamUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RpgMazeTeamUIController:IsManualShowOnOpen(userData)
	return false
end

function RpgMazeTeamUIController:GetBGM(userData)
	return nil
end

function RpgMazeTeamUIController:OnOpen(userData)
	for i = 1, #self.SubPanels do
		local subPanel = self.SubPanels[i]

		subPanel:OnRootUIOpen()
	end

	self:UpdateView(userData == nil and 0 or userData.dollId)
end

function RpgMazeTeamUIController:OnClose(userData)
	for i = 1, #self.SubPanels do
		local subPanel = self.SubPanels[i]

		subPanel:OnRootUIClose()
	end

	for path, asset in pairs(self.PortraitCache) do
		UnityEngine.Object.DestroyImmediate(asset)

		self.PortraitCache[path] = nil
	end
end

function RpgMazeTeamUIController:OnAddListeners()
	for i = 1, #self.DollTabs do
		local tab = self.DollTabs[i]

		tab.View:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnClickTabBtns[i])
	end

	for i = 1, #self.SubPanelToggles do
		local toggle = self.SubPanelToggles[i]

		toggle.onValueChanged:AddListener(self["DelegateOnClickSubPanelToggle" .. i])
	end

	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function RpgMazeTeamUIController:OnRemoveListeners()
	for i = 1, #self.DollTabs do
		local tab = self.DollTabs[i]

		tab.View:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnClickTabBtns[i])
	end

	for i = 1, #self.SubPanelToggles do
		local toggle = self.SubPanelToggles[i]

		toggle.onValueChanged:RemoveListener(self["DelegateOnClickSubPanelToggle" .. i])
	end

	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function RpgMazeTeamUIController:OnPause()
	return
end

function RpgMazeTeamUIController:OnResume()
	return
end

function RpgMazeTeamUIController:OnCover()
	return
end

function RpgMazeTeamUIController:OnReveal()
	return
end

function RpgMazeTeamUIController:OnRefocus(userData)
	return
end

function RpgMazeTeamUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RpgMazeTeamUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RpgMazeTeamUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RpgMazeTeamUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RpgMazeTeamUIController:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.DollTabs do
		local tab = self.DollTabs[i]

		tab:Dispose()
	end

	for i = 1, #self.SubPanels do
		local subPanel = self.SubPanels[i]

		if subPanel.IsShow then
			subPanel:Hide(true)
		end

		subPanel:Dispose()
	end

	for i = 1, #self.SubPanelToggles do
		self.SubPanelToggles[i] = nil
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function RpgMazeTeamUIController:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function RpgMazeTeamUIController:UpdateView(dollId)
	local dollPODs = MazeDataModule.GetActiveDollDataList()

	for i = 1, #self.DollTabs do
		local tab = self.DollTabs[i]
		local dollPOD = dollPODs[i]
		local soulData

		if dollPOD ~= nil then
			soulData = MazeDataModule.GetSoulData(dollPOD.soulCid)
		end

		tab:SetData(dollPOD, soulData)

		if dollPOD ~= nil and (dollId == 0 or dollPOD.id == dollId) then
			local toggle = tab.View:GetComponent("Toggle")

			if toggle.isOn then
				self:ShowTabLv1_OnClickDoll(i)
			else
				toggle.isOn = true
			end
		end
	end
end

function RpgMazeTeamUIController:ShowTabLv1_OnClickDoll(index)
	self.TabIndex = index

	for i = 1, #self.DollTabs do
		local tab = self.DollTabs[i]

		tab:SetSelect(false)
	end

	local currentTab = self.DollTabs[index]

	currentTab:SetSelect(true)
	self:UpdateBaseInfo(currentTab.DollPOD)
	self:UpdatePortrait(currentTab.DollPOD)

	local selectedIndex = 0

	for i = 1, #self.SubPanelToggles do
		local toggle = self.SubPanelToggles[i]

		if toggle.isOn then
			selectedIndex = i

			break
		end
	end

	if selectedIndex > 0 then
		self:ShowTabLv2_AttrSkillEquip(selectedIndex)
	else
		self.SubPanelToggles[1].isOn = true
	end
end

function RpgMazeTeamUIController:UpdateBaseInfo(dollPOD)
	local soulData = MazeDataModule.GetSoulData(dollPOD.soulCid)
	local cfgSoulData = soulData:GetCfgSoul()

	UGUIUtil.SetText(self.SoulNameText, cfgSoulData.Name)
	UGUIUtil.SetText(self.SoulNameText2, cfgSoulData.EnglishName)
	UGUIUtil.SetText(self.SoulTitleText, cfgSoulData.SoulDescribe)
	UGUIUtil.SetText(self.LvText, RpgMazeTeamUIApi:GetString("LvText", dollPOD.lv))
	UGUIUtil.SetText(self.PowerText, tostring(dollPOD.power))
end

function RpgMazeTeamUIController:UpdatePortrait(dollPOD)
	local portraitObj

	if self.PortraitNode.transform.childCount > 0 then
		portraitObj = self.PortraitNode.transform:GetChild(0).gameObject

		portraitObj.transform:SetParent(self.UIController.transform, false)
		portraitObj:SetActive(false)
	end

	local soulData = MazeDataModule.GetSoulData(dollPOD.soulCid)
	local portraitPath = UIGlobalApi.GetSoulPortraitPath(soulData.soulCid, soulData:GetCfgDress2D().SoulResID)

	portraitObj = self.PortraitCache[portraitPath]

	if portraitObj ~= nil then
		portraitObj:SetActive(true)
		portraitObj.transform:SetParent(self.PortraitNode.transform, false)
	else
		AssetUtil.LoadAsset(self, portraitPath, self.OnPrefabLoadSucceed, nil, self.PortraitNode.transform)
	end
end

function RpgMazeTeamUIController:OnPrefabLoadSucceed(assetName, asset, duration, userData)
	local assetObj = UnityEngine.Object.Instantiate(asset)

	assetObj.transform:SetParent(userData, false)

	self.PortraitCache[assetName] = assetObj
end

function RpgMazeTeamUIController:OnClickTabBtn(isOn, index)
	if isOn then
		self:ShowTabLv1_OnClickDoll(index)
	end
end

function RpgMazeTeamUIController:AddSubPanel(class, view)
	local controller = class.New(view)

	table.insert(self.SubPanels, controller)
	view:SetActive(false)
end

function RpgMazeTeamUIController:OnClickSubPanelToggle(index)
	self:ShowTabLv2_AttrSkillEquip(index)
end

function RpgMazeTeamUIController:ShowTabLv2_AttrSkillEquip(index)
	for i = 1, #self.SubPanels do
		local subPanel = self.SubPanels[i]

		subPanel:Hide()
	end

	local subPanel = self.SubPanels[index]
	local dollDataList = MazeDataModule.GetActiveDollDataList()

	subPanel:Show(dollDataList[self.TabIndex])
end

return RpgMazeTeamUIController
