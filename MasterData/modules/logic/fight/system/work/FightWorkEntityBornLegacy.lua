-- chunkname: @modules/logic/fight/system/work/FightWorkEntityBornLegacy.lua

module("modules.logic.fight.system.work.FightWorkEntityBornLegacy", package.seeall)

local FightWorkEntityBornLegacy = class("FightWorkEntityBornLegacy", BaseWork)
local SpineFadeDelay = {
	[FightEnum.EntitySide.MySide] = 0.7,
	[FightEnum.EntitySide.EnemySide] = 0.5
}
local TotalDuration = 0.5
local BornParam = {
	{
		0,
		TotalDuration,
		"_BloomFactor",
		"float",
		"0",
		"1",
		false
	}
}
local FadeTime = 0.1
local EffectTime = 1.5

function FightWorkEntityBornLegacy:ctor(entity, needPlayBornAnim)
	self._entity = entity
	self._needPlayBornAnim = needPlayBornAnim
	self._animDone = false
	self._effectDone = false
	self.dontDealBuff = nil
end

function FightWorkEntityBornLegacy:onStart(context)
	FightController.instance:dispatchEvent(FightEvent.OnStartFightPlayBornNormal, self._entity.id)

	if self._entity.isSub then
		self._effectDone = true

		self._entity:setAlpha(1, 0)
		self:_playBornAnim()

		return
	end

	if self._needPlayBornAnim and self._entity.spine:hasAnimation(SpineAnimState.born) then
		self:_setSkinSpineActionLock(true)
		self._entity.spine:getSkeletonAnim():SetMixDuration(0)
		self._entity.spine:play(SpineAnimState.born, false, true)
		TaskDispatcher.runDelay(function()
			self._entity.spine:setFreeze(true)
		end, nil, 0.001)
	end

	self:_playEffect()
	self._entity:setAlpha(0, 0)

	if self._entity.spine then
		local ppEffectMask = self._entity.spine:getPPEffectMask()

		if self._entity.spine then
			self._entity.spine.enabled = false
		end

		if self._entity.nameUI then
			self._entity.nameUI:setActive(false)
		end

		local delayTime = SpineFadeDelay[self._entity:getSide()] / FightModel.instance:getSpeed()

		if delayTime and delayTime > 0 then
			TaskDispatcher.runDelay(self._startFadeIn, self, delayTime)
		else
			self:_startFadeIn()
		end
	end
end

function FightWorkEntityBornLegacy:_playEffect()
	local effectName = FightPreloadEffectWork.buff_chuchang
	local hangPoint
	local duration = EffectTime
	local entityMO = self._entity:getMO()

	if entityMO then
		local config = lua_fight_debut_show.configDict[entityMO.skin]

		if config then
			effectName = nil

			if not string.nilorempty(config.effect) then
				effectName = config.effect
				hangPoint = config.effectHangPoint
				duration = config.effectTime / 1000
			end

			if config.audioId ~= 0 then
				AudioMgr.instance:trigger(config.audioId)
			end
		end
	end

	if effectName then
		self._effectWrap = self._entity.effect:addHangEffect(effectName, hangPoint)

		self._effectWrap:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, self._effectWrap)
		TaskDispatcher.runDelay(self._onEffectDone, self, duration / FightModel.instance:getSpeed())
	else
		self:_onEffectDone()
	end
end

function FightWorkEntityBornLegacy:_onEffectDone()
	self._effectDone = true

	self:_checkDone()
end

function FightWorkEntityBornLegacy:_checkDone()
	if self._effectDone and self._animDone then
		if self._entity.nameUI then
			self._entity.nameUI:setActive(true)
		end

		if self._entity.spine then
			local ppEffectMask = self._entity.spine:getPPEffectMask()

			if ppEffectMask then
				ppEffectMask.enabled = true
			end

			if not self.dontDealBuff and self._entity.buff then
				self._entity.buff:dealStartBuff()
			end

			self:onDone(true)
		end
	end
end

function FightWorkEntityBornLegacy:_startFadeIn()
	self._entity:setAlpha(1, FadeTime / FightModel.instance:getSpeed())
	TaskDispatcher.runDelay(self._playBornAnim, self, FadeTime / FightModel.instance:getSpeed())

	self._startTime = Time.time

	local ppEffectMask = self._entity.spine:getPPEffectMask()

	self._spineMat = self._entity.spineRenderer:getReplaceMat()

	for _, param in ipairs(BornParam) do
		local propType = param[4]
		local startValueStr = param[5]
		local endValueStr = param[6]

		param.startValue = MaterialUtil.getPropValueFromStr(propType, startValueStr)
		param.endValue = MaterialUtil.getPropValueFromStr(propType, endValueStr)
	end

	TaskDispatcher.runRepeat(self._onFrameMaterialProperty, self, 0.01)
end

function FightWorkEntityBornLegacy:_onFrameMaterialProperty()
	local fightSpeed = FightModel.instance:getSpeed() or 1
	local newSpineMat = self._entity.spineRenderer:getReplaceMat()
	local elapsedTime = Time.time - self._startTime

	for _, param in ipairs(BornParam) do
		local startTime = param[1]
		local endTime = param[2] / fightSpeed

		if elapsedTime >= startTime * 0.95 and elapsedTime <= endTime * 1.05 then
			local propName = param[3]
			local propType = param[4]
			local percent = Mathf.Clamp01((elapsedTime - startTime) / (endTime - startTime))

			param.frameValue = MaterialUtil.getLerpValue(propType, param.startValue, param.endValue, percent, param.frameValue)

			local mat = self._spineMat

			if mat then
				MaterialUtil.setPropValue(mat, propName, propType, param.frameValue)
			end
		end
	end

	if elapsedTime > TotalDuration / fightSpeed then
		TaskDispatcher.cancelTask(self._onFrameMaterialProperty, self)
	end
end

function FightWorkEntityBornLegacy:_setSkinSpineActionLock(state)
	if self._entity and self._entity.skinSpineAction then
		self._entity.skinSpineAction.lock = state
	end
end

function FightWorkEntityBornLegacy:_playBornAnim()
	if self._needPlayBornAnim and self._entity.spine:hasAnimation(SpineAnimState.born) then
		self:_setSkinSpineActionLock(false)
		self._entity.spine:setFreeze(false)
		self._entity.spine:addAnimEventCallback(self._onAnimEvent, self)
		self._entity.spine:play(SpineAnimState.born, false, true)
	else
		self._animDone = true

		self:_checkDone()
	end
end

function FightWorkEntityBornLegacy:_onAnimEvent(actionName, eventName, eventArgs)
	if eventName == SpineAnimEvent.ActionComplete then
		self._entity.spine:getSkeletonAnim():ClearMixDuration()
		self._entity.spine:removeAnimEventCallback(self._onAnimEvent, self)
		self._entity:resetAnimState()

		self._animDone = true

		self:_checkDone()
	end
end

function FightWorkEntityBornLegacy:clearWork()
	self:_setSkinSpineActionLock(false)
	TaskDispatcher.cancelTask(self._startFadeIn, self)
	TaskDispatcher.cancelTask(self._playBornAnim, self)
	TaskDispatcher.cancelTask(self._onEffectDone, self)
	TaskDispatcher.cancelTask(self._onFrameMaterialProperty, self)

	if self._effectWrap then
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, self._effectWrap)
		self._entity.effect:removeEffect(self._effectWrap)

		self._effectWrap = nil
	end

	if self._entity and self._entity.spine:getSkeletonAnim() then
		self._entity.spine:setFreeze(false)
		self._entity.spine:getSkeletonAnim():ClearMixDuration()
		self._entity.spine:removeAnimEventCallback(self._onAnimEvent, self)
	end

	self._spineMat = nil
end

return FightWorkEntityBornLegacy
