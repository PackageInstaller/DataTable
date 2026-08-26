-- chunkname: @modules/logic/rouge/rpc/RougeRpc.lua

module("modules.logic.rouge.rpc.RougeRpc", package.seeall)

local RougeRpc = class("RougeRpc", BaseRpc)

function RougeRpc:sendGetRougeInfoRequest(season, callback, cbObj)
	local req = RougeModule_pb.GetRougeInfoRequest()

	req.season = season

	return self:sendMsg(req, callback, cbObj)
end

function RougeRpc:onReceiveGetRougeInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local rougeInfo = msg.rougeInfo

	RougeModel.instance:updateRougeInfo(rougeInfo)
	RougeModel.instance:setTeamInitHeros(msg.initHeroIds)
end

function RougeRpc:onReceiveRougeInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local rougeInfo = msg.rougeInfo

	RougeModel.instance:updateRougeInfo(rougeInfo)
end

function RougeRpc:sendEnterRougeSelectDifficultyRequest(season, version, difficulty, limiterNO, callback, cbObj)
	local req = RougeModule_pb.EnterRougeSelectDifficultyRequest()

	req.season = season

	for i, v in ipairs(version) do
		req.version:append(v)
	end

	req.difficulty = difficulty

	if limiterNO then
		local limitDebuffIds = limiterNO:getLimitIds()

		for _, limitId in ipairs(limitDebuffIds) do
			req.limiterNO.limitIds:append(limitId)
		end

		local limitBuffIds = limiterNO:getLimitBuffIds()

		for _, limitBuffId in ipairs(limitBuffIds) do
			req.limiterNO.limitBuffIds:append(limitBuffId)
		end
	end

	return self:sendMsg(req, callback, cbObj)
end

function RougeRpc:onReceiveEnterRougeSelectDifficultyReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local rougeInfo = msg.rougeInfo

	RougeModel.instance:updateRougeInfo(rougeInfo)
end

function RougeRpc:sendEnterRougeSelectRewardRequest(season, rewardId, callback, cbObj)
	local req = RougeModule_pb.EnterRougeSelectRewardRequest()

	req.season = season

	for i, v in ipairs(rewardId) do
		req.rewardId:append(v)
	end

	return self:sendMsg(req, callback, cbObj)
end

function RougeRpc:onReceiveEnterRougeSelectRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local rougeInfo = msg.rougeInfo

	RougeModel.instance:updateRougeInfo(rougeInfo)
end

function RougeRpc:sendEnterRougeSelectStyleRequest(season, style, callback, cbObj)
	local req = RougeModule_pb.EnterRougeSelectStyleRequest()

	req.season = season
	req.style = style

	return self:sendMsg(req, callback, cbObj)
end

function RougeRpc:onReceiveEnterRougeSelectStyleReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local rougeInfo = msg.rougeInfo

	RougeModel.instance:updateRougeInfo(rougeInfo)
end

function RougeRpc:sendEnterRougeSelectHeroesRequest(season, heroesList, assistHeroUid, callback, cbObj)
	local req = RougeModule_pb.EnterRougeSelectHeroesRequest()

	req.season = season

	for i, v in ipairs(heroesList) do
		req.heroesList:append(v)
	end

	if assistHeroUid then
		req.assistHeroUid = assistHeroUid
	end

	return self:sendMsg(req, callback, cbObj)
end

function RougeRpc:onReceiveEnterRougeSelectHeroesReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local rougeInfo = msg.rougeInfo

	RougeModel.instance:updateRougeInfo(rougeInfo)
end

function RougeRpc:sendRougeGroupChangeRequest(season, battleHeroList, callback, callbackObj)
	local req = RougeModule_pb.RougeGroupChangeRequest()

	req.season = season

	for i, v in ipairs(battleHeroList) do
		local battleHero = req.battleHeroList:add()

		battleHero.index = v.index
		battleHero.heroId = v.heroId
		battleHero.equipUid = v.equipUid
		battleHero.supportHeroId = v.supportHeroId
		battleHero.supportHeroSkill = v.supportHeroSkill
	end

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeGroupChangeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local teamInfo = msg.teamInfo

	RougeModel.instance:updateTeamInfo(teamInfo)
end

function RougeRpc:sendRougeRoundMoveRequest(nodeId)
	local req = RougeModule_pb.RougeRoundMoveRequest()

	req.season = RougeModel.instance:getSeason() or 1
	req.layer = RougeMapModel.instance:getLayerId()
	req.nodeId = nodeId

	return self:sendMsg(req)
end

function RougeRpc:onReceiveRougeRoundMoveReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(msg.map)

	if not RougeMapModel.instance:needPlayMoveToEndAnim() then
		RougeMapController.instance:startMove()
	end
end

function RougeRpc:sendRougeChoiceEventRequest(choiceId, callback, callbackObj)
	local req = RougeModule_pb.RougeChoiceEventRequest()

	req.season = RougeModel.instance:getSeason() or 1
	req.layer = RougeMapModel.instance:getLayerId()

	local curNode = RougeMapModel.instance:getCurNode()

	req.nodeId = curNode.nodeId
	req.eventId = curNode.eventId
	req.choiceId = choiceId

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeChoiceEventReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(msg.map)
	RougeStatController.instance:statRougeChoiceEvent()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onReceiveChoiceEvent)
end

function RougeRpc:sendRougeSelectDropRequest(posList, callback, callbackObj)
	local req = RougeModule_pb.RougeSelectDropRequest()

	req.season = RougeModel.instance:getSeason() or 1

	for _, v in ipairs(posList) do
		req.collectionPos:append(v - 1)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeSelectDropReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(msg.map)
end

function RougeRpc:sendRougeSelectLostCollectionRequest(collectionMoList, callback, callbackObj)
	local req = RougeModule_pb.RougeSelectLostCollectionRequest()

	req.season = RougeModel.instance:getSeason() or 1

	for _, v in ipairs(collectionMoList) do
		req.collectionUid:append(v.uid)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeSelectLostCollectionReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(msg.map)
end

function RougeRpc:sendRougeSelectHealRequest(heroIdList, callback, callbackObj)
	local req = RougeModule_pb.RougeSelectHealRequest()

	req.season = RougeModel.instance:getSeason() or 1

	for _, v in ipairs(heroIdList) do
		req.heroIds:append(v)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeSelectHealReply(resultCode, msg)
	return
end

function RougeRpc:sendRougeSelectReviveRequest(heroIdList, callback, callbackObj)
	local req = RougeModule_pb.RougeSelectReviveRequest()

	req.season = RougeModel.instance:getSeason() or 1

	for _, v in ipairs(heroIdList) do
		req.heroIds:append(v)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeSelectReviveReply(resultCode, msg)
	return
end

function RougeRpc:sendRougePieceMoveRequest(index, callback, callbackObj)
	local req = RougeModule_pb.RougePieceMoveRequest()

	req.season = RougeModel.instance:getSeason() or 1
	req.layer = RougeMapModel.instance:getLayerId()
	req.middleLayer = RougeMapModel.instance:getMiddleLayerId()
	req.index = index

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougePieceMoveReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(msg.map)
end

function RougeRpc:sendRougePieceTalkSelectRequest(selectId, callback, callbackObj)
	local req = RougeModule_pb.RougePieceTalkSelectRequest()

	req.season = RougeModel.instance:getSeason() or 1
	req.layer = RougeMapModel.instance:getLayerId()
	req.middleLayer = RougeMapModel.instance:getMiddleLayerId()
	req.index = RougeMapModel.instance:getCurPosIndex()
	req.select = selectId

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougePieceTalkSelectReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(msg.map)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onReceivePieceChoiceEvent)
end

function RougeRpc:sendRougeLeaveMiddleLayerRequest(nextLayerId)
	local req = RougeModule_pb.RougeLeaveMiddleLayerRequest()

	req.season = RougeModel.instance:getSeason() or 1
	req.layer = RougeMapModel.instance:getLayerId()
	req.middleLayer = RougeMapModel.instance:getMiddleLayerId()
	req.nextLayer = nextLayerId

	RougeMapModel.instance:setWaitLeaveMiddleLayerReply(true)

	return self:sendMsg(req)
end

function RougeRpc:onReceiveRougeLeaveMiddleLayerReply(resultCode, msg)
	RougeMapModel.instance:setWaitLeaveMiddleLayerReply(nil)

	if resultCode ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(msg.createEventMap)
	RougeMapModel.instance:setFinalMapInfo(msg.finalMap)

	local curLayerId = RougeMapModel.instance:getLayerId()

	ViewMgr.instance:openView(ViewName.RougeNextLayerView, curLayerId)
end

function RougeRpc:sendRougeBuyGoodsRequest(eventId, goodsPos, callback, callbackObj)
	local req = RougeModule_pb.RougeBuyGoodsRequest()

	req.season = RougeModel.instance:getSeason() or 1
	req.layer = RougeMapModel.instance:getLayerId()
	req.nodeId = RougeMapModel.instance:getCurNode().nodeId
	req.eventId = eventId

	req.goodsPos:append(goodsPos)

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeBuyGoodsReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(msg.map)
end

function RougeRpc:sendRougeEndShopEventRequest(eventId, callback, callbackObj)
	local curNode = RougeMapModel.instance:getCurNode()

	if not curNode then
		if callback then
			callback(callbackObj)
		end

		return
	end

	local req = RougeModule_pb.RougeEndShopEventRequest()

	req.season = RougeModel.instance:getSeason() or 1
	req.layer = RougeMapModel.instance:getLayerId()
	req.nodeId = curNode.nodeId
	req.eventId = eventId

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeEndShopEventReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(msg.map)
end

function RougeRpc:sendRougeShopRefreshRequest(eventId, callback, callbackObj)
	local req = RougeModule_pb.RougeShopRefreshRequest()

	req.season = RougeModel.instance:getSeason() or 1
	req.layer = RougeMapModel.instance:getLayerId()
	req.nodeId = RougeMapModel.instance:getCurNode().nodeId
	req.eventId = eventId

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeShopRefreshReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(msg.map)
end

function RougeRpc:onReceiveRougeInMapItemUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionDropView, {
		collectionList = msg.collectionId,
		viewEnum = RougeMapEnum.CollectionDropViewEnum.OnlyShow
	})
end

function RougeRpc:onReceiveRougeLayerMapInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(msg.map)
end

function RougeRpc:onReceiveRougeLayerSimpleMapInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeMapModel.instance:updateSimpleMapInfo(msg.map)
end

function RougeRpc:sendRougeRecruitHeroRequest(heroIdList)
	local req = RougeModule_pb.RougeRecruitHeroRequest()

	req.season = RougeModel.instance:getSeason() or 1

	if heroIdList then
		for _, v in ipairs(heroIdList) do
			req.heroIds:append(v)
		end
	end

	return self:sendMsg(req)
end

function RougeRpc:onReceiveRougeRecruitHeroReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeModel.instance:updateTeamLife(msg.teamInfo.heroLifeList)
	RougeModel.instance:updateExtraHeroInfo(msg.teamInfo.heroInfoList)
end

function RougeRpc:onReceiveRougeFightResultPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeModel.instance:updateFightResultMo(msg)
end

function RougeRpc:onReceiveRougeInteractiveTeamHpUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeModel.instance:updateTeamLifeAndDispatchEvent(msg.heroLifeList)
	RougeMapTipPopController.instance:addPopTipByInteractId(msg.interactiveId)
end

function RougeRpc:onReceiveRougeEntrustInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeMapModel.instance:updateEntrustInfo(msg.entrustInfo)
end

function RougeRpc:sendRougeInlayRequest(collectionId, enchantId, holeIndex, callback, callbackObj)
	local req = RougeModule_pb.RougeInlayRequest()

	req.season = RougeModel.instance:getSeason()
	req.targetId = collectionId
	req.holdId = holeIndex - 1
	req.consumeId = enchantId

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeInlayReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local item = msg.item
	local preItem = msg.preItem
	local reason = msg.reason

	RougeCollectionModel.instance:rougeInlay(item, preItem, reason)
	RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
end

function RougeRpc:sendRougeDemountRequest(collectionId, holeIndex, callback, callbackObj)
	local req = RougeModule_pb.RougeDemountRequest()

	req.season = RougeModel.instance:getSeason()
	req.targetId = collectionId
	req.holdId = holeIndex - 1

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeDemountReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local item = msg.item
	local reason = msg.reason

	RougeCollectionModel.instance:rougeDemount(item, reason)
	RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
end

function RougeRpc:sendRougeAddToBarRequest(collectionId, pos, rotation)
	local req = RougeModule_pb.RougeAddToBarRequest()

	req.season = RougeModel.instance:getSeason() or 1
	req.targetId = collectionId
	req.rotation = rotation
	req.pos.row = pos.y
	req.pos.col = pos.x

	self:sendMsg(req)
end

function RougeRpc:onReceiveRougeAddToBarReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function RougeRpc:sendRougeRemoveFromBarRequest(collectionId)
	local req = RougeModule_pb.RougeRemoveFromBarRequest()

	req.season = RougeModel.instance:getSeason()
	req.id = collectionId

	self:sendMsg(req)
end

function RougeRpc:onReceiveRougeRemoveFromBarReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
end

function RougeRpc:onReceiveRougeAddItemWarehousePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local items = msg.items
	local reason = msg.reason

	RougeCollectionModel.instance:onReceiveNewInfo2Bag(items, reason)
end

function RougeRpc:onReceiveRougeRemoveItemWarehousePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeCollectionModel.instance:deleteSomeCollectionFromWarehouse(msg.ids)
end

function RougeRpc:onReceiveRougeItemBagPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeCollectionModel.instance:onReceiveNewInfo2Slot(msg.bag)
end

function RougeRpc:onReceiveRougeItemWarehousePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeCollectionModel.instance:onReceiveNewInfo2Bag(msg.bag)
end

function RougeRpc:onReceiveRougeAddItemBagPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local reason = msg.reason

	RougeCollectionModel.instance:onReceiveNewInfo2Slot(msg.layouts, reason)
end

function RougeRpc:onReceiveRougeRemoveItemBagPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local ids = msg.ids

	RougeCollectionModel.instance:deleteSomeCollectionFromSlot(ids)
end

function RougeRpc:onReceiveRougeItemUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local item = msg.items

	RougeCollectionModel.instance:updateCollectionItems(item)
end

function RougeRpc:sendRougeOneKeyAddToBarRequest(season)
	local req = RougeModule_pb.RougeOneKeyAddToBarRequest()

	req.season = season

	self:sendMsg(req)
end

function RougeRpc:onReceiveRougeOneKeyAddToBarReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeStatController.instance:operateCollection(RougeStatController.operateType.Auto)
	RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
end

function RougeRpc:sendRougeOneKeyRemoveFromBarRequest(season)
	local req = RougeModule_pb.RougeOneKeyRemoveFromBarRequest()

	req.season = season

	self:sendMsg(req)
end

function RougeRpc:onReceiveRougeItemLayoutEffectUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local updateCollections = {}

	for _, info in ipairs(msg.updates) do
		local collectionId = tonumber(info.id)
		local baseEffects = info.baseEffects
		local relations = info.relations
		local attrValues = info.attr
		local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)

		if not collectionMO then
			return
		end

		local isInSlotArea = RougeCollectionModel.instance:isCollectionPlaceInSlotArea(collectionId)

		if not isInSlotArea then
			return
		end

		collectionMO:updateBaseEffects(baseEffects)
		collectionMO:updateEffectRelations(relations)
		collectionMO:updateAttrValues(attrValues)
		table.insert(updateCollections, collectionMO)
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateSlotCollectionEffect, updateCollections)
end

function RougeRpc:onReceiveRougeItemEffectChangeItemPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local isNeedTrigger = self:_checkIsTriggerEffectChangeItem(msg)

	if not isNeedTrigger then
		return
	end

	local trigger = RougeCollectionHelper.buildNewCollectionSlotMO(msg.trigger)
	local removeCollections = RougeCollectionHelper.buildCollectionSlotMOs(msg.rmLayouts)
	local addSlotIds = {}
	local addBagIds = {}
	local showType = tonumber(msg.showType)

	if msg.addToBag then
		for _, collectionId in ipairs(msg.addToBag) do
			table.insert(addSlotIds, tonumber(collectionId))
		end
	end

	if msg.addToWarehouse then
		for _, collectionId in ipairs(msg.addToWarehouse) do
			table.insert(addBagIds, tonumber(collectionId))
		end
	end

	RougeCollectionModel.instance:saveTmpCollectionTriggerEffectInfo(trigger, removeCollections, addSlotIds, addBagIds, showType)
end

function RougeRpc:_checkIsTriggerEffectChangeItem(msg)
	if not msg then
		return false
	end

	local showType = msg.showType
	local removeCollections = msg.rmLayouts

	if showType == RougeEnum.EffectTriggerType.Engulf or showType == RougeEnum.EffectTriggerType.LevelUp then
		return removeCollections and #removeCollections > 0
	end

	return true
end

function RougeRpc:onReceiveRougeOneKeyRemoveFromBarReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeCollectionModel.instance:onKeyClearSlotArea()
	RougeStatController.instance:operateCollection(RougeStatController.operateType.Clear)
	RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
end

function RougeRpc:sendRougeComposeRequest(season, composeId, consumeIds)
	local req = RougeModule_pb.RougeComposeRequest()

	req.season = season
	req.composeId = composeId

	if consumeIds then
		for _, consumeId in ipairs(consumeIds) do
			req.consumeIds:append(consumeId)
		end
	end

	self:sendMsg(req)
end

function RougeRpc:onReceiveRougeComposeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeController.instance:dispatchEvent(RougeEvent.CompositeCollectionSucc)
end

function RougeRpc:onReceiveRougeUpdateCoinPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeModel.instance:getRougeInfo().coin = msg.coin

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeInfoCoin)
end

function RougeRpc:onReceiveRougeUpdatePowerPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeModel.instance:updatePower(msg.power, msg.powerLimit)
end

function RougeRpc:onReceiveRougeUpdateTalentPointPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeModel.instance:getRougeInfo().talentPoint = msg.talentPoint

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeInfoTalentPoint)
end

function RougeRpc:onReceiveRougeUpdateTeamExpAndLevelPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local teamLevel = msg.teamLevel
	local teamExp = msg.teamExp
	local teamSize = msg.teamSize
	local rougeInfo = RougeModel.instance:getRougeInfo()
	local srcLv = rougeInfo.teamLevel
	local srcTeamSize = rougeInfo.teamSize

	rougeInfo.teamLevel = teamLevel
	rougeInfo.teamExp = teamExp
	rougeInfo.teamSize = teamSize

	if srcLv ~= teamLevel and srcLv > 0 then
		RougePopController.instance:addPopViewWithViewName(ViewName.RougeLevelUpView, {
			preLv = srcLv,
			curLv = teamLevel,
			preTeamSize = srcTeamSize,
			curTeamSize = teamSize
		})
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeInfoTeamValues)
end

function RougeRpc:sendRougeAbortRequest(season, callback, cbObj)
	local req = RougeModule_pb.RougeAbortRequest()

	req.season = season or RougeOutsideModel.instance:season()

	return self:sendMsg(req, callback, cbObj)
end

function RougeRpc:onReceiveRougeAbortReply(resultCode, msg)
	local state = RougeModel.instance:getState()

	if state < RougeEnum.State.Start then
		RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(RougeOutsideModel.instance:season())
		RougeModel.instance:clear()

		return
	end

	if resultCode ~= 0 then
		return
	end

	RougeModel.instance:updateRougeInfo(msg.rougeInfo)
	RougeModel.instance:onAbortRouge()
end

function RougeRpc:sendRougeEndRequest(callback, callbackObj)
	local req = RougeModule_pb.RougeEndRequest()

	req.season = RougeModel.instance:getSeason() or 1

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeEndReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(RougeOutsideModel.instance:season())

	local rougeInfo = msg.rougeInfo
	local resultInfo = msg.resultInfo

	RougeModel.instance:updateRougeInfo(rougeInfo)
	RougeModel.instance:updateResultInfo(resultInfo)

	if not RougeStatController.instance:checkIsReset() then
		RougeStatController.instance:statEnd()
	else
		RougeStatController.instance:statEnd(RougeStatController.EndResult.Abort)
	end
end

function RougeRpc:sendActiveTalentRequest(season, index, cb, cbObj)
	local req = RougeModule_pb.ActiveTalentRequest()

	req.season = season
	req.index = index

	return self:sendMsg(req, cb, cbObj)
end

function RougeRpc:onReceiveActiveTalentReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local rougeTalentTree = msg.rougeTalentTree

	RougeModel.instance:updateTalentInfo(rougeTalentTree.rougeTalent)
end

function RougeRpc:onReceiveRougeTeamHpUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeModel.instance:updateTeamLifeAndDispatchEvent(msg.heroLifeList)
end

function RougeRpc:sendRougeRepairShopBuyRequest(collectionId, callback, callbackObj)
	local req = RougeModule_pb.RougeRepairShopBuyRequest()

	req.season = RougeModel.instance:getSeason() or 1
	req.collectionId = collectionId

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeRepairShopBuyReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local pieceInfo = msg.pieceInfo
	local pieceMo = RougeMapModel.instance:getPieceMo(pieceInfo.index)

	if pieceMo then
		pieceMo:update(pieceInfo)
	end
end

function RougeRpc:sendRougeRepairShopRandomRequest(callback, callbackObj)
	local req = RougeModule_pb.RougeRepairShopRandomRequest()

	req.season = RougeModel.instance:getSeason() or 1

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeRepairShopRandomReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local pieceInfo = msg.pieceInfo
	local pieceMo = RougeMapModel.instance:getPieceMo(pieceInfo.index)

	if pieceMo then
		pieceMo:update(pieceInfo)
	end
end

function RougeRpc:sendRougeDisplaceRequest(collectionId, callback, callbackObj)
	local req = RougeModule_pb.RougeDisplaceRequest()

	req.season = RougeModel.instance:getSeason() or 1
	req.collectionId = collectionId

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeDisplaceReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local pieceInfo = msg.pieceInfo
	local pieceMo = RougeMapModel.instance:getPieceMo(pieceInfo.index)

	if pieceMo then
		pieceMo:update(pieceInfo)
	end
end

function RougeRpc:onReceiveRougeTriggerEffectPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeMapTipPopController.instance:addPopTipByEffect(msg.effect)
end

function RougeRpc:sendRougeRandomDropRequest(callback, callbackObj)
	local req = RougeModule_pb.RougeRandomDropRequest()

	req.season = RougeModel.instance:getSeason() or 1

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeRandomDropReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(msg.map)
end

function RougeRpc:sendRougeMonsterFixAttrRequest(season, callback, callbackObj)
	local req = RougeModule_pb.RougeMonsterFixAttrRequest()

	req.season = season

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeMonsterFixAttrReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function RougeRpc:onReceiveRougeTeamInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local teamInfo = msg.teamInfo

	RougeModel.instance:updateTeamInfo(teamInfo)
end

function RougeRpc:sendRougeUseMapSkillRequest(season, mapSkillId, callback, callbackObj)
	local req = RougeModule_pb.RougeUseMapSkillRequest()

	req.season = season
	req.mapSkillId = mapSkillId

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeUseMapSkillReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mapSkill = msg.mapSkill

	RougeMapModel.instance:onUpdateMapSkillInfo(mapSkill)
	RougeStatController.instance:trackUseMapSkill(mapSkill.id)
end

function RougeRpc:sendRougeUnlockSkillRequest(season, skillId, callback, callbackObj)
	local req = RougeModule_pb.RougeUnlockSkillRequest()

	req.season = season
	req.skillId = skillId

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeUnlockSkillReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function RougeRpc:sendRougeItemTrammelsRequest(season, callback, callbackObj)
	local req = RougeModule_pb.RougeItemTrammelsRequest()

	req.season = season

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeItemTrammelsReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function RougeRpc:sendRougeSelectCollectionLevelUpRequest(season, collectionUids, callback, callbackObj)
	local req = RougeModule_pb.RougeSelectCollectionLevelUpRequest()

	req.season = season

	if collectionUids then
		for _, v in ipairs(collectionUids) do
			req.collectionUid:append(v)
		end
	end

	return self:sendMsg(req, callback, callbackObj)
end

function RougeRpc:onReceiveRougeSelectCollectionLevelUpReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(msg.map)
end

function RougeRpc:sendRougeRefreshMapRuleRequest(season, layerId)
	local req = RougeModule_pb.RougeRefreshMapRuleRequest()

	req.season = season
	req.layer = layerId

	self:sendMsg(req)
end

function RougeRpc:onReceiveRougeRefreshMapRuleReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(msg.map)
end

function RougeRpc:sendRougeRefreshMonsterRuleRequest(season, index)
	local req = RougeModule_pb.RougeRefreshMonsterRuleRequest()

	req.season = season
	req.index = index

	self:sendMsg(req)
end

function RougeRpc:onReceiveRougeRefreshMonsterRuleReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeMapModel.instance:updateMapInfo(msg.map)
end

RougeRpc.instance = RougeRpc.New()

return RougeRpc
