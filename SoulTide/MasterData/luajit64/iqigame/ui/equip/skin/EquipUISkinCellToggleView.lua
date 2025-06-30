-- chunkname: @IQIGame\\UI\\Equip\\Skin\\EquipUISkinCellToggleView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(skinCid)
	local isUnlock = EquipModule.GetSkinState(skinCid) ~= nil

	self.LockView:SetActive(not isUnlock)

	local cfgData = CfgSoulPaintingSkinTable[skinCid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgData.DrawingSmallSize), self.SkinImage:GetComponent("Image"))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
