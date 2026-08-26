-- chunkname: @modules/logic/seasonver/act166/model/Season166HeroGroupEditModel.lua

module("modules.logic.seasonver.act166.model.Season166HeroGroupEditModel", package.seeall)

local Season166HeroGroupEditModel = class("Season166HeroGroupEditModel", ListScrollModel)

function Season166HeroGroupEditModel:init(actId, episodeId)
	self.activityId = actId
	self.episodeId = episodeId
	self.episodeCO = DungeonConfig.instance:getEpisodeCO(self.episodeId)
end

function Season166HeroGroupEditModel:copyCharacterCardList(init)
	local moList = HeroGroupTrialModel.instance:isOnlyUseTrial() and {} or tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList())
	local newMOList = {}
	local repeatHero = {}

	self._inTeamHeroUids = {}

	local selectIndex = 1
	local index = 1
	local alreadyList = Season166HeroSingleGroupModel.instance:getList()
	local assistMO = Season166HeroSingleGroupModel.instance.assistMO

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

	if Season166HeroGroupModel.instance:isSeason166Episode() then
		self.sortIndexMap = {}

		for i, v in ipairs(newMOList) do
			self.sortIndexMap[v] = i
		end

		table.sort(newMOList, Season166HeroGroupEditModel.indexMapSortFunc)
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

function Season166HeroGroupEditModel.indexMapSortFunc(a, b)
	local aIndex = Season166HeroGroupEditModel.instance.sortIndexMap[a]
	local bIndex = Season166HeroGroupEditModel.instance.sortIndexMap[b]

	return aIndex < bIndex
end

function Season166HeroGroupEditModel:cancelAllSelected()
	if self._scrollViews then
		for _, view in ipairs(self._scrollViews) do
			local mo = view:getFirstSelect()
			local index = self:getIndex(mo)

			view:selectCell(index, false)
		end
	end
end

function Season166HeroGroupEditModel:isInTeamHero(uid)
	return self._inTeamHeroUids and self._inTeamHeroUids[uid]
end

function Season166HeroGroupEditModel:getEquipMOByHeroUid(heroUid)
	local heroGroupMO = Season166HeroGroupModel.instance:getCurGroupMO()

	if not heroGroupMO then
		return
	end

	local index = tabletool.indexOf(heroGroupMO.heroList, heroUid)

	if index then
		local equip = heroGroupMO:getPosEquips(index - 1)

		if equip and equip.equipUid and #equip.equipUid > 0 then
			local uid = equip.equipUid[1]

			if uid and uid ~= Season166Enum.EmptyUid then
				return EquipModel.instance:getEquip(uid)
			end
		end
	end
end

function Season166HeroGroupEditModel:getAssistHeroList()
	local heroMOList = {}
	local assistHeroMO = Season166HeroSingleGroupModel.instance.assistMO

	if assistHeroMO and Season166HeroGroupModel.instance:isSeason166Episode(self.episodeId) then
		table.insert(heroMOList, assistHeroMO:getHeroMO())
	end

	return heroMOList
end

function Season166HeroGroupEditModel:isRepeatHero(heroId, uid)
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

function Season166HeroGroupEditModel:isTrialLimit()
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

function Season166HeroGroupEditModel:setParam(heroUid)
	self.specialHero = heroUid
end

Season166HeroGroupEditModel.instance = Season166HeroGroupEditModel.New()

return Season166HeroGroupEditModel
