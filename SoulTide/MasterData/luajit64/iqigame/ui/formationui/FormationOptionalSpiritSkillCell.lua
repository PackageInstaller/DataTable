-- chunkname: @IQIGame\\UI\\FormationUI\\FormationOptionalSpiritSkillCell.lua

local m2 = {}

function m2.New(view)
	local obj = Clone(m2)

	obj:Init(view)

	return obj
end

function m2:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m2:SetData(cfgSkillData)
	UGUIUtil.SetText(self.SkillNameText, cfgSkillData ~= nil and cfgSkillData.Name or FormationChooseSoulUIApi:GetOptionalSpSkillUnlockText())
	self.SkillIcon:SetActive(cfgSkillData ~= nil)

	if cfgSkillData == nil then
		return
	end

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgSkillData.Icon), self.SkillIcon:GetComponent(typeof(UnityEngine.UI.Image)))
end

function m2:SetActive(value)
	self.View:SetActive(value)
end

function m2:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local InnerView = m2
local m = {
	Index = 0,
	isOn = false
}

function m.New(view, index, onToggleChanged)
	local obj = Clone(m)

	obj:Init(view, index, onToggleChanged)

	return obj
end

function m:Init(view, index, onToggleChanged)
	self.View = view
	self.Index = index
	self.OnToggleChangedCallback = onToggleChanged

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelf()
		self:OnClickSelf()
	end

	function self.DelegateOnClickSkillIcon()
		self:OnClickSkillIcon()
	end

	self.OffCom = InnerView.New(self.OffView)
	self.OnCom = InnerView.New(self.OnView)

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.DelegateOnClickSelf)
	self.SkillIconBtn:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.DelegateOnClickSkillIcon)
end

function m:RemoveListeners()
	self.View:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.DelegateOnClickSelf)
	self.SkillIconBtn:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.DelegateOnClickSkillIcon)
end

function m:SetData(cfgSkillData, soulData, resetIsOn)
	self.CfgSkillData = cfgSkillData
	self.SoulData = soulData

	self.LockView:SetActive(cfgSkillData == nil)
	self.OffCom:SetData(cfgSkillData)
	self.OnCom:SetData(cfgSkillData)

	if resetIsOn then
		self:__SetIsOn(false, true)
	end
end

function m:SetIsOn(value, ignoreEvent)
	if value == self.isOn then
		return
	end

	self:__SetIsOn(value, ignoreEvent)
end

function m:__SetIsOn(value, ignoreEvent)
	self.isOn = value

	self.OffCom:SetActive(not value)
	self.OnCom:SetActive(value)

	if not ignoreEvent and self.OnToggleChangedCallback ~= nil then
		self.OnToggleChangedCallback(self.Index, self.isOn)
	end
end

function m:OnClickSelf()
	if self.CfgSkillData == nil then
		return
	end

	self:SetIsOn(not self.isOn)
end

function m:OnClickSkillIcon()
	if self.CfgSkillData == nil then
		return
	end

	local skillIndex = SoulSpecialSpiritModule.GetSpSkillIndexByOptionalSkillIndex(self.Index)

	UIModule.Open(Constant.UIControllerName.SkillTipsUI, Constant.UILayer.Tooltip, {
		cfgSkillData = self.CfgSkillData,
		soulData = self.SoulData,
		allSkillStrengths = self.SoulData:GetSpSkillStrengthen(skillIndex)
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	self.OffCom:Dispose()
	self.OnCom:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.OnToggleChangedCallback = nil
	self.CfgSkillData = nil
end

return m
