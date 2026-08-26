-- chunkname: @modules/logic/fight/view/FightTechniqueViewContainer.lua

module("modules.logic.fight.view.FightTechniqueViewContainer", package.seeall)

local FightTechniqueViewContainer = class("FightTechniqueViewContainer", BaseViewContainer)

function FightTechniqueViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "#go_lefttop"),
		FightTechniqueView.New()
	}
end

function FightTechniqueViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

return FightTechniqueViewContainer
