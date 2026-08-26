-- chunkname: @modules/logic/room/view/transport/RoomTransportPathQuickLinkViewUI.lua

module("modules.logic.room.view.transport.RoomTransportPathQuickLinkViewUI", package.seeall)

local RoomTransportPathQuickLinkViewUI = class("RoomTransportPathQuickLinkViewUI", BaseView)

function RoomTransportPathQuickLinkViewUI:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTransportPathQuickLinkViewUI:addEvents()
	return
end

function RoomTransportPathQuickLinkViewUI:removeEvents()
	return
end

function RoomTransportPathQuickLinkViewUI:_editableInitView()
	self._gomapui = gohelper.findChild(self.viewGO, "go_mapui")
	self._gomapuiitem = gohelper.findChild(self.viewGO, "go_mapui/go_quickuiitem")
	self._gomapuiTrs = self._gomapui.transform
	self._uiitemTBList = {
		self:_createTB(self._gomapuiitem)
	}

	gohelper.setActive(self._gomapuiitem, false)

	self._isLinkFinsh = true
end

function RoomTransportPathQuickLinkViewUI:onUpdateParam()
	return
end

function RoomTransportPathQuickLinkViewUI:onOpen()
	self._quickLinkMO = RoomTransportQuickLinkMO.New()

	self.addEventCb(self, RoomMapController.instance, RoomEvent.CameraTransformUpdate, self._cameraTransformUpdate, self)

	if self.viewContainer then
		self.addEventCb(self, self.viewContainer, RoomEvent.TransportPathSelectLineItem, self._onSelectLineItem, self)
	end

	self._quickLinkMO:init()
	self:startWaitRunDelayTask()
end

function RoomTransportPathQuickLinkViewUI:onClose()
	self.__hasWaitRunDelayTask_ = false

	TaskDispatcher.cancelTask(self.__onWaitRunDelayTask_, self)
end

function RoomTransportPathQuickLinkViewUI:onDestroyView()
	return
end

function RoomTransportPathQuickLinkViewUI:_cameraTransformUpdate()
	self:_refreshItemUIPos()
end

function RoomTransportPathQuickLinkViewUI:_onSelectLineItem(lineDataMO)
	if lineDataMO == nil then
		return
	end

	local selectPathO = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(lineDataMO.fromType, lineDataMO.toType)

	if selectPathO and selectPathO:isLinkFinish() then
		self._isLinkFinsh = true
	else
		self._isLinkFinsh = false

		self._quickLinkMO:findPath(lineDataMO.fromType, lineDataMO.toType, true)
	end

	self:startWaitRunDelayTask()
end

function RoomTransportPathQuickLinkViewUI:startWaitRunDelayTask()
	if not self.__hasWaitRunDelayTask_ then
		self.__hasWaitRunDelayTask_ = true

		TaskDispatcher.runDelay(self.__onWaitRunDelayTask_, self, 0.001)
	end
end

function RoomTransportPathQuickLinkViewUI:__onWaitRunDelayTask_()
	self.__hasWaitRunDelayTask_ = false

	self:_refreshItemList()
	self:_refreshItemUIPos()
end

function RoomTransportPathQuickLinkViewUI:_createTB(go)
	local tb = self:getUserDataTb_()

	tb.go = go
	tb.goTrs = go.transform
	tb._txtquick = gohelper.findChildText(go, "txt_quick")

	return tb
end

function RoomTransportPathQuickLinkViewUI:_refreshTB(tb, node, hexPoint)
	if tb.searchIndex ~= node.searchIndex then
		tb.searchIndex = node.searchIndex
		tb._txtquick.text = node.searchIndex
	end

	if tb.hexPoint == nil or tb.hexPoint ~= hexPoint then
		tb.hexPoint = hexPoint

		local px, pz = HexMath.hexXYToPosXY(hexPoint.x, hexPoint.y, RoomBlockEnum.BlockSize)

		tb.worldPos = Vector3(px, 0, pz)
	end
end

function RoomTransportPathQuickLinkViewUI:_refreshItemList()
	local nodeList = self._quickLinkMO:getNodeList()
	local count = 0

	if not self._isLinkFinsh and nodeList and #nodeList > 0 then
		for _, node in ipairs(nodeList) do
			count = count + 1

			local itemTb = self._uiitemTBList[count]

			if not itemTb then
				itemTb = self:_createTB(gohelper.cloneInPlace(self._gomapuiitem))
				self._uiitemTBList[count] = itemTb
			end

			self:_refreshTB(itemTb, node, node.hexPoint)
		end
	end

	for i = 1, #self._uiitemTBList do
		local itemTb = self._uiitemTBList[i]
		local isActive = i <= count

		if itemTb.isActive ~= isActive then
			itemTb.isActive = isActive

			gohelper.setActive(itemTb.go, isActive)
		end
	end
end

function RoomTransportPathQuickLinkViewUI:_refreshItemUIPos()
	for i = 1, #self._uiitemTBList do
		local itemTb = self._uiitemTBList[i]

		if itemTb.isActive then
			self:_setUIPos(itemTb.worldPos, itemTb.goTrs, self._gomapuiTrs, 0.12)
		end
	end
end

function RoomTransportPathQuickLinkViewUI:_setUIPos(worldPos, targetUIGOTrs, parentUIGOTrs, offsetY)
	local bendingPos = RoomBendingHelper.worldToBendingSimple(worldPos)
	local bendingPosX = bendingPos.x
	local bendingPosZ = bendingPos.z

	offsetY = offsetY or 0.12

	local worldPos = Vector3(bendingPosX, bendingPos.y + offsetY, bendingPosZ)
	local localPos = recthelper.worldPosToAnchorPos(worldPos, parentUIGOTrs)

	recthelper.setAnchor(targetUIGOTrs, localPos.x, localPos.y)
end

return RoomTransportPathQuickLinkViewUI
