-- chunkname: @modules/logic/battlepass/view/BpSPViewContainer.lua

module("modules.logic.battlepass.view.BpSPViewContainer", package.seeall)

local BpSPViewContainer = class("BpSPViewContainer", BaseViewContainer)
local TabView_Navigation = 1
local TabView_BonusOrTask = 2

function BpSPViewContainer:buildViews()
	return {
		BpBuyBtn.New(),
		TabViewGroup.New(TabView_Navigation, "#go_btns"),
		BPTabViewGroup.New(TabView_BonusOrTask, "#go_container"),
		BpSPView.New()
	}
end

function BpSPViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == TabView_Navigation then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == TabView_BonusOrTask then
		return {
			BpSPBonusView.New()
		}
	end
end

function BpSPViewContainer:playOpenTransition()
	BpSPViewContainer.super.playOpenTransition(self, {
		duration = 1,
		anim = (self.viewParam and self.viewParam.isSwitch or nil) and "switch"
	})
end

function BpSPViewContainer:playCloseTransition()
	self:onPlayCloseTransitionFinish()
end

return BpSPViewContainer
