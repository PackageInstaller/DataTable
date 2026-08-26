-- chunkname: @modules/logic/seasonver/act166/model/Season166HeroMO.lua

module("modules.logic.seasonver.act166.model.Season166HeroMO", package.seeall)

local Season166HeroMO = pureTable("Season166HeroMO")

function Season166HeroMO:init(info, isAssist)
	self.heroUid = info.heroUid
	self.isAssist = info.isAssist
end

return Season166HeroMO
