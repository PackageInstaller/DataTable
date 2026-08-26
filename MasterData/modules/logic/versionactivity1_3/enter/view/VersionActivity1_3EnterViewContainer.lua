-- chunkname: @modules/logic/versionactivity1_3/enter/view/VersionActivity1_3EnterViewContainer.lua

module("modules.logic.versionactivity1_3.enter.view.VersionActivity1_3EnterViewContainer", package.seeall)

local VersionActivity1_3EnterViewContainer = class("VersionActivity1_3EnterViewContainer", BaseViewContainer)

function VersionActivity1_3EnterViewContainer:buildViews()
	return {
		VersionActivity1_3EnterView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function VersionActivity1_3EnterViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function VersionActivity1_3EnterViewContainer:onContainerInit()
	ActivityStageHelper.recordActivityStage(self.viewParam.activityIdList)
end

function VersionActivity1_3EnterViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) and not ViewMgr.instance:hasOpenFullView() then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

return VersionActivity1_3EnterViewContainer
