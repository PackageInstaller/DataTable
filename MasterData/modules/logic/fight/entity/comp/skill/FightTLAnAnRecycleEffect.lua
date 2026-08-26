-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLAnAnRecycleEffect.lua

module("modules.logic.fight.entity.comp.skill.FightTLAnAnRecycleEffect", package.seeall)

local FightTLAnAnRecycleEffect = class("FightTLAnAnRecycleEffect", FightTimelineTrackItem)

function FightTLAnAnRecycleEffect:onTrackStart(fightStepData, duration, paramsArr)
	self.duration = duration
	self.effectRes = paramsArr[1]
	self.startPosOffsetStr = paramsArr[2]
	self.endPosOffsetStr = paramsArr[3]
	self.parabolaHeight = tonumber(paramsArr[4])
	self.action = paramsArr[5]

	if string.nilorempty(self.effectRes) then
		return
	end

	self.entityId, self.recycleEntityIdList = self:getRecycleEntityId(fightStepData)

	if not self.entityId then
		return
	end

	self.entity = FightHelper.getEntity(self.entityId)

	if not self.entity then
		return
	end

	if not self.recycleEntityIdList then
		return
	end

	self:playAct()

	local targetPosX, targetPosY, targetPosZ = self:getEffectTargetPos()

	self.entity2EffectDict = {}

	for _, entityId in ipairs(self.recycleEntityIdList) do
		self:addEffect(entityId, targetPosX, targetPosY, targetPosZ)
	end
end

function FightTLAnAnRecycleEffect:playAct()
	if self.entity and self.entity.spine and not string.nilorempty(self.action) then
		self.entity.spine:play(self.action, false, true)
	end
end

function FightTLAnAnRecycleEffect:addEffect(entityId, targetPosX, targetPosY, targetPosZ)
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

function FightTLAnAnRecycleEffect:getEffectTargetPos()
	local posX, posY, posZ = FightHelper.getEntityWorldCenterPos(self.entity)
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

function FightTLAnAnRecycleEffect:getRecycleEntityId(fightStepData)
	local actEffect = FightHelper.getActEffectData(FightEnum.EffectType.ANANFOCUSBUFF, fightStepData)

	if not actEffect then
		return
	end

	local targetId = actEffect.targetId
	local infoStr = actEffect.reserveStr
	local infoList = FightStrUtil.instance:getSplitCache(infoStr, ",")

	infoStr = infoList and infoList[2]

	if string.nilorempty(infoStr) then
		return
	end

	infoList = FightStrUtil.instance:getSplitString2Cache(infoStr, false, "|", ":")

	if not infoList then
		return
	end

	local recycleIdList = {}

	for _, info in ipairs(infoList) do
		local entityId = info[1]
		local buffUid = info[2]

		table.insert(recycleIdList, entityId)

		local entity = FightHelper.getEntity(entityId)

		if entity then
			entity.buff:delBuff(buffUid)
		end
	end

	if #recycleIdList == 0 then
		return
	end

	return targetId, recycleIdList
end

function FightTLAnAnRecycleEffect:onTrackEnd()
	return
end

function FightTLAnAnRecycleEffect:resetAction()
	if self.entity and self.entity.spine then
		local animName = self.entity:getDefaultAnim()
		local skeletonAnim = self.entity.spine:getSkeletonAnim()

		if skeletonAnim and skeletonAnim:HasAnimation(animName) then
			self.entity.spine:play(animName, true, false)
		end
	end
end

function FightTLAnAnRecycleEffect:clearFunc()
	self:resetAction()

	if not self.entity2EffectDict then
		return
	end

	for entity, effectWrap in pairs(self.entity2EffectDict) do
		entity.effect:removeEffect(effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(entity.id, effectWrap)
		MonoHelper.removeLuaComFromGo(effectWrap.containerGO, UnitMoverHandler)
		MonoHelper.removeLuaComFromGo(effectWrap.containerGO, UnitMoverParabola)
	end
end

function FightTLAnAnRecycleEffect:onDestructor()
	self:clearFunc()
end

return FightTLAnAnRecycleEffect
