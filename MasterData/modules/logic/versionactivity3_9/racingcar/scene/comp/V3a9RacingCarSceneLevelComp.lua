-- chunkname: @modules/logic/versionactivity3_9/racingcar/scene/comp/V3a9RacingCarSceneLevelComp.lua

module("modules.logic.versionactivity3_9.racingcar.scene.comp.V3a9RacingCarSceneLevelComp", package.seeall)

local V3a9RacingCarSceneLevelComp = class("V3a9RacingCarSceneLevelComp", CommonSceneLevelComp)

function V3a9RacingCarSceneLevelComp:init(sceneId, levelId)
	self:loadLevel(levelId)
end

function V3a9RacingCarSceneLevelComp:onSceneStart(sceneId, levelId)
	self._sceneId = sceneId
	self._levelId = levelId
end

function V3a9RacingCarSceneLevelComp:getSceneLevelUrl()
	local trackId = V3a9RacingCarModel.instance:getTrackId()

	return (string.format("scenes/v3a9_m_s21_racing_games/scene/racing39_config_%03d/racing39_config_%03d_simple.prefab", trackId, trackId))
end

function V3a9RacingCarSceneLevelComp:_onLoadCallback(assetItem)
	V3a9RacingCarSceneLevelComp.super._onLoadCallback(self, assetItem)
end

return V3a9RacingCarSceneLevelComp
