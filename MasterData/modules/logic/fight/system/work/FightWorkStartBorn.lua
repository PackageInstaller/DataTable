-- chunkname: @modules/logic/fight/system/work/FightWorkStartBorn.lua

module("modules.logic.fight.system.work.FightWorkStartBorn", package.seeall)

local FightWorkStartBorn = class("FightWorkStartBorn", FightWorkItem)
local BornTime = 10

function FightWorkStartBorn:onStart()
	self.playedVoice = false
	FightAudioMgr.instance.enterFightVoiceHeroID = nil
	self._flowParallel = self:com_registFlowParallel()

	local entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)

	for _, entity in ipairs(entityList) do
		local entityMo = entity:getMO()
		local continue = not not entityMo:isAssistBoss()

		if entityMo:isAct191Boss() then
			continue = true
		end

		if not ((entity.spine and not entity.spine:hasAnimation(SpineAnimState.born) or nil) and true) then
			if not self.playedVoice then
				self.playedVoice = true

				self:_playEnterVoice()
			end

			local bornWork = FightWorkStartBornNormal.New(entity, true)

			bornWork.dontDealBuff = true

			if FightDataHelper.entityMgr:isSub(entity.id) then
				bornWork:onStart()
			else
				self._flowParallel:addWork(bornWork)
			end
		else
			if entity.nameUI then
				entity.nameUI:setActive(true)
			end

			entity:setAlpha(1, 0)
		end
	end

	entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, true)

	for _, entity in ipairs(entityList) do
		local entityData = entity:getMO()

		if entityData and lua_fight_monster_3d.configDict[entityData.skin] then
			entity.spine._curAnimState = nil

			local bornWork = entity.spine:registworkPlayAnim("idle")

			self._flowParallel:addWork(bornWork)
		end
	end

	TaskDispatcher.runDelay(self._onBornTimeout, self, BornTime)
	FightController.instance:dispatchEvent(FightEvent.OnStartFightPlayBorn)
	self._flowParallel:registFinishCallback(self._onBornEnd, self)
	self:playWorkAndDone(self._flowParallel)
end

function FightWorkStartBorn:_playEnterVoice()
	FightAudioMgr.instance.enterFightVoiceHeroID = nil

	local entityNoSubList = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, false)

	if entityNoSubList and #entityNoSubList > 0 then
		local randomEntity = entityNoSubList[math.random(#entityNoSubList)]
		local heroId = randomEntity:getMO().modelId

		FightAudioMgr.instance:playHeroVoiceRandom(heroId, CharacterEnum.VoiceType.EnterFight)

		FightAudioMgr.instance.enterFightVoiceHeroID = heroId
	end
end

function FightWorkStartBorn:_onBornEnd()
	FightAudioMgr.instance.enterFightVoiceHeroID = nil

	self:onDone(true)
end

function FightWorkStartBorn:_onBornTimeout()
	FightAudioMgr.instance.enterFightVoiceHeroID = nil

	logError("播放出生效果时间超过" .. BornTime .. "秒")
	self:onDone(true)
end

function FightWorkStartBorn:clearWork()
	TaskDispatcher.cancelTask(self._onBornTimeout, self)
end

return FightWorkStartBorn
