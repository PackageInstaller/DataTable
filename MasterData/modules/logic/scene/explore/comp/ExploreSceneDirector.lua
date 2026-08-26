-- chunkname: @modules/logic/scene/explore/comp/ExploreSceneDirector.lua

module("modules.logic.scene.explore.comp.ExploreSceneDirector", package.seeall)

local ExploreSceneDirector = class("ExploreSceneDirector", BaseSceneComp)

function ExploreSceneDirector:onInit()
	self._scene = self:getCurScene()
end

function ExploreSceneDirector:onSceneStart(sceneId, levelId)
	self._scene = self:getCurScene()
	self._compInitSequence = FlowSequence.New()

	local levelAndPreloadWork = FlowParallel.New()

	self._compInitSequence:addWork(levelAndPreloadWork)
	levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.map, ExploreEvent.InitMapDone))
	levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.level, CommonSceneLevelComp.OnLevelLoaded))
	levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.preloader, ExploreEvent.OnExplorePreloadFinish))
	self._compInitSequence:registerDoneListener(self._compInitDone, self)
	self._compInitSequence:start({
		sceneId = sceneId,
		levelId = levelId
	})
end

function ExploreSceneDirector:_compInitDone()
	self._scene:onPrepared()

	self._compInitSequence = nil
end

function ExploreSceneDirector:onSceneClose()
	if self._compInitSequence then
		self._compInitSequence:destroy()

		self._compInitSequence = nil
	end
end

function ExploreSceneDirector:_onLevelLoaded(levelId)
	return
end

return ExploreSceneDirector
