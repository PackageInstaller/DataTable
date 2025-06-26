-- chunkname: @IQIGame\\Scene\\DualTeamExplore\\DualTeamExploreNode.lua

local m = {
	id = 0
}

function m.New(view, id)
	local obj = Clone(m)

	obj:Init(view, id)

	return obj
end

function m:Init(view, id)
	self.gameObject = view
	self.id = id
end

function m:__SetData(nodeData)
	self.NodeData = nodeData
end

function m:GetPos()
	return self.gameObject.transform.position:Clone()
end

function m:GetElementPos(isBuilding)
	if isBuilding then
		return self.gameObject.transform:Find("BuildingPoint").position
	else
		return self.gameObject.transform:Find("NpcPoint").position
	end
end

function m:Dispose()
	self.gameObject = nil
end

return m
