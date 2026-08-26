-- chunkname: @modules/logic/rouge2/map/model/mapmodel/Rouge2_MiddleLayerMapModel.lua

module("modules.logic.rouge2.map.model.mapmodel.Rouge2_MiddleLayerMapModel", package.seeall)

local Rouge2_MiddleLayerMapModel = class("Rouge2_MiddleLayerMapModel")

function Rouge2_MiddleLayerMapModel:initMap(middleLayerInfo)
	self.layerId = middleLayerInfo.layerId
	self.layerCo = lua_rouge2_layer.configDict[self.layerId]
	self.middleLayerId = middleLayerInfo.middleLayerId
	self.middleCo = lua_rouge2_middle_layer.configDict[self.middleLayerId]
	self.curPosIndex = middleLayerInfo.positionIndex

	self:initPieceInfo(middleLayerInfo.pieceInfo)
end

function Rouge2_MiddleLayerMapModel:updateMapInfo(middleLayerInfo)
	self.curPosIndex = middleLayerInfo.positionIndex

	for _, pieceInfo in ipairs(middleLayerInfo.pieceInfo) do
		self:updateOnePieceInfo(pieceInfo)
	end
end

function Rouge2_MiddleLayerMapModel:updateSimpleMapInfo(middleLayerInfo)
	self:updateMapInfo(middleLayerInfo)
end

function Rouge2_MiddleLayerMapModel:initPieceInfo(pieceInfoList)
	self.pieceDict = {}
	self.pieceList = {}

	for _, pieceInfo in ipairs(pieceInfoList) do
		local pieceMo = Rouge2_PieceInfoMO.New()

		pieceMo:init(pieceInfo)

		self.pieceDict[pieceMo.index] = pieceMo

		table.insert(self.pieceList, pieceMo)
	end
end

function Rouge2_MiddleLayerMapModel:updateOnePieceInfo(pieceInfo)
	local pieceMo = self.pieceDict[pieceInfo.index]

	if not pieceInfo then
		logError("update a not exist piece .. " .. tostring(pieceInfo.index))

		return
	end

	pieceMo:update(pieceInfo)
end

function Rouge2_MiddleLayerMapModel:getPieceList()
	return self.pieceList
end

function Rouge2_MiddleLayerMapModel:getMiddleLayerPosByIndex(index)
	return self.middleCo.pointPos[index]
end

function Rouge2_MiddleLayerMapModel:getPathIndex(pointIndex)
	local pos = self:getMiddleLayerPosByIndex(pointIndex)

	if not pos then
		logError("pos = nil" .. pointIndex)
	end

	return pos.z
end

function Rouge2_MiddleLayerMapModel:getMiddleLayerPathPos(pointIndex)
	local pathIndex = self:getPathIndex(pointIndex)

	return self:getMiddleLayerPathPosByPathIndex(pathIndex)
end

function Rouge2_MiddleLayerMapModel:getMiddleLayerPathPosByPathIndex(pathIndex)
	return self.middleCo.pathPointPos[pathIndex]
end

function Rouge2_MiddleLayerMapModel:getCurPosIndex()
	return self.curPosIndex
end

function Rouge2_MiddleLayerMapModel:getMiddleLayerLeavePos()
	local leavePos = self.middleCo.leavePos

	if not leavePos then
		logError(string.format("间隙层地图id ：%s， 没有配置出口位置", self.middleCo.id))

		return 5.68, 0.41
	end

	return leavePos.x, leavePos.y
end

function Rouge2_MiddleLayerMapModel:hadLeavePos()
	return self.middleCo and self.middleCo.leavePos
end

function Rouge2_MiddleLayerMapModel:getMiddleLayerLeavePathIndex()
	local leavePos = self.middleCo.leavePos

	return leavePos.z
end

function Rouge2_MiddleLayerMapModel:getPieceMo(pieceIndex)
	return self.pieceDict[pieceIndex]
end

function Rouge2_MiddleLayerMapModel:getCurPieceMo()
	return self:getPieceMo(self:getCurPosIndex())
end

function Rouge2_MiddleLayerMapModel:clear()
	self.layerId = nil
	self.layerCo = nil
	self.middleLayerId = nil
	self.middleCo = nil
	self.curPosition = nil
	self.pieceDict = nil
	self.pieceList = nil
end

return Rouge2_MiddleLayerMapModel
