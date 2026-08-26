-- chunkname: @modules/logic/rouge/view/RougeTalentTreeOverviewContainer.lua

module("modules.logic.rouge.view.RougeTalentTreeOverviewContainer", package.seeall)

local RougeTalentTreeOverviewContainer = class("RougeTalentTreeOverviewContainer", BaseViewContainer)

function RougeTalentTreeOverviewContainer:buildViews()
	local views = {}

	table.insert(views, RougeTalentTreeOverview.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function RougeTalentTreeOverviewContainer:buildTabViews(tabContainerId)
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

return RougeTalentTreeOverviewContainer
