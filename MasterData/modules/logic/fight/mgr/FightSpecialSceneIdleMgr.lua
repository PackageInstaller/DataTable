-- chunkname: @modules/logic/fight/mgr/FightSpecialSceneIdleMgr.lua

module("modules.logic.fight.mgr.FightSpecialSceneIdleMgr", package.seeall)

local FightSpecialSceneIdleMgr = class("FightSpecialSceneIdleMgr", FightBaseClass)

function FightSpecialSceneIdleMgr:onConstructor()
	self._entity_dic = {}
	self._play_dic = {}

	self:com_registFightEvent(FightEvent.StageChanged, self.onStageChange)
	self:com_registFightEvent(FightEvent.PlaySpecialIdle, self._onPlaySpecialIdle)
	self:com_registFightEvent(FightEvent.OnEntityDead, self._releaseEntity)
	self:com_registFightEvent(FightEvent.OnRestartStageBefore, self._releaseAllEntity)
	self:com_registFightEvent(FightEvent.OnSwitchPlaneClearAsset, self._releaseAllEntity)
	FightController.instance:registerCallback(FightEvent.StageChanged, self.onStageChange, self)
	FightController.instance:registerCallback(FightEvent.PlaySpecialIdle, self._onPlaySpecialIdle, self)
	FightController.instance:registerCallback(FightEvent.OnEntityDead, self._releaseEntity, self)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, self._releaseAllEntity, self)
	FightController.instance:registerCallback(FightEvent.OnSwitchPlaneClearAsset, self._releaseAllEntity, self)
end

function FightSpecialSceneIdleMgr:onStageChange(stageType)
	if stageType == FightStageMgr.StageType.Operate then
		local entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)

		for _, entity in ipairs(entityList) do
			if entity.spine then
				local entity_mo = entity:getMO()

				if FightSpecialSceneIdleMgr.Condition[entity_mo.modelId] then
					self._entity_dic[entity_mo.id] = self._entity_dic[entity_mo.id] or _G["EntitySpecialIdle" .. FightSpecialSceneIdleMgr.Condition[entity_mo.modelId]].New(entity)

					if self._entity_dic[entity_mo.id].detectState then
						self._entity_dic[entity_mo.id]:detectState()
					end
				end
			end
		end

		self:_detectCanPlay()
	end
end

function FightSpecialSceneIdleMgr:_detectCanPlay()
	if self._play_dic then
		for k, v in pairs(self._play_dic) do
			local tar_entity = FightHelper.getEntity(v)

			if tar_entity then
				local config = lua_skin_special_act.configDict[tar_entity:getMO().modelId]

				if config then
					local num = math.random(0, 100)

					if num <= config.probability and tar_entity.spine.tryPlay and tar_entity.spine:tryPlay(SpineAnimState.idle_special1, config.loop == 1 and true) then
						self._entityPlayActName = self._entityPlayActName or {}
						self._entityPlayActName[tar_entity.id] = FightHelper.processEntityActionName(tar_entity, SpineAnimState.idle_special1)

						tar_entity.spine:addAnimEventCallback(self._onAnimEvent, self, tar_entity)
					end
				end
			end
		end
	end

	self._play_dic = {}
end

function FightSpecialSceneIdleMgr:_onAnimEvent(actionName, eventName, eventArgs, tar_entity)
	if self._entityPlayActName and eventName == SpineAnimEvent.ActionComplete and actionName == self._entityPlayActName[tar_entity.id] then
		tar_entity.spine:removeAnimEventCallback(self._onAnimEvent, self)
		tar_entity:resetAnimState()
	end
end

function FightSpecialSceneIdleMgr:_onPlaySpecialIdle(entity_id)
	self._play_dic[entity_id] = entity_id
end

function FightSpecialSceneIdleMgr:_releaseEntity(entity_id)
	if self._entity_dic and self._entity_dic[entity_id] then
		if self._entityPlayActName then
			self._entityPlayActName[entity_id] = nil
		end

		self._entity_dic[entity_id]:releaseSelf()

		self._entity_dic[entity_id] = nil

		local tar_entity = FightHelper.getEntity(entity_id)

		if tar_entity and tar_entity.spine then
			tar_entity.spine:removeAnimEventCallback(self._onAnimEvent, self)
		end
	end
end

function FightSpecialSceneIdleMgr:_releaseAllEntity()
	if self._entity_dic then
		for k, v in pairs(self._entity_dic) do
			self:_releaseEntity(v.id)
		end
	end

	self._play_dic = {}
end

FightSpecialSceneIdleMgr.Condition = {
	[3003] = 2,
	[3025] = 6,
	[3039] = 8,
	[3009] = 5,
	[3032] = 7,
	[3004] = 3,
	[3052] = 3,
	[3047] = 9,
	[3051] = 1,
	[3007] = 4
}

function FightSpecialSceneIdleMgr:onDestructor()
	self:_releaseAllEntity()
end

return FightSpecialSceneIdleMgr
