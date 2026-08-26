-- chunkname: @modules/logic/explore/controller/steps/ExploreBonusSceneClientStep.lua

module("modules.logic.explore.controller.steps.ExploreBonusSceneClientStep", package.seeall)

local ExploreBonusSceneClientStep = class("ExploreBonusSceneClientStep", ExploreStepBase)

function ExploreBonusSceneClientStep:onStart()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)

	local mapId = ExploreModel.instance:getMapId()
	local mapCo = ExploreConfig.instance:getMapIdConfig(mapId)

	ViewMgr.instance:openView(ViewName.ExploreBonusSceneRecordView, {
		chapterId = mapCo.chapterId
	})
end

function ExploreBonusSceneClientStep:_onCloseViewFinish(viewName)
	if ViewName.ExploreBonusSceneRecordView == viewName then
		self:onDone()
	end
end

function ExploreBonusSceneClientStep:onDestory()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	ExploreBonusSceneClientStep.super.onDestory(self)
end

return ExploreBonusSceneClientStep
