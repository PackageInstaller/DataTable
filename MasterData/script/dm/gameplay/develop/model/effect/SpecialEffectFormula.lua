-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/effect/SpecialEffectFormula.lua

SpecialEffectFormula = SpecialEffectFormula or {}

require("dm.gameplay.develop.model.effect.CompositeEffect")

SpecialEffectType = {
	kChangeSkill = "CHANGESKILL",
	kEnergy = "ENERGY",
	kConsume = "RESOURCE",
	kChangeRarity = "CHANGERARITY",
	kPower = "STAMINA",
	kShop = "SHOP",
	kDrawCard = "DRAWCARD",
	kOrePool = "OREPOOL"
}

local specialAddEffectType = {
	kLevel = "LINEAR",
	kCustom = "CUSTOM",
	kFixed = "FIXED"
}

function SpecialEffectFormula:getAddNumByConfig(config, index, level)
	local growType = config.GrowType
	local data

	if config.Parameter.rate and config.Parameter.isPercent == 1 then
		data = self:getRateAddNum(config, index, level)
	elseif config.Parameter.value then
		data = self:getValueAddNum(config, index, level)
	end

	level = level or 0

	local num = 0

	if growType == specialAddEffectType.kFixed then
		num = data
	elseif growType == specialAddEffectType.kLevel then
		if level > 0 then
			num = data[1] + (level - 1) * data[2]
		end
	elseif growType == specialAddEffectType.kCustom and level > 0 then
		num = data[level] or data[#data]
	end

	return num
end

function SpecialEffectFormula:getValueAddNum(config, index, level)
	local data = config.Parameter.value

	if type(data) == "table" and type(data[1]) == "table" then
		assert(index ~= nil, "index is nil path : effectId =" .. tostring(config.Id) .. " is not in SkillSpecialEffect Config")

		data = config.Parameter.value[index]
	elseif type(data) == "table" and type(data[1]) ~= "table" then
		assert(index ~= nil, "index is nil path : effectId =" .. tostring(config.Id) .. " is not in SkillSpecialEffect Config")

		data = config.Parameter.value
	end

	return data
end

function SpecialEffectFormula:getRateAddNum(config, index, level)
	local data = config.Parameter.rate

	if type(data) == "table" and type(data[1]) == "table" then
		assert(index ~= nil, "index is nil path : effectId =" .. tostring(config.Id) .. " is not in SkillSpecialEffect Config")

		data = config.Parameter.rate[index]
	elseif type(data) == "table" and type(data[1]) ~= "table" then
		assert(index ~= nil, "index is nil path : effectId =" .. tostring(config.Id) .. " is not in SkillSpecialEffect Config")

		data = config.Parameter.rate
	end

	return data
end

function SpecialEffectFormula:changeAddNumForShow(config, index, attrNum)
	return (config.Parameter.isPercent == 1 or nil) and (attrNum * 100 .. "%" or attrNum)
end

function SpecialEffectFormula:isPlayerConsume(effectEvn)
	for k, data in pairs(PlayerConsumeConfig) do
		if data.env == effectEvn then
			return true
		end
	end

	return false
end

function SpecialEffectFormula:createEnergyEffect(player, id, level)
	local effects = {}
	local config = ConfigReader:getRecordById("SkillSpecialEffect", id)
	local parameter = config.Parameter

	for j = 1, #parameter.range do
		local effectEvn = parameter.range[j]

		for i = 1, #parameter.type do
			local effectConfig = {
				energyType = parameter.type[i],
				num = SpecialEffectFormula:getAddNumByConfig(config, i, level),
				target = config.Target,
				effectEvn = effectEvn
			}
			local effectConfig = setmetatable(effectConfig, {
				__index = {
					player = player
				}
			})
			local effectClass = EffectCacheConfig:getEffectClass(EffectCacheType.kEnergy)
			local effect = effectClass:new(effectConfig)

			if effect then
				effects[#effects + 1] = effect
			end
		end
	end

	return effects
end

function SpecialEffectFormula:createConsumeEffect(player, id, level)
	local effects = {}
	local config = ConfigReader:getRecordById("SkillSpecialEffect", id)
	local parameter = config.Parameter

	for i = 1, #parameter.itemType do
		local effectConfig = {
			consumeType = parameter.system,
			level = level,
			value = SpecialEffectFormula:getAddNumByConfig(config, i, level),
			rate = SpecialEffectFormula:getAddNumByConfig(config, i, level),
			itemType = parameter.itemType[i]
		}

		local function getSubSystem(list)
			list = list or {}

			local map = {}

			for i = 1, #list do
				map[list[i]] = true
			end

			return map
		end

		effectConfig.subSystem = getSubSystem(parameter.subSystem)
		effectConfig = setmetatable(effectConfig, {
			__index = {
				player = player,
				config = config
			}
		})

		function effectConfig:getPlayer()
			return self.player
		end

		function effectConfig:getConfig()
			return self.config
		end

		local effectClass = EffectCacheConfig:getEffectClass(EffectCacheType.kConsume)
		local effect = effectClass:new(effectConfig)

		if effect then
			effects[#effects + 1] = effect
		end
	end

	return effects
end

function SpecialEffectFormula:createPowerEffect(player, id, level)
	local effects = {}
	local config = ConfigReader:getRecordById("SkillSpecialEffect", id)
	local effectConfig = {
		value = SpecialEffectFormula:getAddNumByConfig(config, 1, level)
	}

	effectConfig = setmetatable(effectConfig, {
		__index = {
			player = player,
			config = config
		}
	})

	function effectConfig:getPlayer()
		return self.player
	end

	function effectConfig:getConfig()
		return self.config
	end

	local effectClass = EffectCacheConfig:getEffectClass(EffectCacheType.kPower)
	local effect = effectClass:new(effectConfig)

	if effect then
		effects[#effects + 1] = effect
	end

	return effects
end

function SpecialEffectFormula:createEffect(player, effectData)
	local id = effectData.id
	local level = effectData.level
	local config = ConfigReader:getRecordById("SkillSpecialEffect", id)

	if not config then
		return {}
	end

	assert(config ~= nil, "effectId =" .. tostring(effectId) .. " is not in SkillSpecialEffect Config")

	if config.EffectType == SpecialEffectType.kEnergy then
		return self:createEnergyEffect(player, id, level)
	elseif config.EffectType == SpecialEffectType.kConsume then
		return self:createConsumeEffect(player, id, level)
	elseif config.EffectType == SpecialEffectType.kPower then
		return self:createPowerEffect(player, id, level)
	end

	return {}
end
