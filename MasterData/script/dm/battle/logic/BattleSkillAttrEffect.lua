-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattleSkillAttrEffect.lua

BattleAttrAddEffectType = {
	kGrowByLevel = "LINEAR",
	kGrowByConfig = "CUSTOM",
	kSingleValue = "FIXED"
}
BattleSkillAttrEffect = BattleSkillAttrEffect or {}

function BattleSkillAttrEffect:createEffect(configId, level)
	local effectId = configId
	local level = level
	local config = ConfigReader:getRecordById("SkillAttrEffect", effectId)

	assert(config ~= nil, "effectId =" .. tostring(effectId) .. " is not in SkillAttrEffect Config")

	config.EffectRange = config.EffectRange or {}

	local effects = {}

	for j = 1, #config.EffectRange do
		local effectEvn = config.EffectRange[j]

		for i = 1, #config.Value do
			local attrNum = SkillAttribute:getAddNumByConfig(config, i, level)
			local attrType = SkillAttribute:getAddTypeByConfig(config, i)

			effects[#effects + 1] = {
				effectEvn = effectEvn,
				attrNum = attrNum,
				attrType = attrType,
				effectType = config.EffectType,
				target = config.Target
			}
		end
	end

	return effects
end

function BattleSkillAttrEffect:getAddNumByConfig(config, configIndex, level)
	level = level or 0

	local growType = config.GrowType
	local addNumData = config.Value[configIndex]
	local num = 0

	if growType == BattleAttrAddEffectType.kSingleValue then
		num = addNumData
	elseif growType == BattleAttrAddEffectType.kGrowByLevel then
		if level > 0 then
			num = addNumData[1] + (level - 1) * addNumData[2]
		end
	elseif growType == BattleAttrAddEffectType.kGrowByConfig and level > 0 then
		num = addNumData[level] or addNumData[#addNumData]
	end

	return num
end

function BattleSkillAttrEffect:getAddTypeByConfig(config, configIndex)
	local addTypes = config.AttrType

	return addTypes[configIndex]
end
