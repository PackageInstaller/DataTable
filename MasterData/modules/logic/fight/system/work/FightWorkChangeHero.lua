-- chunkname: @modules/logic/fight/system/work/FightWorkChangeHero.lua

module("modules.logic.fight.system.work.FightWorkChangeHero", package.seeall)

local FightWorkChangeHero = class("FightWorkChangeHero", FightEffectBase)

function FightWorkChangeHero:onStart()
	local version = FightModel.instance:getVersion()

	if version < 4 then
		self:onDone(true)

		return
	end

	if not self.actEffectData.entity then
		self:onDone(true)

		return
	end

	self:com_registTimer(self._delayDone, 5)

	self._targetId = self.actEffectData.targetId

	FightRenderOrderMgr.instance:unregister(self._targetId)

	self._targetEntity = FightHelper.getEntity(self._targetId)

	if FightEntityDataHelper.isPlayerUid(self._targetId) then
		self._targetEntity = nil
	end

	self._changedId = self.actEffectData.entity.id
	FightDataHelper.tempMgr.canNotSelectEntityIdDic[self.actEffectData.entity.id] = true
	self._changedSubEntity = FightHelper.getEntity(self._changedId)
	self._changedEntityMO = FightDataHelper.entityMgr:getById(self._changedId)

	if not self._changedEntityMO then
		local str = "换人失败,找不到上场的实体, episodeId:%s, battleId:%s, entityId:%s"
		local episodeId = FightDataHelper.fieldMgr.episodeId
		local battleId = FightDataHelper.fieldMgr.battleId
		local entityId = self._changedId

		str = string.format(str, episodeId, battleId, entityId)
		str = str .. "配队: "

		for index, entityData in pairs(FightDataHelper.entityMgr:getSideList(FightEnum.EntitySide.MySide, nil, true)) do
			str = str .. entityData:getEntityName() .. ","
		end

		logError(str)
	end

	FightController.instance:dispatchEvent(FightEvent.BeforeChangeSubHero, self._targetId, self._changedId)

	self._seasonUseChangeHero = FightModel.instance:isSeason2() and self.actEffectData.configEffect == 1

	if self._changedEntityMO.side == FightEnum.EntitySide.MySide then
		if self._seasonUseChangeHero then
			self:_startChangeHero()
		elseif self._changedSubEntity and self._changedSubEntity.spine:getSpineGO() ~= nil then
			self:_startChangeHero()
		else
			FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self._onSubSpineLoaded, self)

			self._toBuildSubId = self._changedEntityMO.id

			if not self._changedSubEntity then
				local subEntity = FightGameMgr.entityMgr:newEntity(self._changedEntityMO)

				if subEntity then
					local stanceConfig = lua_stance.configDict[FightHelper.getEntityStanceId(self._changedEntityMO)]

					if stanceConfig then
						local pos = stanceConfig.subPos1

						transformhelper.setLocalPos(subEntity.go.transform, pos[1] or 0, pos[2] or 0, pos[3] or 0)
					end
				end
			end
		end
	else
		self:_startChangeHero()
	end
end

function FightWorkChangeHero:_startChangeHero()
	FightController.instance:dispatchEvent(FightEvent.OnStartChangeEntity, self._changedEntityMO)

	if self._targetEntity then
		local fightSpeed = FightModel.instance:getSpeed()

		if self._targetEntity.spineRenderer then
			self._targetEntity.spineRenderer:setAlpha(0, 0.4 / fightSpeed)

			local effectPath = "always/ui_renwuxiaoshi"
			local hangPoint

			if self.actEffectData.configEffect == 1 then
				effectPath = "buff/buff_huanren"
				hangPoint = ModuleEnum.SpineHangPoint.mountmiddle
			end

			if not self._seasonUseChangeHero then
				local effectWrap = self._targetEntity.effect:addHangEffect(effectPath, hangPoint)

				effectWrap:setLocalPos(0, 0, 0)
				FightRenderOrderMgr.instance:onAddEffectWrap(self._targetEntity.id, effectWrap)
			end
		end

		if FightModel.instance:isSeason2() then
			self:_targetEntityQuitFinish()
			AudioMgr.instance:trigger(410000103)
		else
			TaskDispatcher.runDelay(self._targetEntityQuitFinish, self, 0.4 / fightSpeed)
		end
	else
		self:_targetEntityQuitFinish()
	end
end

function FightWorkChangeHero:_targetEntityQuitFinish()
	if self._targetEntity then
		FightGameMgr.entityMgr:delEntity(self._targetEntity.id)
	end

	local is_my_side = self._changedEntityMO.side == FightEnum.EntitySide.MySide

	if is_my_side and not self._seasonUseChangeHero then
		self:_playJumpTimeline()
	else
		self:_entityEnter()
	end
end

function FightWorkChangeHero:_playJumpTimeline()
	local posX, posY, posZ = FightHelper.getEntityStandPos(self._changedEntityMO)
	local temp_data = {
		actId = 0,
		customType = "change_hero",
		actEffect = {
			{
				targetId = self._targetId
			}
		},
		fromId = self._changedId,
		toId = self._targetId,
		actType = FightEnum.ActType.SKILL,
		forcePosX = posX,
		forcePosY = posY,
		forcePosZ = posZ
	}
	local time_line
	local skin_config = SkinConfig.instance:getSkinCo(self._changedEntityMO.skin)

	if skin_config and not string.nilorempty(skin_config.alternateSpineJump) then
		time_line = skin_config.alternateSpineJump
	end

	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)

	self._subEntity = FightGameMgr.entityMgr:buildTempSceneEntity("tibushangzhen" .. self._changedEntityMO.id)
	FightWorkChangeHero.playingChangeHero = true

	self._subEntity.skill:playTimeline(time_line or "change_hero_common", temp_data)
end

function FightWorkChangeHero:_removeSubEntity()
	if self._changedSubEntity and self._changedSubEntity.go then
		self._changedSubEntity:disposeSelf()

		self._changedSubEntity = nil
	end
end

function FightWorkChangeHero:_onSkillPlayFinish(entity)
	if entity == self._subEntity then
		self:_removeSubEntity()
	end
end

function FightWorkChangeHero:_onSkillPlayStart(entity)
	if entity == self._subEntity then
		self._timeline_duration = entity.skill and entity.skill:getCurTimelineDuration()

		TaskDispatcher.runDelay(self._entityEnter, self, self._timeline_duration * 0.8)
	end
end

function FightWorkChangeHero:_entityEnter()
	FightGameMgr.entityMgr.entityDic[self._changedId] = nil

	if self._changedSubEntity then
		if self._timeline_duration then
			local _time = self._timeline_duration * 0.2 / FightModel.instance:getSpeed()

			self._changedSubEntity:setAlpha(0, _time)

			self._need_invoke_remove_sub_entity = true
		else
			self._changedSubEntity:disposeSelf()
		end
	end

	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self._onEnterEntitySpineLoadFinish, self)

	self._newEntity = FightGameMgr.entityMgr:newEntity(self._changedEntityMO)
end

function FightWorkChangeHero:_onEnterEntitySpineLoadFinish(unitSpine)
	if unitSpine.unitSpawn.id == self._changedEntityMO.id then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onEnterEntitySpineLoadFinish, self)

		local entity = FightGameMgr.entityMgr:getEntity(self._changedEntityMO.id)

		if self._seasonUseChangeHero then
			if entity then
				entity:resetEntity()
			end

			self:_onEntityBornDone()

			local effectPath = "always/ui_renwuxiaoshi"
			local hangPoint

			if self.actEffectData.configEffect == 1 then
				effectPath = "buff/buff_huanren"
				hangPoint = ModuleEnum.SpineHangPoint.mountmiddle
			end

			local effectWrap = entity.effect:addHangEffect(effectPath, hangPoint, nil, 2)

			effectWrap:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(entity.id, effectWrap)

			local buffComp = entity and entity.buff

			if buffComp then
				xpcall(buffComp.dealStartBuff, __G__TRACKBACK__, buffComp)
			end

			return
		end

		entity.IS_SUB_ENTITY_ENTER = true
		self._work = FightWorkStartBornNormal.New(entity, false)

		self._work:registerDoneListener(self._onEntityBornDone, self)
		self._work:onStart()

		if entity:isMySide() then
			FightAudioMgr.instance:playHeroVoiceRandom(self._changedEntityMO.modelId, CharacterEnum.VoiceType.EnterFight)
		end
	end
end

function FightWorkChangeHero.sortSubList()
	return
end

function FightWorkChangeHero:_onEntityBornDone()
	if self._work then
		self._work:unregisterDoneListener(self._onEntityBornDone, self)
	end

	FightController.instance:dispatchEvent(FightEvent.OnChangeEntity, self._newEntity)
	FightGameMgr.entityMgr:showSubEntity()
	self:onDone(true)
end

function FightWorkChangeHero:_onSubSpineLoaded(unitSpine)
	if unitSpine.unitSpawn.id == self._toBuildSubId then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onSubSpineLoaded, self)

		self._changedSubEntity = FightHelper.getEntity(self._changedId)

		self:_startChangeHero()
	end
end

function FightWorkChangeHero:_delayDone()
	logError("换人超时")
	self:onDone(true)
end

function FightWorkChangeHero:clearWork()
	FightWorkChangeHero.playingChangeHero = false

	if self._subEntity then
		FightGameMgr.entityMgr:delEntity(self._subEntity.id)

		self._subEntity = nil
	end

	if self._need_invoke_remove_sub_entity and self._changedSubEntity then
		self._changedSubEntity:disposeSelf()

		self._changedSubEntity = nil
	end

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

function FightWorkChangeHero:onDestructor()
	FightDataHelper.tempMgr.canNotSelectEntityIdDic[self.actEffectData.entity.id] = nil
end

return FightWorkChangeHero
