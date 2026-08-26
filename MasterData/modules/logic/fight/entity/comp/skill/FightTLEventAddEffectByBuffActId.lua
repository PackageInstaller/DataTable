-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventAddEffectByBuffActId.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventAddEffectByBuffActId", package.seeall)

local FightTLEventAddEffectByBuffActId = class("FightTLEventAddEffectByBuffActId", FightTimelineTrackItem)
local HandleEffectMap = {
	[FightEnum.EffectType.BUFFADD] = true,
	[FightEnum.EffectType.BUFFDEL] = true,
	[FightEnum.EffectType.BUFFUPDATE] = true
}

function FightTLEventAddEffectByBuffActId:onTrackStart(fightStepData, duration, paramsArr)
	self.paramsArr = paramsArr
	self.fightStepData = fightStepData

	local buffActIdList = paramsArr[1]

	if string.nilorempty(buffActIdList) then
		logError("timeline中 bufActId 没配置")

		return
	end

	buffActIdList = FightStrUtil.instance:getSplitToNumberCache(buffActIdList, "|")

	if not buffActIdList then
		return
	end

	local effectName = paramsArr[2]

	if string.nilorempty(effectName) then
		logError("timeline中 目标特效名称不能为空")

		return
	end

	local mountType = paramsArr[3]
	local mountParam = paramsArr[4]
	local offsetX, offsetY, offsetZ = 0, 0, 0
	local arr = FightStrUtil.splitToNumber(paramsArr[5], ",")

	if arr then
		offsetX = arr[1] or offsetX
		offsetY = arr[2] or offsetY
		offsetZ = arr[3] or offsetZ
	end

	local audioId = paramsArr[6]
	local entityIdDict = {}

	for _, effect in ipairs(fightStepData.actEffect) do
		local effectType = effect.effectType

		if HandleEffectMap[effectType] and self:checkBuffIfValid(effect.buff, buffActIdList) then
			entityIdDict[effect.targetId] = true
		end
	end

	self.effectWrapDict = {}

	for entityId, _ in pairs(entityIdDict) do
		local effectWrap = self:createEffect(entityId, effectName, mountType, mountParam, offsetX, offsetY, offsetZ)

		if effectWrap then
			FightRenderOrderMgr.instance:onAddEffectWrap(entityId, effectWrap)

			self.effectWrapDict[entityId] = effectWrap

			if audioId then
				AudioMgr.instance:trigger(audioId)
			end
		end
	end
end

function FightTLEventAddEffectByBuffActId:checkBuffIfValid(buffMo, buffActList)
	if not buffMo then
		return false
	end

	for _, buffActId in ipairs(buffActList) do
		if FightHelper.checkBuffMoHasBuffActId(buffMo, buffActId) then
			return true
		end
	end

	return false
end

function FightTLEventAddEffectByBuffActId:onTrackEnd()
	self:removeEffect()
end

local MountType = {
	HANG = "1",
	GLOBAL = "2"
}

function FightTLEventAddEffectByBuffActId:createEffect(entityId, effectName, mountType, mountParam, offsetX, offsetY, offsetZ)
	if mountType == MountType.GLOBAL then
		return self:createGlobalEffect(entityId, effectName, mountParam, offsetX, offsetY, offsetZ)
	else
		return self:createHangEffect(entityId, effectName, mountParam, offsetX, offsetY, offsetZ)
	end
end

local GlobalParam = {
	Top = "3",
	SpinePos = "4",
	Bottom = "1",
	Center = "2"
}

function FightTLEventAddEffectByBuffActId:createGlobalEffect(entityId, effectName, mountParam, offsetX, offsetY, offsetZ)
	local entity = FightHelper.getEntity(entityId)

	if not entity then
		return
	end

	local effectWrap = entity.effect:addGlobalEffect(effectName)
	local posX, posY, posZ

	if mountParam == GlobalParam.Bottom then
		posX, posY, posZ = FightHelper.getEntityWorldBottomPos(entity)
	elseif mountParam == GlobalParam.Center then
		posX, posY, posZ = FightHelper.getEntityWorldCenterPos(entity)
	elseif mountParam == GlobalParam.Top then
		posX, posY, posZ = FightHelper.getEntityWorldTopPos(entity)
	elseif mountParam == GlobalParam.SpinePos then
		posX, posY, posZ = FightHelper.getProcessEntitySpinePos(entity)
	else
		local hangPointGO = not string.nilorempty(mountParam) and entity:getHangPoint(mountParam)

		if hangPointGO then
			local hangPointPosition = hangPointGO.transform.position

			posZ = hangPointPosition.z
			posY = hangPointPosition.y
			posX = hangPointPosition.x
		else
			posX, posY, posZ = FightHelper.getEntityWorldCenterPos(entity)
		end
	end

	offsetX = entity:isMySide() and -offsetX or offsetX

	effectWrap:setWorldPos(posX + offsetX, posY + offsetY, posZ + offsetZ)

	return effectWrap
end

function FightTLEventAddEffectByBuffActId:createHangEffect(entityId, effectName, hangPoint, offsetX, offsetY, offsetZ)
	local entity = FightHelper.getEntity(entityId)

	if not entity then
		return
	end

	local effectWrap = entity.effect:addHangEffect(effectName, hangPoint)

	effectWrap:setLocalPos(offsetX, offsetY, offsetZ)

	return effectWrap
end

function FightTLEventAddEffectByBuffActId:onDestructor()
	self:removeEffect()
end

function FightTLEventAddEffectByBuffActId:removeEffect()
	if self.effectWrapDict then
		for entityId, effectWrap in pairs(self.effectWrapDict) do
			local entity = FightHelper.getEntity(entityId)

			if entity then
				entity.effect:removeEffect(effectWrap)
			end

			FightRenderOrderMgr.instance:onRemoveEffectWrap(entity.id, effectWrap)
		end
	end

	self.effectWrapDict = nil
end

return FightTLEventAddEffectByBuffActId
