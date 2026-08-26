-- chunkname: @modules/logic/herogroup/model/HeroGroupTrialModel.lua

module("modules.logic.herogroup.model.HeroGroupTrialModel", package.seeall)

local HeroGroupTrialModel = class("HeroGroupTrialModel", BaseModel)

function HeroGroupTrialModel:ctor()
	self.curBattleId = nil
	self._limitNum = 0
	self._trialEquipMo = BaseModel.New()

	HeroGroupTrialModel.super.ctor(self)
end

function HeroGroupTrialModel:setTrialByBattleId(battleId)
	battleId = battleId or HeroGroupModel.instance.battleId

	if self.curBattleId == battleId then
		return
	end

	self.curBattleId = battleId

	local battleCO = lua_battle.configDict[battleId]

	if not battleCO then
		return
	end

	self._trialEquipMo:clear()
	HeroGroupTrialModel.super.clear(self)

	local curBattleTrialHeros = battleCO.trialHeros

	if HeroGroupModel.instance.episodeId and battleId == HeroGroupModel.instance.battleId then
		curBattleTrialHeros = HeroGroupHandler.getTrialHeros(HeroGroupModel.instance.episodeId)
	end

	if not string.nilorempty(curBattleTrialHeros) then
		local trials = GameUtil.splitString2(curBattleTrialHeros, true)

		for _, trial in pairs(trials) do
			local trialId = trial[1]

			if not trial[2] then
				local templateId = 0

				if lua_hero_trial.configDict[trialId] then
					local co = lua_hero_trial.configDict[trialId][templateId]

					if co then
						local heroMo = HeroMo.New()

						heroMo:initFromTrial(unpack(trial))
						self:addAtLast(heroMo)
					else
						logError(string.format("试用角色配置不存在:%s#%s", trialId, templateId))
					end
				end
			end
		end
	end

	if not string.nilorempty(battleCO.trialEquips) then
		local trials = string.splitToNumber(battleCO.trialEquips, "|")

		for _, trial in pairs(trials) do
			local co = lua_equip_trial.configDict[trial]

			if co then
				local equipMO = EquipMO.New()

				equipMO:initByTrialEquipCO(co)
				self._trialEquipMo:addAtLast(equipMO)
			else
				logError("试用心相配置不存在" .. tostring(trial))
			end
		end
	end

	self._limitNum = battleCO.trialLimit

	local addTrialList = ToughBattleModel.instance:getAddTrialHeros()

	if addTrialList then
		self._limitNum = math.min(4, #addTrialList + self._limitNum)

		for index, id in pairs(addTrialList) do
			local heroMo = HeroMo.New()

			heroMo:initFromTrial(id)
			self:addAtLast(heroMo)
		end
	end
end

function HeroGroupTrialModel:setTrialByOdysseyGroupMo(groupMo)
	self:clear()

	self._limitNum = 1

	if groupMo.trialDict then
		for pos, trialMo in pairs(groupMo.trialDict) do
			local trialId = trialMo[1]

			if trialId ~= nil and trialId ~= 0 then
				local heroMo = HeroMo.New()

				heroMo:initFromTrial(trialId, 0, pos)
				self:addAtLast(heroMo)

				local trialCo = lua_hero_trial.configDict[trialId][0]
				local equipMO = EquipMO.New()

				equipMO:initByTrialCO(trialCo)
				self._trialEquipMo:addAtLast(equipMO)
			end
		end
	end
end

function HeroGroupTrialModel:setTrailByTrialIdList(trialIdList, limitNum)
	self:clear()

	self._limitNum = limitNum or self._limitNum

	if trialIdList then
		for _, trialId in ipairs(trialIdList) do
			self:addTrialHero(trialId)
		end
	end
end

function HeroGroupTrialModel:addTrialHero(trialId, templateId)
	if not trialId or trialId == 0 then
		return
	end

	templateId = templateId or 0

	local heroMo = HeroMo.New()

	heroMo:initFromTrial(trialId, templateId)
	self:addAtLast(heroMo)

	local trialCo = lua_hero_trial.configDict[trialId][templateId]
	local equipMO = EquipMO.New()

	equipMO:initByTrialCO(trialCo)
	self._trialEquipMo:addAtLast(equipMO)
end

local isLevelFirst = false
local isAsc = false

function HeroGroupTrialModel:sortByLevelAndRare(levelFirst, asc)
	isLevelFirst = levelFirst
	isAsc = asc

	self:sort(HeroGroupTrialModel.sortMoFunc)
end

function HeroGroupTrialModel.sortMoFunc(a, b)
	if isLevelFirst then
		if a.level ~= b.level then
			if isAsc then
				return a.level < b.level
			else
				return a.level > b.level
			end
		elseif a.config.rare ~= b.config.rare then
			return a.config.rare > b.config.rare
		end
	elseif a.config.rare ~= b.config.rare then
		if isAsc then
			return a.config.rare < b.config.rare
		else
			return a.config.rare > b.config.rare
		end
	elseif a.level ~= b.level then
		return a.level > b.level
	end

	return a.config.id < b.config.id
end

function HeroGroupTrialModel:setFilter(dmgs, careers)
	self._filterDmgs = dmgs
	self._filterCareers = careers
end

function HeroGroupTrialModel:getFilterList()
	self:checkBattleIdIsVaild()

	local selectTags = CharacterSearchFilterModel.instance:getSelectLocalTags()
	local dmgDict = {}
	local careerDict = {}
	local tagDict = {}

	if self._filterCareers then
		for _, career in ipairs(self._filterCareers) do
			careerDict[career] = true
		end
	end

	if self._filterDmgs then
		for _, dmg in ipairs(self._filterDmgs) do
			dmgDict[dmg] = true
		end
	end

	if selectTags then
		for _, tagList in pairs(selectTags) do
			for _, tagId in ipairs(tagList) do
				tagDict[tagId] = true
			end
		end
	end

	local isFilterCareer = next(careerDict) ~= nil
	local isFilterDmg = next(dmgDict) ~= nil
	local isFilterTag = next(tagDict) ~= nil
	local list = {}
	local heroList = self:getList()

	for _, mo in ipairs(heroList) do
		if (not isFilterCareer or careerDict[mo.config.career]) and (not isFilterDmg or dmgDict[mo.config.dmgType]) and (not isFilterTag or self:_isFilterTag(tagDict, mo)) then
			table.insert(list, mo)
		end
	end

	return list
end

function HeroGroupTrialModel:_isFilterTag(tagDict, heroMo)
	local battleTag = heroMo:getHeroBattleTag()
	local battleTags = string.split(battleTag, "#")

	for _, tagId in ipairs(battleTags) do
		if tagDict[tagId] then
			return true
		end
	end

	return false
end

function HeroGroupTrialModel:clear()
	self.curBattleId = nil
	self._limitNum = 0

	self._trialEquipMo:clear()
	HeroGroupTrialModel.super.clear(self)
end

function HeroGroupTrialModel:getLimitNum()
	self:checkBattleIdIsVaild()

	return self._limitNum
end

function HeroGroupTrialModel:getHeroMo(trialCo)
	return self:getById(tostring(tonumber(trialCo.id .. "." .. trialCo.trialTemplate) - 1099511627776))
end

function HeroGroupTrialModel:getEquipMo(equipUid)
	return self._trialEquipMo:getById(tonumber(equipUid))
end

function HeroGroupTrialModel:getTrialEquipList()
	return self._trialEquipMo:getList()
end

function HeroGroupTrialModel:checkBattleIdIsVaild()
	if self.curBattleId and HeroGroupModel.instance.battleId and HeroGroupModel.instance.battleId > 0 and self.curBattleId ~= HeroGroupModel.instance.battleId then
		self:clear()
	end
end

function HeroGroupTrialModel:isOnlyUseTrial()
	self:checkBattleIdIsVaild()

	if not self.curBattleId then
		return false
	end

	local battleCO = lua_battle.configDict[self.curBattleId]

	return self._limitNum > 0 and battleCO.onlyTrial == 1
end

function HeroGroupTrialModel:haveTrialEquip()
	self:checkBattleIdIsVaild()

	return self._trialEquipMo:getCount() > 0
end

HeroGroupTrialModel.instance = HeroGroupTrialModel.New()

return HeroGroupTrialModel
