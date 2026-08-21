-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/character/model/SkillEnhanceModel.lua

module("logic.extensions.character.model.SkillEnhanceModel", package.seeall)

local M = class("SkillEnhanceModel", BaseModel)

function M:onInit()
	self._heroSkillEnhanceCache = {}
	self._requestingHero = {}
end

function M:onReset()
	table.clear(self._heroSkillEnhanceCache)
	table.clear(self._requestingHero)
end

function M:getCharacterSkillEnhanceMO(heroId, skillId)
	local skillEnhanceMO = self:_getHeroSkillEnhanceMO(heroId, skillId)

	if skillEnhanceMO then
		return skillEnhanceMO
	end

	self:_requestHeroSkillMO(heroId)

	return self:_getOrCreateSkillEnhanceMO(heroId, skillId)
end

function M:updateSkillEnhanceInfos(skillUpdateInfoNO)
	local heroId = skillUpdateInfoNO.heroId

	for _, skillInfoNO in ipairs(skillUpdateInfoNO.skillInfos) do
		local skillEnhanceMO = self:_getOrCreateSkillEnhanceMO(heroId, skillInfoNO.skillId)

		skillEnhanceMO:clear()

		for _, enhanceId in ipairs(skillInfoNO.enhanceIds) do
			skillEnhanceMO:addSkillEnhanceCode(enhanceId)
		end

		skillEnhanceMO:rebuild()
	end

	self._requestingHero[heroId] = false

	GlobalDispatcher:dispatchEvent(EventType.SKILL_ENHANCE_INFO_UPDATE, heroId)
end

function M:clearAllRequestingCache()
	table.clear(self._requestingHero)
end

function M:_getHeroSkillEnhanceMO(heroId, skillId)
	local heroSkillCache = self._heroSkillEnhanceCache[heroId]

	return heroSkillCache and heroSkillCache[skillId]
end

function M:_getOrCreateSkillEnhanceMO(heroId, skillId)
	local heroSkillCache = self._heroSkillEnhanceCache[heroId]

	if not heroSkillCache then
		heroSkillCache = {}
		self._heroSkillEnhanceCache[heroId] = heroSkillCache
	end

	local skillEnhanceMO = heroSkillCache[skillId]

	if not skillEnhanceMO then
		skillEnhanceMO = SkillEnhanceMO.New(skillId)
		heroSkillCache[skillId] = skillEnhanceMO
	end

	return skillEnhanceMO
end

function M:_requestHeroSkillMO(heroId)
	if self._requestingHero[heroId] then
		return
	end

	if not HeroDepotModel.instance:getHeroInfoByID(heroId) then
		return
	end

	self._requestingHero[heroId] = true

	HeroDepotAgent.instance:sendHeroSkillEnhanceRequest(heroId)
end

M.instance = M.New()

return M
