-- chunkname: @modules/logic/playercard/view/PlayerCardShowViewContainer.lua

module("modules.logic.playercard.view.PlayerCardShowViewContainer", package.seeall)

local PlayerCardShowViewContainer = class("PlayerCardShowViewContainer", BaseViewContainer)

function PlayerCardShowViewContainer:buildViews()
	local views = {}

	table.insert(views, PlayerCardShowView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes.carditem
	scrollParam.cellClass = PlayerCardCardItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 3
	scrollParam.cellWidth = 482
	scrollParam.cellHeight = 186
	scrollParam.startSpace = 150
	self._scrollView = LuaListScrollView.New(PlayerCardProgressModel.instance, scrollParam)

	table.insert(views, self._scrollView)

	return views
end

return PlayerCardShowViewContainer
