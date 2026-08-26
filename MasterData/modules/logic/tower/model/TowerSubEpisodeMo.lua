-- chunkname: @modules/logic/tower/model/TowerSubEpisodeMo.lua

module("modules.logic.tower.model.TowerSubEpisodeMo", package.seeall)

local TowerSubEpisodeMo = pureTable("TowerSubEpisodeMo")

function TowerSubEpisodeMo:updateInfo(info)
	self.episodeId = info.episodeId
	self.status = info.status
	self.heros = info.heros
	self.assistBossId = info.assistBossId
	self.heroIds = {}
	self.equipUids = {}
	self.trialHeroIds = {}

	if self.heros then
		for i = 1, #self.heros do
			local hero = self.heros[i]

			if hero then
				self.heroIds[i] = hero.heroId or 0
			end

			if hero then
				self.trialHeroIds[i] = hero.trialId or 0
			end

			if hero and hero.equipUid and #hero.equipUid > 0 then
				self.equipUids[i] = {}

				for j = 1, #hero.equipUid do
					table.insert(self.equipUids[i], hero.equipUid[j])
				end
			end
		end
	end
end

function TowerSubEpisodeMo:getHeros(dict)
	if self.status == 1 and self.heroIds then
		for i = 1, #self.heroIds do
			local heroId = self.heroIds[i]

			dict[heroId] = 1
		end
	end
end

function TowerSubEpisodeMo:getAssistBossId(dict)
	if self.status == 1 and self.assistBossId then
		dict[self.assistBossId] = 1
	end
end

function TowerSubEpisodeMo:getTrialHeros(dict)
	if self.status == 1 and self.trialHeroIds then
		for i = 1, #self.trialHeroIds do
			local trialHeroId = self.trialHeroIds[i]

			dict[trialHeroId] = 1
		end
	end
end

return TowerSubEpisodeMo
