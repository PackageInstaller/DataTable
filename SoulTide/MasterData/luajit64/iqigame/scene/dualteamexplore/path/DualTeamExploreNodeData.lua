-- chunkname: @IQIGame\\Scene\\DualTeamExplore\\Path\\DualTeamExploreNodeData.lua

local m = {
	Expired = false
}

function m.New(id)
	local obj = Clone(m)

	obj:Init(id)

	return obj
end

function m:Init(id)
	self.id = id
end

function m:Update(pod)
	self.cid = pod.cid
	self.capacity = pod.capacity
	self.occupierTeamId = pod.occupierTeamId
	self.nextNodes = self.nextNodes or {}

	for i = 1, #self.nextNodes do
		self.nextNodes[i] = nil
	end

	if pod.nextNodes ~= nil then
		for i = 1, #pod.nextNodes do
			local nodeData = DualTeamExploreModule.GetNodeDataById(pod.nextNodes[i])

			self.nextNodes[i] = nodeData
		end
	end
end

return m
