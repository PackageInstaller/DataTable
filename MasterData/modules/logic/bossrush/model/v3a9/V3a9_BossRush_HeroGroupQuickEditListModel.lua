-- chunkname: @modules/logic/bossrush/model/v3a9/V3a9_BossRush_HeroGroupQuickEditListModel.lua

module("modules.logic.bossrush.model.v3a9.V3a9_BossRush_HeroGroupQuickEditListModel", package.seeall)

local V3a9_BossRush_HeroGroupQuickEditListModel = class("V3a9_BossRush_HeroGroupQuickEditListModel", ListScrollModel)

function V3a9_BossRush_HeroGroupQuickEditListModel:copyQuickEditCardList()
	local moList = CharacterBackpackCardListModel.instance:getCharacterCardList()
	local newMOList = {}
	local repeatHero = {}

	self._stageMo = V3a9_BossRushModel.instance:getStageMo(self.actId, self.stage)
	self._inTeamHeroUidMap = {}
	self._inTeamHeroUidList = {}
	self._originalHeroUidList = {}
	self._selectUid = nil

	local assistMo = V3a9_BossRushModel.instance:getEditorAssistMo()
	local assistHeroUId

	if assistMo then
		assistHeroUId = assistMo.heroUid

		table.insert(newMOList, assistMo.heroMO)
	end

	local alreadyList = V3a9_BossRushModel.instance:getHeroUIds(self.stage)

	if alreadyList then
		for i, heroUid in pairs(alreadyList) do
			if heroUid and tonumber(heroUid) > 0 then
				self._inTeamHeroUidList[i] = heroUid
				self._originalHeroUidList[i] = heroUid
				repeatHero[heroUid] = true
				self._inTeamHeroUidMap[heroUid] = 1

				if not assistHeroUId or assistHeroUId ~= heroUid then
					table.insert(newMOList, HeroModel.instance:getById(heroUid))
				end
			end
		end
	end

	local editorList = V3a9_BossRushModel.instance:getEditorHeroList()

	if editorList then
		for i, heroUid in pairs(editorList) do
			if heroUid and tonumber(heroUid) > 0 then
				self._inTeamHeroUidList[i] = heroUid
				self._inTeamHeroUidMap[heroUid] = 1
			end
		end
	end

	for i, mo in ipairs(moList) do
		if not repeatHero[mo.uid] then
			table.insert(newMOList, mo)
		end
	end

	local pos = self:getEmptyPos()
	local deathList = {}

	for i = #newMOList, 1, -1 do
		if V3a9_BossRushModel.instance:isRestrict(newMOList[i].heroId, pos) and not repeatHero[newMOList[i].uid] then
			table.insert(deathList, newMOList[i])
			table.remove(newMOList, i)
		end
	end

	tabletool.addValues(newMOList, deathList)
	self:setList(newMOList)
end

function V3a9_BossRush_HeroGroupQuickEditListModel:keepSelect(selectIndex)
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

function V3a9_BossRush_HeroGroupQuickEditListModel:isInTeamHero(uid)
	return self._inTeamHeroUidMap and self._inTeamHeroUidMap[uid]
end

function V3a9_BossRush_HeroGroupQuickEditListModel:getHeroTeamPos(uid)
	if self._inTeamHeroUidList then
		for index, heroUid in pairs(self._inTeamHeroUidList) do
			if heroUid == uid then
				return index
			end
		end
	end

	return 0
end

function V3a9_BossRush_HeroGroupQuickEditListModel:selectHero(uid)
	local index = self:getHeroTeamPos(uid)

	if index ~= 0 then
		self._inTeamHeroUidList[index] = "0"
		self._inTeamHeroUidMap[uid] = nil

		V3a9_BossRushModel.instance:setEditorHeroList(self._inTeamHeroUidList)
		self:onModelUpdate()

		self._selectUid = nil

		return true
	else
		if self:isTeamFull() then
			return false
		end

		for i = 1, V3a9BossRushEnum.HeroCount do
			local heroUid = self._inTeamHeroUidList[i]

			if not heroUid or heroUid == 0 or heroUid == "0" then
				self._inTeamHeroUidList[i] = uid
				self._inTeamHeroUidMap[uid] = 1

				V3a9_BossRushModel.instance:setEditorHeroList(self._inTeamHeroUidList)
				self:onModelUpdate()

				return true
			end
		end

		self._selectUid = uid
	end

	return false
end

function V3a9_BossRush_HeroGroupQuickEditListModel:isRepeatHero(heroId, uid)
	if not self._inTeamHeroUidMap then
		return false
	end

	for inTeamUid in pairs(self._inTeamHeroUidMap) do
		if inTeamUid ~= "0" then
			local mo = self:getById(inTeamUid)

			if not mo then
				return false
			end

			if mo.heroId == heroId and uid ~= mo.uid then
				return true
			end
		end
	end

	return false
end

function V3a9_BossRush_HeroGroupQuickEditListModel:isTrialLimit()
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

function V3a9_BossRush_HeroGroupQuickEditListModel:inInTeam(uid)
	if not self._inTeamHeroUidMap then
		return false
	end

	return not not self._inTeamHeroUidMap[uid]
end

function V3a9_BossRush_HeroGroupQuickEditListModel:getHeroUids()
	return self._inTeamHeroUidList
end

function V3a9_BossRush_HeroGroupQuickEditListModel:getHeroUidByPos(pos)
	return self._inTeamHeroUidList[pos]
end

function V3a9_BossRush_HeroGroupQuickEditListModel:getIsDirty()
	for i = 1, V3a9BossRushEnum.HeroCount do
		local uid = self._inTeamHeroUidList[i]

		if uid ~= self._originalHeroUidList[i] then
			return true
		end
	end

	return false
end

function V3a9_BossRush_HeroGroupQuickEditListModel:cancelAllSelected()
	if self._scrollViews then
		for _, view in ipairs(self._scrollViews) do
			local mo = view:getFirstSelect()
			local index = self:getIndex(mo)

			view:selectCell(index, false)
		end
	end
end

function V3a9_BossRush_HeroGroupQuickEditListModel:isTeamFull()
	for i = 1, V3a9BossRushEnum.HeroCount do
		if self._inTeamHeroUidList[i] == "0" then
			return false
		end
	end
end

function V3a9_BossRush_HeroGroupQuickEditListModel:checkHeroIsError(uid)
	if not uid or tonumber(uid) < 0 then
		return
	end

	local mo = HeroModel.instance:getById(uid)

	if not mo then
		return
	end
end

function V3a9_BossRush_HeroGroupQuickEditListModel:cancelAllErrorSelected()
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

function V3a9_BossRush_HeroGroupQuickEditListModel:clear()
	self._inTeamHeroUidMap = nil
	self._inTeamHeroUidList = nil
	self._originalHeroUidList = nil
	self._selectIndex = nil
	self._selectUid = nil

	V3a9_BossRush_HeroGroupQuickEditListModel.super.clear(self)
end

function V3a9_BossRush_HeroGroupQuickEditListModel:setParam(actId, stage)
	self.actId = actId
	self.stage = stage
end

function V3a9_BossRush_HeroGroupQuickEditListModel:getEmptyPos(uid)
	if self._inTeamHeroUidList then
		for index = 1, V3a9BossRushEnum.HeroCount do
			local heroUid = self._inTeamHeroUidList[index]

			if not heroUid then
				return index
			end

			if heroUid == "0" or uid and heroUid == uid then
				return index
			end
		end
	end
end

function V3a9_BossRush_HeroGroupQuickEditListModel:checkIsAllHeroRestrict(isShowRestrictToast)
	local isAllHeroRestrict = false
	local emptPos = self:getEmptyPos()

	for i, heroMo in ipairs(self:getList()) do
		if not self:inInTeam(heroMo.uid) and V3a9_BossRushModel.instance:isRestrict(heroMo.heroId, emptPos) then
			isAllHeroRestrict = true

			break
		end
	end

	if isAllHeroRestrict and isShowRestrictToast then
		GameFacade.showToast(ToastEnum.BossRushHeroRestrict2)
	end

	return isAllHeroRestrict
end

V3a9_BossRush_HeroGroupQuickEditListModel.instance = V3a9_BossRush_HeroGroupQuickEditListModel.New()

return V3a9_BossRush_HeroGroupQuickEditListModel
