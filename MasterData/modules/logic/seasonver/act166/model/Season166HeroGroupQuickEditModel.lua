-- chunkname: @modules/logic/seasonver/act166/model/Season166HeroGroupQuickEditModel.lua

module("modules.logic.seasonver.act166.model.Season166HeroGroupQuickEditModel", package.seeall)

local Season166HeroGroupQuickEditModel = class("Season166HeroGroupQuickEditModel", ListScrollModel)

function Season166HeroGroupQuickEditModel:init(actId, episodeId)
	self.activityId = actId
	self.episodeId = episodeId
	self.episodeCO = DungeonConfig.instance:getEpisodeCO(self.episodeId)
end

function Season166HeroGroupQuickEditModel:copyQuickEditCardList()
	local moList = HeroGroupTrialModel.instance:isOnlyUseTrial() and {} or tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList())
	local newMOList = {}
	local repeatHero = {}

	self._inTeamHeroUidMap = {}
	self._inTeamHeroUidList = {}
	self._originalHeroUidList = {}
	self._selectUid = nil

	local heroGroupMO = Season166HeroGroupModel.instance:getCurGroupMO()

	for pos, heroUid in ipairs(heroGroupMO.heroList) do
		local posOpen = Season166HeroGroupModel.instance:isPositionOpen(pos)

		if tonumber(heroUid) > 0 and not repeatHero[heroUid] then
			local tmpMO = self:getHeroMO(heroUid)

			table.insert(newMOList, tmpMO)

			if posOpen then
				self._inTeamHeroUidMap[heroUid] = 1
			end

			repeatHero[heroUid] = true
		else
			local singleGroupMo = Season166HeroSingleGroupModel.instance:getByIndex(pos)

			if singleGroupMo and singleGroupMo.trial then
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

	for i, mo in ipairs(moList) do
		if not repeatHero[mo.uid] then
			repeatHero[mo.uid] = true

			table.insert(newMOList, mo)
		end
	end

	if Season166HeroGroupModel.instance:isSeason166Episode() then
		self.sortIndexMap = {}

		for i, v in ipairs(newMOList) do
			self.sortIndexMap[v] = i
		end

		table.sort(newMOList, Season166HeroGroupQuickEditModel.indexMapSortFunc)
	end

	self:setList(newMOList)
end

function Season166HeroGroupQuickEditModel.indexMapSortFunc(a, b)
	local aIndex = Season166HeroGroupQuickEditModel.instance.sortIndexMap[a]
	local bIndex = Season166HeroGroupQuickEditModel.instance.sortIndexMap[b]

	return aIndex < bIndex
end

function Season166HeroGroupQuickEditModel:getHeroMO(heroUid)
	local heroMO = HeroModel.instance:getById(heroUid)
	local isTrainEpisode = Season166HeroGroupModel.instance:isSeason166TrainEpisode(self.episodeId)

	if not heroMO and isTrainEpisode then
		local assistHeroMO = Season166HeroSingleGroupModel.instance.assistMO

		if assistHeroMO and assistHeroMO.heroUid == heroUid then
			return assistHeroMO:getHeroMO()
		end
	else
		return heroMO
	end
end

function Season166HeroGroupQuickEditModel:keepSelect(selectIndex)
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

function Season166HeroGroupQuickEditModel:isInTeamHero(uid)
	return self._inTeamHeroUidMap and self._inTeamHeroUidMap[uid]
end

function Season166HeroGroupQuickEditModel:getHeroTeamPos(uid)
	if self._inTeamHeroUidList then
		for index, heroUid in ipairs(self._inTeamHeroUidList) do
			if heroUid == uid then
				return index
			end
		end
	end

	return 0
end

function Season166HeroGroupQuickEditModel:selectHero(uid)
	local index = self:getHeroTeamPos(uid)

	if index ~= 0 then
		self._inTeamHeroUidList[index] = "0"
		self._inTeamHeroUidMap[uid] = nil

		self:onModelUpdate()

		self._selectUid = nil

		return true
	else
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

function Season166HeroGroupQuickEditModel:isRepeatHero(heroId, uid)
	if not self._inTeamHeroUidMap then
		return false
	end

	for inTeamUid in pairs(self._inTeamHeroUidMap) do
		local mo = self:getById(inTeamUid)

		if mo and mo.heroId == heroId and uid ~= mo.uid then
			return true
		end
	end

	return false
end

function Season166HeroGroupQuickEditModel:isTrialLimit()
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

function Season166HeroGroupQuickEditModel:getHeroUids()
	return self._inTeamHeroUidList
end

function Season166HeroGroupQuickEditModel:getHeroUidByPos(pos)
	return self._inTeamHeroUidList[pos]
end

function Season166HeroGroupQuickEditModel:getIsDirty()
	for i = 1, #self._inTeamHeroUidList do
		if self._inTeamHeroUidList[i] ~= self._originalHeroUidList[i] then
			return true
		end
	end

	return false
end

function Season166HeroGroupQuickEditModel:cancelAllSelected()
	if self._scrollViews then
		for _, view in ipairs(self._scrollViews) do
			local mo = view:getFirstSelect()
			local index = self:getIndex(mo)

			view:selectCell(index, false)
		end
	end
end

function Season166HeroGroupQuickEditModel:isTeamFull()
	for i = 1, #self._inTeamHeroUidList do
		if self._inTeamHeroUidList[i] == "0" then
			return false
		end
	end

	return true
end

function Season166HeroGroupQuickEditModel:clear()
	self._inTeamHeroUidMap = nil
	self._inTeamHeroUidList = nil
	self._originalHeroUidList = nil
	self._selectIndex = nil
	self._selectUid = nil

	Season166HeroGroupQuickEditModel.super.clear(self)
end

Season166HeroGroupQuickEditModel.instance = Season166HeroGroupQuickEditModel.New()

return Season166HeroGroupQuickEditModel
