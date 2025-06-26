-- chunkname: @IQIGame\\UI\\UseGiftUI.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local GiftItemCell = {
	IsSelect = false
}

function GiftItemCell.New(view, itemSelectHandler)
	local obj = Clone(GiftItemCell)

	obj:__Init(view, itemSelectHandler)

	return obj
end

function GiftItemCell:__Init(view, itemSelectHandler)
	self.gameObject = view
	self.itemSelectEventHandler = itemSelectHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.itemCell = ItemCell.New(self.CommonSlotUI, true, true)

	self.itemCell:SetClickHandler(function()
		self.itemSelectEventHandler(self.itemCell.ItemCfgOrData.cid)
	end)
end

function GiftItemCell:Show(index, itemCid, num)
	self.Index = index
	self.ItemCid = itemCid

	self.gameObject:SetActive(true)
	self.itemCell:SetItemByCid(itemCid, num)
	LuaUtility.SetText(self.itemNameText, self.itemCell.ItemCfgOrData:GetCfg().Name)
	self:ChangeSelect(false)
end

function GiftItemCell:ChangeSelect(isSelect)
	self.IsSelect = isSelect

	self.itemCell:SetSelectFrame(self.IsSelect)
end

function GiftItemCell:Hide()
	self.gameObject:SetActive(false)
end

function GiftItemCell:Dispose()
	self.itemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local UseGiftUI = {
	curSelectNum = 1
}

UseGiftUI = Base:Extend("UseGiftUI", "IQIGame.Onigao.UI.UseGiftUI", UseGiftUI)

function UseGiftUI:OnInit()
	self.itemCellPool = UIViewObjectPool.New(self.itemPrefab, self.giftItemGrid.transform, function(_view)
		return GiftItemCell.New(_view, function(cid)
			self:__OnGiftItemSelectedEventHandler(cid)
		end)
	end)

	self:OnPrepareEventProxy()
end

function UseGiftUI:GetPreloadAssetPaths()
	return nil
end

function UseGiftUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function UseGiftUI:IsManualShowOnOpen(userData)
	return false
end

function UseGiftUI:GetBGM(userData)
	return nil
end

function UseGiftUI:OnOpen(userData)
	self:__OnShow(userData.itemData)
end

function UseGiftUI:OnClose(userData)
	return
end

function UseGiftUI:OnPrepareEventProxy()
	function self.__OnCloseButtonClickProxy()
		UIModule.Close(Constant.UIControllerName.UseGiftUI)
	end

	function self.__OnMinButtonClickProxy()
		self:__OnMinButtonClickHandler()
	end

	function self.__OnReduceBtnClickProxy()
		self:__OnReduceBtnClickHandler()
	end

	function self.__OnAddButtonClickProxy()
		self:__OnAddButtonClickHandler()
	end

	function self.__OnMaxButtonClickProxy()
		self:__OnMaxButtonClickHandler()
	end

	function self.__OnUseButtonClickProxy()
		self:__OnUseButtonClickHandler()
	end
end

function UseGiftUI:OnAddListeners()
	self.minBtn:GetComponent("Button").onClick:AddListener(self.__OnMinButtonClickProxy)
	self.reduceBtn:GetComponent("Button").onClick:AddListener(self.__OnReduceBtnClickProxy)
	self.addBtn:GetComponent("Button").onClick:AddListener(self.__OnAddButtonClickProxy)
	self.maxBtn:GetComponent("Button").onClick:AddListener(self.__OnMaxButtonClickProxy)
	self.useBtn:GetComponent("Button").onClick:AddListener(self.__OnUseButtonClickProxy)
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__OnCloseButtonClickProxy)
end

function UseGiftUI:OnRemoveListeners()
	self.minBtn:GetComponent("Button").onClick:RemoveListener(self.__OnMinButtonClickProxy)
	self.reduceBtn:GetComponent("Button").onClick:RemoveListener(self.__OnReduceBtnClickProxy)
	self.addBtn:GetComponent("Button").onClick:RemoveListener(self.__OnAddButtonClickProxy)
	self.maxBtn:GetComponent("Button").onClick:RemoveListener(self.__OnMaxButtonClickProxy)
	self.useBtn:GetComponent("Button").onClick:RemoveListener(self.__OnUseButtonClickProxy)
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__OnCloseButtonClickProxy)
end

function UseGiftUI:OnPause()
	return
end

function UseGiftUI:OnResume()
	return
end

function UseGiftUI:OnCover()
	return
end

function UseGiftUI:OnReveal()
	return
end

function UseGiftUI:OnRefocus(userData)
	return
end

function UseGiftUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function UseGiftUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function UseGiftUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function UseGiftUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function UseGiftUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.itemCellPool:Dispose(function(_item)
		_item:Dispose()
	end)
end

function UseGiftUI:__OnShow(itemData)
	self.curItemData = itemData
	self.curSelectNum = 1

	local itemCfg = self.curItemData:GetCfg()

	if itemCfg.ItemSubTypes == Constant.ItemSubType[Constant.ItemType.Gift].Selection then
		self:__ShowSelectionGift()
	else
		self:__ShowNonSelectionGift()
	end

	self:__RefreshUseNumber()
	LuaUtility.SetText(self.haveNumText, self.curItemData.num)
end

function UseGiftUI:__ShowNonSelectionGift()
	self.unselectableGiftContent:SetActive(false)
	self.selectableGiftContent:SetActive(true)
	LuaUtility.SetText(self.titleText, UseGiftUIApi.GetGiftTitle())
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.curItemData:GetCfg().Icon), self.giftImg:GetComponent("Image"))
	LuaUtility.SetText(self.giftNameText, self.curItemData:GetCfg().Name)
end

function UseGiftUI:__ShowSelectionGift()
	self.selectableGiftContent:SetActive(false)
	self.unselectableGiftContent:SetActive(true)
	self.itemCellPool:ForItems(function(_item)
		_item:Hide()
	end)

	local previewItems = ItemModule.GetGiftPreviewItems(self.curItemData:GetCfg())

	for i = 1, #previewItems do
		local itemCell = self.itemCellPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		itemCell:Show(i, previewItems[i].cid, previewItems[i].count)
	end
end

function UseGiftUI:__OnGiftItemSelectedEventHandler(cid)
	self.itemCellPool:ForItems(function(_item)
		if not _item.gameObject.activeSelf then
			return
		end

		_item:ChangeSelect(_item.ItemCid == cid)
	end)
end

function UseGiftUI:__RefreshUseNumber()
	LuaUtility.SetText(self.numText, self.curSelectNum)
end

function UseGiftUI:__OnMinButtonClickHandler()
	self.curSelectNum = 1

	self:__RefreshUseNumber()
end

function UseGiftUI:__OnReduceBtnClickHandler()
	self.curSelectNum = self.curSelectNum - 1

	if self.curSelectNum < 1 then
		self.curSelectNum = 1
	end

	self:__RefreshUseNumber()
end

function UseGiftUI:__OnAddButtonClickHandler()
	self.curSelectNum = self.curSelectNum + 1

	if self.curSelectNum > self.curItemData.num then
		self.curSelectNum = self.curItemData.num
	end

	self:__RefreshUseNumber()
end

function UseGiftUI:__OnMaxButtonClickHandler()
	local itemCfg = self.curItemData:GetCfg()

	self.curSelectNum = math.min(itemCfg.MaxUse, self.curItemData.num)

	self:__RefreshUseNumber()
end

function UseGiftUI:__OnUseButtonClickHandler()
	local itemCfg = self.curItemData:GetCfg()

	if itemCfg.ItemSubTypes == Constant.ItemSubType[Constant.ItemType.Gift].Selection then
		self:__DoUseSelectionGift()
	else
		self:__DoUseNormalGift()
	end
end

function UseGiftUI:__DoUseNormalGift()
	local useItemPods = {}

	useItemPods.selectIndex = 1
	useItemPods.id = self.curItemData.id
	useItemPods.num = self.curSelectNum

	ItemModule.UseItem({
		useItemPods
	})
	self.__OnCloseButtonClickProxy()
end

function UseGiftUI:__DoUseSelectionGift()
	local selectIndex = 0

	self.itemCellPool:ForItems(function(_item)
		if not _item.gameObject.activeSelf then
			return
		end

		if not _item.IsSelect then
			return
		end

		selectIndex = _item.Index

		return true
	end)

	if selectIndex == 0 then
		NoticeModule.ShowNotice(20034)

		return
	end

	local useItemPods = {}

	useItemPods.selectIndex = selectIndex
	useItemPods.id = self.curItemData.id
	useItemPods.num = self.curSelectNum

	ItemModule.UseItem({
		useItemPods
	})
	self.__OnCloseButtonClickProxy()
end

return UseGiftUI
