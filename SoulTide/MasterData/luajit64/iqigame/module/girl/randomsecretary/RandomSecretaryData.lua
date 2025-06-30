-- chunkname: @IQIGame\\Module\\Girl\\RandomSecretary\\RandomSecretaryData.lua

local m = {
	isSelect = false
}

function m.New(cid, select)
	local o = Clone(m)

	o:Init(cid, select)

	return o
end

function m:Init(cid, select)
	self.cid = cid
	self.isSelect = select
end

function m:GetCfgData()
	return CfgRandomSecretaryTable[self.cid]
end

return m
