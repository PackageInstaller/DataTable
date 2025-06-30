-- chunkname: @IQIGame\\UI\\SpecialSpirit\\SpecialSpiritUISkillCell.lua

local m = {}

function m.New(view, index, onClick)
	local obj = Clone(m)

	obj:Init(view, index, onClick)

	return obj
end

function m:Init(view, index, onClick)
	self.View = view
	self.Index = index
	self.OnClickCallback = onClick

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelf()
		self:OnClickSelf()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.DelegateOnClickSelf)
end

function m:RemoveListeners()
	self.View:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.DelegateOnClickSelf)
end

function m:SetData(soulData)
	self.SoulData = soulData

	local cfgSkillData = self.SoulData:GetSpSkillByIndex(self.Index)

	self.NormalView:SetActive(cfgSkillData ~= nil)
	self.LockView:SetActive(cfgSkillData == nil)

	if cfgSkillData ~= nil then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgSkillData.Icon), self.Icon:GetComponent(typeof(UnityEngine.UI.Image)))
	end

	self:RefreshRedPoint()
end

function m:RefreshRedPoint()
	self.RedPoint:SetActive(SoulModule.CheckSpSkillRedPoint(self.SoulData, self.Index))
end

function m:OnClickSelf()
	self.OnClickCallback(self.Index)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.SoulData = nil
end

return m
