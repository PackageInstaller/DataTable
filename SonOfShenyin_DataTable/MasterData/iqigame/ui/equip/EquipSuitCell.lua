-- chunkname: @IQIGame\\UI\\Equip\\EquipSuitCell.lua

local EquipSuitCell = {}
local colorEffect = {
	g = 0.9921569,
	b = 1,
	r = 0.5607843
}

function EquipSuitCell.New(go)
	local o = Clone(EquipSuitCell)

	o:Initialize(go)

	return o
end

function EquipSuitCell:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	LuaUtility.SetGameObjectShow(self.EquipTipsText, false)
end

function EquipSuitCell:Refresh(data, effectiveCount)
	self.gameObject.name = data.EffectName

	LuaUtility.SetText(self.EffectNameText, data.EquipTips)

	if effectiveCount >= data.NeedCount then
		LuaUtility.SetTextColor(self.EffectNameText, colorEffect.r, colorEffect.g, colorEffect.b, 1)
		LuaUtility.SetTextColor(self.EquipTipsText, colorEffect.r, colorEffect.g, colorEffect.b, 1)
	else
		UGUIUtil.SetColor(self.EffectNameText:GetComponent("Text"), Color.New(0.4117647058823529, 0.4117647058823529, 0.4117647058823529, 1))
		UGUIUtil.SetColor(self.EquipTipsText:GetComponent("Text"), Color.New(0.4117647058823529, 0.4117647058823529, 0.4117647058823529, 1))
	end
end

function EquipSuitCell:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function EquipSuitCell:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function EquipSuitCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return EquipSuitCell
