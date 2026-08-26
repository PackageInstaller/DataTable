-- chunkname: @modules/logic/seasonver/act123/model/Season123EpisodeMO.lua

module("modules.logic.seasonver.act123.model.Season123EpisodeMO", package.seeall)

local Season123EpisodeMO = pureTable("Season123EpisodeMO")

function Season123EpisodeMO:init(info)
	self.layer = info.layer
	self.state = info.state or 0
	self.round = info.round or 0
	self.effectMainCelebrityEquipIds = info.effectMainCelebrityEquipIds or {}

	self:initHeroes(info.heroInfos)

	self.star = info.star or 0
end

function Season123EpisodeMO:update(info)
	self.state = info.state
	self.round = info.round
	self.effectMainCelebrityEquipIds = info.effectMainCelebrityEquipIds

	self:updateHeroes(info.heroInfos)
end

function Season123EpisodeMO:isFinished()
	return self.state == 1
end

function Season123EpisodeMO:initHeroes(heroInfos)
	self.heroes = {}
	self.heroesMap = {}

	if not heroInfos then
		return
	end

	for i = 1, #heroInfos do
		local heroInfo = heroInfos[i]
		local heroMO = Season123HeroMO.New()

		heroMO:init(heroInfo)
		table.insert(self.heroes, heroMO)

		self.heroesMap[heroMO.heroUid] = heroMO
	end
end

function Season123EpisodeMO:updateHeroes(heroInfos)
	if not heroInfos then
		return
	end

	for i = 1, #heroInfos do
		local heroInfo = heroInfos[i]
		local heroMO = self.heroesMap[heroInfo.heroUid]

		if not heroMO then
			heroMO = Season123HeroMO.New()

			heroMO:init(heroInfo)
			table.insert(self.heroes, heroMO)

			self.heroesMap[heroMO.heroUid] = heroMO
		else
			heroMO:update(heroInfo)
		end
	end
end

return Season123EpisodeMO
