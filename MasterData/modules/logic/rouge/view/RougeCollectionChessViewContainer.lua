-- chunkname: @modules/logic/rouge/view/RougeCollectionChessViewContainer.lua

module("modules.logic.rouge.view.RougeCollectionChessViewContainer", package.seeall)

local RougeCollectionChessViewContainer = class("RougeCollectionChessViewContainer", BaseViewContainer)

function RougeCollectionChessViewContainer:buildViews()
	self._poolComp = RougeCollectionChessPoolComp.New()

	return {
		TabViewGroup.New(1, "#go_left/#go_btns"),
		TabViewGroup.New(2, "#go_rougemapdetailcontainer"),
		self._poolComp,
		RougeCollectionEffectActiveComp.New(),
		RougeCollectionEffectTriggerComp.New(),
		RougeCollectionChessView.New(),
		RougeCollectionChessSlotComp.New(),
		RougeCollectionChessBagComp.New(),
		RougeCollectionChessInteractComp.New(),
		RougeCollectionChessPlaceComp.New()
	}
end

function RougeCollectionChessViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			true
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.RougeCollectionChessViewHelp)

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

function RougeCollectionChessViewContainer:getRougePoolComp()
	return self._poolComp
end

return RougeCollectionChessViewContainer
