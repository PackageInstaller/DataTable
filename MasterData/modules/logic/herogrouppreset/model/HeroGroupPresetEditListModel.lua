-- chunkname: @modules/logic/herogrouppreset/model/HeroGroupPresetEditListModel.lua

module("modules.logic.herogrouppreset.model.HeroGroupPresetEditListModel", package.seeall)

local HeroGroupPresetEditListModel = class("HeroGroupPresetEditListModel", ListScrollModel)

function HeroGroupPresetEditListModel:setMoveHeroId(id)
	self._moveHeroId = id
end

function HeroGroupPresetEditListModel:getMoveHeroIndex()
	return self._moveHeroIndex
end

function HeroGroupPresetEditListModel:copyCharacterCardList(init)
	local moList = HeroGroupTrialModel.instance:isOnlyUseTrial() and {} or CharacterBackpackCardListModel.instance:getCharacterCardList()
	local newMOList = {}
	local repeatHero = {}

	self._inTeamHeroUids = {}

	local selectIndex = 1
	local index = 1
	local alreadyList = HeroGroupPresetSingleGroupModel.instance:getList()

	for i, heroSingleGroupMO in ipairs(alreadyList) do
		local heroUid = heroSingleGroupMO.heroUid
		local isTrial = heroSingleGroupMO.trial

		if not HeroGroupPresetController.instance:useTrial() then
			isTrial = false

			if tonumber(heroUid) < 0 then
				heroUid = "0"
			end
		end

		if isTrial or not heroSingleGroupMO.aid and tonumber(heroUid) > 0 and not repeatHero[heroUid] then
			if isTrial then
				table.insert(newMOList, HeroGroupTrialModel.instance:getById(heroUid))
			else
				table.insert(newMOList, HeroModel.instance:getById(heroUid))
			end

			if self.specialHero == heroUid then
				self._inTeamHeroUids[heroUid] = 2
				selectIndex = index
			else
				self._inTeamHeroUids[heroUid] = 1
				index = index + 1
			end

			repeatHero[heroUid] = true
		end
	end

	local state = CharacterModel.instance:getRankState()
	local tag = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.HeroGroup)

	HeroGroupTrialModel.instance:sortByLevelAndRare(tag == 1, state[tag] == 1)

	if HeroGroupPresetController.instance:useTrial() then
		local trialList = HeroGroupTrialModel.instance:getFilterList()

		for i, heroMo in ipairs(trialList) do
			if not repeatHero[heroMo.uid] then
				table.insert(newMOList, heroMo)
			end
		end
	end

	for i, mo in ipairs(newMOList) do
		if self._moveHeroId and mo.heroId == self._moveHeroId then
			self._moveHeroId = nil
			self._moveHeroIndex = i

			break
		end
	end

	local groupHeroNum = #newMOList
	local isTowerBattle = self.isTowerBattle
	local isWeekWalk_2 = self.isWeekWalk_2
	local isAbyss = self.isAbyss
	local deathList = {}

	if isTowerBattle then
		for i = #newMOList, 1, -1 do
			if TowerModel.instance:isHeroBan(newMOList[i].heroId) then
				table.insert(deathList, newMOList[i])
				table.remove(newMOList, i)
			end
		end
	end

	for i, mo in ipairs(moList) do
		if not repeatHero[mo.uid] then
			repeatHero[mo.uid] = true

			if self.adventure then
				local cd = WeekWalkModel.instance:getCurMapHeroCd(mo.heroId)

				if cd > 0 then
					table.insert(deathList, mo)
				else
					table.insert(newMOList, mo)
				end
			elseif isWeekWalk_2 then
				local cd = WeekWalk_2Model.instance:getCurMapHeroCd(mo.heroId)

				if cd > 0 then
					table.insert(deathList, mo)
				else
					table.insert(newMOList, mo)
				end
			elseif isTowerBattle then
				if TowerModel.instance:isHeroBan(mo.heroId) then
					table.insert(deathList, mo)
				else
					table.insert(newMOList, mo)
				end
			elseif isAbyss then
				if AbyssModel.instance:isCurHeroLocked(mo.heroId) then
					table.insert(deathList, mo)
				else
					table.insert(newMOList, mo)
				end
			elseif self._moveHeroId and mo.heroId == self._moveHeroId then
				self._moveHeroId = nil
				self._moveHeroIndex = groupHeroNum + 1

				table.insert(newMOList, self._moveHeroIndex, mo)
			else
				table.insert(newMOList, mo)
			end
		end
	end

	if self.adventure or isTowerBattle or isWeekWalk_2 or isAbyss then
		tabletool.addValues(newMOList, deathList)
	end

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

function HeroGroupPresetEditListModel:isRepeatHero(heroId, uid)
	if not self._inTeamHeroUids then
		return false
	end

	for inTeamUid in pairs(self._inTeamHeroUids) do
		local mo = self:getById(inTeamUid)

		if not mo then
			logError("heroId:" .. heroId .. ", " .. "uid:" .. uid .. "数据为空")

			return false
		end

		if mo.heroId == heroId and uid ~= mo.uid then
			return true
		end
	end

	return false
end

function HeroGroupPresetEditListModel:isTrialLimit()
	if not self._inTeamHeroUids then
		return false
	end

	local curNum = 0

	for inTeamUid in pairs(self._inTeamHeroUids) do
		local mo = self:getById(inTeamUid)

		if mo:isTrial() then
			curNum = curNum + 1
		end
	end

	return curNum >= HeroGroupTrialModel.instance:getLimitNum()
end

function HeroGroupPresetEditListModel:cancelAllSelected()
	if self._scrollViews then
		for _, view in ipairs(self._scrollViews) do
			local mo = view:getFirstSelect()
			local index = self:getIndex(mo)

			view:selectCell(index, false)
		end
	end
end

function HeroGroupPresetEditListModel:isInTeamHero(uid)
	return self._inTeamHeroUids and self._inTeamHeroUids[uid]
end

function HeroGroupPresetEditListModel:setParam(heroUid, adventure, isTowerBattle, groupType)
	self.specialHero = heroUid
	self.adventure = adventure
	self.isTowerBattle = isTowerBattle
	self._groupType = groupType
	self.isWeekWalk_2 = groupType == HeroGroupEnum.GroupType.WeekWalk_2
	self.isAbyss = groupType == HeroGroupEnum.GroupType.Abyss
end

HeroGroupPresetEditListModel.instance = HeroGroupPresetEditListModel.New()

return HeroGroupPresetEditListModel
