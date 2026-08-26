-- chunkname: @modules/logic/towercompose/view/TowerComposePickAssistItem.lua

module("modules.logic.towercompose.view.TowerComposePickAssistItem", package.seeall)

local TowerComposePickAssistItem = class("TowerComposePickAssistItem", PickAssistItem)

function TowerComposePickAssistItem:_editableInitView()
	TowerComposePickAssistItem.super._editableInitView(self)
	self._playericon:setHideRoomBtn(true)
	self._playericon:setEnableClick(true)
end

return TowerComposePickAssistItem
