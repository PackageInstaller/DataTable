-- chunkname: @modules/logic/seasonver/act123/view/Season123EntryViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123EntryViewContainer", package.seeall)

local Season123EntryViewContainer = class("Season123EntryViewContainer", BaseViewContainer)

function Season123EntryViewContainer:buildViews()
	return {
		Season123CheckCloseView.New(),
		Season123EntryView.New(),
		Season123EntryScene.New(),
		TabViewGroup.New(1, "top_left")
	}
end

function Season123EntryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_7MainViewHelp)

		return {
			self._navigateButtonView
		}
	end
end

function Season123EntryViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_7Enum.ActivityId.Season)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_7Enum.ActivityId.Season
	})
end

return Season123EntryViewContainer
