-- chunkname: @modules/logic/explore/controller/steps/ExploreArchiveClientStep.lua

module("modules.logic.explore.controller.steps.ExploreArchiveClientStep", package.seeall)

local ExploreArchiveClientStep = class("ExploreArchiveClientStep", ExploreStepBase)

function ExploreArchiveClientStep:onStart()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)

	local mapId = ExploreModel.instance:getMapId()
	local mapCo = ExploreConfig.instance:getMapIdConfig(mapId)

	ViewMgr.instance:openView(ViewName.ExploreArchivesDetailView, {
		id = self._data.archiveId,
		chapterId = mapCo.chapterId
	})
end

function ExploreArchiveClientStep:_onCloseViewFinish(viewName)
	if ViewName.ExploreArchivesDetailView == viewName then
		self:onDone()
	end
end

function ExploreArchiveClientStep:onDestory()
	ExploreArchiveClientStep.super.onDestory(self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

return ExploreArchiveClientStep
