-- chunkname: @modules/logic/rouge2/map/model/rpcmo/Rouge2_EpisodeMO.lua

module("modules.logic.rouge2.map.model.rpcmo.Rouge2_EpisodeMO", package.seeall)

local Rouge2_EpisodeMO = pureTable("Rouge2_EpisodeMO")

function Rouge2_EpisodeMO:init(id)
	self.id = id
	self.nodeMoList = {}
	self.isEnd = false
end

function Rouge2_EpisodeMO:setIsEnd(isEnd)
	self.isEnd = isEnd
end

function Rouge2_EpisodeMO:addNode(nodeMo)
	table.insert(self.nodeMoList, nodeMo)
end

function Rouge2_EpisodeMO:getNodeMoList()
	return self.nodeMoList
end

function Rouge2_EpisodeMO:updateNodeArriveStatus()
	local curNode = Rouge2_MapModel.instance:getCurNode()

	if self.id == 1 then
		local isArrived = self.nodeMoList[1] ~= curNode

		if isArrived then
			self.nodeMoList[1].arriveStatus = Rouge2_MapEnum.Arrive.Arrived or Rouge2_MapEnum.Arrive.ArrivingFinish
		end

		return
	end

	local arrivedNode = self:getArrivedNode()

	if arrivedNode then
		for _, nodeMo in ipairs(self.nodeMoList) do
			nodeMo.arriveStatus = nodeMo ~= arrivedNode and Rouge2_MapEnum.Arrive.CantArrive or curNode ~= nodeMo and Rouge2_MapEnum.Arrive.Arrived or nodeMo:getEventState() == Rouge2_MapEnum.EventState.Finish and Rouge2_MapEnum.Arrive.ArrivingFinish or Rouge2_MapEnum.Arrive.ArrivingNotFinish
		end

		return
	end

	for _, nodeMo in ipairs(self.nodeMoList) do
		local preNodeList = nodeMo.preNodeList

		nodeMo.arriveStatus = self:checkPreNodeHadStartOrArrivingFinish(preNodeList) and Rouge2_MapEnum.Arrive.CanArrive or self:checkPreNodeEveryIsCantArrive(preNodeList) and Rouge2_MapEnum.Arrive.CantArrive or Rouge2_MapEnum.Arrive.NotArrive
	end
end

function Rouge2_EpisodeMO:checkPreNodeHadStartOrArrivingFinish(preNodeList)
	if not preNodeList then
		return false
	end

	for _, preNodeId in ipairs(preNodeList) do
		local preNode = Rouge2_MapModel.instance:getNode(preNodeId)

		if preNode.arriveStatus == Rouge2_MapEnum.Arrive.ArrivingFinish then
			return true
		end
	end
end

function Rouge2_EpisodeMO:checkPreNodeEveryIsCantArrive(preNodeList)
	if not preNodeList then
		return true
	end

	for _, preNodeId in ipairs(preNodeList) do
		local preNode = Rouge2_MapModel.instance:getNode(preNodeId)

		if preNode.arriveStatus ~= Rouge2_MapEnum.Arrive.CantArrive then
			return false
		end
	end

	return true
end

function Rouge2_EpisodeMO:getArrivedNode()
	if self.id > Rouge2_MapModel.instance:getCurEpisodeId() then
		return nil
	end

	for _, nodeMo in ipairs(self.nodeMoList) do
		if nodeMo.pathWay then
			return nodeMo
		end
	end
end

function Rouge2_EpisodeMO:sortNode()
	table.sort(self.nodeMoList, Rouge2_EpisodeMO._sortFunc)

	for index, nodeMo in ipairs(self.nodeMoList) do
		nodeMo:setIndex(index)
	end
end

function Rouge2_EpisodeMO._sortFunc(a, b)
	return a.nodeId < b.nodeId
end

return Rouge2_EpisodeMO
