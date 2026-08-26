-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLYXASFDEffect.lua

module("modules.logic.fight.entity.comp.skill.FightTLYXASFDEffect", package.seeall)

local FightTLYXASFDEffect = class("FightTLYXASFDEffect", FightTimelineTrackItem)

function FightTLYXASFDEffect:onTrackStart(fightStepData, duration, paramsArr)
	self.duration = duration
	self.effectRes = paramsArr[1]
	self.startPosOffsetStr = paramsArr[2]
	self.endPosOffsetStr = paramsArr[3]
	self.parabolaHeight = tonumber(paramsArr[4])

	if string.nilorempty(self.effectRes) then
		return
	end

	local actEffect = FightHelper.getActEffectData(FightEnum.EffectType.EMITTEREXTRADEMAGE, fightStepData)

	if not actEffect then
		return
	end

	local damageEntityStr = actEffect.reserveStr

	self.defenderIdList = FightStrUtil.instance:getSplitCache(damageEntityStr, "#")

	if not self.defenderIdList then
		return
	end

	local damageBuffUid = actEffect.effectNum

	self.entityId, self.targetId = FightWorkASFDTryPlayYXTimeline.getDamageFromUidAndTargetUid(fightStepData, damageBuffUid)

	if not self.entityId then
		return
	end

	if not self.targetId then
		return
	end

	self.entity = FightHelper.getEntity(self.entityId)

	if not self.entity then
		return
	end

	self.targetEntity = FightHelper.getEntity(self.targetId)

	if not self.targetEntity then
		return
	end

	local targetPosX, targetPosY, targetPosZ = self:getEffectTargetPos()

	self.entity2EffectDict = {}

	for _, entityId in ipairs(self.defenderIdList) do
		self:addEffect(entityId, targetPosX, targetPosY, targetPosZ)
	end
end

function FightTLYXASFDEffect:addEffect(entityId, targetPosX, targetPosY, targetPosZ)
	local entity = entityId and FightHelper.getEntity(entityId)

	if not entity then
		return
	end

	local effectWrap = entity.effect:addGlobalEffect(self.effectRes)

	FightRenderOrderMgr.instance:onAddEffectWrap(entityId, effectWrap)

	local startPosX, startPosY, startPosZ = FightHelper.getEntityWorldCenterPos(entity)
	local offsetX, offsetY, offsetZ = 0, 0, 0

	if not string.nilorempty(self.startPosOffsetStr) then
		local arr = FightStrUtil.instance:getSplitToNumberCache(self.startPosOffsetStr, ",")

		offsetX = entity:isMySide() and -arr[1] or arr[1]
		offsetY = arr[2]
		offsetZ = arr[3]
	end

	startPosX = startPosX + offsetX
	startPosY = startPosY + offsetY
	startPosZ = startPosZ + offsetZ

	effectWrap:setWorldPos(startPosX, startPosY, startPosZ)

	local mover = MonoHelper.addLuaComOnceToGo(effectWrap.containerGO, UnitMoverParabola)

	MonoHelper.addLuaComOnceToGo(effectWrap.containerGO, UnitMoverHandler)
	mover:simpleMove(startPosX, startPosY, startPosZ, targetPosX, targetPosY, targetPosZ, self.duration, self.parabolaHeight)

	self.entity2EffectDict[entity] = effectWrap
end

function FightTLYXASFDEffect:getEffectTargetPos()
	local posX, posY, posZ = FightHelper.getEntityWorldCenterPos(self.targetEntity)
	local offsetX, offsetY, offsetZ = 0, 0, 0

	if not string.nilorempty(self.endPosOffsetStr) then
		local arr = FightStrUtil.instance:getSplitToNumberCache(self.endPosOffsetStr, ",")

		offsetX = self.entity:isMySide() and -arr[1] or arr[1]
		offsetY = arr[2]
		offsetZ = arr[3]
	end

	posX = posX + offsetX
	posY = posY + offsetY
	posZ = posZ + offsetZ

	return posX, posY, posZ
end

function FightTLYXASFDEffect:onTrackEnd()
	return
end

function FightTLYXASFDEffect:clearFunc()
	if not self.entity2EffectDict then
		return
	end

	for entity, effectWrap in pairs(self.entity2EffectDict) do
		entity.effect:removeEffect(effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(entity.id, effectWrap)
		MonoHelper.removeLuaComFromGo(effectWrap.containerGO, UnitMoverHandler)
		MonoHelper.removeLuaComFromGo(effectWrap.containerGO, UnitMoverParabola)
	end

	tabletool.clear(self.entity2EffectDict)
end

function FightTLYXASFDEffect:onDestructor()
	self:clearFunc()
end

return FightTLYXASFDEffect
