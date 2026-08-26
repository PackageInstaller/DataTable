-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174ForcePickViewContainer.lua

module("modules.logic.versionactivity2_3.act174.view.Act174ForcePickViewContainer", package.seeall)

local Act174ForcePickViewContainer = class("Act174ForcePickViewContainer", BaseViewContainer)

function Act174ForcePickViewContainer:buildViews()
	local views = {}

	table.insert(views, Act174ForcePickView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act174ForcePickViewContainer:buildTabViews(tabContainerId)
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

return Act174ForcePickViewContainer
