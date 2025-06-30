-- chunkname: @IQIGame\\UI\\Library\\LibraryEquipSkillCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(skinCid)
	self.skinCid = skinCid

	local cfgData = CfgSoulPaintingSkinTable[skinCid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgData.Icon), self.ImgIcon:GetComponent("Image"))
end

function m:SetSelect(top)
	self.Check:SetActive(top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
