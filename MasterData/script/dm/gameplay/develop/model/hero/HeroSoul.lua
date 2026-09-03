-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/HeroSoul.lua

require("dm.gameplay.develop.model.effect.SpecialEffectFormula")
require("dm.gameplay.develop.model.hero.skill.SkillAttribute")

HeroSoul = class("HeroSoul", objectlua.Object, _M)

HeroSoul:has("_id", {
	is = "r"
})
HeroSoul:has("_level", {
	is = "r"
})
HeroSoul:has("_exp", {
	is = "r"
})
HeroSoul:has("_lockState", {
	is = "r"
})
HeroSoul:has("_config", {
	is = "r"
})
HeroSoul:has("_pos", {
	is = "r"
})

HeroSoulLockState = {
	kLock = 0,
	kUnLock = 2,
	kCanUnLock = 1
}

function HeroSoul:initialize(id, pos, owner)
	self._owner = owner
	self._id = id
	self._pos = pos
	self._level = 0
	self._exp = 0
	self._lockState = HeroSoulLockState.kLock
	self._config = ConfigReader:getRecordById("HeroSoul", tostring(self._id))
end

function HeroSoul:createAttrEffect(owner, player)
	self._effect = SkillAttrEffect:new(AttrSystemName.kHeroSoul)

	self._effect:setOwner(owner, player)
end

function HeroSoul:synchronize(data)
	if data.level then
		self._level = data.level
	end

	if data.exp then
		self._exp = data.exp
	end

	if data.lock then
		self._lockState = data.lock
	end

	self:refreshEffect()
end

function HeroSoul:refreshEffect()
	self._effect:removeEffect()

	if self._lockState == HeroSoulLockState.kUnLock then
		self:rCreateEffect()
	end
end

function HeroSoul:rCreateEffect()
	if GameConfigs.closeHeroRelationAttr then
		return
	end

	local effects = {}

	if self._config.AttrEffect and self._config.AttrEffect[self._level] then
		effects[#effects + 1] = self._config.AttrEffect[self._level]
	end

	self._effect:refreshEffects(effects, self._level)
	self._effect:rCreateEffect()
end

function HeroSoul:getLock()
	return self._lockState ~= HeroSoulLockState.kUnLock
end

function HeroSoul:isMaxLevel()
	return self:getLevel() == self:getUpgradeLevel()
end

function HeroSoul:getUpgradeLevel()
	return self:getLimitLevel()
end

function HeroSoul:getPreSoul()
	return self._config.PreBattleSoul
end

function HeroSoul:getUnlockCon()
	return self._config.Unlock
end

function HeroSoul:getLimitLevel()
	return self._config.LevelMax
end

function HeroSoul:getGoldCost()
	for i = 1, #self._config.CurrencyCost do
		if self._config.CurrencyCost[i].id == CurrencyIdKind.kGold then
			return self._config.CurrencyCost[i]
		end
	end
end

function HeroSoul:getNextLevelCost(level)
	return self._config.LevelCost[level] or 0
end

function HeroSoul:getNextLevelDiaCost(level)
	return self._config.LevelDiamond[level] or 0
end

function HeroSoul:getName()
	return Strings:get(self._config.Name)
end

function HeroSoul:getIconId()
	return "asset/soul/" .. self._config.Icon .. ".png"
end

function HeroSoul:getDesc(level)
	level = level or self._level

	local effectIds = {}
	local spEffectIds = {}

	if self._config.AttrEffect then
		for i = 1, #self._config.AttrEffect do
			effectIds[#effectIds + 1] = self._config.AttrEffect[i]
		end
	end

	if self._config.SpecialEffect then
		for i = 1, #self._config.SpecialEffect do
			spEffectIds[#spEffectIds + 1] = self._config.SpecialEffect[i]
		end
	end

	local descs = HeroSoul:getEffectDescs(effectIds, spEffectIds, level)
	local str = ""

	for i = 1, #descs do
		str = i == 1 and descs[1] or str .. "、" .. descs[1]
	end

	return str
end

function HeroSoul:getDescType(level1, level2)
	local value1 = ""
	local value2 = ""
	local effectIds = {}
	local spEffectIds = {}

	if self._config.AttrEffect then
		for i = 1, #self._config.AttrEffect do
			effectIds[#effectIds + 1] = self._config.AttrEffect[i]
		end
	end

	if self._config.SpecialEffect then
		for i = 1, #self._config.SpecialEffect do
			spEffectIds[#spEffectIds + 1] = self._config.SpecialEffect[i]
		end

		value1 = HeroSoul:getEffectValueDescs(effectIds, spEffectIds, level1)[1]
		value2 = HeroSoul:getEffectValueDescs(effectIds, spEffectIds, level2)[1]
	end

	return HeroSoul:getEffectTypeDescs(effectIds, spEffectIds, level1)[1], value1, value2
end

local attrName = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_SkillAttrName", "content")
local attrTypeDesc = {
	EFFECTRATE = "%",
	DEF = "",
	HP = "",
	["TOGANK@HURT"] = "%",
	REFLECTION = "%",
	["TOGANK@UNHURT"] = "%",
	ATKWEAKEN = "%",
	HP_RATE = "%",
	UNHURTRATE = "%",
	HURTRATE = "%",
	["TODPS@HURT"] = "%",
	UNCRITRATE = "%",
	EFFECTSTRG = "%",
	UNEFFECTRATE = "%",
	ATK_RATE = "%",
	UNBLOCKRATE = "%",
	DEF_RATE = "%",
	["TOTANK@HURT"] = "%",
	BLOCKSTRG = "",
	ATK = "",
	["TODPS@UNHURT"] = "%",
	BECUREDRATE = "%",
	ABSORPTION = "%",
	CRITSTRG = "",
	UNDEADRATE = "%",
	BLOCKRATE = "%",
	DEFRATE = "%",
	ATKRATE = "%",
	["TOTANK@UNHURT"] = "%",
	DEFWEAKEN = "%",
	CRITRATE = "%"
}

function HeroSoul.class:getAttrEffectDesc(effectId, level, style)
	style = style or {}
	style.fontName = style.fontName or TTF_FONT_FZYH_R
	style.fontSize = style.fontSize or 18

	local effectConfig = ConfigReader:getRecordById("SkillAttrEffect", effectId)

	style.type = Strings:get(attrName[effectConfig.AttrType[1]])

	local desc = Strings:get(effectConfig.EffectDesc, style)
	local attrNum = SkillPrototype:getAddNumByConfig(effectConfig, 1, level)

	if attrTypeDesc[effectConfig.AttrType[1]] ~= "" then
		attrNum = attrNum * 100 .. "%"
	end

	desc = desc .. attrNum

	local t = TextTemplate:new(desc)

	return t:stringify(effectConfig, SkillPrototype:getEffectDescFactorFunc(level))
end

function HeroSoul.class:getSpecialEffectDesc(effectId, level, style)
	style = style or {}
	style.fontName = style.fontName or TTF_FONT_FZYH_R
	style.fontSize = style.fontSize or 18

	local effectConfig = ConfigReader:getRecordById("SkillSpecialEffect", effectId)
	local Parameter = effectConfig.Parameter
	local attrNum = 0

	for key, value in pairs(Parameter) do
		if type(value) == "string" then
			style[key] = Strings:get(SpecialEffectDesId[value])

			break
		end
	end

	if effectConfig then
		attrNum = SpecialEffectFormula:getAddNumByConfig(effectConfig, 1, level)
		attrNum = SpecialEffectFormula:changeAddNumForShow(effectConfig, 0, math.abs(attrNum))
	end

	local desc = Strings:get(effectConfig.Desc, style) .. attrNum
	local t = TextTemplate:new(desc)

	return t:stringify(effectConfig, SkillPrototype:getEffectDescFactorFunc(level))
end

function HeroSoul.class:getEffectDescs(effectIds, specialEffectIds, level, style)
	local subDescs = {}

	if effectIds then
		for i = 1, #effectIds do
			subDescs[#subDescs + 1] = HeroSoul:getAttrEffectDesc(effectIds[i], level, style)
		end
	end

	if specialEffectIds then
		for i = 1, #specialEffectIds do
			subDescs[#subDescs + 1] = HeroSoul:getSpecialEffectDesc(specialEffectIds[i], level, style)
		end
	end

	return subDescs
end

function HeroSoul.class:getAttrEffectTypeDesc(effectId, level, style)
	style = style or {}
	style.fontName = style.fontName or TTF_FONT_FZYH_R
	style.fontSize = style.fontSize or 18

	local effectConfig = ConfigReader:getRecordById("SkillAttrEffect", effectId)

	style.type = Strings:get(attrName[effectConfig.AttrType[1]])

	local desc = Strings:get(effectConfig.EffectDesc, style)
	local t = TextTemplate:new(desc)

	return t:stringify(effectConfig, SkillPrototype:getEffectDescFactorFunc(level))
end

function HeroSoul.class:getAttrEffectValueDesc(effectId, level, style)
	style = style or {}
	style.fontName = style.fontName or TTF_FONT_FZYH_R
	style.fontSize = style.fontSize or 18

	local effectConfig = ConfigReader:getRecordById("SkillAttrEffect", effectId)

	style.type = attrName[effectConfig.AttrType[1]]

	local attrNum = SkillPrototype:getAddNumByConfig(effectConfig, 1, level)

	if attrTypeDesc[effectConfig.AttrType[1]] ~= "" then
		attrNum = attrNum * 100 .. "%"
	end

	return attrNum
end

function HeroSoul.class:getSpecialEffectTypeDesc(effectId, level, style)
	style = style or {}
	style.fontName = style.fontName or TTF_FONT_FZYH_R
	style.fontSize = style.fontSize or 18

	local effectConfig = ConfigReader:getRecordById("SkillSpecialEffect", effectId)
	local Parameter = effectConfig.Parameter

	for key, value in pairs(Parameter) do
		if type(value) == "string" then
			style[key] = Strings:get(SpecialEffectDesId[value])

			break
		end
	end

	local desc = Strings:get(effectConfig.Desc, style)
	local t = TextTemplate:new(desc)

	return t:stringify(effectConfig, SkillPrototype:getEffectDescFactorFunc(level))
end

function HeroSoul.class:getSpecialEffectValueDesc(effectId, level, style)
	style = style or {}
	style.fontName = style.fontName or TTF_FONT_FZYH_R
	style.fontSize = style.fontSize or 18

	local effectConfig = ConfigReader:getRecordById("SkillSpecialEffect", effectId)
	local attrNum = 0

	if effectConfig then
		attrNum = SpecialEffectFormula:getAddNumByConfig(effectConfig, 1, level)
		attrNum = SpecialEffectFormula:changeAddNumForShow(effectConfig, 0, math.abs(attrNum))
	end

	return attrNum
end

function HeroSoul.class:getEffectTypeDescs(effectIds, specialEffectIds, level, style)
	local subDescs = {}

	if effectIds then
		for i = 1, #effectIds do
			subDescs[#subDescs + 1] = HeroSoul:getAttrEffectTypeDesc(effectIds[i], level, style)
		end
	end

	if specialEffectIds then
		for i = 1, #specialEffectIds do
			subDescs[#subDescs + 1] = HeroSoul:getSpecialEffectTypeDesc(specialEffectIds[i], level, style)
		end
	end

	return subDescs
end

function HeroSoul.class:getEffectValueDescs(effectIds, specialEffectIds, level, style)
	local subDescs = {}

	if effectIds then
		for i = 1, #effectIds do
			subDescs[#subDescs + 1] = HeroSoul:getAttrEffectValueDesc(effectIds[i], level, style)
		end
	end

	if specialEffectIds then
		for i = 1, #specialEffectIds do
			subDescs[#subDescs + 1] = HeroSoul:getSpecialEffectValueDesc(specialEffectIds[i], level, style)
		end
	end

	return subDescs
end
