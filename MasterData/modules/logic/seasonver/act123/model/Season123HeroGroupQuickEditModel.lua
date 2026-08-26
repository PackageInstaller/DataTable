-- chunkname: @modules/logic/seasonver/act123/model/Season123HeroGroupQuickEditModel.lua

module("modules.logic.seasonver.act123.model.Season123HeroGroupQuickEditModel", package.seeall)

local Season123HeroGroupQuickEditModel = class("Season123HeroGroupQuickEditModel", ListScrollModel)

function Season123HeroGroupQuickEditModel:init(actId, layer, episodeId, stage)
	self.activityId = actId
	self.layer = layer
	self.episodeId = episodeId
	self.episodeCO = DungeonConfig.instance:getEpisodeCO(self.episodeId)
	self.stage = stage
end

function Season123HeroGroupQuickEditModel:copyQuickEditCardList()
	local moList = tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList())
	local heroMO = Season123Model.instance:getAssistData(self.activityId, self.stage)

	if heroMO and Season123Controller.isEpisodeFromSeason123(self.episodeId) and Season123HeroGroupModel.instance:isEpisodeSeason123() then
		table.insert(moList, heroMO)
	end

	local newMOList = {}
	local repeatHero = {}

	self._inTeamHeroUidMap = {}
	self._inTeamHeroUidList = {}
	self._originalHeroUidList = {}
	self._selectUid = nil

	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()

	for pos, heroUid in ipairs(heroGroupMO.heroList) do
		local posOpen = HeroGroupModel.instance:isPositionOpen(pos)

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

	local deathList = {}

	for i, mo in ipairs(moList) do
		if not repeatHero[mo.uid] and self:checkSeasonBox(mo) then
			repeatHero[mo.uid] = true

			table.insert(newMOList, mo)
		end
	end

	if self.adventure then
		tabletool.addValues(newMOList, deathList)
	end

	local trialList = HeroGroupTrialModel.instance:getFilterList()

	for i, heroMo in ipairs(trialList) do
		if not repeatHero[heroMo.uid] then
			table.insert(newMOList, heroMo)
		end
	end

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		self.sortIndexMap = {}

		for i, v in ipairs(newMOList) do
			self.sortIndexMap[v.uid] = i
		end

		table.sort(newMOList, Season123HeroGroupQuickEditModel.sortDead)
	end

	self:setList(newMOList)
end

function Season123HeroGroupQuickEditModel.sortDead(a, b)
	local aIsDead = Season123HeroGroupEditModel.instance:getHeroIsDead(a)
	local bIsDead = Season123HeroGroupEditModel.instance:getHeroIsDead(b)

	if aIsDead ~= bIsDead then
		return bIsDead
	end

	local aIsRestrict = not not HeroGroupModel.instance:isRestrict(a.uid)
	local bIsRestrict = not not HeroGroupModel.instance:isRestrict(b.uid)

	if aIsRestrict ~= bIsRestrict then
		return bIsRestrict
	end

	local aIndex = Season123HeroGroupQuickEditModel.instance.sortIndexMap[a.uid]
	local bIndex = Season123HeroGroupQuickEditModel.instance.sortIndexMap[b.uid]

	return aIndex < bIndex
end

function Season123HeroGroupQuickEditModel:checkSeasonBox(heroMO)
	return true
end

function Season123HeroGroupQuickEditModel:keepSelect(selectIndex)
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

function Season123HeroGroupQuickEditModel:isInTeamHero(uid)
	return self._inTeamHeroUidMap and self._inTeamHeroUidMap[uid]
end

function Season123HeroGroupQuickEditModel:getHeroTeamPos(uid)
	if self._inTeamHeroUidList then
		for index, heroUid in pairs(self._inTeamHeroUidList) do
			if heroUid == uid then
				return index
			end
		end
	end

	return 0
end

function Season123HeroGroupQuickEditModel:selectHero(uid)
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

function Season123HeroGroupQuickEditModel:getHeroUids()
	return self._inTeamHeroUidList
end

function Season123HeroGroupQuickEditModel:getHeroUidByPos(pos)
	return self._inTeamHeroUidList[pos]
end

function Season123HeroGroupQuickEditModel:getIsDirty()
	for i = 1, #self._inTeamHeroUidList do
		if self._inTeamHeroUidList[i] ~= self._originalHeroUidList[i] then
			return true
		end
	end

	return false
end

function Season123HeroGroupQuickEditModel:cancelAllSelected()
	if self._scrollViews then
		for _, view in ipairs(self._scrollViews) do
			local mo = view:getFirstSelect()
			local index = self:getIndex(mo)

			view:selectCell(index, false)
		end
	end
end

function Season123HeroGroupQuickEditModel:isTeamFull()
	for i = 1, #self._inTeamHeroUidList do
		local posOpen = HeroGroupModel.instance:isPositionOpen(i)

		if self._inTeamHeroUidList[i] == "0" and posOpen then
			return false
		end
	end

	return true
end

function Season123HeroGroupQuickEditModel:setParam(adventure)
	self.adventure = adventure
end

function Season123HeroGroupQuickEditModel:isRepeatHero(heroId, uid)
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

function Season123HeroGroupQuickEditModel:isTrialLimit()
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

function Season123HeroGroupQuickEditModel:inInTeam(uid)
	if not self._inTeamHeroUidMap then
		return false
	end

	return not not self._inTeamHeroUidMap[uid]
end

function Season123HeroGroupQuickEditModel:clear()
	self._inTeamHeroUidMap = nil
	self._inTeamHeroUidList = nil
	self._originalHeroUidList = nil
	self._selectIndex = nil
	self._selectUid = nil

	Season123HeroGroupQuickEditModel.super.clear(self)
end

Season123HeroGroupQuickEditModel.instance = Season123HeroGroupQuickEditModel.New()

return Season123HeroGroupQuickEditModel
