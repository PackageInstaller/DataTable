-- chunkname: @IQIGame\\UI\\Equip\\EquipReplacePanel.lua

local EquipReplacePanel = {}

function EquipReplacePanel.New(go, mainView)
	local o = Clone(EquipReplacePanel)

	o:Initialize(go, mainView)

	return o
end

function EquipReplacePanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function EquipReplacePanel:InitComponent()
	return
end

function EquipReplacePanel:InitDelegate()
	function self.delegateOnClickButtonTrue()
		self:OnClickButtonTrue()
	end

	function self.delegateOnClickButtonCancel()
		self:OnClickButtonCancel()
	end
end

function EquipReplacePanel:AddListener()
	self.buttonTrue:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonTrue)
	self.buttonCancel:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonCancel)
end

function EquipReplacePanel:RemoveListener()
	self.buttonTrue:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonTrue)
	self.buttonCancel:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonCancel)
end

function EquipReplacePanel:OnDestroy()
	return
end

function EquipReplacePanel:OnClickButtonTrue()
	if self.clickTrueCallBack then
		self:clickTrueCallBack()
	end

	self:Hide()
end

function EquipReplacePanel:OnClickButtonCancel()
	if self.clickFalseCallBack then
		self:clickFalseCallBack()
	end

	self:Hide()
end

function EquipReplacePanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function EquipReplacePanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function EquipReplacePanel:Refresh(type, selectHeroCid, equipHeroCid, clickTrueCallBack, clickFalseCallBack)
	local cfgHeroSelected = CfgUtil.GetCfgHeroDataWithID(selectHeroCid)
	local cfgHeroEquipped = CfgUtil.GetCfgHeroDataWithID(equipHeroCid)

	if type == Constant.EquipReplacePanelType.Equip then
		LuaUtility.SetText(self.textTitle, string.format(CfgUtil.GetCfgTipsTextWithID(6000201), cfgHeroEquipped.Name, cfgHeroSelected.Name))
	elseif type == Constant.EquipReplacePanelType.DiySkill then
		LuaUtility.SetText(self.textTitle, string.format(CfgUtil.GetCfgTipsTextWithID(130101), cfgHeroEquipped.Name, cfgHeroSelected.Name))
	end

	self.clickTrueCallBack = clickTrueCallBack
	self.clickFalseCallBack = clickFalseCallBack
end

return EquipReplacePanel
