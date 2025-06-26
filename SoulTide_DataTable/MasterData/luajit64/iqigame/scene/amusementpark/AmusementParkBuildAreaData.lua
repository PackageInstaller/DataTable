-- chunkname: @IQIGame\\Scene\\AmusementPark\\AmusementParkBuildAreaData.lua

local m = {}

function m.New(pos)
	local o = Clone(m)

	o:Init(pos)

	return o
end

function m:Init(pos)
	self.pos = pos
end

function m:IsOpen()
	return table.indexOf(AmusementParkModule.AmusementParkInfoPOD.postList, self.pos) ~= -1
end

function m:GetAreaBuildData()
	for i, v in pairs(AmusementParkModule.AmusementParkBuilds) do
		if v.parkBuildPOD and v.parkBuildPOD.post == self.pos then
			return v
		end
	end

	return nil
end

return m
