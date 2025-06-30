-- chunkname: @IQIGame\\Scene\\MemoryStory\\MemoryStoryPathNode.lua

local m = {
	NodeId = 0,
	ConnectNodeId = {}
}

function m.New(trans)
	local obj = Clone(m)

	obj:__Init(trans)

	return obj
end

function m:__Init(trans)
	self.NodeId = tonumber(trans.name)
	self.Position = trans.localPosition
	self.PositionV2 = Vector2.New(self.Position.x, self.Position.y)

	local cnt = trans.childCount

	for i = 0, cnt - 1 do
		local child = trans:GetChild(i)

		table.insert(self.ConnectNodeId, tonumber(child.name))
	end
end

return m
