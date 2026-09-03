-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/relation/Relation.lua

require("dm.gameplay.develop.model.effect.SingleAttrAddEffect")
require("dm.gameplay.develop.model.effect.RangeAttrAddEffect")
require("dm.gameplay.develop.model.hero.skill.SkillAttribute")

Relation = class("Relation", objectlua.Object, _M)

Relation:has("_config", {
	is = "r"
})
Relation:has("_id", {
	is = "r"
})
Relation:has("_isActive", {
	is = "r"
})
Relation:has("_lockState", {
	is = "r"
})
Relation:has("_level", {
	is = "r"
})
Relation:has("_index", {
	is = "rw"
})
Relation:has("_effect", {
	is = "rw"
})
Relation:has("_history", {
	is = "r"
})

RelationLockState = {
	kCanDevelop = 1,
	kCanNotDevelop = 2,
	kLock = 0
}
RelationType = {
	kHero = "HERO",
	kGlobal = "GLOBAL",
	kEquip = "EQUIP"
}
RelationCondType = {
	kEquipEvolve = "EQUIPEVOLVE",
	kRelationAmount = "RELATIONAMOUNT",
	kHeroStar = "HEROSTAR",
	kHeroAmount = "HEROAMOUNT",
	kRelationLevel = "RELATIONLEVEL",
	kEquipStar = "EQUIPSTAR"
}

local SpecialEffectType = {
	PRODUCTION = "PRODUCTION",
	CHANGESKILL = "CHANGESKILL",
	UNLOCKSKILL = "UNLOCKSKILL"
}

function Relation:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:getRecordById("HeroRelation", tostring(id))
	self._isActive = false
	self._lockState = RelationLockState.kLock
	self._level = 0
	self._index = 0
	self._history = {}
end

function Relation:createAttrEffect(owner, player)
	self._effect = SkillAttrEffect:new(AttrSystemName.kHeroRelation)

	self._effect:setOwner(owner, player)
end

function Relation:synchronize(data)
	if data.lock then
		self._lockState = data.lock
	end

	if data.level then
		self._level = data.level
	end

	if data.history then
		for index, dateTime in pairs(data.history) do
			self._history[index] = dateTime
		end
	end

	self._isActive = self._lockState ~= RelationLockState.kLock

	self:refreshEffect()
end

function Relation:getIsActive()
	return self._lockState ~= RelationLockState.kLock
end

function Relation:getCanDevelop()
	return self._lockState == RelationLockState.kCanDevelop
end

function Relation:refreshEffect()
	self._effect:removeEffect()

	if self._isActive then
		self:rCreateEffect()
	end
end

function Relation:rCreateEffect()
	if GameConfigs.closeHeroRelationAttr then
		return
	end

	local effects = {}

	if self._config.Effect[self._level] then
		effects[#effects + 1] = self._config.Effect[self._level]
	end

	self._effect:refreshEffects(effects, self._level)
	self._effect:rCreateEffect()
end

function Relation:getType()
	return self._config.Type
end

function Relation:getCondition()
	return self._config.Condition
end

function Relation:getRelationTargets()
	return self._config.RelationList
end

function Relation:getMaxLevel()
	return self._config.EffectLevel
end

function Relation:getName()
	return Strings:get(self._config.Name)
end

function Relation:getDescType()
	return Strings:get(self._config.DescType)
end

function Relation:getSort()
	return self._config.Sort
end

function Relation:getIconId()
	return self._config.IconConfig
end

function Relation:getEffectIdByLevel(level)
	level = level or self._level

	local effectIds = {}

	if self._config.Effect[self._level] then
		effectIds[#effectIds + 1] = self._config.Effect[self._level]
	end

	return effectIds[1]
end

local RelationShowType = {
	{
		16,
		"#F7EFE8",
		"#DFFF2E"
	},
	{
		16,
		"#ffffff",
		"#DFFF2E"
	},
	{
		16,
		"#503214",
		"#DFFF2E"
	}
}

function Relation.class:fillDesc(strId, config, style, styleType)
	local effectColor = style.fontColor
	local desc = Strings:get(strId, {
		fontName = style.fontName,
		fontSize = style.fontSize,
		fontColor = style.fontColor
	})
	local t = TextTemplate:new(desc)
	local funcMap = {
		HEROAMOUNT = function(value)
			local str = ""

			for i = 1, #value do
				local heroConfig = ConfigReader:getRecordById("HeroBase", value[i])

				if heroConfig then
					str = str .. Strings:get(heroConfig.Name)

					if #value > 0 and i ~= #value then
						str = str .. ","
					end
				end
			end

			return str
		end,
		EQUIPSTAR = function(value)
			local str = ""
			local equipConfig = ConfigReader:getRecordById("EquipBase", value[1])

			str = str .. Strings:get(equipConfig.EquipName[1])

			return str
		end,
		HEROLIST = function(value)
			local str = ""

			for i = 1, #value do
				local heroId = value[i]
				local hasHero = style.developSystem:getHeroSystem():hasHero(heroId)
				local heroConfig = ConfigReader:getRecordById("HeroBase", heroId)

				if heroConfig then
					local nameStr = Strings:get(heroConfig.Name)

					if hasHero then
						local nameRichStr = "<font face='${fontName}' size='${fontSize}' color='" .. effectColor .. "'>${name}</font>"
						local templateStr = TextTemplate:new(nameRichStr)
						local var_20_1 = {}

						var_20_1.fontName = style.fontName or TTF_FONT_FZYH_R
						var_20_1.fontSize = style.fontSize or 16
						var_20_1.name = nameStr
						str = str .. templateStr:stringify(var_20_1)
					else
						local nameRichStr = "<font face='${fontName}' size='${fontSize}' color='" .. effectColor .. "'>${name}</font>"
						local templateStr = TextTemplate:new(nameRichStr)
						local var_20_3 = {}

						var_20_3.fontName = style.fontName or TTF_FONT_FZYH_R
						var_20_3.fontSize = style.fontSize or 16
						var_20_3.name = nameStr
						str = str .. templateStr:stringify(var_20_3)
					end

					if #value > 0 and i ~= #value then
						local nameRichStr = "<font face='${fontName}' size='${fontSize}' color='#F7EFE8'>,</font>"
						local templateStr = TextTemplate:new(nameRichStr)
						local var_20_5 = {}

						var_20_5.fontName = style.fontName or TTF_FONT_FZYH_R
						var_20_5.fontSize = style.fontSize or 16
						str = str .. templateStr:stringify(var_20_5)
					end
				end
			end

			return str
		end
	}

	return (t:stringify(config, funcMap))
end

function Relation.class:getFontColorByLevel(level, styleType)
	local styleConfig = RelationShowType[styleType]

	return level <= 0 and "#B4AAAA" or styleConfig[3]
end

function Relation.class:getEffectDesc(level, config, style, styleType)
	local effectIds = {}

	if config.Effect[level] then
		effectIds[#effectIds + 1] = config.Effect[level]
	end

	local specialEffectIds = {}

	if config.SpecialEffect[level] then
		specialEffectIds[#specialEffectIds + 1] = config.SpecialEffect[level]
	end

	return Relation:getEffectDescs(effectIds, specialEffectIds, level, style, styleType)[1] or ""
end

function Relation.class:getShortCondDesc(level, config, style, styleType)
	return Relation:fillDesc(config.ShortDesc[level], config, style, styleType)
end

function Relation.class:getLongCondDesc(level, config, style, styleType)
	return Relation:fillDesc(config.LongDesc[level], config, style, styleType)
end

function Relation.class:getShortEffectDesc(level, config, style, styleType)
	local styleConfig = RelationShowType[styleType]

	style.fontName = style.fontName or TTF_FONT_FZYH_R
	style.fontSize = style.fontSize or styleConfig[1]

	local desc = Relation:getShortCondDesc(level, config, style, styleType)
	local factor1 = Strings:get("Relation_Desc_Punc1", style)
	local factor2 = Strings:get("Relation_Desc_Punc2", style)
	local string = Relation:getEffectDesc(level, config, style, styleType)

	desc = Relation:getEffectDesc(level, config, style, styleType) ~= "" and desc .. factor1 .. string or desc .. factor2

	return desc
end

function Relation.class:getLongDesc(level, config, style, styleType)
	local styleConfig = RelationShowType[styleType]

	style.fontName = style.fontName or TTF_FONT_FZYH_R
	style.fontSize = style.fontSize or styleConfig[1]

	local desc = Relation:getLongCondDesc(level, config, style, styleType)
	local factor1 = Strings:get("Relation_Desc_Punc1", style)
	local factor2 = Strings:get("Relation_Desc_Punc2", style)
	local string = Relation:getEffectDesc(level, config, style, styleType)

	desc = Relation:getEffectDesc(level, config, style, styleType) ~= "" and desc .. factor1 .. string or desc .. factor2

	return desc
end

function Relation.class:getName(level, config)
	level = level or 0

	local numConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroRelationLevelName", "content")
	local str = level > 0 and Strings:get(numConfig[level]) or ""

	return Strings:get(config.Name) .. str
end

function Relation.class:getSpecialEffectDesc(effectId, level, style)
	style = style or {}
	style.fontName = style.fontName or TTF_FONT_FZYH_R
	style.fontSize = style.fontSize or 16

	local effectConfig = ConfigReader:getRecordById("SkillSpecialEffect", effectId)
	local Parameter = effectConfig.Parameter
	local effectType = effectConfig.EffectType

	if effectType == SpecialEffectType.PRODUCTION then
		for key, value in pairs(Parameter) do
			style[key] = type(value) == "number" and value or Strings:get(SpecialEffectDesId[value])
		end
	end

	local desc = Strings:get(effectConfig.Desc, style)
	local t = TextTemplate:new(desc)

	return t:stringify(effectConfig, SkillPrototype:getEffectDescFactorFunc(level))
end

function Relation.class:getEffectDescs(effectIds, specialEffectIds, level, style)
	local subDescs = {}

	if effectIds then
		for i = 1, #effectIds do
			subDescs[#subDescs + 1] = SkillPrototype:getAttrEffectDesc(effectIds[i], level, style)
		end
	end

	if specialEffectIds then
		for i = 1, #specialEffectIds do
			subDescs[#subDescs + 1] = Relation:getSpecialEffectDesc(specialEffectIds[i], level, style)
		end
	end

	return subDescs
end
