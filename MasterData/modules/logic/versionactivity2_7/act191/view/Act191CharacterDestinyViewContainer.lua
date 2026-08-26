-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191CharacterDestinyViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191CharacterDestinyViewContainer", package.seeall)

local Act191CharacterDestinyViewContainer = class("Act191CharacterDestinyViewContainer", BaseViewContainer)

function Act191CharacterDestinyViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191CharacterDestinyView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act191CharacterDestinyViewContainer:buildTabViews(tabContainerId)
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

return Act191CharacterDestinyViewContainer
