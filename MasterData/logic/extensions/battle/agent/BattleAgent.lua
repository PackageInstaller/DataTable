-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/agent/BattleAgent.lua

module("logic.extensions.battle.agent.BattleAgent", package.seeall)

local BattleAgent = class("BattleAgent", BaseAgent)

function BattleAgent:ctor()
	BattleAgent.super.ctor(self)

	self._endType = false
end

function BattleAgent:reset()
	return
end

function BattleAgent:sendEndReadyRequest()
	local req = BattleExtension_pb.EndReadyRequest()

	self:sendMsg(req)
end

function BattleAgent:handleEndReadyReply(status, msg)
	return
end

function BattleAgent:sendCancelReadyRequest()
	local req = BattleExtension_pb.CancelReadyRequest()

	self:sendMsg(req)
end

function BattleAgent:handleCancelReadyReply(status, msg)
	return
end

function BattleAgent:handleBattleStartPush(status, msg)
	if status == 0 then
		BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_END_READY, true)
	else
		BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_END_READY, false)
	end
end

function BattleAgent:sendPlaceEntityRequest(heroId, unionIndex)
	local req = BattleExtension_pb.PlaceEntityRequest()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)
	local placeEntityNO = BattleExtension_pb.PlaceEntityNO()

	placeEntityNO.entity = heroId
	placeEntityNO.cell.x = x
	placeEntityNO.cell.z = z

	table.insert(req.placeEntities, placeEntityNO)
	self:sendMsg(req)
end

function BattleAgent:sendPlaceEntityRequestBatch(heroIdList, unionIndexList)
	local req = BattleExtension_pb.PlaceEntityRequest()

	for i, heroId in ipairs(heroIdList) do
		local unionIndex = unionIndexList[i]
		local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)
		local placeEntityNO = BattleExtension_pb.PlaceEntityNO()

		placeEntityNO.entity = heroId
		placeEntityNO.cell.x = x
		placeEntityNO.cell.z = z

		table.insert(req.placeEntities, placeEntityNO)
	end

	self:sendMsg(req)
end

function BattleAgent:handlePlaceEntityReply(status, msg)
	if status == 0 then
		BattleDispatcher:dispatchEvent(BattleEventType.OnPlaceEntityEnd)
	end
end

function BattleAgent:sendRemoveEntityRequest(entityId)
	local req = BattleExtension_pb.RemoveEntityRequest()

	req.entity = entityId

	self:sendMsg(req)
end

function BattleAgent:handleRemoveEntityReply(status, msg)
	if status == 0 then
		BattleDispatcher:dispatchEvent(BattleEventType.OnRemoveEntityEnd)
	end
end

function BattleAgent:sendMoveEntityRequest(entityId, unionIndex)
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)
	local req = BattleExtension_pb.MoveEntityRequest()

	req.entity = entityId
	req.cell.x = x
	req.cell.z = z

	self:sendMsg(req)
end

function BattleAgent:handleMoveEntityReply(status, msg)
	if status == 0 then
		BattleDispatcher:dispatchEvent(BattleEventType.OnMoveEntityEnd)
	end
end

function BattleAgent:sendPostEventAnimationRequest()
	local req = BattleExtension_pb.PostEventAnimationRequest()

	self:sendMsg(req)
end

function BattleAgent:handlePostEventAnimationReply(status, msg)
	return
end

function BattleAgent:handleAnimationPostedPush(status, msg)
	if status == 0 then
		BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_NEXT_OPERATE)
	end
end

function BattleAgent:sendStepRequest(entityId, pathUnionIndexs, skillId, targetUnionIndex, transportUnionIndex, isStrenthening, lookAtDirection)
	local req = BattleExtension_pb.StepRequest()

	self:setupStepRequest(req, entityId, pathUnionIndexs, skillId, targetUnionIndex, transportUnionIndex, isStrenthening, lookAtDirection)
	self:sendMsg(req)
end

function BattleAgent:setupStepRequest(req, entityId, pathUnionIndexs, skillId, targetUnionIndex, transportUnionIndex, isStrenthening, lookAtDirection)
	req.entity = entityId
	req.strengthening = isStrenthening and true or false

	if targetUnionIndex and skillId then
		req.releasingSkill = skillId
	end

	if pathUnionIndexs then
		for _, pathUnionIndex in pairs(pathUnionIndexs) do
			local x, z = BoardIndexConverter.unionIndexToCoordinates(pathUnionIndex)
			local cellNO = BattleExtension_pb.CellNO()

			cellNO.x = x
			cellNO.z = z

			table.insert(req.movement, cellNO)
		end
	end

	if targetUnionIndex then
		local targetX, targetZ = BoardIndexConverter.unionIndexToCoordinates(targetUnionIndex)
		local targetCellNO = req.target

		targetCellNO.x = targetX
		targetCellNO.z = targetZ
	end

	if transportUnionIndex then
		local transportX, transportZ = BoardIndexConverter.unionIndexToCoordinates(transportUnionIndex)
		local positionCellNO = req.position

		positionCellNO.x = transportX
		positionCellNO.z = transportZ
	end

	if lookAtDirection then
		local lookAtCellNO = req.lookAt

		lookAtCellNO.x = checkint(lookAtDirection:getX())
		lookAtCellNO.z = checkint(lookAtDirection:getZ())
	end
end

function BattleAgent:handleStepReply(status, msg)
	return
end

function BattleAgent:sendForecastRequest(entityId, pathUnionIndexs, skillId, targetUnionIndex, transportUnionIndex, isStrenthening, lookAtDirection)
	local req = BattleExtension_pb.ForecastRequest()

	self:setupStepRequest(req.step, entityId, pathUnionIndexs, skillId, targetUnionIndex, transportUnionIndex, isStrenthening, lookAtDirection)
	self:sendMsg(req)
end

function BattleAgent:handleForecastReply(status, msg)
	return
end

function BattleAgent:handleResultForecastPush(status, msg)
	if BattleLog.enableServerLog then
		BattleLog.logServer(string.format("ResultForecastPush:%s", msg))
	end

	BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_FORECAST_PUSH, msg)
end

function BattleAgent:sendForecastAiRequest()
	local req = BattleExtension_pb.ForecastAiRequest()

	self:sendMsg(req)
end

function BattleAgent:handleForecastAiReply(status, msg)
	return
end

function BattleAgent:handleResultForecastAiPush(status, msg)
	if BattleLog.enableServerLog then
		BattleLog.logServer(string.format("ResultForecastAiPush:%s", msg))
	end

	BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_AI_FORECAST_PUSH, msg)
end

function BattleAgent:sendEndStageRequest()
	local req = BattleExtension_pb.EndStageRequest()

	self:sendMsg(req)
end

function BattleAgent:handleEndStageReply(status, msg)
	return
end

function BattleAgent:sendSurrenderRequest(endType)
	BattleDispatcher:dispatchEvent(BattleEventType.OnFailTimesUpdate)

	self._endType = endType and endType or BattleExtension_pb.EndType.SURRENDER

	local req = BattleExtension_pb.SurrenderRequest()

	req.type = self._endType

	self:sendMsg(req)

	local cmdExecuter = BattleMgr.instance:getCmdExecuter()

	cmdExecuter:setPause(true, BattleConst.DefaultStateKey)
end

function BattleAgent:handleSurrenderReply(status, msg)
	if BattleLog.enableServerLog then
		BattleLog.logServer(string.format("SurrenderReply:%s", msg))
	end

	local cmdExecuter = BattleMgr.instance:getCmdExecuter()

	if status == 0 and self._endType == BattleExtension_pb.EndType.SURRENDER then
		local model = BattleMgr.instance:getModel()
		local resultMO = model:getResultMO()

		resultMO:setSurrender(true)
		cmdExecuter:clearCommands()

		local battleNetMgr = BattleMgr.instance:getNetEventMgr()

		battleNetMgr:clearNetEvents()
	end

	BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_SURRENDER_REPLY, self._endType)
	cmdExecuter:setPause(false, BattleConst.DefaultStateKey)
end

function BattleAgent:sendConnectRequest()
	local req = BattleExtension_pb.ConnectRequest()

	self:sendMsg(req)
end

function BattleAgent:handleConnectReply(status, msg)
	if BattleLog.enableServerLog then
		BattleLog.logServer(string.format("connectReply:%s", msg))
	end

	local battleType = msg.info.type

	if battleType == BattleExtension_pb.GameType.FOOTBALLPVP then
		TimeLimitActivityModel.instance:addReleaseBattleInfo(msg.info)
		TimeLimitActivityModel.instance:startBattle(BattleExtension_pb.GameType.FOOTBALLPVP)
	else
		printError("unhandle battle type")
	end
end

function BattleAgent:sendDisconnectRequest()
	local req = BattleExtension_pb.DisconnectRequest()

	self:sendMsg(req)
end

function BattleAgent:handleDisconnectReply(status, msg)
	if status == 0 then
		BattleMgr.instance:exit()
	end
end

function BattleAgent:sendConnectCompleteRequest()
	local req = BattleExtension_pb.ConnectCompleteRequest()

	self:sendMsg(req)
end

function BattleAgent:handleConnectCompleteReply(status, msg)
	return
end

function BattleAgent:handleReadyStartPush(status, msg)
	BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_ALL_USER_ENTER_DONE)
end

function BattleAgent:handleConnectStateChangePush(status, msg)
	if BattleLog.enableServerLog then
		BattleLog.logServer(string.format("ConnectStateChangePush:%s", msg))
	end

	BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_USER_NET_STATE_CHANGED, msg)
end

function BattleAgent:sendSetAiControlledRequest(isAuto)
	local req = BattleExtension_pb.SetAiControlledRequest()

	req.aiControlled = isAuto

	self:sendMsg(req)
end

function BattleAgent:handleSetAiControlledReply(status, msg)
	return
end

function BattleAgent:handleOnEventTriggeredPush(status, msg)
	if BattleLog.enableServerLog then
		BattleLog.logServer(string.format("EventTriggeredPush:%s", msg))
	end

	BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_NET_EVENT, msg.events)
end

function BattleAgent:handleLogBattleLogPush(status, msg)
	if enableLog then
		for _, log in ipairs(msg.log) do
			printInfo("ServerBattleLog::", log)
		end
	end
end

function BattleAgent:handleUnfinishedBattlePush(status, msg)
	local battleInfo = msg.battleInfo
	local canReconnect = msg.canReconnect

	BattleReconnectController.instance:setUnfinishedBattleInfo(battleInfo, canReconnect)
end

function BattleAgent:handleUnfinishedBattleExpiredPush(status, msg)
	BattleReconnectController.instance:setUnfinishedBattleExpired()
end

function BattleAgent:sendDeleteUnfinishedBattleRequest()
	local req = BattleExtension_pb.DeleteUnfinishedBattleRequest()

	self:sendMsg(req)
end

function BattleAgent:handleDeleteUnfinishedBattleReply(status, msg)
	if BattleLog.enableLog then
		BattleLog.log("handleDeleteUnfinishedBattleReply:", status)
	end
end

function BattleAgent:sendReconnectBattleRequest()
	local req = BattleExtension_pb.ReconnectBattleRequest()

	self:sendMsg(req)
end

function BattleAgent:handleReconnectBattleReply(status, msg)
	if status == 0 then
		BattleEnterUtil.enterBattle(msg.battleInfo, BattleEnum.Mode.RECONNECT)
	elseif BattleLog.enableError then
		BattleLog.error(string.format("reconnect battle failed:%s", status))
	end
end

function BattleAgent:sendBackToRequest(round, step)
	local req = BattleExtension_pb.BackToRequest()

	req.round = round
	req.step = step

	self:sendMsg(req)
end

function BattleAgent:handleBackToReply(status, msg)
	if status == 0 then
		BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_BACK_TO, true)
	else
		if BattleLog.enableError then
			BattleLog.error(string.format("back to step failed:%s", status))
		end

		BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_BACK_TO, false)
	end
end

function BattleAgent:sendGetBackInfoRequest(round, step, isForUndo)
	local req = BattleExtension_pb.GetBackInfoRequest()

	req.round = round
	req.step = step

	self:sendMsg(req)
end

function BattleAgent:handleGetBackInfoReply(status, msg)
	if status == 0 then
		BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_GET_BACK_INFO, msg)
	else
		BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_GET_BACK_INFO, false)

		if BattleLog.enableError then
			BattleLog.error(string.format("get back info failed:%s", status))
		end
	end
end

BattleAgent.instance = BattleAgent.New()

return BattleAgent
