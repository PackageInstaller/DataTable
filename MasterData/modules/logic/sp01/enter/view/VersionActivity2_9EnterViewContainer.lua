-- chunkname: @modules/logic/sp01/enter/view/VersionActivity2_9EnterViewContainer.lua

module("modules.logic.sp01.enter.view.VersionActivity2_9EnterViewContainer", package.seeall)

local VersionActivity2_9EnterViewContainer = class("VersionActivity2_9EnterViewContainer", BaseViewContainer)

function VersionActivity2_9EnterViewContainer:buildViews()
	return {
		VersionActivity2_9EnterView.New(),
		VersionActivity2_9EnterViewAnimComp.New(),
		VersionActivity2_9EnterViewBgmComp.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function VersionActivity2_9EnterViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		}, nil, self.customColseBtnCallBack, nil, nil, self)
	}
end

function VersionActivity2_9EnterViewContainer:customColseBtnCallBack()
	VersionActivity2_9EnterController.instance:clearLastEnterMainActId()
	self:closeThis()
end

function VersionActivity2_9EnterViewContainer:onContainerInit()
	local mainActIdList = self.viewParam.mainActIdList

	for i = #mainActIdList, 1, -1 do
		local status = ActivityHelper.getActivityStatus(mainActIdList[i])

		if status == ActivityEnum.ActivityStatus.Normal then
			ActivityStageHelper.recordActivityStage(self.viewParam.activityIdListWithGroup[mainActIdList[i]])

			return
		end
	end

	ActivityStageHelper.recordActivityStage(self.viewParam.activityIdListWithGroup[mainActIdList[1]])
end

function VersionActivity2_9EnterViewContainer:playOpenTransition()
	self:startViewOpenBlock()

	if self.viewParam.skipOpenAnim then
		self:onPlayOpenTransitionFinish()
	else
		TaskDispatcher.runDelay(self.onPlayOpenTransitionFinish, self, 1.1)
	end
end

function VersionActivity2_9EnterViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

return VersionActivity2_9EnterViewContainer
