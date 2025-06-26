-- chunkname: @IQIGame\\UI\\CheckPlayerExhibition\\CheckPlayerExhibitionCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextTag1, CheckPlayerExhibitionUIApi:GetString("TextTag1"))
	UGUIUtil.SetText(self.TextTag2, CheckPlayerExhibitionUIApi:GetString("TextTag2"))
end

function m:SetData(itemCid)
	self.itemCid = itemCid

	local path = UIGlobalApi.GetIconPath(CfgItemTable[self.itemCid].Icon)

	AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	self.ImgBg1:SetActive(false)
	self.ImgBg2:SetActive(false)
	self.ImgBg3:SetActive(true)
	self.Tag1:SetActive(false)
	self.Tag2:SetActive(false)
end

function m:SetSelect(top)
	self.Choose:SetActive(top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
