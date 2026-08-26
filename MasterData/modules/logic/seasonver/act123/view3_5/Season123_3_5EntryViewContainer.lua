-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EntryViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EntryViewContainer", package.seeall)

local Season123_3_5EntryViewContainer = class("Season123_3_5EntryViewContainer", BaseViewContainer)

function Season123_3_5EntryViewContainer:buildViews()
	return {
		Season123_3_5CheckCloseView.New(),
		Season123_3_5EntryView.New(),
		Season123_3_5EntryScene.New(),
		TabViewGroup.New(1, "top_left"),
		TabViewGroup.New(2, "rightbtns/#go_carddetail")
	}
end

function Season123_3_5EntryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season3_5MainViewHelp)

		return {
			self._navigateButtonView
		}
	end

	if tabContainerId == 2 then
		return {
			Season123_3_5CardDetailView.New()
		}
	end
end

function Season123_3_5EntryViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_7Enum.ActivityId.Season)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_7Enum.ActivityId.Season
	})
end

return Season123_3_5EntryViewContainer
