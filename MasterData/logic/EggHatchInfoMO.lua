-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/EggHatchInfoMO.lua

module("logic.extensions.petzoo.model.EggHatchInfoMO", package.seeall)

local EggHatchInfoMO = class("EggHatchInfoMO")

function EggHatchInfoMO:ctor()
	self:reset()
end

function EggHatchInfoMO:reset()
	self.animalRace = 0
	self.geneInfo = nil
	self.hatchEndTime = 0
	self.absorbBuddyId = 0
	self.absorbBuddyName = nil
	self.absorbStartTime = 0
	self.maxCanAbsorbTime = 0
	self.absorbMaxEndTime = 0
	self.hatchCD = 0
end

function EggHatchInfoMO:getHatchSurplusTime()
	local now = ServerTime.now()

	return checknumber(self.absorbBuddyId) > 0 and (now < self.absorbMaxEndTime and self.hatchEndTime + self.maxCanAbsorbTime - now or self.hatchEndTime - now) or self.hatchEndTime - now
end

return EggHatchInfoMO
