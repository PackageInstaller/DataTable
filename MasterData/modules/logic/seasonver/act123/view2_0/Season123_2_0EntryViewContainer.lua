-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0EntryViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0EntryViewContainer", package.seeall)

local Season123_2_0EntryViewContainer = class("Season123_2_0EntryViewContainer", BaseViewContainer)

function Season123_2_0EntryViewContainer:buildViews()
	return {
		Season123_2_0CheckCloseView.New(),
		Season123_2_0EntryView.New(),
		Season123_2_0EntryScene.New(),
		TabViewGroup.New(1, "top_left")
	}
end

function Season123_2_0EntryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season2_0MainViewHelp)

		return {
			self._navigateButtonView
		}
	end
end

function Season123_2_0EntryViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_7Enum.ActivityId.Season)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_7Enum.ActivityId.Season
	})
end

return Season123_2_0EntryViewContainer
