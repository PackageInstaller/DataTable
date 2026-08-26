-- chunkname: @modules/logic/rouge2/map/model/mapmodel/Rouge2_LayerMapModel.lua

module("modules.logic.rouge2.map.model.mapmodel.Rouge2_LayerMapModel", package.seeall)

local Rouge2_LayerMapModel = class("Rouge2_LayerMapModel")

function Rouge2_LayerMapModel:initMap(layerInfo)
	self.layerId = layerInfo.layerId
	self.layerCo = lua_rouge2_layer.configDict[self.layerId]
	self.curEpisodeId = Rouge2_MapHelper.getEpisodeIndex(layerInfo.curStage)
	self.curNodeId = layerInfo.curNode

	self:initNodeInfo(layerInfo.nodeInfo)
end

function Rouge2_LayerMapModel:updateMapInfo(layerInfo)
	self.curEpisodeId = Rouge2_MapHelper.getEpisodeIndex(layerInfo.curStage)
	self.curNodeId = layerInfo.curNode

	self:updateNodeInfo(layerInfo.nodeInfo)
end

function Rouge2_LayerMapModel:updateSimpleMapInfo(layerInfo)
	self:updateMapInfo(layerInfo)
end

function Rouge2_LayerMapModel:initNodeInfo(nodeInfoList)
	self.episodeList = {}
	self.nodeDict = {}

	local nodeIndex = 0
	local maxEpisodeIndex = 0
	local maxNodeId = 0

	for _, nodeInfo in ipairs(nodeInfoList) do
		local episodeIndex = Rouge2_MapHelper.getEpisodeIndex(nodeInfo.stage)

		if maxEpisodeIndex < episodeIndex then
			maxEpisodeIndex = episodeIndex
		end

		if maxNodeId < nodeInfo.nodeId then
			maxNodeId = nodeInfo.nodeId
		end

		local episodeMo = self.episodeList[episodeIndex]

		if not episodeMo then
			episodeMo = Rouge2_EpisodeMO.New()

			episodeMo:init(episodeIndex)
			table.insert(self.episodeList, episodeMo)

			nodeIndex = 0
		end

		nodeIndex = nodeIndex + 1

		local nodeMo = Rouge2_NodeInfoMO.New()

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

	local endEpisodeMo = Rouge2_EpisodeMO.New()

	endEpisodeMo:init(endEpisodeIndex)
	endEpisodeMo:setIsEnd(true)

	local endNodeMo = Rouge2_NodeInfoMO.New()

	endEpisodeMo:addNode(endNodeMo)
	endNodeMo:initEnd(self.layerId, endEpisodeIndex, self.endNodeId, preNodeList)
	table.insert(self.episodeList, endEpisodeMo)

	self.nodeDict[self.endNodeId] = endNodeMo

	for _, episodeMo in ipairs(self.episodeList) do
		episodeMo:sortNode()
		episodeMo:updateNodeArriveStatus()
	end
end

function Rouge2_LayerMapModel:updateNodeInfo(nodeInfoList)
	for _, nodeInfo in ipairs(nodeInfoList) do
		local nodeMo = self.nodeDict[nodeInfo.nodeId]

		if not nodeMo then
			logError("update node info fail, not found nodeId : " .. tostring(nodeInfo.nodeId))
		else
			nodeMo:updateInfo(nodeInfo)
		end
	end

	for _, episodeMo in ipairs(self.episodeList) do
		episodeMo:sortNode()
		episodeMo:updateNodeArriveStatus()
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onNodeArriveStatusChange)
end

function Rouge2_LayerMapModel:getEpisodeList()
	return self.episodeList
end

function Rouge2_LayerMapModel:getCurEpisodeId()
	return self.curEpisodeId
end

function Rouge2_LayerMapModel:getCurNode()
	return self:getNode(self.curNodeId)
end

function Rouge2_LayerMapModel:getNodeDict()
	return self.nodeDict
end

function Rouge2_LayerMapModel:getNode(nodeId)
	local node = self.nodeDict[nodeId]

	if not node then
		logError("not found nodeId : " .. tostring(nodeId))

		return nil
	end

	return node
end

function Rouge2_LayerMapModel:getEndNodeId()
	return self.endNodeId
end

function Rouge2_LayerMapModel:clear()
	self.episodeList = nil
	self.nodeDict = nil
	self.layerId = nil
	self.layerCo = nil
	self.curEpisodeId = nil
	self.curNodeId = nil
end

return Rouge2_LayerMapModel
