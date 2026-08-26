-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotHeroGroupEditListModel.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotHeroGroupEditListModel", package.seeall)

local V1a6_CachotHeroGroupEditListModel = class("V1a6_CachotHeroGroupEditListModel", ListScrollModel)

function V1a6_CachotHeroGroupEditListModel:setMoveHeroId(id)
	self._moveHeroId = id
end

function V1a6_CachotHeroGroupEditListModel:getMoveHeroIndex()
	return self._moveHeroIndex
end

function V1a6_CachotHeroGroupEditListModel:setHeroGroupEditType(value)
	self._heroGroupEditType = value
end

function V1a6_CachotHeroGroupEditListModel:getHeroGroupEditType()
	return self._heroGroupEditType
end

function V1a6_CachotHeroGroupEditListModel:setSeatLevel(value)
	self._seatLevel = value
end

function V1a6_CachotHeroGroupEditListModel:getSeatLevel()
	return self._seatLevel
end

function V1a6_CachotHeroGroupEditListModel:copyCharacterCardList(init)
	local moList = CharacterBackpackCardListModel.instance:getCharacterCardList()

	if self._heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Fight then
		local teamInfo = V1a6_CachotModel.instance:getTeamInfo()
		local map = teamInfo:getAllHeroIdsMap()
		local result = {}
		local deadResult = {}

		for i, v in ipairs(moList) do
			if map[v.heroId] then
				local nowHp = teamInfo:getHeroHp(v.heroId)

				if nowHp.life > 0 then
					table.insert(result, v)
				else
					table.insert(deadResult, v)
				end
			end
		end

		tabletool.addValues(result, deadResult)

		moList = result
	end

	local newMOList = {}
	local repeatHero = {}

	self._inTeamHeroUids = {}

	local selectIndex = 1
	local index = 1
	local alreadyList = V1a6_CachotHeroSingleGroupModel.instance:getList()

	for i, heroSingleGroupMO in ipairs(alreadyList) do
		if heroSingleGroupMO.trial or not heroSingleGroupMO.aid and tonumber(heroSingleGroupMO.heroUid) > 0 and not repeatHero[heroSingleGroupMO.heroUid] then
			if heroSingleGroupMO.trial then
				table.insert(newMOList, HeroGroupTrialModel.instance:getById(heroSingleGroupMO.heroUid))
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

	for i, mo in ipairs(newMOList) do
		if self._moveHeroId and mo.heroId == self._moveHeroId then
			self._moveHeroId = nil
			self._moveHeroIndex = i

			break
		end
	end

	local groupHeroNum = #newMOList
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
			elseif self._moveHeroId and mo.heroId == self._moveHeroId then
				self._moveHeroId = nil
				self._moveHeroIndex = groupHeroNum + 1

				table.insert(newMOList, self._moveHeroIndex, mo)
			elseif self._heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Event then
				table.insert(newMOList, #newMOList - groupHeroNum + 1, mo)
			else
				table.insert(newMOList, mo)
			end
		end
	end

	if self.adventure then
		tabletool.addValues(newMOList, deathList)
	end

	self:setList(newMOList)

	if self._heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Event then
		local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
		local teamInfo = rogueInfo.teamInfo
		local heroList = teamInfo:getFightHeros()

		if #heroList == #newMOList then
			selectIndex = 0
		end
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

function V1a6_CachotHeroGroupEditListModel:isRepeatHero(heroId, uid)
	if not self._inTeamHeroUids then
		return false
	end

	for inTeamUid in pairs(self._inTeamHeroUids) do
		local mo = self:getById(inTeamUid)

		if mo.heroId == heroId and uid ~= mo.uid then
			return true
		end
	end

	return false
end

function V1a6_CachotHeroGroupEditListModel:isTrialLimit()
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

function V1a6_CachotHeroGroupEditListModel:cancelAllSelected()
	if self._scrollViews then
		for _, view in ipairs(self._scrollViews) do
			local mo = view:getFirstSelect()
			local index = self:getIndex(mo)

			view:selectCell(index, false)
		end
	end
end

function V1a6_CachotHeroGroupEditListModel:isInTeamHero(uid)
	return self._inTeamHeroUids and self._inTeamHeroUids[uid]
end

function V1a6_CachotHeroGroupEditListModel:setParam(heroUid, adventure)
	self.specialHero = heroUid
	self.adventure = adventure
end

V1a6_CachotHeroGroupEditListModel.instance = V1a6_CachotHeroGroupEditListModel.New()

return V1a6_CachotHeroGroupEditListModel
