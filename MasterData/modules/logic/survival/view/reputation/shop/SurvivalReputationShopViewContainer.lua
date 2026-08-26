-- chunkname: @modules/logic/survival/view/reputation/shop/SurvivalReputationShopViewContainer.lua

module("modules.logic.survival.view.reputation.shop.SurvivalReputationShopViewContainer", package.seeall)

local SurvivalReputationShopViewContainer = class("SurvivalReputationShopViewContainer", BaseViewContainer)

function SurvivalReputationShopViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "#go_topleft"),
		SurvivalReputationShopView.New()
	}
end

function SurvivalReputationShopViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		}, nil)

		return {
			self.navigateButtonView
		}
	end
end

function SurvivalReputationShopViewContainer:onContainerOpenFinish()
	self.navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

return SurvivalReputationShopViewContainer
