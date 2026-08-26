-- chunkname: @modules/logic/rouge2/herogroup/model/Rouge2_HeroGroupEditListModel.lua

module("modules.logic.rouge2.herogroup.model.Rouge2_HeroGroupEditListModel", package.seeall)

local Rouge2_HeroGroupEditListModel = class("Rouge2_HeroGroupEditListModel", MixScrollModel)

function Rouge2_HeroGroupEditListModel:init(episodeId)
	self.episodeId = episodeId
	self.episodeCo = DungeonConfig.instance:getEpisodeCO(self.episodeId)
end

function Rouge2_HeroGroupEditListModel:copyCharacterCardList(init)
	self._inTeamHeroUids = {}

	if self._attrBuffId and self._attrBuffId ~= 0 then
		return self:_initRecommendTeamHeroList(init)
	else
		return self:_initNormalHeroList(init)
	end
end

function Rouge2_HeroGroupEditListModel:_initRecommendTeamHeroList(init)
	local moList = tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList())
	local newMOList = {}
	local selectIndex = 1

	self.sortIndexMap = {}

	for i, heroMo in ipairs(moList) do
		local hasBattleTag = Rouge2_SystemController.instance:checkHeroContainBattleTag(heroMo.heroId, self._battleTag)

		if hasBattleTag then
			table.insert(newMOList, heroMo)

			self.sortIndexMap[heroMo] = i
		end
	end

	if moList then
		if not #moList then
			local heroNum = 0
			local trialInfoList = Rouge2_BackpackController.instance:getActiveSkillTrialHeroList()

			if trialInfoList then
				for i, trialInfo in ipairs(trialInfoList) do
					local trialId = trialInfo[1]

					if not trialInfo[2] then
						local templateId = 0
						local trialCo = lua_hero_trial.configDict[trialId][templateId]
						local heroId = trialCo and trialCo.heroId

						if heroId and heroId ~= 0 then
							local hasBattleTag = Rouge2_SystemController.instance:checkHeroContainBattleTag(heroId, self._battleTag)

							if hasBattleTag then
								local heroMo = HeroMo.New()

								heroMo:initFromTrial(trialId, templateId)
								table.insert(newMOList, heroMo)

								self.sortIndexMap[heroMo] = heroNum + i
							end
						end
					end
				end
			end

			table.sort(newMOList, Rouge2_HeroGroupEditListModel.indexMapSortFunc)
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
	end
end

function Rouge2_HeroGroupEditListModel:_initNormalHeroList(init)
	local moList = HeroGroupTrialModel.instance:isOnlyUseTrial() and {} or tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList())
	local newMOList = {}
	local repeatHero = {}
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

	table.sort(newMOList, Rouge2_HeroGroupEditListModel.indexMapSortFunc)
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

function Rouge2_HeroGroupEditListModel.indexMapSortFunc(a, b)
	local aIndex = Rouge2_HeroGroupEditListModel.instance.sortIndexMap[a]
	local bIndex = Rouge2_HeroGroupEditListModel.instance.sortIndexMap[b]
	local isInTeam_A = Rouge2_HeroGroupEditListModel.instance:isInTeamHero(a.uid)
	local isInTeam_B = Rouge2_HeroGroupEditListModel.instance:isInTeamHero(b.uid)

	if isInTeam_A and isInTeam_B then
		return aIndex < bIndex
	end

	if isInTeam_A ~= isInTeam_B then
		return isInTeam_A
	end

	local isRecommend_A = Rouge2_SystemController.instance:isRecommendHero(a.heroId)
	local isRecommend_B = Rouge2_SystemController.instance:isRecommendHero(b.heroId)

	if isRecommend_A ~= isRecommend_B then
		return isRecommend_A
	elseif isRecommend_A and isRecommend_B then
		local isTrial_A = a:isTrial()
		local isTrial_B = b:isTrial()

		if isTrial_A ~= isTrial_B then
			return isTrial_A
		end
	end

	return aIndex < bIndex
end

function Rouge2_HeroGroupEditListModel:cancelAllSelected()
	if self._scrollViews then
		for _, view in ipairs(self._scrollViews) do
			local mo = view:getFirstSelect()
			local index = self:getIndex(mo)

			view:selectCell(index, false)
		end
	end
end

function Rouge2_HeroGroupEditListModel:isInTeamHero(uid)
	return self._inTeamHeroUids and self._inTeamHeroUids[uid]
end

function Rouge2_HeroGroupEditListModel:isRepeatHero(heroId, uid)
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

function Rouge2_HeroGroupEditListModel:isTrialLimit()
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

function Rouge2_HeroGroupEditListModel:setParam(heroUid)
	self.specialHero = heroUid
end

function Rouge2_HeroGroupEditListModel:setAttrBuffId(attrBuffId)
	self._attrBuffId = attrBuffId
	self._attrBuffCo = self._attrBuffId and Rouge2_BackpackHelper.getItemConfig(self._attrBuffId)
	self._battleTag = self._attrBuffCo and self._attrBuffCo.battleTag
	self._hasBattleTag = not string.nilorempty(self._battleTag)
	self._battleTagCo = self._hasBattleTag and HeroConfig.instance:getBattleTagConfigCO(self._battleTag)
end

function Rouge2_HeroGroupEditListModel:isAttrBuffTips()
	return self._attrBuffId and self._attrBuffId ~= 0
end

function Rouge2_HeroGroupEditListModel:getBattleTagConfig()
	return self._battleTagCo
end

Rouge2_HeroGroupEditListModel.instance = Rouge2_HeroGroupEditListModel.New()

return Rouge2_HeroGroupEditListModel
