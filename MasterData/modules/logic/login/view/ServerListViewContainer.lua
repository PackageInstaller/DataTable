-- chunkname: @modules/logic/login/view/ServerListViewContainer.lua

module("modules.logic.login.view.ServerListViewContainer", package.seeall)

local ServerListViewContainer = class("ServerListViewContainer", BaseViewContainer)

function ServerListViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "serverlist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = ServerListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 2
	scrollParam.cellWidth = 400
	scrollParam.cellHeight = 60
	scrollParam.cellSpaceH = 50
	scrollParam.cellSpaceV = 40

	table.insert(views, LuaListScrollView.New(ServerListModel.instance, scrollParam))
	table.insert(views, ServerListView.New())

	return views
end

function ServerListViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return ServerListViewContainer
