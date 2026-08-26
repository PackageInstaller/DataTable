-- chunkname: @modules/logic/room/view/common/RoomBuildingLevelUpViewContainer.lua

module("modules.logic.room.view.common.RoomBuildingLevelUpViewContainer", package.seeall)

local RoomBuildingLevelUpViewContainer = class("RoomBuildingLevelUpViewContainer", BaseViewContainer)

function RoomBuildingLevelUpViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomBuildingLevelUpView.New())
	table.insert(views, TabViewGroup.New(1, "#go_righttop"))

	return views
end

function RoomBuildingLevelUpViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local currencyParam = {
			CurrencyEnum.CurrencyType.RoomTrade
		}

		return {
			CurrencyView.New(currencyParam)
		}
	end
end

function RoomBuildingLevelUpViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(ViewName.RoomBuildingLevelUpView, nil, true)
end

return RoomBuildingLevelUpViewContainer
