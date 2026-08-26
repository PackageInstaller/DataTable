-- chunkname: @modules/logic/rouge/map/map/itemcomp/RougeMapPieceItem.lua

module("modules.logic.rouge.map.map.itemcomp.RougeMapPieceItem", package.seeall)

local RougeMapPieceItem = class("RougeMapPieceItem", RougeMapBaseItem)

function RougeMapPieceItem:init(pieceMo, map)
	RougeMapPieceItem.super.init(self)

	self.pieceMo = pieceMo
	self.pieceCo = self.pieceMo:getPieceCo()
	self.map = map

	self:setId(self.pieceMo.id)
	self:createPiece()
	self:createIcon()
	self:createEffect()
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, self.onUpdateMapInfo, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onMiddleActorBeforeMove, self.onMiddleActorBeforeMove, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onExitPieceChoiceEvent, self.onExitPieceChoiceEvent, self)
end

function RougeMapPieceItem:createPiece()
	local middleLayerCo = RougeMapModel.instance:getMiddleLayerCo()
	local dayOrNight = middleLayerCo.dayOrNight
	local res = self.pieceCo.pieceRes

	if string.nilorempty(res) then
		self.isEmpty = true
		self.pieceGo = gohelper.create3d(self.map.goLayerPiecesContainer, self.pieceCo.id)
	else
		self.isEmpty = false
		res = RougeMapHelper.getPieceResPath(res, dayOrNight)
		self.pieceGo = gohelper.clone(self.map.piecePrefabDict[res], self.map.goLayerPiecesContainer, self.pieceCo.id)
	end

	self.pieceTr = self.pieceGo.transform

	transformhelper.setLocalPos(self.pieceTr, self:getMapPos())
	self:refreshDirection()
end

function RougeMapPieceItem:createIcon()
	local type = self.pieceCo.entrustType

	if type == 0 then
		logError(string.format("棋子id : %s, 没有配置委托类型", self.pieceCo.id))

		return
	end

	if type == RougeMapEnum.PieceEntrustType.Boss then
		return
	end

	if not self:canShowIcon() then
		return
	end

	local bgEnum = RougeMapEnum.PieceIconBg[self.pieceCo.entrustType]
	local bgPrefab = self.map.iconBgPrefabDict[bgEnum]
	local parent = self.map.goPieceIconContainer

	self.bgGo = gohelper.clone(bgPrefab, parent, self.pieceCo.id)
	self.bgTr = self.bgGo.transform

	local x, y, z = self:getMapPos()

	transformhelper.setLocalPos(self.bgTr, x + RougeMapEnum.PieceIconOffset.x, y + RougeMapEnum.PieceIconOffset.y, z)

	local iconPrefab = self.map.iconPrefabDict[type]

	self.iconGo = gohelper.clone(iconPrefab, self.bgGo, "icon")
	self.iconTr = self.iconGo.transform

	transformhelper.setLocalPos(self.iconTr, 0, 0, 0)
end

function RougeMapPieceItem:createEffect()
	if self.pieceCo.bossEffect == 0 then
		return
	end

	self.effectGo = gohelper.clone(self.map.luoLeiLaiEffectPrefab, self.pieceGo, "effect")

	self:refreshEffect()
end

function RougeMapPieceItem:refreshDirection()
	if self.isEmpty then
		return
	end

	self:initDirectionMap()

	local pathPos = RougeMapModel.instance:getMiddleLayerPathPos(self.pieceMo.index + 1)
	local x, y = self:getMapPos()
	local angle = RougeMapHelper.getAngle(x, y, pathPos.x, pathPos.y)
	local dir = RougeMapHelper.getPieceDir(angle)

	for _dir, go in pairs(self.directionGoMap) do
		gohelper.setActive(go, _dir == dir)
	end
end

function RougeMapPieceItem:initDirectionMap()
	if self.isEmpty then
		return
	end

	if self.directionGoMap then
		return
	end

	self.directionGoMap = self:getUserDataTb_()

	for _, dir in pairs(RougeMapEnum.PieceDir) do
		self.directionGoMap[dir] = gohelper.findChild(self.pieceGo, dir)
	end
end

function RougeMapPieceItem:getScenePos()
	return self.pieceTr.position
end

function RougeMapPieceItem:getMapPos()
	local pos = RougeMapModel.instance:getMiddleLayerPosByIndex(self.pieceMo.index + 1)

	if not pos then
		return 0, 0, 0
	end

	return pos.x, pos.y, RougeMapHelper.getOffsetZ(pos.y)
end

function RougeMapPieceItem:getClickArea()
	return RougeMapEnum.PieceClickArea
end

function RougeMapPieceItem:onClick()
	logNormal("点击棋子了... " .. self.pieceCo.id)

	if self.pieceMo.finish then
		return
	end

	if not self:canShowIcon() then
		return
	end

	RougeMapController.instance:moveToPieceItem(self.pieceMo, self.onMoveDone, self)
end

function RougeMapPieceItem:onMoveDone()
	self.callbackId = RougeRpc.instance:sendRougePieceMoveRequest(self.pieceMo.index, self.onReceiveMsg, self)
end

function RougeMapPieceItem:onReceiveMsg()
	self.callbackId = nil

	ViewMgr.instance:openView(ViewName.RougeMapPieceChoiceView, self.pieceMo)
end

function RougeMapPieceItem:onUpdateMapInfo()
	self:refreshIcon()
	self:refreshEffect()
end

function RougeMapPieceItem:canShowIcon()
	if self.onPieceView then
		return false
	end

	if self.pieceMo.finish then
		return false
	end

	if not RougeMapHelper.isEntrustPiece(self.pieceCo.entrustType) then
		return true
	end

	return RougeMapModel.instance:getEntrustId() == nil
end

function RougeMapPieceItem:refreshIcon()
	local canShow = self:canShowIcon()

	gohelper.setActive(self.bgGo, canShow)
	gohelper.setActive(self.iconGo, canShow)
end

function RougeMapPieceItem:refreshEffect()
	if not self.effectGo then
		return
	end

	local isFinish = self.pieceMo.finish

	gohelper.setActive(self.effectGo, not isFinish)
end

function RougeMapPieceItem:onMiddleActorBeforeMove(data)
	local pieceId = data.pieceId

	if pieceId == RougeMapEnum.LeaveId then
		return
	end

	self.onPieceView = true

	self:refreshIcon()
end

function RougeMapPieceItem:onExitPieceChoiceEvent()
	self.onPieceView = false

	self:refreshIcon()
end

function RougeMapPieceItem:destroy()
	if self.callbackId then
		RougeRpc.instance:removeCallbackById(self.callbackId)
	end

	RougeMapPieceItem.super.destroy(self)
end

return RougeMapPieceItem
