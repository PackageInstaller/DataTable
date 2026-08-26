-- chunkname: @modules/logic/milestone/model/MileStoneMO.lua

module("modules.logic.milestone.model.MileStoneMO", package.seeall)

local MileStoneMO = pureTable("MileStoneMO")

function MileStoneMO:init(id)
	self.id = id
end

function MileStoneMO:updateInfo(info)
	self.getBonusId = info.getBonusId
	self.progress = info.progress
end

function MileStoneMO:updateBonusInfo(bonusId)
	self.getBonusId = bonusId
end

function MileStoneMO:isBonusHasGet(bonusId)
	return bonusId <= self.getBonusId
end

function MileStoneMO:getProgress()
	return self.progress
end

return MileStoneMO
