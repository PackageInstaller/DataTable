-- chunkname: @modules/logic/fight/mgr/FightEntityFootRingMgr.lua

module("modules.logic.fight.mgr.FightEntityFootRingMgr", package.seeall)

local FightEntityFootRingMgr = class("FightEntityFootRingMgr", FightBaseClass)

function FightEntityFootRingMgr:onConstructor()
	local curScene = GameSceneMgr.instance:getCurScene()

	self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self.onLevelLoaded)
	self:com_registFightEvent(FightEvent.OnSpineLoaded, self._onSpineLoaded)
	self:com_registFightEvent(FightEvent.BeforeDeadEffect, self._onEntityDeadBefore)
	self:com_registFightEvent(FightEvent.BeforePlayUniqueSkill, self._onBeforePlayUniqueSkill)
	self:com_registFightEvent(FightEvent.AfterPlayUniqueSkill, self._onAfterPlayUniqueSkill)
	self:com_registFightEvent(FightEvent.SetEntityFootEffectVisible, self._onSetEntityFootEffectVisible)
	self:com_registFightEvent(FightEvent.OnRestartStageBefore, self._releaseAllEntityEffect)
	self:com_registFightEvent(FightEvent.OnSwitchPlaneClearAsset, self._releaseAllEntityEffect)
end

function FightEntityFootRingMgr:_onSpineLoaded(unitSpine)
	if not unitSpine or not self._fly_effect_url then
		return
	end

	self:_setSpineFlyEffect(unitSpine)
end

function FightEntityFootRingMgr:onLevelLoaded(levelId)
	self:_releaseFlyEffect()
	self:_setLevelCO(levelId)
	self:_setAllSpineFlyEffect()
end

function FightEntityFootRingMgr:_setLevelCO(levelId)
	local levelCO = lua_scene_level.configDict[levelId]
	local flyEffect = levelCO.flyEffect

	if not string.nilorempty(flyEffect) then
		self.updateTimer = self:com_registSingleRepeatTimer(self._onFrameUpdateEffectPos, 0.01, -1)
		self._fly_effect_url = "buff/buff_feixing"
	end
end

function FightEntityFootRingMgr:_setAllSpineFlyEffect()
	if not self._fly_effect_url then
		return
	end

	local entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)

	for _, entity in ipairs(entityList) do
		if entity.spine and self._fly_effect_url then
			self:_setSpineFlyEffect(entity.spine)
		end
	end
end

function FightEntityFootRingMgr:_setSpineFlyEffect(spine)
	local target_entity = spine.unitSpawn

	if not target_entity:isMySide() then
		return
	end

	local entity_id = target_entity.id
	local entity_mo = target_entity:getMO()

	if not entity_mo then
		return
	end

	local skin_config = FightConfig.instance:getSkinCO(entity_mo.skin)

	if not skin_config or skin_config.isFly == 1 then
		return
	end

	if not self.foot_effect then
		self.foot_effect = {}
		self.origin_pos_y = {}
		self.cache_entity = {}
	end

	if self.cache_entity[entity_id] then
		self:_onEntityDeadBefore(entity_id)
	end

	local x, y = FightHelper.getEntityStandPos(entity_mo)

	self.origin_pos_y[entity_id] = y
	self.cache_entity[entity_id] = target_entity
	self.foot_effect[entity_id] = self.foot_effect[entity_id] or target_entity.effect:addHangEffect(self._fly_effect_url)
end

function FightEntityFootRingMgr:_onFrameUpdateEffectPos()
	if self.foot_effect then
		for k, v in pairs(self.foot_effect) do
			local target_entity = self.cache_entity[k]

			if target_entity and not gohelper.isNil(target_entity.go) then
				local target_go = target_entity.go

				if target_go then
					local pos_x, pos_y, pos_z = transformhelper.getPos(target_go.transform)

					self.foot_effect[k]:setWorldPos(pos_x, self.origin_pos_y[k], pos_z)
				end
			end
		end
	end
end

function FightEntityFootRingMgr:_onBeforePlayUniqueSkill()
	if self.foot_effect then
		for k, v in pairs(self.foot_effect) do
			gohelper.setActive(v.containerGO, false)
		end
	end
end

function FightEntityFootRingMgr:_onAfterPlayUniqueSkill()
	if self.foot_effect then
		for k, v in pairs(self.foot_effect) do
			gohelper.setActive(v.containerGO, true)
		end
	end
end

function FightEntityFootRingMgr:_onEntityDeadBefore(entityId)
	if self.foot_effect and self.foot_effect[entityId] then
		local entity = self.cache_entity[entityId]

		if entity and entity.effect then
			entity.effect:removeEffect(self.foot_effect[entityId])
		end

		self.foot_effect[entityId] = nil
		self.cache_entity[entityId] = nil
	end
end

function FightEntityFootRingMgr:_onSetEntityFootEffectVisible(entity_id, state)
	if self.foot_effect and self.foot_effect[entity_id] then
		self:_onFrameUpdateEffectPos()
		gohelper.setActive(self.foot_effect[entity_id].containerGO, state or false)
	end
end

function FightEntityFootRingMgr:_releaseAllEntityEffect()
	if self.foot_effect then
		for k, v in pairs(self.foot_effect) do
			self:_onEntityDeadBefore(k)
		end
	end
end

function FightEntityFootRingMgr:_releaseFlyEffect()
	self:com_cancelTimer(self.updateTimer)
	self:_releaseAllEntityEffect()

	self.origin_pos_y = nil
	self.foot_effect = nil
	self._fly_effect_url = nil
	self.cache_entity = nil
end

function FightEntityFootRingMgr:onDestructor()
	self:_releaseFlyEffect()
end

return FightEntityFootRingMgr
