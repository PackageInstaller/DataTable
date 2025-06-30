-- chunkname: @IQIGame\\Module\\CommonActivity\\MonsterAcademy\\MonsterAcademyAreaFunctionData.lua

local m = {}

function m.New(cfgID, ownershipAreaID)
	local o = Clone(m)

	o:Init(cfgID, ownershipAreaID)

	return o
end

function m:Init(cfgID, ownershipAreaID)
	self.cfgID = cfgID
	self.ownerShipAreaID = ownershipAreaID
	self.cfgFunction = CfgGalgameMonsterSchoolFunctionTable[cfgID]
end

return m
