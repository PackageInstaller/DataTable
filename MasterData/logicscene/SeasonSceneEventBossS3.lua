-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/season/events/s3/SeasonSceneEventBossS3.lua

module("logicscene.scene.unit.component.season.events.s3.SeasonSceneEventBossS3", package.seeall)

local SeasonSceneEventBossS3 = class("SeasonSceneEventBossS3", SeasonSceneEventBossDoppelganger)

function SeasonSceneEventBossS3:_getModelResPath()
	if not self:_needShowModel() then
		return
	end

	local skinId = SeasonConfig.instance:getCommonValue("BOSS_GUIDE_SKINID", true)
	local modelCo = CharacterConfig.instance:getModelCo(skinId)

	return (GameUrl.getSpineUrl(modelCo.resName))
end

function SeasonSceneEventBossS3:_loadModelByResPath(resPath)
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

function SeasonSceneEventBossS3:_needShowModel()
	if self._preparePlayerBossAppear or self._preparePlayDoppelgangerAppear then
		return true
	end

	if SeasonModel.instance:isOccupied(self.evtData.id) then
		return
	end

	local bossMo = SeasonModel.instance.bossMo
	local pevCfg = SeasonConfig.instance:getSeasonPVEConfig(SeasonModel.instance:getSeasonId())
	local bossPhaseId = checknumber(pevCfg.bossPhaseId)

	return bossMo.phaseId == bossPhaseId
end

function SeasonSceneEventBossS3:handleBossPhaseChange(prePhaseId, curPhaseId)
	self._preparePlayerBossAppear = false

	if prePhaseId == 0 or prePhaseId == curPhaseId then
		return
	end

	local pevCfg = SeasonConfig.instance:getSeasonPVEConfig(SeasonModel.instance:getSeasonId())
	local bossPhaseId = checknumber(pevCfg.bossPhaseId)

	if curPhaseId == bossPhaseId then
		self._preparePlayerBossAppear = true

		if not self._unit:isClipping() and not self._resObject then
			self:onActive()
		end

		self._unit:setVisible(false)
	end
end

function SeasonSceneEventBossS3:_onModelLoadedFinish()
	SeasonSceneEventBossS3.super.super._onModelLoadedFinish(self)

	if self._preparePlayerBossAppear == true then
		self._unit:setVisible(false)
	else
		self._unit:setVisible(true)
	end
end

function SeasonSceneEventBossS3:setPlayedBossAppear()
	self._preparePlayerBossAppear = false

	self._unit:setVisible(true)
end

return SeasonSceneEventBossS3
