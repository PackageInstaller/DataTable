-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/rpc/RogueRpc.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.rpc.RogueRpc", package.seeall)

local RogueRpc = class("RogueRpc", BaseRpc)

function RogueRpc:sendGetRogueStateRequest()
	local req = RogueModule_pb.GetRogueStateRequest()

	self:sendMsg(req)
end

function RogueRpc:onReceiveGetRogueStateReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local state = msg.state

	V1a6_CachotModel.instance:updateRogueStateInfo(state)
	V1a6_CachotProgressListModel.instance:initDatas()
end

function RogueRpc:sendGetRogueInfoRequest(activityId)
	local req = RogueModule_pb.GetRogueInfoRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function RogueRpc:onReceiveGetRogueInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	V1a6_CachotModel.instance:updateRogueInfo(info)
	V1a6_CachotRoomModel.instance:setLayerAndRoom(info.layer, info.room)
	V1a6_CachotController.instance:enterMap(false)
end

function RogueRpc:sendGetRogueScoreRewardRequest(activityId, rewards)
	local req = RogueModule_pb.GetRogueScoreRewardRequest()

	req.activityId = activityId

	for _, id in ipairs(rewards) do
		req.rewards:append(id)
	end

	self:sendMsg(req)
end

function RogueRpc:onReceiveGetRogueScoreRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function RogueRpc:sendAbortRogueRequest(activityId)
	local req = RogueModule_pb.AbortRogueRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function RogueRpc:onReceiveAbortRogueReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local state = msg.state

	V1a6_CachotModel.instance:clearRogueInfo()
	V1a6_CachotModel.instance:updateRogueStateInfo(state)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		return
	end

	local rogueEndingInfo = V1a6_CachotModel.instance:getRogueEndingInfo()

	if rogueEndingInfo then
		V1a6_CachotController.instance:openV1a6_CachotFinishView()
	end
end

function RogueRpc:_packGroup(reqGroup, id, heroList, equips, groupName, clothId)
	reqGroup.id = id
	reqGroup.name = groupName or ""
	reqGroup.clothId = clothId or 0

	if heroList then
		for _, heroId in ipairs(heroList) do
			table.insert(reqGroup.heroList, heroId)
		end
	end

	if equips then
		for i, equip in ipairs(equips) do
			local reqEquip = HeroDef_pb.HeroGroupEquip()

			reqEquip.index = i - 1

			for _, v in ipairs(equip.equipUid) do
				table.insert(reqEquip.equipUid, v)
			end

			table.insert(reqGroup.equips, reqEquip)
		end
	end
end

function RogueRpc:sendEnterRogueRequest(activityId, difficulty, group, backupGroup, allEquips)
	local req = RogueModule_pb.EnterRogueRequest()

	req.activityId = activityId
	req.difficulty = difficulty

	self:_packGroup(req.group, group.id, group.heroList, group.equips, group.groupName, group.clothId)
	self:_packGroup(req.backupGroup, backupGroup.id, backupGroup.heroList, backupGroup.equips, backupGroup.groupName, group.clothId)

	for i, v in ipairs(allEquips) do
		table.insert(req.equipUids, v)
	end

	self:sendMsg(req)
end

function RogueRpc:onReceiveEnterRogueReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	V1a6_CachotModel.instance:updateRogueInfo(info)
	V1a6_CachotRoomModel.instance:setLayerAndRoom(info.layer, info.room)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnReceiveEnterRogueReply)
	V1a6_CachotStatController.instance:recordInitHeroGroupByEnterRogue()
end

function RogueRpc:sendRogueEventStartRequest(activityId, eventId)
	local req = RogueModule_pb.RogueEventStartRequest()

	req.activityId = activityId
	req.eventId = eventId

	self:sendMsg(req)
	V1a6_CachotEventController.instance:setPause(true, V1a6_CachotEnum.EventPauseType.Request)
end

function RogueRpc:onReceiveRogueEventStartReply(resultCode, msg)
	V1a6_CachotEventController.instance:setPause(false, V1a6_CachotEnum.EventPauseType.Request)

	if resultCode ~= 0 then
		return
	end

	if not V1a6_CachotModel.instance:isInRogue() then
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.CheckOpenEnding)
	end
end

function RogueRpc:sendRogueEventSelectRequest(activityId, eventId, option, callback, callbackObj)
	local req = RogueModule_pb.RogueEventSelectRequest()

	req.activityId = activityId
	req.eventId = eventId
	req.option = option

	self:sendMsg(req, callback, callbackObj)
end

function RogueRpc:onReceiveRogueEventSelectReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function RogueRpc:sendRogueEventEndRequest(activityId, eventId, callback, callbackObj)
	local req = RogueModule_pb.RogueEventEndRequest()

	req.activityId = activityId
	req.eventId = eventId

	self:sendMsg(req, callback, callbackObj)
end

function RogueRpc:onReceiveRogueEventEndReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function RogueRpc:sendRogueEventFightRewardRequest(activityId, eventId, idx, colletionIdx)
	local req = RogueModule_pb.RogueEventFightRewardRequest()

	req.activityId = activityId
	req.eventId = eventId
	req.idx = idx

	if colletionIdx then
		req.colletionIdx = colletionIdx
	end

	self:sendMsg(req)
end

function RogueRpc:onReceiveRogueEventFightRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnReceiveFightReward)
end

function RogueRpc:sendRogueEventCollectionRequest(activityId, eventId, idx)
	local req = RogueModule_pb.RogueEventCollectionRequest()

	req.activityId = activityId
	req.eventId = eventId
	req.idx = idx

	self:sendMsg(req)
end

function RogueRpc:onReceiveRogueEventCollectionReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function RogueRpc:sendRogueGroupChangeRequest(activityId, idx, group, callback, callbackObj)
	local req = RogueModule_pb.RogueGroupChangeRequest()

	req.activityId = activityId
	req.idx = idx

	self:_packGroup(req.group, group.id, group.heroList, group.equips, group.groupName, group.clothId)
	self:sendMsg(req, callback, callbackObj)
end

function RogueRpc:onReceiveRogueGroupChangeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local teamInfo = msg.teamInfo

	V1a6_CachotModel.instance:updateTeamInfo(teamInfo)
end

function RogueRpc:sendRogueGroupIdxChangeRequest(activityId, idx)
	local req = RogueModule_pb.RogueGroupIdxChangeRequest()

	req.activityId = activityId
	req.idx = idx

	self:sendMsg(req)
end

function RogueRpc:onReceiveRogueGroupIdxChangeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local teamInfo = msg.teamInfo

	V1a6_CachotModel.instance:updateTeamInfo(teamInfo)
end

function RogueRpc:sendRogueCollectionEnchantRequest(activityId, uid, leftUid, rightUid)
	local req = RogueModule_pb.RogueCollectionEnchantRequest()

	req.activityId = activityId
	req.uid = uid
	req.leftUid = leftUid or V1a6_CachotEnum.EmptyEnchantId
	req.rightUid = rightUid or V1a6_CachotEnum.EmptyEnchantId

	self:sendMsg(req)
end

function RogueRpc:onReceiveRogueCollectionEnchantReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function RogueRpc:onReceiveRogueGoodsInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local goodsInfos = msg.goodsInfos

	V1a6_CachotModel.instance:updateGoodsInfos(goodsInfos)
end

function RogueRpc:sendBuyRogueGoodsRequest(activityId, id, num, callback, callbackObj)
	local req = RogueModule_pb.BuyRogueGoodsRequest()

	req.activityId = activityId
	req.id = id
	req.num = num

	self:sendMsg(req, callback, callbackObj)
end

function RogueRpc:onReceiveBuyRogueGoodsReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local goodsInfo = msg.goodsInfo
	local goodInfos = V1a6_CachotModel.instance:getGoodsInfos()

	for _, v in pairs(goodInfos) do
		if v.id == goodsInfo.id then
			v:init(goodsInfo)

			break
		end
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateGoodsInfos)
end

function RogueRpc:onReceiveRogueStatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local state = msg.state

	V1a6_CachotModel.instance:updateRogueStateInfo(state)
end

function RogueRpc:onReceiveRogueInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	V1a6_CachotModel.instance:updateRogueInfo(info)
	V1a6_CachotRoomModel.instance:setLayerAndRoom(info.layer, info.room)
end

function RogueRpc:onReceiveRogueEventUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if not V1a6_CachotModel.instance:isInRogue() then
		return
	end

	local event = msg.event

	if event.status == V1a6_CachotEnum.EventStatus.Start then
		V1a6_CachotStatController.instance:statStartEvent(event)

		local newEventMo = V1a6_CachotRoomModel.instance:tryAddSelectEvent(event)

		if newEventMo then
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerTriggerInteract, newEventMo)
		end
	elseif event.status == V1a6_CachotEnum.EventStatus.Finish then
		V1a6_CachotStatController.instance:statFinishEvent(event)
		V1a6_CachotRoomModel.instance:tryRemoveSelectEvent(event)
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnEventFinish, event)
	end
end

function RogueRpc:onReceiveRogueFightResultPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local teamInfo = msg.teamInfo

	V1a6_CachotModel.instance:updateTeamInfo(teamInfo)
end

function RogueRpc:onReceiveRogueCollectionsPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local collections = msg.collections

	V1a6_CachotModel.instance:updateCollectionsInfos(collections)
end

function RogueRpc:onReceiveRogueTeamInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local teamInfo = msg.teamInfo

	V1a6_CachotModel.instance:updateTeamInfo(teamInfo)
end

function RogueRpc:onReceiveRogueCoinPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local coin = msg.coin
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	rogueInfo:updateCoin(coin)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateCoin)
end

function RogueRpc:onReceiveRogueCurrencyPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local currency = msg.currency
	local currencyTotal = msg.currencyTotal
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	rogueInfo:updateCurrency(currency)
	rogueInfo:updateCurrencyTotal(currencyTotal)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateCurrency)
end

function RogueRpc:onReceiveRogueHeartPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local heart = msg.heart
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not rogueInfo then
		return
	end

	if rogueInfo.heart ~= heart then
		local preHeartCo = V1a6_CachotConfig.instance:getHeartConfig(rogueInfo.heart)
		local nowHeartCo = V1a6_CachotConfig.instance:getHeartConfig(heart)

		if preHeartCo.id > nowHeartCo.id then
			GameFacade.showToast(ToastEnum.V1a6Cachot_HeartSub)
		elseif preHeartCo.id < nowHeartCo.id then
			GameFacade.showToast(ToastEnum.V1a6Cachot_HeartAdd)
		end
	end

	rogueInfo:updateHeart(heart)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateHeart)
end

function RogueRpc:onReceiveRogueEndPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	V1a6_CachotModel.instance:updateRogueEndingInfo(msg)
	V1a6_CachotStatController.instance:bakeRogueInfoMo()
	V1a6_CachotStatController.instance:statEnd()
	V1a6_CachotModel.instance:clearRogueInfo()
end

function RogueRpc:onReceiveRogueCollectionGetPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	V1a6_CachotEventController.instance:setPause(true, V1a6_CachotEnum.EventPauseType.GetCollecttions)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CollectionGet, ViewName.V1a6_CachotCollectionGetView, msg)
end

function RogueRpc:onReceiveRogueLifeChangePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local heroLife = msg.heroLife

	V1a6_CachotModel.instance:setChangeLifes(heroLife)
	V1a6_CachotStatController.instance:setChangeLife(heroLife)
end

function RogueRpc:sendRogueCollectionNewRequest(activityId, collecions)
	local req = RogueModule_pb.RogueCollectionNewRequest()

	req.activityId = activityId

	for _, collectionId in pairs(collecions) do
		req.collecions:append(collectionId)
	end

	self:sendMsg(req)
end

function RogueRpc:onReceiveRogueCollectionNewReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local newCollections = msg.newColletions
	local rogueStateInfo = V1a6_CachotModel.instance:getRogueStateInfo()

	if rogueStateInfo then
		rogueStateInfo:updateUnlockCollectionsNew(newCollections)
	end
end

function RogueRpc:onReceiveRogueCollectionUnlockPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	V1a6_CachotCollectionUnlockController.instance:onReceiveUnlockCollections(msg.unlockCollections)
	V1a6_CachotStatController.instance:statUnlockCollection(msg.unlockCollections)
end

function RogueRpc:sendRogueReadEndingRequest(activityId)
	local req = RogueModule_pb.RogueReadEndingRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function RogueRpc:onReceiveRogueReadEndingReply(resultCode, msg)
	return
end

function RogueRpc:sendRogueReturnRequest(activityId, callback, callbackObj)
	local req = RogueModule_pb.RogueReturnRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function RogueRpc:onReceiveRogueReturnReply(resultCode, msg)
	return
end

RogueRpc.instance = RogueRpc.New()

return RogueRpc
