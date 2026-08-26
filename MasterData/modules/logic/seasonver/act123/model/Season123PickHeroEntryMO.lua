-- chunkname: @modules/logic/seasonver/act123/model/Season123PickHeroEntryMO.lua

module("modules.logic.seasonver.act123.model.Season123PickHeroEntryMO", package.seeall)

local Season123PickHeroEntryMO = pureTable("Season123PickHeroEntryMO")

function Season123PickHeroEntryMO:ctor(index)
	self.id = index
	self.heroMO = nil
	self.isSupport = false
end

function Season123PickHeroEntryMO:init(heroUid, heroId, skinId)
	self.heroId = heroId
	self.heroUid = heroUid
	self.heroMO = HeroModel.instance:getById(self.heroUid)
end

function Season123PickHeroEntryMO:getIsEmpty()
	return self.heroUid == nil or self.heroUid == 0
end

function Season123PickHeroEntryMO:updateByPickMO(pickMO)
	self.heroUid = pickMO.uid
	self.heroId = pickMO.heroId
	self.skinId = pickMO.skin
	self.isSupport = false
	self.heroMO = HeroModel.instance:getById(self.heroUid)
end

function Season123PickHeroEntryMO:updateByPickAssistMO(pickAssistMO)
	self.heroUid = pickAssistMO.id
	self.heroId = pickAssistMO.heroMO.heroId
	self.skinId = pickAssistMO.heroMO.skin
	self.isSupport = true
	self.heroMO = pickAssistMO.heroMO
end

function Season123PickHeroEntryMO:updateByHeroMO(heroMO, isSupport)
	self.heroId = heroMO.heroId
	self.heroUid = heroMO.uid
	self.skinId = heroMO.skin
	self.heroMO = heroMO
	self.isSupport = isSupport
end

function Season123PickHeroEntryMO:setEmpty()
	self.heroUid = nil
	self.heroId = nil
	self.heroMO = nil
	self.skinId = nil
	self.isSupport = false
end

return Season123PickHeroEntryMO
