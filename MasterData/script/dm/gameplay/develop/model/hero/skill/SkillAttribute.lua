-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/skill/SkillAttribute.lua

SkillAttribute = SkillAttribute or {}

require("dm.gameplay.develop.model.effect.CompositeEffect")
require("dm.gameplay.develop.model.effect.SingleAttrAddEffect")
require("dm.gameplay.develop.model.effect.RangeAttrAddEffect")

SkillType = {
	kEnter = "ENTER",
	kEQUIP = "EQUIP",
	kCrit = "CRIT",
	kTalent = "TALENT",
	kUltra = "ULTRA",
	kSuper = "UNIQUE",
	kNormal = "NORMAL",
	kBuff = "BUFF",
	kSpecial = "PROUD",
	kPassive = "PASSIVE",
	kSoul = "SOUL",
	kBreak = "BREAK"
}
AttAddEffectType = {
	kGrowByLevel = "LINEAR",
	kGrowByConfig = "CUSTOM",
	kSingleValue = "FIXED"
}
AttrEffectTarget = {
	kHero = "HERO",
	kSelf = "SELF",
	kAll = "ALL",
	kMaster = "MASTER"
}
AttEffectType = {
	kChangeSkill = "CHAGESKILL",
	kUnLockSkill = "UNLOCKSKILL",
	kGrowValue = "CHANGEQUALITY",
	kAddSkillEffect = "ADDEFFECT",
	kAtt = "ATTR",
	kChangeSkillEffect = "CHANGEEFFECT"
}

function SkillAttribute:getElementByConfig(attrType, effectRange)
	local isAttrBaseType = AttributeCategory:isAttrBaseType(attrType)

	effectRange = effectRange or GameEnvType.kAll

	if isAttrBaseType then
		local vectorTypes = effectRange == GameEnvType.kAll and {
			"b",
			"c"
		} or {
			"d",
			"f"
		}
		local isAttrPercentageType = AttributeCategory:isAttrPercentageType(attrType)

		return (isAttrPercentageType ~= nil or nil) and (vectorTypes[1] or vectorTypes[2])
	else
		local vectorTypes = {
			"a",
			"b"
		}

		return (effectRange == GameEnvType.kAll or nil) and (vectorTypes[1] or vectorTypes[2])
	end
end

function SkillAttribute:getAddNumByConfig(config, configIndex, level)
	level = level or 0

	local growType = config.GrowType
	local addNumData = config.Value[configIndex]
	local num = 0

	if growType == AttAddEffectType.kSingleValue then
		num = addNumData
	elseif growType == AttAddEffectType.kGrowByLevel then
		if level > 0 then
			num = addNumData[1] + (level - 1) * addNumData[2]
		end
	elseif growType == AttAddEffectType.kGrowByConfig and level > 0 then
		num = addNumData[level] or addNumData[#addNumData]
	end

	return num
end

function SkillAttribute:getAddTypeByConfig(config, configIndex)
	local addTypes = config.AttrType

	return addTypes[configIndex]
end

function SkillAttribute:changeSkillDescFactors(config, luaStr)
	local funcStr = "return acConfig"

	if namesStr then
		funcStr = funcStr .. namesStr
	end

	local condFn, errmsg = loadstring(funcStr)

	if condFn ~= nil then
		setfenv(condFn, {
			acConfig = acConfig
		})
	end

	local result = condFn()
end

function SkillAttribute:createAttEffect(player, effectData)
	local effectId = effectData.id
	local level = effectData.level
	local config = ConfigReader:getRecordById("SkillAttrEffect", effectId)

	assert(config ~= nil, "effectId =" .. tostring(effectId) .. " is not in SkillAttrEffect Config")

	config.EffectRange = config.EffectRange or {}

	local effects = {}

	for j = 1, #config.EffectRange do
		local effectEvn = config.EffectRange[j]

		for i = 1, #config.Value do
			local attrNum = SkillAttribute:getAddNumByConfig(config, i, level)
			local attrType = SkillAttribute:getAddTypeByConfig(config, i)
			local elementType = SkillAttribute:getElementByConfig(attrType, effectEvn)

			attrType = AttributeCategory:changeBaseAttrType(attrType)

			local effectConfig = {
				effectEvn = effectEvn,
				attrNum = attrNum,
				attrType = attrType,
				elementType = elementType,
				target = config.Target,
				effectType = config.EffectType
			}
			local effect

			if config.Target == "SELF" then
				effect = SingleAttrAddEffect:new(effectConfig)
			else
				effectConfig = setmetatable(effectConfig, {
					__index = {
						player = player
					}
				})
				effect = RangeAttrAddEffect:new(effectConfig)
			end

			if effect then
				effects[#effects + 1] = effect
			end
		end
	end

	return effects
end
