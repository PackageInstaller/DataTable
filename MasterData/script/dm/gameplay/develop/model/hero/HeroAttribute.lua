-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/HeroAttribute.lua

HeroAttribute = HeroAttribute or {}
HeroType = {
	kTank = "ATK",
	kGank = "TECH",
	kDPS = "DEF"
}
HeroAttribute.closeAddHeroAttr = false

local rarityConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_RarityFactor", "content")
local HeroCostAttr_Standard = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroCostAttr_Standard", "content")
local costRateType = {
	ATK = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroCostAttr_ATK", "content"),
	DEF = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroCostAttr_DEF", "content"),
	HP = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroCostAttr_HP", "content")
}

function HeroAttribute:getSpeedRatio(qualityId, starId, hero)
	local speedBase = hero:getHeroPrototype():getConfig().Speed
	local quaConfig = ConfigReader:getRecordById("HeroQuality", qualityId)
	local starConfig = ConfigReader:getRecordById("HeroStarEffect", starId)
	local factor = hero:getAddAttrByType("SPEED")

	return speedBase + quaConfig.Speed + starConfig.Speed + factor
end

function HeroAttribute:getQualityRatio(qualityId, attrType)
	local quaConfig = ConfigReader:requireRecordById("HeroQuality", tostring(qualityId))
	local baseNumMap = {
		ATK = {
			quaConfig.AtkQualityFactor,
			quaConfig.AtkQualityBaseValue
		},
		DEF = {
			quaConfig.DefQualityFactor,
			quaConfig.DefQualityBaseValue
		},
		HP = {
			quaConfig.HpQualityFactor,
			quaConfig.HpQualityBaseValue
		}
	}
	local ratio = baseNumMap[attrType][1]
	local basic = baseNumMap[attrType][2]

	return {
		ratio = ratio,
		basic = basic
	}
end

function HeroAttribute:getStarRatio(starId, attrType)
	local starConfig = ConfigReader:requireRecordById("HeroStarEffect", tostring(starId))
	local baseNumMap = {
		ATK = {
			starConfig.AtkStarFactor,
			starConfig.AtkStarBaseValue
		},
		DEF = {
			starConfig.DefStarFactor,
			starConfig.DefStarBaseValue
		},
		HP = {
			starConfig.HpStarFactor,
			starConfig.HpStarBaseValue
		}
	}
	local ratio = baseNumMap[attrType][1]
	local basic = baseNumMap[attrType][2]

	return {
		ratio = ratio,
		basic = basic
	}
end

function HeroAttribute:getBaseValueByAttType(heroPrototype, attrType)
	return heroPrototype:getBaseNumByType(attrType)
end

function HeroAttribute:getRarity(rareity)
	return rarityConfig[tostring(rareity)]
end

function HeroAttribute:getCostRate(cost, attrType)
	local map = costRateType[attrType]

	if not map or not map[tostring(cost)] then
		return 1
	end

	local num1 = map[tostring(cost)]
	local num2 = map[tostring(HeroCostAttr_Standard)]

	return num2 == 0 and 1 or num1 / num2
end

function HeroAttribute:getBaseAttEffectConfig(data, hero)
	local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(data.heroId)
	local qaRatio = HeroAttribute:getQualityRatio(data.qualityId, data.attrType)
	local starRatio = HeroAttribute:getStarRatio(data.starId, data.attrType)
	local baseValue = HeroAttribute:getBaseValueByAttType(heroPrototype, data.attrType)
	local baseRatioFactor = heroPrototype:getBaseRatioByType(data.attrType)
	local rarityRatio = HeroAttribute:getRarity(data.rarity)
	local costRatio = HeroAttribute:getCostRate(data.cost, data.attrType)
	local factor1 = qaRatio.basic + starRatio.basic + qaRatio.ratio * data.lvl + starRatio.ratio * data.lvl
	local factor2 = baseRatioFactor * rarityRatio * costRatio
	local factor3 = baseValue
	local attrNum = factor1 * factor2 + factor3

	return {
		elementType = "a",
		effectEvn = "ALL",
		target = "SELF",
		attrType = data.attrType,
		attrNum = attrNum
	}
end

function HeroAttribute:attachAttrToHero(env, hero)
	env = env or GameEnvType.kAll

	local heroAttrFactor = hero:getAttrFactor()

	hero:getAttrFactor():reCreateAttr()

	local effectList = hero:getEffectList()

	effectList:attachAttrToTarget(heroAttrFactor, env)

	local rangeEffectList = hero:getPlayer():getEffectList()

	rangeEffectList:attachAttrToHero(hero, env)
end

function HeroAttribute:getAttrNumByType(attrType, env, hero)
	env = env or GameEnvType.kAll

	local attrsFlag = hero:getAttrFlagByType(attrType)

	if attrsFlag then
		return attrsFlag
	end

	local heroAttrFactor = hero:getAttrFactor()

	if not HeroAttribute.closeAddHeroAttr then
		HeroAttribute:attachAttrToHero(env, hero)
	end

	local heroConfig = hero:getHeroPrototype():getConfig()
	local attrNum = 0

	if AttributeCategory:isAttrBaseType(attrType) then
		attrNum = HeroAttribute:getBaseAttrNumByType(attrType, heroAttrFactor, env)
	else
		local attrRateName = AttrName[attrType]

		if attrRateName and heroConfig[attrRateName] then
			attrNum = heroConfig[attrRateName]
		end

		attrNum = attrNum + HeroAttribute:getRateAttrNumByType(attrType, heroAttrFactor, env)
	end

	attrNum = attrNum + hero:getAddAttrByType(attrType)

	hero:setAttrFlagByType(attrType, attrNum)

	return attrNum
end

function HeroAttribute:setAddHeroAttrState(isClose)
	HeroAttribute.closeAddHeroAttr = isClose
end

function HeroAttribute:getBaseAttrNumByType(attrType, attrFactor, env)
	local elementMap = attrFactor:getVector(attrType)
	local result = elementMap.a * (1 + elementMap.b) + elementMap.c

	if env and env ~= GameEnvType.kAll then
		return result * (1 + elementMap.d) + elementMap.f
	end

	return result
end

function HeroAttribute:getRateAttrNumByType(attrType, attrFactor, env)
	local elementMap = attrFactor:getVector(attrType)
	local result = elementMap.a

	if env and env ~= GameEnvType.kAll then
		return result + elementMap.b
	end

	return result
end

HeroAttribute._cache_res = {}
HeroAttribute.heroCombatValue = {}

local Hero_Atk_CoefficientA = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Atk_CoefficientA", "content")
local Hero_Def_CoefficientA = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Def_CoefficientA", "content")
local Hero_Hp_CoefficientA = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Hp_CoefficientA", "content")
local Hero_SpecialBase_UnRand = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_SpecialBase_UnRand", "content")
local Hero_HurtRate_CoefficientA = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_HurtRate_CoefficientA", "content")
local Hero_UnHurtRate_CoefficientA = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_UnHurtRate_CoefficientA", "content")
local Hero_Absorption_CoefficientA = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Absorption_CoefficientA", "content")
local Hero_Reflection_CoefficientA = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Reflection_CoefficientA", "content")
local Hero_SpecialBase_Rand = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_SpecialBase_Rand", "content")
local Hero_Critrate_CoefficientA = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Critrate_CoefficientA", "content")
local Hero_UnCritrate_CoefficientA = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_UnCritrate_CoefficientA", "content")
local Hero_Critstrg_CoefficientA = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Critstrg_CoefficientA", "content")
local Hero_BlockRate_CoefficientA = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_BlockRate_CoefficientA", "content")
local Hero_UnBlockRate_CoefficientA = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_UnBlockRate_CoefficientA", "content")
local Hero_BlockStrg_CoefficientA = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_BlockStrg_CoefficientA", "content")
local Hero_Revise_Coefficient = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Revise_Coefficient", "content")
local Hero_Rareity_Coefficient = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Rareity_Coefficient", "content")
local Hero_HurtRate_CoefficientB = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_HurtRate_CoefficientB", "content")
local Hero_UnHurtRate_CoefficientB = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_UnHurtRate_CoefficientB", "content")
local Hero_Reflection_CoefficientB = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Reflection_CoefficientB", "content")
local Hero_Absorption_CoefficientB = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Absorption_CoefficientB", "content")
local Hero_Add1_Coefficient = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Add1_Coefficient", "content")
local Hero_Add2_Coefficient = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Add2_Coefficient", "content")
local Hero_Critrate_CoefficientB = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Critrate_CoefficientB", "content")
local Hero_UnCritrate_CoefficientB = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_UnCritrate_CoefficientB", "content")
local Hero_Critstrg_CoefficientB = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Critstrg_CoefficientB", "content")
local Hero_BlockRate_CoefficientB = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_BlockRate_CoefficientB", "content")
local Hero_UnBlockRate_CoefficientB = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_UnBlockRate_CoefficientB", "content")
local Hero_BlockStrg_CoefficientB = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_BlockStrg_CoefficientB", "content")
local Hero_EffectRate_CoefficientB = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_EffectRate_CoefficientB", "content")
local Hero_UnEffectRate_CoefficientB = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_UnEffectRate_CoefficientB", "content")
local Hero_EffectStrg_CoefficientB = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_EffectStrg_CoefficientB", "content")
local Hero_Type_Coefficient = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Type_Coefficient", "content")
local Hero_Star_Coefficient = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Star_Coefficient", "content")

HeroAttribute.heroCombatDesc = "    单角色战力 =\n    （攻击 + 防御 + 0.25*生命）\n    *（3 + 伤害率 + 免伤率 + 反伤率*0.6 + 吸血率*0.6）\n    * (8 + 暴击率 + 抗暴率*0.7 + 暴击强度*0.4 + 格挡率 + 破击率*0.7 + 格挡强度*0.4)\n    * (1+星级参数)\n    * 资质系数\n    * 0.011\n    * 身材系数\n    * 职业系数\n    + (伤害率 + 免伤率 + 反弹率 +  吸血率) * 800\n    +(暴击率 + 抗暴率 + 暴击强度 + 格挡率 + 破击率 + 格挡强度 + 效果强度 + 效果抵抗率 + 效果命中率) * 400\n"

function HeroAttribute:getCombat(data)
	local cjson = require("cjson.safe")
	local id = cjson.encode(data)
	local res = HeroAttribute._cache_res[id]

	if res == nil then
		if data then
			local combat = (data.attack * Hero_Atk_CoefficientA + data.defense * Hero_Def_CoefficientA + data.hp * Hero_Hp_CoefficientA) * (Hero_SpecialBase_UnRand + data.hurtRate * Hero_HurtRate_CoefficientA + data.unhurtRate * Hero_UnHurtRate_CoefficientA + data.reflection * Hero_Reflection_CoefficientA + data.absorption * Hero_Absorption_CoefficientA) * (Hero_SpecialBase_Rand + data.critRate * Hero_Critrate_CoefficientA + data.uncritRate * Hero_UnCritrate_CoefficientA + data.critStrg * Hero_Critstrg_CoefficientA + data.blockRate * Hero_BlockRate_CoefficientA + data.unblockRate * Hero_UnBlockRate_CoefficientA + data.blockStrg * Hero_BlockStrg_CoefficientA) * (1 + Hero_Star_Coefficient[tostring(data.star)]) * (Hero_Rareity_Coefficient[tostring(data.rarity)] or 1) * Hero_Revise_Coefficient * 1 * Hero_Type_Coefficient[data.occupation] + (data.hurtRate * Hero_HurtRate_CoefficientB + data.unhurtRate * Hero_UnHurtRate_CoefficientB + data.reflection * Hero_Reflection_CoefficientB + data.absorption * Hero_Absorption_CoefficientB) * Hero_Add1_Coefficient + (data.critRate * Hero_Critrate_CoefficientB + data.uncritRate * Hero_UnCritrate_CoefficientB + data.critStrg * Hero_Critstrg_CoefficientB + data.blockRate * Hero_BlockRate_CoefficientB + data.unblockRate * Hero_UnBlockRate_CoefficientB + data.blockStrg * Hero_BlockStrg_CoefficientB + data.effectStrg * Hero_EffectStrg_CoefficientB + data.unEffectRate * Hero_UnEffectRate_CoefficientB + data.effectRate * Hero_EffectRate_CoefficientB) * Hero_Add2_Coefficient

			HeroAttribute._cache_res[id] = combat

			print("cdsklcndskcndksncdksncdkscndk.  ", data.attack, Hero_Atk_CoefficientA, data.defense, Hero_Def_CoefficientA, data.hp, Hero_Hp_CoefficientA)

			local var_13_1 = {
				data.attack * Hero_Atk_CoefficientA + data.defense * Hero_Def_CoefficientA + data.hp * Hero_Hp_CoefficientA,
				Hero_SpecialBase_UnRand + data.hurtRate * Hero_HurtRate_CoefficientA + data.unhurtRate * Hero_UnHurtRate_CoefficientA + data.reflection * Hero_Reflection_CoefficientA + data.absorption * Hero_Absorption_CoefficientA,
				Hero_SpecialBase_Rand + data.critRate * Hero_Critrate_CoefficientA + data.uncritRate * Hero_UnCritrate_CoefficientA + data.critStrg * Hero_Critstrg_CoefficientA + data.blockRate * Hero_BlockRate_CoefficientA + data.unblockRate * Hero_UnBlockRate_CoefficientA + data.blockStrg * Hero_BlockStrg_CoefficientA,
				1 + Hero_Star_Coefficient[tostring(data.star)],
				nil,
				nil,
				1
			}

			var_13_1[5] = Hero_Rareity_Coefficient[tostring(data.rarity)] or 1
			var_13_1[6] = Hero_Revise_Coefficient
			var_13_1[8] = Hero_Type_Coefficient[data.occupation]
			var_13_1[9] = (data.hurtRate * Hero_HurtRate_CoefficientB + data.unhurtRate * Hero_UnHurtRate_CoefficientB + data.reflection * Hero_Reflection_CoefficientB + data.absorption * Hero_Absorption_CoefficientB) * Hero_Add1_Coefficient
			var_13_1[10] = (data.critRate * Hero_Critrate_CoefficientB + data.uncritRate * Hero_UnCritrate_CoefficientB + data.critStrg * Hero_Critstrg_CoefficientB + data.blockRate * Hero_BlockRate_CoefficientB + data.unblockRate * Hero_UnBlockRate_CoefficientB + data.blockStrg * Hero_BlockStrg_CoefficientB + data.effectStrg * Hero_EffectStrg_CoefficientB + data.unEffectRate * Hero_UnEffectRate_CoefficientB + data.effectRate * Hero_EffectRate_CoefficientB) * Hero_Add2_Coefficient
			HeroAttribute.heroCombatValue = var_13_1

			return combat
		end
	else
		return res
	end
end

function HeroAttribute:getMaxHeroCombat(data)
	return (data.attack * Hero_Atk_CoefficientA + data.defense * Hero_Def_CoefficientA + data.hp * Hero_Hp_CoefficientA) * (Hero_SpecialBase_UnRand + data.hurtRate * Hero_HurtRate_CoefficientA + data.unhurtRate * Hero_UnHurtRate_CoefficientA + data.reflection * Hero_Reflection_CoefficientA + data.absorption * Hero_Absorption_CoefficientA) * (Hero_SpecialBase_Rand + data.critRate * Hero_Critrate_CoefficientA + data.uncritRate * Hero_UnCritrate_CoefficientA + data.critStrg * Hero_Critstrg_CoefficientA + data.blockRate * Hero_BlockRate_CoefficientA + data.unblockRate * Hero_UnBlockRate_CoefficientA + data.blockStrg * Hero_BlockStrg_CoefficientA) * (1 + Hero_Star_Coefficient[tostring(data.star)]) * (Hero_Rareity_Coefficient[tostring(data.rarity)] or 1) * Hero_Revise_Coefficient * 1 * Hero_Type_Coefficient[data.occupation] + (data.hurtRate * Hero_HurtRate_CoefficientB + data.unhurtRate * Hero_UnHurtRate_CoefficientB + data.reflection * Hero_Reflection_CoefficientB + data.absorption * Hero_Absorption_CoefficientB) * Hero_Add1_Coefficient + (data.critRate * Hero_Critrate_CoefficientB + data.uncritRate * Hero_UnCritrate_CoefficientB + data.critStrg * Hero_Critstrg_CoefficientB + data.blockRate * Hero_BlockRate_CoefficientB + data.unblockRate * Hero_UnBlockRate_CoefficientB + data.blockStrg * Hero_BlockStrg_CoefficientB + data.effectStrg * Hero_EffectStrg_CoefficientB + data.unEffectRate * Hero_UnEffectRate_CoefficientB + data.effectRate * Hero_EffectRate_CoefficientB) * Hero_Add2_Coefficient
end
