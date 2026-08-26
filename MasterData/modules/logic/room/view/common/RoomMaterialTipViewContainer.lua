-- chunkname: @modules/logic/room/view/common/RoomMaterialTipViewContainer.lua

module("modules.logic.room.view.common.RoomMaterialTipViewContainer", package.seeall)

local RoomMaterialTipViewContainer = class("RoomMaterialTipViewContainer", BaseViewContainer)

function RoomMaterialTipViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomMaterialTipView.New())
	table.insert(views, RoomMaterialTipViewBanner.New())

	return views
end

function RoomMaterialTipViewContainer:onContainerClickModalMask()
	self:closeThis()
end

function RoomMaterialTipViewContainer:onContainerOpen()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_open)
end

return RoomMaterialTipViewContainer
