-- chunkname: @IQIGame\\Module\\TownLibrary\\TownLibraryEquipData.lua

TownLibraryEquipData = {}

function TownLibraryEquipData.New(cfgID, isLock, star)
	local o = Clone(TownLibraryEquipData)

	o:Init(cfgID, isLock, star)

	return o
end

function TownLibraryEquipData:Init(cfgID, isLock, star)
	self.cfgID = cfgID
	self.cfgInfo = CfgItemTable[cfgID]
	self.isLock = isLock
	self.maxStart = star

	if self.maxStart == nil then
		self.maxStart = 0
	end
end

return TownLibraryEquipData
