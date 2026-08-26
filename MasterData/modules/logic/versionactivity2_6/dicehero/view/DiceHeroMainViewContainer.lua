-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroMainViewContainer.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroMainViewContainer", package.seeall)

local DiceHeroMainViewContainer = class("DiceHeroMainViewContainer", BaseViewContainer)

function DiceHeroMainViewContainer:buildViews()
	return {
		DiceHeroMainView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function DiceHeroMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return DiceHeroMainViewContainer
