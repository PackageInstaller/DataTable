-- chunkname: @IQIGame\\UI\\CommonTips\\GiftTipsContent\\GiftTipsInfoContent.lua

local TipsSourcesElement = require("IQIGame.UI.CommonTips.Element.TipsSourcesElement")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local __PreviewItem = {}

function __PreviewItem.New(view)
	local obj = Clone(__PreviewItem)

	obj:__Init(view)

	return obj
end

function __PreviewItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.itemCell = ItemCell.New(self.CommonSlotUI, false, false)
end

function __PreviewItem:Show(data)
	self.gameObject:SetActive(true)

	local itemCfg = CfgItemTable[data.cid]

	if itemCfg == nil then
		logError("礼包道具配置错误 item.csv 找不到物品Id " .. tostring(data.cid))

		return
	end

	self.itemCell:SetItem(ItemData.CreateByCIDAndNumber(data.cid, data.count))
	LuaUtility.SetText(self.itemNameText, CommonGiftTipsUIApi:GetPreviewItemName(itemCfg.Name, itemCfg.Quality))
	LuaUtility.SetText(self.itemNumText, CommonGiftTipsUIApi:GetPreviewItemNum(data.count, itemCfg.Quality))
end

function __PreviewItem:Hide()
	self.gameObject:SetActive(false)
end

function __PreviewItem:Dispose()
	self.itemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local GiftTipsInfoContent = {}

GiftTipsInfoContent.PreviewItem = __PreviewItem
GiftTipsInfoContent.PreviewItemData = __PreviewItemData

function GiftTipsInfoContent.New(view)
	local obj = Clone(GiftTipsInfoContent)

	obj:__Init(view)

	return obj
end

function GiftTipsInfoContent:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.itemPrefab:SetActive(false)

	local itemPrefabParent = self.itemPrefab.transform.parent.transform

	self.previewItemPool = UIViewObjectPool.New(self.itemPrefab, itemPrefabParent, function(_view)
		return self.PreviewItem.New(_view)
	end)
	self.sourcesElement = TipsSourcesElement.New(self.TipsSourcesContent)

	self:__AddListeners()
end

function GiftTipsInfoContent:__AddListeners()
	return
end

function GiftTipsInfoContent:__RemoveListeners()
	return
end

function GiftTipsInfoContent:Dispose()
	self:__RemoveListeners()
	self.sourcesElement:Dispose()
	self.previewItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.previewItemPool = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function GiftTipsInfoContent:SetData(itemData, params)
	self.Content:SetActive(false)

	local cfgData = itemData:GetCfg()

	self.giftIntroText:GetComponent("Text").text = cfgData.ItemTips

	local previewItemsData = ItemModule.GetGiftPreviewItems(cfgData)

	LuaUtility.SetGameObjectShow(self.giftIntroText, #previewItemsData == 0)
	self:__RefreshGiftPreviewShow(cfgData)

	if LuaUtility.StrIsNullOrEmpty(cfgData.ItemStory) then
		self.giftBackstoryText:SetActive(false)
	else
		self.giftBackstoryText:SetActive(true)

		self.giftBackstoryText:GetComponent("Text").text = cfgData.ItemStory
	end

	if params.hideSource then
		self.sourcesElement:Hide()
	else
		self.sourcesElement:Show(cfgData.Source)
	end

	self.Content:SetActive(true)

	self.Content.transform.localPosition = Vector3.New(0, 0, 0)
end

function GiftTipsInfoContent:__RefreshGiftPreviewShow(cfgData)
	self.giftTipsText:GetComponent("Text").text = CommonGiftTipsUIApi:GetPreviewTitle(cfgData.ItemSubTypes)

	self.previewItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	local previewItemsData = ItemModule.GetGiftPreviewItems(cfgData)

	for i = 1, #previewItemsData do
		local previewItem = self.previewItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		previewItem:Show(previewItemsData[i])
	end
end

return GiftTipsInfoContent
