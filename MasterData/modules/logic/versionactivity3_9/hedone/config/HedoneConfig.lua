-- chunkname: @modules/logic/versionactivity3_9/hedone/config/HedoneConfig.lua

module("modules.logic.versionactivity3_9.hedone.config.HedoneConfig", package.seeall)

local HedoneConfig = class("HedoneConfig", BaseConfig)

function HedoneConfig:reqConfigNames()
	return {
		"activity220_hedone_const",
		"activity220_hedone_game",
		"activity220_hedone_wave",
		"activity220_hedone_monster_group",
		"activity220_hedone_monster",
		"activity220_hedone_attribute",
		"activity220_hedone_skill",
		"activity220_hedone_effect",
		"activity220_hedone_buff"
	}
end

function HedoneConfig:onInit()
	return
end

function HedoneConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function HedoneConfig:activity220_hedone_constConfigLoaded(configTable)
	self._constCacheDict = {}
end

function HedoneConfig:activity220_hedone_attributeConfigLoaded(configTable)
	self._ownerType2AttrIdList = {}

	for _, cfg in ipairs(configTable.configList) do
		local list = GameUtil.tabletool_checkDictTable(self._ownerType2AttrIdList, cfg.ownerType)

		list[#list + 1] = cfg.attrId
	end
end

function HedoneConfig:getHedoneConstCfg(constId, nilError)
	local cfg = lua_activity220_hedone_const.configDict[constId]

	if not cfg and nilError then
		logError(string.format("HedoneConfig:getHedoneConstCfg error, cfg is nil, constId:%s", constId))
	end

	return cfg
end

local CONST_CACHE_KEY = {}

local function _makeConstCacheKey(constId, isMLValue, isToNumber, delimiter)
	CONST_CACHE_KEY[1] = constId
	CONST_CACHE_KEY[2] = isMLValue and "1" or "0"
	CONST_CACHE_KEY[3] = isToNumber and "1" or "0"
	CONST_CACHE_KEY[4] = delimiter or "_"

	return (table.concat(CONST_CACHE_KEY, "#"))
end

function HedoneConfig:getHedoneConst(constId, isMLValue, isToNumber, delimiter)
	local cacheKey = _makeConstCacheKey(constId, isMLValue, isToNumber, delimiter)
	local cached = self._constCacheDict[cacheKey]

	if cached then
		return cached
	end

	local cfg = self:getHedoneConstCfg(constId, true)

	if not cfg then
		return
	end

	if isMLValue then
		if not cfg.mlvalue then
			local result = cfg.value
			local hasDelimiter = not string.nilorempty(delimiter)

			if hasDelimiter and isToNumber then
				result = string.splitToNumber(result, delimiter)
			elseif hasDelimiter then
				result = string.split(result, delimiter)
			elseif isToNumber then
				result = tonumber(result)
			end

			if result then
				self._constCacheDict[cacheKey] = result
			end

			return result
		end
	end
end

function HedoneConfig:getHedoneGameCfg(gameId, nilError)
	local cfg = lua_activity220_hedone_game.configDict[gameId]

	if not cfg and nilError then
		logError(string.format("HedoneConfig:getHedoneGameCfg error, cfg is nil, gameId:%s", gameId))
	end

	return cfg
end

function HedoneConfig:getHedoneGameTargetTime(gameId)
	local cfg = self:getHedoneGameCfg(gameId, true)

	return (cfg or nil) and (cfg.targetTime or 0)
end

function HedoneConfig:getHedoneGameWinDesc(gameId)
	local cfg = self:getHedoneGameCfg(gameId, true)

	return (cfg or nil) and (cfg.winDesc or "")
end

function HedoneConfig:getHedoneGamePlayerBaseAttr(gameId)
	local cfg = self:getHedoneGameCfg(gameId, true)

	return (cfg and not string.nilorempty(cfg.playerBaseAttr) or nil) and string.splitToNumber(cfg.playerBaseAttr, "#")
end

function HedoneConfig:getHedoneGameLevelWaves(gameId)
	local result = {}
	local cfg = self:getHedoneGameCfg(gameId, true)

	if cfg and not string.nilorempty(cfg.levelWaves) then
		local arr = GameUtil.splitString2(cfg.levelWaves, true)

		for _, data in ipairs(arr) do
			result[#result + 1] = {
				time = data[1],
				waveId = data[2]
			}
		end
	end

	return result
end

function HedoneConfig:getHedoneGameMonsterGrowPerSecond(gameId)
	local cfg = self:getHedoneGameCfg(gameId, true)

	return (cfg or nil) and (cfg.monsterGrowPerSecond or 0)
end

function HedoneConfig:getHedoneWaveCfg(waveId, nilError)
	local cfg = lua_activity220_hedone_wave.configDict[waveId]

	if not cfg and nilError then
		logError(string.format("HedoneConfig:getHedoneWaveCfg error, cfg is nil, waveId:%s", waveId))
	end

	return cfg
end

function HedoneConfig:getHedoneWaveRandomType(waveId)
	local cfg = self:getHedoneWaveCfg(waveId, true)

	return cfg and cfg.randomType
end

function HedoneConfig:getHedoneWaveRandomParam(waveId)
	local cfg = self:getHedoneWaveCfg(waveId, true)

	return cfg and cfg.randomParam
end

function HedoneConfig:getHedoneWaveIsBossWave(waveId)
	local cfg = self:getHedoneWaveCfg(waveId, true)

	return cfg and cfg.isBossWave
end

function HedoneConfig:getHedoneMonsterGroupCfg(groupId, nilError)
	local cfg = lua_activity220_hedone_monster_group.configDict[groupId]

	if not cfg and nilError then
		logError(string.format("HedoneConfig:getHedoneMonsterGroupCfg error, cfg is nil, groupId:%s", groupId))
	end

	return cfg
end

function HedoneConfig:getHedoneMonsterGroupWeight(groupId)
	local cfg = self:getHedoneMonsterGroupCfg(groupId, true)

	return (cfg or nil) and (cfg.weight or 0)
end

function HedoneConfig:getHedoneMonsterGroupBaseAttrFactor(groupId)
	local cfg = self:getHedoneMonsterGroupCfg(groupId, true)

	return (cfg or nil) and (cfg.baseAttrFactor or 1)
end

function HedoneConfig:getHedoneMonsterGroupMonsters(groupId)
	local result = {}
	local cfg = self:getHedoneMonsterGroupCfg(groupId, true)

	if cfg and not string.nilorempty(cfg.monsters) then
		local arr = GameUtil.splitString2(cfg.monsters, true)

		for _, data in ipairs(arr) do
			result[#result + 1] = {
				monsterId = data[1],
				count = data[2]
			}
		end
	end

	return result
end

function HedoneConfig:getHedoneMonsterGroupIdListByType(groupType)
	if not self._type2GroupIdList then
		self._type2GroupIdList = {}

		local cfgList = lua_activity220_hedone_monster_group.configList

		for _, cfg in ipairs(cfgList) do
			local list = GameUtil.tabletool_checkDictTable(self._type2GroupIdList, cfg.type)

			list[#list + 1] = cfg.id
		end
	end

	return self._type2GroupIdList[groupType]
end

function HedoneConfig:getHedoneMonsterCfg(monsterId, nilError)
	local cfg = lua_activity220_hedone_monster.configDict[monsterId]

	if not cfg and nilError then
		logError(string.format("HedoneConfig:getHedoneMonsterCfg error, cfg is nil, monsterId:%s", monsterId))
	end

	return cfg
end

function HedoneConfig:getHedoneMonsterBaseAttr(monsterId)
	local cfg = self:getHedoneMonsterCfg(monsterId, true)

	return (cfg and not string.nilorempty(cfg.baseAttr) or nil) and string.splitToNumber(cfg.baseAttr, "#")
end

function HedoneConfig:getHedoneMonsterImage(monsterId)
	local cfg = self:getHedoneMonsterCfg(monsterId, true)

	return cfg and cfg.image
end

function HedoneConfig:getHedoneMonsterMoveSpeed(monsterId)
	local cfg = self:getHedoneMonsterCfg(monsterId, true)

	return (cfg or nil) and (cfg.moveSpeed or 0)
end

function HedoneConfig:getHedoneMonsterScale(monsterId)
	local cfg = self:getHedoneMonsterCfg(monsterId, true)

	return (cfg or nil) and (cfg.scale or 1)
end

function HedoneConfig:getHedoneMonsterExp(monsterId)
	local cfg = self:getHedoneMonsterCfg(monsterId, true)

	return (cfg or nil) and (cfg.exp or 0)
end

function HedoneConfig:getHedoneMonsterIsShowHp(monsterId)
	local cfg = self:getHedoneMonsterCfg(monsterId, true)

	return cfg and cfg.showHp
end

function HedoneConfig:getHedoneAttributeCfg(attrId, nilError)
	local cfg = lua_activity220_hedone_attribute.configDict[attrId]

	if not cfg and nilError then
		logError(string.format("HedoneConfig:getHedoneAttributeCfg error, cfg is nil, attrId:%s", attrId))
	end

	return cfg
end

function HedoneConfig:getHedoneAttributeName(attrId)
	local cfg = self:getHedoneAttributeCfg(attrId, true)

	return cfg and cfg.name
end

function HedoneConfig:getHedoneAttributeOwnerType(attrId)
	local cfg = self:getHedoneAttributeCfg(attrId, true)

	return cfg and cfg.ownerType
end

function HedoneConfig:getHedoneAttributeIsNeedSubId(attrId)
	local attrOwnerType = self:getHedoneAttributeOwnerType(attrId)

	return attrOwnerType and attrOwnerType ~= HedoneGameEnum.AttributeOwnerType.Unit
end

function HedoneConfig:getHedoneAttributeMin(attrId)
	local cfg = self:getHedoneAttributeCfg(attrId, true)

	return (cfg or nil) and (cfg.min or 0)
end

function HedoneConfig:getHedoneAttributeMax(attrId)
	local cfg = self:getHedoneAttributeCfg(attrId, true)

	return (cfg or nil) and (cfg.max or 0)
end

function HedoneConfig:getHedoneAttributeDefaultValue(attrId)
	local cfg = self:getHedoneAttributeCfg(attrId, true)

	return (cfg or nil) and (cfg.defaultValue or 0)
end

function HedoneConfig:getHedoneSkillCfg(skillId, nilError)
	local cfg = lua_activity220_hedone_skill.configDict[skillId]

	if not cfg and nilError then
		logError(string.format("HedoneConfig:getHedoneSkillCfg error, cfg is nil, skillId:%s", skillId))
	end

	return cfg
end

function HedoneConfig:getHedoneSkillName(skillId)
	local cfg = self:getHedoneSkillCfg(skillId, true)

	return cfg and cfg.name
end

function HedoneConfig:getHedoneSkillDesc(skillId)
	local cfg = self:getHedoneSkillCfg(skillId, true)

	return (cfg or nil) and (cfg.desc or "")
end

function HedoneConfig:getHedoneSkillType(skillId)
	local cfg = self:getHedoneSkillCfg(skillId, true)

	return cfg and cfg.skillType
end

function HedoneConfig:getHedoneSkillTagList(skillId)
	local result
	local cfg = self:getHedoneSkillCfg(skillId, true)
	local strTags = cfg and cfg.tags

	return (not string.nilorempty(strTags) or nil) and string.split(strTags, "#") or {}
end

function HedoneConfig:getHedoneSkillCd(skillId)
	local cfg = self:getHedoneSkillCfg(skillId, true)

	return (cfg or nil) and (cfg.cd or 0)
end

function HedoneConfig:getHedoneSkillUnlockGameId(skillId)
	local cfg = self:getHedoneSkillCfg(skillId, true)

	return cfg and cfg.unlockGameId
end

function HedoneConfig:getHedoneSkillConflictSkillList(skillId)
	local cfg = self:getHedoneSkillCfg(skillId, true)

	return (cfg and not string.nilorempty(cfg.conflictSkills) or nil) and string.splitToNumber(cfg.conflictSkills, "#")
end

function HedoneConfig:getHedoneSkillUnlockTypeCountList(skillId)
	local result = {}
	local cfg = self:getHedoneSkillCfg(skillId, true)

	if cfg and not string.nilorempty(cfg.unlockTypeCount) then
		local defaultType = self:getHedoneSkillType(skillId)
		local arr = GameUtil.splitString2(cfg.unlockTypeCount, true)

		for _, data in ipairs(arr) do
			if #data > 1 then
				result[#result + 1] = {
					type = data[1],
					count = data[2]
				}
			elseif defaultType then
				result[#result + 1] = {
					type = defaultType,
					count = data[1]
				}
			end
		end
	end

	return result
end

function HedoneConfig:getHedoneSkillRare(skillId)
	local cfg = self:getHedoneSkillCfg(skillId, true)

	return cfg and cfg.rare
end

function HedoneConfig:getHedoneSkillIsUnique(skillId)
	local cfg = self:getHedoneSkillCfg(skillId, true)

	return cfg and cfg.isUnique
end

function HedoneConfig:getHedoneSkillWeight(skillId)
	local cfg = self:getHedoneSkillCfg(skillId, true)

	return (cfg or nil) and (cfg.weight or 0)
end

function HedoneConfig:getHedoneSkillIcon(skillId)
	local cfg = self:getHedoneSkillCfg(skillId, true)

	return cfg and cfg.icon
end

function HedoneConfig:getHedoneSkillBullet(skillId)
	local cfg = self:getHedoneSkillCfg(skillId, true)

	return cfg and cfg.bullet
end

function HedoneConfig:getHedoneSkillFindTarget(skillId)
	local cfg = self:getHedoneSkillCfg(skillId, true)

	return cfg and cfg.findTarget
end

function HedoneConfig:getHedoneSkillTypeIsNeedLinkBullet(skillType)
	if not self._needLinkBulletSkillTypeDict then
		self._needLinkBulletSkillTypeDict = {}

		local skillTypeList = self:getHedoneConst(HedoneEnum.ConstId.LinkNeedBulletSkillType, false, true, "#")

		for _, tSkillType in ipairs(skillTypeList) do
			self._needLinkBulletSkillTypeDict[tSkillType] = true
		end
	end

	return self._needLinkBulletSkillTypeDict[skillType]
end

function HedoneConfig:getHedoneSkillIdListByRare(rare)
	if not self._rare2SkillIdList then
		self._rare2SkillIdList = {}

		for _, cfg in ipairs(lua_activity220_hedone_skill.configList) do
			local list = GameUtil.tabletool_checkDictTable(self._rare2SkillIdList, cfg.rare)

			list[#list + 1] = cfg.skillId
		end
	end

	return rare and self._rare2SkillIdList[rare]
end

function HedoneConfig:getHedoneAllSkillTypeList()
	if not self._allSkillTypeList then
		self._allSkillTypeList = {}

		local existDict = {}

		for _, cfg in ipairs(lua_activity220_hedone_skill.configList) do
			local skillType = cfg.skillType

			if skillType and not existDict[skillType] then
				existDict[skillType] = true
				self._allSkillTypeList[#self._allSkillTypeList + 1] = skillType
			end
		end
	end

	return self._allSkillTypeList
end

function HedoneConfig:getCDSKillIdByType(argsType)
	if not self._type2CDSKillIdDict then
		self._type2CDSKillIdDict = {}

		for _, cfg in ipairs(lua_activity220_hedone_skill.configList) do
			if cfg.cd and cfg.cd > 0 then
				local skillType = cfg.skillType

				self._type2CDSKillIdDict[skillType] = cfg.skillId
			end
		end
	end

	return self._type2CDSKillIdDict[argsType]
end

function HedoneConfig:getHedoneEffectCfg(effectId, nilError)
	local cfg = lua_activity220_hedone_effect.configDict[effectId]

	if not cfg and nilError then
		logError(string.format("HedoneConfig:getHedoneEffectCfg error, cfg is nil, effectId:%s", effectId))
	end

	return cfg
end

function HedoneConfig:getHedoneEffectGroup(effectId)
	local cfg = self:getHedoneEffectCfg(effectId, true)

	return cfg and cfg.effectGroup
end

function HedoneConfig:getHedoneEffectType(effectId)
	local cfg = self:getHedoneEffectCfg(effectId, true)

	return cfg and cfg.effectType
end

function HedoneConfig:getHedoneEffectParam(effectId)
	local cfg = self:getHedoneEffectCfg(effectId, true)

	return cfg and cfg.effectParam
end

function HedoneConfig:getHedoneEffectIsDetachedEff(effectId)
	local cfg = self:getHedoneEffectCfg(effectId, true)

	return cfg and cfg.isDetachedEff
end

function HedoneConfig:getHedoneEffectEntityRes(effectId)
	local cfg = self:getHedoneEffectCfg(effectId, true)

	return cfg and cfg.entityRes
end

function HedoneConfig:getHedoneEffectIgnoreSelf(effectId)
	local cfg = self:getHedoneEffectCfg(effectId, true)

	return cfg and cfg.ignoreSelf
end

function HedoneConfig:getHedoneEffectLifeRule(effectId)
	local cfg = self:getHedoneEffectCfg(effectId, true)

	return cfg and cfg.lifeRule
end

function HedoneConfig:getHedoneEffectLifeParam(effectId)
	local cfg = self:getHedoneEffectCfg(effectId, true)

	return (cfg or nil) and (cfg.lifeParam or 0)
end

function HedoneConfig:getHedoneEffectTriggerInterval(effectId)
	local cfg = self:getHedoneEffectCfg(effectId, true)

	return (cfg or nil) and (cfg.triggerInterval or 0)
end

function HedoneConfig:getHedoneEffectRange(effectId)
	local cfg = self:getHedoneEffectCfg(effectId, true)

	return (cfg or nil) and (cfg.range or 0)
end

function HedoneConfig:getHedoneEffectValueMul(effectId)
	local cfg = self:getHedoneEffectCfg(effectId, true)

	return (cfg or nil) and (cfg.valueMul or 0)
end

function HedoneConfig:getHedoneEffectTriggerEffect(effectId)
	local cfg = self:getHedoneEffectCfg(effectId, true)

	return cfg and cfg.triggerEffect
end

function HedoneConfig:getHedoneEffectTriggerEffectDuration(effectId)
	local cfg = self:getHedoneEffectCfg(effectId, true)

	return cfg and cfg.triggerEffectDuration
end

function HedoneConfig:getHedoneEffectHitEffect(effectId)
	local cfg = self:getHedoneEffectCfg(effectId, true)

	return cfg and cfg.hitEffect
end

function HedoneConfig:getHedoneEffectHitAudio(effectId)
	local cfg = self:getHedoneEffectCfg(effectId, true)

	return cfg and cfg.hitAudio
end

function HedoneConfig:getHedoneAllEffectGroupList()
	if not self._allEffectGroupList then
		self._allEffectGroupList = {}

		local existDict = {}

		for _, cfg in ipairs(lua_activity220_hedone_effect.configList) do
			local effectGroup = cfg.effectGroup

			if effectGroup and not existDict[effectGroup] then
				existDict[effectGroup] = true
				self._allEffectGroupList[#self._allEffectGroupList + 1] = effectGroup
			end
		end
	end

	return self._allEffectGroupList
end

function HedoneConfig:getHedoneBuffCfg(buffId, nilError)
	local cfg = lua_activity220_hedone_buff.configDict[buffId]

	if not cfg and nilError then
		logError(string.format("HedoneConfig:getHedoneBuffCfg error, cfg is nil, buffId:%s", buffId))
	end

	return cfg
end

function HedoneConfig:getHedoneBuffLifeRule(buffId)
	local cfg = self:getHedoneBuffCfg(buffId, true)

	return cfg and cfg.lifeRule
end

function HedoneConfig:getHedoneBuffSubLifeRule(buffId)
	local cfg = self:getHedoneBuffCfg(buffId, true)

	return cfg and cfg.subLifeRule
end

function HedoneConfig:getHedoneBuffLifeParam(buffId)
	local cfg = self:getHedoneBuffCfg(buffId, true)

	return (cfg or nil) and (cfg.lifeParam or 0)
end

function HedoneConfig:getHedoneBuffAffectType(buffId)
	local cfg = self:getHedoneBuffCfg(buffId, true)

	return cfg and cfg.affectType
end

function HedoneConfig:getHedoneBuffAffectParam(buffId)
	local cfg = self:getHedoneBuffCfg(buffId, true)

	return cfg and cfg.affectParam
end

function HedoneConfig:getHedoneOwnerAttrIdList(ownerType)
	return self._ownerType2AttrIdList and self._ownerType2AttrIdList[ownerType]
end

HedoneConfig.instance = HedoneConfig.New()

return HedoneConfig
