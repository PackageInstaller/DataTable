-- chunkname: @modules/logic/fight/system/work/FightWorkSkillOrBuffFocusMonster.lua

module("modules.logic.fight.system.work.FightWorkSkillOrBuffFocusMonster", package.seeall)

local FightWorkSkillOrBuffFocusMonster = class("FightWorkSkillOrBuffFocusMonster", BaseWork)

function FightWorkSkillOrBuffFocusMonster:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkSkillOrBuffFocusMonster:onStart()
	local entityId = self:isSkillFocus(self.fightStepData)

	if entityId then
		ViewMgr.instance:openView(ViewName.FightTechniqueGuideView, {
			entity = FightDataHelper.entityMgr:getById(entityId),
			config = self.monster_guide_focus_config
		})
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	else
		self:onDone(true)
	end
end

function FightWorkSkillOrBuffFocusMonster:_onCloseViewFinish(viewName)
	if viewName == ViewName.FightTechniqueGuideView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
		TaskDispatcher.runDelay(self._delayDone, self, FightWorkFocusMonster.EaseTime)
	end
end

function FightWorkSkillOrBuffFocusMonster:_delayDone()
	self:onDone(true)
end

function FightWorkSkillOrBuffFocusMonster:isSkillFocus(fightStepData)
	local fightParam = FightModel.instance:getFightParam()
	local entity = FightHelper.getEntity(fightStepData.fromId)

	if not entity or not entity:getMO() then
		return
	end

	if FightDataHelper.stateMgr.isReplay then
		return
	end

	if DungeonModel.instance:hasPassLevel(fightParam.episodeId) then
		return
	end

	if not lua_monster_guide_focus.configDict[fightParam.episodeId] then
		return
	end

	local config = FightConfig.instance:getMonsterGuideFocusConfig(fightParam.episodeId, fightStepData.actType, fightStepData.actId, entity:getMO().modelId)

	if not config then
		for i, v in ipairs(fightStepData.actEffect) do
			if v.effectType == FightEnum.EffectType.BUFFADD then
				local target_entity_mo = FightDataHelper.entityMgr:getById(v.targetId)

				if target_entity_mo then
					config = FightConfig.instance:getMonsterGuideFocusConfig(fightParam.episodeId, FightWorkFocusMonster.invokeType.Buff, v.buff.buffId, target_entity_mo.modelId)

					if config then
						break
					end
				end
			end
		end

		if not config then
			return
		end
	end

	self.monster_guide_focus_config = config

	local key = FightWorkSkillOrBuffFocusMonster.getPlayerPrefKey(config)

	if PlayerPrefsHelper.hasKey(key) then
		return
	end

	return fightStepData.fromId
end

function FightWorkSkillOrBuffFocusMonster.getPlayerPrefKey(config)
	local playerInfo = PlayerModel.instance:getPlayinfo()

	return string.format("%s_%s_%s_%s_%s_%s", PlayerPrefsKey.FightFocusSkillOrBuffMonster, playerInfo.userId, tostring(config.id), tostring(config.invokeType), tostring(config.param), tostring(config.monster))
end

function FightWorkSkillOrBuffFocusMonster:clearWork()
	return
end

return FightWorkSkillOrBuffFocusMonster
