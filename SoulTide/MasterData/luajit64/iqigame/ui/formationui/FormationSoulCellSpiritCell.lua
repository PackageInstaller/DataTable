-- chunkname: @IQIGame\\UI\\FormationUI\\FormationSoulCellSpiritCell.lua

local m = {
	HasAvailableSkill = false
}

function m.New(view, onClick)
	local obj = Clone(m)

	obj:Init(view, onClick)

	return obj
end

function m:Init(view, onClick)
	self.View = view
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

function m:SetData(skillCid, hasAvailableSkill)
	self.HasAvailableSkill = hasAvailableSkill

	self.NormalView:SetActive(skillCid ~= 0)
	self.EmptyView:SetActive(skillCid == 0 and hasAvailableSkill)
	self.UnavailableView:SetActive(not hasAvailableSkill)

	if skillCid ~= 0 then
		local cfgSkillData = CfgSkillTable[skillCid]

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgSkillData.Icon), self.SpiritIcon:GetComponent(typeof(UnityEngine.UI.Image)))
	end
end

function m:OnClickSelf()
	if not self.HasAvailableSkill then
		return
	end

	if self.OnClickCallback ~= nil then
		self.OnClickCallback()
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.OnClickCallback = nil
end

return m
