-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkAttrData.lua

local m = {
	attrID = 0,
	attrType = 0,
	attrValue = 0
}

function m.New(attrType, attrValue)
	local o = Clone(m)

	o:Init(attrType, attrValue)

	return o
end

function m:Init(attrType, attrValue)
	self.attrType = attrType
	self.attrValue = attrValue
	self.attrID = self:GetAttrID()
end

function m:GetAttrID()
	for i, v in pairsCfg(CfgAmusementParkAttributeTable) do
		if v.Group == AmusementParkModule.GlobalCid and v.Tpye == self.attrType then
			return v.Id
		end
	end

	return 0
end

function m:GetCfgData()
	return CfgAmusementParkAttributeTable[self.attrID]
end

return m
