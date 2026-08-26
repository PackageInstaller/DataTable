-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyInRoomViewContainer.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyInRoomViewContainer", package.seeall)

local PartyGameLobbyInRoomViewContainer = class("PartyGameLobbyInRoomViewContainer", BaseViewContainer)

function PartyGameLobbyInRoomViewContainer:buildViews()
	local views = {}

	table.insert(views, PartyGameLobbyInRoomView.New())

	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "root/roomList/#go_Expand/ScrollView"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam1.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam1.cellClass = PartyGameLobbyInRoomPlayerItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirV
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 530
	scrollParam1.cellHeight = 116
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0

	table.insert(views, LuaListScrollView.New(PartyGameRoomModel.instance:getPlayerInfosModel(), scrollParam1))

	return views
end

return PartyGameLobbyInRoomViewContainer
