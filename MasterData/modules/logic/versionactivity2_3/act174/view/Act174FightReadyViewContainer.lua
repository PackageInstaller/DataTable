-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174FightReadyViewContainer.lua

module("modules.logic.versionactivity2_3.act174.view.Act174FightReadyViewContainer", package.seeall)

local Act174FightReadyViewContainer = class("Act174FightReadyViewContainer", BaseViewContainer)

function Act174FightReadyViewContainer:buildViews()
	local views = {}

	table.insert(views, Act174FightReadyView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act174FightReadyViewContainer:buildTabViews(tabContainerId)
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

return Act174FightReadyViewContainer
