-- chunkname: @modules/logic/versionactivity2_6/dicehero/rpc/DiceHeroRpc.lua

module("modules.logic.versionactivity2_6.dicehero.rpc.DiceHeroRpc", package.seeall)

local DiceHeroRpc = class("DiceHeroRpc", BaseRpc)

function DiceHeroRpc:sendDiceHeroGetInfo(callback, callobj)
	local req = DiceHeroModule_pb.DiceHeroGetInfoRequest()

	return self:sendMsg(req, callback, callobj)
end

function DiceHeroRpc:onReceiveDiceHeroGetInfoReply(resultCode, msg)
	if resultCode == 0 then
		DiceHeroModel.instance:initInfo(msg.info)
	end
end

function DiceHeroRpc:sendDiceHeroEnterStory(levelId, chapter, callback, callobj)
	local req = DiceHeroModule_pb.DiceHeroEnterStoryRequest()

	req.levelId = levelId
	req.chapter = chapter

	return self:sendMsg(req, callback, callobj)
end

function DiceHeroRpc:onReceiveDiceHeroEnterStoryReply(resultCode, msg)
	if resultCode == 0 then
		DiceHeroModel.instance:initInfo(msg.info)
	end
end

function DiceHeroRpc:sendDiceHeroGetReward(index, chapter, callback, callobj)
	local req = DiceHeroModule_pb.DiceHeroGetRewardRequest()

	for _, v in ipairs(index) do
		table.insert(req.index, v)
	end

	req.chapter = chapter

	return self:sendMsg(req, callback, callobj)
end

function DiceHeroRpc:onReceiveDiceHeroGetRewardReply(resultCode, msg)
	if resultCode == 0 then
		DiceHeroModel.instance:initInfo(msg.info)
	end
end

function DiceHeroRpc:sendDiceHeroEnterFight(levelId, callback, callobj)
	DiceHeroModel.instance.lastEnterLevelId = levelId

	local req = DiceHeroModule_pb.DiceHeroEnterFightRequest()

	req.levelId = levelId

	return self:sendMsg(req, callback, callobj)
end

function DiceHeroRpc:onReceiveDiceHeroEnterFightReply(resultCode, msg)
	if resultCode == 0 then
		DiceHeroFightModel.instance:setGameData(msg.fight)
	end
end

function DiceHeroRpc:sendDiceHeroResetDice(diceUids, callback, callobj)
	local req = DiceHeroModule_pb.DiceHeroResetDiceRequest()

	for _, uid in pairs(diceUids) do
		table.insert(req.diceUids, uid)
	end

	return self:sendMsg(req, callback, callobj)
end

function DiceHeroRpc:onReceiveDiceHeroResetDiceReply(resultCode, msg)
	if resultCode == 0 then
		local flow = DiceHeroHelper.instance:buildFlow(msg.steps)

		DiceHeroController.instance:dispatchEvent(DiceHeroEvent.StepStart)
		DiceHeroHelper.instance:startFlow(flow)
	end
end

function DiceHeroRpc:sendDiceHeroConfirmDice(callback, callobj)
	local req = DiceHeroModule_pb.DiceHeroConfirmDiceRequest()

	return self:sendMsg(req, callback, callobj)
end

function DiceHeroRpc:onReceiveDiceHeroConfirmDiceReply(resultCode, msg)
	if resultCode == 0 then
		local gameData = DiceHeroFightModel.instance:getGameData()

		gameData.confirmed = true

		DiceHeroController.instance:dispatchEvent(DiceHeroEvent.ConfirmDice)

		local flow = DiceHeroHelper.instance:buildFlow(msg.steps)

		DiceHeroController.instance:dispatchEvent(DiceHeroEvent.StepStart)
		DiceHeroHelper.instance:startFlow(flow)
	end
end

function DiceHeroRpc:sendDiceHeroUseSkill(type, skillId, toId, diceUids, pattern, callback, callobj)
	local req = DiceHeroModule_pb.DiceHeroUseSkillRequest()

	req.type = type
	req.skillId = skillId
	req.toId = toId

	for _, uid in ipairs(diceUids) do
		table.insert(req.diceUids, uid)
	end

	req.pattern = pattern

	return self:sendMsg(req, callback, callobj)
end

function DiceHeroRpc:onReceiveDiceHeroUseSkillReply(resultCode, msg)
	if resultCode == 0 then
		local gameInfo = DiceHeroFightModel.instance:getGameData()

		for i, v in ipairs(msg.skillId) do
			DiceHeroStatHelper.instance:addUseCard(v)

			local skillCardMo = gameInfo.skillCardsBySkillId[v]

			if skillCardMo then
				skillCardMo.curRoundUse = skillCardMo.curRoundUse + 1
			end
		end

		for i, v in ipairs(msg.diceUids) do
			local diceItem = DiceHeroHelper.instance:getDice(v)

			if diceItem then
				diceItem:markDeleted()
			end
		end

		local flow = DiceHeroHelper.instance:buildFlow(msg.steps)

		DiceHeroController.instance:dispatchEvent(DiceHeroEvent.StepStart)
		DiceHeroHelper.instance:startFlow(flow)
	end
end

function DiceHeroRpc:sendDiceHeroEndRound(callback, callobj)
	local req = DiceHeroModule_pb.DiceHeroEndRoundRequest()

	return self:sendMsg(req, callback, callobj)
end

function DiceHeroRpc:onReceiveDiceHeroEndRoundReply(resultCode, msg)
	if resultCode == 0 then
		DiceHeroController.instance:dispatchEvent(DiceHeroEvent.StepStart)

		local flow = DiceHeroHelper.instance:buildFlow(msg.steps)

		flow:addWork(DiceHeroLastStepWork.New(msg.fight))

		if #msg.afterSteps > 0 then
			DiceHeroHelper.instance.afterFlow = DiceHeroHelper.instance:buildFlow(msg.afterSteps)
		end

		DiceHeroHelper.instance:startFlow(flow)
	end
end

function DiceHeroRpc:sendDiceGiveUp(chapter, callback, callobj)
	local req = DiceHeroModule_pb.DiceGiveUpRequest()

	req.chapter = chapter

	return self:sendMsg(req, callback, callobj)
end

function DiceHeroRpc:onReceiveDiceGiveUpReply(resultCode, msg)
	if resultCode == 0 then
		DiceHeroStatHelper.instance:sendReset()
		GameFacade.showToast(ToastEnum.DiceHeroDiceResetSuccess)
		DiceHeroModel.instance:initInfo(msg.info)
	end
end

function DiceHeroRpc:onReceiveDiceFightSettlePush(resultCode, msg)
	if resultCode == 0 then
		local isFirstWin = false

		if msg.status == DiceHeroEnum.GameStatu.Win then
			local lastEnterLevelId = DiceHeroModel.instance.lastEnterLevelId
			local co = lua_dice_level.configDict[lastEnterLevelId]

			if co then
				local gameInfo = DiceHeroModel.instance:getGameInfo(co.chapter)

				if gameInfo.currLevel == lastEnterLevelId and not gameInfo.allPass then
					isFirstWin = true
				end
			end
		end

		DiceHeroModel.instance:initInfo(msg.info)

		DiceHeroFightModel.instance.finishResult = msg.status
		DiceHeroFightModel.instance.isFirstWin = isFirstWin
	end
end

DiceHeroRpc.instance = DiceHeroRpc.New()

return DiceHeroRpc
