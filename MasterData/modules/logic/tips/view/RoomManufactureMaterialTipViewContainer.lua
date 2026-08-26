-- chunkname: @modules/logic/tips/view/RoomManufactureMaterialTipViewContainer.lua

module("modules.logic.tips.view.RoomManufactureMaterialTipViewContainer", package.seeall)

local RoomManufactureMaterialTipViewContainer = class("RoomManufactureMaterialTipViewContainer", BaseViewContainer)

function RoomManufactureMaterialTipViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomManufactureMaterialTipView.New())

	return views
end

function RoomManufactureMaterialTipViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return RoomManufactureMaterialTipViewContainer
