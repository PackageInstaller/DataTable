-- chunkname: @modules/logic/rouge/model/RougeHeroGroupQuickEditListModel.lua

module("modules.logic.rouge.model.RougeHeroGroupQuickEditListModel", package.seeall)

local RougeHeroGroupQuickEditListModel = class("RougeHeroGroupQuickEditListModel", ListScrollModel)

function RougeHeroGroupQuickEditListModel:calcTotalCapacity()
	local totalCapacity = 0

	for index, heroUid in pairs(self._inTeamHeroUidList) do
		local heroMo = HeroModel.instance:getById(heroUid)

		if heroMo then
			local capacity = RougeController.instance:getRoleStyleCapacity(heroMo, index > RougeEnum.FightTeamNormalHeroNum and not self._skipAssitType)

			totalCapacity = totalCapacity + capacity
		end
	end

	totalCapacity = totalCapacity + self:_getAssitCapacity()
	totalCapacity = totalCapacity + RougeHeroGroupEditListModel.instance:getAssistCapacity()

	return totalCapacity
end

function RougeHeroGroupQuickEditListModel:_isTeamCapacityEnough(posIndex, uid)
	local totalCapacity = 0
	local checkTarget = false

	for index, heroUid in pairs(self._inTeamHeroUidList) do
		local heroMo = HeroModel.instance:getById(heroUid)

		if heroUid == uid then
			checkTarget = true
		end

		if heroMo then
			local capacity = RougeController.instance:getRoleStyleCapacity(heroMo, index > RougeEnum.FightTeamNormalHeroNum and not self._skipAssitType)

			totalCapacity = totalCapacity + capacity
		end
	end

	if not checkTarget then
		local heroMo = HeroModel.instance:getById(uid)

		if heroMo then
			local capacity = RougeController.instance:getRoleStyleCapacity(heroMo, posIndex > RougeEnum.FightTeamNormalHeroNum and not self._skipAssitType)

			totalCapacity = totalCapacity + capacity
		end
	end

	totalCapacity = totalCapacity + self:_getAssitCapacity(posIndex, uid)
	totalCapacity = totalCapacity + RougeHeroGroupEditListModel.instance:getAssistCapacity()

	return totalCapacity <= RougeHeroGroupEditListModel.instance:getTotalCapacity()
end

function RougeHeroGroupQuickEditListModel:_getAssitCapacity(posIndex, uid)
	if self._edityType ~= RougeEnum.HeroGroupEditType.Fight then
		return 0
	end

	local tempTeamHeroUidList

	if posIndex and uid then
		tempTeamHeroUidList = {}

		for index, heroUid in pairs(self._inTeamHeroUidList) do
			if HeroModel.instance:getById(heroUid) then
				tempTeamHeroUidList[index] = heroUid
			elseif uid then
				tempTeamHeroUidList[index] = uid
				uid = nil
			end
		end
	end

	tempTeamHeroUidList = tempTeamHeroUidList or self._inTeamHeroUidList

	local totalCapacity = 0
	local tempList = RougeHeroSingleGroupModel.instance:getList()
	local groupList = {}
	local heroMap = {}

	for i, v in ipairs(tempList) do
		groupList[i] = nil

		if i <= RougeEnum.FightTeamNormalHeroNum then
			local heroUid = tempTeamHeroUidList[i]
			local heroMo = HeroModel.instance:getById(heroUid)

			groupList[i] = heroMo

			if heroMo then
				heroMap[heroMo.heroId] = heroMo
			end
		else
			local heroMo = v:getHeroMO()

			if heroMo and not heroMap[heroMo.heroId] and groupList[i - RougeEnum.FightTeamNormalHeroNum] then
				groupList[i] = heroMo
			end
		end
	end

	for i, heroMo in pairs(groupList) do
		if i > RougeEnum.FightTeamNormalHeroNum then
			local capacity = RougeController.instance:getRoleStyleCapacity(heroMo, i > RougeEnum.FightTeamNormalHeroNum and not self._skipAssitType)

			totalCapacity = totalCapacity + capacity
		end
	end

	return totalCapacity
end

function RougeHeroGroupQuickEditListModel:copyQuickEditCardList()
	self._edityType = RougeHeroGroupEditListModel.instance:getHeroGroupEditType()
	self._isSelectHeroType = self._edityType == RougeEnum.HeroGroupEditType.SelectHero
	self._isInitType = self._edityType == RougeEnum.HeroGroupEditType.Init
	self._skipAssitType = not self._isSelectHeroType and not self._isInitType
	self._battleRoleNum = self._isInitType and RougeEnum.InitTeamHeroNum or RougeEnum.DefaultTeamHeroNum

	local moList = self._isSelectHeroType and RougeHeroGroupEditListModel.instance:getSelectHeroList(CharacterBackpackCardListModel.instance:getCharacterCardList()) or self._edityType == RougeEnum.HeroGroupEditType.Init and CharacterBackpackCardListModel.instance:getCharacterCardList() or RougeHeroGroupEditListModel.instance:getTeamList(CharacterBackpackCardListModel.instance:getCharacterCardList())
	local newMOList = {}
	local repeatHero = {}

	self._inTeamHeroUidMap = {}
	self._inTeamHeroUidList = {}
	self._originalHeroUidList = {}
	self._assitPosIndex = {}
	self._selectUid = nil

	local alreadyList = RougeHeroSingleGroupModel.instance:getList()

	for pos, heroSingleGroupMO in ipairs(alreadyList) do
		local posOpen = self:isPositionOpen(pos)
		local heroUid = heroSingleGroupMO.heroUid

		if tonumber(heroUid) > 0 and not repeatHero[heroUid] then
			table.insert(newMOList, HeroModel.instance:getById(heroUid))

			if posOpen then
				self._inTeamHeroUidMap[heroUid] = 1
			end

			repeatHero[heroUid] = true
		else
			local singleGroupMo = RougeHeroSingleGroupModel.instance:getByIndex(pos)

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

		if pos > RougeEnum.FightTeamNormalHeroNum then
			self._assitPosIndex[heroUid] = pos
		end
	end

	local assistHeroId = RougeHeroGroupEditListModel.instance:getAssistHeroId()
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
			elseif mo.heroId ~= assistHeroId then
				table.insert(newMOList, mo)
			end
		end
	end

	if self.adventure then
		tabletool.addValues(newMOList, deathList)
	end

	self:setList(newMOList)
end

function RougeHeroGroupQuickEditListModel:keepSelect(selectIndex)
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

function RougeHeroGroupQuickEditListModel:isInTeamHero(uid)
	return self._inTeamHeroUidMap and self._inTeamHeroUidMap[uid]
end

function RougeHeroGroupQuickEditListModel:getHeroTeamPos(uid)
	if self._inTeamHeroUidList then
		for index, heroUid in pairs(self._inTeamHeroUidList) do
			if heroUid == uid then
				return index
			end
		end
	end

	return 0
end

function RougeHeroGroupQuickEditListModel:selectHero(uid)
	local index = self:getHeroTeamPos(uid)

	if index ~= 0 then
		self._inTeamHeroUidList[index] = "0"
		self._inTeamHeroUidMap[uid] = nil

		self:onModelUpdate()

		self._selectUid = nil

		return true
	else
		if self._isInitType and not self:_isTeamCapacityEnough(index, uid) then
			GameFacade.showToast(ToastEnum.RougeTeamCapacityFull)

			return false
		end

		if self._isSelectHeroType and not self:_isTeamCapacityEnough(index, uid) then
			GameFacade.showToast(ToastEnum.RougeTeamSelectHeroCapacityFull)

			return false
		end

		if self._edityType == RougeEnum.HeroGroupEditType.Fight and not self:_isTeamCapacityEnough(index, uid) then
			GameFacade.showToast(ToastEnum.RougeTeamSelectHeroCapacityFull)

			return false
		end

		if self:isTeamFull() then
			GameFacade.showToast(ToastEnum.RougeTeamFull)

			return false
		end

		for i = 1, #self._inTeamHeroUidList do
			local heroUid = self._inTeamHeroUidList[i]

			if heroUid == 0 or heroUid == "0" and not self:_skipAssistPos(i) then
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

function RougeHeroGroupQuickEditListModel:isRepeatHero(heroId, uid)
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

function RougeHeroGroupQuickEditListModel:isTrialLimit()
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

function RougeHeroGroupQuickEditListModel:inInTeam(uid)
	if not self._inTeamHeroUidMap then
		return false
	end

	return not not self._inTeamHeroUidMap[uid]
end

function RougeHeroGroupQuickEditListModel:getHeroUids()
	return self._inTeamHeroUidList
end

function RougeHeroGroupQuickEditListModel:getHeroUidByPos(pos)
	return self._inTeamHeroUidList[pos]
end

function RougeHeroGroupQuickEditListModel:getAssitPosIndex(uid)
	return self._assitPosIndex[uid]
end

function RougeHeroGroupQuickEditListModel:getIsDirty()
	for i = 1, #self._inTeamHeroUidList do
		if self._inTeamHeroUidList[i] ~= self._originalHeroUidList[i] then
			return true
		end
	end

	return false
end

function RougeHeroGroupQuickEditListModel:cancelAllSelected()
	if self._scrollViews then
		for _, view in ipairs(self._scrollViews) do
			local mo = view:getFirstSelect()
			local index = self:getIndex(mo)

			view:selectCell(index, false)
		end
	end
end

function RougeHeroGroupQuickEditListModel:isPositionOpen(index)
	if self._isSelectHeroType or self._isInitType then
		return true
	end

	return RougeHeroGroupModel.instance:isPositionOpen(index)
end

function RougeHeroGroupQuickEditListModel:isTeamFull()
	if self._isSelectHeroType then
		return false
	end

	local limitRole = self._battleRoleNum

	for i = 1, math.min(limitRole, #self._inTeamHeroUidList) do
		local posOpen = self:isPositionOpen(i)

		if self._inTeamHeroUidList[i] == "0" and posOpen and not self:_skipAssistPos(i) then
			return false
		end
	end

	return true
end

function RougeHeroGroupQuickEditListModel:_skipAssistPos(i)
	return RougeHeroGroupEditListModel.instance:getAssistPos() == i
end

function RougeHeroGroupQuickEditListModel:setParam(adventure)
	self.adventure = adventure
end

function RougeHeroGroupQuickEditListModel:clear()
	self._inTeamHeroUidMap = nil
	self._inTeamHeroUidList = nil
	self._originalHeroUidList = nil
	self._selectIndex = nil
	self._selectUid = nil

	RougeHeroGroupQuickEditListModel.super.clear(self)
end

RougeHeroGroupQuickEditListModel.instance = RougeHeroGroupQuickEditListModel.New()

return RougeHeroGroupQuickEditListModel
