-- chunkname: @modules/logic/fight/entity/comp/heroCustomComp/FightHeroHSYComp.lua

module("modules.logic.fight.entity.comp.heroCustomComp.FightHeroHSYComp", package.seeall)

local FightHeroHSYComp = class("FightHeroHSYComp", FightHeroCustomCompBase)

FightHeroHSYComp.EffectReleaseTime = 2

function FightHeroHSYComp:init(go)
	FightHeroHSYComp.super.init(self, go)

	local entityMo = self.entity:getMO()

	self.skinId = entityMo and entityMo.skin

	local config = lua_fight_hsy_effect.configDict[self.skinId]

	if not config then
		logError("回声谣回血特效配置不存在, 皮肤id : " .. tostring(self.skinId))

		config = lua_fight_hsy_effect.configList[1]
	end

	self.config = config
	self.audio = config.audio
	self.existEffectWrapDict = {}
	self.playingEntityDict = {}
	self.effectEndTimeDict = {}
	self.updateHandle = UpdateBeat:CreateListener(self._onFrame, self)
end

function FightHeroHSYComp:_onFrame()
	if not self.effectEndTimeDict then
		return
	end

	if not next(self.effectEndTimeDict) then
		self:_tryRemoveUpdateListener()

		return
	end

	local now = Time.time

	for targetId, endTime in pairs(self.effectEndTimeDict) do
		if endTime < now then
			self:hideEffect(targetId)
		end
	end
end

function FightHeroHSYComp:addEventListeners()
	FightController.instance:registerCallback(FightEvent.OnTrigger_HSY_FakeHPEffect, self.onTrigger_HSY_FakeHPEffect, self)
end

function FightHeroHSYComp:removeEventListeners()
	FightController.instance:unregisterCallback(FightEvent.OnTrigger_HSY_FakeHPEffect, self.onTrigger_HSY_FakeHPEffect, self)
end

function FightHeroHSYComp:onTrigger_HSY_FakeHPEffect(targetId)
	if self.playingEntityDict[targetId] then
		return
	end

	local effectWrap = self.existEffectWrapDict[targetId]

	if not effectWrap then
		self:createEffect(targetId)
	end

	self:showEffect(targetId)
end

function FightHeroHSYComp:createEffect(targetId)
	local effect = self.config.effect

	if string.nilorempty(effect) then
		logError("回声谣回血配置特效资源不存在, 皮肤id : " .. tostring(self.skinId))

		return
	end

	local entity = FightHelper.getEntity(targetId)

	if not entity then
		return
	end

	local effectWrap = entity.effect:addHangEffect(effect, self.config.hangPoint)

	effectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(targetId, effectWrap)

	self.existEffectWrapDict[targetId] = effectWrap
end

function FightHeroHSYComp:hideEffect(targetId)
	local effectWrap = self.existEffectWrapDict[targetId]

	if effectWrap then
		effectWrap:setActive(false)
	end

	self.playingEntityDict[targetId] = nil
	self.effectEndTimeDict[targetId] = nil

	self:_tryRemoveUpdateListener()
end

function FightHeroHSYComp:showEffect(targetId)
	local effectWrap = self.existEffectWrapDict[targetId]

	if not effectWrap then
		return
	end

	effectWrap:setActive(true)

	if self.audio ~= 0 then
		AudioMgr.instance:trigger(self.audio)
	end

	self.playingEntityDict[targetId] = true

	local duration = self.config.duration

	if not duration or duration <= 0 then
		duration = FightHeroHSYComp.EffectReleaseTime
	end

	self.effectEndTimeDict[targetId] = Time.time + duration

	self:_tryAddUpdateListener()
end

function FightHeroHSYComp:_tryAddUpdateListener()
	if self.updateHandle and not self._updateListening then
		UpdateBeat:AddListener(self.updateHandle)

		self._updateListening = true
	end
end

function FightHeroHSYComp:_tryRemoveUpdateListener()
	if self._updateListening and self.updateHandle and not next(self.effectEndTimeDict) then
		UpdateBeat:RemoveListener(self.updateHandle)

		self._updateListening = false
	end
end

function FightHeroHSYComp:onDestroy()
	if self.updateHandle then
		UpdateBeat:RemoveListener(self.updateHandle)

		self.updateHandle = nil
	end

	for entityId, effectWrap in pairs(self.existEffectWrapDict) do
		local entity = FightHelper.getEntity(entityId)

		if entity then
			entity.effect:removeEffect(effectWrap)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(entityId, effectWrap)
		end
	end

	tabletool.clear(self.existEffectWrapDict)

	self.existEffectWrapDict = nil

	tabletool.clear(self.playingEntityDict)

	self.playingEntityDict = nil

	tabletool.clear(self.effectEndTimeDict)

	self.effectEndTimeDict = nil

	FightHeroHSYComp.super.onDestroy(self)
end

return FightHeroHSYComp
