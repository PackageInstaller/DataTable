-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8EntryViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8EntryViewContainer", package.seeall)

local Season123_1_8EntryViewContainer = class("Season123_1_8EntryViewContainer", BaseViewContainer)

function Season123_1_8EntryViewContainer:buildViews()
	return {
		Season123_1_8CheckCloseView.New(),
		Season123_1_8EntryView.New(),
		Season123_1_8EntryScene.New(),
		TabViewGroup.New(1, "top_left")
	}
end

function Season123_1_8EntryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_8MainViewHelp)

		return {
			self._navigateButtonView
		}
	end
end

function Season123_1_8EntryViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_7Enum.ActivityId.Season)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_7Enum.ActivityId.Season
	})
end

return Season123_1_8EntryViewContainer
