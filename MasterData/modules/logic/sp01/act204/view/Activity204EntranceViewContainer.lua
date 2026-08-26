-- chunkname: @modules/logic/sp01/act204/view/Activity204EntranceViewContainer.lua

module("modules.logic.sp01.act204.view.Activity204EntranceViewContainer", package.seeall)

local Activity204EntranceViewContainer = class("Activity204EntranceViewContainer", BaseViewContainer)

function Activity204EntranceViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity204EntranceView.New())
	table.insert(views, Activity204EntranceHeroView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function Activity204EntranceViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

function Activity204EntranceViewContainer:playCloseTransition()
	self:onPlayCloseTransitionFinish()
end

return Activity204EntranceViewContainer
