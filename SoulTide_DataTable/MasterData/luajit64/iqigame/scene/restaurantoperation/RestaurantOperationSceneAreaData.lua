-- chunkname: @IQIGame\\Scene\\RestaurantOperation\\RestaurantOperationSceneAreaData.lua

local m = {
	jobPositions = {},
	walkAreas = {}
}

function m.New(areaType, jobPositions, walkAreas)
	local o = Clone(m)

	o:Init(areaType, jobPositions, walkAreas)

	return o
end

function m:Init(areaType, jobPositions, walkAreas)
	self.sceneAreaType = areaType
	self.jobPositions = jobPositions
	self.walkAreas = walkAreas
end

function m:AddRoleInPos(pos, roleID)
	if self.jobPositions then
		for i, v in pairs(self.jobPositions) do
			if v.pos == pos then
				v.roleID = roleID
			end
		end
	end
end

function m:RemoveRoleFromPos(roleID)
	if self.jobPositions then
		for i, v in pairs(self.jobPositions) do
			if v.roleID == roleID then
				v.roleID = nil
			end
		end
	end
end

return m
