-- chunkname: @modules/logic/versionactivity1_5/enter/view/VersionActivity1_5EnterViewContainer.lua

module("modules.logic.versionactivity1_5.enter.view.VersionActivity1_5EnterViewContainer", package.seeall)

local VersionActivity1_5EnterViewContainer = class("VersionActivity1_5EnterViewContainer", BaseViewContainer)

function VersionActivity1_5EnterViewContainer:buildViews()
	return {
		VersionActivity1_5EnterView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function VersionActivity1_5EnterViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function VersionActivity1_5EnterViewContainer:onContainerInit()
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

function VersionActivity1_5EnterViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

return VersionActivity1_5EnterViewContainer
