-- chunkname: @IQIGame\\UI\\Fishing\\FishCollectionCell.lua

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

function m:SetData(data, isUnlock)
	self.cfgFishListData = data

	self.Lock:SetActive(not isUnlock)
	self.ImgDown:SetActive(isUnlock)
	self.ImgUp:SetActive(isUnlock)
	self.ImgQuality:SetActive(isUnlock)

	local cfgItemData = CfgItemTable[self.cfgFishListData.ItemID]

	if isUnlock then
		local path = CommonSlotUIApi:GetString("QualityBackgroundPath", cfgItemData.Quality)

		AssetUtil.LoadImage(self, path, self.ImgQuality:GetComponent("Image"))
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.ImgDown:GetComponent("Image"))
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.ImgUp:GetComponent("Image"))
	end
end

function m:SetSelect(top)
	self.goDown:SetActive(not top)
	self.goUp:SetActive(top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
