-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterdepot/data/CharacterBaseData.lua

module("logic.extensions.characterdepot.data.CharacterBaseData", package.seeall)

local M = class("CharacterBaseData")

function M:ctor(params)
	self._id = params.id or 0
	self.id = self._id
	self._level = params.level
	self._powerLv = params.powerLv
	self._nodesInfo = params.nodesInfo
	self._extNodesInfo = params.extNodesInfo
	self._breakLv = params.breakLv
	self._ccDegree = params.ccDegree
	self._wakeup = params.wakeup
	self._pveWinTimes = params.pveWinTimes
	self._attrs = params.attrs
	self._skills = params.skills
	self._talentSkills = params.talentSkills
	self._treatyLv = params.treatyLv
	self._status = params.status
	self._heroCfgInfo = params.id and CharacterConfig.instance:getCfgInfoByID(params.id) or params.heroCfgInfo or false
	self._heroInfoCfg = params.id and PastInfoConfig.instance:getCharacterInfo(params.id) or params.heroInfoCfg or false
	self._modelCfgInfo = fasle
	self._lvExp = params.lvExp
	self._tacitExp = params.tacitExp
	self._qua6 = params.qua6
	self._expression = CharacterUnlockContentConfig.instance:getExpressionIdByInfoId(params.expression)
	self._propertyFields = {}
	self._skinId = params.skinId or false
	self._atkRange = self:_calculateAtkRange()

	self:updateAttrParts(params.attrParts)
	self:initAttributeMap()

	self._equipData = HeroEquipData.New(params)
	self._heroEchoItemData = HeroEchoItemData.New(params)
	self._thinkingItemData = ThinkingItemData.New()
end

function M:updateHeroData(params)
	self._level = params.level
	self._powerLv = params.powerLv
	self._nodesInfo = params.nodesInfo
	self._extNodesInfo = params.extNodesInfo
	self._breakLv = params.breakLv
	self._ccDegree = params.ccDegree
	self._wakeup = params.wakeup
	self._pveWinTimes = params.pveWinTimes
	self._attrs = params.attrs
	self._skills = params.skills
	self._talentSkills = params.talentSkills
	self._treatyLv = params.treatyLv
	self._status = params.status
	self._lvExp = params.lvExp
	self._tacitExp = params.tacitExp
	self._qua6 = params.qua6
	self._expression = CharacterUnlockContentConfig.instance:getExpressionIdByInfoId(params.expression)
	self._skinId = params.skinId or false
	self._atkRange = self:_calculateAtkRange()

	self:updateAttrParts(params.attrParts)
	self:initAttributeMap()
end

function M:_calculateAtkRange()
	for _, skill in ipairs(self._skills) do
		local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skill.key)

		if skillCOWrapper and skillCOWrapper:getSkillType() == BattleEnum.SkillCategory.NORMAL then
			return skillCOWrapper:getReleaseDistance()
		end
	end

	return 0
end

function M:powerLvId2Lv(powerLvId)
	local powerLv = CharacterExpConfig.instance:getPowerLvById(powerLvId)

	return powerLv
end

function M:updateAttrParts(attrParts)
	self._attrParts = {}

	for k, v in ipairs(attrParts) do
		self._attrParts[v.attr] = self._attrParts[v.attr] or 0
		self._attrParts[v.attr] = self._attrParts[v.attr] + v.value
	end
end

function M:getAttrPartsBase(attr)
	return self._attrParts[attr] or 0
end

function M:getId()
	return self._id
end

function M:getLevel()
	return self._level
end

function M:getPowerLv()
	return self._powerLv
end

function M:getNodesInfo()
	return self._nodesInfo
end

function M:getExtNodesInfo()
	return self._extNodesInfo
end

function M:getIsMaxPowerLv()
	return self:getPowerLv() >= HeroPowerConfig.instance:getMaxPowerLevel(self:getId())
end

function M:getBreakLv()
	return self._breakLv
end

function M:getccDegree()
	return self._ccDegree
end

function M:getAwakeTalent()
	return self._wakeup
end

function M:isAwakeTalentSkill()
	local wakeup = self:getAwakeTalent()

	return wakeup and CommEnum.TalentSkillAwakeStatus.Unlock or CommEnum.TalentSkillAwakeStatus.Locked
end

function M:talentSkillId()
	return self._heroCfgInfo.battleTalent[self:isAwakeTalentSkill()]
end

function M:talentBaseSkillId()
	return self._heroCfgInfo.battleTalent[CommEnum.TalentSkillAwakeStatus.None]
end

function M:getAttrs()
	return self._attrs
end

function M:initAttributeMap()
	for _, propertyNO in ipairs(self._attrs) do
		self._propertyFields[propertyNO.attr] = propertyNO.value
	end
end

function M:getAttribute(propertyEnum)
	return self._propertyFields[propertyEnum] or 0
end

function M:getSkills()
	return self._skills
end

function M:getTalentSkills()
	return self._talentSkills
end

function M:geTreatyLv()
	return self._treatyLv
end

function M:getStatus()
	return self._status
end

function M:getLevelExp()
	return self._lvExp
end

function M:getIsMaxLevel()
	local maxLv = CharacterExpConfig.instance:getPowerLvAndQualityToLvLimit(self:getPowerLv(), self:getQuality())
	local curLv = self:getLevel()

	return maxLv <= curLv
end

function M:getRemainedExpAndCostToTargetLv(targetLv)
	local maxLv = CharacterExpConfig.instance:getPowerLvAndQualityToLvLimit(self:getPowerLv(), self:getQuality())
	local curLv = self:getLevel()

	targetLv = maxLv <= targetLv and maxLv or targetLv

	local expRemained = 0
	local expCost = 0
	local isLvMax = maxLv <= curLv

	if not isLvMax and curLv ~= targetLv then
		local expAddProfile, goldConsumeProfile = AchievementModel.instance:getHeroUpgradeAchievementSkillFactor()
		local qualityStr = CharacterExpConfig.instance:qualityToQualityStr(self:getQuality())
		local upgradeConfig = CharacterExpConfig.instance:getUpgradeCO()

		if upgradeConfig and upgradeConfig[curLv] and upgradeConfig[curLv][qualityStr] then
			-- block empty
		else
			printError(string.format("t_%s中没有lv[%s] quality[%s]的配置", ConfigName.CharacterUpgrade, curLv, qualityStr))
		end

		for i = curLv, targetLv - 1 do
			local _co = upgradeConfig[i]
			local expNeed = _co[qualityStr]

			if i == curLv then
				expNeed = expNeed - self:getLevelExp()
			end

			local _cost = expNeed * (_co.goldPerExp * (1 - goldConsumeProfile))

			expRemained = expRemained + expNeed
			expCost = expCost + _cost
		end
	end

	return expRemained, expCost
end

function M:getTacit()
	local level = TacitConfig.instance:getCurLevelByExp(self._tacitExp)

	return level
end

function M:getTacitExp()
	return self._tacitExp
end

function M:getIsTacitMaxExp()
	return self:getTacitExp() >= TacitConfig.instance:getMaxExp()
end

function M:getCharacterCo()
	return self._heroCfgInfo
end

function M:getModelCo()
	if self._skinId then
		local skinCo = HeroSkinConfig.instance:getInfo(self._skinId)

		if skinCo then
			self._modelCfgInfo = ModelConfig.instance:getModelConfig(skinCo.module)
		end
	end

	if not self._modelCfgInfo then
		self._modelCfgInfo = ModelConfig.instance:getModelConfig(self._heroCfgInfo.modelId)
	end

	return self._modelCfgInfo
end

function M:getCharacterInfoCo()
	return self._heroInfoCfg
end

function M:getName()
	return self._heroInfoCfg.name or ""
end

function M:getOrganizationCO()
	if self._heroInfoCfg then
		return PastInfoConfig.instance:getOrgInfo(self._heroInfoCfg.organization)
	end

	return nil
end

function M:getGainHeroTime()
	local lst = ItemModel.instance:getItemsByItemId(self:getId())

	if #lst > 0 then
		return lst[1]:getAddTime()
	end

	return 0
end

function M:getHeroIsNewItem()
	return CharacterUtil.isHeroNewItem(self:getId(), true)
end

function M:removeNewItemMark()
	if not self:getHeroIsNewItem() then
		return
	end

	local lst = ItemModel.instance:getItemsByItemId(self:getId())
	local uuid

	if #lst > 0 then
		uuid = lst[1]:getUuid()
	end

	if uuid then
		BackpackAgent.instance:sendremoveRedPointRequest(GameEnum.ItemTypeEnum.HeroType, {
			uuid
		})
	end
end

function M:getHeroCanBreakLvUp()
	return CharacterUtil.isHeroCanBrealLvUp(self:getId(), true)
end

function M:getHeroHasTacitTaskCanReceive()
	return CharacterUtil.isHeroHasTacitTaskCanReceive(self:getId(), true)
end

function M:getHeroCanSublimed()
	return CharacterUtil.isHeroCanSublimed(self:getId())
end

function M:getModelId()
	if self._skinId then
		local skinCo = HeroSkinConfig.instance:getInfo(self._skinId)

		if skinCo then
			return skinCo.module
		end
	end

	return self._heroCfgInfo.modelId or 0
end

function M:getQuality()
	return self._heroCfgInfo.quality or 2
end

function M:getCareer()
	return self._heroCfgInfo.career or 1
end

function M:getColorType()
	return self._heroCfgInfo.colorType or 1
end

function M:getCamp()
	return self._heroCfgInfo.camp or 1
end

function M:getDest()
	return self._heroCfgInfo.characterDescription or ""
end

function M:getMove()
	return self._heroCfgInfo.move or 1
end

function M:getAtkRange()
	return self._atkRange
end

function M:getNormalSkillAtkRange(includeEnhance)
	local characterCo = self:getCharacterCo()
	local normalSkills = characterCo.normalSkills
	local skillId
	local atkRange = 0

	for _, _skillId in ipairs(normalSkills or {}) do
		local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(_skillId)

		if not skillId and skillCOWrapper:getSkillType() == BattleEnum.SkillCategory.NORMAL then
			skillId = _skillId
			atkRange = skillCOWrapper:getReleaseDistance()
		end
	end

	if includeEnhance and skillId then
		local skillEnhanceMO = SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(self:getId(), skillId)

		atkRange = skillEnhanceMO:getReleaseDistance(BattleEnum.SkillStatus.Normal)
	end

	return atkRange
end

function M:getInitialSan()
	return self._heroCfgInfo.initialSan or 1
end

function M:getBattleTalent()
	return self._heroCfgInfo.battleTalent
end

function M:getRecommendThinking()
	return {}
end

function M:getAvailableThinkingIds()
	return self._heroCfgInfo.thinkings or {}
end

function M:getThinkingUnlockCost()
	local thinkingItemData = self:getThinkingItemData()
	local unlockCount = thinkingItemData:getUnlockCount()
	local cfgCost = ThinkingConfig.instance:getThinkingUnlockCfg(unlockCount)
	local costLzb = 0
	local cost = cfgCost and cfgCost.cost or {}
	local costItem = {}

	for _, val in ipairs(cost) do
		if val.id == CommEnum.CurrencyCodeEnum.LzbCode then
			costLzb = val.num
		else
			table.insert(costItem, ItemUtil.createItemData({
				itemId = val.id,
				count = val.num
			}))
		end
	end

	return costLzb, costItem
end

function M:getDefaultHouseSkillIds()
	return self._heroCfgInfo.houseSkill or {}
end

function M:getRoguelikeSkillIds()
	return {}
end

function M:getSixDim()
	return self._qua6
end

function M:getExpression()
	return self._expression
end

function M:getSkinId()
	return self._skinId
end

function M:getHeroEquipData()
	return self._equipData
end

function M:getHeroEchoItemData()
	return self._heroEchoItemData
end

function M:getThinkingItemData()
	return self._thinkingItemData
end

function M:getPveWinTimes()
	return self._pveWinTimes or 0
end

function M:getActiveNormalSkill()
	local skills = {}
	local normalSkills = self._heroCfgInfo.normalSkills

	for _, skillInfo in ipairs(self._skills) do
		if table.indexof(normalSkills, skillInfo.key) then
			table.insert(skills, skillInfo)
		end
	end

	return skills
end

function M:getTags(onlyMain)
	return CharacterConfig.instance:getCharacterTags(self:getId(), onlyMain)
end

return M
