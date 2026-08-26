-- chunkname: @modules/logic/seasonver/act123/model/Season123ShowHeroMO.lua

module("modules.logic.seasonver.act123.model.Season123ShowHeroMO", package.seeall)

local Season123ShowHeroMO = pureTable("Season123ShowHeroMO")

function Season123ShowHeroMO:init(heroMO, heroUid, heroId, skinId, hpRate, isAssist)
	self.id = heroUid
	self.uid = heroUid
	self.heroId = heroId
	self.hpRate = hpRate
	self.heroMO = heroMO
	self.skin = skinId
	self.isAssist = isAssist
end

return Season123ShowHeroMO
