-- chunkname: @modules/logic/autochess/main/view/AutoChessFriendListViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessFriendListViewContainer", package.seeall)

local AutoChessFriendListViewContainer = class("AutoChessFriendListViewContainer", BaseViewContainer)

function AutoChessFriendListViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessFriendListView.New())

	return views
end

return AutoChessFriendListViewContainer
