-- chunkname: @modules/logic/versionactivity2_3/act174/model/Act174TeamMO.lua

module("modules.logic.versionactivity2_3.act174.model.Act174TeamMO", package.seeall)

local Act174TeamMO = pureTable("Act174TeamMO")

function Act174TeamMO:init(info)
	self.index = info.index
	self.battleHeroInfo = {}

	for i, battleHero in ipairs(info.battleHeroInfo) do
		self.battleHeroInfo[i] = self:creatBattleHero(battleHero)
	end
end

function Act174TeamMO:creatBattleHero(info)
	local hero = {}

	hero.index = info.index
	hero.heroId = info.heroId
	hero.itemId = info.itemId
	hero.priorSkill = info.priorSkill

	return hero
end

function Act174TeamMO:notEmpty()
	for _, hero in ipairs(self.battleHeroInfo) do
		if hero.heroId and hero.heroId ~= 0 then
			return true
		end
	end

	return false
end

return Act174TeamMO
