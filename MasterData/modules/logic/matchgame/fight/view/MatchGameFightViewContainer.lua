-- chunkname: @modules/logic/matchgame/fight/view/MatchGameFightViewContainer.lua

module("modules.logic.matchgame.fight.view.MatchGameFightViewContainer", package.seeall)

local MatchGameFightViewContainer = class("MatchGameFightViewContainer", BaseViewContainer)

function MatchGameFightViewContainer:buildViews()
	self.matchGameFightView = MatchGameFightView.New()
	self.matchGameFightSceneView = MatchGameFightSceneView.New()
	self.matchGameFightSkillView = MatchGameFightSkillView.New()

	return {
		self.matchGameFightView,
		self.matchGameFightSceneView,
		self.matchGameFightSkillView,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function MatchGameFightViewContainer:buildTabViews(tabContainerId)
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

function MatchGameFightViewContainer:setOverrideCloseClick(overrideCloseFunc, overrideCloseObj)
	self.navigateView:setOverrideClose(overrideCloseFunc, overrideCloseObj)
end

function MatchGameFightViewContainer:getFightView()
	return self.matchGameFightView
end

function MatchGameFightViewContainer:getSceneView()
	return self.matchGameFightSceneView
end

function MatchGameFightViewContainer:getSkillView()
	return self.matchGameFightSkillView
end

return MatchGameFightViewContainer
