-- chunkname: @modules/logic/summon/view/SummonHeroDetailViewContainer.lua

module("modules.logic.summon.view.SummonHeroDetailViewContainer", package.seeall)

local SummonHeroDetailViewContainer = class("SummonHeroDetailViewContainer", BaseViewContainer)

function SummonHeroDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, SummonHeroDetailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function SummonHeroDetailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				(self.viewParam and self.viewParam.showHome ~= nil or nil) and self.viewParam.showHome,
				false
			})
		}
	end
end

return SummonHeroDetailViewContainer
