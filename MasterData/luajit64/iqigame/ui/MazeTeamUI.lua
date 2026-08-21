-- chunkname: @IQIGame\\UI\\MazeTeamUI.lua

local MazeTeamUI = {
	PortraitCache = {}
}

MazeTeamUI = Base:Extend("MazeTeamUI", "IQIGame.Onigao.UI.MazeTeamUI", MazeTeamUI)

local MazeTeamDollTabView = require("IQIGame.UI.MazeTeam.MazeTeamDollTabView")
local MazeTeamAttrController = require("IQIGame.UI.MazeTeam.MazeTeamAttrController")
local MazeTeamSkillEquipController = require("IQIGame.UI.MazeTeam.MazeTeamSkillEquipController")

function MazeTeamUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnAttrTabBtnValueChanged(isOn)
		self:OnAttrTabBtnValueChanged(isOn)
	end

	function self.DelegateOnSkillEquipTabBtnValueChanged(isOn)
		self:OnSkillEquipTabBtnValueChanged(isOn)
	end

	function self.DelegateOnClickOptionalSpSkill()
		self:OnClickOptionalSpSkill()
	end

	self.DollTabs = {}

	for i = 1, 5 do
		local tab = MazeTeamDollTabView.New(UnityEngine.Object.Instantiate(self.DollTabPrefab), true)

		tab.View.transform:SetParent(self.TabGrid.transform, false)

		self.DollTabs[i] = tab
	end

	self.DelegateOnClickTabBtns = {}

	for i = 1, #self.DollTabs do
		self.DelegateOnClickTabBtns[i] = function(isOn)
			self:OnClickTabBtn(isOn, i)
		end
	end

	self.AttrController = MazeTeamAttrController.New(self.AttrView)
	self.SkillEquipController = MazeTeamSkillEquipController.New(self.SkillEquipView, self.UIController:GetPreloadedAsset(UIGlobalApi.GetSkillGridAssetPath()), self.UIController:GetPreloadedAsset(UIGlobalApi.GetEquipMouldPrefab()))

	UGUIUtil.SetText(self.TitleText, MazeTeamUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.LvLabelText, MazeTeamUIApi:GetString("LvLabelText"))

	self.AttrTabBtn:GetComponent("ToggleHelperComponent").text = MazeTeamUIApi:GetString("AttrTabBtnText")
	self.SkillEquipTabBtn:GetComponent("ToggleHelperComponent").text = MazeTeamUIApi:GetString("SkillEquipTabBtnText")
end

function MazeTeamUI:GetPreloadAssetPaths()
	return {
		UIGlobalApi.GetSkillGridAssetPath(),
		UIGlobalApi.GetEquipMouldPrefab()
	}
end

function MazeTeamUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeTeamUI:IsManualShowOnOpen(userData)
	return false
end

function MazeTeamUI:OnOpen(userData)
	self:UpdateView(userData == nil and 0 or userData.dollId)

	local attrToggle = self.AttrTabBtn:GetComponent("Toggle")

	if attrToggle.isOn then
		self:ShowRightPanel(1)
	else
		attrToggle.isOn = true
	end
end

function MazeTeamUI:OnClose(userData)
	for path, asset in pairs(self.PortraitCache) do
		UnityEngine.Object.DestroyImmediate(asset)

		self.PortraitCache[path] = nil
	end
end

function MazeTeamUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)

	for i = 1, #self.DollTabs do
		local tab = self.DollTabs[i]

		tab.View:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnClickTabBtns[i])
	end

	self.AttrTabBtn:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnAttrTabBtnValueChanged)
	self.SkillEquipTabBtn:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnSkillEquipTabBtnValueChanged)
	self.OptionalSpSkillView:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.DelegateOnClickOptionalSpSkill)
end

function MazeTeamUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)

	for i = 1, #self.DollTabs do
		local tab = self.DollTabs[i]

		tab.View:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnClickTabBtns[i])
	end

	self.AttrTabBtn:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnAttrTabBtnValueChanged)
	self.SkillEquipTabBtn:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnSkillEquipTabBtnValueChanged)
	self.OptionalSpSkillView:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.DelegateOnClickOptionalSpSkill)
end

function MazeTeamUI:OnPause()
	return
end

function MazeTeamUI:OnResume()
	return
end

function MazeTeamUI:OnCover()
	return
end

function MazeTeamUI:OnReveal()
	return
end

function MazeTeamUI:OnRefocus(userData)
	return
end

function MazeTeamUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeTeamUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeTeamUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeTeamUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeTeamUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.DollTabs do
		local tab = self.DollTabs[i]

		tab:Dispose()
	end

	self.AttrController:Dispose()
	self.SkillEquipController:Dispose()
end

function MazeTeamUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.MazeTeamUI)
end

function MazeTeamUI:UpdateView(dollId)
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
				self:ShowTab(i)
			else
				toggle.isOn = true
			end
		end
	end

	self.SkillEquipTabBtn:SetActive(UnlockFunctionModule.IsUnlock(Constant.UnlockType.SOUL_PAINTING))
end

function MazeTeamUI:OnAttrTabBtnValueChanged(isOn)
	if isOn then
		self:ShowRightPanel(1)
	end
end

function MazeTeamUI:OnSkillEquipTabBtnValueChanged(isOn)
	if isOn then
		self:ShowRightPanel(2)
	end
end

function MazeTeamUI:ShowRightPanel(index)
	self.AttrController.View:SetActive(index == 1)
	self.SkillEquipController.View:SetActive(index == 2)
end

function MazeTeamUI:OnClickTabBtn(isOn, index)
	if isOn then
		self:ShowTab(index)
	end
end

function MazeTeamUI:ShowTab(index)
	self.TabIndex = index

	for i = 1, #self.DollTabs do
		local tab = self.DollTabs[i]

		tab:SetSelect(false)
	end

	local currentTab = self.DollTabs[index]
	local optionalSpSkillCids = SkillModule.FilterSkillsByShowType(currentTab.DollPOD.initSkills, Constant.Skill.SHOW_TYPE_OPTIONAL_SP_SKILL, false)

	self.OptionalSpSkillCfgData = nil

	if #optionalSpSkillCids > 0 then
		self.OptionalSpSkillCfgData = CfgSkillTable[optionalSpSkillCids[1]]
	end

	currentTab:SetSelect(true)
	self:UpdateBaseInfo(currentTab.DollPOD)
	self:UpdatePortrait(currentTab.DollPOD)
	self.AttrController:SetData(currentTab.DollPOD)
	self.SkillEquipController:SetData(currentTab.DollPOD)
end

function MazeTeamUI:UpdateBaseInfo(dollPOD)
	local soulData = MazeDataModule.GetSoulData(dollPOD.soulCid)
	local cfgSoulData = soulData:GetCfgSoul()

	UGUIUtil.SetText(self.SoulNameText, cfgSoulData.Name)
	UGUIUtil.SetText(self.SoulNameText2, cfgSoulData.EnglishName)
	UGUIUtil.SetText(self.SoulTitleText, cfgSoulData.SoulDescribe)
	UGUIUtil.SetText(self.LvText, tostring(dollPOD.lv))
	self.Star:GetComponent("SimpleStarComponent"):UpdateView(5, soulData:GetCfgSoulQuality().Quality)
	UGUIUtil.SetText(self.PowerText, tostring(dollPOD.power))
	self.OptionalSpSkillView:SetActive(self.OptionalSpSkillCfgData ~= nil)

	if self.OptionalSpSkillCfgData ~= nil then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.OptionalSpSkillCfgData.Icon), self.OptionalSpSkillView:GetComponentInChildren(typeof(UnityEngine.UI.Image)))
	end
end

function MazeTeamUI:UpdatePortrait(dollPOD)
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

function MazeTeamUI:OnPrefabLoadSucceed(assetName, asset, duration, userData)
	local assetObj = UnityEngine.Object.Instantiate(asset)

	assetObj.transform:SetParent(userData, false)

	self.PortraitCache[assetName] = assetObj
end

function MazeTeamUI:OnClickOptionalSpSkill()
	if self.OptionalSpSkillCfgData == nil then
		return
	end

	local currentTab = self.DollTabs[self.TabIndex]

	UIModule.Open(Constant.UIControllerName.SkillTipsUI, Constant.UILayer.Tooltip, {
		cfgSkillData = self.OptionalSpSkillCfgData,
		soulData = currentTab.SoulData,
		allSkillStrengths = currentTab.DollPOD.allSkillStrengthens
	})
end

return MazeTeamUI
