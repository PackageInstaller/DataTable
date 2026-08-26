-- chunkname: @modules/logic/versionactivity1_2/enter/view/VersionActivity1_2EnterViewContainer.lua

module("modules.logic.versionactivity1_2.enter.view.VersionActivity1_2EnterViewContainer", package.seeall)

local VersionActivity1_2EnterViewContainer = class("VersionActivity1_2EnterViewContainer", BaseViewContainer)

function VersionActivity1_2EnterViewContainer:buildViews()
	return {
		VersionActivity1_2EnterView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function VersionActivity1_2EnterViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function VersionActivity1_2EnterViewContainer:onContainerInit()
	ActivityStageHelper.recordActivityStage(self.viewParam.activityIdList)
end

function VersionActivity1_2EnterViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) and not ViewMgr.instance:hasOpenFullView() then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

return VersionActivity1_2EnterViewContainer
