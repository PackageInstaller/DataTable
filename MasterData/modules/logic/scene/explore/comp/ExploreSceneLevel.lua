-- chunkname: @modules/logic/scene/explore/comp/ExploreSceneLevel.lua

module("modules.logic.scene.explore.comp.ExploreSceneLevel", package.seeall)

local ExploreSceneLevel = class("ExploreSceneLevel", CommonSceneLevelComp)

function ExploreSceneLevel:init(sceneId, levelId)
	self:loadLevel(levelId)
end

function ExploreSceneLevel:onSceneStart(sceneId, levelId)
	self._sceneId = sceneId
	self._levelId = levelId
end

function ExploreSceneLevel:loadLevel(levelId)
	if self._isLoadingRes then
		logError("is loading scene level res, cur id = " .. (self._levelId or "nil") .. ", try to load id = " .. (levelId or "nil"))

		return
	end

	if self._assetItem then
		gohelper.destroy(self._instGO)
		self._assetItem:Release()

		self._assetItem = nil
		self._instGO = nil
	end

	self._isLoadingRes = true
	self._levelId = levelId

	self:getCurScene():setCurLevelId(self._levelId)

	self._resPath = ResUrl.getExploreSceneLevelUrl(levelId)

	loadAbAsset(self._resPath, false, self._onLoadCallback, self)
end

return ExploreSceneLevel
