-- chunkname: @modules/logic/fight/model/mo/FightEntityMO.lua

module("modules.logic.fight.model.mo.FightEntityMO", package.seeall)

local FightEntityMO = pureTable("FightEntityMO")
local srcIndex = FightEntityMO.__index
local srcNewIndex = FightEntityMO.__newindex
local attrProxyDict = {
	position = true
}

function FightEntityMO.__index(t, key)
	if attrProxyDict[key] then
		local funcName = "get_" .. tostring(key)
		local handle = FightEntityMO[funcName]

		if handle then
			return handle(t, key)
		end
	end

	return srcIndex[key]
end

function FightEntityMO.__newindex(t, key, value)
	if attrProxyDict[key] then
		local funcName = "set_" .. tostring(key)
		local handle = FightEntityMO[funcName]

		if handle then
			return handle(t, key, value)
		end
	end

	srcNewIndex(t, key, value)
end

function FightEntityMO:ctor()
	self.buffDic = {}
	self.playCardExPoint = 0
	self.moveCardExPoint = 0
	self.skillList = {}
	self.skillId2Lv = {}
	self.skillNextLvId = {}
	self.skillPrevLvId = {}
	self.skillGroup1 = {}
	self.skillGroup2 = {}
end

function FightEntityMO:init(info, side)
	self._playCardAddExpoint = 1
	self._moveCardAddExpoint = 1
	self._combineCardAddExpoint = 1
	self.expointMaxAdd = info.expointMaxAdd
	self.exSkillPointChange = info.exSkillPointChange or 0
	self.id = info.uid
	self.uid = info.uid
	self.modelId = info.modelId
	self.skin = self:initSkin(info)
	self.originSkin = self.skin
	self.position = info.position
	self.entityType = info.entityType
	self.userId = info.userId

	self:setExPoint(info.exPoint)

	self.level = info.level
	self.currentHp = info.currentHp
	self.attrMO = self:_buildAttr(info.attr)

	self:_buildBuffs(info.buffs)
	self:_buildSkills(info)

	self.shieldValue = info.shieldValue
	self.equipUid = info.equipUid
	self.trialId = info.trialId

	if info.trialEquip then
		self.trialEquip = {}
		self.trialEquip.equipUid = info.trialEquip.equipUid
		self.trialEquip.equipId = info.trialEquip.equipId
		self.trialEquip.equipLv = info.trialEquip.equipLv
		self.trialEquip.refineLv = info.trialEquip.refineLv
	else
		self.trialEquip = nil
	end

	self.exSkillLevel = info.exSkillLevel

	local version = FightModel.instance:getVersion()

	if version >= 1 then
		if info.teamType == FightEnum.TeamType.MySide then
			self.side = FightEnum.EntitySide.MySide or FightEnum.EntitySide.EnemySide
		end
	else
		self.side = side
	end

	self._powerInfos = {}

	self:setPowerInfos(info.powerInfos)

	self.act104EquipUids = {}

	for i, v in ipairs(info.act104EquipUids) do
		table.insert(self.act104EquipUids, v)
	end

	self:buildSummonedInfo(info.SummonedList)

	self.teamType = info.teamType

	self:buildEnhanceInfoBox(info.enhanceInfoBox)

	self.career = info.career

	self:updateStoredExPoint()
	self:updateStoredDeviceExPoint()

	self.status = info.status
	self.guard = info.guard
	self.subCd = info.subCd
	self.exPointType = info.exPointType
	self.equipRecord = info.equipRecord
	self.destinyStone = info.destinyStone
	self.destinyRank = info.destinyRank
	self.customUnitId = info.customUnitId
	self.weakCareers = {}

	for i, v in ipairs(info.weakCareers) do
		table.insert(self.weakCareers, v)
	end

	self.toughnessValue = info.toughnessValue
	self.toughnessPoint = info.toughnessPoint
	self.isBroken = info.isBroken
	self.exPointMax = info.exPointMax
end

function FightEntityMO:onStageChanged(curStage, preStage)
	self:updateStoredDeviceExPoint()
	self:updateStoredExPoint()
end

function FightEntityMO:_buildAttr(attr)
	if not self.attrMO then
		local heroAttribute = HeroAttributeMO.New()

		self.attrMO:init(attr)

		return self.attrMO
	end
end

function FightEntityMO:_buildBuffs(buffs)
	for i, buffInfo in ipairs(buffs) do
		local buffMO = FightBuffInfoData.New(buffInfo, self.id)

		self.buffDic[buffMO.uid] = buffMO
	end

	self:_dealBuffFeature()
end

function FightEntityMO:_buildSkills(entityInfo)
	self.skillList = {}
	self.skillId2Lv = {}
	self.skillNextLvId = {}
	self.skillPrevLvId = {}
	self.passiveSkillDic = {}
	self.skillGroup1 = {}
	self.skillGroup2 = {}
	self.skillId2Index = {}

	for i, skillId in ipairs(entityInfo.skillGroup1) do
		table.insert(self.skillList, skillId)
		table.insert(self.skillGroup1, skillId)

		self.skillId2Lv[skillId] = i
		self.skillNextLvId[skillId] = entityInfo.skillGroup1[i + 1]
		self.skillPrevLvId[skillId] = entityInfo.skillGroup1[i - 1]
		self.skillId2Index[skillId] = 1
	end

	for i, skillId in ipairs(entityInfo.skillGroup2) do
		table.insert(self.skillList, skillId)
		table.insert(self.skillGroup2, skillId)

		self.skillId2Lv[skillId] = i
		self.skillNextLvId[skillId] = entityInfo.skillGroup2[i + 1]
		self.skillPrevLvId[skillId] = entityInfo.skillGroup2[i - 1]
		self.skillId2Index[skillId] = 2
	end

	for _, skillId in ipairs(entityInfo.passiveSkill) do
		table.insert(self.skillList, skillId)

		self.passiveSkillDic[skillId] = true
	end

	table.insert(self.skillList, entityInfo.exSkill)

	self.skillId2Lv[entityInfo.exSkill] = 4
	self.exSkill = entityInfo.exSkill

	self:updateCanPreCalculateCardLv()
end

function FightEntityMO:addPassiveSkill(skillId)
	if self.passiveSkillDic then
		self.passiveSkillDic[skillId] = true
	end

	if self.skillList and not tabletool.indexOf(self.skillList, skillId) then
		table.insert(self.skillList, skillId)
	end

	self:updateCanPreCalculateCardLv()
end

function FightEntityMO:removePassiveSkill(skillId)
	if self.passiveSkillDic then
		self.passiveSkillDic[skillId] = nil
	end

	if self.skillList then
		tabletool.removeValue(self.skillList, skillId)
	end

	self:updateCanPreCalculateCardLv()
end

function FightEntityMO:isPassiveSkill(skillId)
	return self.passiveSkillDic and self.passiveSkillDic[skillId]
end

function FightEntityMO:updateCanPreCalculateCardLv()
	self.cardCanUpEffectTagList = self.cardCanUpEffectTagList or {
		{},
		{}
	}

	tabletool.clear(self.cardCanUpEffectTagList[1])
	tabletool.clear(self.cardCanUpEffectTagList[2])

	if not self.passiveSkillDic then
		return
	end

	local targetBehaviourId = FightEnum.BehaviourId.AddCardRankByEffectTag

	for skillId, _ in pairs(self.passiveSkillDic) do
		local skillCo = lua_skill.configDict[skillId]

		if skillCo then
			for i = 1, FightEnum.MaxBehavior do
				local behavior = skillCo["behavior" .. i]

				if not string.nilorempty(behavior) then
					local behaviourArray = FightStrUtil.instance:getSplitCache(behavior, "#")
					local behaviourId = behaviourArray and tonumber(behaviourArray[1])

					if behaviourId == targetBehaviourId then
						local canUpEffectTagList = FightStrUtil.instance:getSplitToNumberCache(behaviourArray[2], ",")
						local cardIndex = tonumber(behaviourArray[3])

						tabletool.addValues(self.cardCanUpEffectTagList[cardIndex], canUpEffectTagList)
					end
				end
			end
		end
	end
end

function FightEntityMO:getCanUpEffectTagList(cardIndex)
	if self.cardCanUpEffectTagList then
		return self.cardCanUpEffectTagList[cardIndex]
	end
end

function FightEntityMO:getSkillIdIndex(skillId)
	if self.skillId2Index then
		return self.skillId2Index[skillId]
	end
end

function FightEntityMO:hasSkill(skillId)
	local skillLv = self.skillId2Lv[skillId]

	return skillLv ~= nil
end

function FightEntityMO:getSkillLv(skillId)
	local skillLv = self.skillId2Lv[skillId]

	return skillLv or FightConfig.instance:getSkillLv(skillId)
end

function FightEntityMO:getSkillNextLvId(skillId)
	local nextSkillId = self.skillNextLvId[skillId]

	nextSkillId = nextSkillId or FightHelper.processNextSkillId(skillId)

	return nextSkillId or FightConfig.instance:getSkillNextLvId(skillId)
end

function FightEntityMO:getSkillPrevLvId(skillId)
	local prevSkillId = self.skillPrevLvId[skillId]

	return prevSkillId or FightConfig.instance:getSkillPrevLvId(skillId)
end

function FightEntityMO:isActiveSkill(skillId)
	local skillLv = self.skillId2Lv[skillId]

	return skillLv ~= nil or FightConfig.instance:isActiveSkill(skillId)
end

function FightEntityMO:getBuffList(returnList)
	local list = returnList or {}

	for k, v in pairs(self.buffDic) do
		table.insert(list, v)
	end

	return list
end

function FightEntityMO:getOrderedBuffList_ByTime(returnList)
	local list = self:getBuffList(returnList)

	table.sort(list, self.sortBuffByTime)

	return list
end

function FightEntityMO.sortBuffByTime(a, b)
	return a.time < b.time
end

function FightEntityMO:getBuffDic()
	return self.buffDic
end

function FightEntityMO:addBuff(buff)
	if not self.buffDic[buff.uid] then
		self.buffDic[buff.uid] = FightBuffInfoData.New(buff, self.id)

		self:_dealBuffFeature()

		return true
	end
end

function FightEntityMO:delBuff(uid)
	if self.buffDic[uid] then
		self.buffDic[uid] = nil

		self:_dealBuffFeature()
	end
end

function FightEntityMO:updateBuff(buff)
	if self.buffDic[buff.uid] then
		FightDataUtil.coverData(buff, self.buffDic[buff.uid])
	end
end

function FightEntityMO:getBuffMO(uid)
	return self.buffDic[uid]
end

function FightEntityMO:clearAllBuff()
	tabletool.clear(self.buffDic)
end

function FightEntityMO:getEntityName()
	local co = self:getCO()

	return (co or nil) and (co.name or "nil")
end

function FightEntityMO:isEnemySide()
	return self.side == FightEnum.EntitySide.EnemySide
end

function FightEntityMO:isMySide()
	return self.side == FightEnum.EntitySide.MySide
end

function FightEntityMO:getIdName()
	local isMySide = self.side == FightEnum.EntitySide.MySide

	if isMySide then
		if not FightEnum.EntityGOName.MySide then
			local goName = FightEnum.EntityGOName.EnemySide

			return string.format("%s_%d", goName, self.position)
		end
	end
end

function FightEntityMO:getCO()
	if self:isCharacter() then
		return lua_character.configDict[self.modelId]
	elseif self:isMonster() then
		return lua_monster.configDict[self.modelId]
	elseif self:isAssistBoss() then
		return lua_tower_assist_boss.configDict[self.modelId]
	elseif self:isAct191Boss() then
		for i, config in ipairs(lua_activity191_assist_boss.configList) do
			if config.skinId == self.skin then
				return config
			end
		end
	elseif self:isASFDEmitter() then
		return FightASFDConfig.instance:getASFDEmitterConfig(self.side)
	elseif self:isVorpalith() then
		self.vorpalithCo = self.vorpalithCo or {
			uniqueSkill_point = 5,
			name = "灵刃"
		}

		return self.vorpalithCo
	elseif self:isRouge2Music() then
		self.rouge2MusicCo = self.rouge2MusicCo or {
			uniqueSkill_point = 0,
			name = "肉鸽音符实体"
		}

		return self.rouge2MusicCo
	end

	return lua_character.configDict[self.modelId] or lua_monster.configDict[self.modelId]
end

function FightEntityMO:isCharacter()
	return self.entityType == FightEnum.EntityType.Character
end

function FightEntityMO:isMonster()
	return self.entityType == FightEnum.EntityType.Monster
end

function FightEntityMO:isAssistBoss()
	return self.entityType == FightEnum.EntityType.AssistBoss
end

function FightEntityMO:isASFDEmitter()
	return self.entityType == FightEnum.EntityType.ASFDEmitter
end

function FightEntityMO:isVorpalith()
	return self.entityType == FightEnum.EntityType.Vorpalith
end

function FightEntityMO:isAct191Boss()
	return self.entityType == FightEnum.EntityType.Act191Boss
end

function FightEntityMO:isRouge2Music()
	return self.entityType == FightEnum.EntityType.Rouge2Music
end

function FightEntityMO:getSpineSkinCO()
	if self:isVorpalith() then
		return
	end

	local skinId = self.skin

	if not skinId then
		local heroCO = lua_character.configDict[self.modelId]

		skinId = heroCO and heroCO.skinId
	end

	if not skinId then
		local monsterCO = lua_monster.configDict[self.modelId]

		skinId = monsterCO and monsterCO.skinId
	end

	local skinCO = FightConfig.instance:getSkinCO(self.skin)

	if skinCO then
		return skinCO
	else
		if FightEntityDataHelper.isPlayerUid(self.id) then
			return
		end

		logError("skin not exist: " .. self.skin .. " modelId: " .. self.modelId)
	end
end

function FightEntityMO:resetSimulateExPoint()
	self.playCardExPoint = 0
	self.moveCardExPoint = 0
end

function FightEntityMO:applyMoveCardExPoint()
	self.moveCardExPoint = 0
	self.playCardExPoint = 0
end

function FightEntityMO:getExPoint()
	return self.exPoint
end

function FightEntityMO:setExPoint(exPoint)
	self.exPoint = exPoint
end

function FightEntityMO:changeExpointMaxAdd(num)
	self.expointMaxAdd = self.expointMaxAdd or 0

	if self.exPointType ~= FightEnum.ExPointType.Common then
		return
	end

	self.expointMaxAdd = self.expointMaxAdd + num
end

function FightEntityMO:getMaxExPoint()
	local config = self:getCO()

	if not config then
		return 0
	end

	return self:getConfigMaxExPoint() + self:getExpointMaxAddNum()
end

function FightEntityMO:getExpointMaxAddNum()
	return self.expointMaxAdd or 0
end

function FightEntityMO:changeServerUniqueCost(num)
	if self.exPointType ~= FightEnum.ExPointType.Common then
		return
	end

	self.exSkillPointChange = self:getExpointCostOffsetNum() + num
end

function FightEntityMO:getUniqueSkillPoint()
	for k, buffMO in pairs(self.buffDic) do
		local buffId = buffMO.buffId
		local featuresSplit = self:getFeaturesSplitInfoByBuffId(buffId)

		if featuresSplit then
			for _, oneFeature in ipairs(featuresSplit) do
				if oneFeature[1] == FightEnum.BuffActId.ExSkillNoConsumption then
					return 0
				end
			end
		end
	end

	return self:getConfigMaxExPoint() + self:getExpointCostOffsetNum()
end

function FightEntityMO:getExpointCostOffsetNum()
	return self.exSkillPointChange or 0
end

function FightEntityMO:getPreviewExPoint()
	return self.exPoint + self.moveCardExPoint + self.playCardExPoint - FightHelper.getPredeductionExpoint(self.id)
end

function FightEntityMO:onPlayCardExPoint(skillId)
	if not FightCardDataHelper.isBigSkill(skillId) then
		local maxSkillPoint = self:getMaxExPoint()
		local previewExPoint = self:getPreviewExPoint()

		if previewExPoint < maxSkillPoint then
			self.playCardExPoint = self.playCardExPoint + self._playCardAddExpoint

			if maxSkillPoint < self:getPreviewExPoint() then
				self.playCardExPoint = self.playCardExPoint - (self:getPreviewExPoint() - maxSkillPoint)
			end
		end
	end
end

function FightEntityMO:onMoveCardExPoint(isMove)
	if isMove then
		if not self._moveCardAddExpoint then
			local addExpoint = self._combineCardAddExpoint
			local maxSkillPoint = self:getMaxExPoint()
			local previewExPoint = self:getPreviewExPoint()

			if previewExPoint < maxSkillPoint then
				self.moveCardExPoint = self.moveCardExPoint + addExpoint

				if maxSkillPoint < self:getPreviewExPoint() then
					self.moveCardExPoint = self.moveCardExPoint - (self:getPreviewExPoint() - maxSkillPoint)
				end
			end
		end
	end
end

function FightEntityMO:_dealBuffFeature()
	self._playCardAddExpoint = 1
	self._moveCardAddExpoint = 1
	self._combineCardAddExpoint = 1

	for k, buffMO in pairs(self.buffDic) do
		local buffId = buffMO.buffId
		local featuresSplit = self:getFeaturesSplitInfoByBuffId(buffId)

		if featuresSplit then
			for _, oneFeature in ipairs(featuresSplit) do
				if oneFeature[1] == 606 then
					self._combineCardAddExpoint = self._combineCardAddExpoint + oneFeature[2]
				elseif oneFeature[1] == 607 then
					self._moveCardAddExpoint = self._moveCardAddExpoint + oneFeature[2]
				elseif oneFeature[1] == 603 then
					self._playCardAddExpoint = 0
					self._combineCardAddExpoint = 0
					self._moveCardAddExpoint = 0

					return
				elseif oneFeature[1] == 845 then
					self._playCardAddExpoint = self._playCardAddExpoint + oneFeature[2]
				end
			end
		end
	end
end

function FightEntityMO:getCombineCardAddExPoint()
	return self._combineCardAddExpoint
end

function FightEntityMO:getMoveCardAddExPoint()
	return self._moveCardAddExpoint
end

function FightEntityMO:getPlayCardAddExPoint()
	return self._playCardAddExpoint
end

function FightEntityMO:getFeaturesSplitInfoByBuffId(buffId)
	self.buffFeaturesSplit = self.buffFeaturesSplit or {}

	if not self.buffFeaturesSplit[buffId] then
		local buffCO = lua_skill_buff.configDict[buffId]
		local features = buffCO and buffCO.features

		if not string.nilorempty(features) then
			self.buffFeaturesSplit[buffId] = FightStrUtil.instance:getSplitString2Cache(features, true)
		end
	end

	return self.buffFeaturesSplit[buffId]
end

function FightEntityMO:hasBuffFeature(featureStr)
	for k, buffMO in pairs(self.buffDic) do
		local buffId = buffMO.buffId
		local featuresSplit = self:getFeaturesSplitInfoByBuffId(buffId)

		if featuresSplit then
			for _, oneFeature in ipairs(featuresSplit) do
				local buffActCO = lua_buff_act.configDict[oneFeature[1]]

				if buffActCO and buffActCO.type == featureStr then
					return true, buffMO
				end
			end
		end
	end
end

function FightEntityMO:hasBuffActId(buffActId)
	for _, buffMO in pairs(self.buffDic) do
		local buffId = buffMO.buffId
		local featuresSplit = self:getFeaturesSplitInfoByBuffId(buffId)

		if featuresSplit then
			for _, oneFeature in ipairs(featuresSplit) do
				if oneFeature[1] == buffActId then
					return true, buffMO
				end
			end
		end
	end
end

function FightEntityMO:hasBuffTypeId(buffTypeId)
	for _, buffMo in pairs(self.buffDic) do
		local co = buffMo:getCO()

		if co and co.typeId == buffTypeId then
			return true
		end
	end
end

function FightEntityMO:hasBuffId(buffId)
	for _, buffMo in pairs(self.buffDic) do
		if buffMo.buffId == buffId then
			return true
		end
	end
end

function FightEntityMO:getBuffDataByBuffId(buffId)
	for _, buffMo in pairs(self.buffDic) do
		if buffMo.buffId == buffId then
			return buffMo
		end
	end
end

function FightEntityMO:setHp(hp)
	if self:isASFDEmitter() then
		return self:setASFDEmitterHp(hp)
	end

	self:defaultSetHp(hp)
end

function FightEntityMO:defaultSetHp(hp)
	if hp < 0 then
		hp = 0
	end

	if hp > self.attrMO.hp then
		hp = self.attrMO.hp
	end

	self.currentHp = hp
end

function FightEntityMO:setASFDEmitterHp(hp)
	if hp < 0 then
		hp = 0
	end

	self.currentHp = hp
end

function FightEntityMO:setShield(shield)
	self.shieldValue = shield
end

function FightEntityMO:onChangeHero()
	tabletool.clear(self.buffDic)
	self:_dealBuffFeature()
	self:setShield(0)
end

function FightEntityMO:setPowerInfos(infos)
	local tab = {}

	for i, v in ipairs(infos) do
		local data = FightPowerInfoData.New(v)

		tab[data.powerId] = data
	end

	FightDataUtil.coverData(tab, self._powerInfos)
end

function FightEntityMO:refreshPowerInfo(info)
	local data = FightPowerInfoData.New(info)
	local powerId = data.powerId

	self._powerInfos[powerId] = FightDataUtil.coverData(data, self._powerInfos[powerId])
end

function FightEntityMO:getPowerInfos()
	return self._powerInfos or {}
end

function FightEntityMO:getPowerInfo(powerId)
	return self._powerInfos and self._powerInfos[powerId]
end

function FightEntityMO:hasStress()
	if self._powerInfos then
		return self._powerInfos and self._powerInfos.max > 0
	end
end

function FightEntityMO:changePowerMax(id, offset)
	if self._powerInfos and self._powerInfos[id] then
		self._powerInfos[id].max = self._powerInfos[id].max + offset
	end
end

function FightEntityMO:buildSummonedInfo(list)
	self.summonedInfo = self.summonedInfo or FightEntitySummonedInfo.New()

	self.summonedInfo:init(list)

	return self.summonedInfo
end

function FightEntityMO:getSummonedInfo()
	self.summonedInfo = self.summonedInfo or FightEntitySummonedInfo.New()

	return self.summonedInfo
end

function FightEntityMO:buildEnhanceInfoBox(enhanceInfoBox)
	self.canUpgradeIds = {}
	self.upgradedOptions = {}

	if enhanceInfoBox then
		for i, v in ipairs(enhanceInfoBox.canUpgradeIds) do
			self.canUpgradeIds[v] = v
		end

		for i, v in ipairs(enhanceInfoBox.upgradedOptions) do
			self.upgradedOptions[v] = v
		end
	end
end

function FightEntityMO:getTrialAttrCo()
	if not self.trialId or self.trialId <= 0 then
		return
	end

	local trialCo = lua_hero_trial.configDict[self.trialId][0]

	if not trialCo then
		return
	end

	if trialCo.attrId <= 0 then
		return
	end

	return lua_hero_trial_attr.configDict[trialCo.attrId]
end

function FightEntityMO:updateStoredExPoint()
	self.storedExPoint = 0

	for _, buffMo in pairs(self:getBuffDic()) do
		local params = buffMo.actCommonParams

		if not string.nilorempty(params) then
			local paramList = FightStrUtil.instance:getSplitToNumberCache(params, "#")
			local actId = paramList[1]
			local buffActCo = lua_buff_act.configDict[actId]
			local type = buffActCo and buffActCo.type

			if type == FightEnum.BuffType_ExPointOverflowBank then
				self.storedExPoint = self.storedExPoint + paramList[2]
			end
		end
	end
end

function FightEntityMO:setStoredExPoint(num)
	self.storedExPoint = num
end

function FightEntityMO:changeStoredExPoint(offsetNum)
	self.storedExPoint = self.storedExPoint + offsetNum
end

function FightEntityMO:getStoredExPoint()
	return self.storedExPoint
end

function FightEntityMO:hadStoredExPoint()
	return self.storedExPoint > 0
end

function FightEntityMO:updateStoredDeviceExPoint()
	self.storedDeviceExPoint = 0

	self:logStoredDeviceExPoint("update Stored Device Ex Point")

	local targetId = FightEnum.BuffActId.DeviceExPointOverflowBank

	for _, buffMo in pairs(self:getBuffDic()) do
		for _, actInfo in ipairs(buffMo.actInfo) do
			if actInfo.actId == targetId then
				self:changeStoredDeviceExPoint(actInfo.param[1])
			end
		end
	end
end

function FightEntityMO:setStoredDeviceExPoint(num)
	self:logStoredDeviceExPoint("setStoredDeviceExPoint .." .. num)

	self.storedDeviceExPoint = num
end

function FightEntityMO:changeStoredDeviceExPoint(offsetNum)
	self:logStoredDeviceExPoint(string.format("changeStoredDeviceExPoint .. before %s, after %s", self.storedDeviceExPoint, self.storedDeviceExPoint + offsetNum))

	self.storedDeviceExPoint = self.storedDeviceExPoint + offsetNum
end

function FightEntityMO:logStoredDeviceExPoint(msg)
	if isDebugBuild then
		logNormal(string.format("[device store ex point][%s] %s", self:getEntityName(), msg))
		logNormal(string.format("[device store ex point][%s] %s", self:getEntityName(), debug.traceback()))
	end
end

function FightEntityMO:getStoredDeviceExPoint()
	return self.storedDeviceExPoint
end

function FightEntityMO:hadStoredDeviceExPoint()
	return self.storedDeviceExPoint > 0
end

function FightEntityMO:getResistanceDict()
	self.resistanceDict = self.resistanceDict or {}

	tabletool.clear(self.resistanceDict)

	local spAttributeMo = FightModel.instance:getSpAttributeMo(self.uid)

	if spAttributeMo then
		for key, field in pairs(FightEnum.ResistanceKeyToSpAttributeMoField) do
			local value = spAttributeMo[field]

			if value and value > 0 then
				self.resistanceDict[key] = value
			end
		end
	end

	return self.resistanceDict
end

function FightEntityMO:isFullResistance(resistance)
	local spAttributeMo = FightModel.instance:getSpAttributeMo(self.uid)

	if not spAttributeMo then
		return false
	end

	local resistanceValue = spAttributeMo[resistance]

	if not resistanceValue then
		logError(string.format("%s 不存在 %s 的sp attr", self:getEntityName(), resistance))

		return false
	end

	return resistanceValue >= 1000
end

function FightEntityMO:isPartResistance(resistance)
	local spAttributeMo = FightModel.instance:getSpAttributeMo(self.uid)

	if not spAttributeMo then
		return false
	end

	local resistanceValue = spAttributeMo[resistance]

	if not resistanceValue then
		logError(string.format("%s 不存在 %s 的sp attr", self:getEntityName(), resistance))

		return false
	end

	return resistanceValue > 0
end

function FightEntityMO:setNotifyBindContract()
	self.notifyBindContract = true
end

function FightEntityMO:clearNotifyBindContract()
	self.notifyBindContract = nil
end

function FightEntityMO:isStatusDead()
	return self.status == FightEnum.EntityStatus.Dead
end

function FightEntityMO:setDead()
	self.status = FightEnum.EntityStatus.Dead
end

function FightEntityMO:getCareer()
	if self:isASFDEmitter() then
		return self:getASFDCareer()
	end

	return self.career
end

function FightEntityMO:getASFDCareer()
	for _, buffMO in pairs(self.buffDic) do
		local buffId = buffMO.buffId
		local featuresSplit = self:getFeaturesSplitInfoByBuffId(buffId)

		if featuresSplit then
			for _, oneFeature in ipairs(featuresSplit) do
				local buffActCO = lua_buff_act.configDict[oneFeature[1]]

				if buffActCO and buffActCO.type == FightEnum.BuffType_EmitterCareerChange then
					return tonumber(oneFeature[2])
				end
			end
		end
	end

	return self.career
end

function FightEntityMO:getConfigMaxExPoint()
	if self.exPointMax and self.exPointMax > 0 then
		return self.exPointMax
	end

	if self.configMaxExPoint then
		return self.configMaxExPoint
	end

	local config = self:getCO()

	if not config then
		return 0
	end

	local configMaxExPoint = config.uniqueSkill_point

	if configMaxExPoint and type(configMaxExPoint) == "string" then
		configMaxExPoint = tonumber(string.split(configMaxExPoint, "#")[2])
	end

	local rankReplace = lua_character_rank_replace.configDict[self.modelId]

	if rankReplace then
		local showLevel, rank = HeroConfig.instance:getShowLevel(self.level or 1)

		if rank > 2 then
			local arr = string.split(rankReplace.uniqueSkill_point, "#")

			configMaxExPoint = arr[2] or configMaxExPoint
		end
	end

	self.configMaxExPoint = configMaxExPoint

	return self.configMaxExPoint
end

function FightEntityMO:getHeroDestinyStoneMo()
	if self.trialId and self.trialId > 0 then
		local trialCo = lua_hero_trial.configDict[self.trialId][0]

		if trialCo then
			self.destinyStoneMo = self.destinyStoneMo or HeroDestinyStoneMO.New(self.modelId)

			self.destinyStoneMo:refreshMo(trialCo.facetslevel, 1, trialCo.facetsId)
		end
	else
		local heroMo = HeroModel.instance:getByHeroId(self.modelId)

		self.destinyStoneMo = heroMo and heroMo.destinyStoneMo
	end

	return self.destinyStoneMo
end

function FightEntityMO:initSkin(info)
	local skin = info.skin

	skin = skin ~= 312001 and FightHelper.processEntitySkin(skin, info.uid) or skin

	if skin == 312001 then
		local showLevel, rank = HeroConfig.instance:getShowLevel(info.level)

		if rank then
			rank = rank - 1

			if rank >= 2 then
				skin = 312002
			end
		end
	end

	if string.sub(skin, 1, 4) == "3120" and lua_skin.configDict[skin] then
		local showLevel, rank = HeroConfig.instance:getShowLevel(info.level)

		if rank then
			rank = rank - 1

			if rank < 2 then
				skin = 312001
			end
		end
	end

	return skin
end

function FightEntityMO:getHeroExtraMo()
	if self.trialId and self.trialId > 0 then
		local trialCo = lua_hero_trial.configDict[self.trialId][0]

		if trialCo then
			local extraStr = trialCo.extraStr

			if not string.nilorempty(extraStr) then
				local config = HeroConfig.instance:getHeroCO(self.modelId)
				local heroMo = HeroMo.New()

				heroMo:init(trialCo, config)

				self.extraMo = self.extraMo or CharacterExtraMO.New(heroMo)

				self.extraMo:refreshMo(extraStr)
			end
		end
	else
		local heroMo = HeroModel.instance:getByHeroId(self.modelId)

		self.extraMo = heroMo and heroMo.extraMo
	end

	return self.extraMo
end

function FightEntityMO:checkReplaceSkill(skillIdList)
	if skillIdList then
		local destinyStoneMo = self:getHeroDestinyStoneMo()

		if destinyStoneMo then
			skillIdList = destinyStoneMo:_replaceSkill(skillIdList)
		end

		local extraMo = self:getHeroExtraMo()

		if extraMo then
			skillIdList = extraMo:getReplaceSkills(skillIdList)
		end
	end

	return skillIdList
end

function FightEntityMO:getDeviceMo()
	if self.trialId and self.trialId > 0 then
		local deviceId = self:getTrialDeviceId()

		if deviceId and deviceId > 0 then
			self.deviceMo = self.deviceMo or HeroDeviceMO.New(self.modelId)

			self.deviceMo:setExSkillLevel(self.exSkillLevel)
			self.deviceMo:refreshDevice(deviceId)
		end
	else
		local deviceId = self:getDeviceIdByExSkillLv(self.exSkillLevel)

		if deviceId and deviceId > 0 then
			self.deviceMo = self.deviceMo or HeroDeviceMO.New(self.modelId)

			self.deviceMo:setExSkillLevel(self.exSkillLevel)
			self.deviceMo:refreshDevice(deviceId)
		end
	end

	return self.deviceMo
end

function FightEntityMO:getTrialDeviceId()
	if not self.trialId or self.trialId == 0 then
		return
	end

	local trialCo = lua_hero_trial.configDict[self.trialId][0]

	return self:getDeviceIdByExSkillLv(trialCo.exSkillLv)
end

function FightEntityMO:getDeviceIdByExSkillLv(exSkillLv)
	local destinyStoneDeviceId = self:getDestinyStoneDeviceId(exSkillLv)

	if destinyStoneDeviceId then
		return destinyStoneDeviceId
	end

	return self:getExSkillDeviceId()
end

function FightEntityMO:getDestinyStoneDeviceId(exSkillLv)
	local destinyStoneMo = self:getHeroDestinyStoneMo()

	if destinyStoneMo then
		local exSkillCo = destinyStoneMo:getExpExchangeSkillCo(exSkillLv)

		if exSkillCo and exSkillCo.deviceId > 0 then
			return exSkillCo.deviceId
		end

		local stoneCo = destinyStoneMo:getCurUseStoneCo()

		if stoneCo and not string.nilorempty(stoneCo.deviceAdd) then
			local devices = GameUtil.splitString2(stoneCo.deviceAdd, true)

			for _, v in pairs(devices) do
				if v[1] == self.exSkillLevel then
					return v[2]
				end
			end
		end
	end
end

function FightEntityMO:getExSkillDeviceId()
	local exSkillCos = SkillConfig.instance:getheroexskillco(self.modelId)
	local exSkillCo = exSkillCos and exSkillCos[self.exSkillLevel]

	if exSkillCo and exSkillCo.deviceId > 0 then
		return exSkillCo.deviceId
	end

	local heroCo = HeroConfig.instance:getHeroCO(self.modelId)

	return heroCo and heroCo.deviceId
end

function FightEntityMO:getEquipMo()
	if not self.equipRecord then
		return
	end

	if not self.equipMo then
		self.equipMo = EquipMO.New()

		self.equipMo:init({
			count = 1,
			exp = 0,
			uid = self.equipRecord.equipUid,
			equipId = self.equipRecord.equipId,
			level = self.equipRecord.equipLv,
			refineLv = self.equipRecord.refineLv
		})
		self.equipMo:setBreakLvByLevel()
	end

	return self.equipMo
end

function FightEntityMO:getLockMaxHpRate()
	for _, buffMo in pairs(self.buffDic) do
		local actParams = buffMo.actCommonParams

		if not string.nilorempty(actParams) then
			local list = FightStrUtil.instance:getSplitString2Cache(actParams, true, "|", "#")

			for _, array in ipairs(list) do
				if array[1] == FightEnum.BuffActId.LockHpMax then
					return (array[2] or nil) and (array[2] / 1000 or 1)
				end
			end
		end
	end

	return 1
end

function FightEntityMO:getHpAndShieldFillAmount(hp, shield)
	local maxHpLockRate = self:getLockMaxHpRate()

	if self.attrMO and self.attrMO.hp > 0 then
		if not self.attrMO.hp then
			local maxHp = 1
			local lockedMaxHp = maxHp * maxHpLockRate
			local currHp = hp or self.currentHp
			local currShield = shield or self.shieldValue

			if not (currHp / lockedMaxHp) then
				local hpPercent = 0
				local shieldPercent = 0

				if lockedMaxHp >= currShield + currHp then
					hpPercent = currHp / lockedMaxHp
					shieldPercent = (currShield + currHp) / lockedMaxHp
				else
					hpPercent = currHp / (currHp + currShield)
					shieldPercent = 1
				end

				hpPercent = hpPercent * maxHpLockRate
				shieldPercent = shieldPercent * maxHpLockRate

				local realHpPercent, fictionHpPercent = self:getHpPercentAndFictionHpPercent(hpPercent, currHp)
				local fakeHp = self:getFakeHp()
				local fakeHpPercent = fakeHp < 0 and 0 or Mathf.Clamp01(fakeHp / lockedMaxHp)

				fakeHpPercent = fakeHpPercent > 0 and fakeHpPercent + shieldPercent or 0

				return realHpPercent, shieldPercent, fictionHpPercent, fakeHpPercent
			end
		end
	end
end

function FightEntityMO:getHpPercentAndFictionHpPercent(hpPercent, currHp)
	local fictionHp = self:getFictionHp()

	if fictionHp < 0 then
		return hpPercent, 0
	end

	if currHp <= fictionHp then
		return hpPercent, 0
	end

	local realHpPercent = fictionHp / currHp * hpPercent
	local fictionHpPercent = hpPercent

	return realHpPercent, fictionHpPercent
end

function FightEntityMO:getFictionHp()
	local actId = FightEnum.BuffActId.FictionHp

	for _, buffMo in pairs(self.buffDic) do
		local actInfo = buffMo.actInfo

		if actInfo then
			for _, buffActInfo in pairs(actInfo) do
				if buffActInfo.actId == actId then
					local fictionHp = buffActInfo.param[1]

					return fictionHp or -1
				end
			end
		end
	end

	return -1
end

function FightEntityMO:getFakeHp()
	local actId = FightEnum.BuffActId.LostHpToFakeHp

	for _, buffMo in pairs(self.buffDic) do
		local actInfo = buffMo.actInfo

		if actInfo then
			for _, buffActInfo in pairs(actInfo) do
				if buffActInfo.actId == actId then
					local fakeHp = buffActInfo.param[1]

					return fakeHp or -1
				end
			end
		end
	end

	return -1, -1
end

function FightEntityMO:getFakeHpPercent()
	local fakeHp, maxFakeHp = self:getFakeHpAndMaxFakeHp()

	if fakeHp < 0 then
		return 0
	end

	return Mathf.Clamp01(fakeHp / maxFakeHp)
end

function FightEntityMO:getHeDuoNieBuffData()
	local buffActId = FightEnum.BuffActId.HedoneCard

	for _, buffMo in pairs(self.buffDic) do
		local actInfo = buffMo.actInfo

		if actInfo then
			for _, buffActInfo in pairs(actInfo) do
				if buffActInfo.actId == buffActId then
					local param = buffActInfo.param
					local curCount = param[1]
					local maxCount = param[2]
					local unlock = param[3] == 1

					return curCount, maxCount, unlock
				end
			end
		end
	end
end

function FightEntityMO:set_position(key, position)
	self._position = position
end

function FightEntityMO:get_position(key)
	if self:isAssistBoss() and FightDataHelper.paTaMgr:checkIsAssistRole() then
		return 3
	end

	return self._position
end

return FightEntityMO
