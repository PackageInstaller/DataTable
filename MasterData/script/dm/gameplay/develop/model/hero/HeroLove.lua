-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/HeroLove.lua

HeroLove = class("HeroLove", objectlua.Object, _M)

HeroLove:has("_map", {
	is = "rw"
})
HeroLove:has("_owner", {
	is = "rw"
})
HeroLove:has("_max", {
	is = "rw"
})

function HeroLove:initialize(owner)
	super.initialize(self)

	self._owner = owner
	self._id = self._owner:getId()
	self._config = ConfigReader:getRecordById("HeroLove", self._id)
	self._loveLevel = 0
	self._loveExp = 0

	if self._owner then
		self:createAttrEffect(self._owner, self._owner:getPlayer())
	end
end

function HeroLove:createAttrEffect(owner, player)
	self._effect = SkillAttrEffect:new(AttrSystemName.kHeroLove)

	self._effect:setOwner(owner, player)
end

function HeroLove:refreshEffect()
	self._effect:removeEffect()
	self:rCreateEffect()
end

function HeroLove:rCreateEffect()
	if GameConfigs.closeHeroRelationAttr then
		return
	end

	local effects = self:getAttrEffects()

	self._effect:refreshEffects(effects, 0)
	self._effect:rCreateEffect()
end

function HeroLove:synchronize(loveLevel, loveExp)
	self._loveLevel = loveLevel
	self._loveExp = loveExp

	self:refreshEffect()
end

function HeroLove:getAttrEffects()
	local effects = {}
	local attrArry = self._config.LikabilityAttr

	for i = 1, #attrArry do
		local attrData = attrArry[i]

		if i < self._loveLevel then
			for exp, value in pairs(attrData) do
				for num = 1, #value do
					effects[#effects + 1] = value[num]
				end
			end
		elseif i == self._loveLevel then
			for exp, value in pairs(attrData) do
				if tonumber(exp) <= self._loveExp then
					for num = 1, #value do
						effects[#effects + 1] = value[num]
					end
				end
			end
		end
	end

	return effects
end

function HeroLove:getCurMaxExp()
	if not self._config.Likability[self._loveLevel] then
		local exp = self._config.Likability[self._loveLevel - 1]

		exp = self._config.Likability[self._loveLevel] or self._config.Likability[#self._config.Likability]

		return self._config.Likability[self._loveLevel]
	end
end

function HeroLove:getTotalExp()
	local exp = 0

	for i = 1, self._config.Likability do
		if i < self._loveLevel then
			exp = exp + self._config.Likability[i]
		elseif i == self._loveLevel then
			exp = exp + self._loveExp
		end
	end

	return exp
end

function HeroLove:getMaxLoveLevel()
	return #self._config.Likability
end

function HeroLove:getLoveExpByLevel(level)
	return self._config.Likability[level] or 0
end

function HeroLove:getTotalLoveExtraBonus()
	return {
		param = self:getShowAttrList(self:getAttrEffects())
	}
end

function HeroLove:getCurLoveExtraBonus(level)
	level = level or self._loveLevel

	local config = self._config
	local data = {}
	local totalExp = self:getLoveExpByLevel(level)

	totalExp = totalExp == 0 and self:getCurMaxExp() or totalExp

	if config.LikabilityAttr then
		if level - 1 == self:getMaxLoveLevel() then
			if not (level - 1) then
				do
					local index = level

					if config.LikabilityAttr[index] then
						local showdata = config.LikabilityAttr[index]

						for exp, value in pairs(showdata) do
							data[#data + 1] = {
								type = "attr",
								param = self:getShowAttrList(value),
								proportion = tonumber(exp) / totalExp,
								image = FuncBonusType.attr[1]
							}
						end
					end
				end

				if config.Function then
					for funcType, value in pairs(config.Function) do
						local loveLevel = value[1]
						local loveExp = value[2]

						if (loveLevel ~= 1 or loveExp ~= 0) and level == loveLevel and (funcType ~= "date" or funcType == "date" and self._owner:getDateStory()) then
							data[#data + 1] = {
								descType = "func",
								param = {
									FuncBonusType[funcType][2]
								},
								proportion = tonumber(loveExp) / totalExp,
								image = FuncBonusType[funcType][1],
								type = funcType
							}
						end
					end
				end
			end
		end
	end

	return data
end

function HeroLove:getShowAttrList(effectIds)
	local attr = {}
	local effects = effectIds

	for i = 1, #effects do
		local descs = self:getAttrDesc(effects[i])
		local attrType = ConfigReader:requireRecordById("SkillAttrEffect", effects[i]).AttrType[1]

		if not attr[attrType] then
			attr[attrType] = descs
		elseif type(descs[2]) == "number" then
			attr[attrType][2] = attr[attrType][2] + descs[2]
		end
	end

	local showAttr = {}

	for attrType, value in pairs(attr) do
		value[#value + 1] = attrType
		showAttr[#showAttr + 1] = value
	end

	return showAttr
end

function HeroLove:getAttrDesc(effectId)
	local effectConfig = ConfigReader:requireRecordById("SkillAttrEffect", effectId)
	local desc = AttributeCategory:getAttName(effectConfig.AttrType[1])
	local attrNum = SkillAttribute:getAddNumByConfig(effectConfig, 1, 0)

	if AttributeCategory:getAttNameAttend(effectConfig.AttrType[1]) ~= "" then
		attrNum = attrNum * 100 .. "%"
	end

	return {
		desc,
		attrNum
	}
end

function HeroLove:getGiftDesc()
	return self._config.GiftDesc
end

function HeroLove:getLovelyGift()
	return self._config.LovelyGift
end

function HeroLove:getOffensiveGift()
	return self._config.OffensiveGift
end

function HeroLove:getDateDesc()
	return self._config.DateDesc
end

function HeroLove:getDateGreetingDesc()
	local descArr = self:getDateDesc().greeting
	local index = math.random(1, #descArr)

	return descArr[index] or descArr[1]
end

function HeroLove:getDateRefuseDesc()
	local descArr = self:getDateDesc().refuse
	local index = math.random(1, #descArr)

	return descArr[index] or descArr[1]
end

function HeroLove:getStoryLink()
	return self._config.StoryLink or {}
end

function HeroLove:getFunction()
	return self._config.Function
end

function HeroLove:getLikabilityAttr()
	return self._config.LikabilityAttr
end

function HeroLove:getLikability()
	return self._config.Likability
end

function HeroLove:getGiftEventDesc()
	return self._config.GiftEventDesc
end

function HeroLove:getLovelyGift()
	return self._config.LovelyGift
end

function HeroLove:getUseEventDesc()
	return self._config.UseEventDesc
end

function HeroLove:getLoveSound()
	return self._config.LoveSound
end
