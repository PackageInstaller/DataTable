-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/model/TowerHero.lua

TowerHero = class("TowerHero", objectlua.Object, _M)

TowerHero:has("_id", {
	is = "rw"
})
TowerHero:has("_baseId", {
	is = "rw"
})
TowerHero:has("_exp", {
	is = "rw"
})
TowerHero:has("_rarity", {
	is = "rw"
})
TowerHero:has("_star", {
	is = "r"
})
TowerHero:has("_awakenLevel", {
	is = "rw"
})
TowerHero:has("_maxSkillId", {
	is = "rw"
})
TowerHero:has("_surfaceId", {
	is = "rw"
})
TowerHero:has("_atk", {
	is = "rw"
})
TowerHero:has("_def", {
	is = "rw"
})
TowerHero:has("_hp", {
	is = "rw"
})
TowerHero:has("_speed", {
	is = "rw"
})
TowerHero:has("_rate", {
	is = "rw"
})
TowerHero:has("_combat", {
	is = "rw"
})
TowerHero:has("_party", {
	is = "rw"
})
TowerHero:has("_config", {
	is = "rw"
})
TowerHero:has("_qualityId", {
	is = "rw"
})
TowerHero:has("_maxExp", {
	is = "rw"
})
TowerHero:has("_expRatio", {
	is = "rw"
})
TowerHero:has("_littleStar", {
	is = "rw"
})
TowerHero:has("_heroPrototype", {
	is = "rw"
})
TowerHero:has("_allCompseHeros", {
	is = "rw"
})
TowerHero:has("_player", {
	is = "r"
})
TowerHero:has("_awakenStar", {
	is = "rw"
})
TowerHero:has("_identityAwakenLevel", {
	is = "rw"
})

function TowerHero:initialize(id, player)
	super.initialize(self)

	self._id = id
	self._baseId = nil
	self._exp = 0
	self._rarity = nil
	self._star = nil
	self._maxSkillId = nil
	self._surfaceId = nil
	self._atk = nil
	self._def = nil
	self._hp = nil
	self._speed = 0
	self._rate = nil
	self._combat = 0
	self._config = nil
	self._awakenLevel = nil
	self._maxExp = 0
	self._expRatio = 0
	self._player = player
	self._allCompseHeros = 0
	self._awakenStar = 0
	self._party = 0
	self._identityAwakenLevel = 0
end

function TowerHero:synchronize(data)
	if data.baseId then
		self._baseId = data.baseId
		self._heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(self._baseId)
		self._config = self:getHeroPrototype():getConfig()
		self._qualityId = self._config.BaseQualityAttr

		self:updateQualityConfig()
		self:initSkillList()
	end

	if data.rarity then
		self._rarity = data.rarity
		self.rareity = data.rarity
	end

	if data.exp then
		self._exp = data.exp

		self:setMaxExpAndRatio()
	end

	if data.star then
		self._star = data.star
	end

	if data.awakenLevel then
		self._awakenLevel = data.awakenLevel
	end

	if data.maxSkillId then
		self._maxSkillId = data.maxSkillId
	end

	if data.surfaceId then
		self._surfaceId = data.surfaceId
	end

	if data.atk then
		self._atk = data.atk
	end

	if data.def then
		self._def = data.def
	end

	if data.hp then
		self._hp = data.hp
	end

	if data.speed then
		self._speed = data.speed
	end

	if data.rate then
		self._rate = data.rate
	end

	if data.combat then
		self._combat = data.combat
	end

	if data.allCompseHeros then
		self._allCompseHeros = data.allCompseHeros
	end

	self._littleStar = false

	if data.littleStar then
		self._littleStar = data.littleStar
	end

	if data.identityAwakenLevel then
		self._identityAwakenLevel = data.identityAwakenLevel
	end

	local heroSystem = DmGame:getInstance()._injector:getInstance("DevelopSystem"):getHeroSystem()
	local heroInfo = heroSystem:getHeroById(self._baseId)

	self._awakenStar = heroInfo and heroInfo:getAwakenStar() or 0
end

function TowerHero:getHeroInfo()
	return self._config
end

function TowerHero:getFragId()
	return self._config.ItemId
end

function TowerHero:getCost()
	return self._config.Cost
end

function TowerHero:getParty()
	return self._config.Party
end

function TowerHero:getLevel()
	return 1
end

function TowerHero:getQuality()
	return self._qualityConfig.Quality
end

function TowerHero:getLoveLevel()
	return 1
end

function TowerHero:getRarity()
	return self._rarity
end

function TowerHero:getSpeacilRarity()
	local content = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Tower_1_SpecialHero", "content")

	if content[self._baseId] then
		return content[self._baseId]
	end

	return self._rarity
end

function TowerHero:updateQualityConfig()
	self._qualityConfig = ConfigReader:getRecordById("HeroQuality", self._qualityId)
end

function TowerHero:getQualityLevel()
	return self._qualityConfig.QualityLevel
end

function TowerHero:getName()
	return Strings:get(self._config.Name)
end

function TowerHero:getTeamSpecialVoice()
	return self._config.TeamSpecialVoice or {}
end

function TowerHero:getRoleModel()
	return self._config.RoleModel
end

function TowerHero:initSkillList()
	local skillList = self:getHeroPrototype():getShowSkillIds()

	self._skillList = HeroSkillList:new(skillList, self)
end

function TowerHero:getSkillList()
	return self._skillList
end

function TowerHero:getName()
	return (Strings:get(self._config.Name))
end

function TowerHero:getPosition()
	return Strings:get(self._config.Position)
end

function TowerHero:getType()
	return self._config.Type
end

function TowerHero:getModel()
	return (ConfigReader:getDataByNameIdAndKey("Surface", self._surfaceId, "Model"))
end

function TowerHero:getSpeed(env)
	return (math.modf(self._speed))
end

function TowerHero:getAttack(env)
	return (math.modf(self._atk))
end

function TowerHero:getDefense(env)
	return (math.modf(self._def))
end

function TowerHero:getHp(env)
	return (math.modf(self._hp))
end

function TowerHero:getGrowValue()
	local content = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Tower_1_HeroGrowValue", "content")

	return content[tostring(self:getSpeacilRarity())]
end

function TowerHero:setMaxExpAndRatio(env)
	local content = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Tower_1_GrowMaxValue", "content")

	self._maxExp = content[tostring(self:getSpeacilRarity())]

	local r = self._exp / self._maxExp

	self._expRatio = tonumber(string.format("%.2f", tostring(r)))
end

function TowerHero:getAwardCount()
	return self._allCompseHeros
end

function TowerHero:getMaxExpAward()
	if self._expRatio >= 1 then
		return self:getExpAward()
	end

	return nil
end

function TowerHero:getExpAward()
	return {
		type = 2,
		amount = self:getAwardCount(),
		code = self._config.ItemId
	}
end

function TowerHero:getExpGrowRareityBase()
	local content = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Tower_1_GrowRareityBase", "content")

	return content[tostring(self:getSpeacilRarity())]
end

function TowerHero:getExpGrowSameType()
	local content = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Tower_1_GrowSameType", "content")

	return content[tostring(self:getSpeacilRarity())]
end

function TowerHero:getExpGrowSameCard()
	local content = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Tower_1_GrowSameCard", "content")

	return content[tostring(self:getSpeacilRarity())]
end

function TowerHero:getSkillRateShow()
	return tostring(self._config.SkillRate * 100) .. "%"
end

function TowerHero:getMaxStar()
	return self._config.MaxStar
end

function TowerHero:getHeroProById()
	return PrototypeFactory:getInstance():getHeroPrototype(self._baseId)
end

function TowerHero:getPassiveCondition()
	return self._config.PassiveCondition
end

function TowerHero:getSkillListOj(heroId)
	return self:getSkillList()
end

function TowerHero:getSkillById(heroId, skillId)
	local skillListOj = self:getSkillListOj(heroId)

	return skillListOj:getSkillById(skillId)
end

function TowerHero:checkHasKeySkill()
	if not self:getPassiveCondition() then
		return nil
	end

	local heroPrototype = self:getHeroProById()
	local config = heroPrototype:getConfig()

	if config.KeyPassiveSkill and config.KeyPassiveSkill == "" then
		return nil
	end

	local skillIds = heroPrototype:getShowSkillIds()

	for i = 1, #skillIds do
		local skillId = skillIds[i]
		local showType = heroPrototype:getSkillShowType(skillId)

		if showType == "BattlePassiveSkill" then
			local skill = self:getSkillById(self._baseId, skillId)

			return skill, self:getPassiveCondition()
		end
	end

	return nil
end
