-- chunkname: @modules/logic/scene/survival/comp/SurvivalSceneDirector.lua

module("modules.logic.scene.survival.comp.SurvivalSceneDirector", package.seeall)

local SurvivalSceneDirector = class("SurvivalSceneDirector", BaseSceneComp)

function SurvivalSceneDirector:onInit()
	self._scene = self:getCurScene()
end

function SurvivalSceneDirector:onSceneStart(sceneId, levelId)
	self._scene = self:getCurScene()
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
end

function SurvivalSceneDirector:_compInitDone()
	self._scene:onPrepared()

	self._compInitSequence = nil

	self:startEnterProgress()
end

function SurvivalSceneDirector:startEnterProgress()
	local survivalOpenViewWork = SurvivalOpenViewWork.New({
		viewName = ViewName.SurvivalMapMainView
	})

	survivalOpenViewWork:registerDoneListener(self.onOpenView, self)

	local parallel = FlowParallel.New()

	parallel:addWork(survivalOpenViewWork)

	self.flow = FlowSequence.New()

	self.flow:addWork(TimerWork.New(0.1))
	self.flow:addWork(parallel)
	self.flow:start()
end

function SurvivalSceneDirector:onOpenView()
	self:onSurvivalMainViewOpen()
end

function SurvivalSceneDirector:onSurvivalMainViewOpen()
	ViewMgr.instance:closeView(ViewName.SurvivalLoadingView)
end

function SurvivalSceneDirector:onSceneClose()
	if self._compInitSequence then
		self._compInitSequence:destroy()

		self._compInitSequence = nil
	end

	self:disposeEnterProgress()
end

function SurvivalSceneDirector:disposeEnterProgress()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end
end

return SurvivalSceneDirector
