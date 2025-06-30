-- chunkname: @IQIGame\\Module\\Soul\\SoulData.lua

SoulData = {
	isUnlock = false,
	favorMaxLv = 1,
	mood = 0,
	exp = 0,
	totalTalentCount = 0,
	dailyDislike = false,
	moodTimeInterval = 0,
	favor = 0,
	workStatus = 0,
	oathActivation = false,
	favorLv = 1,
	insecureNotFirstUnlock = false,
	lv = 1,
	maxStarFeatureIds = {},
	unlockSkillGroups = {},
	talentCids = {},
	talentGroupCids = {},
	dress2DDataList = {},
	dress3DDataList = {},
	unlockSoulItemIDList = {},
	unlockSoulItemCountList = {},
	activationSkillStrengthen = {},
	damageTypes = {},
	classTypes = {},
	CfgSoulSpecialSpirits = {},
	curAttStageStarDatum = {},
	jewelry = {}
}

function SoulData.New()
	local o = Clone(SoulData)

	return o
end

function SoulData:Initialize(soulCid, soulPOD, No)
	if soulPOD ~= nil and soulCid ~= soulPOD.cid then
		logError("[SoulData]->SoulCid is invalid.")

		return
	end

	self.soulCid = soulCid
	self.No = No
	self.soulQualityCid = 1

	local dress2DCid = -1
	local dress3DCid = -1

	if soulPOD ~= nil then
		self.isUnlock = true
		self.favor = soulPOD.favor or 0
		self.soulQualityCid = soulPOD.qualityId or 0
		self.dailyDislike = soulPOD.dailyDislike or false
		self.exp = soulPOD.exp or 0
		self.talentCids = soulPOD.talentCids or {}
		self.talentGroupCids = soulPOD.talentGroupCids or {}
		self.unlockSkillGroups = soulPOD.unlockSkillGroups or {}
		self.activationSkillStrengthen = soulPOD.activationSkillStrengthen or {}
		self.lv = soulPOD.lv or 1
		self.favorLv = soulPOD.favorLv or 1
		self.favorMaxLv = soulPOD.favorMaxLv or 1
		self.mood = soulPOD.mood or 0
		self.oathActivation = soulPOD.oathActivation or false
		self.moodTimeInterval = soulPOD.moodTimeInterval or Constant.Number.IntMaxValue
		self.soulMemoryPieces = soulPOD.soulMemoryPieces or {}
		self.atts = soulPOD.soulAttr or {}
		self.workStatus = soulPOD.workStatus or 0
		dress2DCid = soulPOD.dress2DCid or -1
		dress3DCid = soulPOD.dress3DCid or -1
		self.jewelry = soulPOD.jewelry
	end

	self:InitDressDatum(self.soulCid, dress2DCid, dress3DCid)
	self:InitDamageTypes()
	self:InitClassTypes()

	for i, v in ipairs(self:GetCfgSoul().UnlockItem) do
		if i % 2 == 0 then
			self.unlockSoulItemCountList[#self.unlockSoulItemCountList + 1] = v
		else
			self.unlockSoulItemIDList[#self.unlockSoulItemIDList + 1] = v
		end
	end

	for i, v in pairsCfg(CfgSoulQualityTable) do
		if v.SoulId == self.soulCid and v.Quality == 5 then
			for m, n in ipairs(v.ADDSkillID) do
				self.maxStarFeatureIds[m] = n
			end

			break
		end
	end

	self.totalTalentCount = 0

	local groupCids = self:GetCfgSoul().TalentGroupId

	for i, v in pairsCfg(CfgSoulTalentTable) do
		for m, n in pairs(groupCids) do
			if v.GroupId == n then
				self.totalTalentCount = self.totalTalentCount + 1
			end
		end
	end

	self:RefreshSpDatum(soulPOD)
end

function SoulData:InitDressDatum(soulCid, dressCid2D, dressCid3D)
	for i, v in pairsCfg(CfgDressTable) do
		if v.SoulID == soulCid then
			if v.Type == 1 then
				if v.InitialDress == 1 then
					self.originalDressCid3D = i
				end
			elseif v.Type == 2 and v.InitialDress == 1 then
				self.originalDressCid2D = i
			end
		end
	end

	if dressCid2D == -1 then
		dressCid2D = self.originalDressCid2D
	end

	if dressCid3D == -1 then
		dressCid3D = self.originalDressCid3D
	end

	self.dressCid2D = dressCid2D
	self.dressCid3D = dressCid3D
	self.dress2DDataList = DressModule.GetSoulDressDataList(self.soulCid, 2)
	self.dress3DDataList = DressModule.GetSoulDressDataList(self.soulCid, 1)

	self:SortDress(1)
	self:SortDress(2)
end

function SoulData:InitDamageTypes()
	self.damageTypes = {}

	local skillGroups = self:GetCfgSoul().DefaultSkill
	local skills = {}

	for i = 1, 2 do
		for m, n in ipairs(CfgSkillGroupTable[skillGroups[i]].GroupSkills) do
			skills[#skills + 1] = n
		end
	end

	self.damageTypes = SkillModule.GetDamageTypes(skills)
end

function SoulData:InitClassTypes()
	self.classTypes = {}

	local skillGroups = self:GetCfgSoul().DefaultSkill

	for i = 1, 2 do
		local types = CfgSkillGroupTable[skillGroups[i]].SoulClass

		for m, n in ipairs(types) do
			self.classTypes[#self.classTypes + 1] = n
		end
	end
end

function SoulData:RefreshSpDatum(soulPOD)
	if soulPOD == nil then
		return
	end

	self.cfgSoulSpDataAtt = nil
	self.CfgSoulSpecialSpirits = {}

	if soulPOD ~= nil and soulPOD.specialSpirit ~= nil then
		for i, v in pairs(soulPOD.specialSpirit) do
			local cfgSpData = CfgSoulSpecialSpiritTable[v]

			if cfgSpData.Group == 1 then
				self.cfgSoulSpDataAtt = cfgSpData
			elseif SoulSpecialSpiritModule.IsSpSkillGroup(cfgSpData.Group) then
				local skillIndex = SoulSpecialSpiritModule.GetSpSkillIndex(cfgSpData.Group)

				self.CfgSoulSpecialSpirits[skillIndex] = cfgSpData
			end
		end
	end

	local curLv = self:GetCurAttrSpiritLevel()

	self.cfgSoulSpDataAttToActive = SoulSpecialSpiritModule.GetCfgData(self.soulCid, 1, curLv + 1)

	local curStage = 1

	if self.cfgSoulSpDataAttToActive ~= nil then
		curStage = self.cfgSoulSpDataAttToActive.Stage
	elseif self.cfgSoulSpDataAtt ~= nil then
		curStage = self.cfgSoulSpDataAtt.Stage
	end

	self.curAttStageStarDatum = {}

	local cfgDataList = SoulSpecialSpiritModule.GetCfgListByGroupStage(self.soulCid, 1, curStage)

	if cfgDataList ~= nil then
		for i = 1, #cfgDataList do
			local cfgData = cfgDataList[i]

			self.curAttStageStarDatum[i] = {
				cid = cfgData.Id,
				isUnlock = self.cfgSoulSpDataAtt ~= nil and cfgData.Level <= self.cfgSoulSpDataAtt.Level,
				Level = cfgData.Level
			}
		end
	end

	local group = 2

	self.__SpSkillTotalLvs = {}
	self.cfgSoulSpDataSkillToActive = {}

	for i = 1, SoulSpecialSpiritModule.GetSpSkillNum() do
		local skillIndex = SoulSpecialSpiritModule.GetSpSkillIndex(group)

		self.__SpSkillTotalLvs[skillIndex] = SoulSpecialSpiritModule.GetMaxLvInGroup(self.soulCid, group)

		local curSpSkillEnhanceCfgData = self.CfgSoulSpecialSpirits[skillIndex]
		local curSpSkillEnhanceLevel = curSpSkillEnhanceCfgData ~= nil and curSpSkillEnhanceCfgData.Level or 0

		self.cfgSoulSpDataSkillToActive[skillIndex] = SoulSpecialSpiritModule.GetCfgData(self.soulCid, group, curSpSkillEnhanceLevel + 1)
		group = group + 1
	end
end

function SoulData:GetCurAttrSpiritLevel()
	return self.cfgSoulSpDataAtt ~= nil and self.cfgSoulSpDataAtt.Level or 0
end

function SoulData:GetFeatureOfNextLvSpirit(index)
	local toNextLvCfgData = self.cfgSoulSpDataSkillToActive[index]

	if toNextLvCfgData ~= nil then
		if #toNextLvCfgData.ADDSkillStrengthen > 0 then
			return toNextLvCfgData.ADDSkillStrengthen[#toNextLvCfgData.ADDSkillStrengthen], 0
		elseif toNextLvCfgData.AddOptionalSkill ~= 0 then
			return 0, toNextLvCfgData.AddOptionalSkill
		elseif toNextLvCfgData.ADDSkillID ~= 0 then
			return 0, toNextLvCfgData.ADDSkillID
		end
	end

	return 0, 0
end

function SoulData:GetSpSkillTotalLv(index)
	local lv = self.__SpSkillTotalLvs[index] or 0

	return lv
end

function SoulData:GetSpSkillLvByIndex(skillIndex)
	local cfg = self.CfgSoulSpecialSpirits[skillIndex]

	if cfg == nil then
		return 0
	end

	return cfg.Level
end

function SoulData:GetSpSkillByIndex(skillIndex, onlyUnlock)
	local cfg = self.CfgSoulSpecialSpirits[skillIndex]

	if cfg == nil and not onlyUnlock then
		cfg = self.cfgSoulSpDataSkillToActive[skillIndex]
	end

	if cfg ~= nil then
		return CfgSkillTable[cfg.Skill]
	end

	return nil
end

function SoulData:GetSpOptionalSkillByIndex(optionalSkillIndex, onlyUnlock)
	local skillIndex = optionalSkillIndex + 2

	return self:GetSpSkillByIndex(skillIndex, onlyUnlock)
end

function SoulData:HasAvailableOptionalSpSkill()
	for i = 1, SoulSpecialSpiritModule.GetSpSkillNum() do
		local optionalSkillIndex = SoulSpecialSpiritModule.GetOptionalSkillIndexBySpSkillIndex(i)

		if optionalSkillIndex ~= -1 and self.CfgSoulSpecialSpirits[i] ~= nil then
			return true
		end
	end

	return false
end

function SoulData:GetSpSkillStrengthen(skillIndex)
	local cfgData = self.CfgSoulSpecialSpirits[skillIndex]

	if cfgData == nil then
		return nil
	end

	return cfgData.ADDSkillStrengthen
end

function SoulData:SortDress(dressType)
	if dressType == 1 then
		table.sort(self.dress3DDataList, SoulData.DoSortDress)
	elseif dressType == 2 then
		table.sort(self.dress2DDataList, SoulData.DoSortDress)
	end
end

function SoulData.DoSortDress(tb1, tb2)
	if tb1.hasOwned == true and tb2.hasOwned == false then
		return true
	elseif tb1.hasOwned == false and tb2.hasOwned == true then
		return false
	elseif tb1.hasOwned == true and tb2.hasOwned == true then
		if tb1.cfgDressRow.Id < tb2.cfgDressRow.Id then
			return true
		else
			return false
		end
	elseif tb1.hasOwned == false and tb1.hasOwned == false then
		if tb1.cfgDressRow.Id < tb2.cfgDressRow.Id then
			return true
		else
			return false
		end
	end
end

function SoulData:RecoverOriginalDressData(dressType)
	if dressType == 1 then
		self.dressCid3D = self.originalDressCid3D
	elseif dressType == 2 then
		self.dressCid2D = self.originalDressCid2D
	end
end

function SoulData.SortFavorValue(tb1, tb2)
	local aq = tonumber(tb1.FavorValue)
	local bq = tonumber(tb2.FavorValue)

	return bq < aq
end

function SoulData:UpgradePercent()
	local percent = 0
	local lvExp = self:GetSoulFavor(self.favorLv)

	percent = self.favor / lvExp

	return percent
end

function SoulData:UpgradeFavor()
	local lvExp = self:GetSoulFavor(self.favorLv)

	return self.favor, lvExp
end

function SoulData:CheckExistSpineDress()
	return self:GetCfgSoulRes2D().SpineActionControl ~= 0
end

function SoulData:CheckFeatureUnlock(featureId)
	local cfgQualityData = self:GetCfgSoulQuality()

	for i, v in pairs(cfgQualityData.ADDSkillID) do
		if featureId == v then
			return true
		end
	end

	return false
end

function SoulData:CheckStrengthenIsActive(strengthenCid)
	return table.indexOf(self.activationSkillStrengthen, strengthenCid) ~= -1
end

function SoulData:CheckCanUnlock()
	if self.isUnlock == true then
		return false
	else
		for i, v in ipairs(self.unlockSoulItemIDList) do
			local needCount = self.unlockSoulItemCountList[i]
			local ownCount = WarehouseModule.GetItemNumByCfgID(v)

			if needCount <= ownCount then
				return true
			end
		end
	end

	return false
end

function SoulData:CheckItemEnoughToUpQualityLv()
	for i, v in ipairs(self:GetUpQualityLvItemIds()) do
		local needCount = self:GetCostItemCountToUpQualityLv()[i]
		local ownCount = WarehouseModule.GetItemNumByCfgID(v)

		if ownCount < needCount then
			return false
		end
	end

	return true
end

function SoulData:CheckFullQuality()
	return CfgSoulQualityTable[self.soulQualityCid].NextLevel == 0
end

function SoulData:CheckAllowAddStarExp()
	return false
end

function SoulData:GetGrowUpValues(cfgData)
	local ret = {
		cfgData.LevelAtkUP,
		cfgData.LevelMAtkUP,
		cfgData.LevelMaxHpUP,
		cfgData.LevelSpeedUP,
		cfgData.LevelDefUP,
		cfgData.LevelMDefUP
	}

	return ret
end

function SoulData:GetWoreDressIndexInDataList(dressType)
	local dataList = self.dress2DDataList

	if dressType == 1 then
		dataList = self.dress3DDataList
	end

	for i, v in ipairs(dataList) do
		if v:CheckWore() == true then
			return i - 1
		end
	end

	return 0
end

function SoulData:GetCfgSoul()
	return CfgSoulTable[self.soulCid]
end

function SoulData:GetAbilities()
	local ret = {}
	local firstGroupId = self:GetCfgSoul().TalentGroupId[1]

	for i, v in pairsCfg(CfgSoulTalentTable) do
		if v.GroupId == firstGroupId and v.Type == 1 then
			ret[1] = v.Ability[1]
			ret[2] = v.Ability[2]

			break
		end
	end

	return ret
end

function SoulData:GetCfgSoulQuality()
	return CfgSoulQualityTable[self.soulQualityCid]
end

function SoulData:GetCfgSoulQualityNext()
	if self:GetCfgSoulQuality().NextLevel == 0 then
		return nil
	end

	return CfgSoulQualityTable[self:GetCfgSoulQuality().NextLevel]
end

function SoulData:GetCfgDress2D()
	return CfgDressTable[self.dressCid2D]
end

function SoulData:GetCfgDress3D()
	return CfgDressTable[self.dressCid3D]
end

function SoulData:GetOriginalCfgDress2D()
	return CfgDressTable[self.originalDressCid2D]
end

function SoulData:GetOriginalCfgDress3D()
	return CfgDressTable[self.originalDressCid3D]
end

function SoulData:GetCfgSoulRes2D()
	return CfgSoulResTable[self:GetCfgDress2D().SoulResID]
end

function SoulData:GetCfgSoulRes3D()
	return CfgSoulResTable[self:GetCfgDress3D().SoulResID]
end

function SoulData:GetOriginalCfgSoulRes2D()
	return CfgSoulResTable[self:GetOriginalCfgDress2D().SoulResID]
end

function SoulData:GetOriginalCfgSoulRes3D()
	return CfgSoulResTable[self:GetOriginalCfgDress3D().SoulResID]
end

function SoulData:GetDefaultHeadIcon()
	return CfgSoulResTable[CfgDressTable[self.originalDressCid3D].SoulResID].HeadIcon
end

function SoulData:GetSpinePath()
	local entityID = self:GetCfgSoulRes3D().UIEntityId
	local path = UIGlobalApi.GetElementPrefab(CfgElementEntityTable[entityID].PrefabName)

	return path
end

function SoulData:GetUpQualityLvItemIds()
	local ret = {}

	for i, v in ipairs(self:GetCfgSoulQuality().Cost) do
		if i % 2 ~= 0 then
			ret[#ret + 1] = v
		end
	end

	return ret
end

function SoulData:GetAllCfgQuality()
	local ret = {}

	for i, v in pairsCfg(CfgSoulQualityTable) do
		if v.SoulId == self.soulCid then
			ret[#ret + 1] = v
		end
	end

	table.sort(ret, function(a, b)
		return a.Id < b.Id
	end)

	return ret
end

function SoulData:GetCostItemCountToUpQualityLv()
	local ret = {}

	for i, v in ipairs(self:GetCfgSoulQuality().Cost) do
		if i % 2 == 0 then
			ret[#ret + 1] = v
		end
	end

	return ret
end

function SoulData:GetCostCountOnStageItem(itemCid)
	for i, v in ipairs(self:GetCfgSoulQuality().Cost) do
		if i % 2 ~= 0 and v == itemCid then
			return self:GetCfgSoulQuality().Cost[i + 1]
		end
	end

	return nil
end

function SoulData:GetMaxQualityLvCfgOnCurQuality(cfgData)
	local ret = cfgData
	local nextCfgData = CfgSoulQualityTable[cfgData.NextLevel]

	if nextCfgData ~= nil and nextCfgData.QualityLevel ~= 0 then
		ret = self:GetMaxQualityLvCfgOnCurQuality(nextCfgData)
	end

	return ret
end

function SoulData:GetMinQualityLvCfgOnCurQuality(cfgData)
	local ret = cfgData

	if ret.QualityLevel ~= 0 then
		local prevCfgData = CfgSoulQualityTable[cfgData.Id - 1]

		ret = self:GetMinQualityLvCfgOnCurQuality(prevCfgData)
	end

	return ret
end

function SoulData:GetMaxCfgSoulQualityData(cfgData)
	if cfgData.NextLevel ~= 0 then
		local nextCfgData = CfgSoulQualityTable[cfgData.NextLevel]

		if nextCfgData.NextLevel ~= 0 then
			return self:GetMaxCfgSoulQualityData(nextCfgData)
		else
			return nextCfgData
		end
	end

	return cfgData
end

function SoulData:GetCfgSoulFavor(favorLv)
	local lv = self.favorLv

	if favorLv then
		lv = favorLv
	end

	for i, v in pairsCfg(CfgSoulFavorTable) do
		if v.SoulID == self.soulCid and v.FavorDegree == lv then
			return v
		end
	end

	return nil
end

function SoulData:GetSoulFavor(lv)
	for i, v in pairsCfg(CfgSoulFavorTable) do
		if v.SoulID == self.soulCid and v.FavorDegree == lv then
			return v.FavorValue
		end
	end

	return 0
end

function SoulData:OnEvolveSuccess(soulPOD)
	self:OnUpdate(soulPOD)
end

function SoulData:OnUpdateMood(mood)
	self.mood = mood
end

function SoulData:OnUpdate(soulPOD)
	self.isUnlock = true
	self.soulQualityCid = soulPOD.qualityId
	self.favor = soulPOD.favor
	self.dailyDislike = soulPOD.dailyDislike
	self.exp = soulPOD.exp
	self.talentCids = soulPOD.talentCids
	self.talentGroupCids = soulPOD.talentGroupCids
	self.unlockSkillGroups = soulPOD.unlockSkillGroups
	self.activationSkillStrengthen = soulPOD.activationSkillStrengthen
	self.lv = soulPOD.lv
	self.favorLv = soulPOD.favorLv
	self.oathActivation = soulPOD.oathActivation
	self.favorMaxLv = soulPOD.favorMaxLv
	self.mood = soulPOD.mood
	self.moodTimeInterval = soulPOD.moodTimeInterval
	self.soulMemoryPieces = soulPOD.soulMemoryPieces
	self.atts = soulPOD.soulAttr
	self.workStatus = soulPOD.workStatus

	if soulPOD.dress2DCid ~= nil then
		self.dressCid2D = soulPOD.dress2DCid
	end

	if soulPOD.dress3DCid ~= nil then
		self.dressCid3D = soulPOD.dress3DCid
	end

	self.jewelry = soulPOD.jewelry

	self:RefreshSpDatum(soulPOD)
	L2DModule.Instance:SetMoodState(self.soulCid, SoulModule.GetMoodState(self.soulCid, self.mood))
	L2DModule.Instance:SetLoveUIStyle(self.soulCid, self.favorLv)
	L2DModule.Instance:SetDailyDislike(self.soulCid, self.dailyDislike)
end

function SoulData:OnWearDressSuccess(dressCid)
	local dressType = CfgDressTable[dressCid].Type

	if dressType == 1 then
		self.dressCid3D = dressCid
	elseif dressType == 2 then
		self.dressCid2D = dressCid
	end
end

function SoulData:OnGetNewDress(dressData)
	local dressType = dressData.cfgDressRow.Type

	self.dress2DDataList = DressModule.GetSoulDressDataList(self.soulCid, 2)
	self.dress3DDataList = DressModule.GetSoulDressDataList(self.soulCid, 1)

	self:SortDress(dressType)
end

function SoulData:OnDressTimeout(dressData)
	if self.dressCid3D == dressData.dressCid then
		self:RecoverOriginalDressData(dressData.cfgDressRow.Type)
	end

	if self.dressCid2D == dressData.dressCid then
		self:RecoverOriginalDressData(dressData.cfgDressRow.Type)
	end
end

function SoulData:GetJewelryIds()
	local tab = {}

	for i, v in pairs(self.jewelry) do
		table.insert(tab, i)
	end

	return tab
end

function SoulData:GetJewelryAndSpeed()
	if self.jewelry == nil then
		return 0, 0
	end

	for i, v in pairs(self.jewelry) do
		return i, v
	end

	return 0, 0
end
