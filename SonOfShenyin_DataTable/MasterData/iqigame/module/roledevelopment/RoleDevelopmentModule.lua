-- chunkname: @IQIGame\\Module\\RoleDevelopment\\RoleDevelopmentModule.lua

RoleDevelopmentModule = {
	SelectBreachMaterialIsMax = false,
	HistoryLv = 0,
	IsCanUpgradeHero = false,
	UpgradeExpPaopMoney = 1,
	SelectSkillIndex = 0,
	CurMaxExp = 0,
	CurPreviewEXP = 0,
	IsCanUseUpgrade = true,
	SkillExpPaopMoney = 2,
	ShowBreachAnim = false,
	FavorItemID = 38,
	IsCanUpgradeSkill = false,
	PreviewNeedExp = 0,
	PreviewExp = 0,
	LvTable = {},
	HistoryAttr = {},
	CurSelectMaterialExp = {},
	CurSelectMaterialItems = {}
}

function RoleDevelopmentModule.Initialize()
	RoleDevelopmentModule.GetRoleLevelTable()
	RoleDevelopmentModule.__InitRoleDevelopmentTipsTable()
end

function RoleDevelopmentModule.Shutdown()
	return
end

function RoleDevelopmentModule.GetItemByActionType(actionType)
	local items = {}

	for k, v in pairsCfg(CfgItemTable) do
		if actionType == v.UserAction then
			table.insert(items, v)
		end
	end

	return items
end

function RoleDevelopmentModule.GetHavingUpgradeMaterial(upgradeItems)
	local havingMaterial = false

	ForPairs(upgradeItems, function(_, itemCfg)
		local num = WarehouseModule.GetItemNumByCfgID(itemCfg.Id)

		if num > 0 then
			havingMaterial = true

			return true
		end
	end)

	return havingMaterial
end

function RoleDevelopmentModule.GetRoleAttrs(heroCid, attrType)
	return RoleDevelopmentModule.GetAttrsByAttrGroup(WarlockModule.WarlockDataDic[heroCid].AttributeGroups, attrType)
end

function RoleDevelopmentModule.GetRoleAttrsByHeroPod(heroPod, attrType)
	return RoleDevelopmentModule.GetAttrsByAttrGroup(heroPod.attr, attrType)
end

function RoleDevelopmentModule.GetRoleAttrsByWarlockData(warlockData, attrType)
	return RoleDevelopmentModule.GetAttrsByAttrGroup(warlockData.AttributeGroups, attrType)
end

function RoleDevelopmentModule.GetAttrsByAttrGroup(attrGroup, attrType)
	local Attrs = {}

	for i, v in pairs(attrGroup) do
		if CfgAttributeTable[i].Type == attrType then
			local value = v

			if CfgAttributeTable[i].IsPer == false then
				value = math.floor(value)
			else
				value = string.format("%.3f", value)
				value = value * 100 .. "%"
			end

			table.insert(Attrs, i, {
				attType = i,
				value = value
			})
		end
	end

	table.sort(Attrs, function(a, b)
		return CfgAttributeTable[a.attType].Sort < CfgAttributeTable[b.attType].Sort
	end)

	return Attrs
end

function RoleDevelopmentModule.GetExpPropMoney(id)
	return CfgDiscreteDataTable[id].Data[1]
end

function RoleDevelopmentModule.GetRoleLevelTable()
	RoleDevelopmentModule.LvTable = {}

	for k, v in pairsCfg(CfgHeroLvTable) do
		table.insert(RoleDevelopmentModule.LvTable, v)
	end

	table.sort(RoleDevelopmentModule.LvTable, function(tab1, tab2)
		return tab1.HeroLv < tab2.HeroLv
	end)
end

function RoleDevelopmentModule.GetMaxExp(heroLV)
	local maxExp = 0

	for i = 1, #RoleDevelopmentModule.LvTable do
		if heroLV > RoleDevelopmentModule.LvTable[i].HeroLv then
			maxExp = maxExp + RoleDevelopmentModule.LvTable[i].UpgradeNeedExp
		else
			break
		end
	end

	return maxExp
end

function RoleDevelopmentModule.GetAttrCfg(id)
	for k, v in pairsCfg(CfgAttributeTable) do
		if v.Id == id then
			return v
		end
	end

	return nil
end

function RoleDevelopmentModule.GetPreviewNeedExp(heroData)
	local roleData = heroData
	local curMaxlv = roleData:GetCurMaxLv()
	local curMaxExp = RoleDevelopmentModule.GetMaxExp(curMaxlv)
	local curHeroExp = RoleDevelopmentModule.GetMaxExp(roleData.lv) + roleData.exp

	RoleDevelopmentModule.PreviewNeedExp = curMaxExp - curHeroExp
end

function RoleDevelopmentModule.GetPreviewLv(exp)
	local cfgExp = 0

	for i = 1, #RoleDevelopmentModule.LvTable do
		cfgExp = cfgExp + RoleDevelopmentModule.LvTable[i].UpgradeNeedExp

		if exp < cfgExp then
			return i
		end
	end

	return RoleDevelopmentModule.LvTable[#RoleDevelopmentModule.LvTable].HeroLv
end

function RoleDevelopmentModule.UseItemIsMAXExp(lv, exp)
	if RoleDevelopmentModule.GetMaxExp(lv + 1) == exp then
		return lv + 1
	else
		return lv
	end
end

function RoleDevelopmentModule.GetAllSKillOrItems(skillId)
	local ItemTable = {}
	local SkillTable = {}
	local itemDataTable = {}

	ItemTable = RoleDevelopmentModule.GetItemByActionType(Constant.ActionType.AddSkillExpAction)

	for k, v in pairs(WarehouseModule.AllItems) do
		local itemTypes = v:GetCfg().ItemTypes

		if itemTypes == Constant.ItemType.Skill and v.skillData:GetCfg().IsDiy == true and v.skillData.heroPos == 0 and v.skillData.lock == false and v.skillData.id ~= skillId then
			table.insert(SkillTable, v)
		end
	end

	for k, v in pairs(ItemTable) do
		local count = WarehouseModule.GetItemNumByCfgID(v.Id)
		local itemData

		itemData = WarehouseModule.FindItemForCid(v.Id)

		table.insert(itemDataTable, itemData)
	end

	table.sort(itemDataTable, function(a, b)
		return a:GetCfg().Quality < b:GetCfg().Quality
	end)

	return itemDataTable, SkillTable
end

function RoleDevelopmentModule.GetAllSkillItems(skillType, skillId, isEquiped)
	local skillItemsByType = {}

	skillId = skillId == nil and -1 or skillId

	for _, v in pairs(WarehouseModule.AllItems) do
		local itemTypes = v:GetCfg().ItemTypes

		if itemTypes == Constant.ItemType.Skill and (v.skillData:GetCfg().SkillType == Constant.SkillType.TYPE_LORE or v.skillData:GetCfg().SkillType == Constant.SkillType.TYPE_PROFESSION) and v.skillData.id ~= skillId then
			if isEquiped then
				if v.skillData.heroCid ~= 0 then
					table.insert(skillItemsByType, v)
				end
			else
				table.insert(skillItemsByType, v)
			end
		end
	end

	return skillItemsByType
end

function RoleDevelopmentModule.GetSkillItemsByCid(skillCid, id, isEquiped)
	local skillItemsByCid = {}

	for _, v in pairs(WarehouseModule.AllItems) do
		if v.cid == skillCid then
			if isEquiped then
				if v.skillData.heroCid ~= 0 then
					table.insert(skillItemsByCid, v)
				end
			elseif v.id ~= id then
				table.insert(skillItemsByCid, v)
			end
		end
	end

	return skillItemsByCid
end

function RoleDevelopmentModule.GetCurHeroSkill(heroCid, HeroData)
	local skills

	if HeroData then
		skills = HeroData.SkillGroups
	else
		skills = WarlockModule.WarlockDataDic[heroCid].SkillGroups
	end

	local skillList = {}

	for k, v in pairs(skills) do
		if v ~= nil then
			skillList[v.heroPos] = SkillData.New(v)

			skillList[v.heroPos]:UpdateData(v)
		end
	end

	return skillList
end

function RoleDevelopmentModule.GetSkillCfgByIDAndLv(id, lv)
	local nextLv = lv + 1
	local exist = false

	for k, v in pairsCfg(CfgSkillLevelTable) do
		if v.Skill == id and v.SkillLv == nextLv then
			exist = true

			return exist, v
		end
	end

	return exist, nil
end

function RoleDevelopmentModule.GetOpenSkillCondition(skillIndex)
	if skillIndex == 4 then
		return CfgDiscreteDataTable[28].Data[1]
	elseif skillIndex == 5 then
		return CfgDiscreteDataTable[29].Data[1]
	end

	return nil
end

function RoleDevelopmentModule.IsCommonlyUsedItem(id)
	local DiscreteCfg = CfgDiscreteDataTable[13].Data

	for i = 1, #DiscreteCfg do
		if DiscreteCfg[i] == id then
			return true
		end
	end

	return false
end

function RoleDevelopmentModule.GetSelectMaterialMaxCount(materialExp)
	local curMaxExp = RoleDevelopmentModule.CurMaxExp - RoleDevelopmentModule.CurPreviewEXP
	local count = math.ceil(curMaxExp / materialExp)

	return count
end

function RoleDevelopmentModule.GetHeroAndSkillCost(heroCid)
	local heroData = WarlockModule.WarlockDataDic[heroCid]
	local skillGroup = RoleDevelopmentModule.GetCurHeroSkill(heroCid)
	local allCost = heroData.AttributeGroups[9] == nil and 0 or heroData.AttributeGroups[9]
	local curCost = 0

	for _, v in pairs(skillGroup) do
		curCost = curCost + v.Cost
	end

	return allCost, curCost
end

function RoleDevelopmentModule.GetHeroStarLvCfgs(heroCid)
	local heroStarLevels = {}

	for k, v in pairsCfg(CfgHeroStarLevelTable) do
		if heroCid == v.HeroId then
			table.insert(heroStarLevels, v)
		end
	end

	table.sort(heroStarLevels, function(a, b)
		if a.StarLvNow == b.StarLvNow then
			return a.StarLv < b.StarLv
		end

		return a.StarLvNow < b.StarLvNow
	end)

	return heroStarLevels
end

function RoleDevelopmentModule.GetCurrentStarCfg(starLvCfgs, starLevel, starTime)
	for i = 1, #starLvCfgs do
		if starLvCfgs[i].StarLvNow == starLevel and starLvCfgs[i].StarLv == starTime then
			return starLvCfgs[i]
		end
	end

	return {
		StarLv = 0,
		StarLvNow = starLvCfgs[1].StarLvNow,
		AttrType = {
			Constant.Attribute.TYPE_HP,
			Constant.Attribute.TYPE_ATTACK,
			Constant.Attribute.TYPE_DEFENSE
		},
		AttrValue = {
			0,
			0,
			0
		}
	}
end

function RoleDevelopmentModule.GetNextStarCfg(starLvCfgs, starLevel, starTime)
	local cfg = RoleDevelopmentModule.GetStarCfgByLvAndTime(starLvCfgs, starLevel, starTime + 1)

	if cfg ~= nil then
		return cfg
	else
		return RoleDevelopmentModule.GetStarCfgByLvAndTime(starLvCfgs, starLevel + 1, 1)
	end

	return nil
end

function RoleDevelopmentModule.GetStarCfgByLvAndTime(starLvCfgs, starLevel, starTime)
	for i = 1, #starLvCfgs do
		if starLvCfgs[i].StarLvNow == starLevel and starLvCfgs[i].StarLv == starTime then
			return starLvCfgs[i]
		end
	end

	return nil
end

function RoleDevelopmentModule.GetStarRiseCount(starLvCfgs, starLevel, starTime)
	local index = 0

	for i = 1, #starLvCfgs do
		index = index + 1

		if starLvCfgs[i].StarLvNow == starLevel and starLvCfgs[i].StarLv == starTime then
			return index
		end
	end

	return 0
end

function RoleDevelopmentModule.GetAttrDataByStarCfg(starLvCfg, attrType)
	for k, v in pairs(starLvCfg.AttrType) do
		if v == attrType then
			return starLvCfg.AttrValue[k]
		end
	end
end

function RoleDevelopmentModule.GetHeroBaseAttrData(heroCid, attrType)
	local heroCfg = CfgHeroTable[heroCid]

	for i = 1, #heroCfg.Attribute, 3 do
		if heroCfg.Attribute[i] == attrType then
			return heroCfg.Attribute[i + 1]
		end
	end
end

function RoleDevelopmentModule.GetHeroBreakAttrValueByType(heroCid, attrType)
	local heroBreakTable = {}

	for k, v in pairsCfg(CfgHeroBreakTable) do
		if v.HeroId == heroCid then
			table.insert(heroBreakTable, v)
		end
	end

	table.sort(heroBreakTable, function(a, b)
		return a.BreakLv > b.BreakLv
	end)

	local attrIndex = table.indexOf(heroBreakTable[1].AttrType, attrType)

	if attrIndex <= 0 then
		return 0
	end

	return heroBreakTable[1].AttrValue[attrIndex]
end

function RoleDevelopmentModule.GetCurrentAttrQuality(attrValue, type)
	local discreteData

	if type == Constant.Attribute.TYPE_HP_GROWUP then
		discreteData = CfgDiscreteDataTable[80]
	elseif type == Constant.Attribute.TYPE_ATTACK_GROWUP then
		discreteData = CfgDiscreteDataTable[81]
	elseif type == Constant.Attribute.TYPE_DEFENSE_GROWUP then
		discreteData = CfgDiscreteDataTable[82]
	end

	local index = 0

	for i = 1, #discreteData.Data do
		if attrValue >= discreteData.Data[i] / 100 then
			index = index + 1
		else
			break
		end
	end

	if index > #discreteData.Data then
		index = #discreteData.Data
	end

	return index
end

function RoleDevelopmentModule.RoleUpgrade(roleCid, id2CountDic, preview)
	net_hero.useSoulExpItem(roleCid, id2CountDic, preview)
end

function RoleDevelopmentModule.RoleBreach(roleCid)
	net_hero.breakThrough(roleCid, false)
end

function RoleDevelopmentModule.RoleBreachForPreview(roleCid)
	net_hero.breakThrough(roleCid, true)
end

function RoleDevelopmentModule.RoleSkillUpgrade(skillID, id2CountDic)
	net_skill.upgradeSkill(skillID, id2CountDic)
end

function RoleDevelopmentModule.RoleSkillBeach(skillID)
	net_skill.strengSkill(skillID)
end

function RoleDevelopmentModule.RoleSkillWear(roleCid, pos, skillID)
	net_skill.wearSkill(roleCid, pos, skillID)
end

function RoleDevelopmentModule.RoleSkillUnload(roleCid, pos)
	net_skill.unloadSkill(roleCid, pos)
end

function RoleDevelopmentModule.RoleSkillLock(skillIds)
	net_skill.lockSkill(skillIds)
end

function RoleDevelopmentModule.AscendingStart(heroCid)
	net_hero.ascendingStart(heroCid)
end

function RoleDevelopmentModule.GetBreakReward(heroCid, BreakLv)
	net_hero.breakPrize(heroCid, BreakLv)
end

function RoleDevelopmentModule.PreviewHeroMax(heroCid, level, breakLv)
	net_hero.previewHeroMax(heroCid, level, breakLv)
end

function RoleDevelopmentModule.NotifyHeroChange(heros)
	EventDispatcher.Dispatch(EventID.RoleUpdateData, heros)
end

function RoleDevelopmentModule.RoleUpdradeResult(cri, preview, heroPod)
	if preview == true then
		EventDispatcher.Dispatch(EventID.RoleUpgradePreviewSuccessEvent, heroPod)
	else
		EventDispatcher.Dispatch(EventID.RoleUpgradeSuccess, cri)
	end
end

function RoleDevelopmentModule.RoleBreachResult(preview, hero)
	if preview then
		RoleDevelopmentModule.PreviewHeroData = hero

		EventDispatcher.Dispatch(EventID.GetRolePreviewBreakDataSucess)
	else
		EventDispatcher.Dispatch(EventID.RoleBreakThroughSucess)
		CVModule.PlayCV(Constant.CVActionType.RoleUpgrade, hero.cid)
	end
end

function RoleDevelopmentModule.RoleSkillUpgradeResult(code, oldSkillPod, skillpod, isUp)
	EventDispatcher.Dispatch(EventID.RoleSkillUpgradeSucess, oldSkillPod, skillpod, isUp)

	if isUp and CfgSkillTable[skillpod.skillCid].IsDiy then
		UIModule.Open(Constant.UIControllerName.SkillUpgradeTipsUI, Constant.UILayer.UI, {
			oldSkillPod = oldSkillPod,
			SkillPOD = skillpod
		})
	end
end

function RoleDevelopmentModule.RoleSkillBreachResult()
	EventDispatcher.Dispatch(EventID.RoleSkillBreachSucess)
end

function RoleDevelopmentModule.RoleSkillUnloadResult()
	EventDispatcher.Dispatch(EventID.RemoveSkillSucess)
end

function RoleDevelopmentModule.RoleSkillWearResult()
	EventDispatcher.Dispatch(EventID.WearSkillSucess)
end

function RoleDevelopmentModule.RoleSkillLockResult()
	EventDispatcher.Dispatch(EventID.LockSkillSucess)
end

function RoleDevelopmentModule.AscendingStartResult()
	EventDispatcher.Dispatch(EventID.AscendingStartSucess)
end

function RoleDevelopmentModule.GetBreakRewardResult(heroPOD, itemShowList)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShowList)
	EventDispatcher.Dispatch(EventID.GetBreakRewardSuccessEvent)
end

function RoleDevelopmentModule.PreviewHeroMaxResult(heroPod)
	local previewHeroData = WarlockData.New()

	previewHeroData:Initialize(heroPod)

	local heroCfg = CfgHeroTable[previewHeroData.cid]

	for i = 1, #heroCfg.Skill do
		-- block empty
	end

	EventDispatcher.Dispatch(EventID.GetPreviewHeroDataReuslt, previewHeroData)
end

function RoleDevelopmentModule.__InitRoleDevelopmentTipsTable()
	RoleDevelopmentModule.TipsCfgTable = {}

	ForPairs(CfgRoleDevelopmentTipsTable, function(_, _data)
		if RoleDevelopmentModule.TipsCfgTable[_data.Type] == nil then
			RoleDevelopmentModule.TipsCfgTable[_data.Type] = {}
		end

		table.insert(RoleDevelopmentModule.TipsCfgTable[_data.Type], _data)
	end)
end

function RoleDevelopmentModule.GetIndexByDiySkillType(skillType)
	local index = -1

	table.search(Constant.DIYSkillPosMapping, function(k, v)
		if v == skillType then
			index = k

			return true
		end
	end)

	return index
end

function RoleDevelopmentModule.GetSkillHasEquipedOnHero(heroCid, skillData)
	local heroData = WarlockModule.WarlockDataDic[heroCid]

	for k, v in pairs(heroData.SkillGroups) do
		if v ~= nil and (v.id == skillData.id or v.skillCid == skillData.skillCid) then
			return true
		end
	end

	return false
end

function RoleDevelopmentModule.GetHeroDiySkillPosIsSameSkill(heroCid, skillData, pos)
	local heroData = WarlockModule.WarlockDataDic[heroCid]
	local heroSKillData = heroData.SkillGroups[pos]

	if heroSKillData == nil or heroSKillData.skillCid ~= skillData.skillCid then
		return false
	end

	return true
end
