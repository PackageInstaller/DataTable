-- chunkname: @modules/logic/activitywelfare/subview/DestinyStoneGiftStoneDetailViewContainer.lua

module("modules.logic.activitywelfare.subview.DestinyStoneGiftStoneDetailViewContainer", package.seeall)

local DestinyStoneGiftStoneDetailViewContainer = class("DestinyStoneGiftStoneDetailViewContainer", BaseViewContainer)

function DestinyStoneGiftStoneDetailViewContainer:buildViews()
	local views = {}

	self._stoneView = DestinyStoneGiftStoneDetailView.New()

	table.insert(views, self._stoneView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function DestinyStoneGiftStoneDetailViewContainer:buildTabViews(tabContainerId)
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

return DestinyStoneGiftStoneDetailViewContainer
