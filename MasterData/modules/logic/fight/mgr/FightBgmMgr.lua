-- chunkname: @modules/logic/fight/mgr/FightBgmMgr.lua

module("modules.logic.fight.mgr.FightBgmMgr", package.seeall)

local FightBgmMgr = class("FightBgmMgr", FightBaseClass)

function FightBgmMgr:onConstructor()
	FightAudioMgr.instance:init()

	self._stopBgAudioId = nil

	local fightParam = FightModel.instance:getFightParam()

	self._bgAudioId = self:_getCurBgAudioId()

	if self._bgAudioId then
		FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Comeshow)
		self:_playBgm()
		self:_detectDefaultSwitch(fightParam.episodeId)
	end

	self:_playAmbientSound()

	local curScene = GameSceneMgr.instance:getCurScene()

	self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self.onLevelLoaded)
	self:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView)
	self:com_registFightEvent(FightEvent.OnFightReconnect, self._switchMonsterGroup)
	self:com_registFightEvent(FightEvent.OnStartSequenceStart, self._onStartSequenceStart)
	self:com_registFightEvent(FightEvent.OnRoundSequenceStart, self._switchMonsterGroup)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self._onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish)
	self:com_registFightEvent(FightEvent.OnBuffUpdate, self._onBuffUpdate)
	self:com_registFightEvent(FightEvent.OnHpChange, self._onHpChange)
	self:com_registFightEvent(FightEvent.OnFightReconnectLastWork, self._onFightReconnectLastWork)
	self:com_registFightEvent(FightEvent.OnSpineLoaded, self._onSpineLoaded)
	self:com_registFightEvent(FightEvent.BeforeDeadEffect, self._onEntityDeadBefore)
	self:com_registFightEvent(FightEvent.EntityDeadFinish, self._onEntityDeadFinish)
	self:com_registFightEvent(FightEvent.OnRestartFightDisposeDone, self._onRestartFightDisposeDone)
	self:com_registFightEvent(FightEvent.OnSwitchPlaneClearAssetDone, self._onSwitchPlaneClearAssetDone)
	self:com_registFightEvent(FightEvent.AddMagicCircile, self._onAddMagicCircile)
	self:com_registFightEvent(FightEvent.SwitchFightendBgm, self._onSwitchFightendBgm)
	self:com_registFightEvent(FightEvent.PlayDialog, self._onPlayDialog)
	self:com_registFightEvent(FightEvent.AfterPlayDialog, self._onAfterPlayDialog)
	self:com_registFightEvent(FightEvent.ReplayBgmAfterAVG, self.onReplayBgmAfterAVG)
end

function FightBgmMgr:onCloseView(viewName)
	if viewName == ViewName.CharacterView then
		self._ambientSound = nil

		self:_playAmbientSound()
	end
end

function FightBgmMgr:onReplayBgmAfterAVG()
	self:_playBgm()

	self._ambientSound = nil

	self:_playAmbientSound()
	FightAudioMgr.instance:setSwitch(self._cur_switch or FightEnum.AudioSwitch.Fightnormal)
end

function FightBgmMgr:onLevelLoaded(levelId)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return
	end

	local id = self:_getCurBgAudioId()

	if id ~= self._bgAudioId then
		self._bgAudioId = id

		self:_playBgm()
	end

	self:_playAmbientSound()
end

function FightBgmMgr:_playBgm()
	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.Fight, self._bgAudioId, AudioEnum.Bgm.Stop_FightingMusic)
end

function FightBgmMgr:_onStartSequenceStart()
	local config = self:_getConfig(nil, 0, 11, 0)

	if (config or nil) and false then
		self:_switchMonsterGroup()
	end
end

function FightBgmMgr:_switchMonsterGroup()
	FightAudioMgr.instance:setSwitch(self._cur_switch or FightEnum.AudioSwitch.Fightnormal)
end

function FightBgmMgr:_onSkillPlayFinish(entity, skillId, stepData, timelineName)
	if self:_needDealFinishTimeline(entity, timelineName) then
		return
	end
end

function FightBgmMgr:_needDealFinishTimeline(entity, timelineName)
	local fightParam = FightModel.instance:getFightParam()

	if not entity or not entity:getMO() then
		return
	end

	local config = self:_getConfig(fightParam.episodeId, entity:getMO().modelId, 9, timelineName)

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()

	return true
end

function FightBgmMgr:_onSkillPlayStart(entity, skillId, stepData, timelineName)
	if self:_needDealPlayTimeline(entity, timelineName) then
		return
	end

	local config = self:needDealBgm(stepData.fromId, 1, stepData.actId)

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()
end

function FightBgmMgr:_needDealPlayTimeline(entity, timelineName)
	local fightParam = FightModel.instance:getFightParam()

	if not entity or not entity:getMO() then
		return
	end

	local config = self:_getConfig(fightParam.episodeId, entity:getMO().modelId, 8, timelineName)

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()

	return true
end

function FightBgmMgr:_onBuffUpdate(targetId, effectType, buffId, uid)
	if effectType ~= FightEnum.EffectType.BUFFADD then
		return
	end

	local config = self:needDealBgm(targetId, 2, buffId)

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()
end

function FightBgmMgr:_onHpChange(target_entity)
	local configs = self:needDealBgm(target_entity.id, 3)

	if not configs then
		return
	end

	local temp_list = {}

	for k, v in pairs(configs) do
		table.insert(temp_list, v)
	end

	table.sort(temp_list, FightBgmMgr.hpSortFunc)

	local entity_mo = target_entity:getMO()
	local currentHp = entity_mo.currentHp

	if entity_mo.attrMO and entity_mo.attrMO.hp > 0 then
		if not entity_mo.attrMO.hp then
			local maxHp = 1
			local percent = currentHp / maxHp * 100
			local last_switch = self._cur_switch

			for i, v in ipairs(temp_list) do
				if percent <= tonumber(v.param) then
					self._cur_switch = v.switch
				end
			end

			if last_switch == self._cur_switch then
				return
			end

			self:_switchMonsterGroup()
		end
	end
end

function FightBgmMgr.hpSortFunc(item1, item2)
	return tonumber(item1.param) > tonumber(item2.param)
end

function FightBgmMgr:_detectDefaultSwitch(episodeId)
	local config = self:_getConfig(episodeId, 0, 4, "0")

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch
end

function FightBgmMgr:needPlayVictory()
	local fightParam = FightModel.instance:getFightParam()
	local config = self:_getConfig(fightParam.episodeId, 0, 6, "0")

	if not config then
		return
	end

	return true
end

function FightBgmMgr:_onSwitchFightendBgm()
	if not self:_getConfig(nil, 0, 12, 0) then
		FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Fightend)
	end
end

function FightBgmMgr:_onSpineLoaded(spine)
	local config = self:needDealBgm(spine.unitSpawn.id, 5, 0)

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()
end

function FightBgmMgr:_onEntityDeadBefore(entityId)
	local config = self:needDealBgm(entityId, 7, 0)

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()
end

function FightBgmMgr:_onEntityDeadFinish(modelId)
	local config = self:_getConfig(nil, modelId, 15, 0)

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()
end

function FightBgmMgr:_onAddMagicCircile(magicCircleId)
	local fightParam = FightModel.instance:getFightParam()
	local config = self:_getConfig(fightParam.episodeId, 0, 10, tostring(magicCircleId))

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()

	return true
end

function FightBgmMgr:_onFightReconnectLastWork()
	local all_entity = FightHelper.getAllEntitys()

	for i, v in ipairs(all_entity) do
		local tar_entity_mo = v:getMO()

		if tar_entity_mo then
			local buff_list = tar_entity_mo:getBuffList()

			for index, buff in ipairs(buff_list) do
				self:_onBuffUpdate(v.id, FightEnum.EffectType.BUFFADD, buff.buffId)
			end
		end

		self:_onHpChange(v)
	end
end

function FightBgmMgr:needDealBgm(entity_id, deal_type, param)
	local entity = FightHelper.getEntity(entity_id)

	if not entity or not entity:getMO() then
		return
	end

	local fightParam = FightModel.instance:getFightParam()
	local config = self:_getConfig(fightParam.episodeId, entity:getMO().modelId, deal_type, tostring(param))

	if not config then
		return
	end

	return config
end

function FightBgmMgr:_getConfig(id, monster, invokeType, param)
	local fightParam = FightModel.instance:getFightParam()
	local battleId = fightParam.battleId
	local configDict = lua_fight_music.configDict[id or fightParam.episodeId]

	configDict = configDict or lua_fight_music.configDict[0]

	if configDict then
		configDict = configDict[battleId] or configDict[0]

		if configDict and configDict[monster] and configDict[monster][invokeType] then
			if invokeType == 3 then
				return configDict[monster][invokeType]
			end

			return configDict[monster][invokeType][tostring(param)]
		end
	end
end

function FightBgmMgr:_getCurBgAudioId()
	local fightParam = FightModel.instance:getFightParam()

	if fightParam then
		::label_25_0::

		local var_25_0 = fightParam.battleId

		if fightParam.battleId then
			local battleCO = lua_battle.configDict[fightParam.battleId]

			if battleCO and battleCO.bgmevent and battleCO.bgmevent > 0 then
				return battleCO.bgmevent
			end

			local wave = FightModel.instance:getCurWaveId()
			local levelId = fightParam:getSceneLevel(wave)
			local sceneLevelCO = lua_scene_level.configDict[levelId]

			if sceneLevelCO.bgm and sceneLevelCO.bgm > 0 then
				return sceneLevelCO.bgm
			end
		end
	end
end

function FightBgmMgr:_playAmbientSound()
	local wave = FightModel.instance:getCurWaveId()
	local levelId = FightModel.instance:getFightParam():getSceneLevel(wave)
	local sceneLevelCO = lua_scene_level.configDict[levelId]

	if sceneLevelCO.ambientSound and sceneLevelCO.ambientSound > 0 and sceneLevelCO.ambientSound ~= self._ambientSound then
		self._ambientSound = sceneLevelCO.ambientSound

		AudioMgr.instance:trigger(self._ambientSound)
	end
end

function FightBgmMgr:stopBgm()
	if self._bgAudioId then
		self._stopBgAudioId = self._bgAudioId
		self._bgAudioId = nil

		AudioBgmManager.instance:stopAndRemove(AudioBgmEnum.Layer.Fight)
	end

	self._ambientSound = nil

	AudioMgr.instance:trigger(AudioEnum.UI.stop_combatnoise_bus)
end

function FightBgmMgr:resumeBgm()
	self._cur_switch = nil

	if self._stopBgAudioId then
		self._bgAudioId = self._stopBgAudioId
		self._stopBgAudioId = nil

		self:_playBgm()
		self:_playAmbientSound()
	end
end

function FightBgmMgr:_onRestartFightDisposeDone()
	self._cur_switch = nil

	FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Comeshow)

	local fightParam = FightModel.instance:getFightParam()

	if self._bgAudioId then
		self:_detectDefaultSwitch(fightParam.episodeId)
	end
end

function FightBgmMgr:_onSwitchPlaneClearAssetDone()
	self._cur_switch = nil

	FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Comeshow)

	local fightParam = FightModel.instance:getFightParam()

	if self._bgAudioId then
		self:_detectDefaultSwitch(fightParam.episodeId)
	end
end

function FightBgmMgr:_onPlayDialog(id)
	local config = self:_getConfig(nil, 0, 13, id)

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()

	return true
end

function FightBgmMgr:_onAfterPlayDialog(id)
	local config = self:_getConfig(nil, 0, 14, id)

	if not config then
		return
	end

	if self._cur_switch == config.switch then
		return
	end

	self._cur_switch = config.switch

	self:_switchMonsterGroup()

	return true
end

function FightBgmMgr:onDestructor()
	self:stopBgm()
end

return FightBgmMgr
