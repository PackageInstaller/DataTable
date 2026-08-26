-- chunkname: @modules/logic/versionactivity2_8/molideer/view/MoLiDeErLevelViewContainer.lua

module("modules.logic.versionactivity2_8.molideer.view.MoLiDeErLevelViewContainer", package.seeall)

local MoLiDeErLevelViewContainer = class("MoLiDeErLevelViewContainer", BaseViewContainer)

function MoLiDeErLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, MoLiDeErLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function MoLiDeErLevelViewContainer:buildTabViews(tabContainerId)
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

return MoLiDeErLevelViewContainer
