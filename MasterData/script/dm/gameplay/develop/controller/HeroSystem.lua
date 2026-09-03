-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/controller/HeroSystem.lua

HeroSystem = class("HeroSystem", legs.Actor)

HeroSystem:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
HeroSystem:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
HeroSystem:has("_customDataSystem", {
	is = "rw"
}):injectWith("CustomDataSystem")
HeroSystem:has("_crusadeSystem", {
	is = "r"
}):injectWith("CrusadeSystem")
HeroSystem:has("_shareCDTime", {
	is = "rw"
})
HeroSystem:has("_uiSelectHeroId", {
	is = "rw"
})
HeroSystem:has("_uiHeroEffectId", {
	is = "rw"
})
HeroSystem:has("_eatItemCache", {
	is = "rw"
})
HeroSystem:has("_heroShowIds", {
	is = "rw"
})
HeroSystem:has("_heroIdToIndex", {
	is = "rw"
})
HeroSystem:has("_heroAnim", {
	is = "rw"
})
HeroSystem:has("_heroBgAnim", {
	is = "rw"
})
HeroSystem:has("_heroStarUpItem", {
	is = "rw"
})
HeroSystem:has("_selectData", {
	is = "rw"
})
HeroSystem:has("_heroPicInfo", {
	is = "rw"
})

function HeroSystem:initialize(developSystem)
	super.initialize(self)

	self._showHeroType = 1
	self._developSystem = developSystem
	self._bagSystem = self._developSystem:getBagSystem()
	self._showListCache = {}
	self._heroShowIds = {}
	self._heroIdToIndex = {}
	self._ownHeroNum = 0
	self._shareCDTime = {}
	self._uiSelectHeroId = nil
	self._uiHeroEffectId = nil
	self._eatItemCache = {}
	self._heroStarUpItem = {
		stiveNum = 0,
		items = {}
	}
	self._teamHeroes = {}
	self._selectData = {
		["14"] = "0",
		["13"] = "1",
		["15"] = "0",
		canUseStive = "1",
		canUseOwn = "0",
		["12"] = "1"
	}

	local value = cc.UserDefault:getInstance():getStringForKey(UserDefaultKey.kHeroQuickSelectKey)

	if value == "" then
		local str = ""

		for key, value in pairs(self._selectData) do
			str = str == "" and key .. "_" .. value or str .. "&" .. key .. "_" .. value
		end

		cc.UserDefault:getInstance():setStringForKey(UserDefaultKey.kHeroQuickSelectKey, str)
	else
		local valueTemp = string.split(value, "&")

		for i = 1, #valueTemp do
			local keys = string.split(valueTemp[i], "_")

			self._selectData[keys[1]] = keys[2]
		end
	end

	self:initCombatToCostRate()
end

function HeroSystem:dispose()
	self:stopTimers()
	super.dispose(self)
end

function HeroSystem:initCombatToCostRate()
	self._combatToCostRate = {}

	local rate = ConfigReader:getDataTable("HeroCostAttr")

	for k, v in pairs(rate) do
		self._combatToCostRate[tonumber(v.Id)] = v.COSTPOWER
	end
end

function HeroSystem:resetHeroQuickSelect()
	local value = cc.UserDefault:getInstance():getStringForKey(UserDefaultKey.kHeroQuickSelectKey)
	local valueTemp = string.split(value, "&")

	for i = 1, #valueTemp do
		local keys = string.split(valueTemp[i], "_")

		self._selectData[keys[1]] = keys[2]
	end
end

function HeroSystem:resetHeroStarUpItem()
	self._heroStarUpItem = {
		stiveNum = 0,
		items = {}
	}
end

function HeroSystem:setHeroStarUpItem(stiveNum, items)
	self._heroStarUpItem.stiveNum = stiveNum
	self._heroStarUpItem.items = items
end

function HeroSystem:stopHeroEffect()
	if self._uiHeroEffectId then
		AudioEngine:getInstance():stopEffect(self._uiHeroEffectId)

		self._uiHeroEffectId = nil
	end
end

function HeroSystem:checkEnabledMain(params)
	local result, tip = true, ""

	if params and params.tabType then
		local tabType = tonumber(params.tabType)

		if tabType == 1 then
			result = true
		elseif tabType == 2 then
			result, tip = self._systemKeeper:isUnlock("Hero_Quality")
		elseif tabType == 3 then
			result, tip = self._systemKeeper:isUnlock("Hero_StarUp")
		elseif tabType == 4 then
			result, tip = self._systemKeeper:isUnlock("Hero_Skill")
		elseif tabType == 5 then
			result, tip = self._systemKeeper:isUnlock("Hero_Equip")
		end
	end

	return result, tip
end

function HeroSystem:tryEnterShowMain(params)
	if not params then
		local view = self:getInjector():getInstance("HeroShowMainView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, nil))

		return
	end

	local result, tip = self:checkEnabledMain(params)

	if not result then
		self:dispatch(ShowTipEvent({
			tip = tip
		}))
	else
		local view = self:getInjector():getInstance("HeroShowMainView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, params))
	end
end

function HeroSystem:checkEnabledLevel(param)
	local result, tip = self._systemKeeper:isUnlock("Hero_LevelUp")

	return result, tip
end

function HeroSystem:checkEnabledReborn(param)
	local result, tip = self._systemKeeper:isUnlock("Hero_Reborn_Unlock")

	return result, tip
end

function HeroSystem:tryEnterLevel(param)
	local result, tip = self:checkEnabledLevel(param)

	if not result then
		self:dispatch(ShowTipEvent({
			tip = tip
		}))
	else
		local view = self:getInjector():getInstance("HeroStrengthLevelView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, param))
	end
end

function HeroSystem:tryEnterReborn(param)
	local result, tip = self:checkEnabledReborn(param)

	if not result then
		self:dispatch(ShowTipEvent({
			tip = tip
		}))
	else
		local view = self:getInjector():getInstance("HeroStrengthLevelView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, param))
	end
end

function HeroSystem:checkEnabledQuality()
	local result, tip = self._systemKeeper:isUnlock("Hero_Quality")

	return result, tip
end

function HeroSystem:tryEnterQuality()
	local unlock, tip = self:checkEnabledQuality()

	if not unlock then
		self:dispatch(ShowTipEvent({
			tip = tip
		}))

		return
	end

	self:tryEnterShowMain({
		ignoreSound = true
	})
	self:tryEnterLevel()
end

function HeroSystem:enterBaseShowView(info)
	require("dm.gameplay.develop.view.herostrength.HeroBaseShowView")

	return HeroBaseShowView:new(info)
end

function HeroSystem:enterEatItemView(info)
	require("dm.gameplay.develop.view.herostrength.HeroEatItemView")

	return HeroEatItemView:new(info)
end

function HeroSystem:enterEvolutionView(info)
	require("dm.gameplay.develop.view.herostrength.HeroEvolutionView")

	return HeroEvolutionView:new(info)
end

function HeroSystem:enterRebornView(info)
	require("dm.gameplay.develop.view.herostrength.HeroRebornView")

	return HeroRebornView:new(info)
end

function HeroSystem:enterEquipInfoView(info)
	require("dm.gameplay.develop.view.herostrength.HeroEquipInfoView")

	return HeroEquipInfoView:new(info)
end

function HeroSystem:enterEquipListView(info)
	require("dm.gameplay.develop.view.equip.EquipListView")

	return EquipListView:new(info)
end

function HeroSystem:createItemTipIcon(node, nodeTag)
	nodeTag = nodeTag or 1

	local addImg = cc.Sprite:createWithSpriteFrameName(IconFactory.itemAddTipPath)

	addImg:addTo(node):center(node:getContentSize())
	addImg:setTag(nodeTag)

	return addImg
end

function HeroSystem:syncHeroShowIds()
	self._heroShowIds = self:getHeroShowIdsCache()

	self:dispatch(Event:new(EVT_HEROES_SYNC_SUCC))
end

function HeroSystem:getHeros()
	return self:getHeroList():getHeros()
end

function HeroSystem:getHeroById(heroId)
	return self:getHeroList():getHeroById(heroId)
end

function HeroSystem:getMazeHeroById(heroId)
	return
end

function HeroSystem:hasHero(heroId)
	return self:getHeroList():hasHero(heroId)
end

function HeroSystem:getHeroProById(heroId)
	return PrototypeFactory:getInstance():getHeroPrototype(heroId)
end

function HeroSystem:getAllHeroIds()
	return self:getHeroList():getAllHeroIds()
end

function HeroSystem:getHeroCount()
	return self:getHeroList():getHeroCount()
end

function HeroSystem:getHeroList()
	return self._developSystem:getPlayer():getHeroList()
end

function HeroSystem:getHeroComposeFragCount(heroId)
	local heroPrototype = self:getHeroProById(heroId)

	return heroPrototype:getStarNumByCompose()
end

function HeroSystem:checkHeroCanComp(heroId)
	if self:getHeroById(heroId) then
		return false
	end

	local heroPrototype = self:getHeroProById(heroId)
	local itemNum = heroPrototype:getStarNumByCompose()
	local hasNum = self:getHeroDebrisCount(heroId)

	if itemNum <= hasNum then
		return true
	end

	return false
end

function HeroSystem:getAllHeroConfigIds()
	if not self._heroTimeInfo then
		self:initHeroTimeType()
	end

	self._heroIds = {}

	local heroIdList = ConfigReader:getKeysOfTable("HeroBase")

	for _, heroId in pairs(heroIdList) do
		if heroId ~= "$" then
			local config = ConfigReader:getRecordById("HeroBase", heroId)
			local hero = self:getHeroById(heroId)

			if hero or config.IfHidden == 1 and self._heroTimeInfo[heroId] == nil then
				self._heroIds[#self._heroIds + 1] = heroId
			end
		end
	end

	return self._heroIds
end

function HeroSystem:initHeroTimeType()
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")

	if not self._heroTimeInfo then
		local curTime = gameServerAgent:remoteTimestamp()

		self._heroTimeInfo = {}

		local heroIdList = ConfigReader:getKeysOfTable("HeroBase")

		for _, heroId in pairs(heroIdList) do
			if heroId ~= "$" then
				local config = ConfigReader:getRecordById("HeroBase", heroId)

				if config.IfHidden == 1 then
					local start = self:getTimeType(config)

					if start then
						local _, _, y, mon, d, h, m, s = string.find(start, "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
						local table = {
							year = y,
							month = mon,
							day = d,
							hour = h,
							min = m,
							sec = s
						}
						local mills = TimeUtil:timeByRemoteDate(table)

						if curTime < mills then
							self._heroTimeInfo[heroId] = mills
						end
					end
				end
			end
		end
	end

	if next(self._heroTimeInfo) then
		local function checkTimeFunc()
			local ret = false

			for k, v in pairs(self._heroTimeInfo) do
				local curTime = gameServerAgent:remoteTimestamp()
				local remainTime = curTime - v

				if remainTime >= 0 then
					self._heroTimeInfo[k] = nil
					ret = true
				end
			end

			if ret then
				self:syncHeroShowIds()
				self:dispatch(Event:new(EVT_HEROES_SYNC_SHOW))

				if not next(self._heroTimeInfo) then
					self:stopTimers()

					return
				end
			end
		end

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)
	end
end

function HeroSystem:getTimeType(config)
	if config.TimeType and config.TimeType ~= "" then
		return config.TimeType
	end

	return nil
end

function HeroSystem:stopTimers()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end
end

function HeroSystem:getNextLvlAddExp(heroId, level)
	local heroData = self:getHeroById(heroId)
	local nextExp = self:getHeroExpByLvl(heroId, level)
	local lvlUpFactor = heroData:getLevelUpFactor()

	return math.modf(nextExp * lvlUpFactor)
end

function HeroSystem:getHeroExpByLvl(heroId, level)
	local hero = self:getHeroById(heroId)
	local qualityBase = tostring(hero:getRarity())

	level = tostring(level)

	local data = ConfigReader:getDataByNameIdAndKey("HeroExp", level, "Exp")

	if data then
		return data[qualityBase]
	end

	data = ConfigReader:getDataByNameIdAndKey("HeroExp", "1", "Exp")

	return data[qualityBase]
end

function HeroSystem:getHeroLevelGoldCost(heroId, addExp)
	local hero = self:getHeroById(heroId)
	local maxLevel = hero:getCurMaxLevel()
	local curShowLevel = hero:getLevel()
	local level = curShowLevel
	local exp = hero:getExp()
	local curShowExp = hero:getExp()
	local gold = 0
	local qualityBase = tostring(hero:getRarity())
	local targetTotalExp = addExp + exp
	local totalExp = 0
	local tempExp = addExp

	for i = level, maxLevel do
		if targetTotalExp < totalExp then
			break
		end

		local goldArr = ConfigReader:getDataByNameIdAndKey("HeroExp", tostring(i), "Gold")
		local expArr = ConfigReader:getDataByNameIdAndKey("HeroExp", tostring(i), "Exp")
		local nextExp = expArr[qualityBase]

		totalExp = totalExp + nextExp
		curShowLevel = i
		curShowExp = nextExp - (totalExp - targetTotalExp)

		if i == level then
			if tempExp - (nextExp - exp) >= 0 then
				tempExp = tempExp - (nextExp - exp)
				gold = gold + math.ceil(goldArr[qualityBase] * ((nextExp - exp) / nextExp))
			else
				gold = gold + math.ceil(goldArr[qualityBase] * (tempExp / nextExp))
			end
		elseif tempExp - nextExp >= 0 then
			tempExp = tempExp - nextExp
			gold = gold + goldArr[qualityBase]
		else
			gold = gold + math.ceil(goldArr[qualityBase] * (tempExp / nextExp))
		end

		if maxLevel < curShowLevel then
			curShowLevel = maxLevel
			curShowExp = nextExp

			break
		end
	end

	return curShowLevel, curShowExp, gold
end

function HeroSystem:isHeroLevelMax(heroId, level, exp)
	local hero = self:getHeroById(heroId)

	level = level or hero:getLevel()
	exp = exp or hero:getExp()

	local maxLevel = hero:getCurMaxLevel()

	return level == maxLevel
end

function HeroSystem:isHeroExpMax(heroId, level, exp)
	local hero = self:getHeroById(heroId)

	level = level or hero:getLevel()
	exp = exp or hero:getExp()

	local maxLevel = hero:getCurMaxLevel()

	return level == maxLevel and exp == self:getNextLvlAddExp(heroId, maxLevel)
end

function HeroSystem:getHeroDebrisCount(heroId)
	local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(heroId)
	local fragId = heroPrototype:getConfig().ItemId

	return self._bagSystem:getItemCount(fragId)
end

function HeroSystem:getNextQuality(quality)
	local qualityList = ConfigReader:getRecordById("ConfigValue", "Hero_Quality").content

	if not self._qualityMap then
		self._qualityMap = {}

		for i = 1, #qualityList do
			self._qualityMap[i] = qualityList[i]
		end
	end

	for i = 1, #self._qualityMap do
		if quality and self._qualityMap[i] == quality then
			return self._qualityMap[i + 1]
		end
	end
end

function HeroSystem:getSkillListOj(heroId)
	local hero = self:getHeroById(heroId)

	return hero:getSkillList()
end

function HeroSystem:getShowSkillIds(heroId)
	local heroPrototype = self:getHeroProById(heroId)

	return heroPrototype:getShowSkillIds()
end

function HeroSystem:getSkillById(heroId, skillId)
	local skillListOj = self:getSkillListOj(heroId)

	return skillListOj:getSkillById(skillId)
end

function HeroSystem:getSkillTypeName(skillType)
	local skillTypeArr = ConfigReader:getRecordById("ConfigValue", "Hero_SkillName").content

	return Strings:get(skillTypeArr[tostring(skillType)])
end

function HeroSystem:getSkillTypeIcon(skillType)
	local skillTypeArr = ConfigReader:getRecordById("ConfigValue", "Hero_SkillIcon").content
	local icon1 = skillTypeArr[skillType] .. "_1.png"
	local icon2 = skillTypeArr[skillType] .. "_2.png"

	return "asset/heroRect/heroSkillType/" .. icon1, "asset/heroRect/heroSkillType/" .. icon2
end

local skillCostFactor = ConfigReader:getRecordById("ConfigValue", "Skill_CostFactor").content
local skillCostMap = ConfigReader:getRecordById("ConfigValue", "Skill_CostMap").content

function HeroSystem:getSkillLevelUpCost(heroId, heroRareity, skillId)
	local skill = self:getSkillById(heroId, skillId)
	local heroPrototype = self:getHeroProById(heroId)
	local showType = heroPrototype:getSkillShowType(skillId)
	local rate = skillCostFactor[tostring(heroRareity)]
	local costMap = skillCostMap[showType]
	local config = ConfigReader:getRecordById("ConfigValue", costMap).content
	local cost = rate * (config[skill:getLevel() + 1] or 0)

	return cost or 0
end

function HeroSystem:getSkillLevelUpItemCost(heroId, skillId)
	local skill = self:getSkillById(heroId, skillId)
	local heroPrototype = self:getHeroProById(heroId)
	local showType = heroPrototype:getSkillShowType(skillId)
	local config = heroPrototype:getConfig()
	local costData = config.SkillCost[showType]

	if costData then
		local count = costData.amount[skill:getLevel() + 1] or costData.amount[#costData.amount]

		return {
			itemId = costData.code,
			count = count
		}
	end

	return nil
end

function HeroSystem:checkIsKeySkill(heroId, skillId)
	local hero = self:getHeroById(heroId)

	if not hero:getPassiveCondition() then
		return false
	end

	local heroPrototype = self:getHeroProById(heroId)
	local config = heroPrototype:getConfig()

	if config.KeyPassiveSkill and config.KeyPassiveSkill == "" then
		return nil
	end

	local showType = heroPrototype:getSkillShowType(skillId)

	if showType == "BattlePassiveSkill" then
		return true
	end

	return false
end

function HeroSystem:checkHasKeySkill(heroId)
	local hero = self:getHeroById(heroId)

	if not hero or not hero:getPassiveCondition() then
		return nil
	end

	local heroPrototype = self:getHeroProById(heroId)
	local config = heroPrototype:getConfig()

	if config.KeyPassiveSkill and config.KeyPassiveSkill == "" then
		return nil
	end

	local skillIds = heroPrototype:getShowSkillIds()

	for i = 1, #skillIds do
		local skillId = skillIds[i]
		local showType = heroPrototype:getSkillShowType(skillId)

		if showType == "BattlePassiveSkill" then
			local skill = self:getSkillById(heroId, skillId)

			return skill, hero:getPassiveCondition()
		end
	end

	return nil
end

function HeroSystem:getSkillLevelMax()
	local level = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_SkillMax", "content")

	return level or 1
end

function HeroSystem:getUnLockSkillStar(heroId, skillId)
	local heroPrototype = self:getHeroProById(heroId)
	local unLockSkillIds = heroPrototype:getUnLockSkillIds()

	if unLockSkillIds[skillId] then
		return unLockSkillIds[skillId]
	end

	return nil
end

function HeroSystem:getSkillShowList(heroId)
	if self._showListCache[heroId] then
		return self._showListCache[heroId]
	end

	local data = {}
	local config = ConfigReader:getRecordById("HeroBase", tostring(heroId))
	local starId = config.StarId
	local nextStarId = config.StarId

	while nextStarId ~= "" do
		starId = nextStarId
		nextStarId = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", nextStarId, "NextId")

		local star = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", nextStarId, "Star")
		local SpecialEffect = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", nextStarId, "SpecialEffect") or {}

		if #SpecialEffect > 0 then
			for i = 1, #SpecialEffect do
				local effectId = SpecialEffect[i]
				local config_ = ConfigReader:getRecordById("SkillSpecialEffect", effectId)

				if config_.EffectType == SpecialEffectType.kChangeRarity then
					table.insert(data, {
						star = star,
						skillId = config_.Parameter.skill,
						effectType = config_.EffectType,
						parameter = config_.Parameter
					})
				end
			end
		end
	end

	self._showListCache[heroId] = data

	return data
end

function HeroSystem:getRelationRateByLevel(heroId, relationId, level)
	local config = ConfigReader:getRecordById("HeroRelation", relationId)
	local condition = config.Condition[level]
	local curNum, targetNum = 0, 0

	for condType, factor in pairs(condition) do
		targetNum = targetNum + factor

		if condType == RelationCondType.kHeroAmount then
			for i = 1, #config.RelationList do
				local relationHeroId = config.RelationList[i]

				if self:hasHero(relationHeroId) then
					curNum = curNum + 1
				end
			end
		elseif condType == RelationCondType.kHeroStar then
			for i = 1, #config.RelationList do
				local relationHeroId = config.RelationList[i]

				if self:hasHero(relationHeroId) then
					local hero = self:getHeroById(relationHeroId)

					curNum = curNum + hero:getStar()
				end
			end
		elseif condType == RelationCondType.kEquipStar then
			for i = 1, #config.RelationList do
				local equipId = config.RelationList[i]
				local equipData = self:getEquipById(heroId, equipId)

				if equipData then
					local hero = self:getHeroById(heroId)

					curNum = curNum + equipData:getStar()
				end
			end
		elseif condType == RelationCondType.kRelationAmount then
			local relationList = self:getHeroById(heroId):getRelationList()

			for i = 1, #config.RelationList do
				local relationId = config.RelationList[i]
				local relation = relationList:getRelationById(relationId)

				if relation and relation:getLevel() >= 1 then
					curNum = curNum + 1
				end
			end
		elseif condType == RelationCondType.kRelationLevel then
			local relationList = self:getHeroById(heroId):getRelationList()

			for i = 1, #config.RelationList do
				local relationId = config.RelationList[i]
				local relation = relationList:getRelationById(relationId)

				if relation then
					curNum = curNum + relation:getLevel()
				end
			end
		elseif condType == RelationCondType.kEquipEvolve then
			for i = 1, #config.RelationList do
				local equipId = config.RelationList[i]
				local equipData = self:getEquipById(heroId, equipId)

				if equipData then
					curNum = curNum + equipData:getEvolve() - 1
				end
			end
		end
	end

	if targetNum < curNum then
		curNum = targetNum
	end

	return curNum, targetNum
end

function HeroSystem:getRelationById(heroId, relationId)
	return self:getHeroById(heroId):getRelationList():getRelationById(relationId)
end

function HeroSystem:hasRedPointByRelationId(heroId, relationId)
	local hero = self:getHeroById(heroId)

	if not hero then
		return false
	end

	local unlock, tips = self._systemKeeper:isUnlock("Hero_Relation")

	if unlock == false then
		return false
	end

	local relation = hero:getRelationList():getRelationById(relationId)

	return relation and relation:getCanDevelop()
end

function HeroSystem:getLockSoulNextQuality(heroId, targetQuality)
	local hero = self:getHeroById(heroId)
	local soulData = hero:getHeroSoulList():getSoulMap()

	for soulId, soul in pairs(soulData) do
		local condition = soul:getUnlockCon()
		local quality = condition.quality

		if soul:getLock() and targetQuality == tonumber(quality) then
			return soul
		end
	end

	return nil
end

function HeroSystem:getSoulItemList()
	local allEntries = self:getSoulItemEntryList()
	local list = {}

	for _, entry in pairs(allEntries) do
		local item = entry.item
		local data = {}

		data.id = item:getId()
		data.itemId = item:getId()
		data.allCount = entry.count
		data.quality = item:getQuality()
		data.exp = item:getSoulExp()
		data.eatCount = 0
		list[#list + 1] = data
	end

	return list
end

function HeroSystem:getSoulItemEntryList()
	local function filterFunc(entry)
		if entry.item and entry.count and entry.count > 0 and entry.item:getSoulExp() > 0 then
			return true
		end
	end

	local allEntries = self._bagSystem:getBag():getEntries(filterFunc)

	table.sort(allEntries, function(a, b)
		return self:sortSoulItem(a, b)
	end)

	return allEntries
end

function HeroSystem:sortSoulItem(a, b)
	local item_A = a.item
	local item_B = b.item

	if item_A:getSoulExp() ~= item_B:getSoulExp() then
		return item_A:getSoulExp() > item_B:getSoulExp()
	end

	if item_A:getSort() ~= item_B:getSort() then
		return item_A:getSort() > item_B:getSort()
	end
end

function HeroSystem:getSoulUnlockNumById(heroId, soulId)
	local hero = self:getHeroById(heroId)
	local soulData = hero:getHeroSoulList():getSoulById(soulId)
	local condition = soulData:getUnlockCon()
	local quality = condition.quality

	if hero:getQuality() < tonumber(quality) then
		local var_67_0 = {}

		var_67_0.quality = self:getQualityName(quality) or quality

		return Strings:get("HeroSoul_UI1", var_67_0)
	end
end

function HeroSystem:getQualityName(quality)
	local qualityDescs = ConfigReader:getRecordById("ConfigValue", "QualityDesc").content

	return Strings:get(qualityDescs[tostring(quality)])
end

function HeroSystem:getSubHeroSoulLevelById(heroId)
	local level, count = 0, 0
	local hero = self:getHeroById(heroId)
	local list = hero:getHeroSoulList():getSoulArray()

	for i = 1, #list do
		if not list[i]:getLock() then
			level = level + list[i]:getLevel()
			count = count + 1
		end
	end

	return level, count
end

function HeroSystem:getAdvanceListOj(heroId)
	local hero = self:getHeroById(heroId)

	return hero:getAdvanceList()
end

function HeroSystem:getAdvanceList(heroId)
	return self:getAdvanceListOj(heroId):getShowList()
end

function HeroSystem:getAdvanceCost(heroId)
	local advanceList = self:getAdvanceListOj(heroId)

	return advanceList:getCost()
end

function HeroSystem:getAdvanceIsMax(heroId)
	local advanceList = self:getAdvanceListOj(heroId)

	return advanceList:getMax()
end

function HeroSystem:getShowAttrList(heroId)
	local advanceList = self:getAdvanceListOj(heroId)

	return advanceList:getShowAttrList()
end

function HeroSystem:getConfigByEvolution(qualityId)
	return ConfigReader:getRecordById("HeroQuality", tostring(qualityId))
end

function HeroSystem:getSpeedByItemCount(itemId, count)
	local data = ConfigReader:getRecordById("ExpConsume", tostring(itemId or "200004"))

	if not count then
		return data.ExpConsumeSpeed[1]
	end

	if count < data.ExpConsumeRate[1] then
		return data.ExpConsumeSpeed[1]
	end

	if count >= data.ExpConsumeRate[#data.ExpConsumeRate] then
		return data.ExpConsumeSpeed[#data.ExpConsumeSpeed]
	end

	for i = 1, #data.ExpConsumeRate do
		local preCount = data.ExpConsumeRate[i]

		if count <= preCount then
			return data.ExpConsumeSpeed[i + 1]
		end
	end

	return data.ExpConsumeSpeed[1]
end

function HeroSystem:getCostItemMap()
	local costList = {}
	local normalList = ConfigReader:getRecordById("ConfigValue", "Hero_ExpItem").content

	for i = 1, #normalList do
		costList[#costList + 1] = normalList[i]
	end

	return costList
end

function HeroSystem:getCostNumByItemCount(itemId, count)
	local data = ConfigReader:getRecordById("ExpConsume", tostring(itemId or "200004"))

	if not count then
		return data.ExpConsumeConut[1]
	end

	if count <= data.ExpConsumeRate[1] then
		return data.ExpConsumeConut[1]
	end

	if count >= data.ExpConsumeRate[#data.ExpConsumeRate] then
		return data.ExpConsumeConut[#data.ExpConsumeConut]
	end

	for i = 1, #data.ExpConsumeRate do
		local preCount = data.ExpConsumeRate[i]

		if count < preCount then
			return data.ExpConsumeConut[i]
		end
	end

	return data.ExpConsumeConut[1]
end

function HeroSystem:getTeamSpecialSound(targetId, ids)
	local hero = self:getHeroById(targetId)
	local specialSounds = hero:getTeamSpecialVoice()
	local sounds = {}

	for id, sound in pairs(specialSounds) do
		if table.indexof(ids, id) then
			sounds[#sounds + 1] = sound
		end
	end

	local length = #sounds

	if length > 0 then
		local index = math.random(1, length)

		return sounds[index]
	end

	return nil
end

StrengthenViewType = {
	kEquip = 5,
	kSkill = 4,
	KTSoul = 7,
	kEvolution = 2,
	kStar = 3
}

local redPointFuncMap = {
	[StrengthenViewType.kEvolution] = function(HeroSystem, heroId)
		return HeroSystem:hasRedPointByEvolution(heroId)
	end,
	[StrengthenViewType.kStar] = function(HeroSystem, heroId)
		return HeroSystem:hasRedPointByStar(heroId)
	end,
	[StrengthenViewType.kSkill] = function(HeroSystem, heroId)
		return HeroSystem:hasRedPointBySkill(heroId)
	end,
	[StrengthenViewType.kEquip] = function(HeroSystem, heroId)
		return HeroSystem:hasRedPointByEquip(heroId)
	end,
	[StrengthenViewType.KTSoul] = function(HeroSystem, heroId)
		return HeroSystem:hasRedPointByTSoul(heroId)
	end
}

function HeroSystem:getRedPointFuncMap()
	return redPointFuncMap
end

function HeroSystem:hasRedPointByRelation(heroId)
	local hero = self:getHeroById(heroId)
	local unlock, tips = self._systemKeeper:isUnlock("Hero_Relation")

	if unlock then
		local heroPrototype = self:getHeroProById(heroId)
		local relationArr = heroPrototype:getConfig().RelationList

		for i = 1, #relationArr do
			local relationId = relationArr[i]
			local relation = hero:getRelationList():getRelationById(relationId)

			if relation and relation:getCanDevelop() then
				return true
			end
		end
	end

	return false
end

function HeroSystem:hasRedPointByLevel(heroId)
	local unlock, tip = self._systemKeeper:isUnlock("Hero_LevelUp")

	if not unlock then
		return false
	end

	local heroData = self:getHeroById(heroId)
	local levelRequest = heroData:getCurMaxLevel()

	if levelRequest <= heroData:getLevel() then
		return false
	end

	local maxExpNeed = 0

	for i = heroData:getLevel(), levelRequest do
		local addExp = self:getNextLvlAddExp(heroId, i)

		if i < levelRequest then
			maxExpNeed = maxExpNeed + addExp
		end
	end

	if maxExpNeed - heroData:getExp() <= 0 then
		return false
	end

	local sortItemArr = self:getCostItemMap()

	self._itemMap = {}

	for i = 1, #sortItemArr do
		local itemId = sortItemArr[i]
		local entry = self._bagSystem:getEntryById(itemId)

		if ((entry and entry.count > 0 or nil) and entry.count) > 0 then
			return true
		end
	end

	return false
end

function HeroSystem:hasRedPointByEvolution(heroId)
	local result, tip
	local var_88_0, var_88_1 = self._systemKeeper:isUnlock("Hero_Quality")

	tip = var_88_1

	if not var_88_0 then
		return false
	end

	local hero = self:getHeroById(heroId)
	local config = self:getConfigByEvolution(hero:getQualityId())

	if not config.LevelRequest or config.LevelRequest > hero:getLevel() then
		return false
	end

	if not config.PlayerLevelRequest or config.PlayerLevelRequest > self._developSystem:getLevel() then
		return false
	end

	if #config.CurrencyCost == 0 then
		return false
	end

	local costGold = config.CurrencyCost[1].amount
	local itemIdArr = config.CostItem

	if itemIdArr == nil then
		return false
	end

	if costGold > self._developSystem:getGolds() then
		return false
	end

	for i = 1, #itemIdArr do
		local data = itemIdArr[i]
		local itemId, needCount = data.id, data.amount

		if needCount > self._bagSystem:getItemCount(itemId) then
			return false
		end
	end

	return true
end

local kHeroStiveId = "IR_HeroStive"
local HeroStar_StiveChange = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroStar_StiveChange", "content")
local HeroStar_StiveChangeSelf = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroStar_StiveChangeSelf", "content")

function HeroSystem:hasRedPointByStar(heroId)
	local result, tip
	local var_89_0, var_89_1 = self._systemKeeper:isUnlock("Hero_StarUp")

	tip = var_89_1

	if not var_89_0 then
		return false
	end

	local hero = self:getHeroById(heroId)

	if not hero then
		return false
	end

	local hasStarBoxReward = hero:getHasStarBoxReward()

	if hasStarBoxReward then
		return true
	end

	if self:getHeroIdentityAwakeRedpoint(heroId) then
		return true
	end

	local isMaxStar = hero:isMaxStar()

	if isMaxStar then
		return false
	end

	local heroPrototype = self:getHeroProById(heroId)
	local isLittleStar = hero:getLittleStar()
	local nextIsMiniStar = hero:getNextIsMiniStar()
	local costNum = heroPrototype:getStarCostGoldByStar(hero:getNextStarId())

	if costNum > self._developSystem:getGolds() then
		return false
	end

	if isLittleStar and not nextIsMiniStar then
		local needNum = hero:getStarStive()
		local exp = 0
		local stiveItem
		local num = self._bagSystem:getItemCount(kHeroStiveId)

		if num > 0 then
			stiveItem = {
				exp = 1,
				allCount = num
			}
			exp = stiveItem.allCount * stiveItem.exp

			if needNum <= stiveItem.allCount * stiveItem.exp then
				return true
			end
		end

		local canUseRarity = "12"
		local heroList = self:getOwnHeroIds(true)

		for i = 1, #heroList do
			local value = heroList[i]
			local id = value.id
			local itemId = value.fragId
			local rarity = tostring(value.rareity)

			if rarity == canUseRarity and heroId ~= id then
				local num = self._bagSystem:getItemCount(itemId)

				if num > 0 then
					local addExp = HeroStar_StiveChange[rarity]

					if heroId == id then
						addExp = math.floor(addExp * HeroStar_StiveChangeSelf)
					end

					local itemData = {
						exp = addExp,
						allCount = num
					}

					exp = exp + itemData.allCount * itemData.exp

					if needNum <= exp then
						return true
					end
				end
			end
		end
	else
		local fragId = heroPrototype:getConfig().ItemId
		local needNum = heroPrototype:getStarCostFragByStar(hero:getNextStarId())

		if needNum <= self._bagSystem:getItemCount(fragId) then
			return true
		end
	end

	return false
end

function HeroSystem:hasRedPointBySkill(heroId)
	local result, tip
	local var_90_0, var_90_1 = self._systemKeeper:isUnlock("Hero_Skill")

	tip = var_90_1

	if not var_90_0 then
		return false
	end

	local hero = self:getHeroById(heroId)
	local skillIds = self:getShowSkillIds(heroId)

	for i = 1, #skillIds do
		local skillId = skillIds[i]
		local skill = self:getSkillById(heroId, skillId)
		local isLock = skill:getLock()
		local level = skill:getLevel()
		local costNum = self:getSkillLevelUpCost(heroId, hero:getRarity(), skillId)
		local goldEnough = costNum <= self._developSystem:getGolds()
		local costItem = self:getSkillLevelUpItemCost(heroId, skillId)
		local hasNum = self._bagSystem:getItemCount(costItem.itemId)
		local itemEnough = hasNum >= costItem.count

		if not isLock and goldEnough and itemEnough and level < self:getSkillLevelMax() then
			return true
		end
	end

	return false
end

function HeroSystem:hasRedPointByEquip(heroId)
	local result, tip
	local var_91_0, var_91_1 = self._systemKeeper:isUnlock("Hero_Equip")

	tip = var_91_1

	if not var_91_0 then
		return false
	end

	local hero = self:getHeroById(heroId)

	if not hero then
		return false
	end

	for i = 1, #EquipPositionToType do
		local equipType = EquipPositionToType[i]

		if self:hasRedPointByEquipReplace(heroId, equipType) then
			return true
		end
	end

	return false
end

function HeroSystem:hasRedPointByTSoul(heroId)
	local result, tip
	local var_92_0, var_92_1 = self._systemKeeper:isUnlock("Projection")

	tip = var_92_1

	if not var_92_0 then
		return false
	end

	local hero = self:getHeroById(heroId)

	if not hero then
		return false
	end

	local tSoulSystem = self._developSystem:getTSoulSystem()

	if tSoulSystem:getRedPointForLevel(heroId) then
		return true
	end

	local ret = tSoulSystem:getRedPointForRarity(heroId)

	if table.indexof(ret, true) then
		return true
	end

	return false
end

function HeroSystem:hasRedPointByEquipReplace(heroId, equipType)
	if not heroId or not equipType then
		return false
	end

	local hero = self:getHeroById(heroId)
	local heroEquipId = hero:getEquipIdByType(equipType)
	local equipSystem = self._developSystem:getEquipSystem()
	local param = {
		position = equipType,
		occupation = hero:getType(),
		heroEquipId = heroEquipId,
		heroId = heroId
	}

	return (equipSystem:hasRedPointByReplace(param))
end

function HeroSystem:hasRedPointByEquipStarUp(heroId, equipType)
	if not heroId or not equipType then
		return false
	end

	local hero = self:getHeroById(heroId)
	local heroEquipId = hero:getEquipIdByType(equipType)
	local equipSystem = self._developSystem:getEquipSystem()

	return (equipSystem:hasRedPointByEquipStarUp(heroEquipId))
end

function HeroSystem:hasRedPointBySoulList(heroId)
	local hero = self:getHeroById(heroId)

	if hero == nil then
		return false
	end

	if not self._systemKeeper:isUnlock("Hero_Soul") then
		return false
	end

	local list = hero:getHeroSoulList():getSoulArray()

	for i = 1, #list do
		if list[i]:getLockState() == HeroSoulLockState.kCanUnLock then
			return true
		end
	end

	return false
end

function HeroSystem:getTeamHeroes()
	local teamHeroes = {}
	local teamList = self._developSystem:getAllUnlockTeams()

	for i = 1, #teamList do
		local heroes = teamList[i]:getHeroes()

		for j = 1, #heroes do
			teamHeroes[heroes[j]] = teamHeroes[heroes[j]] or 1
		end
	end

	return teamHeroes
end

function HeroSystem:hasRedPointInStrengthen(heroId, teamHeroes)
	local surfaceSystem = self:getInjector():getInstance(SurfaceSystem)

	if surfaceSystem:getRedPointByHeroId(heroId) then
		return true
	end

	teamHeroes = teamHeroes or self:getTeamHeroes()

	if not teamHeroes[heroId] then
		return false
	end

	for redPointType, _ in pairs(redPointFuncMap) do
		if redPointFuncMap[redPointType](self, heroId) then
			return true
		end
	end

	return false
end

function HeroSystem:checkIsShowRedPoint()
	local hasNew = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKey.kGetNewHeroRed)

	if hasNew then
		return true
	end

	for i = 1, #self._heroShowIds do
		local hero = self._heroShowIds[i]

		if hero.showType == HeroShowType.kCanComp then
			return true
		end
	end

	local teamHeroes = self:getTeamHeroes()

	for id, v in pairs(teamHeroes) do
		if self:hasRedPointInStrengthen(id) then
			return true
		end
	end

	local surfaceSystem = self:getInjector():getInstance(SurfaceSystem)

	if surfaceSystem:checkIsShowRedPoint() then
		return true
	end

	return false
end

HeroShowType = {
	kCanComp = 1,
	kHas = 2,
	kNotOwn = 3
}

function HeroSystem:sortHeroList(list)
	local sortType = self._stageSystem:getSortType()

	self:sortHeroes(list, sortType, nil, true)
end

function HeroSystem:getOwnHeroIds(ignoreSort)
	local list = {}

	for i = 1, self._ownHeroNum do
		local info = self._heroShowIds[i]

		if info and info.showType == HeroShowType.kHas then
			list[#list + 1] = info
		end

		if #list == self._ownHeroNum then
			break
		end
	end

	if not ignoreSort then
		self:onTeam()
		self:sortHeroList(list)
	end

	return list
end

function HeroSystem:onTeam()
	self._teamHeroes = {}

	local teamList = self._developSystem:getAllUnlockTeams()

	for i = 1, #teamList do
		local heroes = teamList[i]:getHeroes()

		for j = 1, #heroes do
			self._teamHeroes[heroes[j]] = self._teamHeroes[heroes[j]] or 1
		end
	end
end

function HeroSystem:getCanActiveHeroes()
	local list1, list2 = {}, {}

	for i = 1, #self._heroShowIds do
		local hero = self._heroShowIds[i]

		if hero.showType == HeroShowType.kCanComp then
			list1[#list1 + 1] = hero
		elseif hero.showType == HeroShowType.kNotOwn then
			list2[#list2 + 1] = hero
		end
	end

	self:sortHeroList(list1)
	self:sortHeroList(list2)

	return list1, list2
end

function HeroSystem:getHeroShowIdsCache()
	local list = {}
	local ownHeros = self:getHeros()

	for id, hero in pairs(ownHeros) do
		local var_103_0 = {
			combat = hero:getSceneCombatByType(SceneCombatsType.kAll),
			hp = hero:getHp(),
			def = hero:getDefense(),
			atk = hero:getAttack(),
			speed = hero:getSpeed(),
			id = id,
			star = hero:getStar(),
			quality = hero:getQuality(),
			qualityLevel = hero:getQualityLevel(),
			level = hero:getLevel(),
			showType = HeroShowType.kHas,
			cost = hero:getCost(),
			rareity = hero:getRarity(),
			ip = hero:getPopularity(),
			name = hero:getName(),
			type = hero:getType(),
			party = hero:getParty(),
			roleModel = hero:getModel(),
			loveLevel = hero:getLoveLevel(),
			littleStar = hero:getLittleStar(),
			maxStar = hero:getMaxStar()
		}

		var_103_0.fragId = hero._config and hero._config.ItemId
		var_103_0.awakenLevel = hero:getAwakenStar()
		var_103_0.identityAwakenLevel = hero:getIdentityAwakenLevel()
		var_103_0.flags = hero._config.Flags
		list[#list + 1] = var_103_0
		self._heroIdToIndex[id] = #list
	end

	self._ownHeroNum = #list

	local heroConfigIds = self:getAllHeroConfigIds()

	for i = 1, #heroConfigIds do
		local id = heroConfigIds[i]
		local heroPrototype = self:getHeroProById(id)

		if not self:getHeroById(id) and heroPrototype then
			local heroConfig = heroPrototype:getConfig()
			local model = IconFactory:getRoleModelByKey("HeroBase", id)
			local data = {
				identityAwakenLevel = 0,
				littleStar = false,
				awakenLevel = 0,
				level = 1,
				combat = heroConfig.BasicPower,
				hp = heroConfig.BaseHp,
				def = heroConfig.BaseDefence,
				atk = heroConfig.BaseAttack,
				speed = heroConfig.Speed,
				id = id,
				star = heroConfig.BaseStar,
				quality = self:getConfigByEvolution(heroConfig.BaseQualityAttr).Quality,
				showType = HeroShowType.kNotOwn,
				cost = heroConfig.Cost,
				rareity = heroConfig.Rareity,
				ip = heroConfig.Popularity,
				name = Strings:get(heroConfig.Name),
				roleModel = model,
				type = heroConfig.Type,
				party = heroConfig.Party,
				fragId = heroConfig.ItemId,
				maxStar = heroConfig.MaxStar,
				flags = heroConfig.Flags
			}

			if self:checkHeroCanComp(id) then
				data.showType = HeroShowType.kCanComp
			end

			list[#list + 1] = data
			self._heroIdToIndex[id] = #list
		end
	end

	return list
end

function HeroSystem:getHeroInfoById(heroId)
	local index = self._heroIdToIndex[heroId]

	return self._heroShowIds[index]
end

function HeroSystem:checkHeroContain(ids, id)
	if ids then
		for i = 1, #ids do
			if id == ids[i] then
				return true
			end
		end
	end

	return false
end

function HeroSystem:getTeamPrepared(teamPetIds, ownPetIds, recommendIds, maxRecommendIds)
	recommendIds = recommendIds or {}

	local ids = teamPetIds
	local ownHeros = ownPetIds
	local costTypes = {
		{},
		{},
		{}
	}

	if maxRecommendIds then
		for i = 1, #maxRecommendIds do
			local id = maxRecommendIds[i]
			local hero = self:getHeroInfoById(id)

			if hero and hero.showType == HeroShowType.kHas and not self:checkHeroContain(ids, id) then
				costTypes[1][#costTypes[1] + 1] = hero
			end
		end
	end

	for i = 1, #recommendIds do
		local id = recommendIds[i]
		local hero = self:getHeroInfoById(id)

		if hero and hero.showType == HeroShowType.kHas and not self:checkHeroContain(ids, id) then
			costTypes[2][#costTypes[2] + 1] = hero
		end
	end

	for i = 1, #ownHeros do
		local hero = self:getHeroInfoById(ownHeros[i])
		local id = hero.id

		if not self:checkHeroContain(recommendIds, id) and not self:checkHeroContain(maxRecommendIds, id) then
			costTypes[3][#costTypes[3] + 1] = hero
		end
	end

	local function heroSort(a, b)
		local sortA = a.combat * self._combatToCostRate[a.cost]
		local sortB = b.combat * self._combatToCostRate[b.cost]

		if sortA == sortB then
			return a.id > b.id
		end

		return sortB < sortA
	end

	table.sort(costTypes[1], heroSort)
	table.sort(costTypes[2], heroSort)
	table.sort(costTypes[3], heroSort)

	for i = 1, #costTypes[1] do
		ids[#ids + 1] = costTypes[1][i].id
	end

	dump(ids, "ids____111")

	for i = 1, #costTypes[2] do
		ids[#ids + 1] = costTypes[2][i].id
	end

	dump(ids, "ids____222")

	for i = 1, #costTypes[3] do
		if #costTypes[3] > 0 then
			ids[#ids + 1] = costTypes[3][1].id

			table.remove(costTypes[3], 1)
		end
	end

	dump(ids, "ids___")

	return ids
end

function HeroSystem:sortOnTeamPets(idList)
	table.sort(idList, function(a, b)
		local infoA = self:getHeroInfoById(a)
		local infoB = self:getHeroInfoById(b)

		if infoA.cost == infoB.cost then
			if infoA.rareity == infoB.rareity then
				return infoA.id < infoB.id
			end

			return infoA.rareity < infoB.rareity
		end

		return infoA.cost < infoB.cost
	end)
end

function HeroSystem:isLimitHero(list, heroId)
	for i, v in pairs(list) do
		if v == heroId then
			return 1
		end
	end

	return 0
end

function HeroSystem:sortHeroes(list, type, recommendIds, checkInTeam, tiredIds, teamType, limitList, maxRecommendIds)
	if type then
		if not HeroSortFuncs.SortFunc[type] then
			local func = HeroSortFuncs.SortFunc[9]

			if not checkInTeam then
				table.sort(list, function(a, b)
					local aInfo = self:getHeroInfoById(a.id or a)
					local bInfo = self:getHeroInfoById(b.id or b)

					if a.showType == HeroShowType.kNotOwn and b.showType == HeroShowType.kNotOwn then
						local aHasNum = self:getHeroDebrisCount(a.id)
						local bHasNum = self:getHeroDebrisCount(b.id)

						if aHasNum ~= bHasNum then
							return bHasNum < aHasNum
						end
					end

					if limitList then
						local aLimit = self:isLimitHero(limitList, (not a.id or nil) and a)
						local bLimit = self:isLimitHero(limitList, (not b.id or nil) and b)

						if aLimit ~= bLimit then
							return aLimit < bLimit
						end
					end

					if tiredIds then
						if self:checkHeroContain(tiredIds, a.id or a) then
							if not self:checkHeroContain(tiredIds, b.id or b) then
								do return false end

								goto label_112_0
							end
						end

						if not self:checkHeroContain(tiredIds, a.id or a) then
							if self:checkHeroContain(tiredIds, b.id or b) then
								return true
							end
						end
					end

					::label_112_0::

					if maxRecommendIds then
						if self:checkHeroContain(maxRecommendIds, a.id or a) then
							if not self:checkHeroContain(maxRecommendIds, b.id or b) then
								do return true end

								goto label_112_1
							end
						end

						if not self:checkHeroContain(maxRecommendIds, a.id or a) then
							if self:checkHeroContain(maxRecommendIds, b.id or b) then
								return false
							end
						end
					end

					::label_112_1::

					if recommendIds then
						if self:checkHeroContain(recommendIds, a.id or a) then
							if not self:checkHeroContain(recommendIds, b.id or b) then
								do return true end

								goto label_112_2
							end
						end

						if not self:checkHeroContain(recommendIds, a.id or a) then
							if self:checkHeroContain(recommendIds, b.id or b) then
								return false
							end
						end
					end

					::label_112_2::

					if teamType and teamType == StageTeamType.CRUSADE then
						local valueA = self._crusadeSystem:checkIsRecommend(a.id or a, aInfo).attrAddNum
						local valueB = self._crusadeSystem:checkIsRecommend(b.id or b, bInfo).attrAddNum

						if valueA ~= valueB then
							return valueB < valueA
						end
					end

					return func(aInfo, bInfo)
				end)

				return
			end

			table.sort(list, function(a, b)
				local aInfo = self:getHeroInfoById(a.id or a)
				local bInfo = self:getHeroInfoById(b.id or b)

				if a.showType == HeroShowType.kNotOwn then
					local aHasNum = self:getHeroDebrisCount(a.id)
					local bHasNum = self:getHeroDebrisCount(b.id)

					if aHasNum ~= bHasNum then
						return bHasNum < aHasNum
					end
				end

				if recommendIds then
					if self:checkHeroContain(recommendIds, a.id or a) then
						if not self:checkHeroContain(recommendIds, b.id or b) then
							do return true end

							goto label_113_0
						end
					end

					if not self:checkHeroContain(recommendIds, a.id or a) then
						if self:checkHeroContain(recommendIds, b.id or b) then
							return false
						end
					end
				end

				::label_113_0::

				local aInTeam = not not self._teamHeroes[aInfo.id]
				local bInTeam = not not self._teamHeroes[bInfo.id]

				if aInTeam == bInTeam then
					return func(aInfo, bInfo)
				end

				return aInTeam and not bInTeam
			end)
		end
	end
end

function HeroSystem:getShowHeroType()
	return self._showHeroType
end

function HeroSystem:setShowHeroType(type)
	self._showHeroType = type
end

function HeroSystem:tryEnterDate(heroId, type, ignoreTip, ignoreEnter, callback)
	assert(self:hasHero(heroId), heroId .. " 英魂未获得")

	if type == GalleryFuncName.kGift then
		local unlock, unlockTips = self._systemKeeper:isUnlock("Hero_Gift")

		if not unlock then
			if not ignoreTip then
				self:dispatch(ShowTipEvent({
					tip = unlockTips
				}))
			end

			return false
		end
	end

	if self:hasHero(heroId) then
		local hero = self:getHeroById(heroId)
		local funcUnlock = hero:getLoveModule():getFunction()

		if funcUnlock[type] then
			if funcUnlock[type][1] > hero:getLoveLevel() and funcUnlock[type][2] == 0 then
				local unlockLevel = funcUnlock[type][1]

				if not ignoreTip then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("GALLERY_UI40", {
							loveLevel = funcUnlock[type][1]
						})
					}))
				end

				return false, unlockLevel
			elseif funcUnlock[type][1] >= hero:getLoveLevel() and funcUnlock[type][2] ~= 0 then
				local unlockLevel = funcUnlock[type][1] + 1

				if not ignoreTip then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("GALLERY_UI40", {
							loveLevel = unlockLevel
						})
					}))
				end

				return false, unlockLevel
			end

			if not ignoreEnter then
				if type == GalleryFuncName.kGift then
					if callback then
						callback()
					else
						local view = self:getInjector():getInstance("GalleryPartnerInfoNewView")

						self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
							tabIndex = 2,
							id = heroId,
							type = type
						}))
					end
				elseif type == GalleryFuncName.kDate then
					local view = self:getInjector():getInstance("GalleryDateView")

					self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
						id = heroId,
						type = type
					}))
				end
			end

			return true
		end
	end
end

function HeroSystem:getNextLoveExp(heroId, loveLevel)
	local hero = self:getHeroById(heroId)
	local var_117_0 = hero:getLoveModule():getLikability()[loveLevel]

	var_117_0 = var_117_0 or 0

	return var_117_0
end

function HeroSystem:getMaxLevelCost(heroId)
	local hero = self:getHeroById(heroId)

	return hero:getMaxLevelCost()
end

function HeroSystem:isLoveLevelMax(heroId)
	local hero = self:getHeroById(heroId)

	if not hero then
		return false
	end

	if hero:getLoveLevel() == hero:getMaxLoveLevel() + 1 then
		return true
	end

	return false
end

function HeroSystem:getLoveLevelById(heroId)
	local hero = self:getHeroById(heroId)

	return hero:getLoveLevel()
end

function HeroSystem:getMaxLoveLevelById(heroId)
	local hero = self:getHeroById(heroId)

	return hero:getMaxLoveLevel()
end

function HeroSystem:getGiftItemList(heroId, sortList)
	local allEntries = self:getGiftItemEntryList()
	local list = {}

	for _, entry in pairs(allEntries) do
		local item = entry.item
		local data = {}

		data.id = item:getId()
		data.name = item:getName()
		data.itemId = item:getId()
		data.sort = item:getSort()
		data.allCount = entry.count
		data.quality = item:getQuality()
		data.exp = self:getGiftAddExpByQuality(item:getQuality()) + self:getGiftAddExpById(heroId, item:getId())
		data.eatCount = 0
		data.addExp = self:getGiftAddExpByQuality(item:getQuality())
		data.extExp = self:getGiftAddExpById(heroId, item:getId())
		list[#list + 1] = data
	end

	if sortList and #sortList > 0 then
		table.sort(list, function(a, b)
			local aId = a.id
			local bId = b.id

			if table.indexof(sortList, aId) and table.indexof(sortList, bId) then
				return table.indexof(sortList, aId) < table.indexof(sortList, bId)
			end

			return false
		end)
	end

	return list
end

function HeroSystem:getGiftAddExpByQuality(quality)
	local giftAttr = ConfigReader:getDataByNameIdAndKey("ConfigValue", "GalleryGiftAttr", "content")

	return giftAttr[tostring(quality)] or 0
end

function HeroSystem:getGiftAddExpById(heroId, itemId)
	local hero = self:getHeroById(heroId)

	return hero:getGiftAddExpById(itemId)
end

function HeroSystem:getGiftItemEntryList()
	local function filterFunc(entry)
		if entry.item and entry.count and entry.count > 0 and entry.item:getSubType() == ItemTypes.k_GALLERY_GIFT then
			return true
		end
	end

	local bagSystem = self._developSystem:getBagSystem()

	return (bagSystem:getBag():getEntries(filterFunc))
end

function HeroSystem:getHeroSoundListById(id)
	local hero = self:getHeroById(id)
	local soundList = hero:getSoundList()
	local soundObj = hero:getSounds()
	local showList = {}
	local lockList = {}
	local customSound = {}

	for i = 1, #soundList do
		local id = soundList[i]
		local sound = soundObj[id]

		if sound and sound:getIsShow() then
			local unlock = sound:getUnlock()
			local unlockDesc = ""

			if not sound:getUnlock() then
				unlock, unlockDesc = self:getSoundUnlock(hero, sound)
			end

			local text = unlock and sound:getText() or unlockDesc
			local data = {
				sound = sound,
				path = sound:getSound(),
				soundDesc = sound:getSoundDesc(),
				text = text,
				unlock = unlock
			}

			if unlock then
				showList[#showList + 1] = data
				customSound[#customSound + 1] = data.path
			else
				lockList[#lockList + 1] = data
			end
		end
	end

	local customKey = CustomDataKey.kHeroSound .. id
	local customData = self._customDataSystem:getValue(PrefixType.kGlobal, customKey)

	if not customData then
		local customValue = ""

		for i = 1, #customSound do
			customValue = i == 1 and customSound[i] or customValue .. "&" .. customSound[i]
		end

		if customValue ~= "" then
			self._customDataSystem:setValue(PrefixType.kGlobal, customKey, customValue)
		end
	end

	for i = 1, #lockList do
		showList[#showList + 1] = lockList[i]
	end

	return showList
end

function HeroSystem:getSoundUnlock(hero, sound)
	local giftTimes = hero:getGiftTimes()
	local unlock = true
	local unlockDesc = ""
	local conditions = sound:getUnlockCondition()
	local length = #conditions

	for i = 1, length do
		local condition = conditions[i]

		if condition then
			if condition.HeroLove and hero:getLoveLevel() < condition.HeroLove then
				unlock = false
				unlockDesc = Strings:get(sound:getUnlockDesc(), {
					HeroLove = condition.HeroLove
				})

				break
			end

			if condition.HeroQuality and hero:getQuality() < condition.HeroQuality then
				unlock = false

				local quality = self:getQualityName(condition.HeroQuality)

				unlockDesc = Strings:get(sound:getUnlockDesc(), {
					HeroQuality = quality
				})

				break
			end

			if condition.HeroStar and hero:getStar() < condition.HeroStar then
				unlock = false
				unlockDesc = Strings:get(sound:getUnlockDesc(), {
					HeroStar = condition.HeroStar
				})

				break
			end

			if condition.Date and hero:getDateTimes() < condition.Date then
				unlock = false
				unlockDesc = Strings:get(sound:getUnlockDesc(), {
					DateSum = condition.Date
				})

				break
			end

			if condition.LoveGift and giftTimes.love < condition.LoveGift then
				unlock = false
				unlockDesc = Strings:get(sound:getUnlockDesc(), {
					LoveGift = condition.LoveGift
				})

				break
			end

			if condition.NormalGift and giftTimes.normal < condition.NormalGift then
				unlock = false
				unlockDesc = Strings:get(sound:getUnlockDesc(), {
					NormalGift = condition.NormalGift
				})

				break
			end

			if condition.DislikeGift and giftTimes.dislike < condition.DislikeGift then
				unlock = false
				unlockDesc = Strings:get(sound:getUnlockDesc(), {
					DislikeGift = condition.DislikeGift
				})

				break
			end

			if condition.BlockPoint then
				local point = self._stageSystem:getPointById(condition.BlockPoint)

				if point and not point:isUnlock() then
					unlock = false
					unlockDesc = Strings:get(sound:getUnlockDesc(), {
						BlockPoint = Strings:get(point:getName())
					})

					break
				end
			end

			if condition.Time then
				local remoteTimestamp = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()
				local year = TimeUtil:remoteDate("*t", remoteTimestamp).year
				local date = year .. "-" .. condition.Time
				local duration = condition.duration * 60 * 60

				if condition.Time == "Birthday" then
					local birthday = self._developSystem:getPlayer():getBirthday()
					local dateTemp = string.split(birthday, "-")

					date = year .. "-" .. dateTemp[2] .. "-" .. dateTemp[3] .. "-00-00-00"
				end

				local dateTemp = string.split(date, "-")
				local startTime = TimeUtil:timeByRemoteDate({
					year = tonumber(dateTemp[1]),
					month = tonumber(dateTemp[2]),
					day = tonumber(dateTemp[3]),
					hour = tonumber(dateTemp[4]),
					min = tonumber(dateTemp[5]),
					sec = tonumber(dateTemp[6])
				})
				local endTime = startTime + duration

				if remoteTimestamp < startTime or endTime < remoteTimestamp then
					unlock = false
					unlockDesc = ""

					break
				end
			end

			if condition.StoryPoint then
				local point = self._stageSystem:getPointById(condition.StoryPoint)

				if not point or point and not point:isUnlock() then
					unlock = false
					unlockDesc = Strings:get(sound:getUnlockDesc(), {
						StoryPoint = point:getName()
					})

					break
				end
			end

			if condition.Hero then
				local heroes = condition.Hero
				local length = #heroes
				local conditionAmount = condition.Amount
				local amount = 0

				for j = 1, length do
					local heroId = heroes[j]

					if self:getHeroById(heroId) then
						amount = amount + 1

						if conditionAmount <= amount then
							break
						end
					end
				end

				if amount < conditionAmount then
					unlock = false
					unlockDesc = Strings:get(sound:getUnlockDesc(), {
						Amount = conditionAmount
					})

					local t = TextTemplate:new(unlockDesc)
					local funcMap = {
						HeroName = function(value)
							local name = ConfigReader:getDataByNameIdAndKey("HeroBase", value, "Name")

							return Strings:get(name)
						end
					}

					unlockDesc = t:stringify(condition, funcMap)

					break
				end
			end
		end
	end

	sound:setUnlock(unlock)

	return unlock, unlockDesc
end

function HeroSystem:hasHeroAwake(heroId)
	local hero = self:getHeroById(heroId)

	if hero then
		return hero:heroAwaked()
	end

	return false
end

function HeroSystem:requestHeroLvlUp(heroId, items, callback)
	local heroService = self:getInjector():getInstance(HeroService)
	local data = {
		heroId = heroId,
		items = items
	}

	heroService:requestHeroLvlUp(data, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_HEROLEVELUP_SUCC, 1))
		end
	end)
end

function HeroSystem:requestHeroStarUp(params, callback)
	local heroService = self:getInjector():getInstance(HeroService)
	local data = {
		heroId = params.heroId,
		items = params.items
	}

	heroService:requestHeroStarUp(data, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:resetHeroStarUpItem()

			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_HEROSTARUP_SUCC, data.heroId))
		end
	end)
end

function HeroSystem:requestSelectStarUpReward(params, callback)
	local heroService = self:getInjector():getInstance(HeroService)
	local data = {
		heroId = params.heroId,
		star = params.star,
		itemId = params.itemId
	}

	heroService:requestSelectStarUpReward(data, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_HEROSTARUP_BOX_SUCC, response))
		end
	end)
end

function HeroSystem:requestHeroEvolutionUp(heroId, callback)
	local heroService = self:getInjector():getInstance(HeroService)
	local data = {
		heroId = heroId
	}

	heroService:requestHeroEvolutionUp(data, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_HEROEVOLUTIONLUP_SUCC, heroId))
		end
	end)
end

function HeroSystem:requestHeroReborn(heroId, callback)
	local heroService = self:getInjector():getInstance(HeroService)
	local data = {
		heroId = heroId
	}

	heroService:requestHeroReborn(data, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_HEROREBORN_SUCC, response))
		end
	end)
end

function HeroSystem:requestHeroSkillLvlUp(heroId, skillId, callback)
	local heroService = self:getInjector():getInstance(HeroService)
	local data = {
		heroId = heroId,
		skillId = skillId
	}

	heroService:requestHeroSkillLvlUp(data, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Tips_3010022")
			}))
			self:dispatch(Event:new(EVT_HEROSKILLUP_SUCC, heroId))
		end
	end)
end

function HeroSystem:requestHeroSkillUpTen(params)
	local heroService = self:getInjector():getInstance(HeroService)
	local data = {
		heroId = params.heroId,
		skillType = params.skillType
	}

	heroService:requestHeroSkillUpTen(data, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Tips_3010022")
			}))
			self:dispatch(Event:new(EVT_HEROSKILLUP_SUCC, heroId))
		end
	end)
end

function HeroSystem:requestHeroAdvanceLvlUp(heroId, callback)
	local param = {
		heroId = heroId
	}
	local heroService = self:getInjector():getInstance(HeroService)

	heroService:requestHeroAdvanceLvlUp(param, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Tips_3010018")
			}))
			self:dispatch(Event:new(EVT_HEROADVANCEUP_SUCC, heroId))

			if callback then
				callback()
			end
		end
	end)
end

function HeroSystem:requestHeroStrengthenData(heroId, callback)
	local heroService = self:getInjector():getInstance(HeroService)
	local data = {
		heroId = heroId
	}

	heroService:requestHeroStrengthenData(data, true, function(response)
		if response.resCode == GS_SUCCESS then
			-- block empty
		end
	end)
end

function HeroSystem:requestRelationUnlock(heroId, relationId, index, func)
	local info = {
		heroId = heroId,
		relationId = relationId
	}
	local heroService = self:getInjector():getInstance(HeroService)

	heroService:requestRelationUnlock(info, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_HERORELATION_LEVELUP_SUCC))

			if func then
				func(index)
			end
		end
	end)
end

function HeroSystem:requestRelationLvlUp(heroId, relationId, index, func)
	local info = {
		heroId = heroId,
		relationId = relationId
	}
	local heroService = self:getInjector():getInstance(HeroService)

	heroService:requestRelationLvlUp(info, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_HERORELATION_LEVELUP_SUCC))

			if func then
				func(index)
			end
		end
	end)
end

function HeroSystem:requestHeroRelation(data, extraData)
	if data.id then
		self:findHeroRelationShare(data.id)
	end
end

function HeroSystem:sendRelationChatMessage(chatTabType, relationId, heroId)
	chatTabType = chatTabType or ChatTabType.kWorld

	local chatSystem = self:getInjector():getInstance("ChatSystem")
	local chat = chatSystem:getChat()
	local channelId = TabTypeToChannelId[chatTabType]
	local channel = chat:getChannel(channelId)

	if channel == nil then
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = Strings:get("Chat_Text8")
		}))

		return
	end

	local tipTextMap = {
		[ChannelId.kUnion] = "Chat_Text7",
		[ChannelId.kTeam] = "Chat_Text6"
	}
	local roomType, roomId = channel:getRoomTypeAndId(self:getInjector())

	if roomType == nil or roomId == nil then
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = Strings:get(tipTextMap[channel:getId()])
		}))

		return
	end

	local messageData = {}

	messageData.channelIds = {
		channelId
	}
	messageData.sender = self._developSystem:getPlayer():getRid()
	messageData.time = self:getInjector():getInstance("GameServerAgent"):remoteTimeMillis()
	messageData.type = MessageType.kPlayer
	messageData.contentId = "Announce_Relation"
	messageData.params = {
		heroId = heroId,
		id = relationId
	}

	chatSystem:requestSendMessage(roomType, roomId, messageData, function(data)
		self:dispatch(ShowTipEvent({
			tip = Strings:get("RelationText10")
		}))
		chatSystem:updateActiveMember()

		local message = chat:syncMessage(messageData)

		message:sync(data)
	end)
end

function HeroSystem:shareHeroRelation(heroId, chatTabType)
	local info = {
		heroId = heroId
	}
	local heroService = self:getInjector():getInstance(HeroService)

	heroService:shareHeroRelation(info, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:sendRelationChatMessage(chatTabType, response.data, heroId)
		end
	end)
end

function HeroSystem:findHeroRelationShare(id)
	local info = {
		id = id
	}
	local heroService = self:getInjector():getInstance(HeroService)

	heroService:findHeroRelationShare(info, true, function(response)
		if response.resCode == GS_SUCCESS then
			local cjson = require("cjson.safe")
			local data = cjson.decode(response.data)
			local view = self:getInjector():getInstance("HeroRelationChatView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
				viewData = data
			}))
		end
	end)
end

function HeroSystem:requestSoulUnlock(heroId, soulId)
	local info = {
		heroId = heroId,
		soulId = soulId
	}
	local heroService = self:getInjector():getInstance(HeroService)

	heroService:requestSoulUnlock(info, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_SOULUNLOCK_SUCC))
		end
	end)
end

function HeroSystem:requestSoulUpByItem(heroId, soulId, items, callFunc)
	local info = {
		heroId = heroId,
		soulId = soulId,
		items = items
	}
	local heroService = self:getInjector():getInstance(HeroService)

	heroService:requestSoulUpByItem(info, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Tips_3010021")
			}))
			self:dispatch(Event:new(EVT_SOULUPBYITEM_SUCC))

			if callFunc then
				callFunc()
			end
		end
	end)
end

function HeroSystem:requestSoulUpByDiamond(heroId, soulId, level, callFunc)
	local info = {
		heroId = heroId,
		soulId = soulId,
		toLv = level
	}
	local heroService = self:getInjector():getInstance(HeroService)

	heroService:requestSoulUpByDiamond(info, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_SOULUPBYDIMOND_SUCC))

			if callFunc then
				callFunc()
			end
		end
	end)
end

function HeroSystem.class:createRedPointImg(parent)
	local img = RedPoint:createDefaultNode()

	img:addTo(parent)
	ccext.positeWithRelPosition(img, parent:getContentSize(), {
		1,
		1
	})

	return img
end

function HeroSystem:requestHeroAwake(heroId, items, callFunc)
	local info = {
		heroId = heroId,
		items = items
	}
	local heroService = self:getInjector():getInstance(HeroService)

	heroService:requestHeroAwake(info, true, function(response)
		if response.resCode == GS_SUCCESS and callFunc then
			callFunc(response)
		end
	end)
end

function HeroSystem:setAwakeHeroFragIdAndDebrisCostCount(heroID, count)
	local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(heroID)

	self._awakeHeroFragId = heroPrototype:getConfig().ItemId
	self._awakeDebrisCostCount = count
end

function HeroSystem:getAwakeHeroFragIdAndDebrisCostCount()
	if self._awakeDebrisCostCount and self._awakeHeroFragId then
		return self._awakeHeroFragId, self._awakeDebrisCostCount
	end

	return "", 0
end

function HeroSystem:cleanAwakeHeroFragIdAndDebrisCostCount()
	self._awakeDebrisCostCount = 0
	self._awakeHeroFragId = ""
end

function HeroSystem:isLinkStageHero(heroId)
	if self._linkHeroMap == nil then
		self._linkHeroMap = {}

		local Hero_Linkage = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Linkage", "content")

		for i = 1, #Hero_Linkage do
			self._linkHeroMap[Hero_Linkage[i]] = 1
		end
	end

	return not not self._linkHeroMap[heroId]
end

function HeroSystem:tryEnterAwakenShowView(heroId)
	local view = self:getInjector():getInstance("HeroStrengthAwakenView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		fromAlbum = true,
		heroId = heroId
	}))
end

function HeroSystem:checkHaveAwaken(heroId)
	local awakenStarConfig = ConfigReader:getRecordById("HeroAwaken", heroId)

	if awakenStarConfig and awakenStarConfig.StarId then
		return true
	end

	return false
end

function HeroSystem:requestHeroIdentityAwake(heroId, items, callFunc)
	local info = {
		heroId = heroId,
		items = items
	}
	local heroService = self:getInjector():getInstance(HeroService)

	heroService:requestHeroIdentityAwake(info, true, function(response)
		if response.resCode == GS_SUCCESS and callFunc then
			callFunc(response)
		end
	end)
end

function HeroSystem:getHeroIdentityAwakeRedpoint(heroId)
	local heroData = self:getHeroById(heroId)
	local heroPrototype = heroData:getHeroPrototype()

	if heroData:heroAwaked() and heroData:canIdentityAwake() and heroData:getNextIdentityStarId() ~= "" then
		local loveNeed = heroData:getIdentityAwakenNeedLove()
		local hasloveLevel = heroData:getLoveLevel()
		local hasDebrisNum = self:getHeroDebrisCount(heroId)
		local needDebrisNum = heroPrototype:getStarCostFragByStar(heroData:getNextIdentityStarId())

		if loveNeed <= hasloveLevel and needDebrisNum <= hasDebrisNum then
			return true
		end
	end

	return false
end
