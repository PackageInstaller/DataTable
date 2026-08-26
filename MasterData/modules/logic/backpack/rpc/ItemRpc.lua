-- chunkname: @modules/logic/backpack/rpc/ItemRpc.lua

module("modules.logic.backpack.rpc.ItemRpc", package.seeall)

local ItemRpc = class("ItemRpc", BaseRpc)

function ItemRpc:sendUseItemRequest(co, id, callback, callbackObj)
	logNormal("Send Use Item Request !")

	local req = ItemModule_pb.UseItemRequest()

	for _, v in ipairs(co) do
		local entry = MaterialModule_pb.M2QEntry()

		entry.materialId = v.materialId
		entry.quantity = v.quantity

		table.insert(req.entry, entry)
	end

	req.targetId = id

	self:sendMsg(req, callback, callbackObj)
end

function ItemRpc:onReceiveUseItemReply(resultCode, msg)
	logNormal("Receive Use Item Reply Result Code : " .. resultCode)
	StoreController.instance:onUseItemInStore(msg)
	BackpackController.instance:dispatchEvent(BackpackEvent.onUseItemFinished)
end

function ItemRpc:onReceiveItemChangePush(resultCode, msg)
	if resultCode == 0 then
		SummonMainController.instance:checkItemConvert(msg.items)
		ItemModel.instance:changeItemList(msg.items)
		ItemPowerModel.instance:changePowerItemList(msg.powerItems)
		ItemInsightModel.instance:changeInsightItemList(msg.insightItems)
		ItemTalentModel.instance:changeTalentItemList(msg.talentItems)
		ItemExpireModel.instance:changeExpireItemList(msg.expireItems)
		BackpackController.instance:dispatchEvent(BackpackEvent.UpdateItemList)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function ItemRpc:sendGetItemListRequest(callback, callbackObj)
	local req = ItemModule_pb.GetItemListRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function ItemRpc:onReceiveGetItemListReply(resultCode, msg)
	if resultCode == 0 then
		ItemModel.instance:setItemList(msg.items)
		ItemModel.instance:setOptionalGift()
		ItemPowerModel.instance:setPowerItemList(msg.powerItems)
		ItemInsightModel.instance:setInsightItemList(msg.insightItems)
		ItemTalentModel.instance:setTalentItemList(msg.talentItems)
		ItemExpireModel.instance:changeExpireItemList(msg.expireItems)
		BackpackController.instance:dispatchEvent(BackpackEvent.UpdateItemList)
	end
end

function ItemRpc:sendUsePowerItemRequest(uid)
	local req = ItemModule_pb.UsePowerItemRequest()

	req.uid = uid

	self:sendMsg(req)
end

function ItemRpc:onReceiveUsePowerItemReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	BackpackController.instance:dispatchEvent(BackpackEvent.UsePowerPotionFinish, msg.uid)
end

function ItemRpc:sendUsePowerItemListRequest(userItemList)
	local req = ItemModule_pb.UsePowerItemListRequest()

	for _, userItem in ipairs(userItemList) do
		local item = ItemModule_pb.UsePowerItemInfo()

		item.uid = userItem.uid
		item.num = userItem.num

		table.insert(req.usePowerItemInfo, item)
	end

	self:sendMsg(req)
end

function ItemRpc:onReceiveUsePowerItemListReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	BackpackController.instance:dispatchEvent(BackpackEvent.UsePowerPotionListFinish, msg.usePowerItemInfo)
end

function ItemRpc:sendAutoUseExpirePowerItemRequest(param)
	if self._autoUsePowerTime and ServerTime.now() - self._autoUsePowerTime < 1 then
		self._autoUsePowerTime = ServerTime.now()

		return
	end

	self._autoUsePowerTime = ServerTime.now()

	local req = ItemModule_pb.AutoUseExpirePowerItemRequest()

	return self:sendMsg(req, param)
end

function ItemRpc:onReceiveAutoUseExpirePowerItemReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.used then
		GameFacade.showToast(ToastEnum.AutoUsseExpirePowerItem)
	end
end

function ItemRpc:sendMarkReadSubType21Request(itemId)
	local req = ItemModule_pb.MarkReadSubType21Request()

	req.itemId = itemId

	return self:sendMsg(req)
end

function ItemRpc:onReceiveMarkReadSubType21Reply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function ItemRpc:sendUseInsightItemRequest(itemUid, heroId, callback, callbackObj)
	local req = ItemModule_pb.UseInsightItemRequest()

	self._startRank = HeroModel.instance:getByHeroId(heroId).rank
	req.uid = itemUid
	req.heroId = heroId

	self:sendMsg(req, callback, callbackObj)
end

function ItemRpc:onReceiveUseInsightItemReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	BackpackController.instance:dispatchEvent(BackpackEvent.UseInsightItemFinished, msg.uid, msg.heroId)
	CharacterController.instance:dispatchEvent(CharacterEvent.successHeroRankUp)
	RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)

	local param = {}

	param.heroId = msg.heroId

	local heroMO = HeroModel.instance:getByHeroId(param.heroId)

	param.newRank = heroMO.rank
	param.startRank = self._startRank
	param.isRank = true

	PopupController.instance:addPopupView(PopupEnum.PriorityType.GainCharacterView, ViewName.CharacterGetView, param)
end

function ItemRpc:simpleSendUseItemRequest(materialId, quantity, targetId, callback, callbackObj)
	if not quantity or quantity <= 0 then
		return
	end

	self:sendUseItemRequest({
		{
			materialId = materialId,
			quantity = quantity
		}
	}, targetId or 0, callback, callbackObj)
end

function ItemRpc:sendGetPowerMakerInfoRequest(isAutoUse, isLogin, callback, callbackObj)
	local req = ItemModule_pb.GetPowerMakerInfoRequest()

	req.isAutoUse = isAutoUse or false
	req.isLogin = isLogin or false

	self:sendMsg(req, callback, callbackObj)
end

function ItemRpc:onReceiveGetPowerMakerInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ItemPowerModel.instance:onGetPowerMakerInfo(msg)
	CurrencyController.instance:dispatchEvent(CurrencyEvent.RefreshPowerMakerInfo)
end

function ItemRpc:autoUseExpirePowerItem()
	if self.isAutoUseExpirePowerItem then
		return
	end

	self:sendGetPowerMakerInfoRequest(false, false, function()
		ItemRpc.instance:sendGetItemListRequest(function()
			self.isAutoUseExpirePowerItem = nil
		end)
		ItemRpc.instance:sendAutoUseExpirePowerItemRequest()
	end)

	self.isAutoUseExpirePowerItem = true
end

function ItemRpc:sendUseTalentItemRequest(uid, heroUid, callback, callbackObj)
	local req = ItemModule_pb.UseTalentItemRequest()

	req.uid = uid
	req.heroUid = heroUid

	self:sendMsg(req, callback, callbackObj)
end

function ItemRpc:onReceiveUseTalentItemReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ItemTalentController.instance:dispatchEvent(ItemTalentEvent.UseTalentItemSuccess, msg.uid, msg.heroUid)
end

ItemRpc.instance = ItemRpc.New()

return ItemRpc
