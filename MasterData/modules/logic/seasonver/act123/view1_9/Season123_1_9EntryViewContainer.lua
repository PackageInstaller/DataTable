-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9EntryViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9EntryViewContainer", package.seeall)

local Season123_1_9EntryViewContainer = class("Season123_1_9EntryViewContainer", BaseViewContainer)

function Season123_1_9EntryViewContainer:buildViews()
	return {
		Season123_1_9CheckCloseView.New(),
		Season123_1_9EntryView.New(),
		Season123_1_9EntryScene.New(),
		TabViewGroup.New(1, "top_left")
	}
end

function Season123_1_9EntryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_9MainViewHelp)

		return {
			self._navigateButtonView
		}
	end
end

function Season123_1_9EntryViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_7Enum.ActivityId.Season)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_7Enum.ActivityId.Season
	})
end

return Season123_1_9EntryViewContainer
