-- chunkname: @modules/logic/rouge2/map/model/rpcmo/Rouge2_NodeInfoMO.lua

module("modules.logic.rouge2.map.model.rpcmo.Rouge2_NodeInfoMO", package.seeall)

local Rouge2_NodeInfoMO = pureTable("Rouge2_NodeInfoMO")

function Rouge2_NodeInfoMO:init(nodeInfo)
	self.layer = nodeInfo.layer
	self.episodeId = Rouge2_MapHelper.getEpisodeIndex(nodeInfo.stage)
	self.nodeId = nodeInfo.nodeId
	self.preNodeList = {}
	self.nextNodeList = {}

	self:updateIdList(self.preNodeList, nodeInfo.lastNodeList)
	self:updateIdList(self.nextNodeList, nodeInfo.nextNodeList)
	self:initEvent(nodeInfo)

	self.pathWay = nodeInfo.pathWay
	self.arriveStatus = Rouge2_MapEnum.Arrive.CantArrive
	self.interactive9drop = nodeInfo.interactive9drop
	self.interactive10drop = nodeInfo.interactive10drop
	self.interactive14drop = nodeInfo.interactive14drop
end

function Rouge2_NodeInfoMO:updateNodeType()
	self.nodeType = (not self.eventId or self.eventId == 0) and Rouge2_MapEnum.NodeType.Start or Rouge2_MapEnum.NodeType.Normal
end

function Rouge2_NodeInfoMO:updateIdList(list, dataList)
	for _, id in ipairs(dataList) do
		table.insert(list, id)
	end
end

function Rouge2_NodeInfoMO:setIndex(index)
	self.index = index
end

function Rouge2_NodeInfoMO:initEnd(layer, episodeId, nodeId, preNodeList)
	self.nodeType = Rouge2_MapEnum.NodeType.End
	self.layer = layer
	self.episodeId = episodeId
	self.nodeId = nodeId
	self.preNodeList = preNodeList
	self.pathWay = false
	self.arriveStatus = Rouge2_MapEnum.Arrive.NotArrive
end

function Rouge2_NodeInfoMO:setPos(x, y, z)
	self.x = x
	self.y = y
	self.z = z
end

function Rouge2_NodeInfoMO:getEpisodePos()
	return self.x, self.y, self.z
end

function Rouge2_NodeInfoMO:updateInfo(nodeInfo)
	self.pathWay = nodeInfo.pathWay

	tabletool.clear(self.preNodeList)
	tabletool.clear(self.nextNodeList)
	self:updateIdList(self.preNodeList, nodeInfo.lastNodeList)
	self:updateIdList(self.nextNodeList, nodeInfo.nextNodeList)

	if self.eventId ~= nodeInfo.eventId then
		local preEventId = self.eventId

		self:initEvent(nodeInfo)
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onNodeEventChange, preEventId, self.eventId)
	elseif not self:checkIsStart() then
		self.eventMo:update(self.eventCo, nodeInfo.eventData)
	end
end

function Rouge2_NodeInfoMO:initEvent(nodeInfo)
	self.eventId = nodeInfo.eventId

	self:updateNodeType()

	if not self:checkIsStart() then
		self.eventCo = Rouge2_MapConfig.instance:getRougeEvent(self.eventId)

		if not Rouge2_MapEnum.EventType2Cls[self.eventCo.type] then
			self.eventMo = Rouge2_MapEnum.EventType2Cls[self.eventCo.type].New()

			self.eventMo:init(self.eventCo, nodeInfo.eventData)
		end
	end
end

function Rouge2_NodeInfoMO:eventIsChange()
	return self.preEventId ~= nil
end

function Rouge2_NodeInfoMO:checkIsStart()
	return self.nodeType == Rouge2_MapEnum.NodeType.Start
end

function Rouge2_NodeInfoMO:checkIsEnd()
	return self.nodeType == Rouge2_MapEnum.NodeType.End
end

function Rouge2_NodeInfoMO:checkIsNormal()
	return self.nodeType == Rouge2_MapEnum.NodeType.Normal
end

function Rouge2_NodeInfoMO:getEventCo()
	return self.eventCo
end

function Rouge2_NodeInfoMO:getEventState()
	return self.eventMo and self.eventMo.state
end

function Rouge2_NodeInfoMO:isFinishEvent()
	return self:getEventState() == Rouge2_MapEnum.EventState.Finish
end

function Rouge2_NodeInfoMO:isStartedEvent()
	return self:getEventState() == Rouge2_MapEnum.EventState.Start
end

function Rouge2_NodeInfoMO:__tostring()
	return string.format("nodeType : %s, layerId : %s, episodeId : %s, nodeId : %s, PreNode : %s, NextNode : %s, eventMo : %s, arriveStatus : %s", self.nodeType, self.layer, self.episodeId, self.nodeId, table.concat(self.preNodeList, ";"), self.nextNodeList and table.concat(self.nextNodeList, ";") or "nil", tostring(self.eventMo), self.arriveStatus)
end

return Rouge2_NodeInfoMO
