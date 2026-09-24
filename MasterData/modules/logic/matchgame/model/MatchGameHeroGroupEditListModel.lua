-- chunkname: @modules/logic/matchgame/model/MatchGameHeroGroupEditListModel.lua

module("modules.logic.matchgame.model.MatchGameHeroGroupEditListModel", package.seeall)

local MatchGameHeroGroupEditListModel = class("MatchGameHeroGroupEditListModel", ListScrollModel)

function MatchGameHeroGroupEditListModel:initList()
	self._selectedCharacterId = 0
	self._isQuickEditMode = false
	self._batchSelectedList = {}
	self._episodeId = MatchGameLevelModel.instance:getCurEpisodeId()
	self._episodeCo = MatchGameLevelModel.instance:getCurEpisodeCo()
	self._maxRoleNum = MatchGameConfig.instance:getEpisodeRoleNum(self._episodeId)

	self:initBatchList()
	self:refreshData()
end

function MatchGameHeroGroupEditListModel:initBatchList()
	local curHeroList = MatchGameHeroGroupModel.instance:getCurTeamHeroes()

	for i = 1, MatchGameEnum.HeroGroupMaxHeroCount do
		local singleMo = curHeroList[i]

		if singleMo then
			if not singleMo.id then
				self._batchSelectedList[i] = 0
			end
		end
	end
end

function MatchGameHeroGroupEditListModel:setQuickEditMode(isOn)
	self._isQuickEditMode = isOn
end

function MatchGameHeroGroupEditListModel:isQuickEditMode()
	return self._isQuickEditMode
end

function MatchGameHeroGroupEditListModel:isBatchSelected(heroId)
	if not self._batchSelectedList then
		return false, 0
	end

	for i, id in ipairs(self._batchSelectedList) do
		if id == heroId then
			return true, i
		end
	end

	return false, 0
end

function MatchGameHeroGroupEditListModel:addBatchSelected(heroId)
	self._batchSelectedList = self._batchSelectedList or {}

	for i, id in ipairs(self._batchSelectedList) do
		if id == 0 then
			self._batchSelectedList[i] = heroId

			return
		end
	end

	table.insert(self._batchSelectedList, heroId)
end

function MatchGameHeroGroupEditListModel:removeBatchSelected(heroId)
	if not self._batchSelectedList then
		return
	end

	for i, id in pairs(self._batchSelectedList) do
		if id == heroId then
			self._batchSelectedList[i] = 0

			return
		end
	end
end

function MatchGameHeroGroupEditListModel:getBatchSelectedCount()
	local count = 0

	if self._batchSelectedList then
		for _, heroId in ipairs(self._batchSelectedList) do
			if heroId ~= 0 then
				count = count + 1
			end
		end
	end

	return count
end

function MatchGameHeroGroupEditListModel:getBatchSelectedList()
	return self._batchSelectedList or {}
end

function MatchGameHeroGroupEditListModel:refreshData()
	local heroMap = MatchGameModel.instance.heroMap

	if not heroMap then
		return
	end

	local teamHeroes = MatchGameHeroGroupModel.instance:getCurTeamHeroes()
	local inTeamMap = {}
	local teamPosMap = {}

	if teamHeroes then
		for posIndex, singleMo in pairs(teamHeroes) do
			if singleMo and singleMo.id ~= 0 then
				inTeamMap[singleMo.id] = true
				teamPosMap[singleMo.id] = posIndex
			end
		end
	end

	local moList = {}

	self:_addBagCharacterList(moList)
	self:_addTrialCharacterList(moList)
	table.sort(moList, function(a, b)
		local aInTeam = inTeamMap[a.id]
		local bInTeam = inTeamMap[b.id]

		if aInTeam ~= bInTeam then
			return aInTeam == true
		end

		if aInTeam and bInTeam then
			return (teamPosMap[a.id] or 0) < (teamPosMap[b.id] or 0)
		end

		local aRecommend = a.career == self._episodeCo.RecCareer
		local bRecommend = b.career == self._episodeCo.RecCareer

		if aRecommend ~= bRecommend then
			return aRecommend
		end

		if a.career ~= b.career then
			return a.career < b.career
		end

		if a.level ~= b.level then
			return a.level > b.level
		end

		return a.id < b.id
	end)
	self:setList(moList)
	self:_updateSelect()
end

function MatchGameHeroGroupEditListModel:_addBagCharacterList(moList)
	local allCharacterMap = MatchGameModel.instance:getAllCharacterMo()

	if allCharacterMap then
		for _, characterMo in pairs(allCharacterMap) do
			table.insert(moList, characterMo)
		end
	end
end

function MatchGameHeroGroupEditListModel:_addTrialCharacterList(moList)
	if not MatchGameConfig.instance:isTeachEpisode(self._episodeId) then
		return
	end

	local trialHeroList = MatchGameConfig.instance:getTrialHeroInfoList(self._episodeId)

	if not trialHeroList then
		return
	end

	for _, heroInfo in ipairs(trialHeroList) do
		local id = heroInfo[1]
		local level = heroInfo[2]
		local heroMo = MatchGameCharacterMo.New()

		heroMo:initByLocal(id, level)
		table.insert(moList, heroMo)
	end
end

function MatchGameHeroGroupEditListModel:handleSelect(heroId)
	if self:isQuickEditMode() then
		local isSelected = self:isBatchSelected(heroId)

		if isSelected then
			self:_setSelectedCharacterId(0)
			self:removeBatchSelected(heroId)
		elseif self:getBatchSelectedCount() < self._maxRoleNum then
			self:_setSelectedCharacterId(heroId)
			self:addBatchSelected(heroId)
		end

		self:_updateSelect()
	elseif self:getSelectedCharacterId() == heroId then
		self:_setSelectedCharacterId(0)

		local mo = self:getById(heroId)

		if mo then
			local index = self:getIndex(mo)

			if index then
				self:selectCell(index, false)
			end
		end
	else
		self:_setSelectedCharacterId(heroId)

		local mo = self:getById(heroId)

		if mo then
			local index = self:getIndex(mo)

			if index then
				self:selectCell(index, true)
			end
		end
	end

	MatchGameController.instance:dispatchEvent(MatchGameEvent.OnSelectionChanged)
end

function MatchGameHeroGroupEditListModel:_setSelectedCharacterId(heroId)
	self._selectedCharacterId = heroId
end

function MatchGameHeroGroupEditListModel:getSelectedCharacterId()
	return self._selectedCharacterId or 0
end

function MatchGameHeroGroupEditListModel:handleQuickEditToggle()
	self:setQuickEditMode(not self._isQuickEditMode)
	self:_updateSelect()
	MatchGameController.instance:dispatchEvent(MatchGameEvent.OnSelectionChanged)
end

function MatchGameHeroGroupEditListModel:_updateSelect()
	for _, scrollView in ipairs(self._scrollViews) do
		scrollView._selectMOs = {}

		if self:isQuickEditMode() then
			for _, heroId in ipairs(self._batchSelectedList or {}) do
				local mo = self:getById(heroId)

				if mo then
					table.insert(scrollView._selectMOs, mo)
				end
			end
		else
			local selectedId = self:getSelectedCharacterId()

			if selectedId > 0 then
				local mo = self:getById(selectedId)

				if mo then
					scrollView._selectMOs = {
						mo
					}
				end
			end
		end
	end

	self:onModelUpdate()
end

MatchGameHeroGroupEditListModel.instance = MatchGameHeroGroupEditListModel.New()

return MatchGameHeroGroupEditListModel
