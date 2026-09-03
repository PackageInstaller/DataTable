-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/equip/HeroEquipAttr.lua

require("dm.gameplay.develop.model.hero.skill.SkillAttribute")

HeroEquipAttr = HeroEquipAttr or {}

local HeroCostAttrBaseNum = "5"
local BaseAttrKey = {
	"ATK",
	"DEF",
	"HP",
	"SPEED"
}
local HeroEquipRarityRate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipRarityRate", "content")

function HeroEquipAttr:createEffect(equip, level)
	local attrEffectList = equip:getAttrEffect()
	local attrList = {}

	for i = 1, #attrEffectList do
		local effectId = attrEffectList[i]
		local data = self:getAttNumById(equip, effectId, level)

		if data then
			for attrType, v in pairs(data) do
				if attrList[attrType] then
					attrList[attrType].attrNum = attrList[attrType].attrNum + v.attrNum
				else
					attrList[attrType] = v
				end
			end
		end
	end

	return attrList
end

function HeroEquipAttr:getAttNumById(equip, effectId, level)
	level = level or equip:getLevel()

	local config = ConfigReader:getRecordById("SkillAttrEffect", effectId)

	assert(config ~= nil, "effectId =" .. tostring(effectId) .. " is not in SkillAttrEffect Config")

	local effects = {}

	for i = 1, #config.Value do
		local attrNum = SkillAttribute:getAddNumByConfig(config, i, level)
		local attrType = SkillAttribute:getAddTypeByConfig(config, i)
		local index = table.nums(effects) + 5

		effects[attrType] = {
			attrNum = attrNum,
			attrType = attrType,
			index = index
		}
	end

	return effects
end

function HeroEquipAttr:getBaseAttrNum(equip, params)
	local attr = {}

	if not params.config then
		local config = equip:getConfig()

		params.heroCost = params.heroId and tostring(ConfigReader:getDataByNameIdAndKey("HeroBase", params.heroId, "Cost")) or HeroCostAttrBaseNum
		params.level = params.level or equip:getLevel()
		params.rarity = tostring(params.rarity or equip:getRarity())
		params.star = params.star or equip:getStar()

		local length = #BaseAttrKey

		for i = 1, length do
			local attrType = BaseAttrKey[i]
			local attrId = config[attrType]

			if attrId and attrId ~= "" then
				params.attrId = attrId
				params.index = table.nums(attr) + 1
				attr[attrType] = HeroEquipAttr:getAttrNumByType(attrType, params)
			end
		end

		return attr
	end
end

function HeroEquipAttr:getAttrNumByType(attrType, params)
	local attrConfig = ConfigReader:getRecordById("HeroEquipAttr", params.attrId)

	if attrConfig then
		local starValue = attrConfig.StarAttr[params.star]
		local levelValue = attrConfig.LevelAttr[params.level]
		local rarityRate = HeroEquipRarityRate[params.rarity]
		local attrNum = (starValue + levelValue) * rarityRate

		return {
			attrType = attrType,
			attrNum = attrNum,
			index = params.index
		}
	end

	return nil
end
