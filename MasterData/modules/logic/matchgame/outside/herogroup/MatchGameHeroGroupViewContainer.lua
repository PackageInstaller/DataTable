-- chunkname: @modules/logic/matchgame/outside/herogroup/MatchGameHeroGroupViewContainer.lua

module("modules.logic.matchgame.outside.herogroup.MatchGameHeroGroupViewContainer", package.seeall)

local MatchGameHeroGroupViewContainer = class("MatchGameHeroGroupViewContainer", BaseViewContainer)

function MatchGameHeroGroupViewContainer:buildViews()
	local views = {}

	table.insert(views, MatchGameHeroGroupView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topbtns"))

	return views
end

function MatchGameHeroGroupViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

return MatchGameHeroGroupViewContainer
