-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/building/V1a5BuildingViewContainer.lua

module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5BuildingViewContainer", package.seeall)

local V1a5BuildingViewContainer = class("V1a5BuildingViewContainer", BaseViewContainer)

function V1a5BuildingViewContainer:buildViews()
	return {
		V1a5BuildingView.New(),
		TabViewGroup.New(1, "#go_BackBtns"),
		TabViewGroup.New(2, "#go_topright")
	}
end

function V1a5BuildingViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		navigateButtonsView:setHelpId(HelpEnum.HelpId.Dungeon1_5BuildingHelp)

		return {
			navigateButtonsView
		}
	elseif tabContainerId == 2 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.V1a5DungeonBuild
			})
		}
	end
end

function V1a5BuildingViewContainer:playOpenTransition()
	local animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	animatorPlayer:Play("v1a5_buildingview_open", self.onPlayOpenTransitionFinish, self)
end

return V1a5BuildingViewContainer
