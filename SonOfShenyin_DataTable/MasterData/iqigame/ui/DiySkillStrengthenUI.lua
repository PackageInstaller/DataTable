-- chunkname: @IQIGame\\UI\\DiySkillStrengthenUI.lua

local UITabList = require("IQIGame.UI.Common.UITabList")
local DiySkillStrengthenInfoView = require("IQIGame.UI.DiySkill.Strengthen.DiySkillStrengthenInfoView")
local DiySkillStrengthView = require("IQIGame.UI.DiySkill.Strengthen.DiySkillStrengthView")
local DiySkillAttributeView = require("IQIGame.UI.DiySkill.Strengthen.DiySkillAttributeView")
local DiySkillBreachView = require("IQIGame.UI.DiySkill.Strengthen.DiySkillBreachView")
local DiySkillRefineView = require("IQIGame.UI.DiySkill.Strengthen.DiySkillRefineView")
local DiySkillStrengthenBagView = require("IQIGame.UI.DiySkill.Strengthen.DiySkillStrengthenBagView")
local DiySkillStrengthenUI = {}

DiySkillStrengthenUI = Base:Extend("DiySkillStrengthenUI", "IQIGame.Onigao.UI.DiySkillStrengthenUI", DiySkillStrengthenUI)

function DiySkillStrengthenUI:OnInit()
	UIAnimationUtil.Init()
	self:__PrepareEventProxy()

	self.startsComponent = self.presentBreachStars:GetComponent("StartsHelperComponent")
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	self.commonReturnBtn:RegisterReturnEvent(function()
		if self.bagView.gameObject.activeSelf then
			self.bagView:Hide()
		else
			UIModule.CloseSelf(self)
		end
	end)

	self.diySkillImgParentAnimation = self.DiySkillImgParent:GetComponent("Animation")
	self.skillInfoView = DiySkillStrengthenInfoView.New(self.DIYInfoParent)
	self.strengthView = DiySkillStrengthView.New(self.DIYStrengthPanel, function(_itemData)
		self:__OnStrengthenMatItemCellClickEventHandler(_itemData)
	end, function()
		self:__OnStrengthenMatChangeEventHandler()
	end)
	self.attributeView = DiySkillAttributeView.New(self.SkillAttParent)
	self.breachView = DiySkillBreachView.New(self.DIYBreachPanel)
	self.refineView = DiySkillRefineView.New(self.SkillRefinePanel, function(_cid, itemIDs)
		self:__OnRefineMatItemCellClickEventHandler(_cid, itemIDs)
	end, function()
		self:__OnRefineMatChangeEventHandler()
	end)
	self.bagView = DiySkillStrengthenBagView.New(self.DIYBagParent, function(_itemData)
		self:__OnBagItemAddEventHandler(_itemData)
	end, function(_itemData)
		self:__OnBagItemReduceEventHandler(_itemData)
	end)
	self.comonSkillImgView = CommonSkillImageView.New(self.Com_SkillImgView)
	self.uiTabList = UITabList.Create()

	self.uiTabList:AddTableItem(self.detailTab, nil, function(_isOn, _view)
		if not _isOn then
			return
		end

		self:__ShowDetailState()
		self:PlayConstantEffect()
	end)
	self.uiTabList:AddTableItem(self.strengthTab, nil, function(_isOn, _view)
		if not _isOn then
			return
		end

		self:__ShowStrengthState()
		self:PlayConstantEffect()
	end)
	self.uiTabList:AddTableItem(self.refineTab, nil, function(_isOn, _view)
		if not _isOn then
			return
		end

		self:__ShowRefineState()
		self:PlayConstantEffect()
	end)
end

function DiySkillStrengthenUI:GetPreloadAssetPaths()
	return nil
end

function DiySkillStrengthenUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DiySkillStrengthenUI:IsManualShowOnOpen(userData)
	return false
end

function DiySkillStrengthenUI:GetBGM(userData)
	return nil
end

function DiySkillStrengthenUI:OnOpen(userData)
	self.constantEffectId = nil

	local tabIndex = userData.tabIndex == nil and 1 or userData.tabIndex

	self.curSkillData = userData.skillData

	self.uiTabList:ChangeSelectIndex(tabIndex)

	local itemCfg = DiySkillModule.GetItemCfgWithDiySkill(self.curSkillData)

	self.comonSkillImgView:SetData(self.curSkillData.skillCid)

	local skillTypeImgPath = RoleDevelopmentApi:GetSkillQualityAndTypeImgPath(CfgItemTable[self.curSkillData.itemCid].Quality, self.curSkillData:GetCfg().ReleaseType)

	AssetUtil.LoadImage(self, skillTypeImgPath, self.diySkillTypeImg:GetComponent("Image"))
	LuaUtility.SetText(self.textStory, itemCfg.ItemStory)

	local maxStrengthenLv = DiySkillModule.GetSkillMaxStrengthenLevel(self.curSkillData.skillCid)

	self.startsComponent:Refresh(itemCfg.Quality, itemCfg.Quality)
	self:PlayQualityAnim(CfgItemTable[self.curSkillData.itemCid].Quality)
	self:SetFunTabsShowEvent(true)
end

function DiySkillStrengthenUI:OnClose(userData)
	self:StopEffect()
end

function DiySkillStrengthenUI:__PrepareEventProxy()
	function self.__onLockSkillSuccessEventProxy()
		self:__OnLockSkillSuccessEventHandler()
	end

	function self.__onRoleSkillUpgradeSucessEventProxy()
		self:__OnRoleSkillUpgradeSucessEventHandler()
	end

	function self.__onRoleSkillBreachSucessEventProxy()
		self:__OnRoleSkillBreachSucessEventHandler()
	end

	function self.__onRoleSkillPurifySucessEventProxy()
		self:__OnRoleSkillPurifySucessEventHandler()
	end

	function self.setFunTabsShowEvent(show)
		self:SetFunTabsShowEvent(show)
	end

	function self.playRightPanelInAnimation(onStartEvent, OnCompleteEvent, isSolo)
		self:PlayRightPanelInAnimation(onStartEvent, OnCompleteEvent, isSolo)
	end

	function self.playRightPanelOutAnimation(onStartEvent, OnCompleteEvent, isSolo)
		self:PlayRightPanelOutAnimation(onStartEvent, OnCompleteEvent, isSolo)
	end
end

function DiySkillStrengthenUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.LockSkillSucess, self.__onLockSkillSuccessEventProxy)
	EventDispatcher.AddEventListener(EventID.RoleSkillUpgradeSucess, self.__onRoleSkillUpgradeSucessEventProxy)
	EventDispatcher.AddEventListener(EventID.RoleSkillBreachSucess, self.__onRoleSkillBreachSucessEventProxy)
	EventDispatcher.AddEventListener(EventID.RoleSkillPurifySucess, self.__onRoleSkillPurifySucessEventProxy)
	EventDispatcher.AddEventListener(EventID.SetDiySkillStrengthenFunTabsShowEvent, self.setFunTabsShowEvent)
	EventDispatcher.AddEventListener(EventID.PlayDiySkillStrengthInAnimationEvent, self.playRightPanelInAnimation)
	EventDispatcher.AddEventListener(EventID.PlayDiySkillStrengthOutAnimationEvent, self.playRightPanelOutAnimation)
end

function DiySkillStrengthenUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.LockSkillSucess, self.__onLockSkillSuccessEventProxy)
	EventDispatcher.RemoveEventListener(EventID.RoleSkillUpgradeSucess, self.__onRoleSkillUpgradeSucessEventProxy)
	EventDispatcher.RemoveEventListener(EventID.RoleSkillBreachSucess, self.__onRoleSkillBreachSucessEventProxy)
	EventDispatcher.RemoveEventListener(EventID.RoleSkillPurifySucess, self.__onRoleSkillPurifySucessEventProxy)
	EventDispatcher.RemoveEventListener(EventID.SetDiySkillStrengthenFunTabsShowEvent, self.setFunTabsShowEvent)
	EventDispatcher.RemoveEventListener(EventID.PlayDiySkillStrengthInAnimationEvent, self.playRightPanelInAnimation)
	EventDispatcher.RemoveEventListener(EventID.PlayDiySkillStrengthOutAnimationEvent, self.playRightPanelOutAnimation)
end

function DiySkillStrengthenUI:OnPause()
	return
end

function DiySkillStrengthenUI:OnResume()
	return
end

function DiySkillStrengthenUI:OnCover()
	return
end

function DiySkillStrengthenUI:OnReveal()
	return
end

function DiySkillStrengthenUI:OnRefocus(userData)
	return
end

function DiySkillStrengthenUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DiySkillStrengthenUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DiySkillStrengthenUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DiySkillStrengthenUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DiySkillStrengthenUI:OnDestroy()
	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)
	end

	self:StopEffect()
	self.skillInfoView:Dispose()
	self.strengthView:Dispose()
	self.breachView:Dispose()
	self.attributeView:Dispose()
	self.bagView:Dispose()
	self.refineView:Dispose()
	self.uiTabList:Dispose()
	self.comonSkillImgView:Dispose()
	AssetUtil.UnloadAsset(self)
end

function DiySkillStrengthenUI:__ShowDetailState()
	self.strengthView:Hide()
	self.attributeView:Hide()
	self.breachView:Hide()
	self.refineView:Hide()
	self.bagView:Hide()
	self.skillInfoView:SetData(self.curSkillData)
end

function DiySkillStrengthenUI:__ShowStrengthState()
	self.skillInfoView:Hide()
	self.refineView:Hide()
	self.bagView:Hide()

	local maxUpgradeLevel = DiySkillModule.GetSkillMaxUpgradeLevelBySkillData(self.curSkillData)
	local skillLevelData = DiySkillModule.GetAllCfgSkillLevelDataByCid(self.curSkillData.Quality)
	local maxLevel = 0

	for i, v in pairs(skillLevelData) do
		if maxLevel < i then
			maxLevel = i
		end
	end

	if self.curSkillData.lv == maxUpgradeLevel then
		if self.curSkillData.lv == maxLevel then
			self.breachView:Hide()
			self.strengthView:SetData(self.curSkillData, true)
			self.attributeView:Show(self.strengthView.SkillAttributes, true)
		else
			self.strengthView:Hide()
			self.breachView:SetData(self.curSkillData)
			self.attributeView:Show(self.breachView.SkillAttributes)
		end
	else
		self.breachView:Hide()
		self.strengthView:SetData(self.curSkillData)
		self.attributeView:Show(self.strengthView.SkillAttributes)
	end
end

function DiySkillStrengthenUI:__ShowRefineState()
	self.breachView:Hide()
	self.strengthView:Hide()
	self.attributeView:Hide()
	self.skillInfoView:Hide()
	self.bagView:Hide()
	self.refineView:OnResetMaterial()
	self.refineView:SetData(self.curSkillData)
	self.refineView:Show()
end

function DiySkillStrengthenUI:__OnBagItemAddEventHandler(_itemData)
	local _id = _itemData.id

	if self.strengthView.gameObject.activeSelf then
		local num = self.strengthView.MaterialItemIds[_id]

		if num == _itemData.num then
			return
		end

		self.bagView:RefreshBagShow(self.strengthView.MaterialItemIds, true)
		self.attributeView:Show(self.strengthView.SkillAttributes)
	elseif self.refineView.gameObject.activeSelf then
		self.refineView:OnMaterialSelect(_itemData, 1)
		self.bagView:RefreshBagShow(self.refineView.MaterialItemIds, true)
	end
end

function DiySkillStrengthenUI:__OnBagItemReduceEventHandler(_itemData)
	if self.strengthView.gameObject.activeSelf then
		self.bagView:RefreshBagShow(self.strengthView.MaterialItemIds, true)
		self.attributeView:Show(self.strengthView.SkillAttributes)
	elseif self.refineView.gameObject.activeSelf then
		self.refineView:OnClearSelectMaterial(_itemData.id, 1)
		self.bagView:RefreshBagShow(self.refineView.MaterialItemIds, true)
	end
end

function DiySkillStrengthenUI:__OnLockSkillSuccessEventHandler()
	if not self.skillInfoView.gameObject.activeSelf then
		return
	end

	self.curSkillData = WarehouseModule.FindItem(self.curSkillData.id).skillData

	self:__ShowDetailState()
end

function DiySkillStrengthenUI:__OnStrengthenMatItemCellClickEventHandler(itemData)
	self.attributeView:Show(self.strengthView.SkillAttributes)

	if self.bagView.gameObject.activeSelf then
		self.bagView:Hide()

		return
	end
end

function DiySkillStrengthenUI:__OnStrengthenMatChangeEventHandler()
	if self.bagView.gameObject.activeSelf then
		self.bagView:RefreshBagShow(self.strengthView.MaterialItemIds, false)
	end

	self.attributeView:Show(self.strengthView.SkillAttributes)
end

function DiySkillStrengthenUI:__OnRoleSkillUpgradeSucessEventHandler()
	self.curSkillData = WarehouseModule.FindItem(self.curSkillData.id).skillData

	self:__ShowStrengthState()
end

function DiySkillStrengthenUI:__OnRoleSkillBreachSucessEventHandler()
	self.curSkillData = WarehouseModule.FindItem(self.curSkillData.id).skillData

	self:__ShowStrengthState()
end

function DiySkillStrengthenUI:__OnRefineMatItemCellClickEventHandler(_cid, itemIDs)
	local allItems = DiySkillModule.GetAllDiySkillRefineMatWithWarehouseByItemID(self.curSkillData.id, itemIDs, true)

	if #allItems <= 0 then
		NoticeModule.ShowNotice(20038)

		return
	end

	self.bagView:Show(allItems, self.refineView.MaterialItemIds)
end

function DiySkillStrengthenUI:__OnRefineMatChangeEventHandler()
	if self.bagView.gameObject.activeSelf then
		self.bagView:RefreshBagShow(self.refineView.MaterialItemIds, true)
	end
end

function DiySkillStrengthenUI:__OnRoleSkillPurifySucessEventHandler()
	self.curSkillData = WarehouseModule.FindItem(self.curSkillData.id).skillData

	self:__ShowRefineState()
end

function DiySkillStrengthenUI:PlayQualityAnim(quality)
	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)
	end

	local effectId = EquipApi:GetShowEffect(quality)

	if effectId == nil then
		logError("技能品质不正确:" .. quality .. " 无法找到该品质的特效!")

		return
	end

	self.effectID = GameEntry.Effect:PlayUIMountPointEffect(EquipApi:GetShowEffect(quality), 50000, 0, self.topEffectRoot, 0)
end

function DiySkillStrengthenUI:PlayConstantEffect()
	if self.constantEffectId ~= nil then
		return
	end

	local quality = CfgItemTable[self.curSkillData.itemCid].Quality
	local effectCfgId = EquipApi:GetConstantDisplayEffect(quality)

	if effectCfgId ~= nil then
		self.constantEffectId = GameEntry.Effect:PlayUIMountPointEffect(effectCfgId, 50000, 0, self.bottomEffectRoot, 0)
	end
end

function DiySkillStrengthenUI:StopEffect()
	if self.constantEffectId ~= nil then
		GameEntry.Effect:StopEffect(self.constantEffectId)

		self.constantEffectId = nil
	end
end

function DiySkillStrengthenUI:SetFunTabsShowEvent(show)
	if show then
		LuaUtility.PlayAnimation(self.FunTabs, "LeftContent_In")
	else
		LuaUtility.PlayAnimation(self.FunTabs, "LeftContent_Out")
	end
end

function DiySkillStrengthenUI:PlayRightPanelInAnimation(onStartEvent, OnCompleteEvent, isSolo)
	UIAnimationUtil.Play(self.rightAnimationRoot, "RightContent_In", onStartEvent, OnCompleteEvent, isSolo)
end

function DiySkillStrengthenUI:PlayRightPanelOutAnimation(onStartEvent, OnCompleteEvent, isSolo)
	UIAnimationUtil.Play(self.rightAnimationRoot, "RightContent_Out", onStartEvent, OnCompleteEvent, isSolo)
end

return DiySkillStrengthenUI
