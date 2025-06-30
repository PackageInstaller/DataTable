-- chunkname: @IQIGame\\UI\\Common\\LinkTipCell\\LinkTipCellItem.lua

local LineTipCellItem = {}

function LineTipCellItem.New(view)
	local obj = Clone(LineTipCellItem)

	obj:Init(view)

	return obj
end

function LineTipCellItem:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfName = self.goName:GetComponent("Text")
	self.tfDesc = self.goDesc:GetComponent("Text")
end

function LineTipCellItem:Refresh(id)
	self:SetActive(true)

	local cfgData = CfgSkillSpecialEffectExplainTable[id]

	self.tfName.text = LinkTipUIApi:GetString("goName", cfgData.EffectName)
	self.tfDesc.text = LinkTipUIApi:GetString("goDesc", cfgData.Describe)
end

function LineTipCellItem:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function LineTipCellItem:SetActive(vs)
	self.View:SetActive(vs)
end

return LineTipCellItem
