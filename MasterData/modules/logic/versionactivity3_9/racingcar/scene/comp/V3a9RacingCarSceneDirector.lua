-- chunkname: @modules/logic/versionactivity3_9/racingcar/scene/comp/V3a9RacingCarSceneDirector.lua

module("modules.logic.versionactivity3_9.racingcar.scene.comp.V3a9RacingCarSceneDirector", package.seeall)

local V3a9RacingCarSceneDirector = class("V3a9RacingCarSceneDirector", BaseSceneComp)

function V3a9RacingCarSceneDirector:onInit()
	self._scene = self:getCurScene()
end

function V3a9RacingCarSceneDirector:_onLevelLoaded()
	self._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
	self._scene:onPrepared()
end

function V3a9RacingCarSceneDirector:onSceneStart(sceneId, levelId)
	self._scene = self:getCurScene()
	self._compInitSequence = FlowSequence.New()

	local levelAndPreloadWork = FlowParallel.New()

	self._compInitSequence:addWork(levelAndPreloadWork)
	levelAndPreloadWork:addWork(V3a9RacingCarSceneWaitEventCompWork.New(self._scene.level, CommonSceneLevelComp.OnLevelLoaded))
	levelAndPreloadWork:addWork(V3a9RacingCarSceneWaitEventCompWork.New(self._scene.preloader, V3a9RacingCarScenePreloader.OnPreloadFinish))
	self._compInitSequence:registerDoneListener(self._compInitDone, self)
	self._compInitSequence:start({
		sceneId = sceneId,
		levelId = levelId
	})
end

function V3a9RacingCarSceneDirector:_compInitDone()
	self._scene:onPrepared()
end

function V3a9RacingCarSceneDirector:onScenePrepared(sceneId, levelId)
	return
end

function V3a9RacingCarSceneDirector:onSceneClose()
	if self._compInitSequence then
		self._compInitSequence:unregisterDoneListener(self._compInitDone, self)
		self._compInitSequence:stop()

		self._compInitSequence = nil
	end
end

return V3a9RacingCarSceneDirector
