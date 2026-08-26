-- chunkname: @modules/logic/balanceumbrella/view/BalanceUmbrellaViewContainer.lua

module("modules.logic.balanceumbrella.view.BalanceUmbrellaViewContainer", package.seeall)

local BalanceUmbrellaViewContainer = class("BalanceUmbrellaViewContainer", BaseViewContainer)

function BalanceUmbrellaViewContainer:buildViews()
	return {
		BalanceUmbrellaView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function BalanceUmbrellaViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		self.navigateView
	}
end

return BalanceUmbrellaViewContainer
