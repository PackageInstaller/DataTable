-- chunkname: @modules/logic/balanceumbrella/view/BalanceUmbrellaClueViewContainer.lua

module("modules.logic.balanceumbrella.view.BalanceUmbrellaClueViewContainer", package.seeall)

local BalanceUmbrellaClueViewContainer = class("BalanceUmbrellaClueViewContainer", BaseViewContainer)

function BalanceUmbrellaClueViewContainer:buildViews()
	return {
		BalanceUmbrellaClueView.New()
	}
end

return BalanceUmbrellaClueViewContainer
