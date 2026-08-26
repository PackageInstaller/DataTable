-- chunkname: @modules/logic/character/model/CharacterModel.lua

module("modules.logic.character.model.CharacterModel", package.seeall)

local CharacterModel = class("CharacterModel", BaseModel)

function CharacterModel:onInit()
	self:reInit()
end

function CharacterModel:reInit()
	self._btnTag = {}
	self._curCardList = {}
	self._curRankIndex = 0
	self._rareAscend = false
	self._levelAscend = false
	self._faithAscend = false
	self._exSklAscend = false
	self._showHeroDict = {}
	self._heroList = nil
	self._hideGainHeroView = false
	self._twinssychubeEquipMos = nil
end

function CharacterModel:getBtnTag(type)
	self._btnTag[type] = self._btnTag[type] or 1

	return self._btnTag[type]
end

function CharacterModel:getRankIndex()
	return self._curRankIndex
end

function CharacterModel:setSortByRankDescOnce()
	self._sortByRankDesc = true
end

function CharacterModel:_setCharacterCardList(cardList)
	CharacterBackpackCardListModel.instance:setCharacterCardList(cardList)
end

function CharacterModel:setHeroList(list)
	self._heroList = list
end

function CharacterModel:_getHeroList()
	if self._heroList then
		return self._heroList
	end

	return HeroModel.instance:getList()
end

function CharacterModel:setCharacterList(isShowHero, type)
	self._btnTag[type] = self._btnTag[type] or 1

	self:setCardListByCareerIndex(self._curRankIndex, isShowHero)

	if self._btnTag[type] == 1 then
		self:_sortByLevel(isShowHero)
	elseif self._btnTag[type] == 2 then
		self:_sortByRare(isShowHero)
	elseif self._btnTag[type] == 3 then
		self:_sortByFaith(isShowHero)
	elseif self._btnTag[type] == 4 then
		self:_sortByExSkill(isShowHero)
	end

	if self._sortByRankDesc then
		self._sortByRankDesc = false
	end

	self:_setCharacterCardList(self._curCardList)
end

function CharacterModel:setCardListByLevel(isShowHero, type)
	self._btnTag[type] = self._btnTag[type] or 1
	self._rareAscend = false
	self._faithAscend = false
	self._exSklAscend = false

	if self._btnTag[type] == 1 then
		self._levelAscend = not self._levelAscend
	else
		self._btnTag[type] = 1
	end

	self:_sortByLevel(isShowHero)
	self:_setCharacterCardList(self._curCardList)
end

function CharacterModel:_updateShowHeroDict()
	local showHeros = PlayerModel.instance:getShowHeros()

	self._showHeroDict = {}

	for i = 1, #showHeros do
		if showHeros[i] ~= 0 then
			self._showHeroDict[showHeros[i].heroId] = #showHeros - i + 1
		end
	end
end

function CharacterModel:_sortByLevel(isShowHero, isSortTag)
	if isShowHero then
		self:_updateShowHeroDict()
	else
		self._showHeroDict = {}
	end

	table.sort(self._curCardList, function(a, b)
		if self._fakeLevelDict then
			if not self._fakeLevelDict[a.heroId] then
				local aLevel = a.level

				if self._fakeLevelDict then
					if not self._fakeLevelDict[b.heroId] then
						local bLevel = b.level

						if not self._showHeroDict[a.heroId] then
							local aShowHeroScore = 0

							if not self._showHeroDict[b.heroId] then
								local bShowHeroScore = 0

								if self._tagCountDict then
									if not self._tagCountDict[a.heroId] then
										local aTagCount = 0

										if self._tagCountDict then
											if not self._tagCountDict[b.heroId] then
												local bTagCount = 0

												if self._sortByRankDesc and a.rank ~= b.rank then
													return a.rank > b.rank
												end

												if bShowHeroScore < aShowHeroScore then
													return true
												elseif aShowHeroScore < bShowHeroScore then
													return false
												elseif a.isFavor ~= b.isFavor then
													return a.isFavor
												elseif isSortTag and aTagCount ~= bTagCount then
													return bTagCount < aTagCount
												elseif aLevel ~= bLevel then
													if self._levelAscend then
														return aLevel < bLevel
													else
														return bLevel < aLevel
													end
												elseif not isSortTag and aTagCount ~= bTagCount then
													return bTagCount < aTagCount
												elseif a.config.rare ~= b.config.rare then
													return a.config.rare > b.config.rare
												elseif a.exSkillLevel ~= b.exSkillLevel then
													return a.exSkillLevel > b.exSkillLevel
												elseif a.heroId ~= b.heroId then
													return a.heroId > b.heroId
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end)
end

function CharacterModel:setCardListByRareAndSort(isShowHero, type, isAscend)
	self._btnTag[type] = self._btnTag[type] or 1
	self._levelAscend = false
	self._faithAscend = false
	self._exSklAscend = false
	self._btnTag[type] = 2
	self._rareAscend = isAscend

	self:_sortByRare(isShowHero)
	self:_setCharacterCardList(self._curCardList)
end

function CharacterModel:setCardListByRare(isShowHero, type)
	self._btnTag[type] = self._btnTag[type] or 1
	self._levelAscend = false
	self._faithAscend = false
	self._exSklAscend = false

	if self._btnTag[type] == 2 then
		self._rareAscend = not self._rareAscend
	else
		self._btnTag[type] = 2
	end

	self:_sortByRare(isShowHero)
	self:_setCharacterCardList(self._curCardList)
end

function CharacterModel:_sortByRare(isShowHero, isSortTag)
	if isShowHero then
		self:_updateShowHeroDict()
	else
		self._showHeroDict = {}
	end

	table.sort(self._curCardList, function(a, b)
		if self._fakeLevelDict then
			if not self._fakeLevelDict[a.heroId] then
				local aLevel = a.level

				if self._fakeLevelDict then
					if not self._fakeLevelDict[b.heroId] then
						local bLevel = b.level

						if not self._showHeroDict[a.heroId] then
							local aShowHeroScore = 0

							if not self._showHeroDict[b.heroId] then
								local bShowHeroScore = 0

								if self._tagCountDict then
									if not self._tagCountDict[a.heroId] then
										local aTagCount = 0

										if self._tagCountDict then
											if not self._tagCountDict[b.heroId] then
												local bTagCount = 0

												if bShowHeroScore < aShowHeroScore then
													return true
												elseif aShowHeroScore < bShowHeroScore then
													return false
												elseif a.isFavor ~= b.isFavor then
													return a.isFavor
												elseif isSortTag and aTagCount ~= bTagCount then
													return bTagCount < aTagCount
												elseif a.config.rare ~= b.config.rare then
													if self._rareAscend then
														return a.config.rare < b.config.rare
													else
														return a.config.rare > b.config.rare
													end
												elseif not isSortTag and aTagCount ~= bTagCount then
													return bTagCount < aTagCount
												elseif aLevel ~= bLevel then
													return bLevel < aLevel
												elseif a.exSkillLevel ~= b.exSkillLevel then
													return a.exSkillLevel > b.exSkillLevel
												elseif a.heroId ~= b.heroId then
													return a.heroId > b.heroId
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end)
end

function CharacterModel:setCardListByFaith(isShowHero, type)
	self._btnTag[type] = self._btnTag[type] or 1
	self._rareAscend = false
	self._levelAscend = false
	self._exSklAscend = false

	if self._btnTag[type] == 3 then
		self._faithAscend = not self._faithAscend
	else
		self._btnTag[type] = 3
	end

	self:_sortByFaith(isShowHero)
	self:_setCharacterCardList(self._curCardList)
end

function CharacterModel:_sortByFaith(isShowHero, isSortTag)
	if isShowHero then
		self:_updateShowHeroDict()
	else
		self._showHeroDict = {}
	end

	table.sort(self._curCardList, function(a, b)
		if self._fakeLevelDict then
			if not self._fakeLevelDict[a.heroId] then
				local aLevel = a.level

				if self._fakeLevelDict then
					if not self._fakeLevelDict[b.heroId] then
						local bLevel = b.level

						if not self._showHeroDict[a.heroId] then
							local aShowHeroScore = 0

							if not self._showHeroDict[b.heroId] then
								local bShowHeroScore = 0

								if self._tagCountDict then
									if not self._tagCountDict[a.heroId] then
										local aTagCount = 0

										if self._tagCountDict then
											if not self._tagCountDict[b.heroId] then
												local bTagCount = 0

												if bShowHeroScore < aShowHeroScore then
													return true
												elseif aShowHeroScore < bShowHeroScore then
													return false
												elseif a.isFavor ~= b.isFavor then
													return a.isFavor
												elseif isSortTag and aTagCount ~= bTagCount then
													return bTagCount < aTagCount
												elseif a.faith ~= b.faith then
													if self._faithAscend then
														return a.faith < b.faith
													else
														return a.faith > b.faith
													end
												elseif not isSortTag and aTagCount ~= bTagCount then
													return bTagCount < aTagCount
												elseif aLevel ~= bLevel then
													if self._faithAscend then
														return aLevel < bLevel
													else
														return bLevel < aLevel
													end
												elseif a.config.rare ~= b.config.rare then
													return a.config.rare > b.config.rare
												elseif a.exSkillLevel ~= b.exSkillLevel then
													return a.exSkillLevel > b.exSkillLevel
												elseif a.heroId ~= b.heroId then
													return a.heroId > b.heroId
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end)
end

function CharacterModel:setCardListByExSkill(isShowHero, type)
	self._btnTag[type] = self._btnTag[type] or 1
	self._btnTag[type] = 4
	self._rareAscend = false
	self._levelAscend = false
	self._faithAscend = false

	if self._btnTag[type] == 4 then
		self._exSklAscend = not self._exSklAscend
	else
		self._btnTag[type] = 4
	end

	self:_sortByExSkill(isShowHero)
	self:_setCharacterCardList(self._curCardList)
end

function CharacterModel:_sortByExSkill(isShowHero, isSortTag)
	if isShowHero then
		self:_updateShowHeroDict()
	else
		self._showHeroDict = {}
	end

	table.sort(self._curCardList, function(a, b)
		if self._fakeLevelDict then
			if not self._fakeLevelDict[a.heroId] then
				local aLevel = a.level

				if self._fakeLevelDict then
					if not self._fakeLevelDict[b.heroId] then
						local bLevel = b.level

						if not self._showHeroDict[a.heroId] then
							local aShowHeroScore = 0

							if not self._showHeroDict[b.heroId] then
								local bShowHeroScore = 0

								if self._tagCountDict then
									if not self._tagCountDict[a.heroId] then
										local aTagCount = 0

										if self._tagCountDict then
											if not self._tagCountDict[b.heroId] then
												local bTagCount = 0

												if bShowHeroScore < aShowHeroScore then
													return true
												elseif aShowHeroScore < bShowHeroScore then
													return false
												elseif a.isFavor ~= b.isFavor then
													return a.isFavor
												elseif isSortTag and aTagCount ~= bTagCount then
													return bTagCount < aTagCount
												elseif a.exSkillLevel ~= b.exSkillLevel then
													if self._exSklAscend then
														return a.exSkillLevel < b.exSkillLevel
													else
														return a.exSkillLevel > b.exSkillLevel
													end
												elseif not isSortTag and aTagCount ~= bTagCount then
													return bTagCount < aTagCount
												elseif aLevel ~= bLevel then
													return bLevel < aLevel
												elseif a.config.rare ~= b.config.rare then
													return a.config.rare > b.config.rare
												elseif a.faith ~= b.faith then
													return a.faith > b.faith
												elseif a.heroId ~= b.heroId then
													return a.heroId > b.heroId
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end)
end

function CharacterModel:setCardListByLangType(type, sortRare, sortTrust)
	self._btnTag[type] = self._btnTag[type] or 1
	self._levelAscend = false
	self._exSklAscend = false

	if sortTrust then
		if self._btnTag[type] == 3 then
			self._faithAscend = not self._faithAscend
		else
			self._btnTag[type] = 3
		end
	end

	if sortRare then
		if self._btnTag[type] == 2 then
			self._rareAscend = not self._rareAscend
		else
			self._btnTag[type] = 2
		end
	end

	self:_sortByLangTypeAndRareOrTrust(sortRare, sortTrust)
	self:_setCharacterCardList(self._curCardList)
end

function CharacterModel:_sortByLangTypeAndRareOrTrust(sortRare, sortTrust)
	table.sort(self._curCardList, function(a, b)
		if sortRare then
			local sortedByRare, sortRareResult = self:_sortByRareFunction(a, b)

			if sortedByRare then
				return sortRareResult
			end

			local sortedByLang, sortResult = self._sortByLangTypeFunction(a, b)

			if sortedByLang then
				return sortResult
			end
		elseif sortTrust then
			local sortedByTrust, sortTrustResult = self:_sortByTrustFunction(a, b)

			if sortedByTrust then
				return sortTrustResult
			end
		end

		if a.level ~= b.level then
			return a.level > b.level
		elseif a.heroId ~= b.heroId then
			return a.heroId > b.heroId
		end
	end)
end

function CharacterModel._sortByLangTypeFunction(char1, char2)
	local langId1, langStr1 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(char1.heroId)
	local langId2, langStr2 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(char2.heroId)

	if langId1 == langId2 then
		return false, nil
	end

	local supportLangList = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()
	local langOrder1 = 0
	local langOrder2 = 0

	for order, lang in ipairs(supportLangList) do
		if langStr1 == lang then
			langOrder1 = order
		end

		if langStr2 == lang then
			langOrder2 = order
		end
	end

	if langOrder1 == langOrder2 then
		return false, nil
	else
		return true, langOrder1 < langOrder2
	end
end

function CharacterModel:_sortByRareFunction(char1, char2)
	if char1.config.rare == char2.config.rare then
		return false, nil
	end

	if self._rareAscend then
		return true, char1.config.rare < char2.config.rare
	else
		return true, char1.config.rare > char2.config.rare
	end
end

function CharacterModel:_sortByTrustFunction(char1, char2)
	if char1.faith == char2.faith then
		return false, nil
	end

	if self._faithAscend then
		return true, char1.faith < char2.faith
	else
		return true, char1.faith > char2.faith
	end
end

function CharacterModel:getRankState()
	return {
		self._levelAscend and 1 or -1,
		self._rareAscend and 1 or -1,
		self._faithAscend and 1 or -1,
		self._exSklAscend and 1 or -1
	}
end

function CharacterModel:_isHeroInCardList(heroId)
	for _, v in pairs(self._curCardList) do
		if v.heroId == heroId then
			return true
		end
	end

	return false
end

function CharacterModel:filterCardListByDmgAndCareer(filterParam, isShowHero, type)
	self._btnTag[type] = self._btnTag[type] or 1
	self._curCardList = {}

	local heroList = tabletool.copy(self:_getHeroList())

	self:checkAppendHeroMOs(heroList)
	self:_filterHeroNewFunc(heroList, filterParam)

	if self._btnTag[type] == 1 then
		self:_sortByLevel(isShowHero, true)
	elseif self._btnTag[type] == 2 then
		self:_sortByRare(isShowHero, true)
	elseif self._btnTag[type] == 3 then
		self:_sortByFaith(isShowHero, true)
	elseif self._btnTag[type] == 4 then
		self:_sortByExSkill(isShowHero, true)
	end

	self:_setCharacterCardList(self._curCardList)
end

function CharacterModel:filterCardListByCareerAndCharType(filterParam, isShowHero, type)
	self._btnTag[type] = self._btnTag[type] or 2
	self._curCardList = {}

	local heroList = tabletool.copy(self:_getHeroList())

	self:checkAppendHeroMOs(heroList)

	local allCareerShow = #filterParam.careers >= 6
	local allCharTypeShow = #filterParam.charTypes >= 6
	local allCharLangType = filterParam.charLang == 0

	for _, v in pairs(heroList) do
		if allCareerShow and allCharTypeShow and allCharLangType then
			self._curCardList[#self._curCardList + 1] = v
		else
			local isCareers = allCareerShow or self:_filterHerobyCareer(filterParam.careers, v.config.career)
			local heroTypePass = allCharTypeShow or LuaUtil.tableContains(filterParam.charTypes, v:getHeroType())
			local heroId = v.heroId
			local langId, langStr = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(heroId)
			local charLangTypePass = allCharLangType or filterParam.charLang == 0 or filterParam.charLang == langId

			if isCareers and heroTypePass and charLangTypePass then
				self._curCardList[#self._curCardList + 1] = v
			end
		end
	end

	self:_sortByLangTypeAndRareOrTrust(self._btnTag[type] == 2, self._btnTag[type] == 3)
	self:_setCharacterCardList(self._curCardList)
end

function CharacterModel:_filterHeroNewFunc(heroList, filterParam)
	self._tagCountDict = {}

	local selectTags = CharacterSearchFilterModel.instance:getSelectLocalTags()

	for _, v in pairs(heroList) do
		local heroCo = v.config
		local isDmg = LuaUtil.tableContains(filterParam.dmgs, heroCo.dmgType)
		local career = heroCo.career
		local destiny = self:filterHerobyDestiny(v.heroId, filterParam.destiny)
		local isCareers = self:_filterHerobyCareer(filterParam.careers, career)
		local isFilterTag = selectTags and self:_isFilterTag(selectTags, v)

		if isDmg and destiny and isCareers and isFilterTag and not self:_isHeroInCardList(v.heroId) then
			table.insert(self._curCardList, v)
		end
	end
end

function CharacterModel:filterHerobyDestiny(heroId, destiny)
	self._filterDestinyHeros = self._filterDestinyHeros or {}

	if not destiny then
		return true
	end

	self._filterDestinyHeros[destiny] = self._filterDestinyHeros[destiny] or {}

	if self._filterDestinyHeros[destiny][heroId] then
		return self._filterDestinyHeros[destiny][heroId] == 1
	end

	if not CharacterDestinyConfig.instance:hasDestinyHero(heroId) then
		self._filterDestinyHeros[destiny][heroId] = 0

		return false
	end

	if destiny == 1 then
		table.insert(self._filterDestinyHeros[destiny], heroId)

		self._filterDestinyHeros[destiny][heroId] = 1

		return true
	elseif destiny == 2 then
		local ids = CharacterDestinyConfig.instance:getFacetIdsByHeroId(heroId)

		if ids then
			for _, facetsId in ipairs(ids) do
				local conusmeCo = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(facetsId)

				if conusmeCo and conusmeCo.type == CharacterDestinyEnum.StoneType.Reshape then
					self._filterDestinyHeros[destiny][heroId] = 1

					return true
				end
			end
		end
	end

	self._filterDestinyHeros[destiny][heroId] = 0

	return false
end

function CharacterModel:_filterHerobyCareer(list, career)
	if not list then
		return
	end

	if LuaUtil.tableContains(list, career) then
		return true
	end

	local careers = FightConfig.instance:getCareerList(career)

	for _, v in ipairs(careers) do
		if LuaUtil.tableContains(list, v) then
			return true
		end
	end
end

function CharacterModel:filterHerobyCareer_1(list, career)
	if not list then
		return
	end

	if list[career] then
		return true
	end

	local careers = FightConfig.instance:getCareerList(career)

	for _, v in ipairs(careers) do
		if list[v] then
			return true
		end
	end
end

function CharacterModel:_sortByTag()
	return
end

function CharacterModel:_isFilterTag(selectTags, heroMo)
	local battleTag = heroMo:getHeroBattleTag()

	return self:isFilterTagByBattleTags(selectTags, battleTag, heroMo.heroId)
end

function CharacterModel:isFilterTagByBattleTags(selectTags, battleTag, heroId)
	self._tagCountDict[heroId] = 0

	if not selectTags then
		return true
	end

	local count = tabletool.len(selectTags)

	if count == 0 then
		return true
	end

	local battleTags = string.split(battleTag, "#")
	local count1 = 0

	for _, list in pairs(selectTags) do
		local count2 = 0

		for _, tagId in ipairs(list) do
			if LuaUtil.tableContains(battleTags, tagId) then
				count2 = count2 + 1
			end
		end

		if #list > 0 and count2 == 0 then
			return false
		end

		count1 = count1 + count2
	end

	self._tagCountDict[heroId] = count1

	return true
end

function CharacterModel:clearTagCountDict()
	self._tagCountDict = {}
end

function CharacterModel:setCardListByCareerIndex(index, isShowHero)
	if isShowHero then
		self:_updateShowHeroDict()
	else
		self._showHeroDict = {}
	end

	self._curCardList = {}
	self._curRankIndex = index

	local heroList = tabletool.copy(self:_getHeroList())

	self:checkAppendHeroMOs(heroList)

	if self._curRankIndex == 0 then
		for _, v in pairs(heroList) do
			table.insert(self._curCardList, v)
		end
	else
		for _, v in pairs(heroList) do
			if v.config.career == index or self._showHeroDict[v.heroId] then
				table.insert(self._curCardList, v)
			end
		end
	end

	self:_setCharacterCardList(self._curCardList)
end

function CharacterModel:updateCardList(isShowHero)
	self:setCardListByCareerIndex(self._curRankIndex)

	if self._rareAscend then
		self:_sortByRare(isShowHero)
	elseif self._levelAscend then
		self:_sortByLevel(isShowHero)
	elseif self._faithAscend then
		self:_sortByFaith(isShowHero)
	elseif self._exSklAscend then
		self:_sortByExSkill(isShowHero)
	end

	self:_setCharacterCardList(self._curCardList)
end

function CharacterModel:getpassiveskills(heroid)
	local pskill = SkillConfig.instance:getpassiveskillsCO(heroid)

	if not pskill then
		return {}
	end

	local skills = {}

	for k, v in pairs(pskill) do
		skills[v.skillGroup] = skills[v.skillGroup] or {}
		skills[v.skillGroup].unlockId = skills[v.skillGroup].unlockId or {}
		skills[v.skillGroup].lockId = skills[v.skillGroup].lockId or {}

		if self:isPassiveUnlock(heroid, k) then
			skills[v.skillGroup].unlock = true

			table.insert(skills[v.skillGroup].unlockId, v.skillLevel)
		else
			table.insert(skills[v.skillGroup].lockId, v.skillLevel)
		end
	end

	local co = {}

	for _, v in pairs(skills) do
		table.sort(v.unlockId)
		table.sort(v.lockId)

		local o = {}

		o.unlockId = v.unlockId
		o.lockId = v.lockId
		o.unlock = v.unlock

		table.insert(co, o)
	end

	table.sort(co, function(a, b)
		local aValue = a.unlock and 1 or 0
		local bValue = b.unlock and 1 or 0

		if aValue ~= bValue then
			return bValue < aValue
		end
	end)

	return co
end

function CharacterModel:isPassiveUnlockByHeroMo(heroMo, value, passiveSkillLevel)
	local unlockids = passiveSkillLevel or heroMo.passiveSkillLevel

	for _, v in ipairs(unlockids) do
		if v == value then
			return true
		end
	end

	return false
end

function CharacterModel:isPassiveUnlock(heroid, value)
	return self:isPassiveUnlockByHeroMo(HeroModel.instance:getByHeroId(heroid), value)
end

function CharacterModel:getMaxUnlockPassiveLevel(heroId)
	local max = 0
	local unlockids = HeroModel.instance:getByHeroId(heroId).passiveSkillLevel

	for _, v in ipairs(unlockids) do
		max = max < v and v or max
	end

	return max
end

function CharacterModel:isHeroLevelReachCeil(heroId, level)
	local heroCo = HeroModel.instance:getByHeroId(heroId)

	level = level or heroCo.level

	return level >= self:getrankEffects(heroId, heroCo.rank)[1]
end

function CharacterModel:isHeroRankReachCeil(heroId)
	local rank = HeroModel.instance:getByHeroId(heroId).rank

	return rank == self:getMaxRank(heroId)
end

function CharacterModel:isHeroTalentReachCeil(heroId)
	local talent = HeroModel.instance:getByHeroId(heroId).talent

	return talent == self:getMaxTalent(heroId)
end

function CharacterModel:isHeroTalentLevelUnlock(heroId, lv)
	local talent = HeroModel.instance:getByHeroId(heroId).talent

	return lv <= talent
end

function CharacterModel:getrankEffects(heroid, rank)
	local skillCo = SkillConfig.instance:getherorankCO(heroid, rank)
	local effTab = {
		0,
		0,
		0
	}

	if not skillCo then
		return effTab
	end

	for _, v in pairs(string.split(skillCo.effect, "|")) do
		local effect = string.split(v, "#")

		if effect[1] == "1" then
			effTab[1] = tonumber(effect[2])
		elseif effect[1] == "2" then
			effTab[2] = tonumber(effect[2])
		elseif effect[1] == "3" then
			effTab[3] = tonumber(effect[2])
		end
	end

	return effTab
end

function CharacterModel:getMaxexskill(heroid)
	local skills = SkillConfig.instance:getheroexskillco(heroid)
	local max = 0

	for _, v in pairs(skills) do
		if max < v.skillLevel then
			max = v.skillLevel
		end
	end

	return max
end

function CharacterModel:getMaxLevel(heroid)
	local levels = SkillConfig.instance:getherolevelsCO(heroid)
	local max = 0

	for _, v in pairs(levels) do
		if max < v.level then
			max = v.level
		end
	end

	return max
end

function CharacterModel:getCurCharacterStage(heroid)
	local lv = HeroModel.instance:getByHeroId(heroid).level
	local stages = SkillConfig.instance:getherolevelsCO(heroid)
	local value = 0

	for _, v in pairs(stages) do
		if lv >= v.level and value < v.level then
			value = v.level
		end
	end

	return value
end

function CharacterModel:getMaxRank(heroid)
	local ranks = SkillConfig.instance:getheroranksCO(heroid)
	local max = 0

	for _, v in pairs(ranks) do
		if max < v.rank then
			max = v.rank
		end
	end

	return max
end

function CharacterModel:getMaxTalent(heroid)
	local talents = SkillConfig.instance:getherotalentsCo(heroid)
	local max = 0

	for _, v in pairs(talents) do
		if max < v.talentId then
			max = v.talentId
		end
	end

	return max
end

function CharacterModel:getAttributeCE(attribute, monsterLevel, log)
	local hp = attribute.hp
	local atk = attribute.atk
	local def = attribute.def
	local mdef = attribute.mdef
	local technic = attribute.technic
	local cri = attribute.cri
	local recri = attribute.recri
	local cri_dmg = attribute.cri_dmg
	local cri_def = attribute.cri_def
	local add_dmg = attribute.add_dmg
	local drop_dmg = attribute.drop_dmg
	local revive = attribute.revive
	local absorb = attribute.absorb
	local clutch = attribute.clutch
	local heal = attribute.heal
	local defense_ignore = attribute.defense_ignore
	local technicCriticalRatio = SkillConfig.instance:getConstNum(FightEnum.FightConstId.TechnicCriticalRatio)
	local technicCriticalDamageRatio = SkillConfig.instance:getConstNum(FightEnum.FightConstId.TechnicCriticalDamageRatio)
	local technicCorrectConst = SkillConfig.instance:getConstNum(FightEnum.FightConstId.TechnicCorrectConst)
	local technicTargetLevelRatio = SkillConfig.instance:getConstNum(FightEnum.FightConstId.TechnicTargetLevelRatio)
	local add_cri = math.floor(technic * technicCriticalRatio / (technicCorrectConst + monsterLevel * technicTargetLevelRatio)) / 1000
	local add_cri_dmg = math.floor(technic * technicCriticalDamageRatio / (technicCorrectConst + monsterLevel * technicTargetLevelRatio)) / 1000

	cri = cri + add_cri
	cri_dmg = cri_dmg + add_cri_dmg

	if log then
		logNormal(string.format("技巧折算%s = 暴击率%s + 暴击创伤%s", technic, add_cri, add_cri_dmg))
	end

	local atk_score = atk * 1
	local def_score = def * 0.5
	local mdef_score = mdef * 0.5
	local hp_score = hp * 0.0833
	local atk_cri_score = atk * 0.5 * cri * 0.5
	local atk_cri_dmg_score = math.max(0, atk * 0.5 * (cri_dmg - 1) * 0.5)
	local atk_add_dmg_score = atk * 0.5 * add_dmg
	local atk_defense_ignore_score = atk * 0.5 * defense_ignore
	local atk_absorb_score = atk * 0.5 * absorb * 0.66
	local atk_clutch_score = atk * 0.5 * clutch * 0.5
	local def_recri_score = (def + mdef) * 0.5 * recri * 0.5
	local def_cri_def_score = (def + mdef) * 0.5 * cri_def * 0.5
	local def_drop_dmg_score = (def + mdef) * 0.5 * drop_dmg
	local def_revive_score = (def + mdef) * 0.5 * revive * 0.66
	local def_heal_score = (def + mdef) * 0.5 * heal * 0.5
	local sum_score = hp_score + atk_score + def_score + mdef_score + atk_cri_score + atk_cri_dmg_score + atk_add_dmg_score + atk_defense_ignore_score + atk_absorb_score + atk_clutch_score + def_recri_score + def_cri_def_score + def_drop_dmg_score + def_revive_score + def_heal_score

	if log then
		logNormal(string.format("基础 %s   %s   %s   %s", atk_score, def_score, mdef_score, hp_score))
		logNormal(string.format("攻击附加 %s   %s   %s   %s   %s   %s", atk_cri_score, atk_cri_dmg_score, atk_add_dmg_score, atk_defense_ignore_score, atk_absorb_score, atk_clutch_score))
		logNormal(string.format("双防附加 %s   %s   %s   %s   %s", def_recri_score, def_cri_def_score, def_drop_dmg_score, def_revive_score, def_heal_score))
	end

	return sum_score
end

function CharacterModel:getCorrectCE(attributeCE, isSub, selfCareer, enemyCareerList, rare, exSkillLevel, levelCE)
	local correct1 = math.pow(attributeCE, 2.5) / math.pow(levelCE, 2.5)
	local correct2 = isSub and 0.7 or 1
	local correct3 = 0

	for _, enemyCareer in ipairs(enemyCareerList) do
		local restrain = FightConfig.instance:getRestrain(selfCareer, enemyCareer)

		if restrain > 1000 then
			correct3 = correct3 + 1
		elseif restrain < 1000 then
			correct3 = correct3 - 1
		end
	end

	correct3 = Mathf.Clamp(correct3, -1, 1)
	correct3 = 1 + 0.2 * correct3

	local correct4 = 1

	if not self._exSkillCorrectDict then
		self._exSkillCorrectDict = {}
		self._exSkillCorrectDict[5] = {
			1.33,
			1.55,
			1.66,
			1.77,
			1.88,
			2
		}
		self._exSkillCorrectDict[4] = {
			1.17,
			1.39,
			1.5,
			1.61,
			1.72,
			1.83
		}
		self._exSkillCorrectDict[3] = {
			1,
			1.22,
			1.33,
			1.44,
			1.55,
			1.66
		}
	end

	if self._exSkillCorrectDict[rare] and self._exSkillCorrectDict[rare][exSkillLevel] then
		correct4 = self._exSkillCorrectDict[rare][exSkillLevel]
	end

	correct4 = 1 + (correct4 - 1) * 0.5

	local sum_correct = correct1 * correct2 * correct3 * correct4

	return sum_correct, correct1, correct2, correct3, correct4
end

function CharacterModel:getMonsterAttribute(monsterId)
	local attribute = {}
	local monsterConfig = lua_monster.configDict[monsterId]
	local monsterTemplateConfig = lua_monster_template.configDict[monsterConfig.template]
	local level = monsterConfig.level

	attribute.hp = monsterTemplateConfig.life + level * monsterTemplateConfig.lifeGrow
	attribute.atk = monsterTemplateConfig.attack + level * monsterTemplateConfig.attackGrow
	attribute.def = monsterTemplateConfig.defense + level * monsterTemplateConfig.defenseGrow
	attribute.mdef = monsterTemplateConfig.mdefense + level * monsterTemplateConfig.mdefenseGrow
	attribute.technic = monsterTemplateConfig.technic + level * monsterTemplateConfig.technicGrow
	attribute.cri = monsterTemplateConfig.cri + level * monsterTemplateConfig.criGrow
	attribute.recri = monsterTemplateConfig.recri + level * monsterTemplateConfig.recriGrow
	attribute.cri_dmg = monsterTemplateConfig.criDmg + level * monsterTemplateConfig.criDmgGrow
	attribute.cri_def = monsterTemplateConfig.criDef + level * monsterTemplateConfig.criDefGrow
	attribute.add_dmg = monsterTemplateConfig.addDmg + level * monsterTemplateConfig.addDmgGrow
	attribute.drop_dmg = monsterTemplateConfig.dropDmg + level * monsterTemplateConfig.dropDmgGrow
	attribute.cri = attribute.cri / 1000
	attribute.recri = attribute.recri / 1000
	attribute.cri_dmg = attribute.cri_dmg / 1000
	attribute.cri_def = attribute.cri_def / 1000
	attribute.add_dmg = attribute.add_dmg / 1000
	attribute.drop_dmg = attribute.drop_dmg / 1000
	attribute.revive = 0
	attribute.absorb = 0
	attribute.clutch = 0
	attribute.heal = 0
	attribute.defense_ignore = 0

	return attribute
end

function CharacterModel:getCharacterAttributeWithEquip(heroId, equips)
	local attribute = {}
	local heroMO = HeroModel.instance:getByHeroId(heroId)

	attribute.hp = heroMO.baseAttr.hp
	attribute.atk = heroMO.baseAttr.attack
	attribute.def = heroMO.baseAttr.defense
	attribute.mdef = heroMO.baseAttr.mdefense
	attribute.technic = heroMO.baseAttr.technic
	attribute.cri = heroMO.exAttr.cri
	attribute.recri = heroMO.exAttr.recri
	attribute.cri_dmg = heroMO.exAttr.criDmg
	attribute.cri_def = heroMO.exAttr.criDef
	attribute.add_dmg = heroMO.exAttr.addDmg
	attribute.drop_dmg = heroMO.exAttr.dropDmg
	attribute.revive = heroMO.spAttr.revive
	attribute.absorb = heroMO.spAttr.absorb
	attribute.clutch = heroMO.spAttr.clutch
	attribute.heal = heroMO.spAttr.heal
	attribute.defense_ignore = heroMO.spAttr.defenseIgnore

	if equips and #equips > 0 then
		for i = 1, #equips do
			local equipMO = EquipModel.instance:getEquip(equips[i])

			if equipMO then
				local hp, atk, def, mdef, upAttrs = EquipConfig.instance:getEquipStrengthenAttrMax0(equipMO)

				attribute.hp = attribute.hp + hp
				attribute.atk = attribute.atk + atk
				attribute.def = attribute.def + def
				attribute.mdef = attribute.mdef + mdef
				attribute.cri = attribute.cri + upAttrs.cri
				attribute.recri = attribute.recri + upAttrs.recri
				attribute.cri_dmg = attribute.cri_dmg + upAttrs.criDmg
				attribute.cri_def = attribute.cri_def + upAttrs.criDef
				attribute.add_dmg = attribute.add_dmg + upAttrs.addDmg
				attribute.drop_dmg = attribute.drop_dmg + upAttrs.dropDmg
				attribute.revive = attribute.revive + upAttrs.revive
				attribute.absorb = attribute.absorb + upAttrs.absorb
				attribute.clutch = attribute.clutch + upAttrs.clutch
				attribute.heal = attribute.heal + upAttrs.heal
				attribute.defense_ignore = attribute.defense_ignore + upAttrs.defenseIgnore
			end
		end
	end

	attribute.cri = attribute.cri / 1000
	attribute.recri = attribute.recri / 1000
	attribute.cri_dmg = attribute.cri_dmg / 1000
	attribute.cri_def = attribute.cri_def / 1000
	attribute.add_dmg = attribute.add_dmg / 1000
	attribute.drop_dmg = attribute.drop_dmg / 1000
	attribute.revive = attribute.revive / 1000
	attribute.absorb = attribute.absorb / 1000
	attribute.clutch = attribute.clutch / 1000
	attribute.heal = attribute.heal / 1000
	attribute.defense_ignore = attribute.defense_ignore / 1000

	return attribute
end

function CharacterModel:getSumCE(heroList, subHeroList, allEquips, battleId, log)
	local battleConfig = lua_battle.configDict[battleId]
	local levelCE = battleConfig.battleEffectiveness

	if levelCE <= 0 then
		return 1
	end

	local monsterLevel = 0
	local enemyCareerList = {}
	local monsterConfigList = DungeonConfig.instance:getMonsterListFromGroupID(battleConfig.monsterGroupIds)

	for i, monsterConfig in ipairs(monsterConfigList) do
		table.insert(enemyCareerList, monsterConfig.career)

		monsterLevel = monsterLevel + monsterConfig.level
	end

	if #monsterConfigList > 0 then
		monsterLevel = monsterLevel / #monsterConfigList
	end

	local allCE = 0
	local playerMax = battleConfig.playerMax
	local count = 0

	for i, heroUid in ipairs(heroList) do
		local isSub = playerMax <= count
		local ce, hasCharacter = self:getCharacterCE(heroUid, battleConfig, enemyCareerList, levelCE, allEquips, isSub, monsterLevel, log)

		if hasCharacter then
			count = count + 1
		end

		allCE = allCE + ce
	end

	for i, heroUid in ipairs(subHeroList) do
		local isSub = playerMax <= count
		local ce, hasCharacter = self:getCharacterCE(heroUid, battleConfig, enemyCareerList, levelCE, allEquips, isSub, monsterLevel, log)

		if hasCharacter then
			count = count + 1
		end

		allCE = allCE + ce
	end

	local sumCE = allCE / levelCE / 4

	if log then
		logNormal(string.format("最终战力allCE = %s", allCE))
		logNormal(string.format("均值比例sumCE = %s", sumCE))
	end

	return sumCE
end

function CharacterModel:getCharacterCE(heroUid, battleConfig, enemyCareerList, levelCE, allEquips, isSub, monsterLevel, log)
	heroUid = tonumber(heroUid)

	if heroUid < 0 then
		local index = math.abs(heroUid)
		local monsterId = ((not string.nilorempty(battleConfig.aid) or nil) and string.splitToNumber(battleConfig.aid, "#"))[index]
		local monsterConfig = monsterId and lua_monster.configDict[monsterId]

		if not monsterConfig then
			return 0, false
		end

		local attribute = CharacterModel.instance:getMonsterAttribute(monsterId)

		if log then
			logNormal(string.format("助战角色monsterId = %s", monsterId))
		end

		local attributeCE = CharacterModel.instance:getAttributeCE(attribute, monsterLevel, log)

		if log then
			logNormal(string.format("属性战力attributeCE = %s", attributeCE))
		end

		local selfCareer = monsterConfig.career
		local rare = 1
		local exSkillLevel = monsterConfig.uniqueSkillLevel
		local correctCE, correct1, correct2, correct3, correct4 = CharacterModel.instance:getCorrectCE(attributeCE, isSub, selfCareer, enemyCareerList, rare, exSkillLevel, levelCE)
		local ce = attributeCE * correctCE

		if log then
			logNormal(string.format("战力修正correctCE = %s = 碾压修正%s x 替补修正%s x 克制修正%s x 仪式修正%s", correctCE, correct1, correct2, correct3, correct4))
			logNormal(string.format("角色战力ce = %s", ce))
		end

		return ce, true
	elseif heroUid > 0 then
		local heroMO = HeroModel.instance:getById(tostring(heroUid))

		if not heroMO then
			return 0, false
		end

		local heroId = heroMO.heroId
		local equips = {}

		for _, equip in ipairs(allEquips) do
			if tonumber(equip.heroUid) == heroUid then
				equips = equip.equipUid
			end
		end

		local attribute = CharacterModel.instance:getCharacterAttributeWithEquip(heroId, equips)

		if log then
			logNormal(string.format("玩家角色heroId = %s", heroId))
		end

		local attributeCE = CharacterModel.instance:getAttributeCE(attribute, monsterLevel, log)

		if log then
			logNormal(string.format("属性战力attributeCE = %s", attributeCE))
		end

		local heroConfig = heroMO.config
		local selfCareer = heroConfig.career
		local rare = heroConfig.rare
		local exSkillLevel = heroMO.exSkillLevel
		local correctCE, correct1, correct2, correct3, correct4 = CharacterModel.instance:getCorrectCE(attributeCE, isSub, selfCareer, enemyCareerList, rare, exSkillLevel, levelCE)
		local ce = attributeCE * correctCE

		if log then
			logNormal(string.format("战力修正correctCE = %s = 碾压修正%s x 替补修正%s x 克制修正%s x 仪式修正%s", correctCE, correct1, correct2, correct3, correct4))
			logNormal(string.format("角色战力ce = %s", ce))
		end

		return ce, true
	end

	return 0, false
end

function CharacterModel:isHeroCouldRankUp(heroid)
	if self:isHeroRankReachCeil(heroid) then
		return false
	end

	local heroData = HeroModel.instance:getByHeroId(heroid)
	local rankCo = SkillConfig.instance:getherorankCO(heroid, heroData.rank + 1)
	local demands = string.split(rankCo.requirement, "|")
	local consumes = string.split(rankCo.consume, "|")
	local could = true

	for _, v in pairs(demands) do
		local demand = string.splitToNumber(v, "#")

		if demand[1] == 1 and heroData.level < demand[2] then
			could = false
		end
	end

	for i = 1, #consumes do
		local consume = string.splitToNumber(consumes[i], "#")
		local quantity = ItemModel.instance:getItemQuantity(consume[1], consume[2])

		if quantity < consume[3] then
			could = false
		end
	end

	return could
end

function CharacterModel:isHeroFullDuplicateCount(heroid)
	local heroData = HeroModel.instance:getByHeroId(heroid)

	return heroData and CharacterEnum.MaxSkillExLevel <= heroData.duplicateCount
end

function CharacterModel:isHeroCouldExskillUp(heroid)
	local heroData = HeroModel.instance:getByHeroId(heroid)

	if CharacterEnum.MaxSkillExLevel <= heroData.exSkillLevel then
		return false
	end

	local exCo = SkillConfig.instance:getherolevelexskillCO(heroid, heroData.exSkillLevel + 1)

	if not exCo then
		logError(string.format("not found ExConfig, heroId : %s, exSkillLevel : %s", heroid, heroData.exSkillLevel + 1))

		return false
	end

	local consumes = string.split(exCo.consume, "|")
	local could = true

	for i = 1, #consumes do
		local consume = string.splitToNumber(consumes[i], "#")
		local count = ItemModel.instance:getItemQuantity(consume[1], consume[2])

		if count < consume[3] then
			could = false
		end
	end

	return could
end

function CharacterModel:hasRoleCouldUp()
	local could = false
	local heros = tabletool.copy(self:_getHeroList())

	self:checkAppendHeroMOs(heros)

	for _, v in pairs(heros) do
		if self:isHeroCouldExskillUp(v.heroId) and not HeroModel.instance:getByHeroId(v.heroId).isNew then
			could = true
		end
	end

	return could
end

function CharacterModel:hasRewardGet()
	local heros = tabletool.copy(self:_getHeroList())

	self:checkAppendHeroMOs(heros)

	for _, hero in pairs(heros) do
		if self:hasCultureRewardGet(hero.heroId) or self:hasItemRewardGet(hero.heroId) then
			return true
		end
	end

	return false
end

function CharacterModel:hasCultureRewardGet(heroId)
	for i = 1, 3 do
		local config = CharacterDataConfig.instance:getCharacterDataCO(heroId, CharacterDataConfig.DefaultSkinDataKey, CharacterEnum.CharacterDataItemType.Culture, i)

		if config and not string.nilorempty(config.unlockConditine) then
			local lock = CharacterDataConfig.instance:checkLockCondition(config)

			if not lock then
				local isGetReward = HeroModel.instance:checkGetRewards(heroId, 4 + i)

				if not isGetReward then
					return true
				end
			end
		end
	end

	return false
end

function CharacterModel:hasItemRewardGet(heroId)
	for i = 1, 3 do
		local lockCo = CharacterDataConfig.instance:getCharacterDataCO(heroId, CharacterDataConfig.DefaultSkinDataKey, CharacterEnum.CharacterDataItemType.Item, i)

		if lockCo and not string.nilorempty(lockCo.unlockConditine) then
			local islock = CharacterDataConfig.instance:checkLockCondition(lockCo)

			if not islock then
				local isGetRewards = HeroModel.instance:checkGetRewards(heroId, i + 1)

				if not isGetRewards then
					return true
				end
			end
		end
	end

	return false
end

function CharacterModel:setFakeList(list)
	self._fakeLevelDict = list
end

function CharacterModel:clearFakeList()
	self._fakeLevelDict = nil
end

function CharacterModel:setFakeLevel(heroId, level)
	self._fakeLevelDict = {}

	if heroId and level then
		self._fakeLevelDict[heroId] = level
	end
end

function CharacterModel:getFakeLevel(heroId)
	return self._fakeLevelDict and self._fakeLevelDict[heroId]
end

function CharacterModel:heroTalentRedPoint(heroId)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
		return false
	end

	local hero_mo_data = HeroModel.instance:getByHeroId(heroId)
	local cur_config = HeroResonanceConfig.instance:getTalentConfig(hero_mo_data.heroId, hero_mo_data.talent)

	if not cur_config then
		logError("共鸣表找不到,英雄id：", hero_mo_data.heroId, "共鸣等级：", hero_mo_data.talent)
	end

	local next_config = HeroResonanceConfig.instance:getTalentConfig(hero_mo_data.heroId, hero_mo_data.talent + 1)

	if not next_config then
		return false
	else
		if next_config.requirement > hero_mo_data.rank then
			return false
		end

		if string.nilorempty(next_config.consume) then
			logError("共鸣消耗配置为空，英雄id：" .. heroId .. "      共鸣等级:" .. next_config.talentId)

			return true
		end

		local item_list = ItemModel.instance:getItemDataListByConfigStr(next_config.consume, true, true)

		for i, v in ipairs(item_list) do
			if not ItemModel.instance:goodsIsEnough(v.materilType, v.materilId, v.quantity) then
				return false
			end
		end
	end

	return true
end

function CharacterModel:setAppendHeroMOs(heroList)
	self._appendHeroMOs = heroList
end

function CharacterModel:checkAppendHeroMOs(heroList)
	if self._appendHeroMOs then
		tabletool.addValues(heroList, self._appendHeroMOs)
	end
end

function CharacterModel:setGainHeroViewShowState(hide)
	self._hideGainHeroView = hide
end

function CharacterModel:getGainHeroViewShowState()
	return self._hideGainHeroView
end

function CharacterModel:setGainHeroViewNewShowState(hideOld)
	self._hideOldGainHeroView = hideOld
end

function CharacterModel:getGainHeroViewShowNewState()
	return self._hideOldGainHeroView
end

function CharacterModel:setGainHeroViewToastState(hideToast)
	self._hideHeroToast = hideToast
end

function CharacterModel:getGainHeroViewToastState()
	return self._hideHeroToast
end

function CharacterModel:getSpecialEffectDesc(skin, rank)
	local co = lua_character_limited.configDict[skin]
	local descList

	if co and not string.nilorempty(co.specialInsightDesc) then
		local effectDesc = string.split(co.specialInsightDesc, "#")

		if rank == tonumber(effectDesc[1]) - 1 then
			descList = {}

			for i = 2, #effectDesc do
				table.insert(descList, effectDesc[i])
			end
		end
	end

	return descList
end

local NuodikaReddot = {
	Card = 1,
	New = 0,
	All = 3,
	Spine = 2
}

function CharacterModel:isNeedShowNewSkillReddot(heroMO)
	if not heroMO or not heroMO:isOwnHero() then
		return
	end

	local co = lua_character_limited.configDict[heroMO.skin]

	if co and not string.nilorempty(co.specialLive2d) then
		local specialLive2d = string.split(co.specialLive2d, "#")

		if tonumber(specialLive2d[1]) == 1 then
			local rank = specialLive2d[2] and tonumber(specialLive2d[2]) or 3
			local isOverRank = heroMO.rank > rank - 1
			local curValue = self:_getNuodikaReddotValue(heroMO.heroId)
			local isCanShow = curValue ~= NuodikaReddot.Card and curValue ~= NuodikaReddot.All

			return isOverRank, isCanShow, co
		end
	end
end

CharacterModel.AnimKey_ReplaceSkillPlay = "CharacterSkillContainer_ReplaceSkill_"

function CharacterModel:isCanPlayReplaceSkillAnim(heroMO)
	local isOverRank, isCanShow, co = self:isNeedShowNewSkillReddot(heroMO)

	if isOverRank then
		local key = CharacterModel.AnimKey_ReplaceSkillPlay .. heroMO.heroId
		local curValue = self:_getNuodikaReddotValue(heroMO.heroId)
		local isPlayed = curValue == NuodikaReddot.Spine or curValue == NuodikaReddot.All
		local isCanPlayAnim = not isPlayed and GameUtil.playerPrefsGetNumberByUserId(key, 0) == 0

		return isCanPlayAnim, isCanShow, co
	end
end

function CharacterModel:cencelPlayReplaceSkillAnim(heroMO)
	GameUtil.playerPrefsSetNumberByUserId(CharacterModel.AnimKey_ReplaceSkillPlay .. heroMO.heroId, 1)

	local curValue = self:_getNuodikaReddotValue(heroMO.heroId)

	if curValue == NuodikaReddot.New then
		self:setPropKeyValueNuodikaReddot(heroMO.heroId, NuodikaReddot.Spine)
	elseif curValue == NuodikaReddot.Card then
		self:setPropKeyValueNuodikaReddot(heroMO.heroId, NuodikaReddot.All)
	end
end

function CharacterModel:cencelCardReddot(heroId)
	local curValue = self:_getNuodikaReddotValue(heroId)

	if curValue == NuodikaReddot.New then
		self:setPropKeyValueNuodikaReddot(heroId, NuodikaReddot.Card)
	elseif curValue == NuodikaReddot.Spine then
		self:setPropKeyValueNuodikaReddot(heroId, NuodikaReddot.All)
	end
end

function CharacterModel:_getNuodikaReddotValue(heroId)
	return PlayerModel.instance:getPropKeyValue(PlayerEnum.SimpleProperty.NuoDiKaNewSkill, heroId, NuodikaReddot.New)
end

function CharacterModel:setPropKeyValueNuodikaReddot(heroId, value)
	local property = PlayerEnum.SimpleProperty.NuoDiKaNewSkill

	PlayerModel.instance:setPropKeyValue(property, heroId, value)

	local propertyStr = PlayerModel.instance:getPropKeyValueString(property)

	PlayerRpc.instance:sendSetSimplePropertyRequest(property, propertyStr)
	GameUtil.playerPrefsSetNumberByUserId(CharacterModel.AnimKey_ReplaceSkillPlay .. heroId, value)
end

function CharacterModel:getReplaceSkillRank(heroMO)
	if not heroMO then
		return 0
	end

	return self:getReplaceSkillRankBySkinId(heroMO.skin)
end

function CharacterModel:getReplaceSkillRankBySkinId(skinId)
	if not skinId then
		return 0
	end

	local skin = skinId

	self._heroReplaceSkillRankDict = self._heroReplaceSkillRankDict or {}

	if not self._heroReplaceSkillRankDict[skin] then
		local co = lua_character_limited.configDict[skin]

		if co then
			local effectDesc = string.split(co.specialInsightDesc, "#")

			self._heroReplaceSkillRankDict[skin] = tonumber(effectDesc[1])
		end
	end

	return self._heroReplaceSkillRankDict[skin] or 1
end

CharacterModel.instance = CharacterModel.New()

return CharacterModel
