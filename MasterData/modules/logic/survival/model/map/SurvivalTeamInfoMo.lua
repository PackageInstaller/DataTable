-- chunkname: @modules/logic/survival/model/map/SurvivalTeamInfoMo.lua

module("modules.logic.survival.model.map.SurvivalTeamInfoMo", package.seeall)

local SurvivalTeamInfoMo = pureTable("SurvivalTeamInfoMo")

function SurvivalTeamInfoMo:init(data)
	self.heros = {}
	self.heroUids = {}

	for _, v in ipairs(data.hero) do
		self.heroUids[v.uid] = true

		table.insert(self.heros, v.uid)
	end

	self.npcId = data.npcId
end

function SurvivalTeamInfoMo:getHeroMo(uid)
	if not self.heroUids[uid] then
		return
	end

	return HeroModel.instance:getById(uid)
end

return SurvivalTeamInfoMo
