-- chunkname: @modules/logic/herogroup/view/CommonTrialHeroDetailViewContainer.lua

module("modules.logic.herogroup.view.CommonTrialHeroDetailViewContainer", package.seeall)

local CommonTrialHeroDetailViewContainer = class("CommonTrialHeroDetailViewContainer", BaseViewContainer)

function CommonTrialHeroDetailViewContainer:buildViews()
	return {
		CommonTrialHeroDetailView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function CommonTrialHeroDetailViewContainer:buildTabViews(tabContainerId)
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

return CommonTrialHeroDetailViewContainer
