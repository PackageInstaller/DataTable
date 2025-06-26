-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleTraining\\DevelopmentView.lua

local m = {
	TabList = {}
}
local changeHeroView = require("IQIGame.UI.RoleDevelopment.RoleTraining.ChangeHeroView")
local BaseSkillTrainingView = require("IQIGame.UI.RoleDevelopment.RoleTraining.BaseSkillTrainingView")
local EquipDetailsView = require("IQIGame.UI.Equip.MainView.EquipDetailsView")
local DiySkillInfoView = require("IQIGame.UI.RoleDevelopment.RoleTraining.DiySkillInfoView.DiySkillInfoView")
local RoleStarRiseView = require("IQIGame.UI.RoleDevelopment.RoleTraining.RoleStarRiseView")
local SkillUpgradeClass = require("IQIGame.UI.RoleDevelopment.SkillUpgradePanel")
local UITabList = require("IQIGame.UI.Common.UITabList")
local developmentBtnView = require("IQIGame.UI.RoleDevelopment.RoleTraining.DevelopmentBtnView")
local TabEnum = {
	SkillTab = 3,
	StarRiseTab = 4,
	DiySkillTab = 2,
	EquipTab = 1
}

function m.New(view, targetUI)
	local obj = Clone(m)

	obj:Init(view, targetUI)

	return obj
end

function m:Init(view, targetUI)
	self.View = view
	self.TargetUI = targetUI

	LuaCodeInterface.BindOutlet(self.View, self)
	self:InitComponent()
	self:InitDelegation()
	self:AddListeners()
end

function m:InitComponent()
	self.skillUpGradePanel = SkillUpgradeClass.New(self.SkillUpGradePanel, self)

	self.skillUpGradePanel:Close()

	self.changeHeroView = changeHeroView.New(self.ChangeHeroPanel, function()
		self:OnChangeHeroCloseCallback()
	end)

	self.changeHeroView:Hide()

	self.equipDetailsView = EquipDetailsView.New(self.EquipView)
	self.diySkillInfoView = DiySkillInfoView.New(self.DiySkillInfoPanel)
	self.baseSkillTrainingView = BaseSkillTrainingView.New(self.BaseSkillTrainingPanel)
	self.roleStarRiseView = RoleStarRiseView.New(self.RoleStarRisePanel)
	self.TabList[TabEnum.EquipTab] = developmentBtnView.New(self.EquipTab, function()
		if not self:GetEquipIsOpen() then
			NoticeModule.ShowNotice(19001)

			return
		end

		self:SetTabState(TabEnum.EquipTab)

		self.CurSelectTabIndex = TabEnum.EquipTab
		RoleDevelopmentModule.CurSelectSkillPos = 1

		EquipModule.SetCurrentHeroCid(self.SelectHeroCid)
		self.equipDetailsView:Show()
		self.TargetUI:HideMainView()
	end, self.equipDetailsView)
	self.TabList[TabEnum.DiySkillTab] = developmentBtnView.New(self.DiySkillTab, function()
		self:SetTabState(TabEnum.DiySkillTab)

		self.CurSelectTabIndex = TabEnum.DiySkillTab

		self.diySkillInfoView:Show(self.SelectHeroCid, Constant.DIYSkillEquipPos.POS_1)
		self.TargetUI:HideMainView()
	end, self.diySkillInfoView)
	self.TabList[TabEnum.SkillTab] = developmentBtnView.New(self.SkillTab, function()
		self:SetTabState(TabEnum.SkillTab)

		self.CurSelectTabIndex = TabEnum.SkillTab
		RoleDevelopmentModule.CurSelectSkillPos = 1

		self.baseSkillTrainingView:Show()
		self.baseSkillTrainingView:SetData(self.SelectHeroCid)
		self.TargetUI:OnlyShowRole()
	end, self.baseSkillTrainingView)
	self.TabList[TabEnum.StarRiseTab] = developmentBtnView.New(self.roleStarTab, function()
		if not self:GetStarRiseIsUnlock() then
			NoticeModule.ShowNotice(19001)

			return
		end

		self:SetTabState(TabEnum.StarRiseTab)

		self.CurSelectTabIndex = TabEnum.StarRiseTab

		self.roleStarRiseView:Show()
		self.roleStarRiseView:SetData(self.SelectHeroCid)
		self.TargetUI:OnlyShowRole()
	end, self.roleStarRiseView)
end

function m:InitDelegation()
	function self.ShowSkillUpgradePanelDelegate(skillPOD)
		self:ShowSkillUpgradePanel(skillPOD)
	end

	function self.DelegateSkillUpSucessEvent()
		self:OnSkillUpgradeSucess()
	end

	function self.DelegateScrollChangeHeroEvent(heroCid)
		self:ScrollChangeHeroEvent(heroCid)
	end

	function self.DelegateChangeHeroEvent(heroCid)
		self:OnChangeHeroEvent(heroCid)
	end

	function self.DelegateOnClickChangeHeroBtn()
		self:OnClickChangeHeroBtn()
	end
end

function m:AddListeners()
	self.ChangeRoleBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChangeHeroBtn)
	EventDispatcher.AddEventListener(EventID.ShowSkillUpgradePanel, self.ShowSkillUpgradePanelDelegate)
	EventDispatcher.AddEventListener(EventID.RoleSkillUpgradeSucess, self.DelegateSkillUpSucessEvent)
	EventDispatcher.AddEventListener(EventID.ScrollChangeHeroEvent, self.DelegateScrollChangeHeroEvent)
	EventDispatcher.AddEventListener(EventID.ChangeHeroEvent, self.DelegateChangeHeroEvent)
end

function m:RemoveListeners()
	self.ChangeRoleBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChangeHeroBtn)
	EventDispatcher.RemoveEventListener(EventID.ShowSkillUpgradePanel, self.ShowSkillUpgradePanelDelegate)
	EventDispatcher.RemoveEventListener(EventID.RoleSkillUpgradeSucess, self.DelegateSkillUpSucessEvent)
	EventDispatcher.RemoveEventListener(EventID.ScrollChangeHeroEvent, self.DelegateScrollChangeHeroEvent)
	EventDispatcher.RemoveEventListener(EventID.ChangeHeroEvent, self.DelegateChangeHeroEvent)
end

function m:SetTabState(tabIndex)
	for k, v in pairs(self.TabList) do
		if k == tabIndex then
			self.TabList[k]:SetSelectState(true)
		else
			self.TabList[k]:SetTargetViewHide()
			self.TabList[k]:SetSelectState(false)
		end
	end
end

function m:SetData(heroCid, heroList)
	self.SelectHeroCid = heroCid
	self.SelectHeroList = heroList

	self.TabList[TabEnum.DiySkillTab]:OnSelectBtnClick()
	self:OnRefreshUnlockBtn()
	self:OnRefreshHeroInfo(self.SelectHeroCid)
end

function m:OnRefreshHeroInfo(heroCid)
	self:RefreshStarRiseState()
	self:RefreshEquipState()

	local heroData = WarlockModule.WarlockDataDic[heroCid]

	AssetUtil.LoadImage(self, heroData:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesHead), self.ChangeHeroHeadImg:GetComponent("Image"))
end

function m:ShowSkillUpgradePanel(skillPOD)
	self.skillUpGradePanel:Open(skillPOD)
end

function m:OnSkillUpgradeSucess()
	return
end

function m:OnRefreshUnlockBtn()
	local isOpen = self:GetStarRiseIsOpen()

	LuaUtility.SetGameObjectShow(self.roleStarTab, isOpen)

	return isOpen
end

function m:ScrollChangeHeroEvent(heroCid)
	if not self.View.activeSelf then
		return
	end

	self.SelectHeroCid = heroCid

	self:OnRefreshHeroInfo(self.SelectHeroCid)

	local isHasStarRise = self:OnRefreshUnlockBtn()

	if self.CurSelectTabIndex == TabEnum.StarRiseTab then
		if isHasStarRise then
			local starRiseIsOpen = self:GetStarRiseIsUnlock()

			if starRiseIsOpen then
				self.TabList[TabEnum.StarRiseTab]:OnSelectBtnClick()

				return
			end
		end
	elseif self.CurSelectTabIndex ~= nil then
		self.TabList[self.CurSelectTabIndex]:OnSelectBtnClick()

		return
	end

	self.TabList[TabEnum.SkillTab]:OnSelectBtnClick()
end

function m:OnChangeHeroCloseCallback()
	return
end

function m:OnClickChangeHeroBtn()
	self.changeHeroView:SetData(self.SelectHeroList, self.SelectHeroCid)
	self.changeHeroView:Show()
end

function m:OnChangeHeroEvent(heroCid)
	if self.SelectHeroCid == heroCid then
		return
	end

	self.SelectHeroCid = heroCid

	self:OnRefreshHeroInfo(self.SelectHeroCid)

	local isHasStarRise = self:OnRefreshUnlockBtn()

	if self.CurSelectTabIndex == TabEnum.StarRiseTab then
		if isHasStarRise then
			local starRiseIsOpen = self:GetStarRiseIsOpen()

			if not starRiseIsOpen then
				self.TabList[TabEnum.SkillTab]:OnSelectBtnClick()

				return
			end
		else
			self.TabList[TabEnum.SkillTab]:OnSelectBtnClick()
		end
	else
		self.TabList[self.CurSelectTabIndex]:OnSelectBtnClick()
	end
end

function m:RefreshStarRiseState()
	self.TabList[TabEnum.StarRiseTab]:SetLockState(not self:GetStarRiseIsUnlock())
end

function m:RefreshEquipState()
	self.TabList[TabEnum.EquipTab]:SetLockState(not self:GetEquipIsOpen())
end

function m:GetStarRiseIsOpen()
	return CfgHeroTable[self.SelectHeroCid].StarLevelSwitch > 0
end

function m:GetStarRiseIsUnlock()
	local heroData = WarlockModule.WarlockDataDic[self.SelectHeroCid]

	return heroData.lv >= CfgDiscreteDataTable[98].Data[1]
end

function m:GetEquipIsOpen()
	return ConditionModule.Check(UnlockFunctionModule.GetFuncSwitchByType(Constant.UnlockType.FUNC_EQUIP_SYS).Condition)
end

function m:Show()
	self.TabList[TabEnum.DiySkillTab]:OnSelectBtnClick()
	self.View:SetActive(true)
	self.changeHeroView:Hide()
end

function m:Hide()
	self.View:SetActive(false)
	self:HideSubViews()
	self.TargetUI:ShowMainView()
end

function m:HideSubViews()
	self.equipDetailsView:Hide()
	self.diySkillInfoView:Hide()
	self.baseSkillTrainingView:Hide()
	self.roleStarRiseView:Hide()
	self.changeHeroView:Hide()
end

function m:Dispose()
	self.changeHeroView:Dispose()

	for k, v in pairs(self.TabList) do
		v:Dispose()
	end

	self.TabList = nil

	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
