-- chunkname: @modules/logic/fight/entity/comp/summoneditem/FightEntitySummonedItem.lua

module("modules.logic.fight.entity.comp.summoneditem.FightEntitySummonedItem", package.seeall)

local FightEntitySummonedItem = class("FightEntitySummonedItem", FightBaseClass)

function FightEntitySummonedItem:onLogicEnter(entity, data)
	self._entity = entity
	self._data = data
	self._uid = data.uid
	self._effectDic = {}

	self:com_registFightEvent(FightEvent.SummonedLevelChange, self._onSummonedLevelChange)
	self:com_registFightEvent(FightEvent.SummonedDelete, self._onSummonedDelete)
	self:com_registFightEvent(FightEvent.EntityEffectLoaded, self._onEntityEffectLoaded)
	self:com_registFightEvent(FightEvent.PlayRemoveSummoned, self._onPlayRemoveSummoned)
	self:com_registFightEvent(FightEvent.SetEntityAlpha, self._onSetEntityAlpha)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self._onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish)
	self:_refreshSummoned()
	self:_initAniEffect()
end

function FightEntitySummonedItem:_getData()
	local entityMO = self._entity:getMO()
	local data = entityMO:getSummonedInfo():getData(self._uid)

	return data or self._data
end

function FightEntitySummonedItem:_refreshSummoned()
	local entityMO = self._entity:getMO()

	self._config = FightConfig.instance:getSummonedConfig(self:_getData().summonedId, self:_getData().level)
	self._stanceConfig = lua_fight_summoned_stance.configDict[self._config.stanceId]

	local posArr = self._stanceConfig and self._stanceConfig["pos" .. self:_getData().stanceIndex] or {
		0,
		0,
		0
	}

	self._pos = {
		x = posArr[1],
		y = posArr[2],
		z = posArr[3]
	}

	self:createEffect(self._config.enterEffect, self._config.enterTime)

	self._loopEffect = self:createEffect(self._config.loopEffect)

	self:_playAudio(self._config.enterAudio)
end

function FightEntitySummonedItem:_playAudio(id)
	if id ~= 0 then
		AudioMgr.instance:trigger(id)
	end
end

function FightEntitySummonedItem:_initAniEffect()
	self:createEffect(self._config.aniEffect)
end

function FightEntitySummonedItem:_onSetEntityAlpha(entityId, state)
	if entityId ~= self._entity.id then
		return
	end

	if state and self._aniEffect then
		self:_playAni("idle" .. self:_getData().level)
	end

	self:_setLoopEffectState(state)
end

function FightEntitySummonedItem:createEffect(name, releaseTime)
	if not string.nilorempty(name) then
		releaseTime = releaseTime and releaseTime / 1000

		local effectWrap = self._entity.effect:addHangEffect(name, ModuleEnum.SpineHangPointRoot, nil, releaseTime, self._pos)

		effectWrap:setLocalPos(self._pos.x, self._pos.y, self._pos.z)

		if not releaseTime then
			self._effectDic[effectWrap.uniqueId] = effectWrap
		end

		FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)

		return effectWrap
	end
end

function FightEntitySummonedItem:_onEntityEffectLoaded(entityId, effectWrap)
	if entityId ~= self._entity.id then
		return
	end

	if effectWrap.path == self._config.aniEffect then
		self._aniEffect = SLFramework.AnimatorPlayer.Get(effectWrap.effectGO)

		local aniName

		self:_playAni(self:_getData().level == 1 and "enter" or string.format("level%d_%d", self:_getData().level - 1, self:_getData().level))
	end
end

function FightEntitySummonedItem:_playAni(aniName)
	if self._aniEffect then
		local stateId = UnityEngine.Animator.StringToHash(aniName)

		if self._aniEffect:HasState(0, stateId) then
			self._aniEffect:play(aniName, nil, nil)
		end
	end
end

function FightEntitySummonedItem:_setLoopEffectState(state, sign)
	if self._loopEffect then
		self._loopEffect:setActive(state, sign or "FightEntitySummonedItem")
	end
end

function FightEntitySummonedItem:_onSkillPlayStart(entity)
	if self._entity.id == entity.id then
		self:_setLoopEffectState(false, "FightEntitySummonedItemTimeline")
	end
end

function FightEntitySummonedItem:_onSkillPlayFinish(entity)
	if self._entity.id == entity.id then
		self:_setLoopEffectState(true, "FightEntitySummonedItemTimeline")
	end
end

function FightEntitySummonedItem:_onSummonedLevelChange(entityId, uid, oldLevel, newLevel)
	if entityId ~= self._entity.id then
		return
	end

	if uid == self:_getData().uid then
		local aniName = string.format("level%d_%d", oldLevel, newLevel)

		self:_playAni(aniName)

		self._lastLoopEffect = self._loopEffect

		self:_refreshSummoned()

		if self._loopEffect.effectGO then
			self:_releaseLastLoopEffect()
		else
			self:com_registFightEvent(FightEvent.EntityEffectLoaded, self._onChangeEffectLoaded)
		end
	end
end

function FightEntitySummonedItem:_onChangeEffectLoaded(entityId, effectWrap)
	if effectWrap == self._loopEffect then
		self:com_cancelFightEvent(FightEvent.EntityEffectLoaded, self._onChangeEffectLoaded)
		self:_releaseLastLoopEffect()
	end
end

function FightEntitySummonedItem:_releaseLastLoopEffect()
	if self._lastLoopEffect then
		self:_releaseEffect(self._lastLoopEffect)
	end
end

function FightEntitySummonedItem:_onPlayRemoveSummoned(entityId, uid)
	if entityId ~= self._entity.id then
		return
	end

	if uid == self:_getData().uid then
		self._removeEffectWrap = self:createEffect(self._config.closeEffect)

		if self._removeEffectWrap then
			if self._removeEffectWrap.effectGO then
				self:_releaseLoopEffect()
			else
				self:com_registFightEvent(FightEvent.EntityEffectLoaded, self._onRemoveEffectLoaded)
			end
		else
			self:_releaseLoopEffect()
		end

		self:_playAudio(self._config.closeAudio)
	end
end

function FightEntitySummonedItem:_releaseLoopEffect()
	if self._loopEffect then
		self:_releaseEffect(self._loopEffect)

		self._loopEffect = nil
	end
end

function FightEntitySummonedItem:_onRemoveEffectLoaded(entityId, effectWrap)
	if self._removeEffectWrap == effectWrap then
		self:com_cancelFightEvent(FightEvent.EntityEffectLoaded, self._onRemoveEffectLoaded)
		self:_releaseLoopEffect()
	end
end

function FightEntitySummonedItem:_onSummonedDelete(entityId, uid)
	if entityId ~= self._entity.id then
		return
	end

	if uid == self:_getData().uid then
		self:disposeSelf()
	end
end

function FightEntitySummonedItem:_releaseEffect(effectWrap)
	self._effectDic[effectWrap.uniqueId] = nil

	FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, effectWrap)
	self._entity.effect:removeEffect(effectWrap)
end

function FightEntitySummonedItem:onLogicExit()
	for k, effectWrap in pairs(self._effectDic) do
		self:_releaseEffect(effectWrap)
	end
end

return FightEntitySummonedItem
