-- chunkname: @modules/logic/rouge2/common/rpc/Rouge2_Rpc.lua

module("modules.logic.rouge2.common.rpc.Rouge2_Rpc", package.seeall)

local Rouge2_Rpc = class("Rouge2_Rpc", BaseRpc)

function Rouge2_Rpc:reInit()
	self._isWaitEquipAciveSkill = false
end

function Rouge2_Rpc:sendGetRouge2InfoRequest(callback, callbackObj)
	local req = Rouge2Module_pb.GetRouge2InfoRequest()

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveGetRouge2InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local rouge2Info = msg.rouge2Info

	Rouge2_Model.instance:updateRougeInfo(rouge2Info)
end

function Rouge2_Rpc:sendEnterRouge2SelectDifficultyRequest(difficulty, callback, callbackObj)
	local req = Rouge2Module_pb.EnterRouge2SelectDifficultyRequest()

	req.difficulty = difficulty

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveEnterRouge2SelectDifficultyReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local rouge2Info = msg.rouge2Info

	Rouge2_Model.instance:updateRougeInfo(rouge2Info)
	Rouge2_StatController.instance:statSelectDifficulty()
end

function Rouge2_Rpc:sendEnterRouge2SelectCareerRequest(careerId, callback, callbackObj)
	local req = Rouge2Module_pb.EnterRouge2SelectCareerRequest()

	req.careerId = careerId

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveEnterRouge2SelectCareerReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local rouge2Info = msg.rouge2Info

	Rouge2_Model.instance:updateRougeInfo(rouge2Info)
	Rouge2_SystemController.instance:checkCurTeamSystemId()
	Rouge2_StatController.instance:statSelectCareer()
end

function Rouge2_Rpc:sendRouge2AddCareerAttrPointRequest(attrId, addPoint, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2AddCareerAttrPointRequest()

	req.attrId = attrId
	req.addPoint = addPoint

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2AddCareerAttrPointReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local map = msg.map

	Rouge2_MapModel.instance:updateMapInfo(map)
end

function Rouge2_Rpc:sendRouge2RoundMoveRequest(layer, nodeId, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2RoundMoveRequest()

	req.layer = layer
	req.nodeId = nodeId

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2RoundMoveReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local map = msg.map

	Rouge2_MapModel.instance:updateMapInfo(map)

	if not Rouge2_MapModel.instance:needPlayMoveToEndAnim() then
		Rouge2_MapController.instance:startMove()
	end
end

function Rouge2_Rpc:sendRouge2ChoiceEventRequest(layer, nodeId, eventId, choiceId, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2ChoiceEventRequest()

	req.layer = layer
	req.nodeId = nodeId
	req.eventId = eventId
	req.choiceId = choiceId

	Rouge2_MapChoiceController.instance:onSendChoiceRequest()
	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2ChoiceEventReply(resultCode, msg)
	Rouge2_MapChoiceController.instance:onReceiveChoiceReply(resultCode, msg)
end

function Rouge2_Rpc:sendRouge2BuyGoodsRequest(layer, nodeId, eventId, goodsPos, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2BuyGoodsRequest()

	req.layer = layer
	req.nodeId = nodeId
	req.eventId = eventId

	if goodsPos then
		for _, pos in ipairs(goodsPos) do
			req.goodsPos:append(pos)
		end
	end

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2BuyGoodsReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Rouge2_MapModel.instance:updateMapInfo(msg.map)
end

function Rouge2_Rpc:sendRouge2StealGoodsRequest(layer, nodeId, eventId, goodsPos, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2StealGoodsRequest()

	req.layer = layer
	req.nodeId = nodeId
	req.eventId = eventId

	if goodsPos then
		for _, pos in ipairs(goodsPos) do
			req.goodsPos:append(pos)
		end
	end

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2StealGoodsReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Rouge2_MapModel.instance:updateMapInfo(msg.map)
end

function Rouge2_Rpc:sendRouge2StealGoodsEnterFightRequest(layer, nodeId, eventId, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2StealGoodsEnterFightRequest()

	req.layer = layer
	req.nodeId = nodeId
	req.eventId = eventId

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2StealGoodsEnterFightReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Rouge2_MapModel.instance:updateMapInfo(msg.map)
end

function Rouge2_Rpc:sendRouge2EndShopEventRequest(layer, nodeId, eventId, isReturn, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2EndShopEventRequest()

	req.layer = layer
	req.nodeId = nodeId
	req.eventId = eventId
	req["return"] = isReturn

	return self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2EndShopEventReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Rouge2_MapModel.instance:updateMapInfo(msg.map)
end

function Rouge2_Rpc:sendRouge2ShopRefreshRequest(layer, nodeId, eventId, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2ShopRefreshRequest()

	req.layer = layer
	req.nodeId = nodeId
	req.eventId = eventId

	return self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2ShopRefreshReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Rouge2_MapModel.instance:updateMapInfo(msg.map)
end

function Rouge2_Rpc:sendRouge2SelectDropRequest(collectionPos, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2SelectDropRequest()

	if collectionPos then
		for _, pos in ipairs(collectionPos) do
			req.collectionPos:append(pos - 1)
		end
	end

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2SelectDropReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local map = msg.map

	Rouge2_MapModel.instance:updateMapInfo(map)
end

function Rouge2_Rpc:sendRouge2SelectLostCollectionRequest(collectionUid, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2SelectLostCollectionRequest()

	if collectionUid then
		for _, uid in ipairs(collectionUid) do
			req.collectionUid:append(uid)
		end
	end

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2SelectLostCollectionReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local map = msg.map

	Rouge2_MapModel.instance:updateMapInfo(map)
end

function Rouge2_Rpc:sendRouge2SelectUpdateCollectionRequest(collectionUid, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2SelectUpdateCollectionRequest()

	req.collectionUid = collectionUid

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2SelectUpdateCollectionReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local map = msg.map

	Rouge2_MapModel.instance:updateMapInfo(map)
end

function Rouge2_Rpc:sendRouge2GainCareer1RewardRequest(callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2GainCareer1RewardRequest()

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2GainCareer1RewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local rouge2Info = msg.rouge2Info

	Rouge2_Model.instance:updateRougeInfo(rouge2Info)
end

function Rouge2_Rpc:sendRouge2SelectBandMemberRequest(bandIdList, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2SelectBandMemberRequest()

	if bandIdList then
		for _, bandId in ipairs(bandIdList) do
			req.bandId:append(bandId)
		end
	end

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2SelectBandMemberReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local map = msg.map

	Rouge2_MapModel.instance:updateMapInfo(map)
end

function Rouge2_Rpc:sendRouge2RemoveBandMemberRequest(bandIdList, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2RemoveBandMemberRequest()

	if bandIdList then
		for _, bandId in ipairs(bandIdList) do
			req.bandId:append(bandId)
		end
	end

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2RemoveBandMemberReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local map = msg.map

	Rouge2_MapModel.instance:updateMapInfo(map)
end

function Rouge2_Rpc:sendRouge2EndBandRequest(callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2EndBandRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2EndBandReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local map = msg.map

	Rouge2_MapModel.instance:updateMapInfo(map)
end

function Rouge2_Rpc:sendRouge2PieceMoveRequest(layer, middleLayer, index, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2PieceMoveRequest()

	req.layer = layer
	req.middleLayer = middleLayer
	req.index = index

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2PieceMoveReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local map = msg.map

	Rouge2_MapModel.instance:updateMapInfo(map)
end

function Rouge2_Rpc:sendRouge2PieceTalkSelectRequest(layer, middleLayer, index, select, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2PieceTalkSelectRequest()

	req.layer = layer
	req.middleLayer = middleLayer
	req.index = index
	req.select = select

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2PieceTalkSelectReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local map = msg.map

	Rouge2_MapModel.instance:updateMapInfo(map)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onReceivePieceChoiceEvent)
end

function Rouge2_Rpc:sendRouge2LeaveMiddleLayerRequest(layer, middleLayer, nextLayer, nextWeatherId, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2LeaveMiddleLayerRequest()

	req.layer = layer
	req.middleLayer = middleLayer
	req.nextLayer = nextLayer
	req.nextWeatherId = nextWeatherId

	Rouge2_MapModel.instance:setWaitLeaveMiddleLayerReply(true)
	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2LeaveMiddleLayerReply(resultCode, msg)
	Rouge2_MapModel.instance:setWaitLeaveMiddleLayerReply(nil)

	if resultCode ~= 0 then
		return
	end

	local createEventMap = msg.createEventMap
	local finalMap = msg.finalMap

	Rouge2_MapModel.instance:updateMapInfo(createEventMap)
	Rouge2_MapModel.instance:setFinalMapInfo(finalMap)

	local curLayerId = Rouge2_MapModel.instance:getLayerId()
	local curWeatherMo = Rouge2_MapModel.instance:getCurMapWeatherInfo()
	local weatherId = curWeatherMo and curWeatherMo:getWeatherId()
	local weatherRuleIdList = curWeatherMo and curWeatherMo:getWeatherRuleIdList()
	local params = {
		layerId = curLayerId,
		weatherId = weatherId,
		weatherRuleIdList = weatherRuleIdList
	}

	ViewMgr.instance:openView(ViewName.Rouge2_NextLayerView, params)
end

function Rouge2_Rpc:sendRouge2EndRequest(callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2EndRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2EndReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local rouge2Info = msg.rouge2Info
	local resultInfo = msg.resultInfo

	Rouge2_Model.instance:updateRougeInfo(rouge2Info)
	Rouge2_Model.instance:updateResultInfo(resultInfo)
	Rouge2_TalentModel.instance:updateResultInfo(resultInfo)

	if not Rouge2_StatController.instance:checkIsReset() then
		Rouge2_StatController.instance:statEnd()
	else
		Rouge2_StatController.instance:statEnd(Rouge2_StatController.EndResult.Abort)
	end
end

function Rouge2_Rpc:sendRouge2AbortRequest(callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2AbortRequest()

	self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2AbortReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local rouge2Info = msg.rouge2Info

	Rouge2_Model.instance:updateRougeInfo(rouge2Info)
	Rouge2_Model.instance:onAbortRouge()
end

function Rouge2_Rpc:onReceiveRouge2LayerMapInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local map = msg.map

	Rouge2_MapModel.instance:updateMapInfo(map)
end

function Rouge2_Rpc:onReceiveRouge2UpdateCoinPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local coin = msg.coin
	local preCoin = Rouge2_Model.instance:getCoin()
	local updateNum = coin - preCoin

	if updateNum > 0 then
		local tips = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_getcointips"), updateNum)

		Rouge2_MapTipPopController.instance:addPopTip(tips)
	end

	Rouge2_Model.instance:getRougeInfo().coin = coin

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnUpdateRougeInfoCoin)
end

function Rouge2_Rpc:onReceiveRouge2UpdateRevivalCoinPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local revivalCoin = msg.revivalCoin
	local preRevivalCoin = Rouge2_Model.instance:getRevivalCoin()
	local updateNum = revivalCoin - preRevivalCoin

	if updateNum > 0 then
		local tips = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_getrevivalcointips"), updateNum)

		Rouge2_MapTipPopController.instance:addPopTip(tips)
	end

	Rouge2_Model.instance:updateRevivalCoin(revivalCoin)
end

function Rouge2_Rpc:onReceiveRouge2EntrustInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local entrustInfo = msg.entrustInfo

	Rouge2_MapModel.instance:updateEntrustInfo(entrustInfo)
end

function Rouge2_Rpc:onReceiveRouge2InfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local rouge2Info = msg.rouge2Info

	Rouge2_Model.instance:updateRougeInfo(rouge2Info)
end

function Rouge2_Rpc:sendRouge2MonsterFixAttrRequest(nodeId, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2MonsterFixAttrRequest()

	req.nodeId = nodeId

	return self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2MonsterFixAttrReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function Rouge2_Rpc:onReceiveRouge2AttrUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Rouge2_MapChoiceController.instance:addPushToFlow("Rouge2AttrUpdatePush", msg)
end

function Rouge2_Rpc:onReceiveRouge2BagItemRemovePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Rouge2_MapChoiceController.instance:addPushToFlow("Rouge2BagItemRemovePush", msg)
end

function Rouge2_Rpc:onReceiveRouge2BagItemUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Rouge2_MapChoiceController.instance:addPushToFlow("Rouge2BagItemUpdatePush", msg)
end

function Rouge2_Rpc:sendRouge2EndCheckRequest(callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2EndCheckRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2EndCheckReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Rouge2_MapModel.instance:updateMapInfo(msg.map)
end

function Rouge2_Rpc:sendRouge2ReRollCheckRequest(callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2ReRollCheckRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2ReRollCheckReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Rouge2_MapModel.instance:updateMapInfo(msg.map)
	Rouge2_StatController.instance:statDiceReRoll()
end

function Rouge2_Rpc:sendRouge2SummonerActiveTalentRequest(talentId, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2SummonerActiveTalentRequest()

	req.talentId = talentId

	return self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2SummonerActiveTalentReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Rouge2_Model.instance:updateRougeInfo(msg.rouge2Info)
end

function Rouge2_Rpc:sendRouge2SummonerResetTalentRequest(stage, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2SummonerResetTalentRequest()

	req.stage = stage

	return self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2SummonerResetTalentReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Rouge2_Model.instance:updateRougeInfo(msg.rouge2Info)
end

function Rouge2_Rpc:sendRouge2SetSystemIdRequest(systemId, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2SetSystemIdRequest()

	req.systemId = systemId

	return self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2SetSystemIdReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Rouge2_Model.instance:updateCurTeamSystemId(msg.systemId)
end

function Rouge2_Rpc:sendRouge2GainCareerAttrDropRequest(attrId, callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2GainCareerAttrDropRequest()

	req.attrId = attrId

	return self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2GainCareerAttrDropReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local rouge2Info = msg.rouge2Info

	Rouge2_Model.instance:updateRougeInfo(rouge2Info)
end

function Rouge2_Rpc:sendRouge2RefreshDropRequest(callback, callbackObj)
	local req = Rouge2Module_pb.Rouge2RefreshDropRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function Rouge2_Rpc:onReceiveRouge2RefreshDropReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Rouge2_MapModel.instance:updateMapInfo(msg.map)
end

Rouge2_Rpc.instance = Rouge2_Rpc.New()

return Rouge2_Rpc
