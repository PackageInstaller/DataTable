-- chunkname: @modules/logic/seasonver/act123/model/Season123PickHeroMO.lua

module("modules.logic.seasonver.act123.model.Season123PickHeroMO", package.seeall)

local Season123PickHeroMO = pureTable("Season123PickHeroMO")

function Season123PickHeroMO:init(heroUid, heroId, skinId, index)
	self.id = heroUid
	self.uid = heroUid
	self.index = index
	self.heroId = heroId
	self.skin = skinId
	self.isSelect = false
end

return Season123PickHeroMO
