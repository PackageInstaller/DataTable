-- chunkname: @modules/logic/rouge/map/model/mapmodel/RougeMiddleLayerMapModel.lua

module("modules.logic.rouge.map.model.mapmodel.RougeMiddleLayerMapModel", package.seeall)

local RougeMiddleLayerMapModel = class("RougeMiddleLayerMapModel")

function RougeMiddleLayerMapModel:initMap(middleLayerInfo)
	self.layerId = middleLayerInfo.layerId
	self.layerCo = lua_rouge_layer.configDict[self.layerId]
	self.middleLayerId = middleLayerInfo.middleLayerId
	self.middleCo = lua_rouge_middle_layer.configDict[self.middleLayerId]
	self.curPosIndex = middleLayerInfo.positionIndex

	self:initPieceInfo(middleLayerInfo.pieceInfo)
end

function RougeMiddleLayerMapModel:updateMapInfo(middleLayerInfo)
	self.curPosIndex = middleLayerInfo.positionIndex

	for _, pieceInfo in ipairs(middleLayerInfo.pieceInfo) do
		self:updateOnePieceInfo(pieceInfo)
	end
end

function RougeMiddleLayerMapModel:updateSimpleMapInfo(middleLayerInfo)
	self:updateMapInfo(middleLayerInfo)
end

function RougeMiddleLayerMapModel:initPieceInfo(pieceInfoList)
	self.pieceDict = {}
	self.pieceList = {}

	for _, pieceInfo in ipairs(pieceInfoList) do
		local pieceMo = RougePieceInfoMO.New()

		pieceMo:init(pieceInfo)

		self.pieceDict[pieceMo.index] = pieceMo

		table.insert(self.pieceList, pieceMo)
	end
end

function RougeMiddleLayerMapModel:updateOnePieceInfo(pieceInfo)
	local pieceMo = self.pieceDict[pieceInfo.index]

	if not pieceInfo then
		logError("update a not exist piece .. " .. tostring(pieceInfo.index))

		return
	end

	pieceMo:update(pieceInfo)
end

function RougeMiddleLayerMapModel:getPieceList()
	return self.pieceList
end

function RougeMiddleLayerMapModel:getMiddleLayerPosByIndex(index)
	return self.middleCo.pointPos[index]
end

function RougeMiddleLayerMapModel:getPathIndex(pointIndex)
	local pos = self:getMiddleLayerPosByIndex(pointIndex)

	return pos.z
end

function RougeMiddleLayerMapModel:getMiddleLayerPathPos(pointIndex)
	local pathIndex = self:getPathIndex(pointIndex)

	return self:getMiddleLayerPathPosByPathIndex(pathIndex)
end

function RougeMiddleLayerMapModel:getMiddleLayerPathPosByPathIndex(pathIndex)
	return self.middleCo.pathPointPos[pathIndex]
end

function RougeMiddleLayerMapModel:getCurPosIndex()
	return self.curPosIndex
end

function RougeMiddleLayerMapModel:getMiddleLayerLeavePos()
	local leavePos = self.middleCo.leavePos

	if not leavePos then
		logError(string.format("间隙层地图id ：%s， 没有配置出口位置", self.middleCo.id))

		return 5.68, 0.41
	end

	return leavePos.x, leavePos.y
end

function RougeMiddleLayerMapModel:hadLeavePos()
	return self.middleCo and self.middleCo.leavePos
end

function RougeMiddleLayerMapModel:getMiddleLayerLeavePathIndex()
	local leavePos = self.middleCo.leavePos

	return leavePos.z
end

function RougeMiddleLayerMapModel:getPieceMo(pieceIndex)
	return self.pieceDict[pieceIndex]
end

function RougeMiddleLayerMapModel:getCurPieceMo()
	return self:getPieceMo(self:getCurPosIndex())
end

function RougeMiddleLayerMapModel:clear()
	self.layerId = nil
	self.layerCo = nil
	self.middleLayerId = nil
	self.middleCo = nil
	self.curPosition = nil
	self.pieceDict = nil
	self.pieceList = nil
end

return RougeMiddleLayerMapModel
