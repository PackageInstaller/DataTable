-- chunkname: @IQIGame\\UI\\CommonTips\\ItemTipsContent\\ItemTipsHeadContent.lua

local ItemTipsHeadContent = {}

function ItemTipsHeadContent.New(view)
	local obj = Clone(ItemTipsHeadContent)

	obj:__Init(view)

	return obj
end

function ItemTipsHeadContent:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:AddListeners()
end

function ItemTipsHeadContent:AddListeners()
	return
end

function ItemTipsHeadContent:RemoveListeners()
	return
end

function ItemTipsHeadContent:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function ItemTipsHeadContent:SetData(itemData, params)
	local cfgData = itemData:GetCfg()

	self.itemNameText:GetComponent("Text").text = CommonItemTipsUIApi:GetItemName(cfgData.Name, cfgData.Quality)
	self.itemTypeText:GetComponent("Text").text = CommonTipsApi:GetItemTypeText(cfgData.ItemTypes, cfgData.ItemSubTypes)

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgData.Icon), self.itemImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, CommonItemTipsUIApi:GetQualityBackground(cfgData.Quality), self.qualityBg:GetComponent("Image"))
end

return ItemTipsHeadContent
