-- chunkname: @modules/logic/turnback/view/new/view/TurnbackDoubleRewardChargeViewContainer.lua

module("modules.logic.turnback.view.new.view.TurnbackDoubleRewardChargeViewContainer", package.seeall)

local TurnbackDoubleRewardChargeViewContainer = class("TurnbackDoubleRewardChargeViewContainer", BaseViewContainer)

function TurnbackDoubleRewardChargeViewContainer:buildViews()
	local views = {}

	table.insert(views, TurnbackDoubleRewardChargeView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topright"))

	return views
end

function TurnbackDoubleRewardChargeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._currencyView = CurrencyView.New({})

		return {
			self._currencyView
		}
	end
end

return TurnbackDoubleRewardChargeViewContainer
