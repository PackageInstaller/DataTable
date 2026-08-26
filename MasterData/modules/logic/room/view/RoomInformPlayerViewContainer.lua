-- chunkname: @modules/logic/room/view/RoomInformPlayerViewContainer.lua

module("modules.logic.room.view.RoomInformPlayerViewContainer", package.seeall)

local RoomInformPlayerViewContainer = class("RoomInformPlayerViewContainer", BaseViewContainer)

function RoomInformPlayerViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "object/scroll_inform"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "object/scroll_inform/Viewport/#go_informContent/#go_informItem"
	scrollParam.cellClass = RoomInformReportTypeItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 4
	scrollParam.cellWidth = 280
	scrollParam.cellHeight = 40
	scrollParam.cellSpaceH = 37
	scrollParam.cellSpaceV = 33
	scrollParam.startSpace = 0

	return {
		CommonViewFrame.New(),
		RoomInformPlayerView.New(),
		LuaListScrollView.New(RoomReportTypeListModel.instance, scrollParam)
	}
end

function RoomInformPlayerViewContainer:buildTabViews(tabContainerId)
	return
end

function RoomInformPlayerViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return RoomInformPlayerViewContainer
