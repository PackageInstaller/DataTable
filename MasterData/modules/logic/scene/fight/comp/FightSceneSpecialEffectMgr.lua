-- chunkname: @modules/logic/scene/fight/comp/FightSceneSpecialEffectMgr.lua

module("modules.logic.scene.fight.comp.FightSceneSpecialEffectMgr", package.seeall)

local FightSceneSpecialEffectMgr = class("FightSceneSpecialEffectMgr", BaseSceneComp)

function FightSceneSpecialEffectMgr:onSceneStart(sceneId, levelId)
	FightController.instance:registerCallback(FightEvent.OnInvokeSkill, self._onInvokeSkill, self)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, self._beforeDeadEffect, self)
	FightController.instance:registerCallback(FightEvent.FightRoundEnd, self._onFightRoundEnd, self)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	FightController.instance:registerCallback(FightEvent.BeforeDestroyEntity, self._onBeforeDestroyEntity, self)
end

function FightSceneSpecialEffectMgr:addBuff(tar_entity, buff)
	self:_detectShiSiHangShiGoodEffect(tar_entity)
	self:_detectPlayBuffAnimation(tar_entity, buff)
	self:_detectPlayCarAnimation(tar_entity, buff)
end

function FightSceneSpecialEffectMgr:delBuff(tar_entity, buff)
	self:_detectShiSiHangShiGoodEffect(tar_entity)

	if tar_entity.id == self._xia_li_uid and (buff.buffId == 30172 or buff.buffId == 30171) then
		self:_releaseXiaLiSpecialEffect()
	end

	self:_detectPlayBuffAnimation(tar_entity, buff, true)
end

function FightSceneSpecialEffectMgr:_detectPlayBuffAnimation(tar_entity, buff_mo, delete_buff)
	if FightBuffHelper.isDormantBuff(buff_mo.buffId) then
		if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
			-- block empty
		elseif not FightWorkStepBuff.updateWaitTime then
			return
		end

		self._buff_animation_dic = self._buff_animation_dic or {}
		self._buff_animation_dic[tar_entity.id] = self._buff_animation_dic[tar_entity.id] or {}

		self:_releaseEntityAnimation(tar_entity.id)

		local tar_class = FightBuffPlayAnimation.New(tar_entity, buff_mo, delete_buff and "mjzz_return" or "mjzz_sleep")

		table.insert(self._buff_animation_dic[tar_entity.id], tar_class)
	end
end

function FightSceneSpecialEffectMgr:_onSkillPlayStart(tar_entity)
	if tar_entity and tar_entity.id == self._xia_li_uid and self._xia_li_skill_id == 30170143 and self._xiali_special_effect then
		self._xiali_special_effect:setActive(false)
	end
end

function FightSceneSpecialEffectMgr:_onSkillPlayFinish(tar_entity)
	if tar_entity and tar_entity.id == self._xia_li_uid and self._xiali_special_effect then
		self._xiali_special_effect:setActive(true)
	end
end

function FightSceneSpecialEffectMgr:_onInvokeSkill(stepData)
	if stepData.actType == FightEnum.ActType.SKILL then
		local from_entity = FightHelper.getEntity(stepData.fromId)

		if from_entity and stepData.fromId == from_entity.id then
			if stepData.actId == 30170141 then
				self:_releaseXiaLiSpecialEffect()

				self._xiali_special_effect = from_entity.effect:addHangEffect("buff/xiali_buff_innate1", ModuleEnum.SpineHangPoint.mounthead, nil, nil, {
					z = 0,
					x = 0,
					y = 0
				})

				self._xiali_special_effect:setLocalPos(0, 0, 0)

				self._xia_li_uid = from_entity.id
				self._xia_li_skill_id = stepData.actId

				FightRenderOrderMgr.instance:onAddEffectWrap(from_entity.id, self._xiali_special_effect)
			elseif stepData.actId == 30170143 then
				self:_releaseXiaLiSpecialEffect()

				self._xiali_special_effect = from_entity.effect:addHangEffect("buff/xiali_buff_innate2", "special4", nil, nil, {
					z = 0,
					x = 0,
					y = 0
				})

				self._xiali_special_effect:setLocalPos(0, 0, 0)

				self._xia_li_uid = from_entity.id
				self._xia_li_skill_id = stepData.actId

				FightRenderOrderMgr.instance:onAddEffectWrap(from_entity.id, self._xiali_special_effect)
			end
		end
	end
end

function FightSceneSpecialEffectMgr:_onFightRoundEnd()
	return
end

function FightSceneSpecialEffectMgr:setBuffEffectVisible(tar_entity, state)
	if tar_entity and tar_entity.id == self._xia_li_uid and self._xiali_special_effect then
		self._xiali_special_effect:setActive(state)
	end

	if tar_entity and tar_entity.id == self._shi_si_hang_shi_uid and self._shi_si_hang_shi_good_effect then
		self._shi_si_hang_shi_good_effect:setActive(state)
	end
end

function FightSceneSpecialEffectMgr:_releaseXiaLiSpecialEffect()
	if self._xiali_special_effect then
		local tar_entity = FightHelper.getEntity(self._xia_li_uid)

		if tar_entity then
			tar_entity.effect:removeEffect(self._xiali_special_effect)
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(self._xia_li_uid, self._xiali_special_effect)

		self._xiali_special_effect = nil
		self._xia_li_uid = nil
	end
end

function FightSceneSpecialEffectMgr:_releaseShiSiHangShiGoodEffect()
	if self._shi_si_hang_shi_good_effect then
		local tar_entity = FightHelper.getEntity(self._shi_si_hang_shi_uid)

		if tar_entity then
			tar_entity.effect:removeEffect(self._shi_si_hang_shi_good_effect)
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(self._shi_si_hang_shi_uid, self._shi_si_hang_shi_good_effect)

		self._shi_si_hang_shi_good_effect = nil
		self._shi_si_hang_shi_uid = nil
	end
end

function FightSceneSpecialEffectMgr:_detectShiSiHangShiGoodEffect(tar_entity, buff)
	local entityMO = tar_entity:getMO()

	if entityMO and entityMO.modelId == 3023 then
		local level, rank = HeroConfig.instance:getShowLevel(entityMO.level)

		if rank < 2 then
			return
		end

		local haveGoodBuff = false
		local buffDic = entityMO:getBuffDic()

		for _, buffMO in pairs(buffDic) do
			local buff_config = lua_skill_buff.configDict[buffMO.buffId]
			local buff_type_config = lua_skill_bufftype.configDict[buff_config.typeId]

			for index, value in ipairs(FightEnum.BuffTypeList.GoodBuffList) do
				if buff_type_config.type == value then
					haveGoodBuff = true

					break
				end
			end

			if haveGoodBuff then
				break
			end
		end

		if haveGoodBuff then
			if not self._shi_si_hang_shi_good_effect then
				self._shi_si_hang_shi_good_effect = tar_entity.effect:addHangEffect("buff/shisihangshi_innate", ModuleEnum.SpineHangPoint.mountweapon, nil, nil, {
					z = 0,
					x = 0,
					y = 0
				})

				self._shi_si_hang_shi_good_effect:setLocalPos(0, 0, 0)

				self._shi_si_hang_shi_uid = tar_entity.id

				FightRenderOrderMgr.instance:onAddEffectWrap(tar_entity.id, self._shi_si_hang_shi_good_effect)
			end
		else
			self:_releaseShiSiHangShiGoodEffect()
		end
	end
end

function FightSceneSpecialEffectMgr:_detectPlayCarAnimation(tar_entity, buff)
	for i = 1, 10 do
		if buff.buffId == 6301310 + i then
			if tar_entity.spine:tryPlay("idle_change") then
				tar_entity.spine:addAnimEventCallback(self._onAnimEvent, self, tar_entity)
			end

			break
		end
	end
end

function FightSceneSpecialEffectMgr:_onAnimEvent(actionName, eventName, eventArgs, tar_entity)
	if eventName == SpineAnimEvent.ActionComplete and actionName == "idle_change" then
		tar_entity.spine:removeAnimEventCallback(self._onAnimEvent, self)
		tar_entity:resetAnimState()
	end
end

function FightSceneSpecialEffectMgr:_releaseAllEntityAnimation()
	if self._buff_animation_dic then
		for entity_id, v in pairs(self._buff_animation_dic) do
			self:_releaseEntityAnimation(entity_id)
		end
	end

	self._buff_animation_dic = nil
end

function FightSceneSpecialEffectMgr:_releaseEntityAnimation(entity_id)
	if self._buff_animation_dic and self._buff_animation_dic[entity_id] then
		for i, v in ipairs(self._buff_animation_dic[entity_id]) do
			v:releaseSelf()
		end

		self._buff_animation_dic[entity_id] = {}
	end
end

function FightSceneSpecialEffectMgr:_releaseEntitySpineAnimEvent(tar_entity)
	if tar_entity and tar_entity.spine then
		tar_entity.spine:removeAnimEventCallback(self._onAnimEvent, self)
	end
end

function FightSceneSpecialEffectMgr:_beforeDeadEffect(entity_id, tar_entity)
	local tar_entity = tar_entity or FightHelper.getEntity(entity_id)

	if tar_entity then
		if tar_entity.id == self._xia_li_uid then
			self:_releaseXiaLiSpecialEffect()
		end

		if tar_entity.id == self._shi_si_hang_shi_uid then
			self:_releaseShiSiHangShiGoodEffect()
		end

		self:_releaseEntityAnimation(tar_entity.id)
	end
end

function FightSceneSpecialEffectMgr:_onBeforeDestroyEntity(tar_entity)
	self:_releaseEntitySpineAnimEvent(tar_entity)
end

function FightSceneSpecialEffectMgr:clearEffect(tar_entity)
	self:_beforeDeadEffect(nil, tar_entity)
end

function FightSceneSpecialEffectMgr:clearAllEffect()
	self:_releaseXiaLiSpecialEffect()
	self:_releaseShiSiHangShiGoodEffect()
	self:_releaseAllEntityAnimation()
end

function FightSceneSpecialEffectMgr:onSceneClose()
	FightController.instance:unregisterCallback(FightEvent.OnInvokeSkill, self._onInvokeSkill, self)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, self._beforeDeadEffect, self)
	FightController.instance:unregisterCallback(FightEvent.FightRoundEnd, self._onFightRoundEnd, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	FightController.instance:unregisterCallback(FightEvent.BeforeDestroyEntity, self._onBeforeDestroyEntity, self)
	self:clearAllEffect()
end

return FightSceneSpecialEffectMgr
