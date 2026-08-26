-- chunkname: @modules/logic/rouge/model/RougeHeroGroupEditListModel.lua

module("modules.logic.rouge.model.RougeHeroGroupEditListModel", package.seeall)

local RougeHeroGroupEditListModel = class("RougeHeroGroupEditListModel", ListScrollModel)

function RougeHeroGroupEditListModel:setMoveHeroId(id)
	self._moveHeroId = id
end

function RougeHeroGroupEditListModel:getMoveHeroIndex()
	return self._moveHeroIndex
end

function RougeHeroGroupEditListModel:setHeroGroupEditType(value)
	self._heroGroupEditType = value
	self._skipAssitType = self._heroGroupEditType == RougeEnum.HeroGroupEditType.Init or self._heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero
end

function RougeHeroGroupEditListModel:setCapacityInfo(selectHeroCapacity, curCapacity, totalCapacity, assistCapacity, assistPos, assistHeroId)
	self._selectHeroCapacity = selectHeroCapacity
	self._curCapacity = curCapacity
	self._totalCapacity = totalCapacity
	self._assistCapacity = assistCapacity or 0
	self._assistPos = assistPos
	self._assistHeroId = assistHeroId
end

function RougeHeroGroupEditListModel:getAssistHeroId()
	return self._assistHeroId
end

function RougeHeroGroupEditListModel:getAssistCapacity()
	return self._assistCapacity
end

function RougeHeroGroupEditListModel:getAssistPos()
	return self._assistPos
end

function RougeHeroGroupEditListModel:getTotalCapacity()
	return self._totalCapacity
end

function RougeHeroGroupEditListModel:canAddCapacity(index, newHeroMo)
	if not self._curCapacity or not self._totalCapacity then
		return false
	end

	local totalCapacity = self:calcTotalCapacity(index, newHeroMo)

	return totalCapacity <= self._totalCapacity
end

function RougeHeroGroupEditListModel:calcTotalCapacity(index, newHeroMo)
	local totalCapacity = 0
	local groupList = RougeHeroSingleGroupModel.instance:getList()
	local list = {}

	for i, mo in ipairs(groupList) do
		local heroMo = mo:getHeroMO()

		if heroMo == newHeroMo then
			heroMo = nil
		end

		if i == index then
			heroMo = newHeroMo
		end

		local isAssitType = i > RougeEnum.FightTeamNormalHeroNum and not self._skipAssitType

		if isAssitType and not list[i - RougeEnum.FightTeamNormalHeroNum] then
			heroMo = nil
		end

		list[i] = heroMo
	end

	for i, heroMo in pairs(list) do
		local capacity = RougeController.instance:getRoleStyleCapacity(heroMo, i > RougeEnum.FightTeamNormalHeroNum and not self._skipAssitType)

		totalCapacity = totalCapacity + capacity
	end

	totalCapacity = totalCapacity + self._assistCapacity

	return totalCapacity
end

function RougeHeroGroupEditListModel:getHeroGroupEditType()
	return self._heroGroupEditType
end

function RougeHeroGroupEditListModel:getTeamNoSortedList()
	local teamInfo = RougeModel.instance:getTeamInfo()
	local map = teamInfo.heroLifeMap
	local result = {}

	for k, hpInfo in pairs(map) do
		local heroMo = HeroModel.instance:getByHeroId(hpInfo.heroId)

		table.insert(result, heroMo)
	end

	return result
end

function RougeHeroGroupEditListModel:getTeamList(moList)
	local teamInfo = RougeModel.instance:getTeamInfo()
	local map = teamInfo.heroLifeMap
	local result = {}
	local deadResult = {}

	for i, v in ipairs(moList) do
		local hpInfo = map[v.heroId]

		if hpInfo then
			local heroMo = HeroModel.instance:getByHeroId(hpInfo.heroId)

			if hpInfo.life > 0 then
				table.insert(result, heroMo)
			else
				table.insert(deadResult, heroMo)
			end
		end
	end

	tabletool.addValues(result, deadResult)

	return result
end

function RougeHeroGroupEditListModel:getSelectHeroList(moList)
	local teamInfo = RougeModel.instance:getTeamInfo()
	local map = teamInfo.heroLifeMap
	local result = {}

	for i, v in ipairs(moList) do
		local hpInfo = map[v.heroId]

		if not hpInfo then
			table.insert(result, v)
		end
	end

	return result
end

function RougeHeroGroupEditListModel:copyCharacterCardList(init)
	local moList = CharacterBackpackCardListModel.instance:getCharacterCardList()

	if self._heroGroupEditType == RougeEnum.HeroGroupEditType.Fight or self._heroGroupEditType == RougeEnum.HeroGroupEditType.FightAssit then
		moList = self:getTeamList(moList)
	elseif self._heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
		moList = self:getSelectHeroList(moList)
	end

	local newMOList = {}
	local repeatHero = {}

	self._inTeamHeroUids = {}
	self._heroTeamPosIndex = {}

	local selectIndex = 1
	local index = 1
	local alreadyList = RougeHeroSingleGroupModel.instance:getList()

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
			self._heroTeamPosIndex[heroSingleGroupMO.heroUid] = i
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
			elseif mo.heroId ~= self._assistHeroId then
				table.insert(newMOList, mo)
			end
		end
	end

	if self.adventure then
		tabletool.addValues(newMOList, deathList)
	end

	self:setList(newMOList)

	if self._heroGroupEditType == RougeEnum.HeroGroupEditType.Init or self._heroGroupEditType == RougeEnum.HeroGroupEditType.FightAssit or self._heroGroupEditType == RougeEnum.HeroGroupEditType.Fight then
		if not self._selectHeroCapacity then
			do
				local selectHeroCapacity = 0

				if selectHeroCapacity <= 0 then
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
	end
end

function RougeHeroGroupEditListModel:isRepeatHero(heroId, uid)
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

function RougeHeroGroupEditListModel:isTrialLimit()
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

function RougeHeroGroupEditListModel:cancelAllSelected()
	if self._scrollViews then
		for _, view in ipairs(self._scrollViews) do
			local mo = view:getFirstSelect()
			local index = self:getIndex(mo)

			view:selectCell(index, false)
		end
	end
end

function RougeHeroGroupEditListModel:isInTeamHero(uid)
	return self._inTeamHeroUids and self._inTeamHeroUids[uid]
end

function RougeHeroGroupEditListModel:getTeamPosIndex(uid)
	return self._heroTeamPosIndex[uid]
end

function RougeHeroGroupEditListModel:setParam(heroUid, adventure)
	self.specialHero = heroUid
	self.adventure = adventure
end

RougeHeroGroupEditListModel.instance = RougeHeroGroupEditListModel.New()

return RougeHeroGroupEditListModel
