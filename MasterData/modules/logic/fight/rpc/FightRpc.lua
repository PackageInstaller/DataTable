-- chunkname: @modules/logic/fight/rpc/FightRpc.lua

module("modules.logic.fight.rpc.FightRpc", package.seeall)

local FightRpc = class("FightRpc", BaseRpc)

function FightRpc:sendBeginFightRequest(heroList, subHeroList)
	local req = FightModule_pb.BeginFightRequest()

	for _, hero in ipairs(heroList) do
		table.insert(req.heroList, hero)
	end

	if subHeroList then
		for _, subHero in ipairs(subHeroList) do
			table.insert(req.subHeroList, subHero)
		end
	end

	self:sendMsg(req)
end

function FightRpc:onReceiveBeginFightReply(resultCode, msg)
	if resultCode == 0 then
		local fightData = FightData.New(msg.fight)

		FightMgr.instance:startFight(fightData)
		FightModel.instance:updateFight(fightData)
		FightModel.instance:updateFightRound(msg.round)
		FightController.instance:dispatchEvent(FightEvent.RespBeginFight)
	else
		FightModel.instance:setFightParam(nil)
		FightController.instance:dispatchEvent(FightEvent.RespBeginFightFail)
	end
end

function FightRpc:sendTestFightRequest(fightParam, groupIds, fightType)
	local req = FightModule_pb.TestFightRequest()

	fightParam:setReqFightGroup(req)

	for _, groupId in ipairs(groupIds) do
		table.insert(req.groupIds, groupId)
	end

	req.fightActType = fightType or FightEnum.FightActType.Normal

	self:sendMsg(req)
end

function FightRpc:onReceiveTestFightReply(resultCode, msg)
	if resultCode == 0 then
		if isDebugBuild then
			FightPlayBackController.instance:startRecordFightData(msg)
		end

		local fightData = FightData.New(msg.fight)

		FightMgr.instance:startFight(fightData)
		FightModel.instance:updateFight(fightData)
		FightModel.instance:refreshBattleId(fightData)
		FightModel.instance:updateFightRound(msg.round)
		FightController.instance:dispatchEvent(FightEvent.RespBeginFight)
	else
		FightController.instance:dispatchEvent(FightEvent.RespBeginFightFail)
	end
end

function FightRpc:sendTestFightIdRequest(fightParam)
	local req = FightModule_pb.TestFightIdRequest()

	fightParam:setReqFightGroup(req)

	req.fightId = fightParam.battleId
	req.fightActType = fightParam.fightActType or FightEnum.FightActType.Normal

	self:sendMsg(req)
end

function FightRpc:onReceiveTestFightIdReply(resultCode, msg)
	if resultCode == 0 then
		if isDebugBuild then
			FightPlayBackController.instance:startRecordFightData(msg)
		end

		local fightData = FightData.New(msg.fight)

		FightMgr.instance:startFight(fightData)
		FightModel.instance:updateFight(fightData)
		FightModel.instance:updateFightRound(msg.round)
		FightController.instance:dispatchEvent(FightEvent.RespBeginFight)
	else
		FightController.instance:dispatchEvent(FightEvent.RespBeginFightFail)
	end
end

function FightRpc:sendResetRoundRequest()
	local req = FightModule_pb.ResetRoundRequest()

	self:sendMsg(req)
end

function FightRpc:onReceiveResetRoundReply(resultCode, msg)
	if resultCode == 0 then
		local oldCardOps = FightDataHelper.operationDataMgr:getOpList()

		FightMgr.instance:cancelOperation()
		FightController.instance:dispatchEvent(FightEvent.ResetCard, oldCardOps)
	end
end

function FightRpc:sendBeginRoundRequest(beginRoundOps)
	if isDebugBuild then
		FightPlayBackController.instance:recordRoundOp(beginRoundOps)
	end

	local list = self:buildBeginRoundOper(beginRoundOps)

	self._beginRoundOps = beginRoundOps

	local req = FightModule_pb.BeginRoundRequest()

	tabletool.addValues(req.opers, list)

	local deviceArea = FightDataHelper.getDeviceArea()

	if deviceArea then
		deviceArea:applyClientChange()

		for _, deviceInfo in ipairs(deviceArea:getServerDeviceList()) do
			local op = FightDef_pb.FightDeviceOper()

			op.index = deviceInfo.index
			op.uid = deviceInfo.uid

			table.insert(req.devicesOpers, op)
		end
	end

	self:sendMsg(req)
end

function FightRpc:buildBeginRoundOper(operationList)
	operationList = tabletool.copy(operationList)

	for i = #operationList, 1, -1 do
		local operation = operationList[i]

		if operation:isSimulateDissolveCard() then
			table.remove(operationList, i)
		end
	end

	local list = {}

	for _, op in ipairs(operationList) do
		self:insertOp(op, list)
	end

	return list
end

function FightRpc:insertOp(op, opList)
	if op:isRouge2MusicSkill() then
		return
	end

	local oper = FightDef_pb.BeginRoundOper()

	oper.operType = op.operType

	if op.toId then
		oper.toId = op.toId
	end

	oper.param1 = op.param1

	if op.param2 then
		oper.param2 = op.param2
	end

	if op.param3 then
		oper.param3 = op.param3
	end

	if op.cardParam1 then
		oper.cardParam1 = op.cardParam1
	end

	table.insert(opList, oper)
end

function FightRpc:onReceiveBeginRoundReply(resultCode, msg)
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.FightStateType.sendOperation2Server)
	FightDataHelper.paTaMgr:resetOp()

	if resultCode == 0 then
		if msg:HasField("round") then
			if isDebugBuild then
				FightPlayBackController.instance:recordRoundReply(msg)
			end

			self._beginRoundOps = nil

			FightModel.instance:updateFightRound(msg.round)
			FightGameMgr.playMgr:playShow()
			FightController.instance:dispatchEvent(FightEvent.RespBeginRound)
		else
			FightRpc.instance:sendEndFightRequest(false)
		end
	else
		if not FightModel.instance:isFinish() then
			GameFacade.showMessageBox(MessageBoxIdDefine.FightException, MsgBoxEnum.BoxType.Yes_No, function()
				if self._beginRoundOps then
					FightRpc.instance:sendBeginRoundRequest(self._beginRoundOps)
				else
					logError("回合操作步骤不存在")
				end
			end)
		end

		FightController.instance:dispatchEvent(FightEvent.RespBeginRoundFail)
	end

	if canLogNormal and isDebugBuild then
		local colorTagStart = resultCode == 0 and "" or "<color=#FFA500>"
		local colorTagEnd = resultCode == 0 and "" or "</color>"

		logNormal(string.format("%s<== Recv Msg, cmd:%d %s resultCode:%d%s\n%s", colorTagStart, 13744, "BeginRoundReply", resultCode, colorTagEnd, tostring(msg)))
	end
end

function FightRpc:sendChangeSubHeroRequest(subHeroId, changeHeroId)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero)

	local req = FightModule_pb.ChangeSubHeroRequest()

	req.subHeroId = subHeroId
	req.changeHeroId = changeHeroId

	self:sendMsg(req)
end

function FightRpc:onReceiveChangeSubHeroReply(resultCode, msg)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero)
	FightController.instance:dispatchEvent(FightEvent.ReceiveChangeSubHeroReply, resultCode)

	if resultCode == 0 and msg:HasField("round") then
		FightModel.instance:updateFightRound(msg.round)
		FightGameMgr.playMgr:playShow()
		FightController.instance:dispatchEvent(FightEvent.RespBeginRound)
	end
end

function FightRpc:sendChangeSubHeroExSkillRequest(exSkillTarget)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero)

	local req = FightModule_pb.ChangeSubHeroExSkillRequest()

	req.exSkillTarget = exSkillTarget

	self:sendMsg(req)
end

function FightRpc:onReceiveChangeSubHeroExSkillReply(resultCode, msg)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero)
	FightController.instance:dispatchEvent(FightEvent.ChangeSubHeroExSkillReply, resultCode)

	if resultCode == 0 and msg:HasField("round") then
		FightModel.instance:updateFightRound(msg.round)
		FightGameMgr.playMgr:playShow()
		FightController.instance:dispatchEvent(FightEvent.RespBeginRound)
	end
end

function FightRpc:sendReconnectFightRequest(callback, callbackObj)
	local req = FightModule_pb.ReconnectFightRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function FightRpc:onReceiveReconnectFightReply(resultCode, msg)
	if resultCode == 0 then
		FightModel.instance.needFightReconnect = msg:HasField("fight")

		if FightModel.instance.needFightReconnect then
			if isDebugBuild then
				FightPlayBackController.instance:startRecordReconnectFightData(msg)
			end

			local fightData = FightData.New(msg.fight)

			if fightData.version < 1 and msg.fightReason.type == FightEnum.FightReason.DungeonRecord then
				fightData.isRecord = true
			end

			FightMgr.instance:startFight(fightData)
			FightModel.instance:updateFight(fightData)
			FightModel.instance:updateFightRound(msg.lastRound)
			FightModel.instance:updateFightReason(msg.fightReason)
			FightModel.instance:recordFightGroup(msg.fightGroup)
		end

		FightController.instance:dispatchEvent(FightEvent.RespReconnectFight)
	end
end

function FightRpc:onReceiveCardInfoPush(resultCode, msg)
	FightLocalDataMgr.instance.handCardMgr:updateHandCardByProto(msg.cardGroup)
	FightLocalDataMgr.instance.operationDataMgr:dealCardInfoPush(msg)

	self._lastCardInfoPushMsg = msg

	if msg.isGm then
		self:dealCardInfoPushData()
	end
end

function FightRpc:dealCardInfoPushData()
	if self._lastCardInfoPushMsg then
		FightDataMgr.instance.handCardMgr:updateHandCardByProto(self._lastCardInfoPushMsg.cardGroup)
		FightDataMgr.instance.operationDataMgr:dealCardInfoPush(self._lastCardInfoPushMsg)
		FightController.instance:dispatchEvent(FightEvent.PushCardInfo)

		self._lastCardInfoPushMsg = nil
	end
end

function FightRpc:onReceiveTeamInfoPush(resultCode, msg)
	local isFightScene = GameSceneMgr.instance:getCurSceneType() == SceneType.Fight
	local entityMgr = FightGameMgr.entityMgr
	local fightData = FightData.New(msg.fight)

	FightLocalDataMgr.instance:updateFightData(fightData)
	FightDataMgr.instance:updateFightData(fightData)

	if isFightScene then
		entityMgr:compareUpdate(fightData)
	else
		FightModel.instance:updateFight(fightData)
	end

	FightController.instance:dispatchEvent(FightEvent.PushTeamInfo)
end

function FightRpc:sendEndFightRequest(isAbort)
	if isDebugBuild and GMBattleModel.instance.enableGMFightRecord then
		FightRpc.instance:sendGetFightRecordAllRequest()
	end

	local req = FightModule_pb.EndFightRequest()

	req.isAbort = isAbort

	self:sendMsg(req)
	FightController.instance:dispatchEvent(FightEvent.OnReqEndFight)
end

function FightRpc:onReceiveEndFightReply(resultCode, msg)
	if resultCode == 0 then
		FightController.instance:dispatchEvent(FightEvent.RespEndFight)
	else
		FightController.instance:dispatchEvent(FightEvent.RespEndFightFail)
		FightController.instance:errorAndEnterMainScene()
	end
end

function FightRpc:onReceiveEndFightPush(resultCode, msg)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	FightDataHelper.lastFightResult = msg.record.fightResult
	FightModel.instance.needFightReconnect = false

	FightModel.instance:updateRecord(msg.record)
	FightModel.instance:updateMySide(msg.fightGroupA)
	FightModel.instance:recordFightGroup(msg.fightGroupA)
	FightModel.instance:onEndFight()
	FightModel.instance:recordPassModel(msg)
	FightController.instance:dispatchEvent(FightEvent.PushEndFight, msg)
end

function FightRpc:onReceiveFightWavePush(resultCode, msg)
	if resultCode == 0 then
		local fightData = FightData.New(msg.fight)

		FightDataHelper.cacheFightWavePush(fightData)
	end

	FightModel.instance:setNextWaveMsg(msg)
	FightController.instance:dispatchEvent(FightEvent.PushFightWave)
end

function FightRpc:sendUseClothSkillRequest(skillId, fromId, toId, type)
	if isDebugBuild then
		FightPlayBackController.instance:recordUseClothSkillRequest(skillId)
	end

	if type == FightEnum.ClothSkillType.Contract then
		FightModel.instance:setNotifyContractInfo(nil, nil)
	end

	local req = FightModule_pb.UseClothSkillRequest()

	req.skillId = skillId

	if fromId then
		req.fromId = fromId
	end

	if toId then
		req.toId = toId
	end

	req.type = type or FightEnum.ClothSkillType.ClothSkill

	self:sendMsg(req)
end

function FightRpc:onReceiveUseClothSkillReply(resultCode, msg)
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.FightStateType.sendOperation2Server)

	if resultCode == 0 then
		if isDebugBuild then
			FightPlayBackController.instance:recordUseClothSkillReply(msg)
		end

		FightModel.instance:updateClothSkillRound(msg.round)
		FightGameMgr.playMgr:playCloth()
	else
		FightController.instance:dispatchEvent(FightEvent.RespUseClothSkillFail)
		FightMsgMgr.sendMsg(FightMsgId.UseClothSkillReplyFail)
	end
end

function FightRpc:sendAutoRoundRequest(opers)
	local list = self:buildBeginRoundOper(opers)
	local req = FightModule_pb.AutoRoundRequest()

	tabletool.addValues(req.opers, list)

	local curSelectEntityId = FightDataHelper.operationDataMgr.curSelectEntityId

	req.toId = curSelectEntityId == 0 and "0" or curSelectEntityId

	self:sendMsg(req)
end

function FightRpc:onReceiveAutoRoundReply(resultCode, msg)
	if resultCode == 0 then
		FightMsgMgr.sendMsg(FightMsgId.AutoRoundReply, msg)
	else
		FightMsgMgr.sendMsg(FightMsgId.AutoRoundReplyFail)
	end
end

function FightRpc:onReceiveRedealCardInfoPush(resultCode, msg)
	if resultCode == 0 then
		FightLocalDataMgr.instance.handCardMgr:cacheRedealCard(msg)
		FightDataMgr.instance.handCardMgr:cacheRedealCard(msg)
		FightController.instance:dispatchEvent(FightEvent.PushRedealCardInfo)
	end
end

function FightRpc:sendGetFightOperRequest()
	local req = FightModule_pb.GetFightOperRequest()

	self:sendMsg(req)
end

function FightRpc:onReceiveGetFightOperReply(resultCode, msg)
	if resultCode == 0 then
		FightReplayModel.instance:onReceiveGetFightOperReply(msg)
		FightController.instance:dispatchEvent(FightEvent.RespGetFightOperReplay)
	else
		FightController.instance:dispatchEvent(FightEvent.RespGetFightOperReplayFail)
	end
end

function FightRpc:sendGetFightRecordGroupRequest(episodeId)
	local req = FightModule_pb.GetFightRecordGroupRequest()

	req.episodeId = episodeId

	self:sendMsg(req)
end

function FightRpc:onReceiveGetFightRecordGroupReply(resultCode, msg)
	if resultCode == 0 then
		local heroGroupMO = HeroGroupMO.New()

		heroGroupMO:initByFightGroup(msg.fightGroup)
		FightController.instance:dispatchEvent(FightEvent.RespGetFightRecordGroupReply, heroGroupMO)
	end
end

function FightRpc:sendEntityInfoRequest(entityId)
	local req = FightModule_pb.EntityInfoRequest()

	req.uid = entityId

	self:sendMsg(req)
end

function FightRpc:onReceiveEntityInfoReply(resultCode, msg)
	if resultCode == 0 then
		FightController.instance:dispatchEvent(FightEvent.onReceiveEntityInfoReply, msg)
	end

	FightController.instance:dispatchEvent(FightEvent.CountEntityInfoReply, resultCode, msg)
end

function FightRpc:sendGetEntityDetailInfosRequest()
	local req = FightModule_pb.GetEntityDetailInfosRequest()

	self:sendMsg(req)
end

function FightRpc:onReceiveGetEntityDetailInfosReply(resultCode, msg)
	if resultCode == 0 then
		GMFightEntityModel.instance:onGetEntityDetailInfos(msg)
		GMController.instance:dispatchEvent(GMFightEntityView.Evt_OnGetEntityDetailInfos)
	end
end

function FightRpc:sendGetGMFightTeamDetailInfosRequest(callback, callbackObj)
	local req = FightModule_pb.GetGMFightTeamDetailInfosRequest()

	self:sendMsg(req, callback, callbackObj)
end

function FightRpc:onReceiveGetGMFightTeamDetailInfosReply(resultCode, msg)
	if resultCode == 0 then
		GMFightEntityModel.instance:onGetGMFightTeamDetailInfos(msg)
		FightController.instance:dispatchEvent(FightEvent.OnReceiveGmFightTeamDetailInfo)
	end
end

function FightRpc:sendGetFightRecordAllRequest()
	local req = FightModule_pb.GetFightRecordAllRequest()

	self:sendMsg(req)
end

function FightRpc:onReceiveGetFightRecordAllReply(resultCode, msg)
	if resultCode == 0 then
		GMBattleModel.instance:setGMFightRecord(msg)
		FightController.instance:dispatchEvent(FightEvent.OnGMFightWithRecordAllReply)
	end
end

function FightRpc:sendFightWithRecordAllRequest(req)
	self:sendMsg(req)
end

function FightRpc:onReceiveFightWithRecordAllReply(resultCode, msg)
	if resultCode == 0 then
		FightRpc.instance:onReceiveTestFightReply(resultCode, msg)
	end
end

FightRpc.DeckInfoRequestType = {
	MySide = 0,
	EnemySide = 1
}

function FightRpc:sendGetFightCardDeckInfoRequest(requestType)
	local req = FightModule_pb.GetFightCardDeckInfoRequest()

	req.type = requestType or FightRpc.DeckInfoRequestType.MySide

	self:sendMsg(req)
end

function FightRpc:onReceiveGetFightCardDeckInfoReply(resultCode, msg)
	if resultCode == 0 then
		FightController.instance:dispatchEvent(FightEvent.GetFightCardDeckInfoReply, msg)
	end
end

function FightRpc:sendGetFightCardDeckDetailInfoRequest(requestType)
	local req = FightModule_pb.GetFightCardDeckDetailInfoRequest()

	req.type = requestType or FightRpc.DeckInfoRequestType.MySide

	self:sendMsg(req)
end

function FightRpc:onReceiveGetFightCardDeckDetailInfoReply(resultCode, msg)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.FightCardDeckGMView, msg)
	end
end

function FightRpc:onReceiveAct174FightRoundInfo(resultCode, msg)
	FightMgr.instance:playGMDouQuQu(msg)
end

FightRpc.instance = FightRpc.New()

return FightRpc
