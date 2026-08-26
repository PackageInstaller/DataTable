-- chunkname: @modules/logic/fight/entity/comp/specialeffect/FightEntitySpecialEffectBuffLayerEnemySkin.lua

module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectBuffLayerEnemySkin", package.seeall)

local FightEntitySpecialEffectBuffLayerEnemySkin = class("FightEntitySpecialEffectBuffLayerEnemySkin", FightBaseClass)
local defaultReleaseTime = 3000

function FightEntitySpecialEffectBuffLayerEnemySkin:onConstructor(entity)
	self._entity = entity
	self._effectWraps = {}
	self._buffId2Config = {}
	self._oldLayer = {}
	self._buffType = {}
	self.playCount = 0
	self.hideWhenPlayTimeline = {}

	self:com_registFightEvent(FightEvent.SetBuffEffectVisible, self._onSetBuffEffectVisible)
	self:com_registFightEvent(FightEvent.OnBuffUpdate, self._onBuffUpdate)
	self:com_registFightEvent(FightEvent.BeforeDeadEffect, self._onBeforeDeadEffect)
	self:com_registFightEvent(FightEvent.BeforeEnterStepBehaviour, self._onBeforeEnterStepBehaviour)
	self:com_registFightEvent(FightEvent.SkillEditorRefreshBuff, self._onSkillEditorRefreshBuff)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self._onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, LuaEventSystem.High)
	self:com_registFightEvent(FightEvent.BeforePlayTimeline, self.onBeforePlayTimeline)
end

function FightEntitySpecialEffectBuffLayerEnemySkin:onBeforePlayTimeline(entityId)
	if self._entity.id == entityId then
		self.playCount = self.playCount + 1

		for i, effectWrap in ipairs(self.hideWhenPlayTimeline) do
			effectWrap:setActive(false, "FightEntitySpecialEffectBuffLayerEnemySkin_onBeforePlayTimeline")
		end
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:afterPlayTimeline()
	self.playCount = self.playCount - 1

	if self.playCount == 0 then
		for i, effectWrap in ipairs(self.hideWhenPlayTimeline) do
			effectWrap:setActive(true, "FightEntitySpecialEffectBuffLayerEnemySkin_afterPlayTimeline")
		end
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_onBeforeEnterStepBehaviour()
	if FightDataHelper.stateMgr.dealingCrash then
		self:_releaseAllEffect()
	end

	local entityMO = self._entity:getMO()

	if entityMO then
		local buffDic = entityMO:getBuffDic()

		for i, v in pairs(buffDic) do
			self:_onBuffUpdate(self._entity.id, FightEnum.EffectType.BUFFADD, v.buffId, v.uid, nil, v)
		end
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_onSkillEditorRefreshBuff()
	self:_releaseAllEffect()
	self:_onBeforeEnterStepBehaviour()
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_onSetBuffEffectVisible(entityId, state, sign)
	if self._entity.id == entityId and self._effectWraps then
		for buffId, v in pairs(self._effectWraps) do
			for i, effectWrap in pairs(v) do
				effectWrap:setActive(state, sign or "FightEntitySpecialEffectBuffLayerEnemySkin")
			end
		end
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_onSkillPlayStart(entity, curSkillId, fightStepData)
	local entityMO = entity:getMO()

	if entityMO and entityMO.id == self._entity.id and FightCardDataHelper.isBigSkill(curSkillId) then
		self:_onSetBuffEffectVisible(entityMO.id, false, "FightEntitySpecialEffectBuffLayerEnemySkin_onSkillPlayStart")
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_onSkillPlayFinish(entity, curSkillId, fightStepData)
	local entityMO = entity:getMO()

	if entityMO and entityMO.id == self._entity.id then
		if FightCardDataHelper.isBigSkill(curSkillId) then
			self:_onSetBuffEffectVisible(entityMO.id, true, "FightEntitySpecialEffectBuffLayerEnemySkin_onSkillPlayStart")
		end

		self:afterPlayTimeline()
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin.sortList(item1, item2)
	return item1.layer > item2.layer
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_onBuffUpdate(targetId, effectType, buffId, buffUid, configEffect, buffMO)
	if targetId ~= self._entity.id then
		return
	end

	if lua_fight_buff_layer_effect_enemy_skin.configDict[buffId] then
		if effectType == FightEnum.EffectType.BUFFDEL or effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
			local buffType = self._buffType[buffUid]

			if not buffType then
				return
			end

			if buffType == FightEnum.BuffType.LayerSalveHalo then
				return
			end

			self:_refreshEffect(buffId, nil, 0, effectType)

			return
		end

		if not buffMO then
			return
		end

		self._buffType[buffUid] = buffMO.type

		if buffMO.type == FightEnum.BuffType.LayerSalveHalo then
			return
		end

		local entityData = self._entity:getMO()

		if not entityData then
			return
		end

		if entityData.side == FightEnum.EntitySide.MySide then
			if not FightEnum.EntitySide.EnemySide then
				local entitySide = FightEnum.EntitySide.MySide
				local entityList = FightDataHelper.entityMgr:getOriginNormalList(entitySide)
				local have = self:checkRefreshEffect(entityList, buffMO, targetId, effectType)

				if not have then
					entityList = FightDataHelper.entityMgr:getOriginSpList(entitySide)
					have = self:checkRefreshEffect(entityList, buffMO, targetId, effectType)
				end
			end
		end
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:checkRefreshEffect(entityList, buffMO, targetId, effectType)
	local buffId = buffMO.buffId

	for i, entityMO in ipairs(entityList) do
		if not lua_fight_buff_layer_effect_enemy_skin.configDict[buffId][entityMO.originSkin] then
			if lua_fight_buff_layer_effect_enemy_skin.configDict[buffId][entityMO.originSkin] then
				local list = {}

				for k, v in pairs(lua_fight_buff_layer_effect_enemy_skin.configDict[buffId][entityMO.originSkin]) do
					table.insert(list, v)
				end

				table.sort(list, FightEntitySpecialEffectBuffLayerEnemySkin.sortList)

				if buffMO then
					if not buffMO.layer then
						local buffConfig = lua_skill_buff.configDict[buffId]

						self:_refreshEffect(buffId, list, (FightSkillBuffMgr.instance:buffIsStackerBuff(buffConfig) or nil) and FightSkillBuffMgr.instance:getStackedCount(targetId, buffMO), effectType)

						return true
					end
				end
			end
		end
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_refreshEffect(buffId, list, layer, effectType)
	if not self._effectWraps then
		return
	end

	self._effectWraps[buffId] = self._effectWraps[buffId] or {}

	if not self._oldLayer[buffId] then
		local oldLayer = 0

		self._oldLayer[buffId] = layer

		if (effectType == FightEnum.EffectType.BUFFDEL or effectType == FightEnum.EffectType.BUFFDELNOEFFECT) and layer == 0 then
			local config = self._buffId2Config[buffId]

			if config and not string.nilorempty(config.destroyEffect) then
				if config.releaseDestroyEffectTime > 0 then
					if not config.releaseDestroyEffectTime then
						local releaseTime = defaultReleaseTime
						local effectWrap = self._entity.effect:addHangEffect(config.destroyEffect, config.destroyEffectRoot, nil, releaseTime / 1000)

						effectWrap:setLocalPos(0, 0, 0)
						FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)

						if config.destroyEffectAudio > 0 then
							AudioMgr.instance:trigger(config.destroyEffectAudio)
						end
					end
				end
			end

			self:_releaseBuffIdEffect(buffId)

			return
		end

		local config

		for i, v in ipairs(list) do
			if layer >= v.layer then
				config = v

				break
			end
		end

		if not config then
			self:_releaseBuffIdEffect(buffId)

			return
		end

		local keyLayer = config.layer
		local oldConfig = self._buffId2Config[buffId]

		self._buffId2Config[buffId] = config

		local isNew = oldConfig ~= config

		if not self._effectWraps[buffId][keyLayer] and not string.nilorempty(config.loopEffect) then
			local effectWrap = self._entity.effect:addHangEffect(config.loopEffect, config.loopEffectRoot)

			effectWrap:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)

			self._effectWraps[buffId][keyLayer] = effectWrap

			effectWrap:setActive(false)

			if config.hideWhenPlayTimeline == 1 then
				table.insert(self.hideWhenPlayTimeline, effectWrap)
			end
		end

		if isNew then
			self:_hideEffect(buffId)

			if not string.nilorempty(config.createEffect) then
				if config.releaseCreateEffectTime > 0 then
					if not config.releaseCreateEffectTime then
						do
							local releaseTime = defaultReleaseTime
							local effectWrap = self._entity.effect:addHangEffect(config.createEffect, config.createEffectRoot, nil, releaseTime / 1000)

							effectWrap:setLocalPos(0, 0, 0)
							FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)

							if config.createAudio > 0 then
								AudioMgr.instance:trigger(config.createAudio)
							end
						end

						if config.delayTimeBeforeLoop > 0 then
							TaskDispatcher.runDelay(function()
								self:_refreshEffectState(buffId)
							end, self, config.delayTimeBeforeLoop / 1000)

							goto label_12_0
						end
					end
				end
			end

			self:_refreshEffectState(buffId)
		else
			if config.loopEffectAudio > 0 then
				AudioMgr.instance:trigger(config.loopEffectAudio)
			end

			self:_refreshEffectState(buffId)

			if effectType == FightEnum.EffectType.BUFFUPDATE and oldLayer < layer then
				if not string.nilorempty(config.addLayerEffect) then
					if config.releaseAddLayerEffectTime > 0 then
						if not config.releaseAddLayerEffectTime then
							do
								local releaseTime = defaultReleaseTime
								local effectWrap = self._entity.effect:addHangEffect(config.addLayerEffect, config.addLayerEffectRoot, nil, releaseTime / 1000)

								effectWrap:setLocalPos(0, 0, 0)
								FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, effectWrap)
							end

							if config.addLayerAudio > 0 then
								AudioMgr.instance:trigger(config.addLayerAudio)
							end
						end
					end
				end
			end
		end

		::label_12_0::
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_refreshEffectState(buffId)
	if not self then
		return
	end

	if self._effectWraps then
		local effectDic = self._effectWraps[buffId]

		if effectDic then
			local layer = self._buffId2Config[buffId].layer

			for k, v in pairs(effectDic) do
				v:setActive(layer == k)
			end
		end
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_hideEffect(buffId)
	if self._effectWraps then
		local effectDic = self._effectWraps[buffId]

		if effectDic then
			for k, v in pairs(effectDic) do
				v:setActive(false)
			end
		end
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_releaseAllEffect()
	if self._effectWraps then
		for k, v in pairs(self._effectWraps) do
			self:_releaseBuffIdEffect(k)
		end

		self._effectWraps = nil
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_releaseBuffIdEffect(buffId)
	if self._effectWraps then
		for k, v in pairs(self._effectWraps[buffId]) do
			self:_releaseEffect(v)
		end

		self._effectWraps[buffId] = nil
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_releaseEffect(effectWrap)
	for i, v in ipairs(self.hideWhenPlayTimeline) do
		if v == effectWrap then
			table.remove(self.hideWhenPlayTimeline, i)

			break
		end
	end

	self._entity.effect:removeEffect(effectWrap)
	FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, effectWrap)
end

function FightEntitySpecialEffectBuffLayerEnemySkin:_onBeforeDeadEffect(entityId)
	if entityId == self._entity.id then
		self:_releaseAllEffect()
	end
end

function FightEntitySpecialEffectBuffLayerEnemySkin:onDestructor()
	self:_releaseAllEffect()
end

return FightEntitySpecialEffectBuffLayerEnemySkin
