-- chunkname: @modules/logic/room/view/transport/RoomTransportPathViewContainer.lua

module("modules.logic.room.view.transport.RoomTransportPathViewContainer", package.seeall)

local RoomTransportPathViewContainer = class("RoomTransportPathViewContainer", BaseViewContainer)

function RoomTransportPathViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomTransportPathView.New())
	table.insert(views, TabViewGroup.New(2, "#go_righttop/#go_tabfailtips"))
	table.insert(views, RoomTransportPathViewUI.New())
	table.insert(views, RoomTransportPathViewUI.New())

	if RoomTransportPathQuickLinkViewUI._IsShow_ == true and GameResMgr.IsFromEditorDir then
		table.insert(views, RoomTransportPathQuickLinkViewUI.New())
	end

	return views
end

function RoomTransportPathViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigationView
		}
	elseif tabContainerId == 2 then
		return {
			RoomTransportPathFailTips.New()
		}
	end
end

return RoomTransportPathViewContainer
