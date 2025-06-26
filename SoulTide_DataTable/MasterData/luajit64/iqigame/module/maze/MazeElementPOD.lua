-- chunkname: @IQIGame\\Module\\Maze\\MazeElementPOD.lua

local m = {
	Pid = 0,
	NodeId = 0,
	IsRemoved = false,
	MoveTriggerCount = 0,
	ID = 0,
	PrePathNodeId = 0,
	CID = 0
}

function m.New(elementPOD)
	local obj = Clone(m)

	obj:Init(elementPOD)

	return obj
end

function m:Init(elementPOD)
	self.ID = elementPOD.ID
	self.CID = elementPOD.CID
	self.IsRemoved = elementPOD.IsRemoved
	self.ExecutionCounts = elementPOD.ExecutionCounts
	self.NodeId = elementPOD.NodeId
	self.Pid = elementPOD.Pid
	self.MoveTriggerCount = elementPOD.MoveTriggerCount
	self.PrePathNodeId = elementPOD.PrePathNodeId
end

return m
