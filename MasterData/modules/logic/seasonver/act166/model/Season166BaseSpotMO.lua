-- chunkname: @modules/logic/seasonver/act166/model/Season166BaseSpotMO.lua

module("modules.logic.seasonver.act166.model.Season166BaseSpotMO", package.seeall)

local Season166BaseSpotMO = pureTable("Season166BaseSpotMO")

function Season166BaseSpotMO:ctor()
	self.id = 0
	self.isEnter = false
	self.maxScore = 0
end

function Season166BaseSpotMO:setData(info)
	self.id = info.id
	self.isEnter = info.isEnter
	self.maxScore = info.maxScore
end

return Season166BaseSpotMO
