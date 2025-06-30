-- chunkname: @IQIGame\\Module\\Warehouse\\SkillData.lua

SkillData = {
	isDiy = false,
	itemCid = 0,
	lv = 1,
	lock = false,
	AP = 0,
	extLv = 1,
	Cost = 0,
	virtual = false,
	id = 0,
	skillCid = 0,
	CD = 0,
	isCanBreach = false,
	purifyLv = 1
}

function SkillData.New()
	return Clone(SkillData)
end

function SkillData:UpdateData(itemSkillPOD)
	self.exp = itemSkillPOD.exp
	self.lv = itemSkillPOD.lv
	self.extLv = itemSkillPOD.extLv
	self.heroPos = itemSkillPOD.heroPos
	self.heroCid = itemSkillPOD.heroCid
	self.strengLv = itemSkillPOD.strengLv
	self.itemCid = itemSkillPOD.itemCid
	self.skillCid = itemSkillPOD.skillCid
	self.purifyLv = itemSkillPOD.purifyLv
	self.id = itemSkillPOD.id
	self.lock = itemSkillPOD.lock
	self.isDiy = self:GetIsDiy()
	self.Quality = self:GetCfg().Quality

	if self.virtual then
		return
	end

	self.skillCfgByLv = self:GetSkillCfgByLevel()
	self.isCanBreach = self:GetSkillCanBreach()

	self:GetAPCDCost()
	self:GetSkillCfgByStrengthLv()
	self:GetPersonalityCfg()
end

function SkillData:GetCfg()
	return CfgSkillTable[self.skillCid]
end

function SkillData:GetSkillStrengthCfg(stengthId)
	return CfgSkillStrengthenTable[stengthId]
end

function SkillData:GetUpgradeDescribe()
	if self.lv == 1 then
		return self.skillCfgByLv.SkillTips
	else
		return self:GetSkillStrengthCfg(self.skillCfgByLv.StrengthenId).Describe
	end
end

function SkillData:GetRankCfg()
	for k, v in pairsCfg(CfgSkillRankTable) do
		if self.skillCid == v.Skill and v.StrengLv == self.strengLv + 1 then
			return v
		end
	end

	return nil
end

function SkillData:GetIsDiy()
	return self:GetCfg().IsDiy
end

function SkillData:GetMaxRankLv()
	local tempCfg = {}

	for k, v in pairsCfg(CfgSkillRankTable) do
		if self.skillCid == v.Skill then
			table.insert(tempCfg, v)
		end
	end

	return table.len(tempCfg)
end

function SkillData:GetSkillCfgByLevel()
	self.skillCfgsByLv = {}

	if self.virtual then
		return nil
	end

	if self:GetIsDiy() then
		for k, v in pairsCfg(CfgSkillLevelDiyTable) do
			if v.Quality == self:GetCfg().Quality then
				self.skillCfgsByLv[v.SkillLv] = v
			end
		end
	else
		for k, v in pairsCfg(CfgSkillLevelTable) do
			if v.Skill == self.skillCid then
				self.skillCfgsByLv[v.SkillLv] = v
			end
		end
	end

	if getTableLength(self.skillCfgsByLv) == 0 then
		logError(string.format("CfgSkillLevelTable表中找不到 Skill=%d 的技能", self.skillCid))

		return nil
	end

	for i = 1, #self.skillCfgsByLv do
		if self.skillCfgsByLv[i].SkillLv == self.lv then
			return self.skillCfgsByLv[i]
		end
	end

	logError(string.format("CfgSkillLevelTable表中 Skill=%d 的技能中缺少 SkillLv=%d 的技能等级信息", self.skillCid, self.lv))

	return nil
end

function SkillData:GetSkillRefineInfo()
	for k, v in pairsCfg(CfgSkillRefineTable) do
		if v.Skill == self.skillCid and v.SkillRefineLv == self.purifyLv then
			return v
		end
	end

	logError(string.format("检查SkillRefine表中 %s技能%s精炼等级的配置是否存在", self.skillCid, self.purifyLv))

	return nil
end

function SkillData:GetSkillCfgByStrengthLv()
	self.skillCfgsByStrengLv = {}

	for k, v in pairsCfg(CfgSkillRankTable) do
		if v.Skill == self.skillCid then
			self.skillCfgsByStrengLv[v.StrengLv] = v
		end
	end
end

function SkillData:GetSkillType()
	for k, v in pairsCfg(CfgDictTable) do
		if v.GroupId == 6 and v.TypeId == self:GetCfg().SkillType then
			return RoleDevelopmentApi:GetItemIipsDesc(v.TipsId)
		end
	end
end

function SkillData:GetSkillMaxExp()
	local exp = 0
	local curLvCfgByBreach = {}

	for i = 1, #self.skillCfgsByLv do
		if self.skillCfgsByLv[i].NeedLv <= self.strengLv then
			table.insert(curLvCfgByBreach, self.skillCfgsByLv[i])
		end
	end

	for i = 1, #curLvCfgByBreach - 1 do
		exp = exp + curLvCfgByBreach[i].UpgradeNeedExp[1]
	end

	return exp
end

function SkillData:GetPreviewLv(exp)
	local cfgExp = 0

	for i = 1, #self.skillCfgsByLv do
		local upgradeExp = self.skillCfgsByLv[i].UpgradeNeedExp[1] == nil and 0 or self.skillCfgsByLv[i].UpgradeNeedExp[1]

		cfgExp = cfgExp + upgradeExp

		if exp < cfgExp then
			return i
		end
	end

	return self.skillCfgsByLv[#self.skillCfgsByLv].SkillLv
end

function SkillData:GetCurSkillExp()
	local exp = 0

	for i = 1, #self.skillCfgsByLv do
		if i < self.lv then
			exp = exp + self.skillCfgsByLv[i].UpgradeNeedExp[1]
		end
	end

	return exp
end

function SkillData:GetCurSkillExpByLv(lv)
	local exp = 0

	for i = 1, #self.skillCfgsByLv do
		if i < lv then
			exp = exp + self.skillCfgsByLv[i].UpgradeNeedExp[1]
		end
	end

	return exp
end

function SkillData:GetDiySkillMaxLvByBreach(strengthLv)
	local maxLv = 0

	for i = #self.skillCfgsByLv, 1, -1 do
		if self.skillCfgsByLv[i].NeedLv == strengthLv then
			maxLv = i

			return maxLv
		end
	end

	return maxLv
end

function SkillData:GetSkillMaxLevel()
	return self.skillCfgsByLv[#self.skillCfgsByLv].SkillLv
end

function SkillData:GetSkillMaxStrengthLv()
	return self.skillCfgsByStrengLv[#self.skillCfgsByStrengLv].StrengLv
end

function SkillData:IsMaxLv()
	return self.lv >= self:GetSkillMaxLevel()
end

function SkillData:IsMaxBreachLv()
	return self.strengLv >= self:GetSkillMaxStrengthLv()
end

function SkillData:GetSkillCanBreach()
	local type = self:GetCfg().SkillType

	if type == Constant.SkillType.TYPE_LORE then
		return true
	end

	return false
end

function SkillData:GetSkillCanBreachByCfg()
	return self.skillCfgsByStrengLv[#self.skillCfgsByStrengLv] ~= nil
end

function SkillData:GetAPCDCost()
	self.AP = CfgSkillDetailTable[self.skillCid].NeedAp
	self.CD = CfgSkillDetailTable[self.skillCid].CoolDown
	self.Cost = self:GetCfg().NeedCost

	local strengthIDs = self:GetStrengthID()

	if strengthIDs ~= nil then
		for i = 1, #strengthIDs do
			self:CalculatedAttributes(self:GetSkillStrengthCfg(strengthIDs[i]))
		end
	end
end

function SkillData:GetCostEnergy()
	return CfgSkillDetailTable[self.skillCid].HeroEnergyCost[1] == nil and 0 or CfgSkillDetailTable[self.skillCid].HeroEnergyCost[1]
end

function SkillData:GetPersonalitySkillData()
	local PersonlityList, index = WarlockModule.GetCurPersonalityIndex()

	if PersonlityList == nil then
		return
	end

	for i = 1, #PersonlityList do
		if i <= index and PersonlityList[i].config.SkillId == self.skillCid then
			self:CalculatedAttributes(self:GetSkillStrengthCfg(PersonlityList[i].config.StrengthenId))
		end
	end
end

function SkillData:GetStrengthID()
	if self.skillCfgByLv and self.skillCfgByLv.StrengthenId and #self.skillCfgByLv.StrengthenId > 0 then
		return self.skillCfgByLv.StrengthenId
	end

	return nil
end

function SkillData:CalculatedAttributes(strengthcfg)
	local a = 0

	a = a + 1

	local data

	for i = 1, #strengthcfg.SkillSlotEffect do
		data = strengthcfg.SkillSlotEffect[i]

		if data == Constant.SkillChangeType.TYPE_CHANGE_AP then
			for j = 1, #strengthcfg.SkillSlotEffectParam do
				for k = 2, #strengthcfg.SkillSlotEffectParam[j], 2 do
					self.AP = self.AP + tonumber(strengthcfg.SkillSlotEffectParam[j][k])
				end
			end

			self.AP = self.AP < 0 and 0 or self.AP
		elseif data == Constant.SkillChangeType.TYPE_CHANGE_COST then
			for j = 1, #strengthcfg.SkillSlotEffectParam do
				for k = 2, #strengthcfg.SkillSlotEffectParam[j], 2 do
					self.Cost = self.Cost + tonumber(strengthcfg.SkillSlotEffectParam[j][k])
				end
			end

			self.Cost = self.Cost < 0 and 0 or self.Cost
		elseif data == Constant.SkillChangeType.TYPE_CHANGE_SKILL_CD then
			for j = 1, #strengthcfg.SkillSlotEffectParam do
				for k = 2, #strengthcfg.SkillSlotEffectParam[j], 2 do
					self.CD = self.CD + tonumber(strengthcfg.SkillSlotEffectParam[j][k])
				end
			end

			self.CD = self.CD < 0 and 0 or self.CD
		end
	end
end

function SkillData:GetSkillRankMaterial()
	self.strengLv = self.strengLv + 1

	local breachMaterialsItem = self:GetRankCfg() == nil and {} or self:GetRankCfg().StrengCost

	self.strengLv = self.strengLv - 1

	return breachMaterialsItem
end

function SkillData:GetPersonalityCfg()
	self.skillCfgsByPersonality = {}

	for k, v in pairsCfg(CfgPersonalityTable) do
		if v.SkillId == self.skillCid then
			table.insert(self.skillCfgsByPersonality, v)
		end
	end

	table.sort(self.skillCfgsByPersonality, function(tab1, tab2)
		return tab1.Id < tab2.Id
	end)
end

function SkillData:GetStrengthTableAttr(skillLv)
	local strengthCfg = CfgSkillStrengthenTable[self.skillCfgsByLv[skillLv].StrengthenId]
	local index = -1

	for i = 1, #strengthCfg.SkillSlotEffect do
		if strengthCfg.SkillSlotEffect[i] == 100 then
			index = i

			break
		end
	end

	if index == 0 then
		return nil
	end

	return strengthCfg.SkillSlotEffectParam[index]
end

function SkillData:GetMainAttr(skillLv)
	skillLv = skillLv == nil and self.lv or skillLv

	local strengthCfg = CfgSkillStrengthenTable[self.skillCfgsByLv[skillLv].StrengthenId[1]]
	local skillSlotEffectParam

	for i = 1, #strengthCfg.SkillSlotEffect do
		if strengthCfg.SkillSlotEffect[i] == 100 then
			skillSlotEffectParam = strengthCfg.SkillSlotEffectParam[i]

			break
		end
	end

	return {
		attrType = tonumber(skillSlotEffectParam[1]),
		attrValue = tonumber(skillSlotEffectParam[2])
	}
end

function SkillData:GetSubAttr(skillLv)
	skillLv = skillLv == nil and self.lv or skillLv

	local subAttrTable = {}

	for i = 2, #self.skillCfgsByLv[skillLv].StrengthenId do
		local strengthCfg = CfgSkillStrengthenTable[self.skillCfgsByLv[skillLv].StrengthenId[i]]
		local skillSlotEffectParam

		for j = 1, #strengthCfg.SkillSlotEffect do
			if strengthCfg.SkillSlotEffect[j] == 100 then
				skillSlotEffectParam = strengthCfg.SkillSlotEffectParam[j]

				table.insert(subAttrTable, {
					attrType = tonumber(skillSlotEffectParam[1]),
					attrValue = tonumber(skillSlotEffectParam[2])
				})
			end
		end
	end

	return subAttrTable
end

function SkillData:GetSkillAttr(skillLv)
	skillLv = skillLv == nil and self.lv or skillLv

	local subAttrTable = {}

	for i = 1, #self.skillCfgsByLv[skillLv].StrengthenId do
		local strengthCfg = CfgSkillStrengthenTable[self.skillCfgsByLv[skillLv].StrengthenId[i]]
		local skillSlotEffectParam

		for j = 1, #strengthCfg.SkillSlotEffect do
			if strengthCfg.SkillSlotEffect[j] == 100 then
				skillSlotEffectParam = strengthCfg.SkillSlotEffectParam[j]

				table.insert(subAttrTable, {
					attrType = tonumber(skillSlotEffectParam[1]),
					attrValue = tonumber(skillSlotEffectParam[2])
				})
			end
		end
	end

	return subAttrTable
end

function SkillData:SortByLevel(target, ascending)
	return sortByValue(self.lv, target.lv, ascending)
end

function SkillData:SortByStrengthenLv(target, ascending)
	return sortByValue(self.strengLv, target.strengLv, ascending)
end

function SkillData:SortByPurifyLv(target, ascending)
	return sortByValue(self.purifyLv, target.purifyLv, ascending)
end

function SkillData:GetSearchTargetData()
	local skillDetailData = CfgSkillDetailTable[self.skillCid]
	local result = CfgSearchTargetTable[skillDetailData.TargetTypeID]

	if result == nil then
		logError("技能 {0}, SkillDetail表,TargetTypeID 配置错误,SearchTarget表中找不到对应ID:{1}", self.skillCid, skillDetailData.TargetTypeID)
	end

	return result
end
