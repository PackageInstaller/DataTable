-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/season/events/SeasonSceneEventBossS2.lua

module("logicscene.scene.unit.component.season.events.SeasonSceneEventBossS2", package.seeall)

local SeasonSceneEventBossS2 = class("SeasonSceneEventBossS2", SeasonSceneEventBossDoppelganger)

function SeasonSceneEventBossS2:onActive(evtGo)
	SeasonSceneEventBossS2.super.onActive(self, evtGo)
	self:_loadChallengeEffect()
end

function SeasonSceneEventBossS2:onDeactive()
	SeasonSceneEventBossS2.super.onDeactive(self)

	if self._bossEffectLoop then
		self._unit.scene.resCache:recycleObject(self._bossEffectLoop)

		self._bossEffectLoop = nil
	end
end

function SeasonSceneEventBossS2:_getModelResPath()
	if not self:_needShowModel() then
		return
	end

	if SeasonModel.instance:isOccupied(self.evtData.id) then
		return
	end

	local bossCfg = SeasonConfig.instance:getMapEvtDetail(self.evtData.seasonId, SeasonGridEvtTypes.EVT_BOSS, self.evtData.eventId)
	local team = SeasonConfig.instance:getCreeps(bossCfg.creepsMasterId)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(team[1].faceId) > 0 and checknumber(team[1].faceId) or checknumber(team[1].raceId))

	return (GameUrl.getSpineUrl(modelCo.resName))
end

function SeasonSceneEventBossS2:_loadModelByResPath(resPath)
	if not resPath then
		return
	end

	self._resObject = self._unit.scene.resCache:newObject(resPath)
	self._resObject.loadedHandler = self._onModelLoadedFinish
	self._resObject.loadedHandlerTarget = self

	self._resObject:setParent(self._unit.go.transform)
	self._resObject:setScale(0.2)
	self._resObject:setLocalPos(0, -0.25, 0)
end

function SeasonSceneEventBossS2:_needShowModel()
	if self._preparePlayerBossAppear == true or self._preparePlayDoppelgangerAppear == true then
		return true
	end

	if SeasonPVES2BossController.instance:isFinalBossShow() == true then
		return true
	end

	return false
end

function SeasonSceneEventBossS2:handleBossPhaseChange(prePhaseId, curPhaseId)
	self._preparePlayerBossAppear = false

	if prePhaseId == 0 or prePhaseId == curPhaseId then
		return
	end

	local pevCfg = SeasonConfig.instance:getSeasonPVEConfig(SeasonModel.instance:getSeasonId())
	local bossPhaseId = checknumber(pevCfg.bossPhaseId)
	local bossShowPhaseId = SeasonConfig.instance:getCommonValue("FINAL_BOSS_SHOW_PHASEID", true)
	local defendBossShowPhaseId = SeasonConfig.instance:getCommonValue("DEFEND_BOSS_SHOW_PHASEID", true)

	if curPhaseId == bossShowPhaseId and curPhaseId == defendBossShowPhaseId then
		self._preparePlayerBossAppear = true

		if not self._unit:isClipping() and not self._resObject then
			self:onActive()
		end

		self._unit:setVisible(false)
	elseif curPhaseId == bossShowPhaseId then
		if not self._unit:isClipping() and not self._resObject then
			self:onActive()
		end

		self._unit:setVisible(true)
	end
end

function SeasonSceneEventBossS2:_onModelLoadedFinish()
	SeasonSceneEventBossS2.super.super._onModelLoadedFinish(self)

	if self._preparePlayerBossAppear == true then
		self._unit:setVisible(false)
	else
		self._unit:setVisible(true)
	end
end

function SeasonSceneEventBossS2:setPlayedBossAppear()
	self._preparePlayerBossAppear = false

	self._unit:setVisible(true)
end

function SeasonSceneEventBossS2:_loadChallengeEffect()
	if not SeasonPVES2BossController.instance:isFinalBossShow() then
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

function SeasonSceneEventBossS2:_onBossEffectResLoadedFinish()
	return
end

return SeasonSceneEventBossS2
