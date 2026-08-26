-- chunkname: @modules/logic/herogroup/model/HeroGroupQuickEditListModel.lua

module("modules.logic.herogroup.model.HeroGroupQuickEditListModel", package.seeall)

local HeroGroupQuickEditListModel = class("HeroGroupQuickEditListModel", ListScrollModel)

function HeroGroupQuickEditListModel:copyQuickEditCardList()
	local moList = HeroGroupTrialModel.instance:isOnlyUseTrial() and {} or CharacterBackpackCardListModel.instance:getCharacterCardList()
	local newMOList = {}
	local repeatHero = {}

	self._inTeamHeroUidMap = {}
	self._inTeamHeroUidList = {}
	self._originalHeroUidList = {}
	self._selectUid = nil

	local _, assistMo = HeroGroupModel.instance:getAssistMo()
	local editorAssistMo = HeroGroupModel.instance:getEditorAssistMo()
	local _assistMo = editorAssistMo or assistMo and assistMo.assistMo

	if _assistMo then
		table.insert(newMOList, _assistMo.heroMO)
	end

	if assistMo then
		local posOpen = HeroGroupModel.instance:isPositionOpen(assistMo.id)

		if posOpen then
			self._inTeamHeroUidMap[assistMo.heroUid] = 1
			repeatHero[assistMo.heroUid] = true
		end
	end

	local alreadyList = HeroSingleGroupModel.instance:getList()

	for pos, heroSingleGroupMO in ipairs(alreadyList) do
		local isAssistPos = assistMo and assistMo.id == pos
		local posOpen = HeroGroupModel.instance:isPositionOpen(pos)
		local heroUid = heroSingleGroupMO.heroUid

		if not isAssistPos then
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
		end

		if posOpen then
			if assistMo and _assistMo and assistMo.id == pos then
				heroUid = _assistMo.heroUid
			end

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

	local isTowerBattle = self.isTowerBattle
	local isWeekWalk_2 = self.isWeekWalk_2
	local isAbyss = self.isAbyss
	local deathList = {}

	if isTowerBattle then
		for i = #newMOList, 1, -1 do
			if TowerModel.instance:isHeroBan(newMOList[i].heroId) then
				table.insert(deathList, newMOList[i])
				table.remove(newMOList, i)
			end
		end
	end

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
			elseif isWeekWalk_2 then
				local cd = WeekWalk_2Model.instance:getCurMapHeroCd(mo.heroId)

				if cd > 0 then
					table.insert(deathList, mo)
				else
					table.insert(newMOList, mo)
				end
			elseif isTowerBattle then
				if TowerModel.instance:isHeroBan(mo.heroId) then
					table.insert(deathList, mo)
				else
					table.insert(newMOList, mo)
				end
			elseif isAbyss then
				if AbyssModel.instance:isCurHeroLocked(mo.heroId) then
					table.insert(deathList, mo)
				else
					table.insert(newMOList, mo)
				end
			else
				table.insert(newMOList, mo)
			end
		end
	end

	if self.adventure or isTowerBattle or isWeekWalk_2 or isAbyss then
		tabletool.addValues(newMOList, deathList)
	end

	self:setList(newMOList)
end

function HeroGroupQuickEditListModel:keepSelect(selectIndex)
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

function HeroGroupQuickEditListModel:isInTeamHero(uid)
	return self._inTeamHeroUidMap and self._inTeamHeroUidMap[uid]
end

function HeroGroupQuickEditListModel:getHeroTeamPos(uid)
	if self._inTeamHeroUidList then
		for index, heroUid in pairs(self._inTeamHeroUidList) do
			if heroUid == uid then
				return index
			end
		end
	end

	return 0
end

function HeroGroupQuickEditListModel:selectHero(uid)
	local index = self:getHeroTeamPos(uid)

	if index ~= 0 then
		self._inTeamHeroUidList[index] = "0"
		self._inTeamHeroUidMap[uid] = nil

		self:onModelUpdate()

		self._selectUid = nil

		return true
	else
		if self:isTeamFull() then
			return false
		end

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

function HeroGroupQuickEditListModel:isRepeatHero(heroId, uid)
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

function HeroGroupQuickEditListModel:isTrialLimit()
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

function HeroGroupQuickEditListModel:inInTeam(uid)
	if not self._inTeamHeroUidMap then
		return false
	end

	return not not self._inTeamHeroUidMap[uid]
end

function HeroGroupQuickEditListModel:getHeroUids()
	return self._inTeamHeroUidList
end

function HeroGroupQuickEditListModel:getHeroUidByPos(pos)
	return self._inTeamHeroUidList[pos]
end

function HeroGroupQuickEditListModel:getIsDirty()
	for i = 1, #self._inTeamHeroUidList do
		if self._inTeamHeroUidList[i] ~= self._originalHeroUidList[i] then
			return true
		end
	end

	return false
end

function HeroGroupQuickEditListModel:cancelAllSelected()
	if self._scrollViews then
		for _, view in ipairs(self._scrollViews) do
			local mo = view:getFirstSelect()
			local index = self:getIndex(mo)

			view:selectCell(index, false)
		end
	end
end

function HeroGroupQuickEditListModel:isTeamFull()
	local limitRole = HeroGroupModel.instance:getBattleRoleNum() or 0

	for i = 1, math.min(limitRole, #self._inTeamHeroUidList) do
		local posOpen = HeroGroupModel.instance:isPositionOpen(i)

		if self._inTeamHeroUidList[i] == "0" and posOpen then
			return false
		end
	end

	return true
end

function HeroGroupQuickEditListModel:checkHeroIsError(uid)
	if not uid or tonumber(uid) < 0 then
		return
	end

	local mo = HeroModel.instance:getById(uid)

	if not mo then
		return
	end

	if self.adventure then
		local cd = WeekWalkModel.instance:getCurMapHeroCd(mo.heroId)

		if cd > 0 then
			return true
		end
	elseif self.isWeekWalk_2 then
		local cd = WeekWalk_2Model.instance:getCurMapHeroCd(mo.heroId)

		if cd > 0 then
			return true
		end
	elseif self.isTowerBattle then
		if TowerModel.instance:isHeroBan(mo.heroId) then
			return true
		end
	elseif self.isAbyss and AbyssModel.instance:isCurHeroLocked(mo.heroId) then
		return true
	end
end

function HeroGroupQuickEditListModel:cancelAllErrorSelected()
	local isError = false

	for k, v in pairs(self._inTeamHeroUidList) do
		if self:checkHeroIsError(v) then
			isError = true

			break
		end
	end

	if isError then
		self._inTeamHeroUidList = {}
	end
end

function HeroGroupQuickEditListModel:towerComposeSelectHero(uid)
	local index = self:getHeroTeamPos(uid)

	if index ~= 0 then
		self._inTeamHeroUidList[index] = "0"
		self._inTeamHeroUidMap[uid] = nil

		self:onModelUpdate()

		self._selectUid = nil

		return true
	else
		local startIndex = 1
		local endIndex = #self._inTeamHeroUidList
		local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
		local themeId = recordFightParam.themeId
		local curLockPlaneId = TowerComposeModel.instance:getCurLockPlaneId(themeId)

		if curLockPlaneId == 1 then
			startIndex = #self._inTeamHeroUidList / 2 + 1
		elseif curLockPlaneId == 2 then
			endIndex = #self._inTeamHeroUidList / 2
		end

		local isTeamFull = true

		for i = startIndex, endIndex do
			local posOpen = HeroGroupModel.instance:isPositionOpen(i)

			if self._inTeamHeroUidList[i] == "0" and posOpen then
				isTeamFull = false

				break
			end
		end

		if isTeamFull then
			return false
		end

		for i = startIndex, endIndex do
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

function HeroGroupQuickEditListModel:setParam(adventure, isTowerBattle, groupType)
	self.adventure = adventure
	self.isTowerBattle = isTowerBattle
	self._groupType = groupType
	self.isWeekWalk_2 = groupType == HeroGroupEnum.GroupType.WeekWalk_2
	self.isAbyss = groupType == HeroGroupEnum.GroupType.Abyss
end

function HeroGroupQuickEditListModel:clear()
	self._inTeamHeroUidMap = nil
	self._inTeamHeroUidList = nil
	self._originalHeroUidList = nil
	self._selectIndex = nil
	self._selectUid = nil

	HeroGroupQuickEditListModel.super.clear(self)
end

HeroGroupQuickEditListModel.instance = HeroGroupQuickEditListModel.New()

return HeroGroupQuickEditListModel
