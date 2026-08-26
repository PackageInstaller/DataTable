-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinBuildingLevelUpViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinBuildingLevelUpViewContainer", package.seeall)

local AssassinBuildingLevelUpViewContainer = class("AssassinBuildingLevelUpViewContainer", BaseViewContainer)

function AssassinBuildingLevelUpViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinBuildingLevelUpView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	return views
end

function AssassinBuildingLevelUpViewContainer:buildTabViews(tabContainerId)
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

function AssassinBuildingLevelUpViewContainer:playCloseTransition()
	local animator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	animator:Play(UIAnimationName.Close, self.onCloseAnimDone, self)
end

function AssassinBuildingLevelUpViewContainer:onCloseAnimDone()
	self:onPlayCloseTransitionFinish()
end

return AssassinBuildingLevelUpViewContainer
