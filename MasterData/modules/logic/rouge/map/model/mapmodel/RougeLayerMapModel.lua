-- chunkname: @modules/logic/rouge/map/model/mapmodel/RougeLayerMapModel.lua

module("modules.logic.rouge.map.model.mapmodel.RougeLayerMapModel", package.seeall)

local RougeLayerMapModel = class("RougeLayerMapModel")

function RougeLayerMapModel:initMap(layerInfo)
	self.layerId = layerInfo.layerId
	self.layerCo = lua_rouge_layer.configDict[self.layerId]
	self.curEpisodeId = RougeMapHelper.getEpisodeIndex(layerInfo.curStage)
	self.curNodeId = layerInfo.curNode

	self:initNodeInfo(layerInfo.nodeInfo)
	self:initLayerChoiceInfo(layerInfo.layerChoiceInfo)
end

function RougeLayerMapModel:updateMapInfo(layerInfo)
	self.curEpisodeId = RougeMapHelper.getEpisodeIndex(layerInfo.curStage)
	self.curNodeId = layerInfo.curNode

	self:updateNodeInfo(layerInfo.nodeInfo)
	self:updateLayerChoiceInfo(layerInfo.layerChoiceInfo)
end

function RougeLayerMapModel:updateSimpleMapInfo(layerInfo)
	self:updateMapInfo(layerInfo)
end

function RougeLayerMapModel:initNodeInfo(nodeInfoList)
	self.episodeList = {}
	self.nodeDict = {}

	local nodeIndex = 0
	local maxEpisodeIndex = 0
	local maxNodeId = 0

	for _, nodeInfo in ipairs(nodeInfoList) do
		local episodeIndex = RougeMapHelper.getEpisodeIndex(nodeInfo.stage)

		if maxEpisodeIndex < episodeIndex then
			maxEpisodeIndex = episodeIndex
		end

		if maxNodeId < nodeInfo.nodeId then
			maxNodeId = nodeInfo.nodeId
		end

		local episodeMo = self.episodeList[episodeIndex]

		if not episodeMo then
			episodeMo = RougeEpisodeMO.New()

			episodeMo:init(episodeIndex)
			table.insert(self.episodeList, episodeMo)

			nodeIndex = 0
		end

		nodeIndex = nodeIndex + 1

		local nodeMo = RougeNodeInfoMO.New()

		nodeMo:init(nodeInfo)
		episodeMo:addNode(nodeMo)

		self.nodeDict[nodeMo.nodeId] = nodeMo
	end

	local endEpisodeIndex = maxEpisodeIndex + 1

	self.endNodeId = maxNodeId + 1

	local preNodeList = {}
	local lastEpisodeMo = self.episodeList[maxEpisodeIndex]

	for _, nodeMo in ipairs(lastEpisodeMo:getNodeMoList()) do
		table.insert(preNodeList, nodeMo.nodeId)
	end

	local endEpisodeMo = RougeEpisodeMO.New()

	endEpisodeMo:init(endEpisodeIndex)
	endEpisodeMo:setIsEnd(true)

	local endNodeMo = RougeNodeInfoMO.New()

	endEpisodeMo:addNode(endNodeMo)
	endNodeMo:initEnd(self.layerId, endEpisodeIndex, self.endNodeId, preNodeList)
	table.insert(self.episodeList, endEpisodeMo)

	self.nodeDict[self.endNodeId] = endNodeMo

	for _, episodeMo in ipairs(self.episodeList) do
		episodeMo:sortNode()
		episodeMo:updateNodeArriveStatus()
	end

	self:initNodeFogInfo()
end

function RougeLayerMapModel:updateNodeInfo(nodeInfoList)
	for _, nodeInfo in ipairs(nodeInfoList) do
		local nodeMo = self.nodeDict[nodeInfo.nodeId]

		if not nodeMo then
			logError("update node info fail, not found nodeId : " .. tostring(nodeInfo.nodeId))
		else
			nodeMo:updateInfo(nodeInfo)
		end
	end

	local endNodeMo = self:getNode(self.endNodeId)

	if endNodeMo then
		endNodeMo.fog = endNodeMo:checkIsEndFog()
	end

	for _, episodeMo in ipairs(self.episodeList) do
		episodeMo:sortNode()
		episodeMo:updateNodeArriveStatus()
	end

	self:initNodeFogInfo()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onNodeArriveStatusChange)
end

function RougeLayerMapModel:getEpisodeList()
	return self.episodeList
end

function RougeLayerMapModel:getCurEpisodeId()
	return self.curEpisodeId
end

function RougeLayerMapModel:getCurNode()
	return self:getNode(self.curNodeId)
end

function RougeLayerMapModel:getNodeDict()
	return self.nodeDict
end

function RougeLayerMapModel:getNode(nodeId)
	local node = self.nodeDict[nodeId]

	if not node then
		logError("not found nodeId : " .. tostring(nodeId))

		return nil
	end

	return node
end

function RougeLayerMapModel:getEndNodeId()
	return self.endNodeId
end

function RougeLayerMapModel:initNodeFogInfo()
	self._fogNodeList = {}
	self._holeNodeList = {}
	self._fogNodeMap = {}
	self._holeNodeMap = {}

	local hasFogNode = false

	for _, episodeMo in ipairs(self.episodeList or {}) do
		local nodeMoList = episodeMo:getNodeMoList()
		local unfogNodes = {}

		for _, nodeMo in ipairs(nodeMoList or {}) do
			if nodeMo.fog then
				hasFogNode = true
				self._fogNodeMap[nodeMo.nodeId] = nodeMo

				table.insert(self._fogNodeList, nodeMo)
			else
				table.insert(unfogNodes, nodeMo)
			end
		end

		for _, nodeMo in ipairs(unfogNodes) do
			if hasFogNode then
				self._holeNodeMap[nodeMo.nodeId] = nodeMo

				table.insert(self._holeNodeList, nodeMo)
			end
		end
	end
end

function RougeLayerMapModel:getFogNodeList()
	return self._fogNodeList
end

function RougeLayerMapModel:getHoleNodeList()
	return self._holeNodeList
end

function RougeLayerMapModel:isHoleNode(nodeId)
	return self._holeNodeMap and self._holeNodeMap[nodeId] ~= nil
end

function RougeLayerMapModel:initLayerChoiceInfo(layerChoiceInfo)
	self.layerChoiceInfo = RougeLayerChoiceInfoMO.New()

	self.layerChoiceInfo:init(layerChoiceInfo)
end

function RougeLayerMapModel:updateLayerChoiceInfo(layerChoiceInfo)
	self.layerChoiceInfo = self.layerChoiceInfo or RougeLayerChoiceInfoMO.New()

	self.layerChoiceInfo:init(layerChoiceInfo)
end

function RougeLayerMapModel:getLayerChoiceInfo(layerId)
	if self.layerId == layerId then
		return self.layerChoiceInfo
	end
end

function RougeLayerMapModel:clear()
	self.episodeList = nil
	self.nodeDict = nil
	self.layerId = nil
	self.layerCo = nil
	self.curEpisodeId = nil
	self.curNodeId = nil
end

return RougeLayerMapModel
