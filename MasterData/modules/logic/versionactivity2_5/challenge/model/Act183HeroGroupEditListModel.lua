-- chunkname: @modules/logic/versionactivity2_5/challenge/model/Act183HeroGroupEditListModel.lua

module("modules.logic.versionactivity2_5.challenge.model.Act183HeroGroupEditListModel", package.seeall)

local Act183HeroGroupEditListModel = class("Act183HeroGroupEditListModel", MixScrollModel)

function Act183HeroGroupEditListModel:init(actId, episodeId)
	self.activityId = actId
	self.episodeId = episodeId
	self.episodeCo = DungeonConfig.instance:getEpisodeCO(self.episodeId)
	self.challengeEpisodeCo = Act183Config.instance:getEpisodeCo(self.episodeId)
	self.groupEpisodeMo = Act183Model.instance:getGroupEpisodeMo(self.challengeEpisodeCo.groupId)
	self.groupEpisodeType = self.groupEpisodeMo and self.groupEpisodeMo:getGroupType()
end

function Act183HeroGroupEditListModel:copyCharacterCardList(init)
	local moList = HeroGroupTrialModel.instance:isOnlyUseTrial() and {} or tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList())
	local newMOList = {}
	local repeatHero = {}

	self._inTeamHeroUids = {}

	local selectIndex = 1
	local index = 1
	local alreadyList = HeroSingleGroupModel.instance:getList()
	local assistMO = HeroSingleGroupModel.instance.assistMO

	for i, heroSingleGroupMO in ipairs(alreadyList) do
		if heroSingleGroupMO.trial or not heroSingleGroupMO.aid and tonumber(heroSingleGroupMO.heroUid) > 0 and not repeatHero[heroSingleGroupMO.heroUid] then
			if heroSingleGroupMO.trial then
				table.insert(newMOList, HeroGroupTrialModel.instance:getById(heroSingleGroupMO.heroUid))
			elseif assistMO and heroSingleGroupMO.heroUid == assistMO.heroUid then
				table.insert(newMOList, assistMO:getHeroMO())
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

	self.sortIndexMap = {}

	for i, v in ipairs(newMOList) do
		self.sortIndexMap[v] = i
	end

	table.sort(newMOList, Act183HeroGroupEditListModel.indexMapSortFunc)
	self:setList(newMOList)

	if newMOList[selectIndex] then
		local selectHeroId = newMOList[selectIndex].heroId
		local isSelectHeroRepress = Act183Model.instance:isHeroRepressInPreEpisode(self.episodeId, selectHeroId)

		if isSelectHeroRepress then
			selectIndex = 0
		end

		if init and #newMOList > 0 and selectIndex > 0 and #self._scrollViews > 0 then
			for _, view in ipairs(self._scrollViews) do
				view:selectCell(selectIndex, true)
			end

			if newMOList[selectIndex] then
				return newMOList[selectIndex]
			end
		end
	end
end

function Act183HeroGroupEditListModel.indexMapSortFunc(a, b)
	local episodeId = Act183HeroGroupEditListModel.instance.episodeId
	local aRepress = Act183Model.instance:isHeroRepressInPreEpisode(episodeId, a.heroId)
	local bRepress = Act183Model.instance:isHeroRepressInPreEpisode(episodeId, b.heroId)

	if aRepress ~= bRepress then
		return not aRepress
	end

	local aIndex = Act183HeroGroupEditListModel.instance.sortIndexMap[a]
	local bIndex = Act183HeroGroupEditListModel.instance.sortIndexMap[b]

	return aIndex < bIndex
end

function Act183HeroGroupEditListModel:cancelAllSelected()
	if self._scrollViews then
		for _, view in ipairs(self._scrollViews) do
			local mo = view:getFirstSelect()
			local index = self:getIndex(mo)

			view:selectCell(index, false)
		end
	end
end

function Act183HeroGroupEditListModel:isInTeamHero(uid)
	return self._inTeamHeroUids and self._inTeamHeroUids[uid]
end

function Act183HeroGroupEditListModel:isRepeatHero(heroId, uid)
	if not self._inTeamHeroUids then
		return false
	end

	for inTeamUid in pairs(self._inTeamHeroUids) do
		local mo = self:getById(inTeamUid)

		if mo and mo.heroId == heroId and uid ~= mo.uid then
			return true
		end
	end

	return false
end

function Act183HeroGroupEditListModel:isTrialLimit()
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

	if self.episodeCo then
		if not self.episodeCo.roleNum then
			local roleNum = ModuleEnum.MaxHeroCountInGroup

			return roleNum <= curNum
		end
	end
end

function Act183HeroGroupEditListModel:setParam(heroUid)
	self.specialHero = heroUid
end

Act183HeroGroupEditListModel.instance = Act183HeroGroupEditListModel.New()

return Act183HeroGroupEditListModel
