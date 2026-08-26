-- chunkname: @modules/logic/rouge2/map/map/itemcomp/Rouge2_MapLeaveIconItem.lua

module("modules.logic.rouge2.map.map.itemcomp.Rouge2_MapLeaveIconItem", package.seeall)

local Rouge2_MapLeaveIconItem = class("Rouge2_MapLeaveIconItem", LuaCompBase)

function Rouge2_MapLeaveIconItem:ctor(tranHeadContainer)
	self._tranHeadContainer = tranHeadContainer
end

function Rouge2_MapLeaveIconItem:init(go)
	self.go = go
	self.tran = self.go.transform
	self._mainCamera = CameraMgr.instance:getMainCamera()

	self:setVisible(false)
end

function Rouge2_MapLeaveIconItem:show(leaveItem)
	self:setVisible(true)

	local scenePos = leaveItem:getScenePos()
	local posX, posY = recthelper.worldPosToAnchorPos2(scenePos, self._tranHeadContainer, self._mainCamera, self._mainCamera)

	recthelper.setAnchor(self.tran, posX, posY)
end

function Rouge2_MapLeaveIconItem:setVisible(isVisible)
	gohelper.setActive(self.go, isVisible)
end

return Rouge2_MapLeaveIconItem
