-- chunkname: @IQIGame\\Module\\Girl\\GirlBackGround\\GirlBackGroundData.lua

local m = {
	unlock = false
}

function m.New(cid, unlock)
	local o = Clone(m)

	o:Init(cid, unlock)

	return o
end

function m:Init(cid, unlock)
	self.cid = cid
	self.unlock = unlock
end

function m:GetConfigData()
	return CfgGirlBackgroundTable[self.cid]
end

return m
