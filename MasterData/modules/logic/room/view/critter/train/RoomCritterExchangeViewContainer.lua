-- chunkname: @modules/logic/room/view/critter/train/RoomCritterExchangeViewContainer.lua

module("modules.logic.room.view.critter.train.RoomCritterExchangeViewContainer", package.seeall)

local RoomCritterExchangeViewContainer = class("RoomCritterExchangeViewContainer", BaseViewContainer)

function RoomCritterExchangeViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCritterExchangeView.New())
	table.insert(views, TabViewGroup.New(1, "#go_righttop"))

	return views
end

function RoomCritterExchangeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._currencyView = CurrencyView.New({})
		self._currencyView.foreHideBtn = true

		return {
			self._currencyView
		}
	end
end

function RoomCritterExchangeViewContainer:setCurrencyType(currencyTypeParam)
	if self._currencyView then
		self._currencyView:setCurrencyType(currencyTypeParam)
	end
end

return RoomCritterExchangeViewContainer
