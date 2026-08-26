-- chunkname: @modules/logic/meilanni/view/MeilanniViewContainer.lua

module("modules.logic.meilanni.view.MeilanniViewContainer", package.seeall)

local MeilanniViewContainer = class("MeilanniViewContainer", BaseViewContainer)

function MeilanniViewContainer:buildViews()
	local views = {}

	table.insert(views, MeilanniView.New())
	table.insert(views, MeilanniMap.New())
	table.insert(views, MeilanniEventView.New())
	table.insert(views, MeilanniDialogBtnView.New())
	table.insert(views, MeilanniDialogView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function MeilanniViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, HelpEnum.HelpId.VersionActivityMeiLanNi)

	return {
		self._navigateButtonView
	}
end

return MeilanniViewContainer
