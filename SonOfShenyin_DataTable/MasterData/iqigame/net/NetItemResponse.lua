-- chunkname: @IQIGame\\Net\\NetItemResponse.lua

NetItemResponse = {}

function net_item.useItemResult(code, addItems)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, addItems)
	EventDispatcher.Dispatch(EventID.UseItemResult)
end

function net_item.compositeItemResult(code, addItems)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, addItems)
	EventDispatcher.Dispatch(EventID.CompositeItemResultEvent)
end

function net_item.sellItemResult(code)
	return
end

function net_item.destroyItemResult(code)
	return
end

function net_item.readItemFlagResult(code, itemPOD)
	ItemModule.ReadItemFlagResult(itemPOD)
end

function net_item.notifyAddItems(itemShowPODS)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShowPODS)
end

function net_item.notifyRetrunItems(itemShowPODS)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShowPODS, Constant.GetPanelType.ReturnMaterials)
end

function net_item.notifyConverterHero(heroConverterPOD)
	for k, v in pairs(heroConverterPOD) do
		WarehouseModule.ConverterItems[v.targetId] = v
	end
end

function net_item.disItemResult(code, items)
	ItemModule.DisItemResult(items)
end
