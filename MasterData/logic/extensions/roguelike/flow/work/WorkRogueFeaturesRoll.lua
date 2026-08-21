-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/WorkRogueFeaturesRoll.lua

module("logic.extensions.roguelike.flow.work.WorkRogueFeaturesRoll", package.seeall)

local M = class("WorkRogueFeaturesRoll", WorkBase)
local kReduceSan = "ReduceSan"
local kReduceCoin = "ReduceCoin"

function M:onEnter(context)
	local judgeMgr = RogueMgr.instance:getRogueFlow().judgeMgr

	self._featureDices = judgeMgr:getFeaturePatterns() or RogueMgr.instance:getModel():getCurMonster().monsterProp:getFeaturesDices()

	local isFirst = RogueMgr.instance:getModel():getIsFirstRondRoleIndex()

	if isFirst then
		local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Round")
		local msg = string.format(format, RogueMgr.instance:getStateMgr():getRoundIndex())

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
	end

	if judgeMgr:getNeedNewFeature() then
		if not judgeMgr:getIsNeedNewFeature() and judgeMgr:getCurRoundCombatDiceCount() ~= nil and judgeMgr:getCurRoundCombatDiceCount() ~= 0 and judgeMgr:getCombatDiceFeatures() ~= nil then
			local index = RogueMgr.instance:getRogueFlow().judgeMgr:getFeatureIndex()

			if not index then
				for k, v in pairs(self._featureDices) do
					if v == judgeMgr:getCombatDiceFeatures() then
						index = k

						RogueMgr.instance:getRogueFlow().judgeMgr:setFeatureIndex(index)
					end
				end
			end

			self:prepareData(judgeMgr:getCombatDiceFeatures())
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_FEATURES_ROLL_RESULT, judgeMgr:getCombatDiceFeatures())
			self:onDone(WorkResult.Succeed)

			return
		end

		if not RogueMgr.instance:getNeedShowDice() then
			local index = math.random(1, #self._featureDices)
			local features = self._featureDices[index]

			RogueMgr.instance:getRogueFlow().judgeMgr:setFeatureIndex(index)
			judgeMgr:setCombatDiceFeatures(features)
			print("随机设置特征骰为", features)
			self:prepareData(features)
			self:execAction(features)
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_FEATURES_ROLL_RESULT, features)
			self:onDone(WorkResult.Succeed)

			return
		end
	else
		local index = RogueMgr.instance:getRogueFlow().judgeMgr:getFeatureIndex()

		if not index then
			for k, v in pairs(self._featureDices) do
				if v == judgeMgr:getCombatDiceFeatures() then
					index = k

					RogueMgr.instance:getRogueFlow().judgeMgr:setFeatureIndex(index)
				end
			end
		end

		if judgeMgr:getCombatDiceFeatures() ~= nil then
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_FEATURES_ROLL_RESULT, judgeMgr:getCombatDiceFeatures())
		end

		self:onDone(WorkResult.Succeed)

		return
	end

	RogueMgr.instance:getRogueFlow().judgeMgr:setNeedNewFeature(false)
	settimer(0.1, self.checkHadDiceBar, self, true)
end

function M:checkHadDiceBar()
	removetimer(self.checkHadDiceBar, self)
	self:showRollDiceAnimation()
end

function M:showRollDiceAnimation()
	removetimer(self.showRollDice, self)

	local count = math.random(1, 6)
	local interval = math.random(8, 10) / 50

	self._totalRollTime = count
	self._lastFeature = count
	self._curRollTime = 0

	if RoguelikeConst.IsGuildMode() then
		local round = RogueMgr.instance:getStateMgr():getRoundIndex()
		local guidePatters = RoguelikeConfig.instance:getConstByName("GuidFeaturePattern").numValues
		local index = guidePatters[round] and guidePatters[round] or math.random(1, 6)

		self._totalRollTime = 6 + index
	end

	self:showFeatureCardAni()
end

function M:showFeatureCardAni()
	local co = RoguelikeConfig.instance:getMonsterActionById(self._featureDices[self._lastFeature])
	local prop = RogueMgr.instance:getModel():getCurMonster().monsterProp
	local addBase = RogueMgr.instance:getStateMgr():getMonsterAttrBase()
	local data = {}

	data.name = co.name

	local pattern = RoguelikeUtil.instance:convertCAttrType2SType(tonumber(co.icon))

	data.attr = RoguelikeConst.AttrType2Name[pattern]
	data.attrLevel = 0

	local round1, round2 = prop:getActionSectionRound(self._lastFeature)
	local rate = 1
	local effectTexts = {}

	for k, v in pairs(co.effect) do
		local effectCo = RoguelikeConfig.instance:getEffectById(v)

		if effectCo then
			local effectParam = effectCo.params

			if string.find(effectParam, "#") then
				rate = tonumber(string.split(effectParam, "#")[2]) or 1
			else
				rate = tonumber(effectParam) or 1
			end

			local round1Temp = math.floor((round1 + addBase) * rate)
			local round2Temp = math.floor((round2 + addBase) * rate)

			table.insert(effectTexts, round1Temp ~= round2Temp and string.format("<color=#ffffff>%s~%s</color>", round1Temp, round2Temp) or string.format("<color=#ffffff>%s</color>", round1Temp))
		end
	end

	local roundText = round1 ~= round2 and string.format("<color=#ffffff>%s~%s</color>", round1, round2) or string.format("<color=#ffffff>%s</color>", round1)
	local effectDesc = ""

	if #co.effect == 1 then
		effectDesc = string.format(co.effectDesc, effectTexts[1])
	elseif #co.effect == 2 then
		effectDesc = string.format(co.effectDesc, effectTexts[1], effectTexts[2])
	elseif #co.effect == 3 then
		effectDesc = string.format(co.effectDesc, effectTexts[1], effectTexts[2], effectTexts[3])
	elseif #co.effect == 4 then
		effectDesc = string.format(co.effectDesc, effectTexts[1], effectTexts[2], effectTexts[3], effectTexts[4])
	end

	data.effect = effectDesc
	data.pattern = tonumber(co.icon)
	data.isDisplay = true
	data.co = co

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_CUR_MONSTER_CARD, data)
	settimer(2, self.dealMonsterAction, self, false)
end

function M:dealMonsterAction()
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_battle_charstop)
	RogueMgr.instance:getRogueFlow().judgeMgr:setFeatureIndex(self._lastFeature)

	local features = self._featureDices[self._lastFeature]
	local actionCo = RoguelikeConfig.instance:getMonsterActionById(features)

	RogueMgr.instance:getRogueFlow().judgeMgr:setCombatDiceFeatures(tonumber(actionCo.icon))
	self:prepareData(features)
	self:execAction(features)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_FEATURES_ROLL_RESULT, features, true, self._lastFeature)
	self:onDone(WorkResult.Succeed)
end

function M:showRollDice()
	printError("播放卡牌动画", self._curRollTime, self._totalRollTime)

	if self._curRollTime > self._totalRollTime then
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_battle_charstop)
		removetimer(self.showRollDice, self)
		RogueMgr.instance:getRogueFlow().judgeMgr:setFeatureIndex(self._lastFeature)

		local features = self._featureDices[self._lastFeature]
		local actionCo = RoguelikeConfig.instance:getMonsterActionById(features)
		local msg = string.format(RoguelikeConfig.getBroadCast("Monster_Exec_Action"), RogueMgr.instance:getModel():getCurMonster().monsterProp:getName(), actionCo.name)

		RogueMgr.instance:getRogueFlow().judgeMgr:setCombatDiceFeatures(tonumber(actionCo.icon))
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
		self:prepareData(features)
		self:execAction(features)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_FEATURES_ROLL_RESULT, features, true, self._lastFeature)
		self:onDone(WorkResult.Succeed)

		return
	end

	local temp = self._curRollTime % 6

	temp = temp == 0 and 6 or temp
	self._lastFeature = temp
	self._curRollTime = self._curRollTime + 1
end

function M:prepareData(feature)
	local actionCo = RoguelikeConfig.instance:getMonsterActionById(feature)

	if actionCo then
		local judgeModel = RogueMgr.instance:getRogueFlow().judgeModel
		local isMonsterAttack, paramsA = judgeModel:getMonsterActionIsTakeDamage()

		if isMonsterAttack then
			local damage = RogueMgr.instance:getRogueFlow().judgeModel:getMonsterAttackDamage(paramsA)
		end
	end
end

function M:execAction(feature)
	local actionCo = RoguelikeConfig.instance:getMonsterActionById(feature)
	local monsterName = RogueMgr.instance:getModel():getCurMonster().monsterProp:getName()

	if actionCo then
		local judgeModel = RogueMgr.instance:getRogueFlow().judgeModel
		local isMonsterAttack, paramsA = judgeModel:getMonsterActionIsTakeDamage()
		local isDiceWall, paramsB = judgeModel:getMonsterActionIsDiceWall()
		local isReduceSan, paramsC = judgeModel:getMonsterActionIsReduceSan()
		local isReduceCoin, paramsD = judgeModel:getMonsterActionIsReduceCoin()

		if isMonsterAttack then
			local damage = RogueMgr.instance:getRogueFlow().judgeModel:getMonsterAttack()
			local msg = string.format(RoguelikeConfig.getBroadCast("Monster_Will_Be_Attack"), monsterName, damage)

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
		end

		if isDiceWall then
			local defenseCount = RogueMgr.instance:getRogueFlow().judgeModel:getMonsterDefenseWall(paramsB)
			local msg = string.format(RoguelikeConfig.getBroadCast("Monster_Can_Defense"), monsterName, defenseCount)

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
		end

		if isReduceSan then
			local count = RogueMgr.instance:getRogueFlow().judgeModel:getMonsterReduceSanCount(paramsC)
			local effectId = RogueMgr.instance:getRogueFlow().judgeModel:getCurMonsterActionEffectByClientProgram("ReduceSan")

			RoguelikeController.instance:execEffectIds({
				effectId
			}, nil, nil, count * -1)

			local msg = string.format(RoguelikeConfig.getBroadCast("Monster_Reduce_San"), monsterName, count)

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
		end

		if isReduceCoin then
			local count = RogueMgr.instance:getRogueFlow().judgeModel:getMonsterReduceCoinCount(paramsD)
			local effectId = RogueMgr.instance:getRogueFlow().judgeModel:getCurMonsterActionEffectByClientProgram("ReduceCoin")

			RoguelikeController.instance:execEffectIds({
				effectId
			}, nil, nil, count * -1)

			local msg = string.format(RoguelikeConfig.getBroadCast("Monster_Reduce_Coin"), monsterName, count)

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
		end
	end

	local actionId = RogueMgr.instance:getRogueFlow().judgeMgr:getMonsterActionId()

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_FORECAST_LINE, true, actionId, true)
	settimer(2, function()
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_FORECAST_LINE, false, actionId, true)
	end, self, false)
end

function M:onExit(isInterrupt)
	removetimer(self.checkDiceStop, self)
	removetimer(self.checkHadDiceBar, self)
	removetimer(self.showRollDice, self)
	removetimer(self.dealMonsterAction, self)
end

return M
