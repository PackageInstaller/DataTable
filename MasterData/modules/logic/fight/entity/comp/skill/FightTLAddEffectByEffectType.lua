-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLAddEffectByEffectType.lua

module("modules.logic.fight.entity.comp.skill.FightTLAddEffectByEffectType", package.seeall)

local FightTLAddEffectByEffectType = class("FightTLAddEffectByEffectType", FightTimelineTrackItem)

function FightTLAddEffectByEffectType:onTrackStart(fightStepData, duration, paramsArr)
	self.duration = duration
	self.effectType = tonumber(paramsArr[1])
	self.effectRes = paramsArr[2]
	self.hangType = paramsArr[3]
	self.hangParam = paramsArr[4]
	self.offset = paramsArr[5]
	self.releaseTime = tonumber(paramsArr[6]) or 0

	if not self.effectType then
		return
	end

	if string.nilorempty(self.effectRes) then
		return
	end

	local actEffect = FightHelper.getActEffectData(self.effectType, fightStepData)

	if not actEffect then
		logError("未找到 effect 数据 : " .. tostring(self.effectType))

		return
	end

	local entityUid = actEffect.targetId
	local entity = entityUid and FightHelper.getEntity(entityUid)

	if not entity then
		return
	end

	self.effectWrap = self.hangType == "1" and self:addHangEffect(self.effectRes, entity, self.hangParam, self.releaseTime, self.offset) or self.hangType == "1" and self:addGlobalEffect(self.effectRes, entity, self.hangParam, self.releaseTime, self.offset) or self:addWorldPosEffect(self.effectRes, entity, self.hangParam, self.releaseTime, self.offset)

	if self.effectWrap then
		FightRenderOrderMgr.instance:onAddEffectWrap(entityUid, self.effectWrap)
	end

	self.entity = entity
end

function FightTLAddEffectByEffectType:addHangEffect(effectRes, entity, hangParam, releaseTime, offset)
	if not entity then
		return
	end

	releaseTime = releaseTime > 0 and releaseTime or nil

	local effectWrap = entity.effect:addHangEffect(effectRes, hangParam, nil, releaseTime)

	if not string.nilorempty(offset) then
		local arr = FightStrUtil.instance:getSplitToNumberCache(offset, ",")

		effectWrap:setLocalPos(arr[1] or 0, arr[2] or 0, arr[3] or 0)
	else
		effectWrap:setLocalPos(0, 0, 0)
	end

	return effectWrap
end

function FightTLAddEffectByEffectType:addGlobalEffect(effectRes, entity, hangParam, releaseTime, offset)
	if not entity then
		return
	end

	releaseTime = releaseTime > 0 and releaseTime or nil

	local effectWrap = entity.effect:addGlobalEffect(effectRes, nil, releaseTime)

	if not string.nilorempty(offset) then
		local arr = FightStrUtil.instance:getSplitToNumberCache(offset, ",")

		effectWrap:setLocalPos(arr[1] or 0, arr[2] or 0, arr[3] or 0)
	else
		effectWrap:setLocalPos(0, 0, 0)
	end

	return effectWrap
end

function FightTLAddEffectByEffectType:addWorldPosEffect(effectRes, entity, hangParam, releaseTime, offset)
	if not entity then
		return
	end

	releaseTime = releaseTime > 0 and releaseTime or nil

	local effectWrap = entity.effect:addGlobalEffect(effectRes, nil, releaseTime)
	local posX, posY, posZ

	if hangParam == "1" then
		posX, posY, posZ = FightHelper.getEntityWorldTopPos(entity)
	elseif hangParam == "2" then
		posX, posY, posZ = FightHelper.getEntityWorldCenterPos(entity)
	elseif hangParam == "3" then
		posX, posY, posZ = FightHelper.getEntityWorldBottomPos(entity)
	else
		posX, posY, posZ = FightHelper.getProcessEntitySpinePos(entity)
	end

	local offsetX = 0
	local offsetY = 0
	local offsetZ = 0

	if not string.nilorempty(offset) then
		local arr = FightStrUtil.instance:getSplitToNumberCache(offset, ",")

		offsetX = arr[1] or 0
		offsetY = arr[2] or 0
		offsetZ = arr[3] or 0
	end

	effectWrap:setLocalPos(posX + offsetX, posY + offsetY, posZ + offsetZ)

	return effectWrap
end

function FightTLAddEffectByEffectType:onTrackEnd()
	return
end

function FightTLAddEffectByEffectType:clearFunc()
	if self.releaseTime <= 0 and self.effectWrap and self.entity then
		self.entity.effect:removeEffect(self.effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entity.id, self.effectWrap)
	end

	self.effectWrap = nil
	self.entity = nil
end

function FightTLAddEffectByEffectType:onDestructor()
	self:clearFunc()
end

return FightTLAddEffectByEffectType
