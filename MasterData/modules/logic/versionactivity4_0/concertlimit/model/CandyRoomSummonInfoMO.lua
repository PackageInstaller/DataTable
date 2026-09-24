-- chunkname: @modules/logic/versionactivity4_0/concertlimit/model/CandyRoomSummonInfoMO.lua

module("modules.logic.versionactivity4_0.concertlimit.model.CandyRoomSummonInfoMO", package.seeall)

local CandyRoomSummonInfoMO = pureTable("CandyRoomSummonInfoMO")

function CandyRoomSummonInfoMO:init()
	self.rewardId = 0
	self.summonedCount = 0
end

function CandyRoomSummonInfoMO:refresh(info)
	self.rewardId = info.rewardId
	self.summonedCount = info.summonedCount
end

function CandyRoomSummonInfoMO:getSummonedCount()
	return self.summonedCount
end

function CandyRoomSummonInfoMO:addSummonedCount(count)
	self.summonedCount = self.summonedCount + count
end

return CandyRoomSummonInfoMO
