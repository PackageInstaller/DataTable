-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyFriendListViewContainer.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyFriendListViewContainer", package.seeall)

local PartyGameLobbyFriendListViewContainer = class("PartyGameLobbyFriendListViewContainer", BaseViewContainer)

function PartyGameLobbyFriendListViewContainer:buildViews()
	local views = {}

	table.insert(views, PartyGameLobbyFriendListView.New())
	PartyGameRoomModel.instance:initFriendList()

	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "root/friendList/#go_has/ScrollView"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam1.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam1.cellClass = PartyGameLobbyFriendItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirV
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 530
	scrollParam1.cellHeight = 120
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0

	table.insert(views, LuaListScrollView.New(PartyGameRoomModel.instance:getFriendModel(), scrollParam1))

	return views
end

return PartyGameLobbyFriendListViewContainer
