-- chunkname: @IQIGame\\Net\\NetItemResponse.lua

NetItemResponse = {}

function net_item.useItemResult(code, addItems, itemUseRecords)
	PlayerModule.PlayerInfo.itemUseRecords = itemUseRecords

	if #addItems > 0 then
		local itemDatas = {}
		local itemData

		for i = 1, #addItems do
			itemData = ItemData.New(addItems[i])

			table.insert(itemDatas, itemData)
		end

		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemDatas)
	end
end

function net_item.sellItemResult(code)
	return
end

function net_item.destroyItemResult(code)
	return
end

function net_item.lockEquipmentResult_delegate(code, uid, lock)
	NetCommController.Responded()
	EquipModule.OnReqLockResult(code, uid, lock)
end

function net_item.optionalGiftResult(code, getItems)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, getItems)
end
