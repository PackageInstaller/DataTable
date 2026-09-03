-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/Hero.lua

require("dm.gameplay.develop.model.hero.HeroAttribute")
require("dm.gameplay.develop.model.effect.SingleEffectList")
require("dm.gameplay.develop.model.hero.relation.HeroRelationList")
require("dm.gameplay.develop.model.hero.HeroSoulList")
require("dm.gameplay.develop.model.hero.skill.HeroSkillList")
require("dm.gameplay.develop.model.hero.AdvanceList")
require("dm.gameplay.develop.model.hero.HeroLove")
require("dm.gameplay.develop.model.hero.HeroStar")
require("dm.gameplay.develop.model.hero.HeroLegend")
require("dm.gameplay.develop.model.hero.HeroSound")
require("dm.gameplay.develop.model.hero.HeroStarReward")

Hero = class("Hero", objectlua.Object, _M)

Hero:has("_group", {
	is = "rw"
})
Hero:has("_player", {
	is = "r"
})
Hero:has("_id", {
	is = "rw"
})
Hero:has("_heroPrototype", {
	is = "rw"
})
Hero:has("_skillList", {
	is = "rw"
})
Hero:has("_heroSoulList", {
	is = "r"
})
Hero:has("_roleType", {
	is = "rw"
})
Hero:has("_effectList", {
	is = "rw"
})
Hero:has("_effect", {
	is = "rw"
})
Hero:has("_effectNext", {
	is = "rw"
})
Hero:has("_attrFactor", {
	is = "rw"
})
Hero:has("_attrsFlag", {
	is = "rw"
})
Hero:has("_attrs", {
	is = "rw"
})
Hero:has("_quality", {
	is = "rw"
})
Hero:has("_qualityId", {
	is = "rw"
})
Hero:has("_qualityConfig", {
	is = "rw"
})
Hero:has("_star", {
	is = "rw"
})
Hero:has("_starId", {
	is = "rw"
})
Hero:has("_littleStar", {
	is = "rw"
})
Hero:has("_starConfig", {
	is = "rw"
})
Hero:has("_starRewards", {
	is = "rw"
})
Hero:has("_starRewardsConfig", {
	is = "rw"
})
Hero:has("_starAttrs", {
	is = "rw"
})
Hero:has("_starAttrsMap", {
	is = "rw"
})
Hero:has("_hasStarBoxReward", {
	is = "rw"
})
Hero:has("_awakenStar", {
	is = "rw"
})
Hero:has("_awakenStarId", {
	is = "rw"
})
Hero:has("_awakenStarConfig", {
	is = "rw"
})
Hero:has("_level", {
	is = "rw"
})
Hero:has("_exp", {
	is = "rw"
})
Hero:has("_speed", {
	is = "rw"
})
Hero:has("_equipIds", {
	is = "rw"
})
Hero:has("_advanceList", {
	is = "rw"
})
Hero:has("_baseInnerList", {
	is = "rw"
})
Hero:has("_innerLevel", {
	is = "rw"
})
Hero:has("_innerJigsawIndex", {
	is = "rw"
})
Hero:has("_loveModule", {
	is = "rw"
})
Hero:has("_loveLevel", {
	is = "rw"
})
Hero:has("_loveExp", {
	is = "rw"
})
Hero:has("_rarity", {
	is = "rw"
})
Hero:has("_awakenLevel", {
	is = "rw"
})
Hero:has("_giftMap", {
	is = "rw"
})
Hero:has("_dateTimes", {
	is = "rw"
})
Hero:has("_sounds", {
	is = "rw"
})
Hero:has("_giftTimes", {
	is = "rw"
})
Hero:has("_sceneCombats", {
	is = "rw"
})
Hero:has("_surfaceId", {
	is = "rw"
})
Hero:has("_nextEventType", {
	is = "rw"
})
Hero:has("_clone", {
	is = "rw"
})
Hero:has("_lastDate", {
	is = "rw"
})
Hero:has("_tsoul", {
	is = "rw"
})
Hero:has("_identityAwakenLevel", {
	is = "rw"
})

function Hero:initialize(heroId, player)
	super.initialize(self)

	self._player = player
	self._id = heroId
	self._heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(heroId)
	self._config = self:getHeroPrototype():getConfig()
	self._roleType = DevelopRoleType.kHero
	self._awakenStarConfig = ConfigReader:getRecordById("HeroAwaken", heroId)
	self._baseInnerList = self._config.InnerAttr
	self._qualityId = self._config.BaseQualityAttr

	self:updateQualityConfig()

	self._quality = self._qualityConfig.Quality
	self._star = self._config.BaseStar
	self._starId = self._config.StarId
	self._awakenStar = 0

	if self._awakenStarConfig then
		self._awakenStarId = self._awakenStarConfig.StarId or ""
	end

	self._littleStar = false
	self._starRewards = {}
	self._starRewardsConfig = {}
	self._hasStarBoxReward = false
	self._starAttrs = {}
	self._starAttrsMap = {}

	self:initStarId()
	self:initStarAttrs()
	self:updateStarConfig()

	self._level = 1
	self._exp = 0
	self._speed = self._config.Speed
	self._loveLevel = 0
	self._loveExp = 0
	self._rarity = self._config.Rareity
	self._nextEventType = ""
	self._giftMap = {}
	self._sounds = {}
	self._dateTimes = 0
	self._giftTimes = {
		dislike = 0,
		love = 0,
		normal = 0
	}
	self._sceneCombats = {}
	self._equipIds = {}
	self._surfaceId = self._config.SurfaceList[1]
	self._clone = nil

	self:initAttribute()
	self:initSys()
	self:initSoundList()
	self:initStarRewardsConfig()

	self._lastDate = {}
	self._tsoul = {}
	self._identityAwakenLevel = 0
end

function Hero:getConfig()
	return self._config
end

function Hero:initAttribute()
	self._attrFactor = AttrFactor:new()
	self._effectList = SingleEffectList:new(self:getId())
	self._attrsFlag = {}
end

function Hero:clearAttrsFlag()
	self._attrsFlag = {}
end

function Hero:getAttrFlagByType(attrType)
	return self._attrsFlag[attrType]
end

function Hero:setAttrFlagByType(attrType, attrNum)
	self._attrsFlag[attrType] = attrNum
end

function Hero:initSys()
	local skillList = self:getHeroPrototype():getShowSkillIds()

	self._skillList = HeroSkillList:new(skillList, self)
	self._heroSoulList = HeroSoulList:new(self._config.Soul, self)
	self._advanceList = AdvanceList:new(self)
	self._loveModule = HeroLove:new(self)
	self._starModule = HeroStar:new(self)
	self._heroLegend = HeroLegend:new(self)
end

function Hero:initSoundList()
	local soundList = self:getSoundList()

	for i = 1, #soundList do
		local id = soundList[i]

		self._sounds[id] = self._sounds[id] or HeroSound:new(id)
	end
end

function Hero:getSkillById(id)
	return self._skillList:getSkillById(id)
end

function Hero:synchronize(data)
	if not data then
		return
	end

	if self._clone then
		self._clone:synchronize(data)
	end

	local hasBaseAttrChange = false

	if data.uuid then
		self._uuid = data.uuid
	end

	if data.level and self._level ~= data.level then
		hasBaseAttrChange = true
		self._level = data.level
	end

	if data.star and self._star ~= data.star then
		hasBaseAttrChange = true
		self._star = data.star
	end

	if data.identityAwakenLevel then
		self._identityAwakenLevel = data.identityAwakenLevel
	end

	if data.awakenLevel and self._awakenStar ~= data.awakenLevel then
		hasBaseAttrChange = true
		self._awakenStar = data.awakenLevel
	end

	if data.starId and self._starId ~= data.starId then
		hasBaseAttrChange = true
		self._starId = data.starId

		self:updateStarConfig()
		self._starModule:synchronize(self._starId)
	end

	if data.littleStar ~= nil then
		hasBaseAttrChange = true
		self._littleStar = data.littleStar
	end

	if data.quality and self._quality ~= data.quality then
		hasBaseAttrChange = true
		self._quality = data.quality
	end

	if data.qualityId and self._qualityId ~= data.qualityId then
		hasBaseAttrChange = true
		self._qualityId = data.qualityId

		self:updateQualityConfig()
	end

	if data.exp then
		hasBaseAttrChange = true

		self:setExp(data.exp)
	end

	if data.skills then
		hasBaseAttrChange = true

		self._skillList:synchronize(data.skills)
	end

	if data.rarity then
		hasBaseAttrChange = true
		self._rarity = data.rarity
	end

	if data.heroEquip then
		hasBaseAttrChange = true

		for type, equipId in pairs(data.heroEquip) do
			self._equipIds[type] = equipId
		end
	end

	if data.souls then
		self._heroSoulList:synchronize(data.souls)
	end

	if data.innerLevel then
		self._innerLevel = data.innerLevel
	end

	if data.innerJigsawIndex then
		self._innerJigsawIndex = data.innerJigsawIndex
	end

	if data.innerLevel or data.innerJigsawIndex then
		hasBaseAttrChange = true

		self._advanceList:synchronize(self._innerLevel, self._innerJigsawIndex, self._baseInnerList)
	end

	if data.loveLevel then
		self._loveLevel = data.loveLevel
	end

	if data.awakenLevel then
		self._awakenLevel = data.awakenLevel
	end

	if data.loveExp then
		self._loveExp = data.loveExp
	end

	if data.loveLevel or data.loveExp then
		hasBaseAttrChange = true

		self._loveModule:synchronize(self._loveLevel, self._loveExp)
	end

	if data.nextEventType then
		self._nextEventType = data.nextEventType
	end

	if data.starRewards then
		self:updateStarRewards(data.starRewards)
	end

	self:updateSpeed()

	if data.giftMap then
		for itemId, value in pairs(data.giftMap) do
			self._giftMap[itemId] = self._giftMap[itemId] or {}
			self._giftMap[itemId] = value
		end

		self:updateGiftTimes()
	end

	if data.dateTimes then
		self._dateTimes = data.dateTimes
	end

	if data.sceneCombats then
		for key, num in pairs(data.sceneCombats) do
			self._sceneCombats[key] = num
		end
	end

	if data.surfaceId then
		self._surfaceId = data.surfaceId
	end

	if data.tsoul then
		for k, v in pairs(data.tsoul) do
			self._tsoul[k] = v
			hasBaseAttrChange = true
		end
	end

	self._attrs = data.attrs

	self:clearAttrsFlag()

	if hasBaseAttrChange then
		self:rCreateEffect()
	end

	if data.lastDate then
		for storyIndex, options in pairs(data.lastDate) do
			local opts = {}

			for key, value in pairs(options) do
				opts[tonumber(key) + 1] = value
			end

			self._lastDate[storyIndex] = opts
		end
	end
end

function Hero:synchronizeDelEquip(data)
	if not data then
		return
	end

	if self._clone then
		self._clone:synchronizeDelEquip(data)
	end

	for type, equip in pairs(data) do
		if self._equipIds[type] then
			self._equipIds[type] = nil
		end
	end

	self:syncAttrEffect()
end

function Hero:synchronizeDelTsoul(data)
	if not data then
		return
	end

	if self._clone then
		self._clone:synchronizeDelTsoul(data)
	end

	for type, tsoul in pairs(data) do
		if self._tsoul[type] then
			self._tsoul[type] = nil
		end
	end

	self:syncAttrEffect()
end

function Hero:updateGiftTimes()
	for itemId, times in pairs(self._giftMap) do
		if self._loveModule:getLovelyGift()[itemId] then
			self._giftTimes.love = self._giftTimes.love + times
		elseif self._loveModule:getOffensiveGift()[itemId] then
			self._giftTimes.dislike = self._giftTimes.dislike + times
		else
			self._giftTimes.normal = self._giftTimes.normal + times
		end
	end
end

function Hero:updateStarRewards(starRewards)
	for star, value in pairs(starRewards) do
		star = tonumber(star)

		local reward = self._starRewards[star]

		if not reward then
			reward = HeroStarReward:new(star)
			self._starRewards[star] = reward
		end

		reward:synchronize(value)
	end

	self._hasStarBoxReward = false

	for i, reward in pairs(self._starRewards) do
		local isGotReward = reward:isGotReward()

		if not isGotReward then
			self._hasStarBoxReward = true

			break
		end
	end
end

function Hero:getStarBoxGetOver()
	for k, reward in pairs(self._starRewards) do
		if not reward:isGotReward() then
			return false
		end
	end

	return true
end

function Hero:updateSpeed()
	self._speed = HeroAttribute:getSpeedRatio(self._qualityId, self._starId, self)
end

function Hero:syncAttrEffect()
	if self._clone then
		self._clone:syncAttrEffect()
	end

	local effects = self:getGalleryLegendEffectIdsById()

	self._heroLegend:synchronize(effects)
	self:clearAttrsFlag()
	self:updateSpeed()
	self:rCreateEffect()
end

function Hero:rCreateEffect()
	self:removeEffect()
	self:rCreateBaseAttEffect()
	self:addEffect()
end

function Hero:addEffect()
	self:getEffectList():addEffect(self._effect)
end

function Hero:removeEffect()
	self:getEffectList():removeEffect(self._effect)
end

function Hero:getNextStarEffect(params)
	if not params.qualityId then
		local qualityId = self:getQualityId()

		if not params.starId then
			local starId = self:getStarId()

			if not params.level then
				local lvl = self:getLevel()
				local heroId = self:getId()
				local cost = self:getCost()
				local rarity = self:getRarity()
				local changeRarityEffect = self._starModule:changeRarityEffect(starId)

				if self._clone then
					local star = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", starId, "Star")
					local quality = ConfigReader:getDataByNameIdAndKey("HeroQuality", qualityId, "Quality")
					local data = {
						starId = starId,
						qualityId = qualityId,
						level = lvl,
						heroId = heroId,
						cost = cost,
						rarity = (changeRarityEffect or nil) and changeRarityEffect,
						star = (self:isMaxStar() or nil) and self:getMaxStar(),
						quality = quality
					}

					self._clone:synchronize(data)

					local combat = self._clone:getCombat()
					local effectNum1 = self._clone:getAttack()
					local effectNum2 = self._clone:getDefense()
					local effectNum3 = self._clone:getHp()
					local effectNum4 = self._clone:getSpeed()

					return effectNum1, effectNum2, effectNum3, effectNum4, combat
				end

				return 0, 0, 0, 0, 0
			end
		end
	end
end

function Hero:getEquipAttr(equipId, type)
	if not equipId or not type then
		return 0
	end

	local equipList = self._player:getEquipList()
	local num = 0
	local equip = equipList:getEquipById(equipId)

	if not equip then
		return num
	end

	local attrConfig = equip:getPreAttrList(self._id)

	if attrConfig[type] then
		num = num + attrConfig[type].attrNum
	end

	return num
end

function Hero:getCombatByEquip(equipId)
	local addATK = self:getEquipAttr(equipId, "ATK")
	local addDEF = self:getEquipAttr(equipId, "DEF")
	local addHP = self:getEquipAttr(equipId, "HP")
	local addSPEED = self:getEquipAttr(equipId, "SPEED")
	local curEquipEffectNum1 = self:getEquipAttrByType("ATK")
	local curEquipEffectNum2 = self:getEquipAttrByType("DEF")
	local curEquipEffectNum3 = self:getEquipAttrByType("HP")
	local curEquipEffectNum4 = self:getEquipAttrByType("SPEED")
	local effectNum1 = HeroAttribute:getAttrNumByType("ATK", env, self) - curEquipEffectNum1 + addATK
	local effectNum2 = HeroAttribute:getAttrNumByType("DEF", env, self) - curEquipEffectNum2 + addDEF
	local effectNum3 = HeroAttribute:getAttrNumByType("HP", env, self) - curEquipEffectNum3 + addHP
	local effectNum4 = self._speed - curEquipEffectNum4 + addSPEED
	local attrData = {
		critRate = self:getCritRate(evn),
		hurtRate = self:getHurtRate(evn),
		unhurtRate = self:getUnhurtRate(evn),
		reflection = self:getReflection(evn),
		absorption = self:getAbsorption(evn),
		uncritRate = self:getUncritRate(evn),
		critStrg = self:getCritStrg(evn),
		blockRate = self:getBlockRate(evn),
		unblockRate = self:getUnblockRate(evn),
		blockStrg = self:getBlockStrg(evn),
		attack = effectNum1,
		defense = effectNum2,
		hp = effectNum3,
		speed = effectNum4,
		star = self:getStar(),
		skillLevel = self:getSkillsLevel(),
		rarity = self:getRarity(),
		effectStrg = self:getEffectStrg(evn),
		unEffectRate = self:getUnEffectRate(evn),
		effectRate = self:getEffectRate(evn),
		normalSkillLevel = self:getNormalSkillLevel(),
		poundSkillLevel = self:getProudSkillLevel(),
		uniqueSkillLevel = self:getUniqueSkillLevel(),
		battleSkillLevel = self:getBattlePassiveSkillLevel(),
		occupation = self:getType()
	}
	local combat = HeroAttribute:getCombat(attrData)

	combat = math.modf(combat)

	return combat
end

function Hero:rCreateBaseAttEffect()
	if GameConfigs.closeHeroBaseAttr then
		return
	end

	local allEffects = {}

	for attrType, _ in pairs(AttrBaseType) do
		local starId = self:getStarId()
		local qualityId = self:getQualityId()
		local lvl = self:getLevel()
		local heroId = self:getId()
		local cost = self:getCost()
		local data = {
			starId = starId,
			qualityId = qualityId,
			lvl = lvl,
			attrType = attrType,
			heroId = heroId,
			cost = cost,
			rarity = self:getRarity()
		}
		local effectConfig = HeroAttribute:getBaseAttEffectConfig(data, self)

		allEffects[#allEffects + 1] = SingleAttrAddEffect:new(effectConfig)
	end

	self._effect = CompositeEffect:new(allEffects)
	self._effect._effectFromName = AttrSystemName.kHeroBase
end

function Hero:getGalleryAllAttrByType(type)
	return self._player:getEffectCenter():getGalleryAllEffectAttrsById(type)
end

function Hero:getGalleryLegendEffectIdsById()
	return (self._player:getEffectCenter():getGalleryLegendEffectIdsById(self._id))
end

function Hero:getAuraEffectById(type)
	return self._player:getEffectCenter():getAuraEffectById(type)
end

function Hero:getBuildComfortEffectById(type)
	return self._player:getEffectCenter():getBuildComfortEffectById(type)
end

function Hero:getMessageEffectById(type)
	return self._player:getEffectCenter():getMessageEffectById(type)
end

function Hero:getMessagePartyEffectById(partyId, type)
	return self._player:getEffectCenter():getMessagePartyEffectById(partyId, type)
end

function Hero:getTimeEffectById(type)
	return self._player:getEffectCenter():getHeroTimeEffectByIdForType(self._id, type)
end

function Hero:getEquipAttrByType(type)
	local num = 0
	local equipList = self._player:getEquipList()

	for i, equipId in pairs(self._equipIds) do
		local equip = equipList:getEquipById(equipId)
		local attrConfig = equip:getAttrList()

		if attrConfig[type] then
			num = num + attrConfig[type].attrNum
		end
	end

	return num
end

function Hero:createEquipSkillAttr()
	local equipList = self._player:getEquipList()

	for i, equipId in pairs(self._equipIds) do
		local equip = equipList:getEquipById(equipId)
		local skill = equip:getSkill()

		if skill and skill:getLevel() > 0 then
			if not skill:getSkillAttrEffect() then
				skill:createAttrEffect(self, self._player)
			end

			skill:getSkillAttrEffect():setOwner(self, self._player)
			skill:rCreateEffect()
		end
	end
end

function Hero:getAddAttrByType(type)
	self:createEquipSkillAttr()

	return self:getGalleryAllAttrByType(type) + self:getAuraEffectById(type) + self:getEquipAttrByType(type) + self:getBuildComfortEffectById(type) + self:getTimeEffectById(type) + self:getTSOULAttrByType(type) + self:getMessageEffectById(type) + self:getMessagePartyEffectById(self._config.Party, type)
end

function Hero:getTSOULAttrByType(type)
	return self._player:getEffectCenter():getTSOULEffectsById(self._id, type)
end

function Hero:checkHaveAwakenView()
	local have = false

	if self:isMaxStar() == false then
		return have
	end

	if self._awakenStarConfig ~= nil and self._awakenStarId ~= nil then
		have = true
	end

	return have
end

function Hero:heroCanAwaken()
	return self._awakenStarId ~= nil and self._awakenStarId ~= ""
end

function Hero:heroAwaked()
	return self._awakenStar > 0
end

function Hero:getAwakenStarNeedLove()
	return (self._awakenStarConfig or nil) and (self._awakenStarConfig.NeedLove or 0)
end

function Hero:getSpeed(env)
	return (math.modf(self._speed))
end

function Hero:getAttack(env)
	return (math.modf(HeroAttribute:getAttrNumByType("ATK", env, self)))
end

function Hero:getDefense(env)
	return (math.modf(HeroAttribute:getAttrNumByType("DEF", env, self)))
end

function Hero:getHp(env)
	return (math.modf(HeroAttribute:getAttrNumByType("HP", env, self)))
end

function Hero:getSceneCombatByType(type)
	return self._sceneCombats[type] or 0
end

function Hero:getSkillRateShow()
	local attrNum = self:getSkillRate()

	if AttributeCategory:getAttNameAttend("SKILLRATE") ~= "" then
		attrNum = attrNum * 100 .. "%"
	end

	return attrNum
end

function Hero:getCritRate(env)
	return HeroAttribute:getAttrNumByType("CRITRATE", env, self)
end

function Hero:getUncritRate(env)
	return HeroAttribute:getAttrNumByType("UNCRITRATE", env, self)
end

function Hero:getCritStrg(env)
	return HeroAttribute:getAttrNumByType("CRITSTRG", env, self)
end

function Hero:getBlockRate(env)
	return HeroAttribute:getAttrNumByType("BLOCKRATE", env, self)
end

function Hero:getUnblockRate(env)
	return HeroAttribute:getAttrNumByType("UNBLOCKRATE", env, self)
end

function Hero:getBlockStrg(env)
	return HeroAttribute:getAttrNumByType("BLOCKSTRG", env, self)
end

function Hero:getHurtRate(env)
	return HeroAttribute:getAttrNumByType("HURTRATE", env, self)
end

function Hero:getUnhurtRate(env)
	return HeroAttribute:getAttrNumByType("UNHURTRATE", env, self)
end

function Hero:getAbsorption(env)
	return HeroAttribute:getAttrNumByType("ABSORPTION", env, self)
end

function Hero:getReflection(env)
	return HeroAttribute:getAttrNumByType("REFLECTION", env, self)
end

function Hero:getEffectStrg(env)
	return HeroAttribute:getAttrNumByType("EFFECTSTRG", env, self)
end

function Hero:getUnEffectRate(env)
	return HeroAttribute:getAttrNumByType("UNEFFECTRATE", env, self)
end

function Hero:getEffectRate(env)
	return HeroAttribute:getAttrNumByType("EFFECTRATE", env, self)
end

function Hero:getSkillRate(env)
	return HeroAttribute:getAttrNumByType("SKILLRATE", env, self)
end

function Hero:getSkillLevelByType(type)
	local skillId = self._config[type]
	local skill = self._skillList:getSkillById(skillId)

	return (skill or nil) and skill:getLevel()
end

function Hero:getNormalSkillLevel()
	return self:getSkillLevelByType("NormalSkill")
end

function Hero:getProudSkillLevel()
	return self:getSkillLevelByType("ProudSkill")
end

function Hero:getUniqueSkillLevel()
	return self:getSkillLevelByType("UniqueSkill")
end

function Hero:getBattlePassiveSkillLevel()
	return self:getSkillLevelByType("BattlePassiveSkill")
end

function Hero:getCombat(evn)
	HeroAttribute:setAddHeroAttrState(true)
	HeroAttribute:attachAttrToHero(env, self)

	local attrData = {
		critRate = self:getCritRate(evn),
		hurtRate = self:getHurtRate(evn),
		unhurtRate = self:getUnhurtRate(evn),
		reflection = self:getReflection(evn),
		absorption = self:getAbsorption(evn),
		uncritRate = self:getUncritRate(evn),
		critStrg = self:getCritStrg(evn),
		blockRate = self:getBlockRate(evn),
		unblockRate = self:getUnblockRate(evn),
		blockStrg = self:getBlockStrg(evn),
		attack = HeroAttribute:getAttrNumByType("ATK", env, self),
		defense = HeroAttribute:getAttrNumByType("DEF", env, self),
		hp = HeroAttribute:getAttrNumByType("HP", env, self),
		star = self:getStar(),
		skillLevel = self:getSkillsLevel(),
		speed = self._speed,
		rarity = self:getRarity(),
		effectStrg = self:getEffectStrg(evn),
		unEffectRate = self:getUnEffectRate(evn),
		effectRate = self:getEffectRate(evn),
		normalSkillLevel = self:getNormalSkillLevel(),
		poundSkillLevel = self:getProudSkillLevel(),
		uniqueSkillLevel = self:getUniqueSkillLevel(),
		battleSkillLevel = self:getBattlePassiveSkillLevel(),
		occupation = self:getType()
	}

	HeroAttribute:setAddHeroAttrState(false)

	local combat = HeroAttribute:getCombat(attrData)

	attrData.attack = math.modf(attrData.attack)
	attrData.hp = math.modf(attrData.hp)
	attrData.defense = math.modf(attrData.defense)
	attrData.speed = math.modf(attrData.speed)

	return math.modf(combat), attrData
end

function Hero:getSkillsLevel()
	local num = 0
	local skillIdList = self:getHeroPrototype():getShowSkillIds()

	for _, skillId in pairs(skillIdList) do
		local skill = self._skillList:getSkillById(skillId)

		if skill then
			num = num + skill:getLevel()
		end
	end

	return num
end

local HeroSkillShow = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Skill_Show", "content")

function Hero:getShowSkillIds()
	if not self._skillIds then
		self._skillIds = {}

		local skillIds = self:getHeroPrototype():getShowSkillIds()
		local skills = {}

		for i = 1, #skillIds do
			local skillId = skillIds[i]
			local skill = self:getSkillById(skillId)
			local skillType = skill:getType()
			local index = table.indexof(HeroSkillShow, skillType)

			if index then
				table.insert(skills, {
					index = index,
					skillId = skillId
				})
			end
		end

		table.sort(skills, function(a, b)
			return a.index < b.index
		end)

		for i = 1, #skills do
			table.insert(self._skillIds, skills[i].skillId)
		end
	end

	return self._skillIds
end

function Hero:getName()
	local colorQua = self._qualityConfig.Quality
	local nameStr = Strings:get(self._config.Name)

	return nameStr, GameStyle:getColor(colorQua)
end

function Hero:getCVName()
	return Strings:get(self._config.CVName)
end

function Hero:updateQualityConfig()
	self._qualityConfig = ConfigReader:getRecordById("HeroQuality", self._qualityId)
end

function Hero:getQualityLevel()
	return self._qualityConfig.QualityLevel
end

function Hero:getQualityBase()
	return self._qualityConfig.QualityBase
end

function Hero:getLevelRequest()
	return self._qualityConfig.LevelRequest
end

function Hero:getCurMaxLevel()
	return self._qualityConfig.MaxLevel
end

function Hero:getPlayerLevelRequest()
	return self._qualityConfig.PlayerLevelRequest
end

function Hero:getQualityCostItem()
	return self._qualityConfig.CostItem
end

function Hero:getQualityCostCurrency()
	return self._qualityConfig.CurrencyCost
end

function Hero:getNextQualityId()
	return self._qualityConfig.NextQuality
end

function Hero:getNextQuality()
	local config = self:getConfigByEvolution(self:getNextQualityId())

	return config.Quality
end

function Hero:getNextQualityLevel()
	local config = self:getConfigByEvolution(self:getNextQualityId())

	return config.QualityLevel
end

function Hero:getNextQualityLevelRequest()
	local config = self:getConfigByEvolution(self:getNextQualityId())

	return config.LevelRequest
end

function Hero:getNextQualityMaxLevel()
	local config = self:getConfigByEvolution(self:getNextQualityId())

	return config.MaxLevel
end

function Hero:getConfigByEvolution(qualityId)
	return ConfigReader:getRecordById("HeroQuality", tostring(qualityId))
end

function Hero:initStarId()
	local starConfig = ConfigReader:getRecordById("HeroStarEffect", self._starId)
	local star = starConfig.Star

	while star ~= self._star do
		self._starId = starConfig.NextId
		starConfig = ConfigReader:getRecordById("HeroStarEffect", self._starId)
		star = starConfig.Star
	end
end

function Hero:initStarAttrs()
	local starAttrsTemp = {}
	local starId = self._config.StarId
	local nextStarId = self._config.StarId
	local checkAwaken = true
	local checkIdentityAwake = true
	local tmpStar = 0

	while nextStarId ~= "" do
		starId = nextStarId

		local star = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", nextStarId, "Star")

		if tmpStar ~= 0 then
			tmpStar = tmpStar + 1
			star = tmpStar
		end

		nextStarId = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", starId, "NextId")

		if nextStarId == "" and self:heroCanAwaken() and checkAwaken then
			nextStarId = self._awakenStarId
			checkAwaken = false
			tmpStar = star
		end

		if nextStarId == "" and self:heroCanAwaken() and self:canIdentityAwake() and checkIdentityAwake then
			nextStarId = self._awakenStarConfig.IAId
			checkIdentityAwake = false
		end

		local isMiniStar = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", starId, "MiniStar") == 1
		local Effect = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", starId, "Effect") or {}
		local SpecialEffect = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", starId, "SpecialEffect") or {}

		if #SpecialEffect > 0 then
			for i = 1, #SpecialEffect do
				local effectId = SpecialEffect[i]
				local config = ConfigReader:getRecordById("SkillSpecialEffect", effectId)

				if config.EffectType == SpecialEffectType.kChangeSkill then
					starAttrsTemp[star] = starAttrsTemp[star] or {}

					local style = {
						fontSize = 18,
						fontName = TTF_FONT_FZYH_M
					}
					local skillId = config.Parameter.after
					local beforeSkillId = config.Parameter.before
					local skillName = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Name")
					local isEXSkill = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "IsEXSkill") == 1
					local desc = Strings:get(config.Desc, style)
					local var_86_0 = {
						attrType = "skill",
						name = Strings:get(skillName),
						desc = desc,
						skillId = skillId,
						beforeSkillId = beforeSkillId,
						isEXSkill = isEXSkill,
						isMiniStar = isMiniStar
					}

					if config.IsHidden then
						var_86_0.isHide = config.IsHidden or 0
					end

					local data = var_86_0

					table.insert(starAttrsTemp[star], data)
				end
			end
		end

		if #Effect > 0 then
			starAttrsTemp[star] = starAttrsTemp[star] or {}

			for i = 1, #Effect do
				local effectId = Effect[i]
				local style = {
					fontSize = 18,
					fontName = TTF_FONT_FZYH_M
				}
				local desc = SkillPrototype:getAttrEffectDesc(effectId, 1, style)
				local data = {
					path = "icon_yinghun_attr_up.png",
					attrType = "attr",
					isHide = 0,
					name = Strings:get("HEROS_UI42"),
					desc = desc,
					isMiniStar = isMiniStar
				}

				table.insert(starAttrsTemp[star], data)
			end
		end
	end

	local indexArr = {}

	for star, v in pairs(starAttrsTemp) do
		table.insert(indexArr, star)
	end

	table.sort(indexArr, function(a, b)
		return a < b
	end)

	for i = 1, #indexArr do
		local star = indexArr[i]

		table.insert(self._starAttrs, {
			star = star,
			info = starAttrsTemp[star]
		})
	end

	self._starAttrsMap = starAttrsTemp
end

function Hero:initStarRewardsConfig()
	local HeroStar_StarReward = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroStar_StarReward", "content")
	local HeroStar_TheLeadsStarReward = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroStar_TheLeadsStarReward", "content")

	self._starRewardsConfig = {}

	local heroIds = HeroStar_TheLeadsStarReward.heroId
	local config = HeroStar_StarReward[tostring(self:getRarity())]

	for i, v in pairs((table.indexof(heroIds, self._id) or nil) and HeroStar_TheLeadsStarReward) do
		if type(tonumber(i)) == "number" and v ~= 0 then
			table.insert(self._starRewardsConfig, {
				star = tonumber(i),
				rewardNum = v[2],
				rewardRarity = v[1]
			})
		end
	end

	table.sort(self._starRewardsConfig, function(a, b)
		return a.star < b.star
	end)
end

function Hero:updateStarConfig()
	self._starConfig = ConfigReader:getRecordById("HeroStarEffect", self._starId)
end

function Hero:getNextStarId(forAwaken)
	return (forAwaken and self._awakenStarId ~= "" and self._awakenStar <= 0 or nil) and self._awakenStarId
end

function Hero:getNextIdentityStarId()
	if self._awakenStar > 0 and self._identityAwakenLevel == 0 then
		return (self._awakenStarConfig or nil) and (self._awakenStarConfig.IAId or "")
	elseif self._identityAwakenLevel > 0 then
		return self._starConfig.NextId
	end

	return ""
end

function Hero:getIdentityAwakenNeedLove()
	local starId = self:getNextIdentityStarId()

	return ConfigReader:getDataByNameIdAndKey("HeroStarEffect", starId, "NeedLove")
end

function Hero:getIdentityAwakenNeedItem()
	local starId = self:getNextIdentityStarId()

	return ConfigReader:getDataByNameIdAndKey("HeroStarEffect", starId, "UpNeedItem")
end

function Hero:canIdentityAwake()
	return self._awakenStarConfig and self._awakenStarConfig.IAId ~= ""
end

function Hero:getNextIsMiniStar()
	local starId = self:getNextStarId()
	local miniStar = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", starId, "MiniStar")

	return miniStar == 1
end

function Hero:getNextIsMiniAwakenStar()
	local awakenStarId = self:getNextAwakenStarId()
	local miniStar = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", awakenStarId, "MiniStar")

	return miniStar == 1
end

function Hero:getIsMiniStar()
	return self._starConfig.MiniStar == 1
end

function Hero:getIsMiniAwakenStar()
	return self._awakenStarConfig.MiniStar == 1
end

function Hero:getStarStive()
	local starId = self:getNextStarId()

	return (ConfigReader:getDataByNameIdAndKey("HeroStarEffect", starId, "StarStive"))
end

function Hero:isMaxStar()
	return self._star == self:getMaxStar()
end

function Hero:getConfigByStarId(starId)
	return ConfigReader:getRecordById("HeroStarEffect", tostring(starId))
end

function Hero:getDateStory()
	local storyList = self._loveModule:getStoryLink()

	if #storyList > 0 then
		local storyIndex = self._dateTimes + 1

		if storyIndex > #storyList then
			storyIndex = math.random(1, #storyList)
		end

		return {
			storyIndex = storyIndex,
			storyId = storyList[storyIndex].story,
			option = storyList[storyIndex].option
		}
	end

	return nil
end

function Hero:getGotGiftMark(itemData)
	local giftMarkIcon = {
		kNormal = "xc_putong.png",
		kOffensive = "xc_buxihuan.png",
		kLove = "xc_xihuan.png"
	}

	itemData.markTag = 2

	local itemId = itemData.itemId
	local random = math.random(1, 2)

	if random > 1 then
		itemData.useSoundDes = true
	end

	if self._loveModule:getLovelyGift()[itemId] then
		itemData.markSound = "Voice_" .. self._id .. "_20"
		itemData.markIcon = giftMarkIcon.kLove
		itemData.markTag = 1
	elseif self._loveModule:getOffensiveGift()[itemId] then
		itemData.markSound = "Voice_" .. self._id .. "_68"
		itemData.markIcon = giftMarkIcon.kOffensive
		itemData.markTag = 4
	else
		itemData.markSound = "Voice_" .. self._id .. "_69"
		itemData.markIcon = giftMarkIcon.kNormal
		itemData.markTag = 3
	end
end

function Hero:getGiftTip(giftId)
	local descArr = self._loveModule:getGiftDesc().normal
	local index = math.random(1, #descArr)

	if self._loveModule:getLovelyGift()[giftId] then
		descArr = self._loveModule:getGiftDesc().lovely
		index = math.random(1, #descArr)

		return descArr[index] or descArr[1]
	end

	if self._loveModule:getOffensiveGift()[giftId] then
		descArr = self._loveModule:getGiftDesc().offensive
		index = math.random(1, #descArr)

		return descArr[index] or descArr[1]
	end

	return descArr[index] or descArr[1]
end

function Hero:getGiftAddExpById(itemId)
	local loveExp = self._loveModule:getLovelyGift()[itemId]

	if loveExp then
		return loveExp
	end

	local offensiveExp = self._loveModule:getOffensiveGift()[itemId]

	if offensiveExp then
		return -offensiveExp
	end

	return 0
end

function Hero:getGiftGreetingDesc()
	local descArr = self._loveModule:getGiftDesc().greeting
	local index = math.random(1, #descArr)

	return descArr[index] or descArr[1]
end

function Hero:getMaxLevelCost()
	local totalExp = 0
	local maxLoveLevel = self._loveModule:getMaxLoveLevel()

	for i = self._loveLevel, maxLoveLevel do
		totalExp = totalExp + self._loveModule:getLikability()[i]
	end

	return totalExp - self._loveExp
end

function Hero:getMaxLoveLevel()
	return self._loveModule:getMaxLoveLevel()
end

function Hero:getLoveSound()
	return self._loveModule:getLoveSound()
end

function Hero:getIsHide()
	return self._config.IfHidden
end

function Hero:getDesc()
	return Strings:get(self._config.Desc)
end

function Hero:getSex()
	return self._config.Sex
end

function Hero:getFragId()
	return self._config.ItemId
end

function Hero:getCost()
	return self._config.Cost
end

function Hero:getPosition()
	return Strings:get(self._config.Position)
end

function Hero:getType()
	return self._config.Type
end

function Hero:getLevelUpFactor()
	return self._config.LevelUpFactor
end

function Hero:getSimpleName()
	return self._config.Name
end

function Hero:getSuperSkill()
	return self._config.UniqueSkill
end

function Hero:getUltraSkill()
	return self._config.UltraSkill
end

function Hero:getModel()
	return (ConfigReader:getDataByNameIdAndKey("Surface", self._surfaceId, "Model"))
end

function Hero:getPopularity()
	return self._config.Popularity
end

function Hero:getTypeDesc()
	return Strings:get(self:getType())
end

function Hero:getSoundList()
	return self._config.SoundList
end

function Hero:getHandOffset()
	return self._config.HeadTouchDeviation or {
		0,
		0
	}
end

function Hero:getTeamSpecialVoice()
	return self._config.TeamSpecialVoice or {}
end

function Hero:getEquipIdByType(type)
	return self._equipIds[type]
end

function Hero:getParty()
	return self._config.Party
end

function Hero:getSkillItemCost()
	return self._config.SkillCost or {}
end

function Hero:getPassiveCondition()
	return self._config.PassiveCondition
end

function Hero:getSurfaceList()
	return self._config.SurfaceList or {}
end

function Hero:getMaxStar()
	return self._config.MaxStar
end

function Hero:getStarIdByNum(num)
	local baseStarId = self._config.StarId
	local star = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", baseStarId, "Star")

	for i = star, self:getMaxStar() - 1 do
		baseStarId = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", baseStarId, "NextId")

		print("Hero:getStarIdByNum : " .. nextStarId)
	end

	return baseStarId
end

function Hero:getTSoulIdByPos(pos)
	return self._tsoul[tostring(pos)]
end

function Hero:hasAwakenAnimation()
	return self._awakenStarConfig.Animation and self._awakenStarConfig.Animation ~= ""
end
