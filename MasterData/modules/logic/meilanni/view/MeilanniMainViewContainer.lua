-- chunkname: @modules/logic/meilanni/view/MeilanniMainViewContainer.lua

module("modules.logic.meilanni.view.MeilanniMainViewContainer", package.seeall)

local MeilanniMainViewContainer = class("MeilanniMainViewContainer", BaseViewContainer)

function MeilanniMainViewContainer:buildViews()
	local views = {}

	table.insert(views, MeilanniMainView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function MeilanniMainViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, HelpEnum.HelpId.VersionActivityMeiLanNi, self._closeCallback)

	return {
		self._navigateButtonView
	}
end

function MeilanniMainViewContainer:_closeCallback()
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_carddisappear)
end

function MeilanniMainViewContainer:onContainerClose()
	return
end

function MeilanniMainViewContainer:onContainerOpen()
	ActivityEnterMgr.instance:enterActivity(VersionActivityEnum.ActivityId.Act108)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivityEnum.ActivityId.Act108
	})
end

return MeilanniMainViewContainer
