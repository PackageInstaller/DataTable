-- chunkname: @IQIGame\\UI\\Shop\\BuyItemPanelSubView\\GiftScrollRootView.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local GiftScrollItem = {}

function GiftScrollItem.New(view)
	local obj = Clone(GiftScrollItem)

	obj:Init(view)

	return obj
end

function GiftScrollItem:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.itemCell = ItemCell.New(self.CommonSlotUI, true, true)
end

function GiftScrollItem:SetData(previewItemsData)
	self.itemCell:SetItemByCid(previewItemsData.cid)
	UGUIUtil.SetText(self.CurOwnText, previewItemsData.count)
end

function GiftScrollItem:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function GiftScrollItem:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function GiftScrollItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.previewItemPool = UIViewObjectPool.New(self.giftItemPrefab, self.ItemContent.transform, function(_view)
		return GiftScrollItem.New(_view)
	end)

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(previewItemsData)
	self.previewItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	for i = 1, #previewItemsData do
		local previewItem = self.previewItemPool:GetFree(function(_item)
			return not _item.View.activeSelf
		end)

		previewItem:Show()
		previewItem:SetData(previewItemsData[i])
	end
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self.previewItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.previewItemPool = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
