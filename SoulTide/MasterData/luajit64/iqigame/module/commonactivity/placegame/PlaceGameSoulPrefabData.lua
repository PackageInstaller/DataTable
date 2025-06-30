-- chunkname: @IQIGame\\Module\\CommonActivity\\PlaceGame\\PlaceGameSoulPrefabData.lua

local m = {}

function m.New(pod)
	local o = Clone(m)

	o:Init(pod)

	return o
end

function m:Init(pod)
	self.id = pod.id

	self:UpdatePOD(pod)
end

function m:UpdatePOD(pod)
	self.placeGameSoulPrefabPOD = pod
end

return m
