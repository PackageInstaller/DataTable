-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/base/prototype/SkillPrototype.lua

SkillPrototype = class("SkillPrototype", objectlua.Object, _M)

SkillPrototype:has("_id", {
	is = "r"
})
SkillPrototype:has("_config", {
	is = "r"
})

function SkillPrototype:initialize(configId)
	super.initialize(self)

	self._id = configId

	if self._id == nil then
		self._id = ""
	end

	self._config = ConfigReader:getRecordById("Skill", configId)

	assert(self._config ~= nil, "Skill with skillId=" .. self._id .. " ,config not exsits")
end

function SkillPrototype:getBattleSkillData(level, enemyBuff)
	local args = {}

	for _, param in ipairs(self._config.Args or {}) do
		local id = param.id
		local enum = param.type
		local value = param.value
		local zoom = param.zoom

		if enum == "FIXED" then
			args[id] = value[1]
		elseif enum == "CUSTOM" then
			args[id] = value[level]
		elseif enum == "LINEAR" then
			args[id] = value[1] + (level - 1) * value[2]
		end

		if enemyBuff and enemyBuff.useZoom and enemyBuff.useZoom == 1 and zoom and zoom ~= "" then
			zoom = zoom <= 0 and 1 or zoom
			args[id] = value[level] * tonumber(zoom)
		end
	end

	if args.dmgFactor1 ~= nil and args.dmgFactor2 ~= nil and args.dmgFactor3 ~= nil then
		args.dmgFactor = {
			args.dmgFactor1,
			args.dmgFactor2,
			args.dmgFactor3
		}
	end

	if enemyBuff then
		for k, v in pairs(enemyBuff) do
			args[k] = v
		end
	end

	return {
		id = self._id,
		level = level or 1,
		args = args,
		icon = self._config.Icon,
		dblrate = self._config.SkillDoubleRate,
		dblhit = self._config.AllowDoubleHit,
		behit = self._config.AllowCounterHit,
		proto = self._config.Actions,
		cost = self._config.Cost,
		summoned = self._config.Summoned,
		range = self._config.SkillRange,
		notAskForTarget = self._config.NotAskForTarget,
		skillType = self._config.SkillType
	}
end

function SkillPrototype:getDoubleRate()
	return self._config.SkillDoubleRate or nil
end

function SkillPrototype:getCanDoubleHit()
	return self._config.AllowDoubleHit or nil
end

function SkillPrototype:getCanHitBack()
	return self._config.AllowCounterHit or nil
end

function SkillPrototype:getAttrDescs(level, style)
	level = level or 0

	if not self._config.AttrEffects then
		local effects = {}
		local descList = {}

		for i = 1, #effects do
			descList[#descList + 1] = SkillPrototype:getAttrEffectDesc(effects[i], level, style)
		end

		return descList
	end
end

function SkillPrototype.class:getDescFactorTable(config, descIndex)
	if not config or not descIndex then
		return {}
	end

	local baseEvn = {
		descIndex = config
	}
	local funcStr = string.gsub(descIndex, "%$", "descIndex.")

	funcStr = string.gsub(funcStr, ";", ",")
	funcStr = "return {" .. funcStr .. "}"

	local factorMap = {}
	local condFn, errmsg = loadstring(funcStr)

	if condFn ~= nil then
		setfenv(condFn, baseEvn)

		factorMap = condFn()
	end

	return factorMap
end

function SkillPrototype.class:getEffectDesc(effectId, level)
	local effectConfig = ConfigReader:getRecordById("SkillAttrEffect", effectId)
	local descIndex = effectConfig.DescIndex
	local factorMap = SkillPrototype:getDescFactorTable(effectConfig, descIndex)
	local desc = Strings:get(effectConfig.EffectDesc)
	local t = TextTemplate:new(desc)
	local funcMap = {
		linear = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[1] + (level - 1) * value[2]
		end,
		fixed = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[1]
		end,
		custom = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[level]
		end
	}

	return t:stringify(factorMap, funcMap)
end

function SkillPrototype.class:getSkillEffectDesc(effectId, level, style)
	style = style or {}
	style.fontName = style.fontName or TTF_FONT_FZYH_R
	style.fontSize = style.fontSize or 18
	style.fontColor = style.fontColor or "#FFFFFF"

	local effectConfig = ConfigReader:getRecordById("Skill", effectId)
	local desc = Strings:get(effectConfig.Desc, style)
	local t = TextTemplate:new(desc)

	return t:stringify(effectConfig, SkillPrototype:getEffectDescFactorFunc(level))
end

function SkillPrototype.class:getEffectDescFactorFunc(level)
	return {
		linear = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[1] + (level - 1) * value[2]
		end,
		fixed = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[1]
		end,
		custom = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return (value[level] or nil) and (value[level] or 0)
		end,
		getSkillName = function(value)
			local skill = ConfigReader:getRecordById("Skill", value)

			return skill ~= nil and Strings:get(skill.Name) or "null"
		end,
		HeroName = function(value)
			local heroConfig = ConfigReader:getRecordById("HeroBase", value)

			return heroConfig ~= nil and Strings:get(heroConfig.Name) or "null"
		end
	}
end

function SkillPrototype.class:getAttrEffectDesc(effectId, level, style)
	style = style or {}
	style.fontName = style.fontName or TTF_FONT_FZYH_R
	style.fontSize = style.fontSize or 18
	style.fontColor = style.fontColor or "#FFFFFF"

	local effectConfig = ConfigReader:getRecordById("SkillAttrEffect", effectId)
	local desc = Strings:get(effectConfig.EffectDesc, style)
	local t = TextTemplate:new(desc)

	return t:stringify(effectConfig, SkillPrototype:getEffectDescFactorFunc(level))
end

local AttAddEffectType = {
	kGrowByLevel = "LINEAR",
	kGrowByConfig = "CUSTOM",
	kSingleValue = "FIXED"
}

function SkillPrototype.class:getAddNumByConfig(config, configIndex, level)
	local growType = config.GrowType
	local addNumData = config.Value[configIndex]

	if growType == AttAddEffectType.kSingleValue then
		return addNumData[1]
	elseif growType == AttAddEffectType.kGrowByLevel then
		return addNumData[1] + (level - 1) * addNumData[2]
	elseif growType == AttAddEffectType.kGrowByConfig then
		return (addNumData[level] or nil) and (addNumData[level] or 0)
	end
end
