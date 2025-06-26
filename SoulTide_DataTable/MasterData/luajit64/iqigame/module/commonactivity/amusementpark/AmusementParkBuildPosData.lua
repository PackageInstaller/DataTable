-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkBuildPosData.lua

local m = {
	unLock = false
}

function m.New(pos, unLock, unlockLv, playerData)
	local o = Clone(m)

	o:Init(pos, unLock, unlockLv, playerData)

	return o
end

function m:Init(pos, unLock, unlockLv, playerData)
	self.pos = pos
	self.unLock = unLock
	self.unlockLv = unlockLv
	self.playerData = playerData
end

return m
