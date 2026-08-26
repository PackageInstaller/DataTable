-- chunkname: @modules/logic/versionactivity2_6/dicehero/controller/DiceHeroHelper.lua

module("modules.logic.versionactivity2_6.dicehero.controller.DiceHeroHelper", package.seeall)

local DiceHeroHelper = class("DiceHeroHelper")

function DiceHeroHelper:ctor()
	self._entityDict = {}
	self._cardDict = {}
	self._diceDict = {}
	self._diceTextureDict = {}
	self._effectItem = nil
	self._effectPool = {}
	self.flow = nil
	self.afterFlow = nil
end

function DiceHeroHelper:buildFlow(steps)
	local flow = FlowSequence.New()

	flow:addWork(DiceHeroFirstStepWork.New())

	for i, v in ipairs(steps) do
		local stepMo = DiceHeroFightStepMo.New()

		stepMo:init(v)

		local parallel = FlowParallel.New()

		parallel:addWork(DiceHeroActionWork.New(stepMo))

		local sequence = FlowSequence.New()

		for _, effectMo in ipairs(stepMo.effect) do
			local effectType = effectMo.effectType

			if not DiceHeroEnum.FightEffectTypeToName[effectType] then
				local effectName = ""
				local cls = _G[string.format("DiceHero%sWork", effectName)]

				if cls then
					sequence:addWork(cls.New(effectMo))
				end
			end
		end

		parallel:addWork(sequence)
		flow:addWork(parallel)
	end

	return flow
end

function DiceHeroHelper:startFlow(flow)
	if self.flow then
		logError("已有Flow执行中")
	end

	self.flow = flow

	self.flow:registerDoneListener(self.flowDone, self)
	self.flow:start()
end

function DiceHeroHelper:flowDone()
	self.flow = nil

	DiceHeroFightModel.instance:getGameData():onStepEnd()
	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.StepEnd)

	if DiceHeroFightModel.instance.finishResult ~= DiceHeroEnum.GameStatu.None then
		ViewMgr.instance:openView(ViewName.DiceHeroResultView, {
			status = DiceHeroFightModel.instance.finishResult
		})
		DiceHeroStatHelper.instance:sendFightEnd(DiceHeroFightModel.instance.finishResult, DiceHeroFightModel.instance.isFirstWin)

		DiceHeroFightModel.instance.finishResult = DiceHeroEnum.GameStatu.None
	end
end

function DiceHeroHelper:isInFlow()
	return self.flow ~= nil
end

function DiceHeroHelper:isNotInFlow()
	return not self:isInFlow()
end

function DiceHeroHelper:isShowCarNum(effectType)
	return effectType == DiceHeroEnum.SkillEffectType.Damage1 or effectType == DiceHeroEnum.SkillEffectType.Damage2 or effectType == DiceHeroEnum.SkillEffectType.ChangeShield1 or effectType == DiceHeroEnum.SkillEffectType.ChangeShield2 or effectType == DiceHeroEnum.SkillEffectType.ChangePower1 or effectType == DiceHeroEnum.SkillEffectType.ChangePower2
end

function DiceHeroHelper:setEffectItem(effectItem)
	self._effectItem = effectItem
end

function DiceHeroHelper:doEffect(type, fromPos, toPos, num)
	local effectItem = table.remove(self._effectPool)

	if not effectItem then
		local effectGo = gohelper.cloneInPlace(self._effectItem)

		effectItem = MonoHelper.addNoUpdateLuaComOnceToGo(effectGo, DiceHeroEffectItem)
	end

	gohelper.setActive(effectItem.go, true)
	effectItem:initData(type, fromPos, toPos, num)

	return effectItem
end

function DiceHeroHelper:returnEffectItemToPool(effectItem)
	gohelper.setActive(effectItem.go, false)
	table.insert(self._effectPool, effectItem)
end

function DiceHeroHelper:registerEntity(uid, obj)
	self._entityDict[uid] = obj
end

function DiceHeroHelper:unregisterEntity(uid)
	self._entityDict[uid] = nil
end

function DiceHeroHelper:getEntity(uid)
	return self._entityDict[uid]
end

function DiceHeroHelper:registerCard(skillId, obj)
	self._cardDict[skillId] = obj
end

function DiceHeroHelper:unregisterCard(skillId)
	self._cardDict[skillId] = nil
end

function DiceHeroHelper:getCard(skillId)
	return self._cardDict[skillId]
end

function DiceHeroHelper:registerDice(uid, obj)
	self._diceDict[uid] = obj
end

function DiceHeroHelper:unregisterDice(uid)
	self._diceDict[uid] = nil
end

function DiceHeroHelper:getDice(uid)
	return self._diceDict[uid]
end

function DiceHeroHelper:checkChapter(chapterId)
	return tostring(chapterId) == tostring(DiceHeroModel.instance.guideChapter)
end

function DiceHeroHelper:checkLevel(levelId)
	return tostring(levelId) == tostring(DiceHeroModel.instance.guideLevel)
end

function DiceHeroHelper:setDiceTexture(name, texture)
	self._diceTextureDict[name] = texture
end

function DiceHeroHelper:getDiceTexture(name)
	return self._diceTextureDict[name]
end

function DiceHeroHelper:clear()
	if self.flow then
		self.flow:onDestroyInternal()

		self.flow = nil
	end

	if self.afterFlow then
		self.afterFlow:onDestroyInternal()

		self.afterFlow = nil
	end

	self._entityDict = {}
	self._cardDict = {}
	self._diceDict = {}
	self._diceTextureDict = {}
	self._effectItem = nil
	self._effectPool = {}
end

DiceHeroHelper.instance = DiceHeroHelper.New()

return DiceHeroHelper
