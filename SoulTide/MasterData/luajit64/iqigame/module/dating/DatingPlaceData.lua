-- chunkname: @IQIGame\\Module\\Dating\\DatingPlaceData.lua

DatingPlaceData = {
	isUnlock = false
}

function DatingPlaceData.New()
	local o = Clone(DatingPlaceData)

	return o
end

function DatingPlaceData:Init(cfgID, unlock)
	self.cfgPlaceID = cfgID
	self.cfgDatingPlace = CfgDatingPlaceTable[cfgID]
	self.isUnlock = unlock
end
