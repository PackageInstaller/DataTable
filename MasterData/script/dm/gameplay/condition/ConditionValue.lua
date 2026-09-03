-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/condition/ConditionValue.lua

ConditionValue = class("ConditionValue", legs.Actor)

function ConditionValue:initialize(conditionkeeper)
	super.initialize(self)

	self._conditionkeeper = conditionkeeper

	self:register()
end

function ConditionValue:register()
	self._conditionkeeper:registerConditionValueFunc("bagBoxCount", self.getBagBoxCount)
	self._conditionkeeper:registerConditionValueFunc("bag.IR_ArtiUp", self.getItemCount)
	self._conditionkeeper:registerConditionValueFunc("bag.IM_SectUp", self.getItemCount)
	self._conditionkeeper:registerConditionValueFunc("teamHeroLevel_playerLevel", self.getDifferForTeamHeroLevelAndPlayerLevel)
	self._conditionkeeper:registerConditionValueFunc("teamHeroCanQualityup", self.getTeamHeroCanQualityupCount)
	self._conditionkeeper:registerConditionValueFunc("teamHeroSkill_playerLevel", self.getDifferForTeamHeroSkillLevelAndPlayerLevel)
	self._conditionkeeper:registerConditionValueFunc("heroEquip_playerLevel", self.getDifferForTeamHeroEquipLevelAndPlayerLevel)
	self._conditionkeeper:registerConditionValueFunc("teamHeroEquipCanQualityUp", self.getTeamHeroEquipCanQualityUp)
	self._conditionkeeper:registerConditionValueFunc("unfinishedDailyTask", self.getUnfinishDailyTaskCount)
	self._conditionkeeper:registerConditionValueFunc("towerCurrFloor", self.getTowerCurFloorCount)
	self._conditionkeeper:registerConditionValueFunc("arenaChallangeTimes", self.getArenaChallengeTimes)
end

function ConditionValue:getBagBoxCount()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local bagSystem = developSystem:getBagSystem()
	local count = 0
	local allEntryIds = bagSystem:getAllEntryIds()

	for _, entryId in ipairs(allEntryIds) do
		local entry = bagSystem:getEntryById(entryId)

		if entry and entry.item and (entry.item:getType() == ItemTypes.K_BOX_SELECT or entry.item:getType() == ItemTypes.K_BOX_RANDOM) then
			count = count + entry.count
		end
	end

	return count
end

function ConditionValue:getItemCount(id)
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local bagSystem = developSystem:getBagSystem()
	local arr = string.split(id, ".")
	local entry = bagSystem:getEntryById(arr[2])

	return (entry or nil) and (entry.count or 0)
end

function ConditionValue:getUnfinishDailyTaskCount()
	local taskSystem = self:getInjector():getInstance(TaskSystem)

	return taskSystem:getTaskListModel():getUnFinishedDailyTaskCount()
end

function ConditionValue:getArenaChallengeTimes()
	local strongSystem = self:getInjector():getInstance(StrongSystem)

	return strongSystem:getArenaRamainTimes()
end

function ConditionValue:getTowerCurFloorCount()
	local strongSystem = self:getInjector():getInstance(StrongSystem)

	return strongSystem:getTowerIndex()
end

function ConditionValue:getDifferForTeamHeroLevelAndPlayerLevel()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local array = {}
	local team = developSystem:getTeamBook():activeTeam(TeamType.kMain)
	local playerLevel = developSystem:getPlayer():getLevel()

	for i = 1, 9 do
		local hero = team:getMemberHero(i)

		if hero then
			array[#array + 1] = playerLevel - hero:getLevel()
		end
	end

	return array
end

function ConditionValue:getTeamHeroCanQualityupCount()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local heroSystem = developSystem:getHeroSystem()
	local count = 0
	local playerLevel = developSystem:getPlayer():getLevel()
	local team = developSystem:getTeamBook():activeTeam(TeamType.kMain)

	for i = 1, 9 do
		local hero = team:getMemberHero(i)

		if hero and heroSystem:hasRedPointByEvolution(hero:getId()) then
			count = count + 1
		end
	end

	return count
end

function ConditionValue:getDifferForTeamHeroSkillLevelAndPlayerLevel()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local heroSystem = developSystem:getHeroSystem()
	local skillSystem = developSystem:getSkillSystem()
	local array = {}
	local playerLevel = developSystem:getPlayer():getLevel()
	local team = developSystem:getTeamBook():activeTeam(TeamType.kMain)

	for i = 1, 9 do
		local hero = team:getMemberHero(i)

		if hero then
			local skills = skillSystem:getShowSkillDatas(hero:getId())

			for i = 1, #skills do
				local skillData = skills[i]

				if not skillData.isLock then
					array[#array + 1] = playerLevel - skillData.level
				end
			end
		end
	end

	return array
end

function ConditionValue:getDifferForTeamHeroEquipLevelAndPlayerLevel()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local equipSystem = developSystem:getEquipSystem()
	local array = {}
	local playerLevel = developSystem:getPlayer():getLevel()
	local team = developSystem:getTeamBook():activeTeam(TeamType.kMain)

	for i = 1, 9 do
		local hero = team:getMemberHero(i)

		if hero then
			local equipList = equipSystem:getEquipList(hero:getId())

			for equipId, equipData in pairs(equipList) do
				array[#array + 1] = playerLevel - equipData:getLevel()
			end
		end
	end

	return array
end

function ConditionValue:getTeamHeroEquipCanQualityUp()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local equipSystem = developSystem:getEquipSystem()
	local count = 0
	local team = developSystem:getTeamBook():activeTeam(TeamType.kMain)

	for i = 1, 9 do
		local hero = team:getMemberHero(i)

		if hero then
			local equipList = equipSystem:getEquipList(hero:getId())

			for equipId, equipData in pairs(equipList) do
				if equipSystem:hasSingleEquipRedPointByQuality(hero:getId(), equipId) then
					count = count + 1
				end
			end
		end
	end

	return count
end
