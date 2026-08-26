-- chunkname: @modules/logic/rouge2/map/map/itemcomp/Rouge2_MapLeaveItem.lua

module("modules.logic.rouge2.map.map.itemcomp.Rouge2_MapLeaveItem", package.seeall)

local Rouge2_MapLeaveItem = class("Rouge2_MapLeaveItem", Rouge2_MapBaseItem)

function Rouge2_MapLeaveItem:init(map)
	Rouge2_MapLeaveItem.super.init(self)

	self.map = map
	self.iconCanvas = self.map.pieceIconCanvas

	self:setId(Rouge2_MapEnum.LeaveId)
	self:createGo()
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onReceivePieceChoiceEvent, self.refreshActive, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onMiddleActorBeforeMove, self.onMiddleActorBeforeMove, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onExitPieceChoiceEvent, self.onExitPieceChoiceEvent, self)
end

function Rouge2_MapLeaveItem:createGo()
	self.go = gohelper.create3d(self.map.goLayerPiecesContainer, "leave")
	self.transform = self.go.transform

	local posX, posY = Rouge2_MapModel.instance:getMiddleLayerLeavePos()

	transformhelper.setLocalPos(self.transform, posX, posY, Rouge2_MapHelper.getOffsetZ(posY))

	self.scenePos = self.transform.position
	self.iconItem = self.iconCanvas:getOrCreateLeaveIconItem()

	self.iconItem:show(self)
	self:refreshActive()
end

function Rouge2_MapLeaveItem:refreshActive()
	local active = self:isActive()

	self.iconItem:setVisible(active)
	gohelper.setActive(self.go, active)
end

function Rouge2_MapLeaveItem:getScenePos()
	return self.scenePos
end

function Rouge2_MapLeaveItem:getClickArea()
	return Rouge2_MapEnum.LeaveItemClickArea
end

function Rouge2_MapLeaveItem:onClick()
	logNormal("on click leave item")
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	Rouge2_MapController.instance:moveToLeaveItem(self.onMoveDone, self)
end

function Rouge2_MapLeaveItem:onMoveDone()
	self:_sendMoveRpc()
end

function Rouge2_MapLeaveItem:_sendMoveRpc()
	local layer = Rouge2_MapModel.instance:getLayerId()
	local middleLayer = Rouge2_MapModel.instance:getMiddleLayerId()

	Rouge2_Rpc.instance:sendRouge2PieceMoveRequest(layer, middleLayer, Rouge2_MapEnum.PathSelectIndex)
end

function Rouge2_MapLeaveItem:isActive()
	if self.onPieceView then
		return false
	end

	local middleLayerCo = Rouge2_MapModel.instance:getMiddleLayerCo()

	return Rouge2_MapUnlockHelper.checkIsUnlock(middleLayerCo.leavePosUnlock)
end

function Rouge2_MapLeaveItem:onMiddleActorBeforeMove(data)
	local pieceId = data.pieceId

	if pieceId == Rouge2_MapEnum.LeaveId then
		return
	end

	self.onPieceView = true

	self:refreshActive()
end

function Rouge2_MapLeaveItem:onExitPieceChoiceEvent()
	self.onPieceView = false

	self:refreshActive()
end

return Rouge2_MapLeaveItem
