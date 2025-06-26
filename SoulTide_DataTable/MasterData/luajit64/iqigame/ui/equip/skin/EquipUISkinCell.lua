-- chunkname: @IQIGame\\UI\\Equip\\Skin\\EquipUISkinCell.lua

local EquipUISkinCellToggleView = require("IQIGame.UI.Equip.Skin.EquipUISkinCellToggleView")
local m = {
	SkinCid = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ToggleOnView = EquipUISkinCellToggleView.New(self.ToggleOnViewGO)
	self.ToggleOffView = EquipUISkinCellToggleView.New(self.ToggleOffViewGO)

	UGUIUtil.SetTextInChildren(self.UsingView, EquipUIApi:GetString("SkinView_Cell_UsingViewText"))
end

function m:SetData(skinCid)
	self.SkinCid = skinCid

	self.ToggleOnView:SetData(skinCid)
	self.ToggleOffView:SetData(skinCid)

	local isUsing = EquipModule.GetSkinState(skinCid) == 1

	self.UsingView:SetActive(isUsing)
end

function m:Dispose()
	self.ToggleOffView:Dispose()
	self.ToggleOnView:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
