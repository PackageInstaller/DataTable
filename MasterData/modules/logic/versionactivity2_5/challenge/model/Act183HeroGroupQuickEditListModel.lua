-- chunkname: @modules/logic/versionactivity2_5/challenge/model/Act183HeroGroupQuickEditListModel.lua

module("modules.logic.versionactivity2_5.challenge.model.Act183HeroGroupQuickEditListModel", package.seeall)

local Act183HeroGroupQuickEditListModel = class("Act183HeroGroupQuickEditListModel", MixScrollModel)

function Act183HeroGroupQuickEditListModel:init(actId, episodeId)
	self.activityId = actId
	self.episodeId = episodeId
	self.episodeCo = DungeonConfig.instance:getEpisodeCO(self.episodeId)
	self.challengeEpisodeCo = Act183Config.instance:getEpisodeCo(self.episodeId)
	self.groupEpisodeMo = Act183Model.instance:getGroupEpisodeMo(self.challengeEpisodeCo.groupId)
	self.groupEpisodeType = self.groupEpisodeMo and self.groupEpisodeMo:getGroupType()
end

function Act183HeroGroupQuickEditListModel:copyQuickEditCardList()
	local moList = HeroGroupTrialModel.instance:isOnlyUseTrial() and {} or CharacterBackpackCardListModel.instance:getCharacterCardList()
	local newMOList = {}
	local repeatHero = {}

	self._inTeamHeroUidMap = {}
	self._inTeamHeroUidList = {}
	self._originalHeroUidList = {}
	self._selectUid = nil

	local alreadyList = HeroSingleGroupModel.instance:getList()

	for pos, heroSingleGroupMO in ipairs(alreadyList) do
		local posOpen = Act183Helper.isHeroGroupPositionOpen(self.episodeId, pos)
		local heroUid = heroSingleGroupMO.heroUid

		if tonumber(heroUid) > 0 and not repeatHero[heroUid] then
			table.insert(newMOList, HeroModel.instance:getById(heroUid))

			if posOpen then
				self._inTeamHeroUidMap[heroUid] = 1
			end

			repeatHero[heroUid] = true
		else
			local singleGroupMo = HeroSingleGroupModel.instance:getByIndex(pos)

			if singleGroupMo.trial then
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

	local trialList = HeroGroupTrialModel.instance:getFilterList()

	for i, heroMo in ipairs(trialList) do
		if not repeatHero[heroMo.uid] then
			table.insert(newMOList, heroMo)
		end
	end

	local isTowerBattle = self.isTowerBattle
	local deathList = {}

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
			elseif isTowerBattle then
				if TowerModel.instance:isHeroBan(mo.heroId) then
					table.insert(deathList, mo)
				else
					table.insert(newMOList, mo)
				end
			else
				table.insert(newMOList, mo)
			end
		end
	end

	if self.adventure or isTowerBattle then
		tabletool.addValues(newMOList, deathList)
	end

	self.sortIndexMap = {}

	for i, v in ipairs(newMOList) do
		self.sortIndexMap[v] = i
	end

	table.sort(newMOList, self.indexMapSortFunc)
	self:setList(newMOList)
end

function Act183HeroGroupQuickEditListModel.indexMapSortFunc(a, b)
	local episodeId = Act183HeroGroupQuickEditListModel.instance.episodeId
	local aRepress = Act183Model.instance:isHeroRepressInPreEpisode(episodeId, a.heroId)
	local bRepress = Act183Model.instance:isHeroRepressInPreEpisode(episodeId, b.heroId)

	if aRepress ~= bRepress then
		return not aRepress
	end

	local aIndex = Act183HeroGroupQuickEditListModel.instance.sortIndexMap[a]
	local bIndex = Act183HeroGroupQuickEditListModel.instance.sortIndexMap[b]

	return aIndex < bIndex
end

function Act183HeroGroupQuickEditListModel:keepSelect(selectIndex)
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

function Act183HeroGroupQuickEditListModel:isInTeamHero(uid)
	return self._inTeamHeroUidMap and self._inTeamHeroUidMap[uid]
end

function Act183HeroGroupQuickEditListModel:getHeroTeamPos(uid)
	if self._inTeamHeroUidList then
		for index, heroUid in pairs(self._inTeamHeroUidList) do
			if heroUid == uid then
				return index
			end
		end
	end

	return 0
end

function Act183HeroGroupQuickEditListModel:selectHero(uid)
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

function Act183HeroGroupQuickEditListModel:isRepeatHero(heroId, uid)
	if not self._inTeamHeroUidMap then
		return false
	end

	for inTeamUid in pairs(self._inTeamHeroUidMap) do
		local mo = self:getById(inTeamUid)

		if mo.heroId == heroId and uid ~= mo.uid then
			return true
		end
	end

	return false
end

function Act183HeroGroupQuickEditListModel:isTrialLimit()
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

	if self.episodeCo then
		if not self.episodeCo.roleNum then
			local roleNum = ModuleEnum.MaxHeroCountInGroup

			return roleNum <= curNum
		end
	end
end

function Act183HeroGroupQuickEditListModel:inInTeam(uid)
	if not self._inTeamHeroUidMap then
		return false
	end

	return not not self._inTeamHeroUidMap[uid]
end

function Act183HeroGroupQuickEditListModel:getHeroUids()
	return self._inTeamHeroUidList
end

function Act183HeroGroupQuickEditListModel:getHeroUidByPos(pos)
	return self._inTeamHeroUidList[pos]
end

function Act183HeroGroupQuickEditListModel:getIsDirty()
	for i = 1, #self._inTeamHeroUidList do
		if self._inTeamHeroUidList[i] ~= self._originalHeroUidList[i] then
			return true
		end
	end

	return false
end

function Act183HeroGroupQuickEditListModel:cancelAllSelected()
	if self._scrollViews then
		for _, view in ipairs(self._scrollViews) do
			local mo = view:getFirstSelect()
			local index = self:getIndex(mo)

			view:selectCell(index, false)
		end
	end
end

function Act183HeroGroupQuickEditListModel:isTeamFull()
	local limitRole = HeroGroupModel.instance:getBattleRoleNum() or 0

	for i = 1, math.min(limitRole, #self._inTeamHeroUidList) do
		local posOpen = Act183Helper.isHeroGroupPositionOpen(self.episodeId, i)

		if self._inTeamHeroUidList[i] == "0" and posOpen then
			return false
		end
	end

	return true
end

function Act183HeroGroupQuickEditListModel:checkHeroIsError(uid)
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
	elseif self.isTowerBattle and TowerModel.instance:isHeroBan(mo.heroId) then
		return true
	end
end

function Act183HeroGroupQuickEditListModel:cancelAllErrorSelected()
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

function Act183HeroGroupQuickEditListModel:setParam(adventure, isTowerBattle)
	self.adventure = adventure
	self.isTowerBattle = isTowerBattle
end

function Act183HeroGroupQuickEditListModel:clear()
	self._inTeamHeroUidMap = nil
	self._inTeamHeroUidList = nil
	self._originalHeroUidList = nil
	self._selectIndex = nil
	self._selectUid = nil

	Act183HeroGroupQuickEditListModel.super.clear(self)
end

Act183HeroGroupQuickEditListModel.instance = Act183HeroGroupQuickEditListModel.New()

return Act183HeroGroupQuickEditListModel
