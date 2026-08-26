-- chunkname: @modules/logic/autochess/main/view/AutoChessCourseViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessCourseViewContainer", package.seeall)

local AutoChessCourseViewContainer = class("AutoChessCourseViewContainer", BaseViewContainer)

function AutoChessCourseViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessCourseView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AutoChessCourseViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return AutoChessCourseViewContainer
