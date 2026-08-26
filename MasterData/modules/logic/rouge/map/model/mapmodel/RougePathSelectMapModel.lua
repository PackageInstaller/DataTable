-- chunkname: @modules/logic/rouge/map/model/mapmodel/RougePathSelectMapModel.lua

module("modules.logic.rouge.map.model.mapmodel.RougePathSelectMapModel", package.seeall)

local RougePathSelectMapModel = class("RougePathSelectMapModel")

function RougePathSelectMapModel:initMap(middleLayerInfo)
	self.layerId = middleLayerInfo.layerId
	self.layerCo = lua_rouge_layer.configDict[self.layerId]
	self.middleLayerId = middleLayerInfo.middleLayerId
	self.middleLayerCo = lua_rouge_middle_layer.configDict[self.middleLayerId]

	self:initPieceInfo(middleLayerInfo.pieceInfo)
	self:initNextLayerList()
	self:initPathSelectCo()
	self:initLayerChoiceInfo(middleLayerInfo.layerChoiceInfo)
end

function RougePathSelectMapModel:initPieceInfo(pieceInfoList)
	self.pieceDict = {}
	self.pieceList = {}

	for _, pieceInfo in ipairs(pieceInfoList) do
		local pieceMo = RougePieceInfoMO.New()

		pieceMo:init(pieceInfo)

		self.pieceDict[pieceMo.index] = pieceMo

		table.insert(self.pieceList, pieceMo)
	end
end

function RougePathSelectMapModel:initPathSelectCo()
	local pathSelectList = RougeMapConfig.instance:getPathSelectList(self.middleLayerId)

	if #pathSelectList == 1 then
		self.pathSelectId = pathSelectList[1]
		self.pathSelectCo = lua_rouge_path_select.configDict[self.pathSelectId]

		return
	end

	for index, layerId in ipairs(self.allLayerList) do
		if self.selectLayerId == layerId then
			self.pathSelectId = pathSelectList[index]
			self.pathSelectCo = lua_rouge_path_select.configDict[self.pathSelectId]

			return
		end
	end

	logError("路线选择层 一个可以选择的路线都没找到, 间隙层id : " .. tostring(self.middleLayerId))
end

function RougePathSelectMapModel:updateMapInfo(layerInfo)
	self:initLayerChoiceInfo(layerInfo.layerChoiceInfo)
end

function RougePathSelectMapModel:updateSimpleMapInfo(layerInfo)
	self:updateMapInfo(layerInfo)
end

function RougePathSelectMapModel:initNextLayerList()
	local nextLayerList = RougeMapConfig.instance:getNextLayerList(self.middleLayerId)

	if not nextLayerList then
		self.nextLayerList = nil
		self.selectLayerId = nil

		return
	end

	self.nextLayerList = {}
	self.allLayerList = {}

	for _, layerId in ipairs(nextLayerList) do
		local layerCo = lua_rouge_layer.configDict[layerId]

		if RougeMapUnlockHelper.checkIsUnlock(layerCo.unlockType, layerCo.unlockParam) then
			self.selectLayerId = layerId

			table.insert(self.nextLayerList, layerId)
		end

		table.insert(self.allLayerList, layerId)
	end
end

function RougePathSelectMapModel:updateSelectLayerId(layerId)
	if self.selectLayerId == layerId then
		return
	end

	self.selectLayerId = layerId

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectLayerChange, self.selectLayerId)
end

function RougePathSelectMapModel:getSelectLayerId()
	return self.selectLayerId
end

function RougePathSelectMapModel:getPieceList()
	return self.pieceList
end

function RougePathSelectMapModel:getNextLayerList()
	return self.nextLayerList
end

function RougePathSelectMapModel:initLayerChoiceInfo(layerChoiceInfo)
	self._layerChoiceInfoMap = {}

	if layerChoiceInfo then
		self._layerChoiceInfoMap = GameUtil.rpcInfosToMap(layerChoiceInfo, RougeLayerChoiceInfoMO, "layerId")
	end
end

function RougePathSelectMapModel:getLayerChoiceInfo(layerId)
	return self._layerChoiceInfoMap and self._layerChoiceInfoMap[layerId]
end

function RougePathSelectMapModel:clear()
	self.layerId = nil
	self.layerCo = nil
	self.middleLayerId = nil
	self.middleCo = nil
	self.pieceDict = nil
	self.pieceList = nil
end

return RougePathSelectMapModel
