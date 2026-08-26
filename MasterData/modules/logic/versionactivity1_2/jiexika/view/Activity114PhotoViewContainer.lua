-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114PhotoViewContainer.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114PhotoViewContainer", package.seeall)

local Activity114PhotoViewContainer = class("Activity114PhotoViewContainer", BaseViewContainer)

function Activity114PhotoViewContainer:buildViews()
	return {
		Activity114PhotoView.New("#go_photos", true),
		TabViewGroup.New(1, "#go_btns")
	}
end

function Activity114PhotoViewContainer:buildTabViews(tabContainerId)
	local navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		navigateView
	}
end

return Activity114PhotoViewContainer
