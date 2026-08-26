-- chunkname: @modules/logic/fight/system/work/FightWorkStepChangeHero.lua

module("modules.logic.fight.system.work.FightWorkStepChangeHero", package.seeall)

local FightWorkStepChangeHero = class("FightWorkStepChangeHero", BaseWork)

function FightWorkStepChangeHero:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkStepChangeHero:isMySide()
	local fromEntityMO = FightDataHelper.entityMgr:getById(self.fightStepData.fromId)

	if fromEntityMO then
		return fromEntityMO.side == FightEnum.EntitySide.MySide
	end

	return tonumber(self.fightStepData.fromId) > 0
end

function FightWorkStepChangeHero:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 5)

	self.from_id = self.fightStepData.fromId
	self.to_id = self.fightStepData.toId

	FightDataHelper.calMgr:playChangeHero(self.fightStepData)

	self._changedEntityMO = FightDataHelper.entityMgr:getById(self.from_id)

	FightController.instance:dispatchEvent(FightEvent.BeforeChangeSubHero, self.to_id)

	local fromEntity = FightHelper.getEntity(self.from_id)

	if fromEntity and fromEntity.spine:getSpineGO() ~= nil then
		self:_startChangeHero()
	else
		local fromEntityMO = FightDataHelper.entityMgr:getById(self.from_id)
		local existSubEntity = FightHelper.getSubEntity(fromEntityMO.side)

		if fromEntityMO and existSubEntity then
			FightGameMgr.entityMgr:delEntity(existSubEntity.id)
			FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self._onSubSpineLoaded, self)

			self._toBuildSubId = fromEntityMO.id

			local subEntity = FightGameMgr.entityMgr:newEntity(fromEntityMO)

			if subEntity then
				local stanceConfig = lua_stance.configDict[FightHelper.getEntityStanceId(self._changedEntityMO)]

				if stanceConfig then
					local pos = stanceConfig.subPos1

					transformhelper.setLocalPos(subEntity.go.transform, pos[1] or 0, pos[2] or 0, pos[3] or 0)
				end
			end
		else
			self:_startChangeHero()
		end
	end
end

function FightWorkStepChangeHero:_startChangeHero()
	FightController.instance:dispatchEvent(FightEvent.OnStartChangeEntity, self._fromEntityMO)

	self.from_entity = FightGameMgr.entityMgr:getEntity(self.from_id)
	self.from_entity_mo = FightDataHelper.entityMgr:getById(self.from_id)
	self.to_entity = FightGameMgr.entityMgr:getEntity(self.to_id)
	self.to_entity_mo = FightDataHelper.entityMgr:getById(self.to_id)

	if self.to_entity then
		local fightSpeed = FightModel.instance:getSpeed()

		if self.to_entity.spineRenderer then
			self.to_entity.spineRenderer:setAlpha(0, 0.4 / fightSpeed)

			local effectWrap = self.to_entity.effect:addHangEffect("always/ui_renwuxiaoshi")

			effectWrap:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(self.to_entity.id, effectWrap)
		end

		TaskDispatcher.runDelay(self._targetEntityQuitFinish, self, 0.4 / fightSpeed)
	else
		self:_targetEntityQuitFinish()
	end
end

function FightWorkStepChangeHero:_targetEntityQuitFinish()
	self._jump_end_pos = {}
	self._jump_end_pos.x, self._jump_end_pos.y, self._jump_end_pos.z = FightHelper.getEntityStandPos(self._changedEntityMO)

	if self.to_entity then
		FightGameMgr.entityMgr:delEntity(self.to_entity.id)

		self.to_entity = nil
	end

	local is_my_side = self.from_entity_mo.side == FightEnum.EntitySide.MySide

	if is_my_side then
		self:_playJumpTimeline()
	else
		self:_entityEnter()
	end
end

function FightWorkStepChangeHero:_onSkillPlayFinish(entity)
	if entity == self._subEntity then
		self:_removeSubEntity()
	end
end

function FightWorkStepChangeHero:_onSkillPlayStart(entity)
	if entity == self._subEntity then
		self._timeline_duration = entity.skill and entity.skill:getCurTimelineDuration()

		TaskDispatcher.runDelay(self._entityEnter, self, self._timeline_duration * 0.8)
	end
end

function FightWorkStepChangeHero:_playJumpTimeline()
	local temp_data = {
		actId = 0,
		customType = "change_hero",
		actEffect = {
			{
				targetId = self.to_id
			}
		},
		fromId = self.from_id,
		toId = self.to_id,
		actType = FightEnum.ActType.SKILL,
		forcePosX = self._jump_end_pos.x,
		forcePosY = self._jump_end_pos.y,
		forcePosZ = self._jump_end_pos.z
	}
	local time_line
	local skin_config = SkinConfig.instance:getSkinCo(self.from_entity_mo.skin)

	if skin_config and not string.nilorempty(skin_config.alternateSpineJump) then
		time_line = skin_config.alternateSpineJump
	end

	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)

	self._subEntity = FightGameMgr.entityMgr:buildTempSceneEntity(self.from_id)
	FightWorkStepChangeHero.playingChangeHero = true

	self._subEntity.skill:playTimeline(time_line or "change_hero_common", temp_data)
end

function FightWorkStepChangeHero:_removeSubEntity()
	if self.from_entity and self.from_entity.go then
		self.from_entity:disposeSelf()

		self.from_entity = nil
	end
end

function FightWorkStepChangeHero:_entityEnter()
	if self.from_entity then
		if self._timeline_duration then
			local _time = self._timeline_duration * 0.2 / FightModel.instance:getSpeed()

			self.from_entity:setAlpha(0, _time)

			self._need_invoke_remove_sub_entity = true
			FightGameMgr.entityMgr.entityDic[self.from_entity.id] = nil
		else
			FightGameMgr.entityMgr:delEntity(self.from_entity.id)
		end
	end

	self.from_entity_mo:onChangeHero()
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self._onEnterEntitySpineLoadFinish, self)

	self._newEntity = FightGameMgr.entityMgr:newEntity(self.from_entity_mo)
end

function FightWorkStepChangeHero:_onEnterEntitySpineLoadFinish(unitSpine)
	if unitSpine.unitSpawn.id == self.from_entity_mo.id then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onEnterEntitySpineLoadFinish, self)

		local entity = FightGameMgr.entityMgr:getEntity(self.from_entity_mo.id)

		self._work = FightWorkStartBornNormal.New(entity, false)

		self._work:registerDoneListener(self._onEntityBornDone, self)
		self._work:onStart()

		if entity:isMySide() then
			FightAudioMgr.instance:playHeroVoiceRandom(self.from_entity_mo.modelId, CharacterEnum.VoiceType.EnterFight)
		end
	end
end

function FightWorkStepChangeHero:_onEntityBornDone()
	self._work:unregisterDoneListener(self._onEntityBornDone, self)
	FightController.instance:dispatchEvent(FightEvent.OnChangeEntity, self._newEntity)

	if self.from_entity_mo and self.from_entity_mo.side == FightEnum.EntitySide.MySide then
		local subList = FightDataHelper.entityMgr:getMySubList()
		local nextSubEntityMO = subList[1]

		if nextSubEntityMO then
			self.nextSubEntityMO = nextSubEntityMO

			FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self._onNextSubSpineLoaded, self)

			self._nextSubEntity = FightGameMgr.entityMgr:newEntity(nextSubEntityMO)
		end
	end

	local to_entity_mo = FightDataHelper.entityMgr:getById(self.to_id)

	if to_entity_mo then
		to_entity_mo:onChangeHero()
	end

	self:onDone(true)
end

function FightWorkStepChangeHero:_onNextSubSpineLoaded(unitSpine)
	if unitSpine.unitSpawn.id == self.nextSubEntityMO.id then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onNextSubSpineLoaded, self)

		local sub_entity = FightGameMgr.entityMgr:getEntity(self.nextSubEntityMO.id)

		self._nextSubBornFlow = FlowSequence.New()

		self._nextSubBornFlow:addWork(FightWorkStartBornNormal.New(sub_entity, true))
		self._nextSubBornFlow:start()
	end
end

function FightWorkStepChangeHero:_onSubSpineLoaded(unitSpine)
	if unitSpine.unitSpawn.id == self._toBuildSubId then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onSubSpineLoaded, self)
		self:_startChangeHero()
	end
end

function FightWorkStepChangeHero:_delayDone()
	logError("change entity step timeout, targetId = " .. self.fightStepData.fromId .. " -> " .. self.fightStepData.toId)
	self:onDone(true)
end

function FightWorkStepChangeHero:clearWork()
	FightWorkStepChangeHero.playingChangeHero = false

	if self._subEntity then
		FightGameMgr.entityMgr:delEntity(self._subEntity.id)

		self._subEntity = nil
	end

	if self._need_invoke_remove_sub_entity then
		self:_removeSubEntity()
	end

	TaskDispatcher.cancelTask(self._delayDone, self)
	TaskDispatcher.cancelTask(self._targetEntityQuitFinish, self)
	TaskDispatcher.cancelTask(self._entityEnter, self)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onSubSpineLoaded, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onNextSubSpineLoaded, self)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onEnterEntitySpineLoadFinish, self)

	self.fightStepData = nil

	if self._work then
		self._work:unregisterDoneListener(self._onEntityBornDone, self)
		self._work:onStop()

		self._work = nil
	end

	self._timeline_duration = nil
end

function FightWorkStepChangeHero:onResume()
	logError("change entity step can't resume")
end

function FightWorkStepChangeHero:onDestroy()
	if self._nextSubBornFlow then
		self._nextSubBornFlow:stop()

		self._nextSubBornFlow = nil
	end

	FightWorkStepChangeHero.super.onDestroy(self)
end

return FightWorkStepChangeHero
