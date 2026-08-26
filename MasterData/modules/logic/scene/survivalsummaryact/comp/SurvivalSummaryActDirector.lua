-- chunkname: @modules/logic/scene/survivalsummaryact/comp/SurvivalSummaryActDirector.lua

module("modules.logic.scene.survivalsummaryact.comp.SurvivalSummaryActDirector", package.seeall)

local SurvivalSummaryActDirector = class("SurvivalSummaryActDirector", BaseSceneComp)

function SurvivalSummaryActDirector:onInit()
	self._scene = self:getCurScene()
end

function SurvivalSummaryActDirector:onSceneStart(sceneId, levelId)
	self._compInitSequence = FlowSequence.New()

	local levelAndPreloadWork = FlowParallel.New()

	self._compInitSequence:addWork(levelAndPreloadWork)
	levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.level, CommonSceneLevelComp.OnLevelLoaded))

	if self._scene.fog then
		levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.fog, SurvivalEvent.OnSurvivalFogLoaded))
	end

	levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.block, SurvivalEvent.OnSurvivalBlockLoadFinish))

	if self._scene.spBlock then
		levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.spBlock, SurvivalEvent.OnSurvivalBlockLoadFinish))
	end

	levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.preloader, SurvivalEvent.OnSurvivalPreloadFinish))

	if self._scene.cloud then
		self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.cloud))
	end

	self._compInitSequence:addWork(BpWaitSecWork.New(0.3))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.graphics))
	self._compInitSequence:addWork(BpWaitSecWork.New(0.3))
	self._compInitSequence:registerDoneListener(self._compInitDone, self)
	self._compInitSequence:start({
		sceneId = sceneId,
		levelId = levelId
	})
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.onOpenView, self)
end

function SurvivalSummaryActDirector:onOpenView(viewName)
	if viewName == ViewName.SurvivalSummaryActView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.onOpenView, self)
		ViewMgr.instance:closeView(ViewName.SurvivalLoadingView, true)
	end
end

function SurvivalSummaryActDirector:_compInitDone()
	self._scene:onPrepared()

	self._compInitSequence = nil

	ViewMgr.instance:openView(ViewName.SurvivalSummaryActView)
end

function SurvivalSummaryActDirector:onSceneClose()
	if self._compInitSequence then
		self._compInitSequence:destroy()

		self._compInitSequence = nil
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.onOpenView, self)
end

return SurvivalSummaryActDirector
