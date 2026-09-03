-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/base/prototype/HeroPrototype.lua

HeroPrototype = class("HeroPrototype", objectlua.Object, _M)

HeroPrototype:has("_id", {
	is = "r"
})
HeroPrototype:has("_config", {
	is = "r"
})
HeroPrototype:has("_unLockSkillIds", {
	is = "r"
})
HeroPrototype:has("_unLockSkillList", {
	is = "r"
})

function HeroPrototype:initialize(heroId)
	super.initialize(self)

	self._id = heroId
	self._config = ConfigReader:getRecordById("HeroBase", tostring(heroId))
	self._showSkillIds = {}
	self._showSkillType = {}
	self._unLockSkillIds = {}
	self._unLockSkillList = {}

	self:createStarEffectList()
	self:createShowSkillIds()
	self:createBaseAttrNum()
end

function HeroPrototype:createStarEffectList()
	local maxStar = ConfigReader:getRecordById("ConfigValue", "Hero_Maxstar").content
	local starId = self:initStarId()

	for i = self._config.BaseStar, maxStar do
		local config = ConfigReader:getRecordById("HeroStarEffect", starId)

		if config and config.SpecialEffect then
			starId = config.NextId

			local starEffectConfig = ConfigReader:getRecordById("SkillSpecialEffect", config.SpecialEffect[1])

			if starEffectConfig then
				local skillId = starEffectConfig.Parameter.skill

				if skillId then
					self._unLockSkillIds[skillId] = i
					self._unLockSkillList[i] = skillId
				end
			end
		end
	end
end

function HeroPrototype:initStarId()
	local baseStar = self._config.BaseStar
	local starId = self._config.StarId
	local starConfig = ConfigReader:getRecordById("HeroStarEffect", starId)
	local star = starConfig.Star

	while star ~= baseStar do
		starId = starConfig.NextId
		starConfig = ConfigReader:getRecordById("HeroStarEffect", starConfig.NextId)
		star = starConfig.Star
	end

	return starId
end

function HeroPrototype:getStarNumByCompose()
	if not self._composeNeedCount then
		local count = 0
		local starNum = self._config.BaseStar
		local starId = self._config.StarId

		for i = 1, starNum do
			local heroStarBase = ConfigReader:getRecordById("HeroStarEffect", starId)

			if heroStarBase then
				starId = heroStarBase.NextId
				count = count + heroStarBase.StarUpFactor
			end
		end

		self._composeNeedCount = count
	end

	return self._composeNeedCount
end

function HeroPrototype:getStarCostFragByStar(starId)
	local heroStarBase = ConfigReader:getRecordById("HeroStarEffect", starId)

	if heroStarBase then
		return heroStarBase.StarUpFactor or heroStarBase.StarStive
	end

	return 0
end

function HeroPrototype:getStarCostStarStiveByStar(starId)
	local heroStarBase = ConfigReader:getRecordById("HeroStarEffect", starId)

	if heroStarBase then
		return heroStarBase.StarStive
	end

	return 0
end

function HeroPrototype:getStarCostGoldByStar(starId)
	local heroStarBase = ConfigReader:getRecordById("HeroStarEffect", starId)

	if heroStarBase then
		return heroStarBase.StarUpCost
	end

	return 0
end

function HeroPrototype:getShowSkillIds()
	return self._showSkillIds
end

function HeroPrototype:getSkillShowType(skillId)
	for i = 1, #self._showSkillIds do
		local id = self._showSkillIds[i]

		if id == skillId and self._showSkillType[i] then
			return self._showSkillType[i]
		end
	end
end

function HeroPrototype:createShowSkillIds()
	local skillShowType = ConfigReader:getRecordById("ConfigValue", "Hero_SkillShowType").content

	for i = 1, #skillShowType do
		local skillType = skillShowType[i]

		if self._config[skillType] then
			self._showSkillIds[#self._showSkillIds + 1] = self._config[skillType]
			self._showSkillType[#self._showSkillType + 1] = skillType
		end
	end
end

function HeroPrototype:createBaseAttrNum()
	self._baseNumMap = {
		ATK = self._config.BaseAttack,
		DEF = self._config.BaseDefence,
		HP = self._config.BaseHp
	}
	self._baseRatioMap = {
		ATK = self._config.AttackFactor,
		DEF = self._config.DefenceFactor,
		HP = self._config.HpFactor
	}
	self._basicAttrNumMap = {
		ATK = self._config.DefaultAttack,
		DEF = self._config.DefaultDefence,
		HP = self._config.DefaultHp,
		CRITRATE = self._config.CritRate,
		UNCRITRATE = self._config.UncritRate,
		CRITSTRG = self._config.CritStrg,
		BLOCKRATE = self._config.BlockRate,
		UNBLOCKRATE = self._config.UnblockRate,
		BLOCKSTRG = self._config.BlockStrg,
		HURTRATE = self._config.HurtRate,
		UNHURTRATE = self._config.UnhurtRate,
		ABSORPTION = self._config.Absorption,
		REFLECTION = self._config.Reflection
	}
end

function HeroPrototype:getBasicAttrNumByType(attrType)
	return self._basicAttrNumMap[attrType] or 0
end

function HeroPrototype:getBaseNumByType(attrType)
	return self._baseNumMap[attrType]
end

function HeroPrototype:getBaseRatioByType(attrType)
	return self._baseRatioMap[attrType]
end
