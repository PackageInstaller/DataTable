-- chunkname: @modules/logic/rouge/view/RougeFactionIllustrationViewContainer.lua

module("modules.logic.rouge.view.RougeFactionIllustrationViewContainer", package.seeall)

local RougeFactionIllustrationViewContainer = class("RougeFactionIllustrationViewContainer", BaseViewContainer)

function RougeFactionIllustrationViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeFactionIllustrationView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function RougeFactionIllustrationViewContainer:buildTabViews(tabContainerId)
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

return RougeFactionIllustrationViewContainer
