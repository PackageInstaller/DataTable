-- chunkname: @IQIGame\\Util\\CfgUtil.lua

CfgUtil = {}

local publicParameterDataPath = "Assets/25_CommonScriptableObject/PublicParameters.asset"

function CfgUtil.Init()
	CfgUtil._InitMembers()
	CfgUtil._InitDiscreteFunctionList()
	CfgUtil._InitResourceFunctionList()
	CfgUtil._InitParameterData()
end

function CfgUtil._InitMembers()
	CfgUtil.DiscreteFunctionList = {}
	CfgUtil.ResourceFunctionList = {}
	CfgUtil.CfgDiscreteData = CfgDiscreteDataTable
	CfgUtil.CfgResourceData = CfgResourceTable
end

function CfgUtil._InitParameterData()
	CoroutineUtility.StartCoroutine(function()
		local loadParameterDataCoroutine = CoroutineUtility.Yield(WaitLoadAsset(CfgUtil, publicParameterDataPath))

		CfgUtil.publicParametersData = loadParameterDataCoroutine.customWait.result
		Constant.LogType.Story = CfgUtil.publicParametersData.enableStoryLog
	end)
end

function CfgUtil.GetPublicParametersData()
	return CfgUtil.publicParametersData
end

function CfgUtil._InitDiscreteFunctionList()
	CfgUtil.DiscreteFunctionList[Constant.DiscreteData.StorySkipConversationTime] = CfgUtil.StorySkipConversationTimeFunction
	CfgUtil.DiscreteFunctionList[Constant.DiscreteData.AchievementDisplayMaxCount] = CfgUtil.AchievementDisplayMaxCountFunction
	CfgUtil.DiscreteFunctionList[Constant.DiscreteData.ActivityPassInfo] = CfgUtil.ActivityPassCfgInfo
	CfgUtil.DiscreteFunctionList[Constant.DiscreteData.ActivityPassBuyCommodityID] = CfgUtil.ActivityPassBuyCommodityID
	CfgUtil.DiscreteFunctionList[Constant.DiscreteData.CurrencyNotEnough] = CfgUtil.CurrencyNotEnoughTips
	CfgUtil.DiscreteFunctionList[Constant.DiscreteData.CurrencyNotEnoughNormal] = CfgUtil.CurrencyNotEnoughTipsNormal
	CfgUtil.DiscreteFunctionList[Constant.DiscreteData.StoryChatBubbleCharacterTime] = CfgUtil.StoryChatBubbleCharacterTimeFunction
end

function CfgUtil._InitResourceFunctionList()
	CfgUtil.ResourceFunctionList[Constant.Resource.TaskSystemUIRightBg] = CfgUtil.TaskSystemUIRightBgFunction
end

function CfgUtil.GetDiscreteDataWithID(ID, ...)
	if CfgUtil.DiscreteFunctionList[ID] then
		local func = CfgUtil.DiscreteFunctionList[ID]

		return func(...)
	end

	return CfgUtil.CfgDiscreteData[ID].Data
end

function CfgUtil.GetCfgDiscreteFirstDataWithID(ID)
	return CfgUtil.CfgDiscreteData[ID].Data[1]
end

function CfgUtil.GetCfgResourceData(ID)
	if CfgUtil.ResourceFunctionList[ID] then
		local func = CfgUtil.ResourceFunctionList[ID]

		return func()
	end
end

function CfgUtil.GetCfgResourceUrl(ID)
	if not CfgUtil.CfgResourceData[ID] then
		logError("获取Resource表资源失败，检查是否有该ID的配置。ID = " .. ID)
	end

	return CfgUtil.CfgResourceData[ID].Url
end

function CfgUtil.ActivityPassCfgInfo()
	local infoTable = {}

	infoTable.normalItemID = CfgUtil.CfgDiscreteData[Constant.DiscreteData.ActivityPassInfo].Data[1]
	infoTable.HighItemID = CfgUtil.CfgDiscreteData[Constant.DiscreteData.ActivityPassInfo].Data[2]
	infoTable.normalAwardGiftItemID = CfgUtil.CfgDiscreteData[Constant.DiscreteData.ActivityPassInfo].Data[3]
	infoTable.highAwardGiftItemID = CfgUtil.CfgDiscreteData[Constant.DiscreteData.ActivityPassInfo].Data[4]

	return infoTable
end

function CfgUtil.ActivityPassBuyCommodityID()
	local infoTable = {}

	infoTable.normal = CfgUtil.CfgDiscreteData[Constant.DiscreteData.ActivityPassBuyCommodityID].Data[1]
	infoTable.high = CfgUtil.CfgDiscreteData[Constant.DiscreteData.ActivityPassBuyCommodityID].Data[2]
	infoTable.priceDifference = CfgUtil.CfgDiscreteData[Constant.DiscreteData.ActivityPassBuyCommodityID].Data[3]

	return infoTable
end

function CfgUtil.StorySkipConversationTimeFunction()
	return CfgUtil.CfgDiscreteData[Constant.DiscreteData.StorySkipConversationTime].Data[1]
end

function CfgUtil.AchievementDisplayMaxCountFunction()
	return CfgUtil.CfgDiscreteData[Constant.DiscreteData.AchievementDisplayMaxCount].Data[1]
end

function CfgUtil.CurrencyNotEnoughTips(CurrencyItemID)
	local data = CfgUtil.CfgDiscreteData[Constant.DiscreteData.CurrencyNotEnough].Data

	for i = 1, #data do
		if data[i] == CurrencyItemID then
			return data[i + 1]
		end
	end
end

function CfgUtil.CurrencyNotEnoughTipsNormal()
	return CfgUtil.CfgDiscreteData[Constant.DiscreteData.CurrencyNotEnoughNormal].Data[1]
end

function CfgUtil.StoryChatBubbleCharacterTimeFunction()
	return CfgUtil.CfgDiscreteData[Constant.DiscreteData.StoryChatBubbleCharacterTime].Data[1]
end

function CfgUtil.TaskSystemUIRightBgFunction()
	return CfgUtil.CfgResourceData[Constant.Resource.TaskSystemUIRightBg].Url
end

function CfgUtil.GetItemCfgDataWithID(ID)
	if not CfgItemTable[ID] then
		logError(string.format("【配置表】道具表找不到 ID = %s 的道具", ID))

		return
	end

	return CfgItemTable[ID]
end

function CfgUtil.CheckCfgItemMainAndSubType(itemCfgId, itemType, itemSubType)
	local cfgItem = CfgUtil.GetItemCfgDataWithID(itemCfgId)

	if cfgItem.ItemTypes ~= itemType then
		return false
	end

	if cfgItem.ItemSubTypes ~= itemSubType then
		return false
	end

	return true
end

function CfgUtil.CheckCfgItemMainType(itemCfgId, itemType)
	local cfgItem = CfgUtil.GetItemCfgDataWithID(itemCfgId)

	if cfgItem.ItemTypes ~= itemType then
		return false
	end

	return true
end

function CfgUtil.GetCfgSkillDetailDataWithID(ID)
	return CfgSkillDetailTable[ID]
end

function CfgUtil.GetCfgSkillDataWithID(ID)
	return CfgSkillTable[ID]
end

function CfgUtil.GetCfgSkillRangeWithID(ID)
	return CfgSkillRangeTable[ID]
end

function CfgUtil.GetCfgSkillEnergyCost(ID)
	local cfgDetail = CfgUtil.GetCfgSkillDetailDataWithID(ID)

	return cfgDetail.NeedAp == nil and 0 or cfgDetail.NeedAp
end

function CfgUtil.GetCfgSkillLevelDataWithID(ID)
	local data = {}

	for _, v in pairsCfg(CfgSkillLevelTable) do
		if v.Skill == ID then
			table.insert(data, v)
		end
	end

	table.sort(data, function(a, b)
		return a.SkillLv < b.SkillLv
	end)

	return data
end

function CfgUtil.GetCfgSkillLevelDataByLevel(ID, level)
	for _, v in pairsCfg(CfgSkillLevelTable) do
		if v.Skill == ID and v.SkillLv == level then
			return v
		end
	end
end

function CfgUtil.GetCfgSkillStrengthenData(ID)
	return CfgSkillStrengthenTable[ID]
end

function CfgUtil.GetSkillCD_Eg_Ct(heroData, skillCid, skillLevel)
	local cfgSkill = CfgUtil.GetCfgSkillDetailDataWithID(skillCid)
	local CfgSkillLevelData = CfgUtil.GetCfgSkillLevelDataByLevel(skillCid, skillLevel)
	local strengthenIdList = Clone(CfgSkillLevelData.StrengthenId)
	local personalityUnLockData = WarlockModule.GetAllUnLockPersonalityDataWithHeroID(heroData)

	for i = 1, #personalityUnLockData do
		table.insert(strengthenIdList, personalityUnLockData[i].config.StrengthenId)
	end

	local cd = cfgSkill.CoolDown or 0
	local energy = CfgUtil.GetCfgSkillEnergyCost(skillCid)
	local cost = 0

	for i = 1, #strengthenIdList do
		local CfgSkillStrengthenData = CfgUtil.GetCfgSkillStrengthenData(strengthenIdList[i])

		for i = 1, #CfgSkillStrengthenData.SkillSlotEffect do
			local effectType = CfgSkillStrengthenData.SkillSlotEffect[i]

			if effectType == Constant.SkillChangeType.TYPE_CHANGE_AP then
				local apParams = CfgSkillStrengthenData.SkillSlotEffectParam[i]

				for j = 1, #apParams, 2 do
					energy = energy + tonumber(apParams[j + 1])
				end
			elseif effectType == Constant.SkillChangeType.TYPE_CHANGE_COST then
				local costParams = CfgSkillStrengthenData.SkillSlotEffectParam[i]

				for j = 1, #costParams, 2 do
					cost = cost + tonumber(costParams[j + 1])
				end
			elseif effectType == Constant.SkillChangeType.TYPE_CHANGE_SKILL_CD then
				local cdParams = CfgSkillStrengthenData.SkillSlotEffectParam[i]

				for j = 1, #cdParams, 2 do
					cd = cd + tonumber(cdParams[j + 1])
				end
			end
		end
	end

	energy = energy < 0 and 0 or energy
	cost = cost < 0 and 0 or cost
	cd = cd < 0 and 0 or cd

	return cd, energy, cost
end

function CfgUtil.GetCfgAttributeDataWithID(ID)
	if not CfgAttributeTable[ID] then
		logError(string.format("【配置表】Attribute.csv表找不到 ID = %s", ID))

		return
	end

	return CfgAttributeTable[ID]
end

function CfgUtil.GetPlotCfgDataWithID(ID)
	return CfgPlotTable[ID]
end

function CfgUtil.GetCfgStoryDataWithID(ID)
	if not CfgStoryDataTable[ID] then
		logError(string.format("【配置表】StoryData.csv表找不到 ID = %s", ID))

		return
	end

	return CfgStoryDataTable[ID]
end

function CfgUtil.GetCfgStoryIncidentDataWithID(ID)
	if not CfgStoryIncidentTable[ID] then
		logError(string.format("【配置表】StoryIncident.csv表找不到 ID = %s", ID))

		return
	end

	return CfgStoryIncidentTable[ID]
end

function CfgUtil.GetCfgStoryBattleDataWithID(ID)
	if not CfgStoryBattleTable[ID] then
		logError(string.format("【配置表】StoryBattle.csv表找不到 ID = %s", ID))

		return
	end

	return CfgStoryBattleTable[ID]
end

function CfgUtil.GetCfgSceneListDataWithID(ID)
	if not CfgSceneListTable[ID] then
		logError(string.format("【配置表】SceneList.csv表找不到 ID = %s", ID))

		return
	end

	return CfgSceneListTable[ID]
end

function CfgUtil.GetMonsterCfgDataWithID(ID)
	if not CfgMonsterTable[ID] then
		logError(string.format("【【配置表】Monster.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgMonsterTable[ID]
end

function CfgUtil.GetCfgBuffDataWithID(ID)
	if not CfgBuffTable[ID] then
		logError(string.format("【【配置表】Buff.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgBuffTable[ID]
end

function CfgUtil.GetFavorLvCfgDataWithID(ID)
	if not CfgFavorLvTable[ID] then
		logError(string.format("【【配置表】FavorLv.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgFavorLvTable[ID]
end

function CfgUtil.GetFavorLvCfgDataWithHeroCid(heroCid)
	local heroData = WarlockModule.GetHeroData(heroCid)

	for _, v in pairsCfg(CfgFavorLvTable) do
		if v.HeroID == heroCid and v.FavorLv == heroData.favorabilityLevel then
			return v
		end
	end
end

function CfgUtil.GetHeroCfgDataWithID(ID)
	if not CfgHeroTable[ID] then
		logError(string.format("【配置表】Hero.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgHeroTable[ID]
end

function CfgUtil.GetCfgFavorMessageGroupDataWithID(ID)
	if not CfgFavorMessageGroupTable[ID] then
		logError(string.format("【配置表】FavorMessageGroup.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgFavorMessageGroupTable[ID]
end

function CfgUtil.GetCfgFavorMessageEntryDataWithID(ID)
	if not CfgFavorMessageEntryTable[ID] then
		logError(string.format("【配置表】FavorMessageEntry.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgFavorMessageEntryTable[ID]
end

function CfgUtil.GetCfgFavorMessageOptionDataWithID(ID)
	if not CfgFavorMessageOptionTable[ID] then
		logError(string.format("【配置表】FavorMessageOption.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgFavorMessageOptionTable[ID]
end

function CfgUtil.GetCfgEquipDataWithID(ID)
	if not CfgEquipTable[ID] then
		logError(string.format("【配置表】Equip.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgEquipTable[ID]
end

function CfgUtil.GetCfgEquipSuitData(suitID, suitType)
	local array = {}

	for _, v in pairs(CfgEquipSuitTable) do
		if v.SuitID == suitID and v.SuitType == suitType then
			table.insert(array, v)
		end
	end

	return array
end

function CfgUtil.GetCfgEquipSuitDataLimitCount(suitID, suitType, needCount)
	local array = {}

	for _, v in pairs(CfgEquipSuitTable) do
		if v.SuitID == suitID and v.SuitType == suitType and needCount >= v.NeedCount then
			table.insert(array, v)
		end
	end

	return array
end

function CfgUtil.CfgEquipAttrDataWithID(ID)
	if not CfgEquipAttrTable[ID] then
		logError(string.format("【配置表】EquipAttr.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgEquipAttrTable[ID]
end

function CfgUtil.GetCfgAttributeDataWithID(ID)
	if not CfgAttributeTable[ID] then
		logError(string.format("【配置表】Attribute.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgAttributeTable[ID]
end

function CfgUtil.GetCfgBossStageDataWithID(ID)
	if not CfgBossStageTable[ID] then
		logError(string.format("【配置表】BossStage.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgBossStageTable[ID]
end

function CfgUtil.GetCfgBossChapterDataWithID(ID)
	if not CfgBossChapterTable[ID] then
		logError(string.format("【配置表】BossChapter.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgBossChapterTable[ID]
end

function CfgUtil.GetSoundCfgDataWithID(ID)
	return CfgSoundTable[ID]
end

function CfgUtil.GetCommodityDataWithID(ID)
	return CfgCommodityTable[ID]
end

function CfgUtil.GetCardJackpotWithID(ID)
	return CfgCardJackpotTable[ID]
end

function CfgUtil.GetStoryResourceWithID(ID)
	local cfg = CfgStoryResourcesTable[ID]

	if not cfg then
		logError(string.format("【【配置表】StoryResources.csv 没有找到 ID = %s 的配置", ID))

		return nil
	end

	if PlayerModule.GetSex() == Constant.PlayerSex.WoMen and not LuaUtility.StrIsNullOrEmpty(cfg.Url_Female) then
		return cfg.Url_Female
	else
		return cfg.Url
	end
end

function CfgUtil.GetTaskCfgWithID(ID)
	return CfgTaskTable[ID]
end

function CfgUtil.GetSoundIDByAnimationName(characterID, animationName)
	for _, v in pairsCfg(CfgStorySoundTable) do
		if v.Animation == animationName and v.CharacterID then
			for _, id in pairs(v.CharacterID) do
				if id == characterID then
					return v
				end
			end
		end
	end
end

function CfgUtil.GetCfgTipsTextWithID(ID)
	if not CfgTipsTable[ID] then
		logError(string.format("【配置表】Tips.csv中id为 %s 的配置为空", ID))

		return string.format("配置错误 ID = %s", ID)
	end

	local str = CfgTipsTable[ID].Text

	return str
end

function CfgUtil.GetCfgHeroDataWithID(ID)
	return CfgHeroTable[ID]
end

function CfgUtil.GetCfgRedDotsDataWithID(Cid)
	return CfgRedDotsTable[Cid]
end

function CfgUtil.GetCfgHelpTipsDataWithID(ID)
	return CfgHelpTipsTable[ID].Text
end

function CfgUtil.GetCfgFunctionDataWithID(ID)
	if not CfgFunctionTable[ID] then
		logError(string.format("【配置表】Function.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgFunctionTable[ID]
end

function CfgUtil.GetCfgCluesDataWithID(ID)
	if not CfgCluesTable[ID] then
		logError(string.format("【配置表】Clues.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgCluesTable[ID]
end

function CfgUtil.GetCfgCluesCraftDataWithID(ID)
	if not CfgCluesCraftTable[ID] then
		logError(string.format("【配置表】CluesCraft.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgCluesCraftTable[ID]
end

function CfgUtil.GetCfgStoryOptionDataWithID(ID)
	if not CfgStoryOptionTable[ID] then
		logError(string.format("【配置表】StoryOption.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgStoryOptionTable[ID]
end

function CfgUtil.GetCfgStoryDialogueDataWithID(ID)
	if not CfgStoryDialogueTable[ID] then
		logError(string.format("【配置表】StoryDialogue.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgStoryDialogueTable[ID]
end

function CfgUtil.GetCfgStorySpeakNpcDataWithID(ID)
	if not CfgStorySpeakNPCTable[ID] then
		logError(string.format("【配置表】StorySpeakNPC.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgStorySpeakNPCTable[ID]
end

function CfgUtil.GetCfgAnimationDataWithID(ID)
	if not CfgAnimationTable[ID] then
		logError(string.format("【配置表】Animation.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgAnimationTable[ID]
end

function CfgUtil.GetCfgCfgElementEntityDataWithID(ID)
	if not CfgElementEntityTable[ID] then
		logError(string.format("【配置表】ElementEntity.csv 没有找到 ID = %s 的配置", ID))

		return
	end

	return CfgElementEntityTable[ID]
end

function CfgUtil.GetCfgStoryTextDataWithID(ID)
	local cfg = CfgStoryTextTable[ID]

	if not cfg then
		logError(string.format("【配置表】StoryText.csv中id为 %s 的配置为空", ID))

		return string.format("配置错误 ID = %s", ID)
	end

	if PlayerModule.GetSex() == Constant.PlayerSex.WoMen and not LuaUtility.StrIsNullOrEmpty(cfg.Text_Female) then
		return cfg.Text_Female
	else
		return cfg.Text
	end
end

function CfgUtil.GetCfgEffectEntityDataWithID(ID)
	if not CfgEffectEntityTable[ID] then
		logError(string.format("【配置表】EffectEntity.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgEffectEntityTable[ID]
end

function CfgUtil.GetCfgFacialEffectDataWithID(ID)
	if not CfgFacialEffectTable[ID] then
		logError(string.format("【配置表】FacialEffect.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgFacialEffectTable[ID]
end

function CfgUtil.GetCfgGuideDataWithID(ID)
	if not CfgGuideTable[ID] then
		logError(string.format("【配置表】Guide.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgGuideTable[ID]
end

function CfgUtil.GetCfgConditionDataWithID(ID)
	if not CfgConditionTable[ID] then
		logError(string.format("【配置表】Condition.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgConditionTable[ID]
end

function CfgUtil.GetCfgCombinationDataWithID(ID)
	if not CfgCombinationTable[ID] then
		logError(string.format("【配置表】Combination.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgCombinationTable[ID]
end

function CfgUtil.GetCfgLoopMapDataWithID(ID)
	for _, v in pairs(CfgLoopMapList) do
		if v.ID == ID then
			return v
		end
	end

	logError(string.format("【配置表】CfgLoopMap.lua 中id为 %s 的配置为空", ID))
end

function CfgUtil.GetCfgPersonalityDataWithID(ID)
	if not CfgPersonalityTable[ID] then
		logError(string.format("【配置表】Personality.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgPersonalityTable[ID]
end

function CfgUtil.GetCfgPlayerLevelDataWithID(ID)
	if not CfgPlayerLevelTable[ID] then
		logError(string.format("【配置表】PlayerLevel.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgPlayerLevelTable[ID]
end

function CfgUtil.GetCfgActivityChapterDataWithID(ID)
	if not CfgActivityChapterTable[ID] then
		logError(string.format("【配置表】ActivityChapter.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgActivityChapterTable[ID]
end

function CfgUtil.GetCfgActivityStageDataWithID(ID)
	if not CfgActivityStageTable[ID] then
		logError(string.format("【配置表】ActivityStage.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgActivityStageTable[ID]
end

function CfgUtil.GetCfgDupTagDataWithID(ID)
	if not CfgDupTagTable[ID] then
		logError(string.format("【配置表】DupTag.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgDupTagTable[ID]
end

function CfgUtil.GetCfgActivityDataWithID(ID)
	if not CfgActivityTable[ID] then
		logError(string.format("【配置表】Activity.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgActivityTable[ID]
end

function CfgUtil.GetCfgCVHeroDataWithID(ID)
	if not CfgCVHeroTable[ID] then
		logError(string.format("【配置表】CVHero.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgCVHeroTable[ID]
end

function CfgUtil.GetCfgTowerChapterDataWithID(ID)
	if not CfgTowerChapterTable[ID] then
		logError(string.format("【配置表】TowerChapter.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgTowerChapterTable[ID]
end

function CfgUtil.GetCfgWorldMapItemDataWithID(ID)
	if not CfgWorldMapItemTable[ID] then
		logError(string.format("【配置表】WorldMapItem.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgWorldMapItemTable[ID]
end

function CfgUtil.GetCfgGeneralDupChapterDataWithID(ID)
	if not CfgGeneralDupChapterTable[ID] then
		logError(string.format("【配置表】CfgGeneralDupChapter.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgGeneralDupChapterTable[ID]
end

function CfgUtil.GetCfgDropLibDataWithID(ID)
	if not CfgDropLibTable[ID] then
		logError(string.format("【配置表】DropLib.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgDropLibTable[ID]
end

function CfgUtil.GetDropAwardListWithID(ID)
	local data = {}
	local cfgDrop = CfgUtil.GetCfgDropLibDataWithID(ID)

	for index, itemID in pairs(cfgDrop.DropShowItem) do
		local t = {}

		t.itemID = itemID
		t.num = cfgDrop.DropShowItemNum[index]
		t.tag = cfgDrop.DropItemTag[index]

		table.insert(data, t)
	end

	return data
end

function CfgUtil.GetCfgWorldMapRoomDataWithID(ID)
	if not CfgWorldMapRoomTable[ID] then
		logError(string.format("【配置表】WorldMapRoom.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgWorldMapRoomTable[ID]
end

function CfgUtil.GetCfgWorldRoomSceneDataWithID(ID)
	if not CfgWorldRoomSceneTable[ID] then
		logError(string.format("【配置表】WorldRoomScene.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgWorldRoomSceneTable[ID]
end

function CfgUtil.GetCfgWorldRoomPartDataWithID(ID)
	if not CfgWorldRoomPartTable[ID] then
		logError(string.format("【配置表】WorldRoomPart.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgWorldRoomPartTable[ID]
end

function CfgUtil.GetCfgWorldMapAreaDataWithID(ID)
	if not CfgWorldMapAreaTable[ID] then
		logError(string.format("【配置表】WorldMapArea.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgWorldMapAreaTable[ID]
end

function CfgUtil.GetCfgMainDialogueDataWithID(ID)
	if not CfgMainDialogueTable[ID] then
		logError(string.format("【配置表】MainDialogue.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgMainDialogueTable[ID]
end

function CfgUtil.GetCfgWorldRoomCompDataWithID(ID)
	if not CfgWorldRoomCompTable[ID] then
		logError(string.format("【配置表】WorldRoomComp.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgWorldRoomCompTable[ID]
end

function CfgUtil.GetCfgWorldRoomActionDataWithID(ID)
	if not CfgWorldRoomActionTable[ID] then
		logError(string.format("【配置表】WorldRoomAction.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgWorldRoomActionTable[ID]
end

function CfgUtil.GetCfgAiGroupDataWithID(ID)
	if not CfgAiGroupTable[ID] then
		logError(string.format("【配置表】AiGroup.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgAiGroupTable[ID]
end

function CfgUtil.GetCfgWorldMapDailyEaterDataWithID(ID)
	if not CfgWorldMapDailyEaterTable[ID] then
		logError(string.format("【配置表】WorldMapDailyEater.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgWorldMapDailyEaterTable[ID]
end

function CfgUtil.GetCfgDrawLotsDataWithID(ID)
	if not CfgDrawLotsTable[ID] then
		logError(string.format("【配置表】CfgDrawLots.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgDrawLotsTable[ID]
end

function CfgUtil.GetCfgCrusadeDupStageDataWithID(ID)
	if not CfgCrusadeDupStageTable[ID] then
		logError(string.format("【配置表】CrusadeDupStage.csv中id为 %s 的配置为空", ID))

		return
	end

	return CfgCrusadeDupStageTable[ID]
end
