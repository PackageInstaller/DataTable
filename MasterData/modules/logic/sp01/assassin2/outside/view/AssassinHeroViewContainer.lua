-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinHeroViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinHeroViewContainer", package.seeall)

local AssassinHeroViewContainer = class("AssassinHeroViewContainer", BaseViewContainer)

function AssassinHeroViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinHeroView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	return views
end

function AssassinHeroViewContainer:buildTabViews(tabContainerId)
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

return AssassinHeroViewContainer
