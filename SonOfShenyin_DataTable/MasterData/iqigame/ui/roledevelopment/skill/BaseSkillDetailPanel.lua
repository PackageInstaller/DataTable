-- chunkname: @IQIGame\\UI\\RoleDevelopment\\Skill\\BaseSkillDetailPanel.lua

local BaseSkillDetailPanel = class(nil, BaseChildrenPanel)
local SkillUpgradeClass = require("IQIGame.UI.RoleDevelopment.SkillUpgradePanel")

function BaseSkillDetailPanel.New(go, mainView)
	local o = Clone(BaseSkillDetailPanel)

	o:Initialize(go, mainView)

	return o
end

function BaseSkillDetailPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.skillUpGradePanel = SkillUpgradeClass.New(self.SkillUpgradePanel, self)

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function BaseSkillDetailPanel:InitComponent()
	self.buttonUpgrade = self.buttonUpgrade:GetComponent("Button")
end

function BaseSkillDetailPanel:InitDelegate()
	function self.buttonUpgradeDelegate()
		self:OnButtonUpgradeClick()
	end

	function self.DelegateOnCloseBtnClick()
		self:OnClose()
	end
end

function BaseSkillDetailPanel:AddListener()
	self.buttonUpgrade.onClick:AddListener(self.buttonUpgradeDelegate)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnCloseBtnClick)
end

function BaseSkillDetailPanel:RemoveListener()
	self.buttonUpgrade.onClick:RemoveListener(self.buttonUpgradeDelegate)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCloseBtnClick)
end

function BaseSkillDetailPanel:OnButtonUpgradeClick()
	return
end

function BaseSkillDetailPanel:OnOpen()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function BaseSkillDetailPanel:OnClose()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function BaseSkillDetailPanel:Refresh(Data)
	self.Data = Data

	local skillCfg = CfgUtil.GetCfgSkillDataWithID(self.Data.skillCid)
	local skillDetailCfg = CfgUtil.GetCfgSkillDetailDataWithID(self.Data.skillCid)
	local skillLevelCfg = CfgUtil.GetCfgSkillLevelDataWithID(self.Data.skillCid)
	local heroData = WarlockModule.WarlockDataDic[self.Data.heroCid]
	local currentLevelSkillCfg = skillLevelCfg[self.Data.lv + self.Data.extLv]
	local cd, energy, cost = CfgUtil.GetSkillCD_Eg_Ct(WarlockModule.WarlockDataDic[self.Data.heroCid], self.Data.skillCid, self.Data.lv + self.Data.extLv)

	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(skillCfg.Icon), self.SkillIcon:GetComponent("Image"))

	local skillElement = CfgSkillDetailTable[skillCfg.Id].Element

	LuaUtility.SetGameObjectShow(self.elementImg, skillElement ~= 0)

	if skillElement ~= 0 then
		LuaUtility.LoadImage(self, RoleDevelopmentApi:GetSkillElementImgPath(skillElement), self.elementImg:GetComponent("Image"))
	end

	LuaUtility.SetText(self.textName, skillCfg.Name)
	LuaUtility.SetText(self.textLevel, string.format("%s", self.Data.lv + self.Data.extLv))
	LuaUtility.SetText(self.textSkillType, RoleDevelopmentApi:GetSkillType(skillCfg.SkillType))
	LuaUtility.SetText(self.textDescription, currentLevelSkillCfg.SkillTips)
	LuaUtility.SetText(self.textSpecialEffect, currentLevelSkillCfg.SkillSpecialEffect)
	LuaUtility.SetText(self.textSkillStory, currentLevelSkillCfg.SkillStory)
	LuaUtility.SetText(self.textCoolDown, cd)
	LuaUtility.SetText(self.energyNumText, energy)

	if skillCfg.SkillRangeID ~= 0 then
		local imageRangePath = UIGlobalApi.GetImagePath(CfgUtil.GetCfgSkillRangeWithID(skillCfg.SkillRangeID).SkillRangeImg)

		LuaUtility.LoadImage(self, imageRangePath, self.imageRange:GetComponent("Image"))
		LuaUtility.SetGameObjectShow(self.imageRange, true)
	else
		LuaUtility.SetGameObjectShow(self.imageRange, false)
	end

	local skillIsMax = self.Data.lv >= skillCfg.MaxStrengthenLevel

	LuaUtility.SetGameObjectShow(self.buttonUpgrade.gameObject, false)
	LuaUtility.SetGameObjectShow(self.objectNotUpgrade, false)
	LuaUtility.SetGameObjectShow(self.objectIsMax, false)

	if skillIsMax then
		LuaUtility.SetGameObjectShow(self.objectIsMax, true)
		self.skillUpGradePanel:Close()
	else
		local roleLevelReached = heroData.lv >= skillLevelCfg[self.Data.lv].NeedLv

		if roleLevelReached then
			self.skillUpGradePanel:Open(self.Data)
		else
			LuaUtility.SetText(self.textNotUpgrade, RoleDevelopmentApi:GetSkillUpgradeLevelLimitText(skillLevelCfg[self.Data.lv].NeedLv))
			LuaUtility.SetGameObjectShow(self.objectNotUpgrade, true)
			self.skillUpGradePanel:Close()
		end
	end
end

return BaseSkillDetailPanel
