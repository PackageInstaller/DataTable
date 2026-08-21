-- chunkname: @IQIGame\\Module\\TownLibrary\\TownLibraryEventResData.lua

TownLibraryEventResData = {}

function TownLibraryEventResData.New(cfgID, isLock)
	local o = Clone(TownLibraryEventResData)

	o:Init(cfgID, isLock)

	return o
end

function TownLibraryEventResData:Init(cfgID, isLock)
	self.cfgID = cfgID
	self.cfgInfo = CfgTownAlienEventBookResTable[cfgID]
	self.isLock = isLock
end

return TownLibraryEventResData
