-- chunkname: @modules/logic/rouge/map/model/rpcmo/RougeNodeInfoMO.lua

module("modules.logic.rouge.map.model.rpcmo.RougeNodeInfoMO", package.seeall)

local RougeNodeInfoMO = pureTable("RougeNodeInfoMO")

function RougeNodeInfoMO:init(nodeInfo)
	self.layer = nodeInfo.layer
	self.episodeId = RougeMapHelper.getEpisodeIndex(nodeInfo.stage)
	self.nodeId = nodeInfo.nodeId
	self.preNodeList = {}
	self.nextNodeList = {}

	self:updateIdList(self.preNodeList, nodeInfo.lastNodeList)
	self:updateIdList(self.nextNodeList, nodeInfo.nextNodeList)
	self:initEvent(nodeInfo)

	self.pathWay = nodeInfo.pathWay
	self.arriveStatus = RougeMapEnum.Arrive.CantArrive
	self.interactive9drop = nodeInfo.interactive9drop
	self.interactive10drop = nodeInfo.interactive10drop
	self.interactive14drop = nodeInfo.interactive14drop
	self.fog = nodeInfo.fog
end

function RougeNodeInfoMO:updateNodeType()
	self.nodeType = (not self.eventId or self.eventId == 0) and RougeMapEnum.NodeType.Start or RougeMapEnum.NodeType.Normal
end

function RougeNodeInfoMO:updateIdList(list, dataList)
	for _, id in ipairs(dataList) do
		table.insert(list, id)
	end
end

function RougeNodeInfoMO:setIndex(index)
	self.index = index
end

function RougeNodeInfoMO:initEnd(layer, episodeId, nodeId, preNodeList)
	self.nodeType = RougeMapEnum.NodeType.End
	self.layer = layer
	self.episodeId = episodeId
	self.nodeId = nodeId
	self.preNodeList = preNodeList
	self.pathWay = false
	self.arriveStatus = RougeMapEnum.Arrive.NotArrive
	self.fog = self:checkIsEndFog()
end

function RougeNodeInfoMO:checkIsEndFog()
	if self.preNodeList then
		for _, preNodeId in ipairs(self.preNodeList) do
			local preNodeMo = RougeMapModel.instance:getNode(preNodeId)

			if preNodeMo and not preNodeMo.fog then
				return false
			end
		end

		return true
	end
end

function RougeNodeInfoMO:setPos(x, y, z)
	self.x = x
	self.y = y
	self.z = z
end

function RougeNodeInfoMO:getEpisodePos()
	return self.x, self.y, self.z
end

function RougeNodeInfoMO:updateInfo(nodeInfo)
	self.pathWay = nodeInfo.pathWay
	self.fog = nodeInfo.fog

	tabletool.clear(self.preNodeList)
	tabletool.clear(self.nextNodeList)
	self:updateIdList(self.preNodeList, nodeInfo.lastNodeList)
	self:updateIdList(self.nextNodeList, nodeInfo.nextNodeList)

	if self.eventId ~= nodeInfo.eventId then
		local preEventId = self.eventId

		self:initEvent(nodeInfo)
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onNodeEventChange, preEventId, self.eventId)
	elseif not self:checkIsStart() then
		self.eventMo:update(self.eventCo, nodeInfo.eventData)
	end
end

function RougeNodeInfoMO:initEvent(nodeInfo)
	self.eventId = nodeInfo.eventId

	self:updateNodeType()

	if not self:checkIsStart() then
		self.eventCo = RougeMapConfig.instance:getRougeEvent(self.eventId)

		if not RougeMapEnum.EventType2Cls[self.eventCo.type] then
			self.eventMo = RougeMapEnum.EventType2Cls[self.eventCo.type].New()

			self.eventMo:init(self.eventCo, nodeInfo.eventData)
		end
	end
end

function RougeNodeInfoMO:eventIsChange()
	return self.preEventId ~= nil
end

function RougeNodeInfoMO:checkIsStart()
	return self.nodeType == RougeMapEnum.NodeType.Start
end

function RougeNodeInfoMO:checkIsEnd()
	return self.nodeType == RougeMapEnum.NodeType.End
end

function RougeNodeInfoMO:checkIsNormal()
	return self.nodeType == RougeMapEnum.NodeType.Normal
end

function RougeNodeInfoMO:getEventCo()
	return self.eventCo
end

function RougeNodeInfoMO:getEventState()
	return self.eventMo and self.eventMo.state
end

function RougeNodeInfoMO:isFinishEvent()
	return self:getEventState() == RougeMapEnum.EventState.Finish
end

function RougeNodeInfoMO:isStartedEvent()
	return self:getEventState() == RougeMapEnum.EventState.Start
end

function RougeNodeInfoMO:__tostring()
	return string.format("nodeType : %s, layerId : %s, episodeId : %s, nodeId : %s, PreNode : %s, NextNode : %s, eventMo : %s, arriveStatus : %s", self.nodeType, self.layer, self.episodeId, self.nodeId, table.concat(self.preNodeList, ";"), self.nextNodeList and table.concat(self.nextNodeList, ";") or "nil", tostring(self.eventMo), self.arriveStatus)
end

return RougeNodeInfoMO
