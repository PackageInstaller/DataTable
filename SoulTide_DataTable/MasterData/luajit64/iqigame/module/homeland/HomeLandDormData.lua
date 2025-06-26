-- chunkname: @IQIGame\\Module\\HomeLand\\HomeLandDormData.lua

HomeLandDormData = {}

function HomeLandDormData.New()
	local o = Clone(HomeLandDormData)

	return o
end

function HomeLandDormData:Init(id, isUnlock, roles, foreignShow)
	self.roomID = id
	self.isUnlock = isUnlock
	self.cfgHomeLandRoomInfo = CfgHomeLandRoomTable[self.roomID]
	self.homeLandRoles = roles
	self.foreignShow = foreignShow
end

return HomeLandDormData
