-- chunkname: @modules/logic/rouge2/map/map/itemcomp/Rouge2_MapPieceItem.lua

module("modules.logic.rouge2.map.map.itemcomp.Rouge2_MapPieceItem", package.seeall)

local Rouge2_MapPieceItem = class("Rouge2_MapPieceItem", Rouge2_MapBaseItem)

function Rouge2_MapPieceItem:init(pieceMo, map)
	Rouge2_MapPieceItem.super.init(self)

	self.pieceMo = pieceMo
	self.pieceCo = self.pieceMo:getPieceCo()
	self.map = map
	self.iconCanvas = self.map.pieceIconCanvas

	self:setId(self.pieceMo.id)
	self:createPiece()
	self:createIcon()
	self:createEffect()
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateMapInfo, self.onUpdateMapInfo, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onMiddleActorBeforeMove, self.onMiddleActorBeforeMove, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onExitPieceChoiceEvent, self.onExitPieceChoiceEvent, self)
end

function Rouge2_MapPieceItem:createPiece()
	local middleLayerCo = Rouge2_MapModel.instance:getMiddleLayerCo()
	local dayOrNight = middleLayerCo.dayOrNight
	local res = self.pieceCo.pieceRes

	if string.nilorempty(res) then
		self.isEmpty = true
		self.pieceGo = gohelper.create3d(self.map.goLayerPiecesContainer, self.pieceCo.id)
	else
		self.isEmpty = false
		res = Rouge2_MapHelper.getPieceResPath(res, dayOrNight)
		self.pieceGo = gohelper.clone(self.map.piecePrefabDict[res], self.map.goLayerPiecesContainer, self.pieceCo.id)
	end

	self.pieceTr = self.pieceGo.transform

	transformhelper.setLocalPos(self.pieceTr, self:getMapPos())
	self:refreshDirection()
end

function Rouge2_MapPieceItem:createIcon()
	self.iconItem = self.iconCanvas:getOrCreatePieceIconItem(self.pieceCo.id)

	local type = self.pieceCo.entrustType

	if type == Rouge2_MapEnum.PieceEntrustType.None then
		return
	end

	if not self:canShowIcon() then
		self.iconItem:setVisible(false)

		return
	end

	self.iconItem:show(self.pieceCo, self)
end

function Rouge2_MapPieceItem:createEffect()
	if self.pieceCo.bossEffect == 0 then
		return
	end

	self.effectGo = gohelper.clone(self.map.luoLeiLaiEffectPrefab, self.pieceGo, "effect")

	self:refreshEffect()
end

function Rouge2_MapPieceItem:refreshDirection()
	if self.isEmpty then
		return
	end

	self:initDirectionMap()

	local pathPos = Rouge2_MapModel.instance:getMiddleLayerPathPos(self.pieceMo.index + 1)
	local x, y = self:getMapPos()
	local angle = Rouge2_MapHelper.getAngle(x, y, pathPos.x, pathPos.y)
	local dir = Rouge2_MapHelper.getPieceDir(angle)

	for _dir, go in pairs(self.directionGoMap) do
		gohelper.setActive(go, _dir == dir)
	end
end

function Rouge2_MapPieceItem:initDirectionMap()
	if self.isEmpty then
		return
	end

	if self.directionGoMap then
		return
	end

	self.directionGoMap = self:getUserDataTb_()

	for _, dir in pairs(Rouge2_MapEnum.PieceDir) do
		self.directionGoMap[dir] = gohelper.findChild(self.pieceGo, dir)
	end
end

function Rouge2_MapPieceItem:getScenePos()
	return self.pieceTr.position
end

function Rouge2_MapPieceItem:getMapPos()
	local pos = Rouge2_MapModel.instance:getMiddleLayerPosByIndex(self.pieceMo.index + 1)

	if not pos then
		return 0, 0, 0
	end

	return pos.x, pos.y, Rouge2_MapHelper.getOffsetZ(pos.y)
end

function Rouge2_MapPieceItem:getClickArea()
	return Rouge2_MapEnum.PieceClickArea
end

function Rouge2_MapPieceItem:onClick()
	logNormal("点击棋子了... " .. self.pieceCo.id)

	if self.pieceCo.entrustType == Rouge2_MapEnum.PieceEntrustType.None then
		return
	end

	if self.pieceMo.finish then
		return
	end

	if not self:canShowIcon() then
		return
	end

	Rouge2_MapController.instance:moveToPieceItem(self.pieceMo, self.onMoveDone, self)
end

function Rouge2_MapPieceItem:isActive()
	return self.pieceCo.entrustType ~= Rouge2_MapEnum.PieceEntrustType.None
end

function Rouge2_MapPieceItem:onMoveDone()
	if Rouge2_MapModel.instance:getCurPosIndex() == self.pieceMo.index then
		self:onReceiveMsg()

		return
	end

	local layer = Rouge2_MapModel.instance:getLayerId()
	local middleLayer = Rouge2_MapModel.instance:getMiddleLayerId()

	self.callbackId = Rouge2_Rpc.instance:sendRouge2PieceMoveRequest(layer, middleLayer, self.pieceMo.index, self.onReceiveMsg, self)
end

function Rouge2_MapPieceItem:onReceiveMsg()
	self.callbackId = nil

	ViewMgr.instance:openView(ViewName.Rouge2_MapPieceChoiceView, self.pieceMo)
end

function Rouge2_MapPieceItem:onUpdateMapInfo()
	self:refreshIcon()
	self:refreshEffect()
end

function Rouge2_MapPieceItem:canShowIcon()
	if self.onPieceView then
		return false
	end

	if self.pieceMo.finish then
		return false
	end

	return self.pieceCo.entrustType ~= Rouge2_MapEnum.PieceEntrustType.None
end

function Rouge2_MapPieceItem:refreshIcon()
	local canShow = self:canShowIcon()

	self.iconItem:setVisible(canShow)
end

function Rouge2_MapPieceItem:refreshEffect()
	if not self.effectGo then
		return
	end

	local isFinish = self.pieceMo.finish

	gohelper.setActive(self.effectGo, not isFinish)
end

function Rouge2_MapPieceItem:onMiddleActorBeforeMove(data)
	local pieceId = data.pieceId

	if pieceId == Rouge2_MapEnum.LeaveId then
		return
	end

	self.onPieceView = true

	self:refreshIcon()
end

function Rouge2_MapPieceItem:onExitPieceChoiceEvent()
	self.onPieceView = false

	self:refreshIcon()
end

function Rouge2_MapPieceItem:destroy()
	if self.callbackId then
		Rouge2_Rpc.instance:removeCallbackById(self.callbackId)
	end

	Rouge2_MapPieceItem.super.destroy(self)
end

return Rouge2_MapPieceItem
