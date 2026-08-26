-- chunkname: @modules/logic/equip/config/EquipConfig.lua

module("modules.logic.equip.config.EquipConfig", package.seeall)

local EquipConfig = class("EquipConfig", BaseConfig)

function EquipConfig:reqConfigNames()
	return {
		"equip",
		"equip_strengthen",
		"equip_strengthen_cost",
		"equip_break_cost",
		"equip_const",
		"equip_skill",
		"equip_tag",
		"equip_trial",
		"equip_break_attr"
	}
end

function EquipConfig:onInit()
	return
end

EquipConfig.MaxLevel = 60
EquipConfig.EquipBreakAttrIdToFieldName = {
	[CharacterEnum.AttrId.Attack] = "attack",
	[CharacterEnum.AttrId.Hp] = "hp",
	[CharacterEnum.AttrId.Defense] = "def",
	[CharacterEnum.AttrId.Mdefense] = "mdef",
	[CharacterEnum.AttrId.Cri] = "cri",
	[CharacterEnum.AttrId.Recri] = "recri",
	[CharacterEnum.AttrId.CriDmg] = "criDmg",
	[CharacterEnum.AttrId.CriDef] = "criDef",
	[CharacterEnum.AttrId.AddDmg] = "addDmg",
	[CharacterEnum.AttrId.DropDmg] = "dropDmg",
	[CharacterEnum.AttrId.Heal] = "heal",
	[CharacterEnum.AttrId.Revive] = "revive",
	[CharacterEnum.AttrId.DefenseIgnore] = "defenseIgnore",
	[CharacterEnum.AttrId.Absorb] = "absorb",
	[CharacterEnum.AttrId.NormalSkillRate] = "normalSkillRate",
	[CharacterEnum.AttrId.Clutch] = "clutch"
}

function EquipConfig:onConfigLoaded(configName, configTable)
	if configName == "equip_const" then
		self._baseExpDic = {}

		local expList = lua_equip_const.configDict[1].value
		local param, id, exp

		for i, v in ipairs(string.split(expList, "|")) do
			param = string.split(v, "#")
			id = param[1]
			exp = param[2]
			self._baseExpDic[tonumber(param[1])] = tonumber(param[2])
		end

		expList = lua_equip_const.configDict[2].value

		for i, v in ipairs(string.split(lua_equip_const.configDict[2].value, "|")) do
			param = string.split(v, "#")
			self._baseExpDic[tonumber(param[1])] = tonumber(param[2])
		end

		self._expTransfer = {}

		local transferStrList = string.split(lua_equip_const.configDict[3].value, "|")
		local tempTransfer

		for _, transferStr in ipairs(transferStrList) do
			tempTransfer = string.splitToNumber(transferStr, "#")
			self._expTransfer[tempTransfer[1]] = tempTransfer[2] / 100
		end

		self._equipBackpackMaxCount = tonumber(lua_equip_const.configDict[13].value)
		self._equipNotShowRefineRare = tonumber(lua_equip_const.configDict[16].value)

		local array = string.splitToNumber(lua_equip_const.configDict[17].value, "#")

		self.equipDecomposeEquipId = array[2]
		self.equipDecomposeEquipUnitCount = array[3]
	end

	if configName == "equip_break_cost" then
		self._equipBreakCostRareList = {}
		self._equipMaxBreakLv = {}

		for _, breakCostCo in ipairs(lua_equip_break_cost.configList) do
			self._equipBreakCostRareList[breakCostCo.rare] = self._equipBreakCostRareList[breakCostCo.rare] or {}

			table.insert(self._equipBreakCostRareList[breakCostCo.rare], breakCostCo)

			self._equipMaxBreakLv[breakCostCo.rare] = self._equipMaxBreakLv[breakCostCo.rare] or 0

			if breakCostCo.breakLevel > self._equipMaxBreakLv[breakCostCo.rare] then
				self._equipMaxBreakLv[breakCostCo.rare] = breakCostCo.breakLevel
			end
		end

		for rare, coList in pairs(self._equipBreakCostRareList) do
			table.sort(coList, function(a, b)
				return a.breakLevel < b.breakLevel
			end)
		end
	end

	if configName == "equip_strengthen_cost" and not self._strengthenCostQualityList then
		self._strengthenCostQualityList = {}

		for i, v in ipairs(lua_equip_strengthen_cost.configList) do
			if not self._strengthenCostQualityList[v.rare] then
				local q = {}

				self._strengthenCostQualityList[v.rare] = q

				table.insert(q, v)
			end
		end
	end

	if configName == "equip_skill" then
		self._equipSkillList = {}
		self.equip_skill_dic = {}

		for i, v in ipairs(lua_equip_skill.configList) do
			self._equipSkillList[v.id] = self._equipSkillList[v.id] or {}
			self._equipSkillList[v.id][v.skillLv] = v
			self.equip_skill_dic[v.skill] = v
			self.equip_skill_dic[v.skill2] = v
		end
	end
end

function EquipConfig:getOneLevelEquipProduceExp(value)
	local exp = self._baseExpDic[value]

	if exp == nil then
		logError("not found base equip exp : " + tostring(value))

		return 0
	end

	return exp
end

function EquipConfig:getCurrentBreakLevelMaxLevel(equipMo)
	return self:_getBreakLevelMaxLevel(equipMo.config.rare, equipMo.breakLv)
end

function EquipConfig:getNextBreakLevelMaxLevel(equipMo)
	return self:_getBreakLevelMaxLevel(equipMo.config.rare, equipMo.breakLv + 1)
end

function EquipConfig:_getBreakLevelMaxLevel(rare, breakLevel)
	local rareList = self._equipBreakCostRareList[rare]

	if not rareList then
		logError(string.format("rare '%s' not config break cost", rare))

		return EquipConfig.MaxLevel
	end

	for i = 1, #rareList do
		if rareList[i].breakLevel == breakLevel then
			return rareList[i].level
		end
	end

	logWarn(string.format("rare '%s',breakLevel '%s' not config break cost", rare, breakLevel))

	return EquipConfig.MaxLevel
end

function EquipConfig:getEquipRefineLvMax()
	self.equip_refine_lv_max = self.equip_refine_lv_max or tonumber(lua_equip_const.configDict[15].value)

	return self.equip_refine_lv_max
end

function EquipConfig:getEquipUniversalId()
	self.equip_universal_id = self.equip_universal_id or tonumber(lua_equip_const.configDict[14].value)

	return self.equip_universal_id
end

function EquipConfig:getMaxLevel(equipCo)
	local rareList = self._equipBreakCostRareList[equipCo.rare]

	if not rareList then
		logWarn(string.format("rare '%s' not config break cost", equipCo.rare))

		return EquipConfig.MaxLevel
	end

	return rareList[#rareList].level
end

function EquipConfig:getEquipMaxBreakLv(rare)
	return self._equipMaxBreakLv and self._equipMaxBreakLv[rare]
end

function EquipConfig:getNextBreakLevelCostCo(equipMo)
	local currentBreakLv = equipMo.breakLv
	local rare = equipMo.config.rare
	local rareList = self._equipBreakCostRareList[rare]

	if not rareList then
		logError(string.format("rare '%s' not config break cost", equipMo.config.rare))

		return nil
	end

	for _, breakCostCo in ipairs(rareList) do
		if currentBreakLv < breakCostCo.breakLevel then
			return breakCostCo
		end
	end

	logWarn(string.format("rare '%s',breakLevel '%s'`s not have next breakLevel config", rare, currentBreakLv))

	return rareList[#rareList]
end

function EquipConfig:getIncrementalExp(equipMO)
	local config = equipMO.config

	if config.isExpEquip == 1 then
		return self._baseExpDic[config.id]
	end

	if equipMO.level == 1 then
		return self._baseExpDic[config.rare]
	end

	local exp = 0
	local tempExp = 0
	local startLevel = 2
	local currentBreakLvMaxLevel, currentBreakLvTransfer

	for i = 0, equipMO.breakLv do
		currentBreakLvMaxLevel = self:_getBreakLevelMaxLevel(config.rare, i)
		tempExp = 0

		for level = startLevel, currentBreakLvMaxLevel do
			if level > equipMO.level then
				break
			end

			tempExp = tempExp + self:getEquipStrengthenCostExp(config.rare, level)
		end

		exp = exp + tempExp * self._expTransfer[i]
		startLevel = currentBreakLvMaxLevel + 1
	end

	currentBreakLvMaxLevel = self:_getBreakLevelMaxLevel(config.rare, equipMO.breakLv)
	exp = currentBreakLvMaxLevel > equipMO.level and exp + equipMO.exp * self._expTransfer[equipMO.breakLv] or exp + equipMO.exp * ((self._expTransfer[equipMO.breakLv + 1] or nil) and (self._expTransfer[equipMO.breakLv + 1] or self._expTransfer[equipMO.breakLv]))
	exp = exp + self._baseExpDic[config.rare]

	return math.floor(exp)
end

function EquipConfig:getEquipStrengthenCostExp(quality, lv)
	if lv == 1 then
		return self._baseExpDic[quality]
	end

	local temp = lua_equip_strengthen_cost.configDict[quality]

	return temp[lv].exp
end

function EquipConfig:getEquipStrengthenCostCo(quality, lv)
	lv = math.min(lv, EquipConfig.MaxLevel)

	local temp = lua_equip_strengthen_cost.configDict[quality]

	return temp[lv]
end

function EquipConfig:getNeedExpToMaxLevel(equipMo)
	local maxLevel = self:getCurrentBreakLevelMaxLevel(equipMo)
	local needExp = 0
	local strengthenDict = self._strengthenCostQualityList[equipMo.config.rare]

	for level = equipMo.level + 1, maxLevel do
		needExp = needExp + strengthenDict[level].exp
	end

	return Mathf.Max(needExp - equipMo.exp, 0)
end

function EquipConfig:getEquipBackpackMaxCount()
	return self._equipBackpackMaxCount
end

function EquipConfig:getEquipCo(id)
	return lua_equip.configDict[id]
end

function EquipConfig:getEquipValueStr(co)
	return self:dirGetEquipValueStr(co.showType, co.value)
end

function EquipConfig:dirGetEquipValueStr(type, value)
	if type == 0 then
		return string.format("%s", value)
	else
		value = value * 0.1

		local intValue = math.floor(value)

		if intValue == value then
			value = intValue
		end

		return string.format("%s%%", value)
	end
end

function EquipConfig:getEquipSkillCfg(id, level)
	local equipConfigList = self._equipSkillList[id]

	if not equipConfigList then
		logError("equip skill config not found config, id : " .. id)

		return nil
	end

	return equipConfigList[level]
end

function EquipConfig:getStrengthenToLvExpInfo(quality, lv, baseExp, addExp)
	addExp = baseExp + addExp

	local costExp = 0
	local q = self._strengthenCostQualityList[quality]

	for i, costCo in ipairs(q) do
		if lv < costCo.level then
			costExp = costCo.exp

			if costCo.exp <= addExp then
				if i == #q then
					addExp = costExp

					break
				else
					addExp = addExp - costExp
				end
			else
				break
			end
		end
	end

	return addExp, costExp
end

function EquipConfig:getStrengthenToLvCost(quality, lv, baseExp, addExp)
	local costValue = 0
	local q = self._strengthenCostQualityList[quality]

	for i, costCo in ipairs(q) do
		if lv < costCo.level then
			local costExp = costCo.exp

			if baseExp > 0 then
				costExp = costExp - baseExp
				baseExp = 0
			end

			if addExp > 0 then
				if costExp < addExp then
					addExp = addExp - costExp
					costValue = costValue + math.floor(costExp * costCo.scoreCost / 1000)
				else
					costValue = costValue + math.floor(addExp * costCo.scoreCost / 1000)
					addExp = 0
				end
			else
				break
			end
		end
	end

	return costValue
end

function EquipConfig:getStrengthenToLvCostExp(rare, currentLv, baseExp, addExp, breakLv)
	local level2expCoDict = self._strengthenCostQualityList[rare]
	local arrivedMax = true
	local maxLv = self:_getBreakLevelMaxLevel(rare, breakLv)

	if currentLv == maxLv then
		return {
			0,
			0
		}, arrivedMax
	end

	local nextLvCostCo = level2expCoDict[currentLv + 1]
	local startValue = baseExp / nextLvCostCo.exp
	local addValue = 0

	addExp = addExp + baseExp

	for i = currentLv + 1, maxLv do
		local costCo = level2expCoDict[i]
		local costExp = costCo.exp

		if costExp <= addExp then
			addExp = addExp - costExp
			addValue = addValue + 1
		else
			addValue = addValue + addExp / costExp
			arrivedMax = false

			break
		end
	end

	return {
		startValue,
		addValue - startValue
	}, arrivedMax
end

function EquipConfig:getStrengthenToLv(quality, lv, addExp)
	local q = self._strengthenCostQualityList[quality]
	local needExp = 0
	local targetLevel = lv

	for i, v in ipairs(q) do
		if lv < v.level then
			needExp = needExp + v.exp

			if needExp <= addExp then
				targetLevel = v.level
			else
				break
			end
		end
	end

	return targetLevel
end

function EquipConfig:getEquipBreakCo(equipId, breakLv)
	breakLv = breakLv or 0

	local equipBreakCoDict = lua_equip_break_attr.configDict[equipId]

	if not equipBreakCoDict then
		return nil
	end

	local breakAttrCo = equipBreakCoDict[breakLv]

	if not breakAttrCo then
		return nil
	end

	return breakAttrCo
end

function EquipConfig:getEquipCurrentBreakLvAttrEffect(equipConfig, breakLv)
	local breakAttrCo = self:getEquipBreakCo(equipConfig.id, breakLv)

	if not breakAttrCo then
		return nil, 0
	end

	for attrId, fieldName in pairs(EquipConfig.EquipBreakAttrIdToFieldName) do
		if breakAttrCo[fieldName] ~= 0 then
			return attrId, breakAttrCo[fieldName]
		end
	end

	return nil, 0
end

function EquipConfig:getEquipAddBaseAttr(equipMO, level)
	level = level or equipMO.level

	local equipCo = equipMO.config
	local hp = self:calcStrengthenAttr(equipCo, level, "hp")
	local atk = self:calcStrengthenAttr(equipCo, level, "atk")
	local def = self:calcStrengthenAttr(equipCo, level, "def")
	local mdef = self:calcStrengthenAttr(equipCo, level, "mdef")

	return hp, atk, def, mdef
end

function EquipConfig:getEquipBreakAddAttrValueDict(equipConfig, breakLv)
	local upAddValues = {}

	for _, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
		upAddValues[attrId] = 0
	end

	for _, attrId in ipairs(CharacterEnum.UpAttrIdList) do
		upAddValues[attrId] = 0
	end

	local attrId, value = self:getEquipCurrentBreakLvAttrEffect(equipConfig, breakLv)

	if attrId then
		upAddValues[attrId] = upAddValues[attrId] + value
	end

	for key, v in pairs(upAddValues) do
		upAddValues[key] = v / 10
	end

	return upAddValues
end

function EquipConfig:getEquipStrengthenAttrMax0(equipMO, equipId, curLevel, breakLv)
	local hp, atk, def, mdef, upAttrs = self:getEquipStrengthenAttr(equipMO, equipId, curLevel, breakLv)

	if upAttrs then
		for k, v in pairs(upAttrs) do
			upAttrs[k] = math.max(0, v)
		end
	end

	return math.max(0, hp), math.max(0, atk), math.max(0, def), math.max(0, mdef), upAttrs
end

function EquipConfig:getEquipStrengthenAttr(equipMO, equipId, curLevel)
	if equipMO then
		if not equipMO.config then
			local equipCo = self:getEquipCo(equipId)

			curLevel = curLevel or equipMO and equipMO.level or self:getMaxLevel(self:getEquipCo(equipId))

			if equipMO then
				if not equipMO.refineLv then
					local refine_lv = 1
					local upAttrs = {}

					for id, config in pairs(lua_character_attribute.configDict) do
						if config.type == 2 or config.type == 3 then
							upAttrs[config.attrType] = self:calcAdvanceAttrGain(equipCo, refine_lv, config.attrType)
						end
					end

					local hp = self:calcStrengthenAttr(equipCo, curLevel, "hp")
					local atk = self:calcStrengthenAttr(equipCo, curLevel, "atk")
					local def = self:calcStrengthenAttr(equipCo, curLevel, "def")
					local mdef = self:calcStrengthenAttr(equipCo, curLevel, "mdef")

					return hp, atk, def, mdef, upAttrs
				end
			end
		end
	end
end

function EquipConfig:getMaxEquipNormalAttr(equipId, sortFunc)
	local equip_config = self:getEquipCo(equipId)
	local gain_tab, gain_list = self:getEquipNormalAttr(equipId, self:getMaxLevel(equip_config), sortFunc)

	return gain_tab, gain_list
end

function EquipConfig:getEquipNormalAttr(equipId, level, sortFunc)
	local equip_config = self:getEquipCo(equipId)
	local attr_tab = {
		"hp",
		"atk",
		"def",
		"mdef"
	}
	local gain_tab = {}
	local gain_list = {}

	for k, v in pairs(attr_tab) do
		local tab = {}

		tab.attrType = v
		tab.value = self:calcStrengthenAttr(equip_config, level, v)
		gain_tab[v] = tab

		table.insert(gain_list, tab)
	end

	table.sort(gain_list, sortFunc or HeroConfig.sortAttr)

	return gain_tab, gain_list
end

function EquipConfig:getMaxEquipAdvanceAttr(equipId)
	local gain_tab, gain_list = self:getEquipAdvanceAttr(equipId, self:getEquipRefineLvMax())

	return gain_tab, gain_list
end

function EquipConfig:getEquipAdvanceAttr(equipId, refine_lv)
	local gain_tab = {}
	local gain_list = {}
	local equip_config = self:getEquipCo(equipId)

	for id, config in pairs(lua_character_attribute.configDict) do
		if config.type == 2 or config.type == 3 then
			local tab = {}

			tab.attrType = config.attrType
			tab.value = self:calcAdvanceAttrGain(equip_config, refine_lv, config.attrType)
			gain_tab[config.attrType] = tab

			table.insert(gain_list, tab)
		end
	end

	table.sort(gain_list, HeroConfig.sortAttr)

	return gain_tab, gain_list
end

function EquipConfig:calcAdvanceAttrGain(equipCo, refine_lv, attr_type)
	if refine_lv == 0 then
		refine_lv = 1
	end

	local equip_skill_config = self:getEquipSkillCfg(equipCo.skillType, refine_lv)

	if not equip_skill_config then
		logError("装备技能表找不到id：", equipCo.skillType, "等级：", refine_lv)
	end

	return equip_skill_config[attr_type] or 0
end

function EquipConfig:calcStrengthenAttr(equipCo, curLevel, attrName)
	local config = lua_equip_strengthen.configDict[equipCo.strengthType]

	if not config then
		return -1
	end

	local value = config[attrName]

	if not value then
		return -1
	end

	local costCo = self:getEquipStrengthenCostCo(equipCo.rare, curLevel)

	return math.floor(value * costCo.attributeRate / 1000)
end

function EquipConfig:attrIdToName(attrId)
	local config = lua_character_attribute.configDict[attrId]

	return config.attrType
end

function EquipConfig:getRareColor(rare)
	return ItemEnum.Color[rare]
end

function EquipConfig:isEquipSkill(skill)
	return self.equip_skill_dic[skill]
end

EquipConfig.FastAddMAXFilterRareId = 91

function EquipConfig:getMaxFilterRare()
	self.maxRare = self.maxRare or CommonConfig.instance:getConstNum(ConstEnum.FastAddMAXFilterRareId)

	return self.maxRare
end

function EquipConfig:getMinFilterRare()
	return 2
end

function EquipConfig:getNotShowRefineRare()
	return self._equipNotShowRefineRare
end

function EquipConfig:getTagList(equipConfig)
	if not equipConfig then
		return {}
	end

	if string.nilorempty(equipConfig.tag) then
		return {}
	end

	return string.splitToNumber(equipConfig.tag, "#")
end

function EquipConfig:getTagName(tagId)
	local tagCo = lua_equip_tag.configDict[tagId]

	if not tagCo then
		logError(string.format("not found tag id : %s config", tagId))

		return ""
	end

	return tagCo.name
end

EquipConfig.instance = EquipConfig.New()

return EquipConfig
