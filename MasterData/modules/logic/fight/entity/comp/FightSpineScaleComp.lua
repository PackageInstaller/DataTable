-- chunkname: @modules/logic/fight/entity/comp/FightSpineScaleComp.lua

module("modules.logic.fight.entity.comp.FightSpineScaleComp", package.seeall)

local FightSpineScaleComp = class("FightSpineScaleComp", FightBaseClass)

function FightSpineScaleComp:onConstructor(entity)
	self.entity = entity

	local spine = self.entity.spine
	local spineGo = spine and spine:getSpineGO()

	if gohelper.isNil(spineGo) then
		self:com_registFightEvent(FightEvent.AfterInitSpine, self.onAfterInitSpine)
	else
		self.spineGo = spineGo
		self.spineTr = spine:getSpineTr()

		self:setScale()
		self:addEvents()
	end
end

function FightSpineScaleComp:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate, self)
	self.addEventCb(self, FightController.instance, FightEvent.UpdateBuffActInfo, self.onUpdateBuffActInfo, self)
end

function FightSpineScaleComp:onAfterInitSpine(spine)
	if spine.entity.entityId ~= self.entity.id then
		return
	end

	self:com_cancelFightEvent(FightEvent.AfterInitSpine, self.onAfterInitSpine)
	self:addEvents()

	self.spineGo = spine:getSpineGO()
	self.spineTr = spine:getSpineTr()

	self:setScale()
end

function FightSpineScaleComp:onUpdateBuffActInfo(entityId, buffUid, buffActInfo)
	if entityId ~= self.entity.id then
		return
	end

	local targetActId = FightEnum.BuffActId.EntityScale

	if buffActInfo.actId == targetActId then
		return self:setScale()
	end
end

function FightSpineScaleComp:onBuffUpdate(entityId, entityType, buffId, buffUid, configEffect, buffMo)
	if entityId ~= self.entity.id then
		return
	end

	if not buffMo then
		return
	end

	local targetActId = FightEnum.BuffActId.EntityScale
	local buffActInfo = buffMo.actInfo

	for _, actInfo in ipairs(buffActInfo) do
		if actInfo.actId == targetActId then
			return self:setScale()
		end
	end
end

local TweenDuration = 0.2

function FightSpineScaleComp:setScale()
	local scale = self:getCurScale()

	if self._targetScale == scale then
		return
	end

	self._targetScale = scale

	self:clearTween()

	if self.spineTr then
		if isDebugBuild then
			logNormal(string.format("[set scale] entityId : %s, set scale : %s, \n %s", self.entity.entityId, scale, debug.traceback()))
		end

		self.tweenId = ZProj.TweenHelper.DOScale(self.spineTr, scale, scale, scale, TweenDuration)
	end
end

function FightSpineScaleComp:clearTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

local MIN_SCALE = 0.2
local MAX_SCALE = 2

function FightSpineScaleComp:getCurScale()
	local entityMo = self.entity:getMO()

	if not entityMo then
		return 1
	end

	local value = 1000
	local targetActId = FightEnum.BuffActId.EntityScale
	local buffDict = entityMo:getBuffDic()

	for _, buff in pairs(buffDict) do
		local buffMo = buff

		for _, actInfo in ipairs(buffMo.actInfo) do
			if actInfo.actId == targetActId then
				value = value + (actInfo.param[1] or 0)
			end
		end
	end

	local scale = value / 1000

	return Mathf.Clamp(scale, MIN_SCALE, MAX_SCALE)
end

function FightSpineScaleComp:onDestructor()
	self:clearTween()
end

return FightSpineScaleComp
