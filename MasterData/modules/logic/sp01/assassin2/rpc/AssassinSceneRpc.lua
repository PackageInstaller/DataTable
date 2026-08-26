-- chunkname: @modules/logic/sp01/assassin2/rpc/AssassinSceneRpc.lua

module("modules.logic.sp01.assassin2.rpc.AssassinSceneRpc", package.seeall)

local AssassinSceneRpc = class("AssassinSceneRpc", BaseRpc)

function AssassinSceneRpc:sendEnterAssassinSceneRequest(questId, heroIdList, cb, cbObj)
	local req = AssassinSceneModule_pb.EnterAssassinSceneRequest()

	req.questId = questId

	for _, heroId in ipairs(heroIdList) do
		table.insert(req.heroIds, heroId)
	end

	self:sendMsg(req, cb, cbObj)
end

function AssassinSceneRpc:onReceiveEnterAssassinSceneReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinSceneRpc:sendHeroMoveRequest(uid, actId, param, cb, cbObj)
	local req = AssassinSceneModule_pb.HeroMoveRequest()

	req.uid = uid
	req.actId = actId
	req.param = param

	self:sendMsg(req, cb, cbObj)
end

function AssassinSceneRpc:onReceiveHeroMoveReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinSceneRpc:sendHeroAttackRequest(uid, actId, targetId, cb, cbObj)
	local req = AssassinSceneModule_pb.HeroAttackRequest()

	req.uid = uid
	req.actId = actId
	req.targetId = targetId

	self:sendMsg(req, cb, cbObj)
end

function AssassinSceneRpc:onReceiveHeroAttackReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinSceneRpc:sendHeroAssassinRequest(uid, actId, param, cb, cbObj)
	local req = AssassinSceneModule_pb.HeroAssassinRequest()

	req.uid = uid
	req.actId = actId
	req.param = param

	self:sendMsg(req, cb, cbObj)
end

function AssassinSceneRpc:onReceiveHeroAssassinReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinSceneRpc:sendHeroInteractiveRequest(uid, interactiveId, cb, cbObj)
	local req = AssassinSceneModule_pb.HeroInteractiveRequest()

	req.uid = uid
	req.interactiveId = interactiveId

	self:sendMsg(req, cb, cbObj)
end

function AssassinSceneRpc:onReceiveHeroInteractiveReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinSceneRpc:sendFinishUserTurnRequest(round, cb, cbObj)
	local req = AssassinSceneModule_pb.FinishUserTurnRequest()

	req.round = round

	self:sendMsg(req, cb, cbObj)
end

function AssassinSceneRpc:onReceiveFinishUserTurnReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinSceneRpc:sendNextRoundRequest(round, cb, cbObj)
	local req = AssassinSceneModule_pb.NextRoundRequest()

	req.round = round

	self:sendMsg(req, cb, cbObj)
end

function AssassinSceneRpc:onReceiveNextRoundReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinSceneRpc:sendFinishMissionRequest(missionId, cb, cbObj)
	local req = AssassinSceneModule_pb.FinishMissionRequest()

	req.missionId = missionId

	self:sendMsg(req, cb, cbObj)
end

function AssassinSceneRpc:onReceiveFinishMissionReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinSceneRpc:sendReturnAssassinSceneRequest(mapId, cb, cbObj)
	local req = AssassinSceneModule_pb.ReturnAssassinSceneRequest()

	req.mapId = mapId

	self:sendMsg(req, cb, cbObj)
end

function AssassinSceneRpc:onReceiveReturnAssassinSceneReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinSceneRpc:sendRecoverSceneRequest(mapId, cb, cbObj)
	local req = AssassinSceneModule_pb.RecoverSceneRequest()

	req.mapId = mapId

	self:sendMsg(req, cb, cbObj)
end

function AssassinSceneRpc:onReceiveRecoverSceneReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinSceneRpc:sendUseAssassinItemRequest(heroUid, itemId, targetId, cb, cbObj)
	local req = AssassinSceneModule_pb.UseAssassinItemRequest()

	req.uid = heroUid
	req.itemId = itemId
	req.targetId = targetId

	self:sendMsg(req, cb, cbObj)
end

function AssassinSceneRpc:onReceiveUseAssassinItemReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinSceneRpc:sendAssassinUseSkillRequest(heroUid, targetId, cb, cbObj)
	local req = AssassinSceneModule_pb.AssassinUseSkillRequest()

	req.uid = heroUid
	req.targetId = targetId

	self:sendMsg(req, cb, cbObj)
end

function AssassinSceneRpc:onReceiveAssassinUseSkillReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinSceneRpc:sendRestartAssassinSceneRequest(mapId, cb, cbObj)
	local req = AssassinSceneModule_pb.RestartAssassinSceneRequest()

	req.mapId = mapId

	self:sendMsg(req, cb, cbObj)
end

function AssassinSceneRpc:onReceiveRestartAssassinSceneReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinSceneRpc:sendGiveUpAssassinSceneRequest(mapId, cb, cbObj)
	local req = AssassinSceneModule_pb.GiveUpAssassinSceneRequest()

	req.mapId = mapId

	self:sendMsg(req, cb, cbObj)
end

function AssassinSceneRpc:onReceiveGiveUpAssassinSceneReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinSceneRpc:sendAssassinChangeMapRequest(mapId, cb, cbObj)
	local req = AssassinSceneModule_pb.AssassinChangeMapRequest()

	req.mapId = mapId

	self:sendMsg(req, cb, cbObj)
end

function AssassinSceneRpc:onReceiveAssassinChangeMapReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinSceneRpc:sendEnterBattleGridRequest(gridId, cb, cbObj)
	local req = AssassinSceneModule_pb.EnterBattleGridRequest()

	req.battleGridId = gridId

	self:sendMsg(req, cb, cbObj)
end

function AssassinSceneRpc:onReceiveEnterBattleGridReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function AssassinSceneRpc:onReceiveSummonMonsterPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AssassinStealthGameController.instance:enemyBornByList(msg.summons)
end

function AssassinSceneRpc:onReceiveMonsterUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AssassinStealthGameController.instance:updateEnemies(msg.monsters)
end

function AssassinSceneRpc:onReceiveNewInteractivePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AssassinStealthGameModel.instance:setInteractiveList(msg.interactiveIds)
	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	AssassinStealthGameController.instance:dispatchEvent(AssassinEvent.OnQTEInteractUpdate)
end

function AssassinSceneRpc:onReceiveMissionUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AssassinStealthGameModel.instance:setMissionData(msg.mission)
	AssassinStealthGameController.instance:dispatchEvent(AssassinEvent.OnMissionUpdate)
end

function AssassinSceneRpc:onReceiveGameStatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AssassinStealthGameModel.instance:setGameState(msg.gameState)

	if msg.gameState == AssassinEnum.GameState.Win then
		AssassinController.instance:onFinishQuest(msg.questId)
	end

	local isPlayerTurn = AssassinStealthGameModel.instance:isPlayerTurn()

	if isPlayerTurn then
		AssassinStealthGameController.instance:checkGameState()
	end
end

function AssassinSceneRpc:onReceiveGainItemPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local itemList = {}
	local newItemDict = {}
	local uid = msg.uid

	for _, gainItemData in ipairs(msg.items) do
		local itemId = gainItemData.itemId
		local count = gainItemData.count
		local gameHeroMo = AssassinStealthGameModel.instance:getHeroMo(uid, true)

		if gameHeroMo then
			local oldCount = gameHeroMo:getItemCount(itemId)

			if oldCount <= 0 then
				newItemDict[itemId] = true
			end

			gameHeroMo:AddItem(itemId, count)
		end

		itemList[#itemList + 1] = {
			itemId = itemId,
			count = count
		}
	end

	AssassinController.instance:openAssassinStealthGameGetItemView(itemList)
	AssassinStealthGameController.instance:dispatchEvent(AssassinEvent.OnHeroGetItem, uid, newItemDict)
end

function AssassinSceneRpc:onReceiveAssassinChangingMapPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AssassinStealthGameModel.instance:setGameRequestData()
	AssassinStealthGameController.instance:changeMap(msg.mapId)
end

function AssassinSceneRpc:onReceiveHeroUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AssassinStealthGameController.instance:updateHeroes(msg.hero)
end

AssassinSceneRpc.instance = AssassinSceneRpc.New()

return AssassinSceneRpc
