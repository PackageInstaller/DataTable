-- chunkname: @modules/logic/dungeon/view/DungeonExploreViewContainer.lua

module("modules.logic.dungeon.view.DungeonExploreViewContainer", package.seeall)

local DungeonExploreViewContainer = class("DungeonExploreViewContainer", BaseViewContainer)

function DungeonExploreViewContainer:buildViews()
	return {
		DungeonExploreView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function DungeonExploreViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil)

		return {
			self.navigateButtonView
		}
	end
end

return DungeonExploreViewContainer
