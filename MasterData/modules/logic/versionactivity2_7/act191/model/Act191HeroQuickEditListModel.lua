-- chunkname: @modules/logic/versionactivity2_7/act191/model/Act191HeroQuickEditListModel.lua

module("modules.logic.versionactivity2_7.act191.model.Act191HeroQuickEditListModel", package.seeall)

local Act191HeroQuickEditListModel = class("Act191HeroQuickEditListModel", ListScrollModel)

function Act191HeroQuickEditListModel:initData()
	self._moList = {}
	self._index2HeroIdMap = {}
	self._heroId2IndexMap = {}
	self.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	local mainTeamSize = self.gameInfo.mainTeamSize

	for _, heroInfo in ipairs(self.gameInfo.warehouseInfo.hero) do
		local mo = {
			heroId = heroInfo.heroId,
			star = heroInfo.star,
			exp = heroInfo.exp,
			config = Activity191Config.instance:getRoleCoByNativeId(heroInfo.heroId, heroInfo.star)
		}
		local battleHeroInfo = self.gameInfo:getBattleHeroInfoInTeam(mo.heroId)

		if battleHeroInfo then
			self._index2HeroIdMap[battleHeroInfo.index] = mo.heroId
			self._heroId2IndexMap[mo.heroId] = battleHeroInfo.index
		else
			local subHeroInfo = self.gameInfo:getSubHeroInfoInTeam(mo.heroId)

			if subHeroInfo then
				self._index2HeroIdMap[subHeroInfo.index + mainTeamSize] = mo.heroId
				self._heroId2IndexMap[mo.heroId] = subHeroInfo.index + mainTeamSize
			end
		end

		self._moList[#self._moList + 1] = mo
	end

	self:filterData(nil, Activity191Enum.SortRule.Down)

	for _, view in ipairs(self._scrollViews) do
		view:selectCell(1, false)
	end
end

function Act191HeroQuickEditListModel:selectHero(heroId, isSelect)
	if isSelect then
		local emptyPos = self:findEmptyPos()

		if emptyPos ~= 0 then
			self._index2HeroIdMap[emptyPos] = heroId
			self._heroId2IndexMap[heroId] = emptyPos
		end
	else
		local index = self:getHeroTeamPos(heroId)

		self._index2HeroIdMap[index] = nil
		self._heroId2IndexMap[heroId] = nil
	end
end

function Act191HeroQuickEditListModel:getHeroTeamPos(heroId)
	return self._heroId2IndexMap[heroId] or 0
end

function Act191HeroQuickEditListModel:findEmptyPos()
	local pos = 0
	local maxCnt = self.gameInfo.mainTeamSize + self.gameInfo.subTeamSize

	for i = 1, maxCnt do
		if not self._index2HeroIdMap[i] then
			pos = i

			break
		end
	end

	return pos
end

function Act191HeroQuickEditListModel:filterData(tag, rule)
	local list

	if tag then
		list = {}

		for _, mo in ipairs(self._moList) do
			local tagArr = string.split(mo.config.tag, "#")

			if tabletool.indexOf(tagArr, tag) then
				list[#list + 1] = mo
			end
		end
	else
		list = tabletool.copy(self._moList)
	end

	table.sort(list, function(a, b)
		local aPos = self:getHeroTeamPos(a.heroId)

		aPos = aPos == 0 and 999 or aPos

		local bPos = self:getHeroTeamPos(b.heroId)

		bPos = bPos == 0 and 999 or bPos

		if aPos == bPos then
			if a.config.quality == b.config.quality then
				if a.config.exLevel == b.config.exLevel then
					return a.config.id < b.config.id
				else
					return a.config.exLevel > b.config.exLevel
				end
			elseif rule == Activity191Enum.SortRule.Down then
				return a.config.quality > b.config.quality
			else
				return a.config.quality < b.config.quality
			end
		else
			return aPos < bPos
		end
	end)
	self:setList(list)
end

function Act191HeroQuickEditListModel:getHeroIdMap()
	return self._index2HeroIdMap or {}
end

Act191HeroQuickEditListModel.instance = Act191HeroQuickEditListModel.New()

return Act191HeroQuickEditListModel
