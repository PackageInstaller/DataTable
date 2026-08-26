-- chunkname: @modules/logic/herogrouppreset/model/HeroGroupPresetQuickEditListModel.lua

module("modules.logic.herogrouppreset.model.HeroGroupPresetQuickEditListModel", package.seeall)

local HeroGroupPresetQuickEditListModel = class("HeroGroupPresetQuickEditListModel", ListScrollModel)

function HeroGroupPresetQuickEditListModel:copyQuickEditCardList()
	local moList = HeroGroupTrialModel.instance:isOnlyUseTrial() and {} or CharacterBackpackCardListModel.instance:getCharacterCardList()
	local newMOList = {}
	local repeatHero = {}

	self._inTeamHeroUidMap = {}
	self._inTeamHeroUidList = {}
	self._originalHeroUidList = {}
	self._selectUid = nil

	local alreadyList = HeroGroupPresetSingleGroupModel.instance:getList()

	for pos, heroSingleGroupMO in ipairs(alreadyList) do
		local posOpen = HeroGroupPresetModel.instance:isPositionOpen(pos)
		local heroUid = heroSingleGroupMO.heroUid

		if not HeroGroupPresetController.instance:useTrial() and tonumber(heroUid) < 0 then
			heroUid = "0"
		end

		if tonumber(heroUid) > 0 and not repeatHero[heroUid] then
			table.insert(newMOList, HeroModel.instance:getById(heroUid))

			if posOpen then
				self._inTeamHeroUidMap[heroUid] = 1
			end

			repeatHero[heroUid] = true
		else
			local singleGroupMo = HeroGroupPresetSingleGroupModel.instance:getByIndex(pos)

			if singleGroupMo.trial and HeroGroupPresetController.instance:useTrial() then
				table.insert(newMOList, HeroGroupTrialModel.instance:getById(heroUid))

				if posOpen then
					self._inTeamHeroUidMap[heroUid] = 1
				end

				repeatHero[heroUid] = true
			end
		end

		if posOpen then
			table.insert(self._inTeamHeroUidList, heroUid)
			table.insert(self._originalHeroUidList, heroUid)
		end
	end

	if HeroGroupPresetController.instance:useTrial() then
		local trialList = HeroGroupTrialModel.instance:getFilterList()

		for i, heroMo in ipairs(trialList) do
			if not repeatHero[heroMo.uid] then
				table.insert(newMOList, heroMo)
			end
		end
	end

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
			else
				table.insert(newMOList, mo)
			end
		end
	end

	if self.adventure or isTowerBattle or isWeekWalk_2 or isAbyss then
		tabletool.addValues(newMOList, deathList)
	end

	self:setList(newMOList)
end

function HeroGroupPresetQuickEditListModel:keepSelect(selectIndex)
	self._selectIndex = selectIndex

	local list = self:getList()

	if #self._scrollViews > 0 then
		for _, view in ipairs(self._scrollViews) do
			view:selectCell(selectIndex, true)
		end

		if list[selectIndex] then
			return list[selectIndex]
		end
	end
end

function HeroGroupPresetQuickEditListModel:isInTeamHero(uid)
	return self._inTeamHeroUidMap and self._inTeamHeroUidMap[uid]
end

function HeroGroupPresetQuickEditListModel:getHeroTeamPos(uid)
	if self._inTeamHeroUidList then
		for index, heroUid in pairs(self._inTeamHeroUidList) do
			if heroUid == uid then
				return index
			end
		end
	end

	return 0
end

function HeroGroupPresetQuickEditListModel:selectHero(uid)
	local index = self:getHeroTeamPos(uid)

	if index ~= 0 then
		self._inTeamHeroUidList[index] = "0"
		self._inTeamHeroUidMap[uid] = nil

		self:onModelUpdate()

		self._selectUid = nil

		return true
	else
		if self:isTeamFull() then
			return false
		end

		for i = 1, #self._inTeamHeroUidList do
			local heroUid = self._inTeamHeroUidList[i]

			if heroUid == 0 or heroUid == "0" then
				self._inTeamHeroUidList[i] = uid
				self._inTeamHeroUidMap[uid] = 1

				self:onModelUpdate()

				return true
			end
		end

		self._selectUid = uid
	end

	return false
end

function HeroGroupPresetQuickEditListModel:isRepeatHero(heroId, uid)
	if not self._inTeamHeroUidMap then
		return false
	end

	for inTeamUid in pairs(self._inTeamHeroUidMap) do
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

function HeroGroupPresetQuickEditListModel:isTrialLimit()
	if not self._inTeamHeroUidMap then
		return false
	end

	local curNum = 0

	for inTeamUid in pairs(self._inTeamHeroUidMap) do
		local mo = self:getById(inTeamUid)

		if mo:isTrial() then
			curNum = curNum + 1
		end
	end

	return curNum >= HeroGroupTrialModel.instance:getLimitNum()
end

function HeroGroupPresetQuickEditListModel:inInTeam(uid)
	if not self._inTeamHeroUidMap then
		return false
	end

	return not not self._inTeamHeroUidMap[uid]
end

function HeroGroupPresetQuickEditListModel:getHeroUids()
	return self._inTeamHeroUidList
end

function HeroGroupPresetQuickEditListModel:getHeroUidByPos(pos)
	return self._inTeamHeroUidList[pos]
end

function HeroGroupPresetQuickEditListModel:getIsDirty()
	for i = 1, #self._inTeamHeroUidList do
		if self._inTeamHeroUidList[i] ~= self._originalHeroUidList[i] then
			return true
		end
	end

	return false
end

function HeroGroupPresetQuickEditListModel:cancelAllSelected()
	if self._scrollViews then
		for _, view in ipairs(self._scrollViews) do
			local mo = view:getFirstSelect()
			local index = self:getIndex(mo)

			view:selectCell(index, false)
		end
	end
end

function HeroGroupPresetQuickEditListModel:isTeamFull()
	local limitRole = HeroGroupPresetModel.instance:getBattleRoleNum() or 0

	for i = 1, math.min(limitRole, #self._inTeamHeroUidList) do
		local posOpen = HeroGroupPresetModel.instance:isPositionOpen(i)

		if self._inTeamHeroUidList[i] == "0" and posOpen then
			return false
		end
	end

	return true
end

function HeroGroupPresetQuickEditListModel:checkHeroIsError(uid)
	if not uid or tonumber(uid) < 0 then
		return
	end

	local mo = HeroModel.instance:getById(uid)

	if not mo then
		return
	end

	if self.adventure then
		local cd = WeekWalkModel.instance:getCurMapHeroCd(mo.heroId)

		if cd > 0 then
			return true
		end
	elseif self.isWeekWalk_2 then
		local cd = WeekWalk_2Model.instance:getCurMapHeroCd(mo.heroId)

		if cd > 0 then
			return true
		end
	elseif self.isTowerBattle then
		if TowerModel.instance:isHeroBan(mo.heroId) then
			return true
		end
	elseif self._groupType == HeroGroupEnum.GroupType.Abyss and AbyssModel.instance:isCurHeroLocked(mo.heroId) then
		return true
	end
end

function HeroGroupPresetQuickEditListModel:cancelAllErrorSelected()
	local isError = false

	for k, v in pairs(self._inTeamHeroUidList) do
		if self:checkHeroIsError(v) then
			isError = true

			break
		end
	end

	if isError then
		self._inTeamHeroUidList = {}
	end
end

function HeroGroupPresetQuickEditListModel:setParam(adventure, isTowerBattle, groupType)
	self.adventure = adventure
	self.isTowerBattle = isTowerBattle
	self._groupType = groupType
	self.isWeekWalk_2 = groupType == HeroGroupEnum.GroupType.WeekWalk_2
	self.isAbyss = groupType == HeroGroupEnum.GroupType.Abyss
end

function HeroGroupPresetQuickEditListModel:clear()
	self._inTeamHeroUidMap = nil
	self._inTeamHeroUidList = nil
	self._originalHeroUidList = nil
	self._selectIndex = nil
	self._selectUid = nil

	HeroGroupPresetQuickEditListModel.super.clear(self)
end

HeroGroupPresetQuickEditListModel.instance = HeroGroupPresetQuickEditListModel.New()

return HeroGroupPresetQuickEditListModel
