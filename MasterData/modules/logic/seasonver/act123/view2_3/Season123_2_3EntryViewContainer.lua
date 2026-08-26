-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3EntryViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3EntryViewContainer", package.seeall)

local Season123_2_3EntryViewContainer = class("Season123_2_3EntryViewContainer", BaseViewContainer)

function Season123_2_3EntryViewContainer:buildViews()
	return {
		Season123_2_3CheckCloseView.New(),
		Season123_2_3EntryView.New(),
		Season123_2_3EntryScene.New(),
		TabViewGroup.New(1, "top_left")
	}
end

function Season123_2_3EntryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season2_3MainViewHelp)

		return {
			self._navigateButtonView
		}
	end
end

function Season123_2_3EntryViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_7Enum.ActivityId.Season)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_7Enum.ActivityId.Season
	})
end

return Season123_2_3EntryViewContainer
