-- chunkname: @modules/logic/seasonver/act123/model/Season123HeroMO.lua

module("modules.logic.seasonver.act123.model.Season123HeroMO", package.seeall)

local Season123HeroMO = pureTable("Season123HeroMO")

function Season123HeroMO:init(info, isAssist)
	self.heroUid = info.heroUid
	self.hpRate = info.hpRate
	self.isAssist = info.isAssist
end

function Season123HeroMO:update(info)
	self.hpRate = info.hpRate
end

return Season123HeroMO
