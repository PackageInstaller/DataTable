-- chunkname: @modules/logic/toughbattle/view/ToughBattleEnterViewContainer.lua

module("modules.logic.toughbattle.view.ToughBattleEnterViewContainer", package.seeall)

local ToughBattleEnterViewContainer = class("ToughBattleEnterViewContainer", BaseViewContainer)

function ToughBattleEnterViewContainer:buildViews()
	return {
		ToughBattleEnterView.New(),
		TabViewGroup.New(1, "root/#go_btns"),
		ToughBattleWordView.New()
	}
end

function ToughBattleEnterViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self.navigateView
	}
end

return ToughBattleEnterViewContainer
