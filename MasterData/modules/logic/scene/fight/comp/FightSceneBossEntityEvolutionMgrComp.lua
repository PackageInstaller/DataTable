-- chunkname: @modules/logic/scene/fight/comp/FightSceneBossEntityEvolutionMgrComp.lua

module("modules.logic.scene.fight.comp.FightSceneBossEntityEvolutionMgrComp", package.seeall)

local FightSceneBossEntityEvolutionMgrComp = class("FightSceneBossEntityEvolutionMgrComp", BaseSceneComp)

function FightSceneBossEntityEvolutionMgrComp:onSceneStart(sceneId, levelId)
	self._entityDic = {}
	self._entityVisible = {}
	self._skinId2Entity = {}
	self._skinIds = {}
	self._delayReleaseEntity = {}
end

function FightSceneBossEntityEvolutionMgrComp:onScenePrepared(sceneId, levelId)
	FightController.instance:registerCallback(FightEvent.SetBossEvolution, self._onSetBossEvolution, self)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, self._onRestartStageBefore, self)
	FightController.instance:registerCallback(FightEvent.OnSwitchPlaneClearAsset, self._onSwitchPlaneClearAsset, self)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	FightController.instance:registerCallback(FightEvent.OnCameraFocusChanged, self._onCameraFocusChanged, self)
	FightController.instance:registerCallback(FightEvent.ReleaseAllEntrustedEntity, self._releaseAllEntity, self)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
end

function FightSceneBossEntityEvolutionMgrComp:_onLevelLoaded()
	self._sceneObj = FightGameMgr.sceneLevelMgr:getSceneGo()
end

function FightSceneBossEntityEvolutionMgrComp:isEvolutionSkin(skinId)
	return self._skinIds[skinId]
end

function FightSceneBossEntityEvolutionMgrComp:_onSetBossEvolution(tempEntity, skinId)
	local entityId = tempEntity.id

	if self._entityDic[entityId] then
		self:_releaseEntity(self._entityDic[entityId])
	end

	self._entityDic[entityId] = tempEntity
	self._entityVisible[entityId] = 0

	tempEntity.spine:play(tempEntity.spine._curAnimState, true)

	self._skinId2Entity[skinId] = self._skinId2Entity[skinId] or {}

	table.insert(self._skinId2Entity[skinId], tempEntity)

	self._skinIds[skinId] = true
end

function FightSceneBossEntityEvolutionMgrComp:_onSpineLoaded(spine)
	local entity = spine.unitSpawn
	local entityMO = entity and entity:getMO()

	if entityMO and self._skinId2Entity[entityMO.skin] then
		for i, v in ipairs(self._skinId2Entity[entityMO.skin]) do
			local mainSpine = v.spine

			if mainSpine then
				::label_6_0::

				local var_6_0 = mainSpine._skeletonAnim

				if mainSpine._skeletonAnim then
					local curTrack = mainSpine._skeletonAnim.state:GetCurrent(0)

					if curTrack and spine._skeletonAnim then
						spine._skeletonAnim:Jump2Time(curTrack.TrackTime)
					end

					local tab = {}

					tab.entity = v

					local spineGO = spine:getSpineGO()

					tab.spineGO = spineGO

					transformhelper.setLocalPos(spineGO.transform, -10000, 0, 0)
					table.insert(self._delayReleaseEntity, tab)
				end
			end
		end

		TaskDispatcher.runDelay(self._delayRelease, self, 0.01)

		self._skinId2Entity[entityMO.skin] = nil
	end
end

function FightSceneBossEntityEvolutionMgrComp:_delayRelease()
	for i, v in ipairs(self._delayReleaseEntity) do
		self:_releaseEntity(v.entity)
		transformhelper.setLocalPos(v.spineGO.transform, 0, 0, 0)
	end

	self._delayReleaseEntity = {}
end

function FightSceneBossEntityEvolutionMgrComp:_onSkillPlayStart()
	for k, v in pairs(self._entityDic) do
		self._entityVisible[v.id] = (self._entityVisible[v.id] or 0) + 1

		v:setAlpha(0, 0.2)
	end
end

function FightSceneBossEntityEvolutionMgrComp:_onSkillPlayFinish()
	for k, v in pairs(self._entityDic) do
		if self._entityVisible[v.id] then
			self._entityVisible[v.id] = self._entityVisible[v.id] - 1

			if self._entityVisible[v.id] < 0 then
				self._entityVisible[v.id] = 0
			end
		end

		if self._entityVisible[v.id] == 0 then
			v:setAlpha(1, 0.2)
			FightGameMgr.entityMgr:adjustSpineLookRotation(v)
		end
	end
end

function FightSceneBossEntityEvolutionMgrComp:_onCameraFocusChanged(state)
	if state then
		self:_onSkillPlayStart()
	else
		self:_onSkillPlayFinish()
	end
end

function FightSceneBossEntityEvolutionMgrComp:_releaseEntity(entity)
	if self._entityDic[entity.id] then
		self._entityDic[entity.id]:disposeSelf()

		self._entityDic[entity.id] = nil
		self._entityVisible[entity.id] = nil
	end
end

function FightSceneBossEntityEvolutionMgrComp:_releaseAllEntity()
	for k, entity in pairs(self._entityDic) do
		self:_releaseEntity(entity)
	end

	self._skinId2Entity = {}
	self._skinIds = {}
	self._delayReleaseEntity = {}
end

function FightSceneBossEntityEvolutionMgrComp:_onRestartStageBefore()
	self:_releaseAllEntity()
end

function FightSceneBossEntityEvolutionMgrComp:_onSwitchPlaneClearAsset()
	self:_releaseAllEntity()
end

function FightSceneBossEntityEvolutionMgrComp:onSceneClose(sceneId, levelId)
	TaskDispatcher.cancelTask(self._delayRelease, self)
	FightController.instance:unregisterCallback(FightEvent.SetBossEvolution, self._onSetBossEvolution, self)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, self._onRestartStageBefore, self)
	FightController.instance:unregisterCallback(FightEvent.OnSwitchPlaneClearAsset, self._onSwitchPlaneClearAsset, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	FightController.instance:unregisterCallback(FightEvent.OnCameraFocusChanged, self._onCameraFocusChanged, self)
	FightController.instance:unregisterCallback(FightEvent.ReleaseAllEntrustedEntity, self._releaseAllEntity, self)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
	self:_releaseAllEntity()
end

return FightSceneBossEntityEvolutionMgrComp
