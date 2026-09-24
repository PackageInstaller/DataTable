-- chunkname: @modules/logic/fight/entity/comp/heroCustomComp/FightHero4_0HNJHelmetComp.lua

module("modules.logic.fight.entity.comp.heroCustomComp.FightHero4_0HNJHelmetComp", package.seeall)

local FightHero4_0HNJHelmetComp = class("FightHero4_0HNJHelmetComp", UserDataDispose)

function FightHero4_0HNJHelmetComp:init(entity, helmetCo)
	self:__onInit()

	self.entity = entity
	self.entityMo = self.entity:getMO()
	self.skinId = self.entityMo.skin
	self.entityId = self.entityMo.uid or "0"
	self.helmetCo = helmetCo
	self.side = self.entityMo.side
	self.helmetEntityName = "SPECIAL_HNJ_HELMET"
	self.helmetEntityId = self.entityId .. "_" .. self.helmetEntityName
	self.started = false
	self.updateListener = UpdateBeat:CreateListener(self._update, self)

	self:addEventListeners()
	self:refreshSpine()
end

function FightHero4_0HNJHelmetComp:startUpdateLister()
	if self.started then
		return
	end

	self.started = true

	UpdateBeat:AddListener(self.updateListener)
end

function FightHero4_0HNJHelmetComp:stopUpdateLister()
	if self.started then
		UpdateBeat:RemoveListener(self.updateListener)

		self.started = false
	end
end

function FightHero4_0HNJHelmetComp:_update()
	if not self.started then
		return
	end

	if not self.entity then
		return
	end

	if not self.helmetEntity then
		return
	end

	local trackEntry = self:getTrackEntry(self.entity)

	if not trackEntry then
		return
	end

	local animName = trackEntry:GetCurAnimationName()

	if animName ~= self._lastSyncedAnim then
		self.helmetEntity.spine:playAnim(animName, trackEntry.Loop, true)

		self.helmetTrackEntry = self:getTrackEntry(self.helmetEntity)
		self._lastSyncedAnim = animName
	end

	if self.helmetTrackEntry then
		self.helmetTrackEntry.TrackTime = trackEntry.TrackTime
	end
end

function FightHero4_0HNJHelmetComp:getTrackEntry(entity)
	if not entity then
		return
	end

	local anim = entity.spine:getSkeletonAnim()

	if anim then
		return anim.state:GetCurrent(0)
	end
end

function FightHero4_0HNJHelmetComp:addEventListeners()
	self.addEventCb(self, FightController.instance, FightEvent.OnSpineLoaded, self.onSpineLoaded, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayStart, self.onSkillPlayStart, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayFinish, self.onSkillPlayFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnSetEntityRenderOrder, self.onSetEntityRenderOrder, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnEntityPosChange, self.onEntityPosChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnEntitySpinePosChange, self.onEntitySpinePosChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetEntityAlpha, self.onSetEntityAlpha, self)
end

function FightHero4_0HNJHelmetComp:onSetEntityAlpha(entityId, active, duration)
	if entityId ~= self.entityId then
		return
	end

	if not self.helmetEntity then
		return
	end

	local alpha = active and 1 or 0

	self.helmetEntity:setAlpha(alpha, duration)
end

function FightHero4_0HNJHelmetComp:onEntitySpinePosChange(entityId, posX, posY, posZ)
	if self.entityId ~= entityId then
		return
	end

	if not self.helmetEntity then
		return
	end

	self.helmetEntity.spine:setLocalPos(posX, posY, posZ)
end

function FightHero4_0HNJHelmetComp:onEntityPosChange(entityId, posX, posY, posZ)
	if self.entityId ~= entityId then
		return
	end

	if not self.helmetEntity then
		return
	end

	self.helmetEntity:setSrcEntityPos(posX, posY, posZ)
end

function FightHero4_0HNJHelmetComp:onBuffUpdate(entityId, effectType, buffId, buffUid)
	if entityId ~= self.entityId then
		return
	end

	self:refreshSpine()
end

function FightHero4_0HNJHelmetComp:onSkillPlayStart(entity, curSkillId, fightStepData)
	if not self.helmetEntity then
		return
	end

	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(curSkillId) and entity.id ~= self.entity.id then
		self.helmetEntity:setActive(false)
	end
end

function FightHero4_0HNJHelmetComp:onSkillPlayFinish(entity, curSkillId, fightStepData)
	if not self.helmetEntity then
		return
	end

	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(curSkillId) and entity.id ~= self.entity.id then
		self.helmetEntity:setActive(true)
	end
end

function FightHero4_0HNJHelmetComp:onSetEntityRenderOrder(entityId, order)
	if entityId ~= self.entityId then
		return
	end

	if not self.helmetEntity then
		return
	end

	self.helmetEntity:setRenderOrder(order + 1)
end

function FightHero4_0HNJHelmetComp:onSpineLoaded(spine)
	if spine.entityId == self.helmetEntityId then
		self.spineLoadedDone = true

		self:showHelmetEntity()
	end
end

function FightHero4_0HNJHelmetComp:refreshSpine()
	if not self.helmetCo then
		return
	end

	local hasChanel = FightHelper.checkHas4_0HNJChannelBuff(self.entityMo)
	local isDead = self.entityMo:isStatusDead()

	if hasChanel and not isDead then
		self:createSpine()
	else
		self:removeSpine()
	end
end

function FightHero4_0HNJHelmetComp:createSpine()
	if self.helmetEntity then
		return
	end

	local resPath = string.format("roles/%s.prefab", self.helmetCo.resPath)

	self.helmetEntity = FightGameMgr.entityMgr:buildTempSpine(resPath, self.helmetEntityId, self.side, nil, FightEntitySpecialHNJHelmet, self.helmetEntityName)

	self.helmetEntity:setSrcEntityMo(self.entityMo)
	self.helmetEntity:setHNJHelmetCo(self.helmetCo)
end

function FightHero4_0HNJHelmetComp:showHelmetEntity()
	if not self.helmetEntity then
		return
	end

	if not self.spineLoadedDone then
		return
	end

	self.helmetEntity:resetStandPos()
	self:startUpdateLister()

	local effectRes = self.helmetCo.effect

	if not string.nilorempty(effectRes) then
		local effectWrap = self.helmetEntity.effect:addHangEffect(self.helmetCo.effect, self.helmetCo.hangPoint, self.side)

		effectWrap:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, effectWrap)
	end
end

function FightHero4_0HNJHelmetComp:removeSpine()
	if not self.helmetEntity then
		return
	end

	self:stopUpdateLister()
	FightGameMgr.entityMgr:delEntity(self.helmetEntityId)

	self.helmetEntity = nil
	self.helmetTrackEntry = nil
	self._lastSyncedAnim = nil
	self.spineLoadedDone = nil
end

function FightHero4_0HNJHelmetComp:dispose()
	self:removeSpine()

	self.updateListener = nil

	self:__onDispose()
end

return FightHero4_0HNJHelmetComp
