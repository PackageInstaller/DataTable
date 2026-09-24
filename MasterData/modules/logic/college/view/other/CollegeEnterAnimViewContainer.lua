-- chunkname: @modules/logic/college/view/other/CollegeEnterAnimViewContainer.lua

module("modules.logic.college.view.other.CollegeEnterAnimViewContainer", package.seeall)

local CollegeEnterAnimViewContainer = class("CollegeEnterAnimViewContainer", BaseViewContainer)

function CollegeEnterAnimViewContainer:buildViews()
	return {}
end

function CollegeEnterAnimViewContainer:onContainerOpen()
	UIBlockMgrExtend.CircleMvDelay = 10

	UIBlockHelper.instance:startBlock(self.viewName, 3)
	TaskDispatcher.runDelay(self._delayClose, self, 2)
	UIBlockMgrExtend.instance:resetMaskShow()
	CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.EnterCollege)
end

function CollegeEnterAnimViewContainer:_delayClose()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onViewOpen, self)
	ViewMgr.instance:openView(ViewName.CollegeMainView)
end

function CollegeEnterAnimViewContainer:_onViewOpen(viewName)
	if viewName == ViewName.CollegeMainView then
		self:closeThis()
	end
end

function CollegeEnterAnimViewContainer:onContainerClose()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onViewOpen, self)
	TaskDispatcher.cancelTask(self._delayClose, self)

	UIBlockMgrExtend.CircleMvDelay = nil
end

return CollegeEnterAnimViewContainer
