-- chunkname: @modules/logic/fight/entity/comp/heroCustomComp/FightHero4_0HNJComp.lua

module("modules.logic.fight.entity.comp.heroCustomComp.FightHero4_0HNJComp", package.seeall)

local FightHero4_0HNJComp = class("FightHero4_0HNJComp", FightHeroCustomCompBase)

FightHero4_0HNJComp.EffectReleaseTime = 2
FightHero4_0HNJComp.SpecialEntityOrderOffset = -50

function FightHero4_0HNJComp:init(go)
	FightHero4_0HNJComp.super.init(self, go)

	self.entityMo = self.entity:getMO()
	self.skinId = self.entityMo and self.entityMo.skin
	self.entityId = self.entityMo and self.entityMo.uid
	self.spineCo = self.skinId and lua_fight_hnj_special_spine.configDict[self.skinId] or lua_fight_hnj_special_spine.configList[1]
	self.effectWrapDict = {}
	self.specialEntityName = "SPECIAL_HNJ"
	self.specialEntityId = self.entityId .. "_" .. self.specialEntityName
	self.side = self.entityMo.side

	self:refreshSpine()
	self:refreshHNJStageEffect()

	if self.skinId then
		local helmetCo = lua_fight_hnj_helmet_spine.configDict[self.skinId]

		if helmetCo then
			self.helmetComp = FightHero4_0HNJHelmetComp.New()

			self.helmetComp:init(self.entity, helmetCo)
		end
	end
end

function FightHero4_0HNJComp:addEventListeners()
	self.addEventCb(self, FightController.instance, FightEvent.OnSpineLoaded, self.onSpineLoaded, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayStart, self.onSkillPlayStart, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayFinish, self.onSkillPlayFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSetEntityRenderOrder, self.onSetEntityRenderOrder, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnEntityPosChange, self.onEntityPosChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnEntitySpinePosChange, self.onEntitySpinePosChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetEntityAlpha, self.onSetEntityAlpha, self)
	self.addEventCb(self, FightController.instance, FightEvent.QTE_OnStageChange, self.onQTEStageChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.On4_0HNJRemoveStageEffect, self.removeStageEffect, self)
	self.addEventCb(self, FightController.instance, FightEvent.On4_0HNJPlayAction, self.onPlayAction, self)
	self.addEventCb(self, FightController.instance, FightEvent.On4_0HNJAddEffect, self.onAddEffect, self)
	self.addEventCb(self, FightController.instance, FightEvent.On4_0HNJSetActive, self.onSetActive, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnTimelineTrackDone, self.onTimelineTrackDone, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnTimelineTrackDestructor, self.onTimelineTrackDestructor, self)
end

function FightHero4_0HNJComp:removeEventListeners()
	return
end

function FightHero4_0HNJComp:onQTEStageChange(curStage)
	self:refreshHNJStageEffect()
end

function FightHero4_0HNJComp:onSetActive(trackId, active)
	if not self.specialEntity then
		return
	end

	self.specialEntity:setActive(active)
end

function FightHero4_0HNJComp:onSetEntityAlpha(entityId, active, duration)
	if entityId ~= self.entityId then
		return
	end

	if not self.specialEntity then
		return
	end

	local alpha = active and 1 or 0

	self.specialEntity:setAlpha(alpha, duration)
end

function FightHero4_0HNJComp:onEntitySpinePosChange(entityId, posX, posY, posZ)
	if self.entityId ~= entityId then
		return
	end

	if not self.specialEntity then
		return
	end

	self.specialEntity.spine:setLocalPos(posX, posY, posZ)
end

function FightHero4_0HNJComp:onEntityPosChange(entityId, posX, posY, posZ)
	if self.entityId ~= entityId then
		return
	end

	if not self.specialEntity then
		return
	end

	self.specialEntity:setSrcEntityPos(posX, posY, posZ)
end

function FightHero4_0HNJComp:onPlayAction(trackId, actionName)
	if not self.specialEntity then
		return
	end

	self.playActionTrackId = trackId

	self.specialEntity.spine:play(actionName)

	if not self.addedAnimEvent then
		self.addedAnimEvent = true

		self.specialEntity.spine:addAnimEventCallback(self.onAnimEvent, self)
	end
end

function FightHero4_0HNJComp:onAnimEvent(actionName, eventName)
	if eventName == SpineAnimEvent.ActionComplete then
		self.specialEntity:resetAnimState()
	end
end

function FightHero4_0HNJComp:onAddEffect(trackId, effectName, hangPoint)
	if not self.specialEntity then
		return
	end

	local effectWrap = self.specialEntity.effect:addHangEffect(effectName, hangPoint)

	FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, effectWrap)
	effectWrap:setLocalPos(0, 0, 0)

	self.effectWrapDict[trackId] = effectWrap
end

function FightHero4_0HNJComp:onTimelineTrackDone(trackId)
	self:onTimelineEnd(trackId)
end

function FightHero4_0HNJComp:onTimelineTrackDestructor(trackId)
	self:onTimelineEnd(trackId)
end

function FightHero4_0HNJComp:onTimelineEnd(trackId)
	local effectWrap = self.effectWrapDict[trackId]

	if effectWrap then
		if self.specialEntity then
			self.specialEntity.effect:removeEffect(effectWrap)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entityId, effectWrap)
		end

		self.effectWrapDict[trackId] = nil
	end

	if trackId == self.playActionTrackId and self.specialEntity then
		self.specialEntity:resetAnimState()
	end
end

function FightHero4_0HNJComp:onSetEntityRenderOrder(entityId, order)
	if entityId ~= self.entityId then
		return
	end

	if not self.specialEntity then
		return
	end

	self.specialEntity:setRenderOrder(order + FightHero4_0HNJComp.SpecialEntityOrderOffset)
end

function FightHero4_0HNJComp:onSkillPlayStart(entity, curSkillId, fightStepData)
	if not self.specialEntity then
		return
	end

	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(curSkillId) and entity.id ~= self.entity.id then
		self.specialEntity:setActive(false)
	end
end

function FightHero4_0HNJComp:onSkillPlayFinish(entity, curSkillId, fightStepData)
	if not self.specialEntity then
		return
	end

	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(curSkillId) and entity.id ~= self.entity.id then
		self.specialEntity:setActive(true)
	end
end

function FightHero4_0HNJComp:onSpineLoaded(spine)
	if spine.entityId == self.specialEntityId then
		self.specialSpineLoadDone = true

		self:showEntity()
	end
end

function FightHero4_0HNJComp:onBuffUpdate(entityId, effectType, buffId, buffUid)
	if entityId ~= self.entityId then
		return
	end

	local buffCo = lua_skill_buff.configDict[buffId]

	if not buffCo then
		return
	end

	if buffCo.typeId ~= FightEnum.BuffTypeId_HNJEnergy then
		return
	end

	self:refreshSpine()
end

function FightHero4_0HNJComp:refreshSpine()
	if not self.spineCo then
		return
	end

	local count = FightHelper.get4_0HNJChannelCount(self.entityMo)
	local max = FightHelper.get4_0HNJChannelMax()
	local isDead = self.entityMo:isStatusDead()

	if count < max or isDead then
		self:removeSpine()

		return
	end

	self:createSpine()
end

function FightHero4_0HNJComp:loadDieAnim()
	if self.dieLoader then
		return
	end

	local dieAnim = self.spineCo.dieAnim

	self.dieAnimAbPath = FightHelper.getEntityAniPath(dieAnim)
	self.dieAnimRes = ResUrl.getEntityAnim(dieAnim)
	self.dieLoader = MultiAbLoader.New()

	self.dieLoader:addPath(self.dieAnimAbPath)
	self.dieLoader:startLoad(self.onLoadDieAnimDone, self)
end

function FightHero4_0HNJComp:onLoadDieAnimDone()
	local assetItem = self.dieLoader:getFirstAssetItem()

	if not assetItem then
		return
	end

	self.dieLoaderDone = true
	self.dieAnim = assetItem:GetResource(self.dieAnimRes)

	if self.dieAnim then
		self.dieAnim.legacy = true
	end

	self:removeSpine()
end

function FightHero4_0HNJComp:removeSpine()
	if not self.specialEntity then
		return
	end

	if not self.dieLoaderDone then
		self:loadDieAnim()

		return
	end

	self.dying = true

	local duration = self.spineCo.dieDuration / FightModel.instance:getSpeed()

	self.dieEffectWrap = self.specialEntity.effect:addHangEffect(self.spineCo.dieEffect, self.spineCo.diePoint, self.side, duration)

	self.dieEffectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, self.dieEffectWrap)

	local audioId = self.spineCo.dieAudio

	if audioId and audioId > 0 then
		AudioMgr.instance:trigger(audioId)
	end

	self:playSpineAnim(self.dieAnim, self.spineCo.dieAnimDuration)
	TaskDispatcher.runDelay(self._removeSpine, self, duration)
end

function FightHero4_0HNJComp:resetSpecialEntity()
	TaskDispatcher.cancelTask(self._removeSpine, self)
	TaskDispatcher.cancelTask(self.stopAnimComp, self)

	if self.specialEntity then
		if self.dieEffectWrap then
			self.specialEntity.effect:removeEffect(self.dieEffectWrap)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entityId, self.dieEffectWrap)

			self.dieEffectWrap = nil
		end

		if self.effectWrap then
			self.specialEntity.effect:removeEffect(self.effectWrap)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entityId, self.effectWrap)

			self.effectWrap = nil
		end

		if self.bornEffect then
			self.specialEntity.effect:removeEffect(self.bornEffect)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entityId, self.bornEffect)

			self.bornEffect = nil
		end
	end

	if self.animComp then
		self.animComp.enabled = false
	end

	self.dying = nil
end

function FightHero4_0HNJComp:createSpine()
	if self.dying then
		self:resetSpecialEntity()
	end

	if self.specialEntity then
		self:showEntity()

		return
	end

	local resPath = string.format("roles/%s.prefab", self.spineCo.resPath)

	self.specialEntity = FightGameMgr.entityMgr:buildTempSpine(resPath, self.specialEntityId, self.side, nil, FightEntitySpecialHNJ, self.specialEntityName)

	self.specialEntity:setSrcEntityMo(self.entityMo)
	self.specialEntity:setHNJSpecialCo(self.spineCo)
	self:loadBornAnim()
end

function FightHero4_0HNJComp:loadBornAnim()
	if self.bornLoader then
		return
	end

	local bornAnim = self.spineCo.bornAnim

	self.bornAnimAbRes = FightHelper.getEntityAniPath(bornAnim)
	self.bornAnimRes = ResUrl.getEntityAnim(bornAnim)
	self.bornLoader = MultiAbLoader.New()

	self.bornLoader:addPath(self.bornAnimAbRes)
	self.bornLoader:startLoad(self.onLoadBornAnimDone, self)
end

function FightHero4_0HNJComp:onLoadBornAnimDone()
	local assetItem = self.bornLoader:getFirstAssetItem()

	if not assetItem then
		return
	end

	self.bornLoadDone = true
	self.bornAnim = assetItem:GetResource(self.bornAnimRes)

	if self.bornAnim then
		self.bornAnim.legacy = true
	end

	self:showEntity()
end

function FightHero4_0HNJComp:showEntity()
	if not self.bornLoadDone then
		return
	end

	if not self.specialSpineLoadDone then
		return
	end

	if not self.specialEntity then
		return
	end

	self.specialEntity:resetStandPos()

	local duration = self.spineCo.bornDuration / FightModel.instance:getSpeed()

	self.bornEffect = self.specialEntity.effect:addHangEffect(self.spineCo.bornEffect, self.spineCo.bornPoint, self.side, duration)

	self.bornEffect:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, self.bornEffect)

	local audioId = self.spineCo.bornAudio

	if audioId and audioId > 0 then
		AudioMgr.instance:trigger(audioId)
	end

	self:playSpineAnim(self.bornAnim, self.spineCo.bornAnimDuration)

	self.effectWrap = self.specialEntity.effect:addHangEffect(self.spineCo.effect, self.spineCo.hangPoint, self.side)

	self.effectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, self.effectWrap)
end

function FightHero4_0HNJComp:playSpineAnim(animClip, duration)
	if not self.specialEntity then
		return
	end

	if gohelper.isNil(animClip) then
		return
	end

	if gohelper.isNil(self.animComp) then
		local spineGo = self.specialEntity.spine:getSpineGO()

		self.animComp = gohelper.onceAddComponent(spineGo, gohelper.Type_Animation)
	end

	local clipName = animClip.name

	self.animComp.enabled = true
	self.animComp.clip = animClip

	self.animComp:AddClip(animClip, clipName)

	local state = self.animComp.this:get(clipName)

	if state then
		state.speed = FightModel.instance:getSpeed()
	end

	self.animComp:Play()
	TaskDispatcher.runDelay(self.stopAnimComp, self, duration / FightModel.instance:getSpeed())
end

function FightHero4_0HNJComp:stopAnimComp()
	if self.animComp then
		self.animComp.enabled = false
	end
end

function FightHero4_0HNJComp:_removeSpine()
	self.addedAnimEvent = nil
	self.dying = nil

	tabletool.clear(self.effectWrapDict)

	self.animComp = nil

	self:disposeAnimLoader()

	self.playActionTrackId = nil

	if self.specialEntity then
		self.specialEntity.spine:removeAnimEventCallback(self.onAnimEvent, self)
		FightGameMgr.entityMgr:delEntity(self.specialEntityId)

		self.specialEntity = nil
		self.specialSpineLoadDone = nil
	end
end

function FightHero4_0HNJComp:disposeAnimLoader()
	if self.bornLoader then
		self.bornLoader:dispose()

		self.bornLoader = nil
	end

	if self.dieLoader then
		self.dieLoader:dispose()

		self.dieLoader = nil
	end

	self.bornLoadDone = nil
	self.dieLoaderDone = nil
	self.bornEffect = nil
	self.effectWrap = nil
	self.dieEffectWrap = nil
	self.bornAnim = nil
	self.dieAnim = nil
	self.bornAnimAbRes = nil
	self.bornAnimRes = nil
	self.dieAnimAbPath = nil
	self.dieAnimRes = nil
end

function FightHero4_0HNJComp:onDestroy()
	if self.helmetComp then
		self.helmetComp:dispose()

		self.helmetComp = nil
	end

	TaskDispatcher.cancelTask(self.stopAnimComp, self)
	TaskDispatcher.cancelTask(self._removeSpine, self)
	self:_removeSpine()
	self:removeStageEffect()
	FightHero4_0HNJComp.super.onDestroy(self)
end

function FightHero4_0HNJComp:refreshHNJStageEffect()
	local qteInfo = FightDataHelper.qteDataMgr:getQteInfo()

	if not qteInfo then
		return
	end

	local curStatus = qteInfo:getStatus()

	if curStatus == FightEnum.QTEStage.Normal then
		self:removeStageEffect()
	elseif curStatus == FightEnum.QTEStage.QTE_SECOND then
		self:createStageEffect()
	end
end

function FightHero4_0HNJComp:createStageEffect()
	if self.stageEffectWrap then
		return
	end

	local co = lua_fight_hnj_second_stage_effect.configDict[self.skinId]

	if not co then
		return
	end

	self.stageEffectWrap = self.entity.effect:addGlobalEffect(co.effect, self.side)

	self.stageEffectWrap:setLocalPos(0, 0, 0)
end

function FightHero4_0HNJComp:removeStageEffect()
	if self.stageEffectWrap then
		self.entity.effect:removeEffect(self.stageEffectWrap)

		self.stageEffectWrap = nil
	end
end

return FightHero4_0HNJComp
