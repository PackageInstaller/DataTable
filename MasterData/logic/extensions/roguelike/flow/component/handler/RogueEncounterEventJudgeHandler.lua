-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/RogueEncounterEventJudgeHandler.lua

module("logic.extensions.roguelike.flow.component.handler.RogueEncounterEventJudgeHandler", package.seeall)

local M = class("RogueEncounterEventJudgeHandler", IRogueJudgeHandler)

function M:getExtraResult()
	local result
	local bigSuccess = RoguelikeConfig.instance:getConstByName("EncounterEventBigSuccess").numValue
	local bigFail = 0
	local trigger, params = RogueMgr.instance:getRogueFlow().model:getConditionEffect("BigSuccessAddition")
	local addition = 0

	if trigger then
		addition = tonumber(params)
	end

	addition = addition + RoguelikeModel.instance:getBigSuccessAdd()

	if math.random(1, 1000) < bigSuccess + addition then
		result = RoguelikeConst.ROGUE_EXTRA_TYPE.BIG_SUCCESS

		self._mgr.flow.model:setExtraResult(result)

		return result
	end

	if bigFail > math.random(1, 1000) then
		result = RoguelikeConst.ROGUE_EXTRA_TYPE.BIG_FAIL

		self._mgr.flow.model:setExtraResult(result)

		return result
	end

	return result
end

function M:judgeDice()
	local extraResult = self._mgr.flow.model:getExtraResult()

	if extraResult == RoguelikeConst.ROGUE_EXTRA_TYPE.BIG_SUCCESS then
		for idx2, dice2 in ipairs(self._mgr._curRoundCombatDice) do
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_MATCH_DICE, 0, dice2:getId())
			print("ROGUE", "消除对抗骰", dice2:getUpPattern())
		end

		self._mgr._curRoundCombatDice = {}

		self._mgr.flow.model:setExtraResult(nil)
		self:onChallengeSuccess()

		if self._mgr.flow.model:checkIsLastOne() then
			self._mgr.flow.model:setRoundFinish(true)

			if #self._mgr._curRoundCombatDice <= 0 then
				self._mgr.flow.model:setJudgeResult(true)
			else
				self._mgr.flow.model:setJudgeResult(false)
			end
		end

		return true
	elseif extraResult == RoguelikeConst.ROGUE_EXTRA_TYPE.BIG_FAIL then
		local dice = RogueDiceMo.New(RoguelikeConst.ROGUE_DICE_TYPE.COMBAT)
		local index = dice:getRandomUpIndex()

		dice:setUpIndex(self._mgr.flow.model:getCurEventProp())
		table.insert(self._mgr._curRoundCombatDice, dice)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ADD_EXTRA_COMBAT_DICE, dice, #self._mgr._curRoundCombatDice)
		self._mgr.flow.model:setExtraResult(nil)
	end

	function matchDice()
		if #self._mgr._curRoundCombatDice == 0 or #self._mgr._curRoundPlayerDice == 0 then
			return false
		end

		for idx, dice1 in ipairs(self._mgr._curRoundPlayerDice) do
			for idx2, dice2 in ipairs(self._mgr._curRoundCombatDice) do
				if dice1:getUpPattern() == dice2:getUpPattern() then
					print("同图案匹配到", dice2:getUpPattern())
					GlobalDispatcher:dispatchEvent(EventType.ROGUE_MATCH_DICE, dice1:getId(), dice2:getId())
					table.remove(self._mgr._curRoundPlayerDice, idx)
					table.remove(self._mgr._curRoundCombatDice, idx2)

					return true
				end
			end
		end

		return false
	end

	local matchTime2 = 0

	while matchDice() and matchTime2 < 10 do
		matchTime2 = matchTime2 + 1

		if #self._mgr._curRoundCombatDice <= 0 then
			print("挑战胜利")
		end
	end

	if self._mgr.flow.model:checkIsLastOne() then
		print("最后一个角色，设置结束")
		self._mgr.flow.model:setRoundFinish(true)

		if #self._mgr._curRoundCombatDice <= 0 then
			self._mgr.flow.model:setJudgeResult(true)
		else
			self._mgr.flow.model:setJudgeResult(false)
		end
	end

	if #self._mgr._curRoundCombatDice <= 0 then
		print("挑战胜利")
		self:onChallengeSuccess()
	else
		print("挑战失败")
		self:reduceRoleHp()

		self._mgr._curRoundCombatDice = {}
	end

	return true
end

function M:skipJudge(isWin, callback)
	if isWin then
		self:saveJudgeArchive(true)
		self:onChallengeSuccess()
	end
end

function M:onChallengeSuccess()
	local replyCo = RogueMgr.instance:getModel():getCurReplyCo()

	if replyCo then
		if RogueMgr.instance:getIsClientMode() then
			-- block empty
		else
			local effectId = replyCo.successEffect

			if effectId ~= nil then
				RoguelikeController.instance:execEffectIds(effectId)
			end

			RogueMgr.instance:getRogueFlow().model:setInSettlement(true)
		end
	else
		print("找不到应对配置")
	end
end

function M:reduceRoleHp()
	local replyCo = RogueMgr.instance:getModel():getCurReplyCo()

	self._mgr.flow.stateMgr:addJudgeFailRole(self._mgr.flow.model:getCurRoleMo():getRoleIndex())

	if replyCo then
		if RogueMgr.instance:getIsClientMode() then
			local attack = replyCo.difficulty
			local roleProp = self._mgr.flow.model:getCurRoleMo()

			roleProp:reduceHp(attack)
		else
			local effectId = replyCo.failEffect

			if effectId ~= nil then
				local roleId = self._mgr.flow.model:getCurRoleMo():getRoleId()
				local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Event_EC_Fail")
				local msg = string.format(format, RogueMgr.instance:getModel():getCurRoleMo():getName())

				GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
				RoguelikeController.instance:execEffectIds(effectId, nil, roleId)
			end
		end
	else
		print("找不到应对配置")
	end
end

function M:saveJudgeArchive(isJudged)
	if RogueMgr.instance:getIsClientMode() then
		return
	end

	local type = self._mgr.flow.model:getCurEventType()
	local roomId = RoguelikeModel.instance:getCurRoomId()
	local replyCo = RogueMgr.instance:getModel():getCurReplyCo()
	local enemyId = replyCo.id
	local eventId = RogueMgr.instance:getModel():getCurEventId()
	local enemyOuterHp = #self._mgr._curRoundCombatDice
	local combatDices = self._mgr._curRoundCombatDice
	local enemyInnerHp = replyCo.difficulty + RogueMgr.instance:getModel():getEventChangeDifficulty()

	enemyInnerHp = math.max(1, enemyInnerHp)

	local round = self._mgr.flow.stateMgr:getRoundIndex()
	local heroId = self._mgr.flow.model:getCurRoleMo():getRoleId()
	local monsterDiceFaceNO = RoguelikeExtension_pb.FaceNO()
	local pattern = self._mgr.flow.model:getCurEventProp()

	monsterDiceFaceNO.face = RoguelikeUtil.instance:convertCAttrType2SType(pattern)
	monsterDiceFaceNO.num = #combatDices

	local enemyFace = monsterDiceFaceNO
	local selectedAttr = pattern
	local roleDices = self._mgr._curRoundPlayerDice
	local curDiceRoleId = self._mgr:getCurDiceRoleId()
	local selfFaces = curDiceRoleId == heroId and roleDices or {}
	local totalFaces = RogueMgr.instance:getStateMgr():getTotalExtraFaces()
	local tmpExtraFaces = RogueMgr.instance:getStateMgr():getTmpExtraFaces()
	local archiveNO = RoguelikeAgent.instance:generateArchive(type, roomId, enemyId, enemyOuterHp, enemyInnerHp, round, heroId, enemyFace, selectedAttr, selfFaces, isJudged, eventId, nil, nil, totalFaces, tmpExtraFaces)

	RoguelikeAgent.instance:sendJudgeArchiveRequest(archiveNO)
end

return M
