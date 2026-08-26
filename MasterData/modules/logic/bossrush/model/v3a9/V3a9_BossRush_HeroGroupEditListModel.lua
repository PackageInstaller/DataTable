-- chunkname: @modules/logic/bossrush/model/v3a9/V3a9_BossRush_HeroGroupEditListModel.lua

module("modules.logic.bossrush.model.v3a9.V3a9_BossRush_HeroGroupEditListModel", package.seeall)

local V3a9_BossRush_HeroGroupEditListModel = class("V3a9_BossRush_HeroGroupEditListModel", ListScrollModel)

function V3a9_BossRush_HeroGroupEditListModel:setMoveHeroId(id)
	self._moveHeroId = id
end

function V3a9_BossRush_HeroGroupEditListModel:getMoveHeroIndex()
	return self._moveHeroIndex
end

function V3a9_BossRush_HeroGroupEditListModel:copyCharacterCardList(init)
	local moList = CharacterBackpackCardListModel.instance:getCharacterCardList()
	local newMOList = {}
	local repeatHero = {}
	local selectIndex = 1
	local index = 1

	self._inTeamHeroUids = {}
	self._heroPosUids = {}

	local assistMo = V3a9_BossRushModel.instance:getEditorAssistMo()
	local assistHeroUId

	if assistMo and assistMo.heroUid and assistMo.heroUid ~= "0" then
		assistHeroUId = assistMo.heroUid
		repeatHero[assistMo.heroUid] = true

		table.insert(newMOList, assistMo.heroMO)
	end

	local alreadyList = V3a9_BossRushModel.instance:getHeroUIds(self.stage)

	if alreadyList then
		for i, heroUid in pairs(alreadyList) do
			if heroUid and tonumber(heroUid) > 0 then
				if self.specialHero == heroUid then
					self._inTeamHeroUids[heroUid] = 2
					selectIndex = index
				else
					self._inTeamHeroUids[heroUid] = 1
					index = index + 1
				end

				repeatHero[heroUid] = true
				self._heroPosUids[i] = heroUid

				if not assistHeroUId or assistHeroUId ~= heroUid then
					table.insert(newMOList, HeroModel.instance:getById(heroUid))
				end
			end
		end
	end

	for i, mo in ipairs(moList) do
		if not repeatHero[mo.uid] then
			table.insert(newMOList, mo)
		end
	end

	local pos = self:getSelectPos()
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

function V3a9_BossRush_HeroGroupEditListModel:isRepeatHero(heroId, uid)
	if not self._inTeamHeroUids then
		return false
	end

	for inTeamUid in pairs(self._inTeamHeroUids) do
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

function V3a9_BossRush_HeroGroupEditListModel:isTrialLimit()
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

function V3a9_BossRush_HeroGroupEditListModel:cancelAllSelected()
	if self._scrollViews then
		for _, view in ipairs(self._scrollViews) do
			local mo = view:getFirstSelect()
			local index = self:getIndex(mo)

			view:selectCell(index, false)
		end
	end
end

function V3a9_BossRush_HeroGroupEditListModel:isInTeamHero(uid)
	return self._inTeamHeroUids and self._inTeamHeroUids[uid]
end

function V3a9_BossRush_HeroGroupEditListModel:setParam(actId, stage, heroUid, pos)
	self.specialHero = heroUid
	self.actId = actId
	self.stage = stage
	self.pos = pos
end

function V3a9_BossRush_HeroGroupEditListModel:getSelectPos()
	return self.pos
end

function V3a9_BossRush_HeroGroupEditListModel:getReplaceHeroList(uid)
	local list = {}

	index = index or self.pos

	if self._heroPosUids then
		for i, _uid in pairs(self._heroPosUids) do
			if index == i then
				list[i] = uid
			elseif _uid ~= uid then
				list[i] = _uid
			end
		end

		if not self._heroPosUids[index] then
			list[index] = uid
		end
	end

	return list
end

V3a9_BossRush_HeroGroupEditListModel.instance = V3a9_BossRush_HeroGroupEditListModel.New()

return V3a9_BossRush_HeroGroupEditListModel
