-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/mgr/RogueGameJudgeMgr.lua

module("logic.extensions.roguelike.flow.component.mgr.RogueGameJudgeMgr", package.seeall)

local M = class("RogueGameJudgeMgr", IRogueFlowComp)
local JudgeHandlerMap = {
	[RoguelikeConst.ROGUE_EVENT_TYPE.SINGLE_EVENT] = RogueSingleEventJudgeHandler,
	[RoguelikeConst.ROGUE_EVENT_TYPE.MULTI_EVENT] = RogueMultiEventJudgeHandler,
	[RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT] = RogueEncounterEventJudgeHandler,
	[RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT] = RogueFightJudgeHandler,
	[RoguelikeConst.ROGUE_EVENT_TYPE.RECTIFY_EVENT] = RogueRectifyJudgeHandler
}
local RoleActionHandlerMap = {
	[RogueJudgeModel.RoleActionType.TakeDamage] = RogueAction_AttackHandler,
	[RogueJudgeModel.RoleActionType.ReduceDiceWall] = RogueAction_ReduceDiceWallHandler,
	[RogueJudgeModel.RoleActionType.AddDiceWall] = RogueAction_DiceWallHandler,
	[RogueJudgeModel.RoleActionType.ReduceSan] = RogueAction_AddSanHandler,
	[RogueJudgeModel.RoleActionType.ReduceCoin] = RogueAction_AddCoinHandler,
	[RogueJudgeModel.RoleActionType.AddDicePattern] = RogueAction_AddPatternHandler,
	[RogueJudgeModel.RoleActionType.Shield2Attack] = RogueAction_Shield2AttackHandler,
	[RogueJudgeModel.RoleActionType.Shield2ReduceDiceWall] = RogueAction_Shield2ReduceDiceWallHandler,
	[RogueJudgeModel.RoleActionType.Shield2Coin] = RogueAction_Shield2CoinHandler,
	[RogueJudgeModel.RoleActionType.Attack2Hurt] = RogueAction_Attack2HurtHandler,
	[RogueJudgeModel.RoleActionType.RecoveryHurt] = RogueAction_RecoveryHurtHandler,
	[RogueJudgeModel.RoleActionType.Shield2Hurt] = RogueAction_Shield2HurtHandler,
	[RogueJudgeModel.RoleActionType.AddCardEntryNext] = RogueAction_AddCardEntryNextHandler
}
local RoleCardEntryHandlerMap = {
	[RogueJudgeModel.RoleCardEntry.THROW_RESULT] = RogueCardThrowResultHandler,
	[RogueJudgeModel.RoleCardEntry.DICE_SUCCESS] = RogueCardDiceSuccessHandler,
	[RogueJudgeModel.RoleCardEntry.DICE_SACRIFICE] = RogueCardDiceSacrificeHandler,
	[RogueJudgeModel.RoleCardEntry.DICE_ECLIPSE] = RogueCardDiceEclipseHandler,
	[RogueJudgeModel.RoleCardEntry.MAKE_DAMAGE] = RogueCardMakeDamageHandler,
	[RogueJudgeModel.RoleCardEntry.MAKE_SHIELD] = RogueCardMakeShieldHandler,
	[RogueJudgeModel.RoleCardEntry.GET_EFFECT_ID] = RogueCardGetEffectHandler,
	[RogueJudgeModel.RoleCardEntry.MAKE_BATTER] = RogueCardMakeBatterHandler,
	[RogueJudgeModel.RoleCardEntry.DICE_BLEED] = RogueCardDiceBleedHandler,
	[RogueJudgeModel.RoleCardEntry.DICE_TRANCE] = RogueCardDiceTranceHandler
}

function M:onInit()
	self._curRoundCombatDice = {}
	self._curRoundPlayerDice = {}
	self._curRoundMatchCombatDice = {}
	self._curRoundMatchPlayerDice = {}
	self._curRoleDiceWalls = {}
	self._curRoundPatternBroadcasts = {}
	self._judgeHandlers = {}
	self._cardEntryHandlers = {}
	self._roleActionHandlers = {}
	self._inSkip = false
end

function M:onStart()
	self:setEvent(true)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_RESULT_FINISH, self._onResultFinish, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SKIP_TO_JUDGE_RESULT, self._onSkipResult, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_GAME_OVER, self._onSkipResult, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_EXPLORE_INFO, self._onExploreInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_RESULT_FINISH, self._onResultFinish, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SKIP_TO_JUDGE_RESULT, self._onSkipResult, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_GAME_OVER, self._onSkipResult, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_EXPLORE_INFO, self._onExploreInfoChange, self)
	end
end

function M:_onResultFinish()
	self.flow.model:setRoundFinish(false)
	self.flow.model:setEventProp(nil)

	self._curRoundCombatDice = {}
	self._curRoundPlayerDice = {}
	self._curRoundMatchCombatDice = {}
	self._curRoundMatchPlayerDice = {}
	self._curRoleDiceWalls = {}
	self._curRoundPatternBroadcasts = {}
	self._combatFeatures = nil
	self._inSkip = false
end

function M:_onExploreInfoChange()
	if RoguelikeController.instance:getIsAllDeath() then
		self:_onSkipResult(nil, false)
	end
end

function M:_onSkipResult(sender, isWin)
	if self.flow ~= nil and self.flow:getCurGamePlay() and self.flow:getCurGamePlay():isGameState(RoguelikeConst.ROGUE_GAME_STATE.RESULT) or self._inSkip then
		return
	end

	self._inSkip = true

	settimer(0.5, self._delaySetSkip, self, fasle)
	self.flow.model:setRoundFinish(true)

	local eventType = self.flow.model:getCurEventType()

	self.flow.model:setJudgeResult(isWin)
	self:getJudgeHandler(eventType):skipJudge(isWin)
	self.flow:changeRogueState(RoguelikeConst.ROGUE_GAME_STATE.RESULT)
end

function M:_delaySetSkip()
	self._inSkip = false
end

function M:onClear()
	removetimer(self._delaySetSkip, self)
	self:setEvent(false)

	self._curRoundCombatDice = {}
	self._curRoundPlayerDice = {}
	self._curRoundMatchCombatDice = {}
	self._curRoundMatchPlayerDice = {}
	self._curRoleDiceWalls = {}
	self._judgeHandlers = {}
	self._roleActionHandlers = {}
	self._cardEntryHandlers = {}
	self._curFeatureIndex = nil
end

function M:getJudgeHandler(eventType)
	if not self._judgeHandlers[eventType] then
		self._judgeHandlers[eventType] = JudgeHandlerMap[eventType].New(self)
	end

	return self._judgeHandlers[eventType]
end

function M:getRoleActionHandler(actionType)
	if not self._roleActionHandlers[actionType] then
		if not RoleActionHandlerMap[actionType] then
			printError("找不到实现", actionType)
		end

		self._roleActionHandlers[actionType] = RoleActionHandlerMap[actionType].New(self)
	end

	return self._roleActionHandlers[actionType]
end

function M:getCardEntryHandler(paramName)
	if not self._cardEntryHandlers[paramName] then
		if not RoleCardEntryHandlerMap[paramName] then
			printError("找不到实现", paramName)
		end

		self._cardEntryHandlers[paramName] = RoleCardEntryHandlerMap[paramName].New(self)
	end

	return self._cardEntryHandlers[paramName]
end

function M:getExtraResult()
	local eventType = self.flow.model:getCurEventType()

	return self:getJudgeHandler(eventType):getExtraResult()
end

function M:judgeDice()
	self.flow.stateMgr:setDeifyCount(0)

	local eventType = self.flow.model:getCurEventType()

	return self:getJudgeHandler(eventType):judgeDice()
end

function M:getFeatureIndexArchive()
	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()

	if judgeArchive ~= nil and judgeArchive.curFeature ~= 0 then
		local monsterId = judgeArchive.enemyId

		if monsterId == RogueMgr.instance:getModel():getCurMonster().monsterProp:getId() then
			self._curFeatureIndex = judgeArchive.curFeature

			if judgeArchive.enemyInnerHp and judgeArchive.enemyInnerHp ~= 0 then
				RogueMgr.instance:getRogueFlow().judgeModel:setMonsterAttack(judgeArchive.enemyInnerHp)
			end

			return judgeArchive.curFeature
		end
	end

	return self._curFeatureIndex
end

function M:setFeatureIndex(index)
	self._curFeatureIndex = index
end

function M:getFeatureIndex()
	return self._curFeatureIndex or self:getFeatureIndexArchive()
end

function M:getFeaturePatternsArchive()
	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()

	if judgeArchive ~= nil and #judgeArchive.features > 0 then
		local monsterId = judgeArchive.enemyId

		if monsterId == RogueMgr.instance:getModel():getCurMonster().monsterProp:getId() then
			self._featurePatterns = {}

			for k, v in ipairs(judgeArchive.features) do
				table.insert(self._featurePatterns, v)
			end

			return judgeArchive.features
		end
	end

	self._featurePatterns = RogueMgr.instance:getModel():getCurMonster().monsterProp:getFeaturesDices()

	return self._featurePatterns
end

function M:getFeaturePatterns()
	if not self._featurePatterns then
		return self:getFeaturePatternsArchive()
	else
		return self._featurePatterns
	end
end

function M:setFeaturePatterns(patterns)
	self._featurePatterns = patterns
end

function M:getMonsterActionId()
	local actions = self:getFeaturePatterns() or RogueMgr.instance:getModel():getCurMonster().monsterProp:getFeaturesDices()
	local index = self:getFeatureIndex()

	return actions[index]
end

function M:getCombatDiceFeatures()
	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()

	if judgeArchive ~= nil and judgeArchive.selectedAttr then
		local monsterId = judgeArchive.enemyId

		if monsterId == RogueMgr.instance:getModel():getCurMonster().monsterProp:getId() then
			self:setCombatDiceFeatures(judgeArchive.selectedAttr)

			return judgeArchive.selectedAttr
		end
	end

	return self._combatFeatures
end

function M:setCombatDiceFeatures(features)
	self._combatFeatures = features
end

function M:setNeedNewFeature(needNewFeature)
	self._isNeeNewFeature = needNewFeature
end

function M:getCombatActionEffectId()
	local actionId = self:getMonsterActionId()
	local actionCo = RoguelikeConfig.instance:getMonsterActionById(actionId)

	return actionCo.effect
end

function M:getNeedNewFeature()
	return self._isNeeNewFeature == true or self:getCombatDiceFeatures() == nil
end

function M:getIsNeedNewFeature()
	return self._isNeeNewFeature
end

function M:changeRandomFeatures(targetFeatures)
	local feature

	if targetFeatures == nil then
		feature = self._combatFeatures

		local temp = {}

		for i = 1, 6 do
			if feature ~= i then
				table.insert(temp, i)
			end
		end

		feature = temp[math.random(1, #temp)]

		print("新随机特征面", feature)
		self:setCombatDiceFeatures(feature)

		if self._featurePatterns and #self._featurePatterns > 0 then
			for k, v in pairs(self._featurePatterns) do
				if k == self:getFeatureIndex() then
					self._featurePatterns[k] = feature
				end
			end

			self:saveJudgeArchive(false)
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_FEATURES_ROLL_REFRESH)
		end
	else
		feature = targetFeatures

		self:setCombatDiceFeatures(targetFeatures)
	end

	return feature
end

function M:createEventDice()
	local judgeArchive = RoguelikeModel.instance:getEventJudgeArchive()
	local enemyId = judgeArchive and judgeArchive.enemyId or -1
	local eventId = self.flow.model:getCurEventId()
	local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(eventId)
	local replyCo = RogueMgr.instance:getModel():getCurReplyCo()
	local weakness = {}
	local prop = self.flow.model:getEventProp()

	if prop ~= nil then
		weakness = {
			prop
		}

		print("修改属性", prop)
	end

	local count = replyCo.difficulty + RogueMgr.instance:getModel():getEventChangeDifficulty()

	self._eventWeakness = weakness

	local dices = {}
	local hasMatchWeakness = false

	function checkHadWeakness(index)
		if hasMatchWeakness then
			return true
		end

		for k, v in pairs(weakness) do
			if v == index then
				hasMatchWeakness = true

				return true
			end
		end
	end

	local hideCount

	if not self._isRestore and judgeArchive == nil then
		self._isRestore = true
	end

	if not self._isRestore and judgeArchive ~= nil and enemyId == replyCo.id then
		count = judgeArchive.enemyInnerHp or 1
		hideCount = judgeArchive.enemyInnerHp - judgeArchive.enemyOuterHp
		self._isRestore = true
	end

	count = math.max(1, count)

	for i = 1, count do
		local dice = RogueDiceMo.New(RoguelikeConst.ROGUE_DICE_TYPE.COMBAT)

		dice:setUpIndex(weakness[1])
		checkHadWeakness(dice:getPatterns())
		table.insert(dices, dice)
	end

	if not hasMatchWeakness and #dices > 0 then
		dices[math.random(1, #dices)]:setUpIndex(weakness[1])
	end

	self._curRoundCombatDice = dices

	self:saveJudgeArchive(false)

	return self._curRoundCombatDice, hideCount
end

function M:createMonsterDice()
	local monsterMo = self.flow.model:getCurMonster().monsterProp
	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()

	if judgeArchive ~= nil and judgeArchive.enemyId ~= 0 and judgeArchive.enemyId == monsterMo:getId() and judgeArchive.enemyFace.num ~= 0 then
		local dices = {}

		for i = 1, judgeArchive.enemyFace.num do
			local dice = RogueDiceMo.New(RoguelikeConst.ROGUE_DICE_TYPE.COMBAT)

			dice:setUpIndex(RoguelikeUtil.instance:convertSAttrTypeCSType(judgeArchive.enemyFace.face))
			dice:setDiceType(1)
			table.insert(dices, dice)
		end

		self._curRoundCombatDice = dices

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_MONSTER_HP)
		self:saveJudgeArchive(false)

		return self._curRoundCombatDice
	end

	local isDefense, params = RogueMgr.instance:getRogueFlow().judgeModel:getMonsterActionIsDiceWall()
	local defenseCount = isDefense and RogueMgr.instance:getRogueFlow().judgeModel:getMonsterDefenseWall(params, true) or 0
	local additionCount = self.flow.stateMgr:getAdditionFighting() or 0

	if additionCount ~= 0 then
		self.flow.stateMgr:setAdditionFighting(0)
	end

	local count = defenseCount + RogueMgr.instance:getModel():getMonsterChangeFight() + additionCount
	local finalCount = count
	local fixedCount = self.flow.stateMgr:getFixedFighting() or 0

	if fixedCount ~= 0 then
		finalCount = fixedCount
	end

	local dices = {}

	if isDefense then
		for i = 1, finalCount do
			local dice = RogueDiceMo.New(RoguelikeConst.ROGUE_DICE_TYPE.COMBAT)

			dice:setUpIndex(self:getCombatDiceFeatures())

			local diceType = count < i and 3 or 1

			dice:setDiceType(diceType)
			table.insert(dices, dice)
		end

		for i = 1, additionCount do
			local dice = RogueDiceMo.New(RoguelikeConst.ROGUE_DICE_TYPE.COMBAT)

			dice:setUpIndex(self:getCombatDiceFeatures())
			dice:setDiceType(2)
			table.insert(dices, dice)
		end
	end

	self._curRoundCombatDice = dices

	self.flow.model:setFirstActiveRoleIndex()
	self.flow.stateMgr:syncRoundIndex()
	self:saveJudgeArchive(false)

	return self._curRoundCombatDice
end

function M:createRoleDiceWall()
	local count = self.flow.judgeModel:getRoleDiceWall()
	local newDices = {}

	for i = #self._curRoleDiceWalls + 1, count do
		local dice = RogueDiceMo.New(RoguelikeConst.ROGUE_DICE_TYPE.COMBAT)

		dice:setUpIndex(1)
		dice:setDiceType(1)
		table.insert(newDices, dice)
		table.insert(self._curRoleDiceWalls, dice)
	end

	return self._curRoleDiceWalls, newDices
end

function M:clearRoleDiceWall()
	for k, v in pairs(self._curRoleDiceWalls or {}) do
		local go = v:getGo()

		self.flow.diceMgr:recoveryDiceObj(go)
	end

	self._curRoleDiceWalls = {}
end

function M:getCurMonsterHp()
	local count = 0

	for k, v in pairs(self._curRoundCombatDice) do
		if v:getDiceType() == 1 then
			count = count + 1
		end
	end

	local monsterMo = self.flow.model:getCurMonster().monsterProp

	count = count + monsterMo:getHp()

	return count
end

function M:getCurRoundCombatDice()
	return TableUtil.deepCopy(self._curRoundCombatDice)
end

function M:getCurRoundCombatDiceCount()
	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()

	if judgeArchive ~= nil and judgeArchive.enemyFace then
		return judgeArchive.enemyFace.num
	end

	return #self._curRoundCombatDice
end

function M:clearCurRoundCombatDice()
	self._curRoundCombatDice = {}
end

function M:removeCurRoundCombatDice()
	table.remove(self._curRoundCombatDice, 1)
end

function M:getSpecialDiceCount(dices)
	local count = 0

	for k, v in ipairs(dices or {}) do
		count = count + v.num
	end

	return count
end

function M:createRoleDice()
	local roleMo = self.flow.model:getActiveRoleMo()

	if not roleMo then
		print("角色全部死亡")

		self._curRoundPlayerDice = {}

		self:setCurDiceRoleId(0)

		return false
	end

	local isMonster = self._combatFeatures ~= nil
	local curSelectProp = isMonster and self.flow.judgeModel:getRoleSelectActionProp() or self.flow.model:getSelectProp()
	local count = roleMo:getPropertyLevel(curSelectProp)
	local dices = {}
	local judgeModel = RogueMgr.instance:getRogueFlow().judgeModel

	if isMonster then
		local entries = judgeModel:getCurEntries()

		for k, v in pairs(entries) do
			local entryCo = RoguelikeConfig.instance:getCardEntryById(v)

			if entryCo then
				local params = string.split(entryCo.effect, "#")
				local program = params[1]
				local eventType = self.flow.model:getCurEventType()
				local judgeHandler = self:getJudgeHandler(eventType)
				local result = self:getCardEntryHandler(program):execAction(RoguelikeConst.CARD_ENTRY_EFFECT_TIME.CREATE_DICE, entryCo, judgeHandler)

				if result then
					for i = 1, result[2] do
						local dice = RogueDiceMo.New(RoguelikeConst.ROGUE_DICE_TYPE.PLAYER, result[1])

						dice:setUpIndex(dice:getRandomUpIndex())
						table.insert(dices, dice)
					end
				end
			else
				printError("找不到配置", v)
			end
		end
	end

	self.flow.stateMgr:saveLastExtraFaceInfo()

	local judgeArchive = RoguelikeModel.instance:getJudgeArchive()

	if judgeArchive ~= nil and judgeArchive.isJudged == false and judgeArchive.heroId == roleMo:getRoleId() and #dices > 0 then
		self._curRoundPlayerDice = dices

		self:setCurDiceRoleId(roleMo:getRoleId())
		print("恢复角色骰子数量", #dices)
	end

	for i = 1, count do
		local dice = RogueDiceMo.New(RoguelikeConst.ROGUE_DICE_TYPE.PLAYER, curSelectProp)

		dice:setUpIndex(dice:getRandomUpIndex())
		table.insert(dices, dice)
	end

	self._curRoundPlayerDice = dices

	self:setCurDiceRoleId(roleMo:getRoleId())
	self:saveJudgeArchive(false)

	return dices
end

function M:getCurRoundPlayerDice()
	return TableUtil.deepCopy(self._curRoundPlayerDice)
end

function M:clearCurRoundPlayerDice()
	self._curRoundPlayerDice = {}
end

function M:setCurDiceRoleId(roleId)
	self._curDiceRoleId = roleId
end

function M:getCurDiceRoleId()
	return self._curDiceRoleId
end

function M:createRectifyDice()
	local roleMo = self.flow.model:getCurRoleMo()
	local curSelectProp = self.flow.model:getSelectProp()
	local count = roleMo:getPropertyLevel(curSelectProp)
	local dices = {}

	for i = 1, count do
		local dice = RogueDiceMo.New(RoguelikeConst.ROGUE_DICE_TYPE.PLAYER, curSelectProp)

		dice:setUpIndex(dice:getRandomUpIndex())
		table.insert(dices, dice)
	end

	self._curRoundPlayerDice = dices

	return dices
end

function M:saveJudgeArchive(isJudged, isIgnoreQuick)
	local eventType = self.flow.model:getCurEventType()

	self.flow.model:clearRestoreIndex()

	return self:getJudgeHandler(eventType):saveJudgeArchive(isJudged, isIgnoreQuick)
end

function M:saveAtOneEventJudgeArchive(replyId, eventType, eventId)
	local type = eventType or 0
	local roomId = 0
	local enemyId = replyId
	local enemyOuterHp = 0
	local enemyInnerHp = 0
	local round = 0
	local heroId = 0
	local monsterDiceFaceNO = RoguelikeExtension_pb.FaceNO()
	local pattern = 0

	monsterDiceFaceNO.face = 0
	monsterDiceFaceNO.num = 0

	local enemyFace = monsterDiceFaceNO
	local selectedAttr = pattern
	local roleDices = {}
	local selfFaces = roleDices
	local isJudged = true
	local archiveNO = RoguelikeAgent.instance:generateArchive(type, roomId, enemyId, enemyOuterHp, enemyInnerHp, round, heroId, enemyFace, selectedAttr, selfFaces, isJudged, eventId)

	RoguelikeAgent.instance:sendJudgeArchiveRequest(archiveNO)
end

function M:saveEmptyJudgeArchive(tempEnemyId)
	local type = 0
	local roomId = 0
	local enemyId = tempEnemyId or 0
	local enemyOuterHp = 0
	local enemyInnerHp = 0
	local round = 0
	local heroId = 0
	local monsterDiceFaceNO = RoguelikeExtension_pb.FaceNO()
	local pattern = 0

	monsterDiceFaceNO.face = 0
	monsterDiceFaceNO.num = 0

	local enemyFace = monsterDiceFaceNO
	local selectedAttr = pattern
	local roleDices = {}
	local selfFaces = roleDices
	local isJudged = true
	local archiveNO = RoguelikeAgent.instance:generateArchive(type, roomId, enemyId, enemyOuterHp, enemyInnerHp, round, heroId, enemyFace, selectedAttr, selfFaces, isJudged)

	RoguelikeAgent.instance:sendJudgeArchiveRequest(archiveNO)
end

return M
