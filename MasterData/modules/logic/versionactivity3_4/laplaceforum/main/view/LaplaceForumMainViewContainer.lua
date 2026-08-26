-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/main/view/LaplaceForumMainViewContainer.lua

module("modules.logic.versionactivity3_4.laplaceforum.main.view.LaplaceForumMainViewContainer", package.seeall)

local LaplaceForumMainViewContainer = class("LaplaceForumMainViewContainer", BaseViewContainer)

function LaplaceForumMainViewContainer:buildViews()
	local views = {}

	table.insert(views, LaplaceForumMainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function LaplaceForumMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

return LaplaceForumMainViewContainer
