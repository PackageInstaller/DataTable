-- chunkname: @IQIGame\\Module\\DiySkill\\DiySkillModule.lua

DiySkillModule = {
	SkillLevelTables = {},
	SkillRankTables = {},
	SkillRefineTables = {}
}
DiySkillModule.SkillCostAttrID = 9

function DiySkillModule.GetItemCfgWithDiySkill(skillData)
	for _, cfg in pairs(CfgItemTable) do
		if cfg.ItemTypes == Constant.ItemType.Skill and cfg.LikeId == skillData.skillCid then
			return cfg
		end
	end

	return nil
end

function DiySkillModule.GetAllDiySkillsWithWarehouse(isShowLimit, heroCid)
	local skills = {}

	for _, v in pairs(WarehouseModule.AllItems) do
		if DiySkillModule.CheckItemDataIsDiySkill(v) then
			if isShowLimit == false then
				if DiySkillModule.GetDiySkillIsLimit(v.skillData, heroCid) then
					table.insert(skills, v)
				end
			else
				table.insert(skills, v)
			end
		end
	end

	return skills
end

function DiySkillModule.GetAllDiySkillRefineMatWithWarehouse(skillId, skillCid, ignoreEquip)
	local curItemData = WarehouseModule.FindItem(skillId)
	local items = {}

	for i = 1, #WarehouseModule.AllItems do
		local itemData = WarehouseModule.AllItems[i]

		if itemData.cid == skillCid and itemData.id ~= curItemData.id and itemData.skillData.purifyLv <= curItemData.skillData.purifyLv then
			if ignoreEquip then
				if itemData.skillData.heroCid == 0 then
					table.insert(items, WarehouseModule.AllItems[i])
				end
			else
				table.insert(items, WarehouseModule.AllItems[i])
			end
		end
	end

	return items
end

function DiySkillModule.GetAllDiySkillRefineMatWithWarehouseByItemID(skillId, itemIDs, ignoreEquip)
	local items = {}

	for i = 1, #WarehouseModule.AllItems do
		local itemData = WarehouseModule.AllItems[i]

		if table.indexOf(itemIDs, itemData.cid) ~= -1 and itemData.id ~= skillId then
			if itemData.skillData ~= nil then
				if ignoreEquip then
					if itemData.skillData.heroCid == 0 then
						table.insert(items, WarehouseModule.AllItems[i])
					end
				else
					table.insert(items, WarehouseModule.AllItems[i])
				end
			else
				table.insert(items, WarehouseModule.AllItems[i])
			end
		end
	end

	return items
end

function DiySkillModule.GetDiySkillIsLimit(skillData, heroCid)
	local skillCfg = skillData:GetCfg()

	if heroCid == nil then
		return true
	end

	local heroCfg = CfgHeroTable[heroCid]

	if DiySkillModule.GetTableElementIsZero(skillCfg.ForceLimit) and DiySkillModule.GetTableElementIsZero(skillCfg.ProfessionLimit) and DiySkillModule.GetTableElementIsZero(skillCfg.ElementLimit) then
		return true
	else
		for i = 1, #skillCfg.ForceLimit do
			if heroCfg.Forces == skillCfg.ForceLimit[i] then
				return true
			end
		end

		for i = 1, #skillCfg.ProfessionLimit do
			if heroCfg.Profession == skillCfg.ProfessionLimit[i] then
				return true
			end
		end

		for i = 1, #skillCfg.ElementLimit do
			if heroCfg.Elements == skillCfg.ElementLimit[i] then
				return true
			end
		end
	end

	return false
end

function DiySkillModule.GetTableElementIsZero(table)
	if #table == 0 then
		return true
	end

	for i = 1, #table do
		if table[i] ~= 0 then
			return false
		end
	end

	return true
end

function DiySkillModule.GetAllDiySkillUpgradeMatWithWarehouse(skillId)
	local mats = {}

	for _, v in pairs(WarehouseModule.AllItems) do
		if v.id ~= skillId and DiySkillModule.CheckSkillItemCanBeUseForUpgradeMaterial(v) then
			table.insert(mats, v)
		end
	end

	return mats
end

function DiySkillModule.CheckSkillItemCanBeUseForUpgradeMaterial(itemData)
	local itemCfg = itemData:GetCfg()

	if itemCfg.UserAction == Constant.ActionType.AddSkillExpAction then
		return true
	end

	local itemType = itemCfg.ItemTypes

	if itemType == Constant.ItemType.Skill then
		local skillData = itemData.skillData

		if skillData.heroCid ~= 0 then
			return false
		end

		local skillCfg = skillData:GetCfg()

		if skillCfg.SkillType == Constant.SkillType.TYPE_LORE then
			return true
		end
	end

	return false
end

function DiySkillModule.CheckItemDataIsDiySkill(itemData)
	if itemData:GetCfg().ItemTypes ~= Constant.ItemType.Skill then
		return false
	end

	local skillType = itemData.skillData:GetCfg().SkillType

	if skillType == Constant.SkillType.TYPE_LORE then
		return true
	end

	return false
end

function DiySkillModule.GetOneKeyDiySkillUpgradeMat(skillData, limitCount, limitCost, filterNum)
	local allMat = DiySkillModule.GetAllDiySkillUpgradeMatWithWarehouse(skillData.id)

	local function __getSkillItemWeight(_itemData)
		local _weight = 1000

		_weight = _weight - _itemData.skillData.purifyLv * 100
		_weight = _weight - _itemData.skillData.strengLv * 10
		_weight = _weight - _itemData:GetCfg().Quality * 10

		return _weight
	end

	local function __getExpItemWeight(_itemData)
		local _weight = 10000

		_weight = _weight + _itemData:GetCfg().ActionParams[1]

		return _weight
	end

	local unitCost = CfgDiscreteDataTable[2].Data[1] / 100
	local filterDataList = {}

	for i = 1, #allMat do
		local itemData = allMat[i]
		local itemCfg = itemData:GetCfg()

		if filterNum >= itemCfg.Quality then
			local canAdd = false
			local filterData = {}

			filterData.id = itemData.id
			filterData.unitCost = unitCost
			filterData.tolerance = 300

			if itemCfg.ItemTypes == Constant.ItemType.Skill then
				filterData.exp = itemData.skillData:GetSkillCfgByLevel().OfferExp
				filterData.num = 1
				filterData.weight = __getSkillItemWeight(itemData)
				canAdd = not itemData.skillData.lock
			else
				filterData.exp = itemCfg.ActionParams[1]
				filterData.num = itemData.num
				filterData.weight = __getExpItemWeight(itemData)
				canAdd = true
			end

			if canAdd then
				table.insert(filterDataList, filterData)
			end
		end
	end

	local curTotalExp = DiySkillModule.GetSkillTotalExpBySkillData(skillData)
	local maxStrengthenLevel = DiySkillModule.GetSkillMaxUpgradeLevel(skillData.Quality, skillData.strengLv)
	local maxLevelNeedExp = DiySkillModule.GetSkillTotalExp(skillData.Quality, maxStrengthenLevel, 0)
	local needExp = maxLevelNeedExp - curTotalExp

	return ItemModule.CommonExpItemFilter(needExp, filterDataList, limitCost)
end

function DiySkillModule.GetOneKeyDiySkillUpgradeMatNew(skillData, limitCost)
	local upgradeItems = RoleDevelopmentModule.GetItemByActionType(Constant.ActionType.AddSkillExpAction)

	table.sort(upgradeItems, function(tab1, tab2)
		return tab1.Quality < tab2.Quality
	end)

	local allMat = {}

	ForArray(upgradeItems, function(_, _itemCfg)
		local num = WarehouseModule.GetItemNumByCfgID(_itemCfg.Id)

		if num > 0 then
			local items = WarehouseModule.GetEnoughItemsByNum(_itemCfg.Id, num)

			for k, v in pairs(items) do
				local itemData = WarehouseModule.GetItemDataById(k)

				table.insert(allMat, itemData)
			end
		end
	end)

	local function __getExpItemWeight(_itemData)
		local _weight = 10000

		_weight = _weight + _itemData:GetCfg().ActionParams[1]

		return _weight
	end

	local unitCost = CfgDiscreteDataTable[2].Data[1] / 100
	local filterDataList = {}

	for i = 1, #allMat do
		local itemData = allMat[i]
		local itemCfg = itemData:GetCfg()
		local filterData = {}

		filterData.id = itemData.id
		filterData.unitCost = unitCost
		filterData.tolerance = 100
		filterData.exp = itemCfg.ActionParams[1]
		filterData.num = itemData.num
		filterData.weight = __getExpItemWeight(itemData)

		table.insert(filterDataList, filterData)
	end

	local curTotalExp = DiySkillModule.GetSkillTotalExpBySkillData(skillData)
	local maxStrengthenLevel = DiySkillModule.GetSkillMaxUpgradeLevel(skillData.Quality, skillData.strengLv)
	local maxLevelNeedExp = DiySkillModule.GetSkillTotalExp(skillData.Quality, maxStrengthenLevel, 0)
	local needExp = maxLevelNeedExp - curTotalExp

	return ItemModule.CommonExpItemFilter(needExp, filterDataList, limitCost)
end

function DiySkillModule.ScreenDiySkillItemDataListByScreenData(itemDataList, screenData)
	local result = {}

	ForPairs(itemDataList, function(_, _itemData)
		if _itemData.skillData == nil then
			table.insert(result, _itemData)

			return
		end

		if screenData ~= nil and not CommonScreenModule.ScreenCheck(_itemData.skillData, screenData) then
			return
		end

		table.insert(result, _itemData)
	end)

	return result
end

function DiySkillModule.GetDiySkillItemListByScreenData(screenData)
	local skillList = {}

	ForPairs(WarehouseModule.AllItems, function(_, _itemData)
		if not DiySkillModule.__CheckSkillByScreenData(_itemData.skillData, screenData) then
			return
		end

		table.insert(skillList, _itemData)
	end)

	return skillList
end

function DiySkillModule.GetDiySkillListByScreenData(screenData)
	local skillList = {}

	ForPairs(WarehouseModule.AllItems, function(_, _itemData)
		if not DiySkillModule.__CheckSkillByScreenData(_itemData.skillData, screenData) then
			return
		end

		table.insert(skillList, _itemData.skillData)
	end)

	return skillList
end

function DiySkillModule.__CheckSkillByScreenData(skillData, screenData)
	if skillData == nil then
		return false
	end

	if screenData == nil then
		return true
	end

	return CommonScreenModule.ScreenCheck(skillData, screenData)
end

function DiySkillModule.GetAllCfgSkillLevelDataByCid(quality)
	local levelConfigData = DiySkillModule.SkillLevelTables[quality]

	if levelConfigData ~= nil then
		return levelConfigData
	end

	levelConfigData = {}

	for _, v in pairsCfg(CfgSkillLevelDiyTable) do
		if v.Quality == quality then
			levelConfigData[v.SkillLv] = v
		end
	end

	DiySkillModule.SkillLevelTables[quality] = levelConfigData

	return levelConfigData
end

function DiySkillModule.GetCfgSkillLevelData(quality, level)
	local levelConfigData = DiySkillModule.GetAllCfgSkillLevelDataByCid(quality)

	return levelConfigData[level]
end

function DiySkillModule.GetSkillMaxUpgradeLevel(quality, upgradeCount)
	local maxLevel = 0
	local levelConfigData = DiySkillModule.GetAllCfgSkillLevelDataByCid(quality)

	for level, cfg in pairs(levelConfigData) do
		if upgradeCount >= cfg.NeedLv and maxLevel < level then
			maxLevel = level
		end
	end

	return maxLevel
end

function DiySkillModule.GetSkillMaxUpgradeLevelBySkillData(skillData)
	return DiySkillModule.GetSkillMaxUpgradeLevel(skillData.Quality, skillData.strengLv)
end

function DiySkillModule.GetSkillTotalExp(quality, level, curExp)
	local totalExp = curExp
	local levelConfigData = DiySkillModule.GetAllCfgSkillLevelDataByCid(quality)

	for _level, cfg in pairs(levelConfigData) do
		if _level < level then
			totalExp = totalExp + cfg.UpgradeNeedExp[1]
		end
	end

	return totalExp
end

function DiySkillModule.GetSkillTotalExpBySkillData(skillData)
	return DiySkillModule.GetSkillTotalExp(skillData.Quality, skillData.lv, skillData.exp)
end

function DiySkillModule.CalcSkillLevelDataWithTotalEXP(quality, exp, upgradeCount)
	local levelConfigData = DiySkillModule.GetAllCfgSkillLevelDataByCid(quality)
	local maxLevel = DiySkillModule.GetSkillMaxUpgradeLevel(quality, upgradeCount)
	local level = 1
	local lastExp = exp

	for i = 1, #levelConfigData do
		local leftover = lastExp - levelConfigData[i].UpgradeNeedExp[1]

		if leftover >= 0 then
			level = level + 1

			if level == maxLevel then
				return level, leftover, maxLevel
			else
				lastExp = leftover
			end
		else
			return level, lastExp, maxLevel
		end
	end

	return level, lastExp, maxLevel
end

function DiySkillModule.CalcSkillLevelDataWithTotalEXPBySkillData(skillData, totalExp)
	return DiySkillModule.CalcSkillLevelDataWithTotalEXP(skillData.Quality, totalExp, skillData.strengLv)
end

function DiySkillModule.GetAllSkillRandCfgByCid(skillCid)
	local skillRankCfgData = DiySkillModule.SkillRankTables[skillCid]

	if skillRankCfgData ~= nil then
		return skillRankCfgData
	end

	skillRankCfgData = {}

	for _, v in pairsCfg(CfgSkillRankTable) do
		if v.Skill == skillCid then
			skillRankCfgData[v.StrengLv] = v
		end
	end

	DiySkillModule.SkillRankTables[skillCid] = skillRankCfgData

	return skillRankCfgData
end

function DiySkillModule.GetSkillMaxStrengthenLevel(skillCid)
	local skillRankCfg = DiySkillModule.GetAllSkillRandCfgByCid(skillCid)

	if #skillRankCfg == 0 then
		logError("SkillRank 配置表找不到 技能【" .. tostring(skillCid) .. "】 相关配置")

		return 0
	end

	return skillRankCfg[#skillRankCfg].StrengLv
end

function DiySkillModule.GetSkillRankData(skillCid, strengthenLv)
	local skillRankCfg = DiySkillModule.GetAllSkillRandCfgByCid(skillCid)

	return skillRankCfg[strengthenLv]
end

function DiySkillModule.GetSkillRankDataBySkillData(skillData)
	return DiySkillModule.GetSkillRankData(skillData.skillCid, skillData.strengLv)
end

function DiySkillModule.GetAllSkillRefineCfg(skillCid)
	local refineConfigData = DiySkillModule.SkillRefineTables[skillCid]

	if refineConfigData ~= nil then
		return refineConfigData
	end

	refineConfigData = {}

	for _, v in pairsCfg(CfgSkillRefineTable) do
		if v.Skill == skillCid then
			refineConfigData[v.SkillRefineLv] = v
		end
	end

	DiySkillModule.SkillRefineTables[skillCid] = refineConfigData

	return refineConfigData
end

function DiySkillModule.GetSkillMaxRefineLevel(skillCid)
	local refineConfigs = DiySkillModule.GetAllSkillRefineCfg(skillCid)

	return #refineConfigs
end

function DiySkillModule.GetSkillRefineCfg(skillCid, purifyLv)
	local refineConfigs = DiySkillModule.GetAllSkillRefineCfg(skillCid)

	return refineConfigs[purifyLv]
end

function DiySkillModule.GetSKillRankAttrs(skillData)
	local SkillAttributes = {}
	local skillRankData = DiySkillModule.GetSkillRankData(skillData.skillCid, skillData.strengLv)
	local strengthCfg, skillSlotEffectParam

	if skillRankData ~= nil and skillRankData.StrengthenId ~= {} then
		for i = 1, #skillRankData.StrengthenId do
			strengthCfg = CfgSkillStrengthenTable[skillRankData.StrengthenId[i]]

			for k = 1, #strengthCfg.SkillSlotEffect do
				if strengthCfg.SkillSlotEffect[k] == 100 then
					skillSlotEffectParam = strengthCfg.SkillSlotEffectParam[k]
					SkillAttributes[tonumber(skillSlotEffectParam[1])] = tonumber(skillSlotEffectParam[2])
				end
			end
		end
	end

	return SkillAttributes
end

function DiySkillModule.GetSkillTotalAttributesWithCustomData(quality, skillCid, lv, strengLv, purifyLv, attrLimitTable)
	local skillAttrTable = DiySkillModule.GetSkillLevelAttributes(quality, skillCid, lv, purifyLv, attrLimitTable)
	local rankAttrTable = DiySkillModule.GetSkillRankAttributes(skillCid, strengLv, attrLimitTable)
	local refineAttrTable = DiySkillModule.GetSkillRefineAttributes(skillCid, lv, purifyLv, attrLimitTable)

	local function handler(_k, _v1, _v2)
		if _v1 == nil then
			return _v2
		end

		if _v2 == nil then
			return _v1
		end

		return _v1 + _v2
	end

	local totalAttributes = table.customMerge(skillAttrTable, rankAttrTable, handler)

	totalAttributes = table.customMerge(totalAttributes, refineAttrTable, handler)

	return totalAttributes
end

function DiySkillModule.GetSkillTotalAttributes(skillData, attrLimitTable)
	return DiySkillModule.GetSkillTotalAttributesWithCustomData(skillData.Quality, skillData.skillCid, skillData.lv, skillData.strengLv, skillData.purifyLv, attrLimitTable)
end

function DiySkillModule.GetSkillLevelAttributes(quality, skillCid, skillLv, refineLv, attrLimitTable)
	local attributes = {}
	local skillLevelData = DiySkillModule.GetCfgSkillLevelData(quality, skillLv)

	if skillLevelData == nil then
		log("技能 {0} 等级 {1} 配置表数据读取失败.", skillCid, skillLv)
	else
		local skillConfig = CfgSkillTable[skillCid]

		for i = 1, table.len(skillConfig.DiyBaseAtt), 2 do
			attributes[skillConfig.DiyBaseAtt[i]] = GetArrayValue(attributes, skillConfig.DiyBaseAtt[i], 0) + math.ceil(skillConfig.DiyBaseAtt[i + 1])
		end

		local growAttr = {}

		for i = 1, table.len(skillConfig.DiyGrowAtt), 2 do
			growAttr[skillConfig.DiyGrowAtt[i]] = GetArrayValue(growAttr, skillConfig.DiyGrowAtt[i], 0) + skillConfig.DiyGrowAtt[i + 1]
		end

		local skillRefineData = DiySkillModule.GetSkillRefineCfg(skillCid, refineLv)

		if skillRefineData then
			local refineAttribute = skillRefineData.RefineAttribute

			for i = 1, table.len(refineAttribute), 2 do
				growAttr[refineAttribute[i]] = GetArrayValue(growAttr, refineAttribute[i], 0) + refineAttribute[i + 1]
			end
		end

		for i, v in pairs(growAttr) do
			attributes[i] = GetArrayValue(attributes, i, 0) + math.ceil(v * (skillLv - 1))
		end
	end

	if attrLimitTable ~= nil then
		ForArray(attrLimitTable, function(_, _attrType)
			if attributes[_attrType] ~= nil then
				return
			end

			attributes[_attrType] = 0
		end)
	end

	return attributes
end

function DiySkillModule.GetSkillRankAttributes(skillCid, rankLv, attrLimitTable)
	local attributes = {}
	local skillRankData = DiySkillModule.GetSkillRankData(skillCid, rankLv)

	if skillRankData == nil then
		log("技能 {0} 突破等级 {1} 配置表数据读取失败.", skillCid, rankLv)
	else
		ForArray(skillRankData.StrengthenId, function(_, _strengthenId)
			local strengthCfg = CfgSkillStrengthenTable[_strengthenId]

			ForArray(strengthCfg.SkillSlotEffect, function(_index, _type)
				if _type ~= 100 then
					return
				end

				local attrType = tonumber(strengthCfg.SkillSlotEffectParam[_index][1])

				if attrLimitTable ~= nil and not ValueInArray(attrLimitTable, attrType) then
					return
				end

				local attrValue = tonumber(strengthCfg.SkillSlotEffectParam[_index][2])

				attributes[attrType] = attrValue
			end)
		end)
	end

	if attrLimitTable ~= nil then
		ForArray(attrLimitTable, function(_, _attrType)
			if attributes[_attrType] ~= nil then
				return
			end

			attributes[_attrType] = 0
		end)
	end

	return attributes
end

function DiySkillModule.GetSkillRefineAttributes(skillCid, lv, refineLv, attrLimitTable)
	local attributes = {}

	return attributes
end

function DiySkillModule.PurifySkill(skillId, id2CountDic)
	net_skill.purifySkill(skillId, id2CountDic)
end

function DiySkillModule.PurifySkillResult(oldSkillpod, skillpod)
	UIModule.Open(Constant.UIControllerName.SkillRefineTipsUI, Constant.UILayer.UI, {
		oldSkillPod = oldSkillpod,
		currentSkillPod = skillpod
	})
	EventDispatcher.Dispatch(EventID.RoleSkillPurifySucess, oldSkillpod, skillpod)
end
