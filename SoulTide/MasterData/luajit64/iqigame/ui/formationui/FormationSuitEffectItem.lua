-- chunkname: @IQIGame\\UI\\FormationUI\\FormationSuitEffectItem.lua

local m = {
	COLOR_NORMAL = Color(0.38, 0.38, 0.38),
	COLOR_SELECTED = Color(0.25, 0.83, 1)
}

function m.New(view, cfgSoulPaintingRareSuitData)
	local obj = Clone(m)

	obj:Init(view, cfgSoulPaintingRareSuitData)

	return obj
end

function m:Init(view, cfgSoulPaintingRareSuitData)
	self.View = view
	self.CfgSoulPaintingRareSuitData = cfgSoulPaintingRareSuitData

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.QualityText, cfgSoulPaintingRareSuitData.Name)
	UGUIUtil.SetText(self.EffectText, cfgSoulPaintingRareSuitData.Desc)
end

function m:SetData(minQuality)
	self:SetSelected(minQuality >= self.CfgSoulPaintingRareSuitData.Quality)
end

function m:SetSelected(value)
	self.CheckMark:SetActive(value)

	local texts = self.View:GetComponentsInChildren(typeof(UnityEngine.UI.Text))

	for i = 0, texts.Length - 1 do
		local text = texts[i]

		text.color = value and m.COLOR_SELECTED or m.COLOR_NORMAL
	end
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.CfgSoulPaintingRareSuitData = nil
end

return m
