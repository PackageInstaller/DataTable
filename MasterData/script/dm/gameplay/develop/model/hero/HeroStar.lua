-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/HeroStar.lua

HeroStar = class("HeroStar", objectlua.Object, _M)

HeroStar:has("_owner", {
	is = "rw"
})

function HeroStar:initialize(owner)
	super.initialize(self)

	self._owner = owner
	self._id = self._owner._config.StarId
	self._heroId = self._owner._config.Id
	self._curStarId = ""

	if self._owner then
		self:createAttrEffect(self._owner, self._owner:getPlayer())
	end
end

function HeroStar:createAttrEffect(owner, player)
	self._effect = SkillAttrEffect:new(AttrSystemName.kHeroStar)

	self._effect:setOwner(owner, player)
end

function HeroStar:refreshEffect()
	self._effect:removeEffect()
	self:rCreateEffect()
end

function HeroStar:rCreateEffect()
	local effects = self:getAttrEffects()

	self._effect:refreshEffects(effects, 0)
	self._effect:rCreateEffect()
end

function HeroStar:synchronize(starId)
	self._curStarId = starId

	self:refreshEffect()
end

function HeroStar:getAttrEffects()
	local effects = {}
	local nextStarId = self._id

	if self._owner._identityAwakenLevel == 0 then
		local nextStarId = self._id

		while nextStarId ~= self._curStarId do
			local starId = nextStarId

			nextStarId = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", starId, "NextId")

			if nextStarId == "" then
				nextStarId = self._curStarId
			end

			local Effect = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", starId, "Effect") or {}

			for i = 1, #Effect do
				effects[#effects + 1] = Effect[i]
			end
		end

		local Effect = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", self._curStarId, "Effect") or {}

		for i = 1, #Effect do
			effects[#effects + 1] = Effect[i]
		end
	elseif self._owner._identityAwakenLevel > 0 then
		while true do
			local starId = nextStarId
			local Effect = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", starId, "Effect") or {}

			for i = 1, #Effect do
				effects[#effects + 1] = Effect[i]
			end

			nextStarId = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", starId, "NextId")

			if nextStarId == "" then
				break
			end
		end

		if self._owner._awakenStar then
			local aid = self._owner._awakenStarId
			local Effect = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", aid, "Effect") or {}

			for i = 1, #Effect do
				effects[#effects + 1] = Effect[i]
			end
		end

		if self._owner._awakenStarConfig then
			local starId = self._owner._awakenStarConfig.IAId
			local curIdentity = self._curStarId

			while true do
				local Effect = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", starId, "Effect") or {}

				for i = 1, #Effect do
					effects[#effects + 1] = Effect[i]
				end

				if starId == curIdentity then
					break
				end

				starId = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", starId, "NextId")
			end
		end
	end

	return effects
end

function HeroStar:changeRarityEffect(starId)
	local specialEffects = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", starId, "SpecialEffect")

	for i = 1, #specialEffects do
		local effectId = specialEffects[i]
		local effectType = ConfigReader:getDataByNameIdAndKey("SkillSpecialEffect", effectId, "EffectType")
		local parameter = ConfigReader:getDataByNameIdAndKey("SkillSpecialEffect", effectId, "Parameter")

		if effectType == SpecialEffectType.kChangeRarity and parameter.value then
			return parameter.value
		end
	end

	return nil
end
