-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/master/MasterAttribute.lua

MasterAttribute = MasterAttribute or {}
MasterAttribute.closeAddMasterAttr = false

function MasterAttribute:getStarRatio(star)
	local starConfig = ConfigReader:getRecordById("MasterStarRate", tostring(star))
	local ratio_atk = starConfig.StarFactorATK
	local basic_atk = starConfig.StarBaseValueATK
	local ratio_def = starConfig.StarFactorDEF
	local basic_def = starConfig.StarBaseValueDEF
	local ratio_hp = starConfig.StarFactorHP
	local basic_hp = starConfig.StarBaseValueHP

	return {
		ATK = ratio_atk,
		ATK_BASE = basic_atk,
		DEF = ratio_def,
		DEF_BASE = basic_def,
		HP = ratio_hp,
		HP_BASE = basic_hp
	}
end

function MasterAttribute:getBaseValueByAttType(masterPrototype, attrType)
	return masterPrototype:getBaseNumByType(attrType)
end

function MasterAttribute:getSpeedRatio(master)
	local factor1 = master:getAddAttrByType("SPEED")
	local factor2 = MasterAttribute:getLevelMasterExtraAttr(master:getLevel(), "SPEED")

	return factor1 + factor2
end

function MasterAttribute:getBaseAttEffectConfig(data, master)
	local attrNum = MasterAttribute:getBaseAttEffect(data, master)

	return {
		elementType = "a",
		effectEvn = "ALL",
		target = "SELF",
		attrType = data.attrType,
		attrNum = attrNum
	}
end

function MasterAttribute:getLevelMasterExtraAttr(level, attrType)
	local levelData = ConfigReader:getRecordById("LevelConfig", tostring(level)) or {}

	return levelData.MasterExtraAttr[attrType] or 0
end

function MasterAttribute:getLevelAttrRatio(level)
	local levelData = ConfigReader:getRecordById("LevelConfig", tostring(level)) or {}

	return levelData.MasterAttrFactor
end

function MasterAttribute:getBaseAttEffect(data, master)
	local masterPrototype = PrototypeFactory:getInstance():getMasterPrototype(data.id)
	local starRatio = MasterAttribute:getStarRatio(data.star)
	local baseValue = masterPrototype:getBaseNumByType(data.attrType)
	local baseRatioFactor = masterPrototype:getBaseRatioByType(data.attrType)
	local levelAttrsRatio = MasterAttribute:getLevelAttrRatio(data.lvl)
	local levelAttrsExtra = MasterAttribute:getLevelMasterExtraAttr(data.lvl, data.attrType)
	local factor1 = baseValue
	local key = data.attrType
	local baseKey = key .. "_BASE"

	if levelAttrsRatio then
		if not levelAttrsRatio[key] then
			local levelAttrRatio = 1
			local factor2 = (starRatio[baseKey] + starRatio[key] * data.lvl) * baseRatioFactor * levelAttrRatio

			return factor1 + factor2 + levelAttrsExtra
		end
	end
end

function MasterAttribute:getAttrNumByType(attrType, env, master)
	env = env or GameEnvType.kAll

	local attrsFlag = master:getAttrFlagByType(attrType)

	if attrsFlag then
		return attrsFlag
	end

	local masterAttrFactor = master:getAttrFactor()

	if not MasterAttribute.closeAddHeroAttr then
		MasterAttribute:attachAttrToMaster(env, master)
	end

	local masterConfig = master:getMasterPrototype():getConfig()
	local attrNum = 0

	if AttributeCategory:isAttrBaseType(attrType) then
		attrNum = MasterAttribute:getBaseAttrNumByType(attrType, masterAttrFactor, env)
	else
		local attrRateName = AttrName[attrType]

		if attrRateName and masterConfig[attrRateName] then
			attrNum = masterConfig[attrRateName]
		end

		attrNum = attrNum + MasterAttribute:getRateAttrNumByType(attrType, masterAttrFactor, env)
	end

	attrNum = attrNum + master:getAddAttrByType(attrType)

	master:setAttrFlagByType(attrType, attrNum)

	return attrNum
end

function MasterAttribute:attachAttrToMaster(env, master)
	env = env or GameEnvType.kAll

	local masterAttrFactor = master:getAttrFactor()

	master:getAttrFactor():reCreateAttr()

	local effectList = master:getEffectList()

	effectList:attachAttrToTarget(masterAttrFactor, env)

	local rangeEffectList = master:getPlayer():getEffectList()

	rangeEffectList:attachAttrToMaster(master, env)
end

function MasterAttribute:setAddMasterAttrState(isClose)
	MasterAttribute.closeAddMasterAttr = isClose
end

function MasterAttribute:getBaseAttrNumByType(attrType, attrFactor, env)
	local elementMap = attrFactor:getVector(attrType)
	local isAttrBaseType = AttributeCategory:isAttrBaseType(attrType)
	local result = elementMap.a * (1 + elementMap.b) + elementMap.c

	return result * (1 + elementMap.d) + elementMap.f
end

function MasterAttribute:getRateAttrNumByType(attrType, attrFactor, env)
	local elementMap = attrFactor:getVector(attrType)
	local isAttrBaseType = AttributeCategory:isAttrBaseType(attrType)
	local result = elementMap.a

	if env and env ~= GameEnvType.kAll then
		return result + elementMap.b
	end

	return result
end

MasterAttribute._cache_res = {}
MasterAttribute.masterCombatDesc = "单个主角战斗力=\n(攻击+防御+生命值*0.2)*\n(3+伤害率+免伤率+反弹率*0.6+吸血率*0.6)*\n(8+暴击率+抗暴率*0.7+暴击强度*0.4+格挡率+破击率*0.7+格挡强度*0.4)*\n(1+星级参数)*\n0.018+\n(伤害率+免伤率+反弹率+吸血率)*800+\n(暴击率+抗暴率+暴击强度+格挡率+破击率+格挡强度)*400"

function MasterAttribute:getAuraAttr(attrType, level, player)
	local key = attrType .. "_" .. tostring(level)
	local key_max = attrType .. "_" .. tostring(level - 1)
	local result = 0
	local config = ConfigReader:getRecordById("MasterAura", key) or ConfigReader:getRecordById("MasterAura", key_max)

	if config then
		local baseRate = config.BaseRate
		local emblemRate = config.EmblemRate
		local extraValue = config.ExtraValue
		local masterList = player:getMasterList()
		local baseEffect = 0
		local emblenEffect = 0
		local master

		for k, v in pairs(masterList:getMasterList()) do
			baseEffect = attrType == "SPEED" and baseEffect + v:getBaseSpeed() or baseEffect + v:getBaseAttrForAura(attrType)
			master = v
		end

		if master then
			emblenEffect = emblenEffect + master:getEmblemAttrByType(attrType)
		end

		result = baseEffect * baseRate + emblenEffect * emblemRate + extraValue
	end

	return result
end
