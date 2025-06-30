-- chunkname: @IQIGame\\UI\\CommonTips\\GiftTipsContent\\GiftTipsHeadContent.lua

local GiftTipsHeadContent = {}

function GiftTipsHeadContent.New(view)
	local obj = Clone(GiftTipsHeadContent)

	obj:__Init(view)

	return obj
end

function GiftTipsHeadContent:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:__AddListeners()
end

function GiftTipsHeadContent:__AddListeners()
	return
end

function GiftTipsHeadContent:__RemoveListeners()
	return
end

function GiftTipsHeadContent:Dispose()
	self:__RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function GiftTipsHeadContent:SetData(itemData, params)
	local cfgData = itemData:GetCfg()

	self.giftNameText:GetComponent("Text").text = CommonGiftTipsUIApi:GetItemName(cfgData.Name, cfgData.Quality)
	self.giftTypeText:GetComponent("Text").text = CommonTipsApi:GetItemTypeText(cfgData.ItemTypes, cfgData.ItemSubTypes)

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgData.Icon), self.giftImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, CommonTipsApi:GetQualityBackground(cfgData.Quality), self.qualityBg:GetComponent("Image"))
end

return GiftTipsHeadContent
