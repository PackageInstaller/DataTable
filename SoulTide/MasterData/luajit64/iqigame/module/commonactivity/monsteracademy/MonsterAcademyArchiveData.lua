-- chunkname: @IQIGame\\Module\\CommonActivity\\MonsterAcademy\\MonsterAcademyArchiveData.lua

local m = {}

function m.New(index, type)
	local o = Clone(m)

	o:Init(index, type)

	return o
end

function m:Init(index, type)
	self.index = index
	self.type = type
end

function m:SetArchiveData(pod)
	self.saveDataPod = pod
end

function m:CleanArchiveData()
	self.saveDataPod = nil
end

return m
