-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/season/events/s3/SeasonSceneEventBossDoppelgangerS3.lua

module("logicscene.scene.unit.component.season.events.s3.SeasonSceneEventBossDoppelgangerS3", package.seeall)

local SeasonSceneEventBossDoppelgangerS3 = class("SeasonSceneEventBossDoppelgangerS3", SeasonSceneEventChallengeImpl)

function SeasonSceneEventBossDoppelgangerS3:_getModelResPath()
	if not self:_needShowModel() then
		return
	end

	local seasonId = SeasonModel.instance:getSeasonId()
	local challengeCfg = SeasonConfig.instance:getMapEvtDetail(seasonId, self.evtData.eventType, self.evtData.eventId)
	local skinId = checknumber(challengeCfg.skinId)

	if skinId == 0 then
		local creepCo = self:_getCreepCo(challengeCfg.creepsMasterId)

		if not creepCo then
			return
		end

		skinId = checknumber(creepCo.raceId)
	end

	local modelCo = CharacterConfig.instance:getModelCo(skinId)

	return (GameUrl.getSpineUrl(modelCo.resName))
end

function SeasonSceneEventBossDoppelgangerS3:handleBossPhaseChange(prePhaseId, curPhaseId)
	self._preparePlayDoppelgangerAppear = false
	self._preparePlayDoppelgangerDisappear = false

	if prePhaseId == 0 or prePhaseId == curPhaseId then
		return
	end

	local pevCfg = SeasonConfig.instance:getSeasonPVEConfig(SeasonModel.instance:getSeasonId())
	local bossPhaseId = checknumber(pevCfg.bossPhaseId)
	local doppelgangerPhaseId = checknumber(pevCfg.bossDoppelgangerPhaseId)

	if curPhaseId == doppelgangerPhaseId then
		if not self._unit:isClipping() and not self._resObject then
			self:onActive()
		end
	elseif curPhaseId == bossPhaseId then
		self._preparePlayDoppelgangerDisappear = true

		if not self._unit:isClipping() and not self._resObject then
			self:onActive()
		end

		self._unit:setVisible(true)
	end
end

function SeasonSceneEventBossDoppelgangerS3:setPlayedDoppelgangerAppear()
	self._preparePlayDoppelgangerAppear = false

	self._unit:setVisible(true)
end

function SeasonSceneEventBossDoppelgangerS3:setPlayedBossAppear()
	self._preparePlayDoppelgangerDisappear = false

	self:onDeactive()
end

function SeasonSceneEventBossDoppelgangerS3:_onModelLoadedFinish()
	SeasonSceneEventBossDoppelgangerS3.super._onModelLoadedFinish(self)

	if self._preparePlayDoppelgangerAppear then
		self._unit:setVisible(false)
	else
		self._unit:setVisible(true)
	end
end

function SeasonSceneEventBossDoppelgangerS3:_needShowModel()
	if self._preparePlayDoppelgangerAppear or self._preparePlayDoppelgangerDisappear then
		return true
	end

	local bossMo = SeasonModel.instance.bossMo
	local pevCfg = SeasonConfig.instance:getSeasonPVEConfig(SeasonModel.instance:getSeasonId())
	local doppelgangerPhaseId = checknumber(pevCfg.bossDoppelgangerPhaseId)

	return doppelgangerPhaseId >= bossMo.phaseId
end

return SeasonSceneEventBossDoppelgangerS3
