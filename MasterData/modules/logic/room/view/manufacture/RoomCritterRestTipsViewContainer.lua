-- chunkname: @modules/logic/room/view/manufacture/RoomCritterRestTipsViewContainer.lua

module("modules.logic.room.view.manufacture.RoomCritterRestTipsViewContainer", package.seeall)

local RoomCritterRestTipsViewContainer = class("RoomCritterRestTipsViewContainer", BaseViewContainer)

function RoomCritterRestTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCritterRestTipsView.New())
	table.insert(views, TabViewGroup.New(1, "#go_righttop"))

	return views
end

function RoomCritterRestTipsViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local currencyParam = {
			CurrencyEnum.CurrencyType.RoomTrade
		}

		return {
			CurrencyView.New(currencyParam)
		}
	end
end

function RoomCritterRestTipsViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(ViewName.RoomCritterRestTipsView, nil, true)
end

return RoomCritterRestTipsViewContainer
