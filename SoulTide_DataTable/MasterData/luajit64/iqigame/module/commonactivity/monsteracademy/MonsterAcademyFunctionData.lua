-- chunkname: @IQIGame\\Module\\CommonActivity\\MonsterAcademy\\MonsterAcademyFunctionData.lua

local m = {
	schedulePOD = 0
}

function m.New(cfgID, ownerShipTargetID, schedulePOD)
	local o = Clone(m)

	o:Init(cfgID, ownerShipTargetID, schedulePOD)

	return o
end

function m:Init(cfgID, ownerShipTargetID, schedulePOD)
	self.cfgID = cfgID
	self.ownerShipTargetID = ownerShipTargetID
	self.schedulePOD = schedulePOD

	if self.schedulePOD then
		self.cfgID = self.schedulePOD.functionId
		self.functionID = self.schedulePOD.id
	else
		self.functionID = self.cfgID
	end

	self.cfgFunction = CfgGalgameMonsterSchoolFunctionTable[self.cfgID]
end

return m
