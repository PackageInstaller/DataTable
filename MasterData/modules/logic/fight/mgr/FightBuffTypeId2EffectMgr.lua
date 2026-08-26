-- chunkname: @modules/logic/fight/mgr/FightBuffTypeId2EffectMgr.lua

module("modules.logic.fight.mgr.FightBuffTypeId2EffectMgr", package.seeall)

local FightBuffTypeId2EffectMgr = class("FightBuffTypeId2EffectMgr", FightBaseClass)

function FightBuffTypeId2EffectMgr:onConstructor()
	self.effectDic = {}
	self.refCounter = {}
	self.posDic = {}

	self:com_registFightEvent(FightEvent.AddEntityBuff, self._onAddEntityBuff)
	self:com_registFightEvent(FightEvent.RemoveEntityBuff, self._onRemoveEntityBuff)
	self:com_registFightEvent(FightEvent.OnFightReconnectLastWork, self._onFightReconnectLastWork)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self._onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish)
	self:com_registFightEvent(FightEvent.OnRoundSequenceFinish, self._onOnRoundSequenceFinish)
	self:com_registFightEvent(FightEvent.SetBuffTypeIdSceneEffect, self._onSetBuffTypeIdSceneEffect)
end

function FightBuffTypeId2EffectMgr:_isValid(buffId)
	local buffConfig = lua_skill_buff.configDict[buffId]

	if not buffConfig then
		return
	end

	local buffTypeId = buffConfig.typeId

	if not lua_fight_buff_type_id_2_scene_effect.configDict[buffTypeId] then
		return
	end

	return true, buffConfig
end

function FightBuffTypeId2EffectMgr:_onAddEntityBuff(entityId, buffMO)
	local valid, buffConfig = self:_isValid(buffMO.buffId)

	if not valid then
		return
	end

	self:addBuff(entityId, buffConfig.typeId)
end

function FightBuffTypeId2EffectMgr:_onRemoveEntityBuff(entityId, buffMO)
	local valid, buffConfig = self:_isValid(buffMO.buffId)

	if not valid then
		return
	end

	self:deleteBuff(buffConfig.typeId)

	local config = lua_fight_buff_type_id_2_scene_effect.configDict[buffConfig.typeId]

	if config then
		if not self.refCounter[buffConfig.typeId] then
			if self.refCounter[buffConfig.typeId] == 0 then
				local effect = config.delEffect

				if string.nilorempty(effect) then
					return
				end

				local pos = config.pos

				if not pos[1] then
					local posX = 0

					if config.reverseX == 1 then
						local entityMO = FightDataHelper.entityMgr:getById(entityId)

						if entityMO and entityMO:isEnemySide() then
							posX = -pos[1]
						end
					end

					if not pos[2] then
						local posY = 0

						if not pos[3] then
							local posZ = 0
							local vertin = FightHelper.getEntity(FightEntityScene.MySideId)

							if vertin then
								local effectWrap = vertin.effect:addGlobalEffect(effect)

								effectWrap:setLocalPos(pos[1], posY, posZ)
								self:com_registTimer(self.removeDelEffect, config.delTime, {
									effectWrap = effectWrap,
									config = config
								})
								AudioMgr.instance:trigger(config.audio)
							end
						end
					end
				end
			end
		end
	end
end

function FightBuffTypeId2EffectMgr:removeDelEffect(tab)
	local effectWrap = tab.effectWrap
	local config = tab.config
	local vertin = FightHelper.getEntity(FightEntityScene.MySideId)

	if not vertin then
		return
	end

	vertin.effect:removeEffect(effectWrap)

	local delAudio = config.delAudio

	if delAudio == 0 then
		return
	end

	AudioMgr.instance:trigger(delAudio)
end

function FightBuffTypeId2EffectMgr:addBuff(entityId, buffTypeId)
	if not self.refCounter[buffTypeId] then
		local counter = 0

		counter = self.refCounter[buffTypeId] + 1
		self.refCounter[buffTypeId] = self.refCounter[buffTypeId]

		if self.refCounter[buffTypeId] == 1 then
			self:addEffect(entityId, buffTypeId)
		end
	end
end

function FightBuffTypeId2EffectMgr:deleteBuff(buffTypeId)
	if not self.refCounter[buffTypeId] then
		local counter = 0

		counter = self.refCounter[buffTypeId] - 1
		self.refCounter[buffTypeId] = self.refCounter[buffTypeId]

		if self.refCounter[buffTypeId] <= 0 then
			self:releaseEffect(buffTypeId)
		end
	end
end

function FightBuffTypeId2EffectMgr:addEffect(entityId, buffTypeId)
	local vertin = FightHelper.getEntity(FightEntityScene.MySideId)

	if not vertin then
		return
	end

	local config = lua_fight_buff_type_id_2_scene_effect.configDict[buffTypeId]

	if not config then
		return
	end

	local effect = config.effect

	if string.nilorempty(effect) then
		return
	end

	local pos = config.pos

	if not pos[1] then
		local posX = 0

		if config.reverseX == 1 then
			local entityMO = FightDataHelper.entityMgr:getById(entityId)

			if entityMO and entityMO:isEnemySide() then
				posX = -pos[1]
			end
		end

		if not pos[2] then
			local posY = 0

			if not pos[3] then
				local posZ = 0
				local effectWrap = vertin.effect:addGlobalEffect(effect)

				effectWrap:setLocalPos(pos[1], posY, posZ)

				self.posDic[buffTypeId] = {
					pos[1],
					posY,
					posZ
				}
				self.effectDic[buffTypeId] = effectWrap
			end
		end
	end
end

function FightBuffTypeId2EffectMgr:releaseEffect(buffTypeId)
	local effectWrap = self.effectDic[buffTypeId]

	if not effectWrap then
		return
	end

	local vertin = FightHelper.getEntity(FightEntityScene.MySideId)

	if not vertin then
		return
	end

	vertin.effect:removeEffect(effectWrap)

	self.effectDic[buffTypeId] = nil
end

function FightBuffTypeId2EffectMgr:_onFightReconnectLastWork()
	local entityDic = FightDataHelper.entityMgr:getAllEntityData()

	for uid, entityData in pairs(entityDic) do
		local buffDic = entityData:getBuffDic()

		for buffUid, buff in pairs(buffDic) do
			self:_onAddEntityBuff(uid, buff)
		end
	end
end

function FightBuffTypeId2EffectMgr:_onSkillPlayStart(entity, curSkillId)
	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(curSkillId) then
		self:_hideEffect()
	end
end

function FightBuffTypeId2EffectMgr:_onSkillPlayFinish(entity, curSkillId)
	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(curSkillId) then
		self:_showEffect()
	end
end

function FightBuffTypeId2EffectMgr:_onSetBuffTypeIdSceneEffect(visible)
	for k, effectWrap in pairs(self.effectDic) do
		local pos = self.posDic[k]

		if visible then
			if not pos[1] then
				local posX = 9999

				if visible then
					if not pos[2] then
						local posY = 9999

						if visible then
							if not pos[3] then
								local posZ = 9999

								effectWrap:setLocalPos(posX, posY, posZ)
							end
						end
					end
				end
			end
		end
	end
end

function FightBuffTypeId2EffectMgr:_hideEffect()
	for k, effectWrap in pairs(self.effectDic) do
		effectWrap:setActive(false, "FightBuffTypeId2EffectMgr")
	end
end

function FightBuffTypeId2EffectMgr:_showEffect()
	for k, effectWrap in pairs(self.effectDic) do
		effectWrap:setActive(true, "FightBuffTypeId2EffectMgr")
	end
end

function FightBuffTypeId2EffectMgr:_onOnRoundSequenceFinish()
	if tabletool.len(self.refCounter) <= 0 then
		return
	end

	local refTab = {}
	local entityDic = FightDataHelper.entityMgr:getAllEntityData()

	for uid, entityData in pairs(entityDic) do
		local buffDic = entityData:getBuffDic()

		for buffUid, buff in pairs(buffDic) do
			local buffConfig = lua_skill_buff.configDict[buff.buffId]

			if buffConfig and lua_fight_buff_type_id_2_scene_effect.configDict[buffConfig.typeId] then
				if not refTab[buffConfig.typeId] then
					local counter = 0

					counter = refTab[buffConfig.typeId] + 1
					refTab[buffConfig.typeId] = refTab[buffConfig.typeId]
				end
			end
		end
	end

	if FightDataUtil.findDiff(self.refCounter, refTab) then
		self:releaseAllEffect()

		self.refCounter = {}

		self:_onFightReconnectLastWork()
	end
end

function FightBuffTypeId2EffectMgr:releaseAllEffect()
	for buffTypeId, effectWrap in pairs(self.effectDic) do
		self:releaseEffect(buffTypeId)
	end
end

function FightBuffTypeId2EffectMgr:onDestructor()
	return
end

return FightBuffTypeId2EffectMgr
