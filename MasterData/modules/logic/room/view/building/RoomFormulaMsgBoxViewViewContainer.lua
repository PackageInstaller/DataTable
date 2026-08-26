-- chunkname: @modules/logic/room/view/building/RoomFormulaMsgBoxViewViewContainer.lua

module("modules.logic.room.view.building.RoomFormulaMsgBoxViewViewContainer", package.seeall)

local RoomFormulaMsgBoxViewViewContainer = class("RoomFormulaMsgBoxViewViewContainer", BaseViewContainer)

RoomFormulaMsgBoxViewViewContainer.lineCount = 4

function RoomFormulaMsgBoxViewViewContainer:buildViews()
	local views = {}
	local listScrollParam = ListScrollParam.New()

	listScrollParam.scrollGOPath = "Exchange/Left/ScrollView"
	listScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	listScrollParam.prefabUrl = "Exchange/Left/ScrollView/Viewport/Content/#go_PropItem"
	listScrollParam.cellClass = RoomFormulaMsgBoxItem
	listScrollParam.scrollDir = ScrollEnum.ScrollDirV
	listScrollParam.cellWidth = 120
	listScrollParam.cellHeight = 106
	listScrollParam.cellSpaceH = 70
	listScrollParam.lineCount = self.lineCount

	table.insert(views, RoomFormulaMsgBoxView.New())
	table.insert(views, LuaListScrollView.New(RoomFormulaMsgBoxModel.instance, listScrollParam))
	table.insert(views, TabViewGroup.New(1, "#go_topright"))

	return views
end

function RoomFormulaMsgBoxViewViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local currencyParam = {
			CurrencyEnum.CurrencyType.Gold
		}

		return {
			CurrencyView.New(currencyParam, nil, nil, nil, true)
		}
	end
end

return RoomFormulaMsgBoxViewViewContainer
