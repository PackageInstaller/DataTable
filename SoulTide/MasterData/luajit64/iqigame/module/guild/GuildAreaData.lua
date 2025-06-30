-- chunkname: @IQIGame\\Module\\Guild\\GuildAreaData.lua

local m = {
	isLock = false
}

function m.New(cfgID, isLock)
	local o = Clone(m)

	o:Init(cfgID, isLock)

	return o
end

function m:Init(cfgID, isLock)
	self.cfgID = cfgID
	self.cfgInfo = CfgGuildAreaTable[cfgID]
	self.isLock = isLock
end

return m
