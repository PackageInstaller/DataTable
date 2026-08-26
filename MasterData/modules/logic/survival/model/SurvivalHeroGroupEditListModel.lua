-- chunkname: @modules/logic/survival/model/SurvivalHeroGroupEditListModel.lua

module("modules.logic.survival.model.SurvivalHeroGroupEditListModel", package.seeall)

local SurvivalHeroGroupEditListModel = class("SurvivalHeroGroupEditListModel", HeroGroupEditListModel)

function SurvivalHeroGroupEditListModel:copyCharacterCardList(init)
	local moList
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local inSurvival = weekInfo.inSurvival
	local teamInfo

	if HeroGroupTrialModel.instance:isOnlyUseTrial() then
		moList = {}
	elseif inSurvival then
		teamInfo = SurvivalMapModel.instance:getSceneMo().teamInfo
		moList = {}

		local hero = CharacterBackpackCardListModel.instance:getCharacterCardList()

		if hero then
			for i, heroMo in ipairs(hero) do
				local uid = heroMo.uid
				local have

				for id in pairs(teamInfo.heroUids) do
					if id == uid then
						have = true

						break
					end
				end

				if have then
					table.insert(moList, (teamInfo:getHeroMo(uid)))
				end
			end
		end
	else
		moList = CharacterBackpackCardListModel.instance:getCharacterCardList()
	end

	local newMOList = {}
	local repeatHero = {}

	self._inTeamHeroUids = {}

	local selectIndex = 1
	local index = 1
	local alreadyList = HeroSingleGroupModel.instance:getList()

	for i, heroSingleGroupMO in ipairs(alreadyList) do
		if heroSingleGroupMO.trial or not heroSingleGroupMO.aid and tonumber(heroSingleGroupMO.heroUid) > 0 and not repeatHero[heroSingleGroupMO.heroUid] then
			if heroSingleGroupMO.trial then
				table.insert(newMOList, HeroGroupTrialModel.instance:getById(heroSingleGroupMO.heroUid))
			elseif inSurvival then
				table.insert(newMOList, (teamInfo:getHeroMo(heroSingleGroupMO.heroUid)))
			else
				table.insert(newMOList, HeroModel.instance:getById(heroSingleGroupMO.heroUid))
			end

			if self.specialHero == heroSingleGroupMO.heroUid then
				self._inTeamHeroUids[heroSingleGroupMO.heroUid] = 2
				selectIndex = index
			else
				self._inTeamHeroUids[heroSingleGroupMO.heroUid] = 1
				index = index + 1
			end

			repeatHero[heroSingleGroupMO.heroUid] = true
		end
	end

	local state = CharacterModel.instance:getRankState()
	local tag = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.HeroGroup)

	HeroGroupTrialModel.instance:sortByLevelAndRare(tag == 1, state[tag] == 1)

	local trialList = HeroGroupTrialModel.instance:getFilterList()

	for i, heroMo in ipairs(trialList) do
		if not repeatHero[heroMo.uid] then
			table.insert(newMOList, heroMo)
		end
	end

	for i, mo in ipairs(newMOList) do
		if self._moveHeroId and mo.heroId == self._moveHeroId then
			self._moveHeroId = nil
			self._moveHeroIndex = i

			break
		end
	end

	local deathList = {}

	for i, mo in ipairs(moList) do
		if not repeatHero[mo.uid] then
			repeatHero[mo.uid] = true

			local healthMo = weekInfo:getHeroMo(mo.heroId)

			if healthMo.health <= 0 or self:getSelectByIndex(mo.heroId) ~= nil then
				table.insert(deathList, mo)
			else
				table.insert(newMOList, mo)
			end
		end
	end

	tabletool.addValues(newMOList, deathList)
	self:setList(newMOList)

	if init and #newMOList > 0 and selectIndex > 0 and #self._scrollViews > 0 then
		for _, view in ipairs(self._scrollViews) do
			view:selectCell(selectIndex, true)
		end

		if newMOList[selectIndex] then
			return newMOList[selectIndex]
		end
	end
end

function SurvivalHeroGroupEditListModel:getSelectByIndex(heroId)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local inSurvival = weekInfo.inSurvival

	if not inSurvival then
		local fight = weekInfo:getMonsterFight()

		return (fight:getUseRoundByHeroId(heroId))
	end

	return nil
end

SurvivalHeroGroupEditListModel.instance = SurvivalHeroGroupEditListModel.New()

return SurvivalHeroGroupEditListModel
