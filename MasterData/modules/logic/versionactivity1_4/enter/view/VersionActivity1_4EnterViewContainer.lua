-- chunkname: @modules/logic/versionactivity1_4/enter/view/VersionActivity1_4EnterViewContainer.lua

module("modules.logic.versionactivity1_4.enter.view.VersionActivity1_4EnterViewContainer", package.seeall)

local VersionActivity1_4EnterViewContainer = class("VersionActivity1_4EnterViewContainer", BaseViewContainer)

function VersionActivity1_4EnterViewContainer:buildViews()
	return {
		VersionActivity1_4EnterView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function VersionActivity1_4EnterViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function VersionActivity1_4EnterViewContainer:onContainerInit()
	ActivityStageHelper.recordActivityStage(self.viewParam.activityIdList)
end

function VersionActivity1_4EnterViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) and not ViewMgr.instance:hasOpenFullView() then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

return VersionActivity1_4EnterViewContainer
