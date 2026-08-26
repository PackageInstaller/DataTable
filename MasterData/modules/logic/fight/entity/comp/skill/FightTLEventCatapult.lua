-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventCatapult.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventCatapult", package.seeall)

local FightTLEventCatapult = class("FightTLEventCatapult", FightTimelineTrackItem)

function FightTLEventCatapult:onTrackStart(fightStepData, duration, paramsArr)
	self._paramsArr = paramsArr
	self.fightStepData = fightStepData
	self._duration = duration
	self.index = FightTLHelper.getNumberParam(paramsArr[1])
	self.effectName = paramsArr[2]
	self.hangPoint = paramsArr[3]

	local startOffset = FightTLHelper.getTableParam(paramsArr[4], ",", true)
	local endOffset = FightTLHelper.getTableParam(paramsArr[5], ",", true)

	self.bezierParam = paramsArr[6]
	self.catapultAudio = FightTLHelper.getNumberParam(paramsArr[7])
	self.hitEffectName = paramsArr[8]
	self.hitStartTime = FightTLHelper.getNumberParam(paramsArr[9]) or 0.01
	self.hitEffectHangPoint = paramsArr[10]
	self.hitAudio = FightTLHelper.getNumberParam(paramsArr[11])
	self.buffIdList = FightTLHelper.getTableParam(paramsArr[12], "#", true)
	self.buffStartTime = FightTLHelper.getNumberParam(paramsArr[13]) or 0.01
	self.alwaysForceLookForward = FightTLHelper.getBoolParam(paramsArr[14])
	self.catapultReleaseTime = FightTLHelper.getNumberParam(paramsArr[15])
	self.hitReleaseTime = FightTLHelper.getNumberParam(paramsArr[16])

	if string.nilorempty(self.effectName) then
		logError("effect name is nil")

		return
	end

	self.skillUser = FightHelper.getEntity(fightStepData.fromId)
	self.side = self.skillUser:getSide()
	self.skillUserId = self.skillUser.id

	local startEntity = self:getStartEntity()
	local endEntity = self:getEndEntity()

	if not startEntity then
		return
	end

	if not endEntity then
		return
	end

	self.startEntity = startEntity
	self.endEntity = endEntity
	self.catapultBuffCount = self:getCatapultBuffCount(self.index + 1)

	local startHangPoint = startEntity:getHangPoint(self.hangPoint)
	local endHangPoint = endEntity:getHangPoint(self.hangPoint)
	local startX, startY, startZ = transformhelper.getPos(startHangPoint.transform)
	local endX, endY, endZ = transformhelper.getPos(endHangPoint.transform)

	self.effectWrap = self.skillUser.effect:addGlobalEffect(self.effectName, nil, self.catapultReleaseTime)

	FightRenderOrderMgr.instance:onAddEffectWrap(self.skillUserId, self.effectWrap)
	self:startBezierMove(startX + startOffset[1], startY + startOffset[2], startZ, endX + endOffset[1], endY + endOffset[2], endZ)
	self:changeLookDir()
	self:playHitEffect()
	self:playAddBuff()
	self:playAddFirstBuff()
end

function FightTLEventCatapult:playAddFirstBuff()
	if self.index ~= 1 then
		return
	end

	local floatBuffCount = self:getCatapultBuffCount(self.index)

	if floatBuffCount < 1 then
		return
	end

	local addBuff = FightEnum.EffectType.BUFFADD
	local entityId = self.startEntity.id
	local count = 0

	for _, actEffectData in ipairs(self.fightStepData.actEffect) do
		if not actEffectData:isDone() and entityId == actEffectData.targetId and actEffectData.effectType == addBuff and self:inCheckNeedPlayBuff(actEffectData.effectNum) then
			count = count + 1

			FightSkillBuffMgr.instance:playSkillBuff(self.fightStepData, actEffectData)
			FightDataHelper.playEffectData(actEffectData)

			if floatBuffCount <= count then
				return
			end
		end
	end
end

function FightTLEventCatapult:getCatapultBuffCount(index)
	local effectType = FightEnum.EffectType.CATAPULTBUFF

	for _, actEffectData in ipairs(self.fightStepData.actEffect) do
		if actEffectData.effectType == effectType and actEffectData.effectNum == index then
			return tonumber(actEffectData.reserveId)
		end
	end

	return 0
end

function FightTLEventCatapult:getStartEntity()
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return self:getPosEntity(self.index)
	else
		return self:get217EffectEntity(self.index)
	end
end

function FightTLEventCatapult:getEndEntity()
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return self:getPosEntity(self.index + 1)
	else
		return self:get217EffectEntity(self.index + 1)
	end
end

function FightTLEventCatapult:get217EffectEntity(index)
	local effectType = FightEnum.EffectType.CATAPULTBUFF

	for _, actEffectData in ipairs(self.fightStepData.actEffect) do
		if actEffectData.effectType == effectType and actEffectData.effectNum == index then
			local id = actEffectData.targetId

			return (FightGameMgr.entityMgr:getEntity(id))
		end
	end
end

function FightTLEventCatapult:getPosEntity(pos)
	local entity = FightGameMgr.entityMgr:getEntityByPosId(SceneTag.UnitMonster, pos)

	entity = entity or FightGameMgr.entityMgr:getEntityByPosId(SceneTag.UnitMonster, 1)

	return entity
end

function FightTLEventCatapult:startBezierMove(startX, startY, startZ, endX, endY, endZ)
	self.effectWrap:setWorldPos(startX, startY, startZ)

	self.mover = MonoHelper.addLuaComOnceToGo(self.effectWrap.containerGO, UnitMoverBezier)

	MonoHelper.addLuaComOnceToGo(self.effectWrap.containerGO, UnitMoverHandler)
	self.mover:setBezierParam(self.bezierParam)
	self.mover:simpleMove(startX, startY, startZ, endX, endY, endZ, self._duration)
	FightAudioMgr.instance:playAudio(self.catapultAudio)
end

function FightTLEventCatapult:changeLookDir()
	if not self.alwaysForceLookForward then
		return
	end

	self.tempForwards = Vector3.New()

	self.mover:registerCallback(UnitMoveEvent.PosChanged, self._onPosChange, self)
end

function FightTLEventCatapult:playHitEffect()
	if string.nilorempty(self.hitEffectName) then
		return
	end

	TaskDispatcher.cancelTask(self._playHitEffect, self)
	TaskDispatcher.runDelay(self._playHitEffect, self, self.hitStartTime)
end

function FightTLEventCatapult:_playHitEffect()
	local hitEffectWrap = self.endEntity.effect:addHangEffect(self.hitEffectName, self.hitEffectHangPoint, nil, self.hitReleaseTime)

	hitEffectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(self.endEntity.id, hitEffectWrap)
	FightAudioMgr.instance:playAudio(self.hitAudio)
end

function FightTLEventCatapult:playAddBuff()
	if not self.buffIdList then
		return
	end

	TaskDispatcher.cancelTask(self._playAddBuff, self)
	TaskDispatcher.runDelay(self._playAddBuff, self, self.buffStartTime)
end

function FightTLEventCatapult:_playAddBuff()
	local addBuff = FightEnum.EffectType.BUFFADD
	local endId = self.endEntity.id
	local count = 0

	for _, actEffectData in ipairs(self.fightStepData.actEffect) do
		if not actEffectData:isDone() and endId == actEffectData.targetId and actEffectData.effectType == addBuff and self:inCheckNeedPlayBuff(actEffectData.effectNum) then
			count = count + 1

			FightSkillBuffMgr.instance:playSkillBuff(self.fightStepData, actEffectData)
			FightDataHelper.playEffectData(actEffectData)

			if count >= self.catapultBuffCount then
				return
			end
		end
	end
end

function FightTLEventCatapult:inCheckNeedPlayBuff(buffId)
	return self.buffIdList and buffId and tabletool.indexOf(self.buffIdList, buffId)
end

function FightTLEventCatapult:_onPosChange(mover)
	local curX, curY, curZ = mover:getPos()
	local preX, preY, preZ = mover:getPrePos()

	self.tempForwards:Set(curX - preX, curY - preY, curZ - preZ)

	if self.tempForwards:Magnitude() < 1e-06 then
		return
	end

	local lookTargetRotation = Quaternion.LookRotation(self.tempForwards, Vector3.up)
	local lookDirRotation = FightHelper.getEffectLookDirQuaternion(self.side)
	local originRotation = FightEnum.RotationQuaternion.Ninety
	local rotation = lookTargetRotation * lookDirRotation * originRotation

	transformhelper.setRotation(self.effectWrap.containerTr, rotation.x, rotation.y, rotation.z, rotation.w)
end

function FightTLEventCatapult:removeEffectMover()
	local effect = self.effectWrap

	if not effect then
		return
	end

	MonoHelper.removeLuaComFromGo(effect.containerGO, UnitMoverBezier)
	MonoHelper.removeLuaComFromGo(effect.containerGO, UnitMoverHandler)

	self.effectWrap = nil
end

function FightTLEventCatapult:onTrackEnd()
	return
end

function FightTLEventCatapult:onDestructor()
	self:removeEffectMover()
	TaskDispatcher.cancelTask(self._playHitEffect, self)
	TaskDispatcher.cancelTask(self._playAddBuff, self)

	self.mover = nil
	self.skillUser = nil
	self.skillUser = nil
	self.side = nil
	self.skillUserId = nil
	self.startEntity = nil
	self.endEntity = nil
end

return FightTLEventCatapult
