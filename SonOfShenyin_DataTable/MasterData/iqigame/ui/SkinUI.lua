-- chunkname: @IQIGame\\UI\\SkinUI.lua

local SkinUI = {}

SkinUI = Base:Extend("SkinUI", "IQIGame.Onigao.UI.SkinUI", SkinUI)

local SkinUIStaticImageSkinPanel = require("IQIGame.UI.Skin.SkinUIStaticImageSkinPanel")
local SkinUISpineSkinPanel = require("IQIGame.UI.Skin.SkinUISpineSkinPanel")
local SkinUIEquipSkinConfirmPanel = require("IQIGame.UI.Skin.SkinUIEquipSkinConfirmPanel")
local E_SkinUI_PanelIndex = {
	StaticImageSkin = 1,
	SpineSkin = 2,
	NONE = 0
}

function SkinUI:OnInit()
	self:InitProperties()
end

function SkinUI:InitProperties()
	self.StaticImageSkinTabToggle = self.StaticImageSkinTabToggleObj:GetComponent("Toggle")
	self.SpineSkinTabToggle = self.SpineSkinTabToggleObj:GetComponent("Toggle")
	self.staticImageSkinPanel = SkinUIStaticImageSkinPanel.New(self.StaticImageSkinShowPanelObj, self.heroCid)
	self.spineSkinPanel = SkinUISpineSkinPanel.New(self.SpineSkinShowPanelObj, self.UIController)
	self.equipSkinConfirmPanel = SkinUIEquipSkinConfirmPanel.New(self.EquipSkinConfirmPanelObj)
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	function self.DelegateOnClickTab(isOn)
		self:OnPanelTabClick(isOn)
	end

	function self.DelegateShowEquipSkinConfirmPanel(equipAllBtnClickCallback, equipSingleBtnClickCallback)
		self:ShowEquipSkinConfirmPanel(equipAllBtnClickCallback, equipSingleBtnClickCallback)
	end

	function self.DelegateOnSkinItemAdd(skinCid)
		self:SkinItemUpdate(skinCid)
	end

	function self.DelegateOnSkinItemRemove(skinCid)
		self:SkinItemUpdate(skinCid)
	end
end

function SkinUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:DisposeProperties()
end

function SkinUI:DisposeProperties()
	self.staticImageSkinPanel:Dispose()

	self.staticImageSkinPanel = nil

	self.spineSkinPanel:Dispose()

	self.spineSkinPanel = nil

	self.equipSkinConfirmPanel:Dispose()

	self.equipSkinConfirmPanel = nil
	self.StaticImageSkinTabToggle = nil
	self.SpineSkinTabToggle = nil

	self.commonReturnBtn:Dispose()

	self.commonReturnBtn = nil
end

function SkinUI:OnAddListeners()
	self.StaticImageSkinTabToggle.onValueChanged:AddListener(self.DelegateOnClickTab)
	self.SpineSkinTabToggle.onValueChanged:AddListener(self.DelegateOnClickTab)
	EventDispatcher.AddEventListener(EventID.ShowEquipSkinConfirmPanel, self.DelegateShowEquipSkinConfirmPanel)
	EventDispatcher.AddEventListener(EventID.AddSkinItem, self.DelegateOnSkinItemAdd)
	EventDispatcher.AddEventListener(EventID.RemoveSkinItem, self.DelegateOnSkinItemRemove)
end

function SkinUI:OnRemoveListeners()
	self.StaticImageSkinTabToggle.onValueChanged:RemoveListener(self.DelegateOnClickTab)
	self.SpineSkinTabToggle.onValueChanged:RemoveListener(self.DelegateOnClickTab)
	EventDispatcher.RemoveEventListener(EventID.ShowEquipSkinConfirmPanel, self.DelegateShowEquipSkinConfirmPanel)
	EventDispatcher.RemoveEventListener(EventID.AddSkinItem, self.DelegateOnSkinItemAdd)
	EventDispatcher.RemoveEventListener(EventID.RemoveSkinItem, self.DelegateOnSkinItemRemove)
end

function SkinUI:OnOpen(userData)
	self.commonReturnBtn:SetHomeBtnState(SceneTransferModule.GetCanBackHome())

	self.heroCid = tonumber(userData)
	self.currentPanelTabIndex = E_SkinUI_PanelIndex.NONE
	self.StaticImageSkinTabToggle.isOn = true
	self.SpineSkinTabToggle.isOn = false

	self:ShowSkinPanel(E_SkinUI_PanelIndex.StaticImageSkin)
	self.equipSkinConfirmPanel:Hide()
	self:ResetToDefault()
end

function SkinUI:OnClose(userData)
	if self.staticImageSkinPanel ~= nil then
		self.staticImageSkinPanel:OnClose()
	end

	if self.spineSkinPanel ~= nil then
		self.spineSkinPanel:OnClose()
	end

	self:ResetToOrigin()
end

function SkinUI:ShowSkinPanel(newPanelTabIndex, isForced)
	isForced = isForced ~= nil and isForced or false

	if not isForced and self.currentPanelTabIndex == newPanelTabIndex then
		return
	end

	if newPanelTabIndex == E_SkinUI_PanelIndex.StaticImageSkin then
		self.staticImageSkinPanel:Refresh(self.heroCid)
	end

	if newPanelTabIndex == E_SkinUI_PanelIndex.SpineSkin then
		self.spineSkinPanel:Refresh(self.heroCid)
	end

	self.staticImageSkinPanel:SetVisible(newPanelTabIndex == E_SkinUI_PanelIndex.StaticImageSkin)
	self.spineSkinPanel:SetVisible(newPanelTabIndex == E_SkinUI_PanelIndex.SpineSkin)

	self.currentPanelTabIndex = newPanelTabIndex
end

function SkinUI:ShowEquipSkinConfirmPanel(equipAllBtnClickCallback, equipSingleBtnClickCallback)
	self.equipSkinConfirmPanel:Show(equipAllBtnClickCallback, equipSingleBtnClickCallback)
end

function SkinUI:SkinItemUpdate(skinCid)
	if SkinModule.IsHeroStaticImageSkinBySkinCid(skinCid) then
		if self.currentPanelTabIndex == E_SkinUI_PanelIndex.StaticImageSkin then
			self.staticImageSkinPanel:Refresh(self.heroCid)
		end
	elseif SkinModule.IsSpineSkinBySkinCid(skinCid) and self.currentPanelTabIndex == E_SkinUI_PanelIndex.SpineSkin then
		self.spineSkinPanel:Refresh(self.heroCid)
	end

	self.equipSkinConfirmPanel:Hide()
end

function SkinUI:OnPanelTabClick(isOn)
	if isOn then
		local clickToggleObj = self.UIController:GetCurrentTarget()

		if clickToggleObj ~= nil then
			if clickToggleObj:Equals(self.StaticImageSkinTabToggleObj) then
				self:ShowSkinPanel(E_SkinUI_PanelIndex.StaticImageSkin)
			elseif clickToggleObj:Equals(self.SpineSkinTabToggleObj) then
				self:ShowSkinPanel(E_SkinUI_PanelIndex.SpineSkin)
			end
		end
	end
end

local enableSpineLightingGlobal = "_BaseMapToggle"

function SkinUI:ResetToDefault()
	self.previousConfig = SceneRenderConfigManager.GetCurrentConfig()

	SceneRenderConfigManager.SetDefaultConfig()
	UnityEngine.Shader.SetGlobalFloat(enableSpineLightingGlobal, 1)
end

function SkinUI:ResetToOrigin()
	if self.previousConfig then
		SceneRenderConfigManager.ApplyConfig(self.previousConfig)
	end

	UnityEngine.Shader.SetGlobalFloat(enableSpineLightingGlobal, 0)
end

function SkinUI:LoadSpinePrefab()
	local path = UIGlobalApi.ElementSpinePath .. self.cfgData.PrefabPath

	AssetUtil.LoadAsset(self, path, self.LoadAssetCallBack)
end

function SkinUI:LoadAssetCallBack(assetName, asset, duration, userData)
	self.spineCell = asset

	self:CreatSpine()
end

function SkinUI:CreatSpine()
	if self.SpineParent.transform:GetChild(0) ~= nil then
		UnityEngine.Object.Destroy(self.SpineParent.transform:GetChild(0).gameObject)
	end

	local obj = UnityEngine.Object.Instantiate(self.spineCell)

	obj.transform:SetParent(self.SpineParent.transform, false)

	obj.transform.localScale = Vector3.one * 100
	obj.transform:GetChild(0).gameObject.layer = 5
	obj.transform:GetChild(0):GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = self.UIController:GetComponent("Canvas").sortingOrder + 1

	local anim = obj.transform:GetChild(0):GetComponent("SkeletonAnimation")

	anim.state:SetAnimation(0, "idle", true)
end

function SkinUI:JumpToCurPage(index)
	self.enhanceScrollview:JumpPage(index)
end

function SkinUI:IsPlayerOwnTargetHero(heroCid)
	return WarlockModule.WarlockDataDic[heroCid] ~= nil
end

function SkinUI:GetPreloadAssetPaths()
	return nil
end

function SkinUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SkinUI:IsManualShowOnOpen(userData)
	return false
end

function SkinUI:GetBGM(userData)
	return nil
end

function SkinUI:OnPause()
	return
end

function SkinUI:OnResume()
	return
end

function SkinUI:OnCover()
	return
end

function SkinUI:OnReveal()
	return
end

function SkinUI:OnRefocus(userData)
	return
end

function SkinUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SkinUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SkinUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SkinUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

return SkinUI
