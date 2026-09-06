-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/season/events/SeasonSceneEventChallengeS2Impl.lua

module("logicscene.scene.unit.component.season.events.SeasonSceneEventChallengeS2Impl", package.seeall)

local SeasonSceneEventChallengeS2Impl = class("SeasonSceneEventChallengeS2Impl", SeasonSceneEventChallengeImpl)

function SeasonSceneEventChallengeS2Impl:onActive(evtGo)
	SeasonSceneEventChallengeS2Impl.super.onActive(self, evtGo)
	self:_loadChallengeEffect()
end

function SeasonSceneEventChallengeS2Impl:onDeactive()
	SeasonSceneEventChallengeS2Impl.super.onDeactive(self)

	if self._bossEffectLoop then
		self._unit.scene.resCache:recycleObject(self._bossEffectLoop)

		self._bossEffectLoop = nil
	end
end

function SeasonSceneEventChallengeS2Impl:_getModelResPath()
	local isBossPoint = false

	for i, v in ipairs(SeasonPVEBossController.instance:getDoppelgangerReadOnlyPointIds()) do
		if self.evtData.id == v then
			isBossPoint = true
		end
	end

	if isBossPoint == true and not self:_checkBossShow() then
		return
	end

	local seasonId = SeasonModel.instance:getSeasonId()
	local challengeCfg = SeasonConfig.instance:getMapEvtDetail(seasonId, self.evtData.eventType, self.evtData.eventId)

	if not challengeCfg.isElite then
		return
	end

	local creepCo = self:_getCreepCo(challengeCfg.creepsMasterId)

	if not creepCo then
		return
	end

	local skinId = creepCo.raceId

	if isBossPoint == true then
		local plusCfg = SeasonConfig.instance:getBossPlusCfg(seasonId, self.evtData.id)

		if plusCfg and checknumber(plusCfg.skinId) > 0 then
			skinId = plusCfg.skinId
		end
	end

	if SeasonModel.instance:isOccupied(self.evtData.id) then
		return
	end

	local mapMo = SeasonModel.instance:getMapInfoById(self.evtData.id)

	if mapMo then
		local gridX, gridY = mapMo:getGridPos()

		if mapMo._fogState == SeasonMapDataMO.Fog_Within then
			return
		end
	end

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	return (GameUrl.getSpineUrl(modelCo.resName))
end

function SeasonSceneEventChallengeS2Impl:_checkBossShow()
	if self._preparePlayDoppelgangerAppear and self._preparePlayDoppelgangerAppear == true then
		return true
	end

	if not SeasonPVES2BossController.instance:isDefendBossShow() then
		return false
	end

	return true
end

function SeasonSceneEventChallengeS2Impl:handleBossPhaseChange(prePhaseId, curPhaseId)
	self._preparePlayDoppelgangerAppear = false

	if prePhaseId == 0 or prePhaseId == curPhaseId then
		return
	end

	local pevCfg = SeasonConfig.instance:getSeasonPVEConfig(SeasonModel.instance:getSeasonId())
	local bossPhaseId = checknumber(pevCfg.bossPhaseId)
	local doppelgangerPhaseId = checknumber(pevCfg.bossDoppelgangerPhaseId)
	local defendPhaseId = SeasonConfig.instance:getCommonValue("DEFEND_BOSS_SHOW_PHASEID", true)

	if curPhaseId == defendPhaseId then
		self._preparePlayDoppelgangerAppear = true

		if not self._unit:isClipping() and not self._resObject then
			self:onActive()
		end

		self._unit:setVisible(false)
	end
end

function SeasonSceneEventChallengeS2Impl:setPlayedDoppelgangerAppear()
	self._preparePlayDoppelgangerAppear = false

	self:onDeactive()
end

function SeasonSceneEventChallengeS2Impl:_onModelLoadedFinish()
	SeasonSceneEventChallengeS2Impl.super._onModelLoadedFinish(self)

	if self._preparePlayDoppelgangerAppear == true then
		self._unit:setVisible(false)
	else
		self._unit:setVisible(true)
	end
end

function SeasonSceneEventChallengeS2Impl:_loadChallengeEffect()
	local isBossPoint = false

	for i, v in ipairs(SeasonPVEBossController.instance:getDoppelgangerReadOnlyPointIds()) do
		if self.evtData.id == v then
			isBossPoint = true
		end
	end

	if not isBossPoint or isBossPoint == true and not self:_checkBossShow() then
		return
	end

	local path = "effect/prefabs/ui/20230120/yijiezhanchangchangjing/fx_yijiezhanchang_boss_loop.prefab"

	if not self._bossEffectLoop then
		self._bossEffectLoop = self._unit.scene.resCache:newObject(path)

		self._bossEffectLoop:setParent(self._unit.go.transform)
		self._bossEffectLoop:setScale(1)
		self._bossEffectLoop:setLocalPos(0, 0, -0.015)
		self._bossEffectLoop:setSortingOrder(self._unit:getSortingOrderOffset(1))

		self._bossEffectLoop.loadedHandler = self._onBossEffectResLoadedFinish
		self._bossEffectLoop.loadedHandlerTarget = self
	else
		self:_onBossEffectResLoadedFinish()
	end
end

function SeasonSceneEventChallengeS2Impl:_onBossEffectResLoadedFinish()
	return
end

return SeasonSceneEventChallengeS2Impl
