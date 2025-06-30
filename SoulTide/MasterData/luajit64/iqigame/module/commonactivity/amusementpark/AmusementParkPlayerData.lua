-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkPlayerData.lua

local m = {}

function m.New(cid, dataPOD)
	local o = Clone(m)

	o:Init(cid, dataPOD)

	return o
end

function m:Init(cid, dataPOD)
	self.cid = cid
	self.parkRolePOD = dataPOD
end

function m:GetCfgData()
	return CfgAmusementParkRoleTable[self.cid]
end

function m:GetRoleAttrByAttrID(attrKey)
	local attrValue

	if self.parkRolePOD then
		attrValue = self.parkRolePOD.attr[attrKey] or 0
	end

	return attrValue
end

function m:IsOpenPlot()
	return self.parkRolePOD.level >= self:GetCfgData().PlotNeedLevel
end

function m:IsFullLevel()
	local cfgControlData = CfgAmusementParkControlTable[AmusementParkModule.GlobalCid]

	return self.parkRolePOD.level >= cfgControlData.MaxSoulLevel
end

function m:GetCfgParkRoleLevelData()
	for i, v in pairsCfg(CfgAmusementParkRoleLevelTable) do
		if v.Group == AmusementParkModule.GlobalCid and v.Level == self.parkRolePOD.level then
			return v
		end
	end

	return nil
end

return m
