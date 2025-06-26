-- chunkname: @IQIGame\\UI\\RoleDevelopment\\SkillUpgradePanel.lua

local SkillUpgradePanel = class(nil, BaseChildrenPanel)
local SkillUpgradePropertyItemClass = require("IQIGame.UI.RoleDevelopment.SkillUpgradePropertyItem")
local SkillUpgradeItemViewClass = require("IQIGame.UI.RoleDevelopment.SkillUpgradeItemView")
local CommonCurrencyCostClass = require("IQIGame.UI.Common.CommonCurrencyCost")

function SkillUpgradePanel.New(go, mainView)
	local o = Clone(SkillUpgradePanel)

	o:Initialize(go, mainView)

	return o
end

function SkillUpgradePanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function SkillUpgradePanel:InitComponent()
	self.buttonUpgrade = self.buttonUpgrade:GetComponent("Button")
	self.commonCurrencyCost = CommonCurrencyCostClass.New(self.CommonCurrencyCost, self)

	LuaUtility.SetGameObjectShow(self.gameObject, true)

	self.itemScroll = self.itemScroll:GetComponent("OptimizedScrollRect")

	self.itemScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateItemScroll(OptimizedParams, OptimizedViewsHolder)
	end)
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function SkillUpgradePanel:InitDelegate()
	function self.buttonUpgradeDelegate()
		self:OnButtonUpgradeClick()
	end
end

function SkillUpgradePanel:AddListener()
	self.buttonUpgrade.onClick:AddListener(self.buttonUpgradeDelegate)
end

function SkillUpgradePanel:RemoveListener()
	self.buttonUpgrade.onClick:RemoveListener(self.buttonUpgradeDelegate)
end

function SkillUpgradePanel:OnButtonUpgradeClick()
	if self.isMoneyEnough then
		RoleDevelopmentModule.RoleSkillUpgrade(self.skillPOD.id, {})
	else
		NoticeModule.ShowCurrencyNotEnoughTips(Constant.ItemCid.GOLD)
	end
end

function SkillUpgradePanel:UpdateItemScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.skillNeedData[index + 1]

	if not self.itemViewList then
		self.itemViewList = {}
	end

	if not self.itemViewList[instanceID] then
		self.itemViewList[instanceID] = SkillUpgradeItemViewClass.New(viewGameObject)
	end

	self.itemViewList[instanceID]:Refresh(data)
end

function SkillUpgradePanel:Open(skillPOD)
	self.skillPOD = skillPOD

	self:OnOpen()
end

function SkillUpgradePanel:OnOpen()
	self:Refresh()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function SkillUpgradePanel:RefreshSkillData(skillPOD)
	self.skillPOD = skillPOD

	self:Refresh()
end

function SkillUpgradePanel:RefreshItemScroll(data)
	self.itemScroll:RefreshByItemCount(#data)
end

function SkillUpgradePanel:Refresh()
	local skillLevelCfg = CfgUtil.GetCfgSkillLevelDataWithID(self.skillPOD.skillCid)
	local currentSkillLevelCfg = skillLevelCfg[self.skillPOD.lv + self.skillPOD.extLv]
	local currentNormalSkillLevelCfg = skillLevelCfg[self.skillPOD.lv]
	local UpgradeNeedExp = currentNormalSkillLevelCfg.UpgradeNeedExp

	self:CreateSkillPropertyData(currentSkillLevelCfg)
	self:CreateSkillNeedData(currentNormalSkillLevelCfg)

	self.isMoneyEnough = self.commonCurrencyCost:Refresh(UpgradeNeedExp[#UpgradeNeedExp - 1], UpgradeNeedExp[#UpgradeNeedExp])

	self:RefreshItemScroll(self.skillNeedData)
end

function SkillUpgradePanel:CreateSkillPropertyData(currentSkillLevelCfg)
	self.skillPropertyData = {}

	local propertyLen = #currentSkillLevelCfg.UpGradeText

	for i = 1, propertyLen do
		local property = {}

		property.name = currentSkillLevelCfg.UpGradeText[i]
		property.OldValue = currentSkillLevelCfg.UpGradeOldValue[i]
		property.newValue = currentSkillLevelCfg.UpGradeNewValue[i]

		table.insert(self.skillPropertyData, property)
	end
end

function SkillUpgradePanel:CreateSkillNeedData(currentSkillLevelCfg)
	self.skillNeedData = {}

	local m_ActionParam = Clone(currentSkillLevelCfg.UpgradeNeedExp)

	for _ = 1, 2 do
		table.remove(m_ActionParam)
	end

	self.skillNeedData = LuaUtility.ActionParamToItemDataTable(m_ActionParam)
end

return SkillUpgradePanel
