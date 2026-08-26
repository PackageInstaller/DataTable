-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/building/V1a5BuildingDetailViewContainer.lua

module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5BuildingDetailViewContainer", package.seeall)

local V1a5BuildingDetailViewContainer = class("V1a5BuildingDetailViewContainer", BaseViewContainer)

function V1a5BuildingDetailViewContainer:buildViews()
	return {
		V1a5BuildingDetailView.New(),
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_topright")
	}
end

function V1a5BuildingDetailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	elseif tabContainerId == 2 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.V1a5DungeonBuild
			})
		}
	end
end

return V1a5BuildingDetailViewContainer
