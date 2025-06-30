-- chunkname: @IQIGame\\Module\\TownLibrary\\TownLibrarySoulBookData.lua

TownLibrarySoulBookData = {}

function TownLibrarySoulBookData.New(cfgID, open)
	local o = Clone(TownLibrarySoulBookData)

	o:Init(cfgID, open)

	return o
end

function TownLibrarySoulBookData:Init(cfgID, open)
	self.cfgID = cfgID
	self.open = open
	self.cfgInfo = CfgSoulBookTable[cfgID]
end

return TownLibrarySoulBookData
