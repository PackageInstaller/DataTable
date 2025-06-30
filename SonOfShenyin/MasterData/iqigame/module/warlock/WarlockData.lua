-- chunkname: @IQIGame\\Module\\Warlock\\WarlockData.lua

WarlockData = {
	exp = 0,
	curSkin = 0,
	MonsterId = 0,
	starLevel = 0,
	lifeCount = 0,
	isTempHeroData = false,
	starTime = 0,
	favorLv = 0,
	AttackValue = 0,
	elementMaster = 0,
	breakLv = 0,
	lv = 0,
	skinGroup = {},
	skins = {},
	voices = {},
	deeds = {},
	AttributeGroups = {},
	SkillGroups = {},
	SkillList = {},
	AttributeDir = {},
	EquipDataArr = {},
	PersonalityDataList = {},
	BaseAttrDic = {},
	breakPrize = {}
}

function WarlockData.New()
	local o = Clone(WarlockData)

	return o
end

function WarlockData:Initialize(HeroData, IsTemporaryCreate)
	if HeroData.hero then
		HeroData = HeroData.hero
	end

	self.BaseData = CfgHeroTable[HeroData.cid]
	self.BaseData.isHeroTable = true

	if self.id == nil then
		self.id = WarlockModule.GetRandomWarlockId()
	end

	self.favorabilityLevel = HeroData.favorabilityLevel
	self.favorabilityExp = HeroData.favorabilityExp
	self.cid = HeroData.cid
	self.warlockCid = HeroData.cid
	self.breakLv = HeroData.breakLv
	self.exp = HeroData.exp
	self.lv = HeroData.lv
	self.AttributeGroups = HeroData.attr
	self.BaseAttributeGroups = HeroData.baseAttr
	self.SkillGroups = HeroData.skill
	self.curSkin = HeroData.curSkin
	self.skins = HeroData.skins
	self.voices = HeroData.voices
	self.deeds = HeroData.deeds
	self.starLevel = HeroData.starLevel
	self.starTime = HeroData.starTime
	self.favorableDups = HeroData.favorableDups
	self.heroSkin = HeroData.heroSkin
	self.TheType = CombatFormationModel.WarkLockType.Hero
	self.lifeCount = HeroData.attr[Constant.Attribute.TYPE_HP]
	self.elementMaster = HeroData.attr[Constant.Attribute.TYPE_ELEMENT]

	local index = 1

	for attrID, attrVal in pairs(self.AttributeGroups) do
		local config = CfgAttributeTable[attrID]

		if config == nil then
			logError("有错误的配置，请检查配置表 Attribute的 id     " .. attrID)
		end

		index = attrID

		if self.AttributeDir[index] == nil then
			self.AttributeDir[index] = {}
		end

		self.AttributeDir[index].attType = attrID

		local attValue
		local baseAttr = self:GetBaseAttr(attrID)
		local attBaseValue, extraValue

		if config.IsPer == false then
			attValue = math.floor(attrVal)
			attBaseValue = math.floor(baseAttr)
			extraValue = attValue - attBaseValue
		else
			attValue = string.format("%.3f", attrVal)
			attValue = attValue * 100 .. "%"
			attBaseValue = string.format("%.3f", baseAttr)
			attBaseValue = attBaseValue * 100 .. "%"
			extraValue = attrVal - baseAttr
			extraValue = string.format("%.3f", extraValue)
			extraValue = extraValue * 100 .. "%"
		end

		self.AttributeDir[index].attBaseValue = attBaseValue
		self.AttributeDir[index].extraValue = extraValue
		self.AttributeDir[index].attValue = attValue
		self.AttributeDir[index].No_attBaseValue = baseAttr
		self.AttributeDir[index].No_attValue = attrVal
		self.AttributeDir[index].No_extraValue = attrVal - baseAttr
		index = index + 1
	end

	if IsTemporaryCreate then
		return
	end

	for k, v in pairs(self.EquipDataArr) do
		self.EquipDataArr[k] = nil
	end

	for k, v in pairs(HeroData.equip) do
		self.EquipDataArr[k] = EquipModule.equipDataDic[v.id]
	end

	self.personality = HeroData.personality

	self:GetPersonalityConfig()

	if CfgMonsterTable[self.BaseData.MonsterId] == nil then
		local name = "Monster"

		if self.BaseData.isHeroTable then
			name = "Hero"
		end

		logError("请检查表 ： " .. name .. "   的 字段MonsterId : " .. self.BaseData.MonsterId .. " 在 Monster表中索引为空 ")
	end

	self.EntityID = self:GetCurSpineElementEntityID()
	self.breakPrize = HeroData.breakPrize

	if HeroData.favor then
		self.favor = HeroData.favor.favorMsgGroups
	end

	self.maxFavorLv = -1

	for _, v in pairsCfg(CfgFavorLvTable) do
		if v.HeroID == self.cid then
			self.maxFavorLv = self.maxFavorLv + 1
		end
	end
end

function WarlockData:GetBaseAttr(type)
	return self.BaseAttributeGroups[type] or 0
end

function WarlockData:GetBaseAttrValueDic()
	local AttribuateArr = UIUtil.GetConfigArrToNumber(self.BaseData.Attribute, 3)

	for i = 1, #AttribuateArr do
		local ItemArr = AttribuateArr[i]
		local v = ItemArr[1]

		if self.BaseAttrDic[v] == nil then
			self.BaseAttrDic[v] = {}
		end

		self.BaseAttrDic[v].AttrValue = ItemArr[2]
		self.BaseAttrDic[v].AttrGrowth = ItemArr[3]

		if self.BaseAttrDic[v].BreakAttrValue == nil then
			self.BaseAttrDic[v].BreakAttrValue = 0
		end
	end

	if self.breakLv and self.breakLv > 0 then
		local breakconfig = self:GetCurHeroBreachCfg(self.breakLv)

		for i, v in pairs(breakconfig.AttrType) do
			if self.BaseAttrDic[v] == nil then
				self.BaseAttrDic[v] = {}
			end

			self.BaseAttrDic[v].BreakAttrValue = breakconfig.AttrValue[i]

			if self.BaseAttrDic[v].AttrValue == nil then
				self.BaseAttrDic[v].AttrValue = 0
			end

			if self.BaseAttrDic[v].AttrGrowth == nil then
				self.BaseAttrDic[v].AttrGrowth = 0
			end
		end
	end
end

function WarlockData:CreateTemporaryData(HeroData, isHelpHeroData, id)
	for key, value in pairs(HeroData) do
		self[key] = value
	end

	if isHelpHeroData then
		if self.id == nil then
			self.id = WarlockModule.GetRandomWarlockId()
		end

		self.BaseData = CfgHeroTable[HeroData.hero.cid]
		self.BaseData.isHeroTable = true
		self.TheType = CombatFormationModel.WarkLockType.HelpHero
		self.lv = HeroData.hero.lv
		self.curSkinPODs = self:ReloadSkinPODs(HeroData.hero.skin)
		self.personality = HeroData.hero.personality
		self.cid = HeroData.hero.cid

		self:GetPersonalityConfig()

		self.heroSkin = HeroData.hero.heroSkin
	else
		self.TheType = CombatFormationModel.WarkLockType.NPC
		self.id = WarlockModule.GetRandomWarlockId()
		self.BaseData = CfgMonsterTable[HeroData.cid]
		self.BaseData.isMonsterTable = true
		self.heroSkin = {}
		self.heroSkin.skinCid = self.BaseData.EntityID
	end

	self.isHelpHeroData = isHelpHeroData
end

function WarlockData:GetCurHeroBreachCfg(breaklv)
	for k, v in pairsCfg(CfgHeroBreakTable) do
		if v.HeroId == self.cid and v.BreakLv == breaklv then
			return v
		end
	end

	return nil
end

function WarlockData:GetFavorIsMax()
	return self.favorabilityLevel == #RoleExtendModule.MaxTable
end

function WarlockData:QueryHeroBreachCfg(breaklv)
	if breaklv == nil then
		breaklv = self.breakLv
	end

	if breaklv >= CfgHeroTable[self.cid].MaxBreakLv then
		breaklv = CfgHeroTable[self.cid].MaxBreakLv
	end

	for k, v in pairsCfg(CfgHeroBreakTable) do
		if v.HeroId == self.cid and v.BreakLv == breaklv then
			return v
		end
	end

	logError(string.format("英雄%s突破等级%s的配置表未找到 请检查HeroBreak表", self.cid, breaklv))

	return nil
end

function WarlockData:GetCurMaxLv()
	if self:IsMaxBreachLv() then
		return self.BaseData.MaxLv
	else
		return self:QueryHeroBreachCfg(self.breakLv).MaxHeroLv
	end
end

function WarlockData:GetMaxLvByPlayerLv()
	local heroLvData = {}

	for k, v in pairsCfg(CfgHeroLvTable) do
		heroLvData[v.HeroLv] = v
	end

	for i = #heroLvData, 1, -1 do
		if heroLvData[i].NeedPlayerLv == PlayerModule.PlayerInfo.baseInfo.pLv then
			return heroLvData[i].HeroLv
		end
	end

	return self:GetCurMaxLv()
end

function WarlockData:GetCfgHeroLvDataByLv()
	for k, v in pairsCfg(CfgHeroLvTable) do
		if v.HeroLv == self.lv then
			return v
		end
	end

	return nil
end

function WarlockData:IsCanBreach()
	local breaklvList = {}

	for k, v in pairsCfg(CfgHeroBreakTable) do
		if v.HeroId == self.cid then
			table.insert(breaklvList, v.MaxHeroLv)
		end
	end

	table.sort(breaklvList, function(a, b)
		return a < b
	end)

	for k, v in pairs(breaklvList) do
		if v >= self.lv then
			return self.lv == v and self.breakLv ~= k
		end
	end

	return false
end

function WarlockData:IsMaxBreachLv()
	return self.breakLv >= CfgHeroTable[self.cid].MaxBreakLv
end

function WarlockData:IsMaxSelfPersonalityLv()
	local TableLength = 5
	local PersonalityLength = table.len(self.personality)

	return TableLength == PersonalityLength
end

function WarlockData:GetPersonalityConfig()
	local Configlist = {}

	if #self.PersonalityDataList == 0 then
		local index = 0

		for k, v in pairsCfg(CfgPersonalityTable) do
			for i = 1, #self.BaseData.PersonalityId do
				if self.BaseData.PersonalityId[i] == v.Id then
					index = index + 1

					table.insert(Configlist, v)

					break
				end
			end

			if index == 5 then
				break
			end
		end

		table.sort(Configlist, function(a, b)
			return a.Id < b.Id
		end)
	end

	for i = 1, #Configlist do
		self.PersonalityDataList[i] = {
			config = Configlist[i]
		}
	end

	for i = 1, #self.PersonalityDataList do
		local Data = self.PersonalityDataList[i]
		local _isOpen, _id = self:GetPersonalityIsLock(Data.config.Id)

		self.PersonalityDataList[i].id = _id
		self.PersonalityDataList[i].index = i
		self.PersonalityDataList[i].isOpen = _isOpen

		if i == 1 then
			self.PersonalityDataList[i].isLock = false
		else
			self.PersonalityDataList[i].isLock = not self.PersonalityDataList[i - 1].isOpen
		end
	end
end

function WarlockData:GetPersonalityIsLock(id)
	for i = 1, #self.personality do
		if self.personality[i] == id then
			return true, id
		end
	end

	return false, id
end

function WarlockData:PersonalityIsLock(personalityID)
	local result = false

	ForArray(self.personality, function(_index, _id)
		result = _id == personalityID

		if result then
			return true
		end
	end)

	return result
end

function WarlockData:GetAllUnLockData()
	local data = {}

	for i = 1, #self.PersonalityDataList do
		if self.PersonalityDataList[i].isOpen then
			table.insert(data, self.PersonalityDataList[i])
		end
	end

	return data
end

function WarlockData:UnlockPersonalityLv()
	local Lv = 0

	for k, v in pairs(self.PersonalityDataList) do
		if v.isOpen then
			Lv = Lv + 1
		end
	end

	return Lv
end

function WarlockData:GetPersonalityDataList()
	return self.PersonalityDataList
end

function WarlockData:GetStarLevel()
	return self.starLevel or 0
end

function WarlockData:GetStarTime()
	return self.starTime or 0
end

function WarlockData:GetCfg()
	return CfgHeroTable[self.cid]
end

function WarlockData:GetFavorDupIsFinished(id)
	if not self.favorableDups[id] then
		return false
	end

	return true
end

function WarlockData:HeroIsDead()
	return self.AttributeGroups[1] <= 0
end

function WarlockData:GetBreakRewardIsReceived(breakLv)
	local isReceived = false

	if table.indexOf(self.breakPrize, breakLv) ~= -1 then
		isReceived = true
	end

	return isReceived
end

function WarlockData:GetCurrentSkinCid()
	return self.heroSkin.skinCid
end

function WarlockData:GetDefaultSkinCfg()
	return SkinModule.GetHeroDefaultSkinCfg(self.cid)
end

function WarlockData:GetDefaultSkinImgPath(skinImageType)
	local skinCfgData = SkinModule.GetHeroDefaultSkinCfg(self.cid)

	return SkinModule.GetHeroSkinImgPathByType(skinCfgData, skinImageType)
end

function WarlockData:GetCurrentSkinConfig()
	return SkinModule.GetHeroCurrentSkinConfig(self.cid)
end

function WarlockData:GetCurrentSkinImgPath(skinImageType)
	local skinCfgData = SkinModule.GetHeroCurrentSkinConfig(self.cid)

	return SkinModule.GetHeroSkinImgPathByType(skinCfgData, skinImageType)
end

function WarlockData:GetCurStaticSkinImagePath(skinImageType)
	local skinDataConfig = CfgHeroSkinTable[self.heroSkin.skinCid]

	return SkinModule.GetHeroSkinImgPathByType(skinDataConfig, skinImageType)
end

function WarlockData:GetCurSpineElementEntityID()
	local skinCfg = CfgHeroSkinTable[self.heroSkin.skinCid]

	return skinCfg.BattleEntityID
end

function WarlockData:GetCurSkinPODs()
	return self.curSkinPODs
end

function WarlockData:ReloadSkinPODs(serverSkinPODs)
	if serverSkinPODs ~= nil then
		local skinPODs = {}

		for skinType, serverSkinPOD in pairs(serverSkinPODs) do
			if skinType == Constant.SkinType.StaticImage or skinType == Constant.SkinType.SpineElementEntity then
				skinPODs[skinType] = SkinModule.GenerateSkinPOD(serverSkinPOD.heroCid, serverSkinPOD.id, serverSkinPOD.itemCid, serverSkinPOD.skinCid)
			end
		end

		return skinPODs
	end

	return nil
end

function WarlockData:CompareWithLevel(target, ascending)
	return sortByValue(self.lv, target.lv, ascending)
end

function WarlockData:CompareWithQuality(target, ascending)
	return sortByValue(self.BaseData.Quality, target.BaseData.Quality, ascending)
end

function WarlockData:CompareWithCid(target, ascending)
	return sortByValue(self.cid, target.cid, ascending)
end

function WarlockData:CompWithFavorLv(target, ascending)
	return sortByValue(self.favorabilityLevel, target.favorabilityLevel, ascending)
end

function WarlockData:CompWithElement(target, ascending)
	return sortByValue(self.BaseData.Elements, target.BaseData.Elements, ascending)
end

function WarlockData:RefreshFavorData(groupId, entryId)
	if not self.favor then
		self.favor = {}
	end

	if not self.favor[groupId] then
		self.favor[groupId] = {}
	end

	self.favor[groupId].cid = groupId

	if not self.favor[groupId].entrys then
		self.favor[groupId].entrys = {}
	end

	table.insert(self.favor[groupId].entrys, entryId)
end

function WarlockData:GetSortFavorArray()
	local favorArray = {}

	for _, v in pairs(self.favor) do
		table.insert(favorArray, v)
	end

	table.sort(favorArray, function(a, b)
		local cfgGroupA = CfgUtil.GetCfgFavorMessageGroupDataWithID(a)
		local cfgGroupB = CfgUtil.GetCfgFavorMessageGroupDataWithID(b)

		return cfgGroupA.Id < cfgGroupB.Id
	end)

	return favorArray
end

function WarlockData:GetMaxFavorLv()
	return self.maxFavorLv
end

function WarlockData:ValidateFavorLvIsMax()
	return self.favorabilityLevel >= self.maxFavorLv
end
