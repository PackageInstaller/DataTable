-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1EntryViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1EntryViewContainer", package.seeall)

local Season123_2_1EntryViewContainer = class("Season123_2_1EntryViewContainer", BaseViewContainer)

function Season123_2_1EntryViewContainer:buildViews()
	return {
		Season123_2_1CheckCloseView.New(),
		Season123_2_1EntryView.New(),
		Season123_2_1EntryScene.New(),
		TabViewGroup.New(1, "top_left")
	}
end

function Season123_2_1EntryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season2_1MainViewHelp)

		return {
			self._navigateButtonView
		}
	end
end

function Season123_2_1EntryViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_7Enum.ActivityId.Season)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_7Enum.ActivityId.Season
	})
end

return Season123_2_1EntryViewContainer
