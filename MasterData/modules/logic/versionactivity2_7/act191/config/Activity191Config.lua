-- chunkname: @modules/logic/versionactivity2_7/act191/config/Activity191Config.lua

module("modules.logic.versionactivity2_7.act191.config.Activity191Config", package.seeall)

local Activity191Config = class("Activity191Config", BaseConfig)

function Activity191Config:reqConfigNames()
	return {
		"activity191_const",
		"activity191_init_build",
		"activity191_node",
		"activity191_badge",
		"activity191_stage",
		"activity191_role",
		"activity191_collection",
		"activity191_template",
		"activity191_relation",
		"activity191_assist_boss",
		"activity191_enhance",
		"activity191_shop",
		"activity191_event",
		"activity191_fight_event",
		"activity191_match_rank",
		"activity191_pvp_match",
		"activity191_rank",
		"activity191_effect",
		"activity191_item",
		"activity191_ex_level",
		"activity191_eff_desc",
		"activity191_relation_select",
		"activity191_summon"
	}
end

function Activity191Config:onInit()
	return
end

function Activity191Config:onConfigLoaded(configName, configTable)
	if configName == "activity191_role" then
		self._roleCfgList = {}
		self._roleId2CfgMap = {}

		for _, v in ipairs(configTable.configList) do
			local actId = v.activityId

			self._roleCfgList[actId] = self._roleCfgList[actId] or {}

			table.insert(self._roleCfgList[actId], v)

			self._roleId2CfgMap[actId] = self._roleId2CfgMap[actId] or {}
			self._roleId2CfgMap[actId][v.roleId] = self._roleId2CfgMap[actId][v.roleId] or {}
			self._roleId2CfgMap[actId][v.roleId][v.star] = v
		end
	elseif configName == "activity191_enhance" then
		self._enhanceCfgMap = {}

		for _, v in ipairs(configTable.configList) do
			local actId = v.activityId

			self._enhanceCfgMap[actId] = self._enhanceCfgMap[actId] or {}
			self._enhanceCfgMap[actId][v.id] = v
		end
	elseif configName == "activity191_relation" then
		self._relationCfgMap = {}

		for _, v in ipairs(configTable.configList) do
			local actId = v.activityId

			self._relationCfgMap[actId] = self._relationCfgMap[actId] or {}
			self._relationCfgMap[actId][v.tag] = self._relationCfgMap[actId][v.tag] or {}
			self._relationCfgMap[actId][v.tag][v.level] = v
		end
	elseif configName == "activity191_assist_boss" then
		self._bossCfgMap = {}

		for _, v in ipairs(configTable.configList) do
			local actId = v.activityId
			local tag = v.relation

			self._bossCfgMap[actId] = self._bossCfgMap[actId] or {}
			self._bossCfgMap[actId][tag] = self._bossCfgMap[actId][tag] or {}

			table.insert(self._bossCfgMap[actId][tag], v)
		end

		for _, v1 in pairs(self._bossCfgMap) do
			for _, v2 in pairs(v1) do
				table.sort(v2, function(a, b)
					return a.bossId < b.bossId
				end)
			end
		end
	end
end

function Activity191Config:getRoleCoByNativeId(roleId, star, try)
	local actId = Activity191Model.instance:getCurActId()
	local actCfgs = self._roleId2CfgMap[actId]

	if actCfgs and actCfgs[roleId] and actCfgs[roleId][star] then
		return actCfgs[roleId][star]
	elseif not try then
		logError(string.format("斗蛐蛐养成表_角色表找不到配置 : 活动ID %s 角色ID %s 星级 %s", actId, roleId, star))
	end
end

function Activity191Config:getRoleCo(id)
	id = tonumber(id)

	local config = lua_activity191_role.configDict[id]

	if config then
		return config
	else
		logError(string.format("斗蛐蛐养成表_角色表找不到配置ID: %s", id))
	end
end

function Activity191Config:getShowRoleCoList(actId)
	local list = {}

	if self._roleCfgList[actId] then
		for _, config in ipairs(self._roleCfgList[actId]) do
			if config.star == 1 then
				list[#list + 1] = config
			end
		end

		table.sort(list, Activity191Helper.sortRoleCo)
	end

	return list
end

function Activity191Config:getCollectionCo(itemId)
	local config = lua_activity191_collection.configDict[itemId]

	if config then
		return config
	else
		logError(string.format("找不到造物配置 ： 造物ID %s", itemId))
	end
end

function Activity191Config:getEnhanceCo(actId, enhanceId)
	local actCfgs = self._enhanceCfgMap[actId]

	if actCfgs and actCfgs[enhanceId] then
		return actCfgs[enhanceId]
	else
		logError(string.format("找不到强化配置 ： 强化ID %s", enhanceId))
	end
end

function Activity191Config:getRelationCoList(tag)
	local actId = Activity191Model.instance:getCurActId()
	local actCfgs = self._relationCfgMap[actId]

	if actCfgs and actCfgs[tag] then
		return actCfgs[tag]
	else
		logError(string.format("找不到羁绊配置 ： 羁绊Tag %s", tag))
	end
end

function Activity191Config:getRelationCo(tag, level)
	level = level or 0

	local actId = Activity191Model.instance:getCurActId()
	local cfgMap = self._relationCfgMap[actId]

	if cfgMap and cfgMap[tag] and cfgMap[tag][level] then
		return cfgMap[tag][level]
	else
		logError(string.format("找不到羁绊配置 ： 羁绊Tag %s   羁绊等级 %s", tag, level))
	end
end

function Activity191Config:getRelationMaxCo(tag)
	local coList = self:getRelationCoList(tag)

	return coList[#coList]
end

function Activity191Config:getHeroPassiveSkillIdList(id)
	local roleCo = self:getRoleCo(id)

	if string.nilorempty(roleCo.passiveSkill) then
		local skillIdList = {}
		local passiveSkillCoDict = SkillConfig.instance:getPassiveSKillsCoByExSkillLevel(roleCo.roleId, roleCo.exLevel)

		for k, co in pairs(passiveSkillCoDict) do
			skillIdList[k] = co.skillPassive
		end

		return skillIdList
	else
		return string.splitToNumber(roleCo.passiveSkill, "|")
	end
end

function Activity191Config:getHeroSkillIdDic(id, single)
	local heroCo = self:getRoleCo(id)

	if string.nilorempty(heroCo.activeSkill1) then
		local heroId = heroCo.roleId
		local exSkillLevel = math.min(heroCo.exLevel, CharacterEnum.MaxSkillExLevel)

		if single then
			local baseSkillIdDict = SkillConfig.instance:getHeroBaseSkillIdDict(heroId)

			if exSkillLevel < 1 then
				return baseSkillIdDict
			end

			local skillExLevelCo

			for i = 1, exSkillLevel do
				skillExLevelCo = self:getHeroLevelExSkillCo(id, i)

				if not string.nilorempty(skillExLevelCo.skillGroup1) then
					baseSkillIdDict[1] = string.splitToNumber(skillExLevelCo.skillGroup1, "|")[1]
				end

				if not string.nilorempty(skillExLevelCo.skillGroup2) then
					baseSkillIdDict[2] = string.splitToNumber(skillExLevelCo.skillGroup2, "|")[1]
				end

				if skillExLevelCo.skillEx ~= 0 then
					baseSkillIdDict[3] = skillExLevelCo.skillEx
				end
			end

			return baseSkillIdDict
		else
			local allSkillIdDict = SkillConfig.instance:getHeroAllSkillIdDict(heroId)

			if exSkillLevel < 1 then
				return allSkillIdDict
			end

			local skillExLevelCo

			for i = 1, exSkillLevel do
				skillExLevelCo = self:getHeroLevelExSkillCo(id, i)

				if not string.nilorempty(skillExLevelCo.skillGroup1) then
					allSkillIdDict[1] = string.splitToNumber(skillExLevelCo.skillGroup1, "|")
				end

				if not string.nilorempty(skillExLevelCo.skillGroup2) then
					allSkillIdDict[2] = string.splitToNumber(skillExLevelCo.skillGroup2, "|")
				end

				if skillExLevelCo.skillEx ~= 0 then
					allSkillIdDict[3] = {
						skillExLevelCo.skillEx
					}
				end
			end

			return allSkillIdDict
		end
	else
		local skillIdDic = {}
		local skillList1 = string.splitToNumber(heroCo.activeSkill1, "#")
		local skillList2 = GameUtil.splitString2(heroCo.activeSkill2, true, ",", "#")[1]

		if single then
			skillIdDic[1] = skillList1[1]
			skillIdDic[2] = skillList2[1]
			skillIdDic[3] = heroCo.uniqueSkill
		else
			skillIdDic[1] = skillList1
			skillIdDic[2] = skillList2
			skillIdDic[3] = {
				heroCo.uniqueSkill
			}
		end

		return skillIdDic
	end
end

function Activity191Config:getHeroLevelExSkillCo(id, skillIndex)
	local heroCo = self:getRoleCo(id)

	if heroCo.type == Activity191Enum.CharacterType.Hero then
		return SkillConfig.instance:getherolevelexskillCO(heroCo.roleId, skillIndex)
	else
		local exSkillCoDict = lua_activity191_ex_level.configDict[heroCo.roleId]

		if not exSkillCoDict then
			logError(string.format("ex skill not found heroid : %s `s config ", heroCo.roleId))

			return nil
		end

		local exSkillCo = exSkillCoDict[skillIndex]

		if exSkillCo == nil then
			logError(string.format("ex skill config gei nil, heroid : %s, skillLevel : %s", heroCo.roleId, skillIndex))
		end

		return exSkillCoDict[skillIndex]
	end
end

function Activity191Config:getExSkillDesc(skillExCo, id)
	if skillExCo == nil then
		return ""
	end

	local desc = skillExCo.desc
	local _, _, skillIndex = string.find(desc, "▩(%d)%%s")

	if not skillIndex then
		logError("not fount skillIndex in desc : " .. desc)

		return desc
	end

	skillIndex = tonumber(skillIndex)

	local skillId = skillIndex == 0 and self:getHeroPassiveSkillIdList(id)[1] or self:getHeroSkillIdDic(id, true)[skillIndex]

	if not skillId then
		logError("not fount skillId, skillIndex : " .. skillIndex)

		return desc
	end

	return desc, lua_skill.configDict[skillId].name, skillIndex
end

function Activity191Config:getFetterHeroList(tag, actId)
	local list = {}
	local roleCoList = lua_activity191_role.configList

	for _, roleCo in ipairs(roleCoList) do
		if roleCo.activityId == actId and roleCo.star == 1 then
			local fetterArr = string.split(roleCo.tag, "#")

			if tabletool.indexOf(fetterArr, tag) then
				list[#list + 1] = {
					inBag = 1,
					transfer = 0,
					config = roleCo
				}
			end
		end
	end

	table.sort(list, Activity191Helper.sortFetterHeroList)

	return list
end

function Activity191Config:getEffDescCfgByName(name)
	for _, v in ipairs(lua_activity191_eff_desc.configList) do
		if v.name == name then
			return v
		end
	end

	logError(string.format("斗蛐蛐显示表_效果概要表找不到配置Name: %s", name))
end

Activity191Config.AttrIdToFieldName = {
	[CharacterEnum.AttrId.Attack] = "attack",
	[CharacterEnum.AttrId.Defense] = "defense",
	[CharacterEnum.AttrId.Technic] = "technic",
	[CharacterEnum.AttrId.Hp] = "life",
	[CharacterEnum.AttrId.Mdefense] = "mdefense"
}

function Activity191Config:getBossCfgMap()
	local actId = Activity191Model.instance:getCurActId()

	if self._bossCfgMap[actId] then
		return self._bossCfgMap[actId]
	else
		logError("协战Boss无配置,活动ID: " .. actId)
	end
end

function Activity191Config:getSummonCfg(bossId)
	local summonCfg = lua_activity191_summon.configDict[bossId]

	if summonCfg then
		return summonCfg
	else
		logError(string.format("斗蛐蛐召唤物表 id : %s 找不到对应配置", bossId))
	end
end

function Activity191Config:getStageCfg(actId, stageId)
	local stageMap = lua_activity191_stage.configDict[actId]

	if stageMap and stageMap[stageId] then
		return stageMap[stageId]
	else
		logError(string.format("斗蛐蛐流程表_阶段表不存在配置 活动ID: %s 阶段ID: %s", actId, stageId))
	end
end

function Activity191Config:getRankCfg(rank)
	local rankCfg = lua_activity191_rank.configDict[rank]

	if rankCfg then
		return rankCfg
	else
		logError(string.format("斗蛐蛐事件表_战力等级表不存在配置 战力等级: %s", rank))
	end
end

Activity191Config.instance = Activity191Config.New()

return Activity191Config
