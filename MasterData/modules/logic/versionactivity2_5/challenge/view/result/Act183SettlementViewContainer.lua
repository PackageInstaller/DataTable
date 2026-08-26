-- chunkname: @modules/logic/versionactivity2_5/challenge/view/result/Act183SettlementViewContainer.lua

module("modules.logic.versionactivity2_5.challenge.view.result.Act183SettlementViewContainer", package.seeall)

local Act183SettlementViewContainer = class("Act183SettlementViewContainer", BaseViewContainer)

function Act183SettlementViewContainer:buildViews()
	local views = {}

	table.insert(views, Act183SettlementView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	return views
end

function Act183SettlementViewContainer:buildTabViews(tabContainerId)
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

return Act183SettlementViewContainer
