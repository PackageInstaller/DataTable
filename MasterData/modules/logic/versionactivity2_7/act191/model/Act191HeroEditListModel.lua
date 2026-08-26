-- chunkname: @modules/logic/versionactivity2_7/act191/model/Act191HeroEditListModel.lua

module("modules.logic.versionactivity2_7.act191.model.Act191HeroEditListModel", package.seeall)

local Act191HeroEditListModel = class("Act191HeroEditListModel", ListScrollModel)

function Act191HeroEditListModel:initData(param)
	self.specialHero = param.heroId
	self.specialIndex = param.index
	self.moList = {}
	self._index2HeroIdMap = {}

	local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	local mainTeamSize = gameInfo.mainTeamSize

	for _, heroInfo in ipairs(gameInfo.warehouseInfo.hero) do
		local mo = {}

		mo.heroId = heroInfo.heroId
		mo.star = heroInfo.star
		mo.exp = heroInfo.exp
		mo.inTeam = 0
		mo.config = Activity191Config.instance:getRoleCoByNativeId(heroInfo.heroId, heroInfo.star)

		local battleHeroInfo = gameInfo:getBattleHeroInfoInTeam(mo.heroId)

		if battleHeroInfo then
			mo.inTeam = 2
			self._index2HeroIdMap[battleHeroInfo.index] = mo.heroId
		else
			local subHeroInfo = gameInfo:getSubHeroInfoInTeam(mo.heroId)

			if subHeroInfo then
				mo.inTeam = 1
				self._index2HeroIdMap[subHeroInfo.index + mainTeamSize] = mo.heroId
			end
		end

		if mo.heroId == self.specialHero then
			mo.inTeam = 3
		end

		self.moList[#self.moList + 1] = mo
	end

	self:filterData(nil, Activity191Enum.SortRule.Down)

	if #self._scrollViews > 0 and self.specialHero and self.specialHero ~= 0 then
		for _, view in ipairs(self._scrollViews) do
			view:selectCell(1, true)
		end
	end
end

function Act191HeroEditListModel:filterData(tag, rule)
	local list

	if tag then
		list = {}

		for _, mo in ipairs(self.moList) do
			local tagArr = string.split(mo.config.tag, "#")

			if tabletool.indexOf(tagArr, tag) then
				list[#list + 1] = mo
			end
		end
	else
		list = tabletool.copy(self.moList)
	end

	table.sort(list, function(a, b)
		if a.inTeam == b.inTeam then
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
			return a.inTeam > b.inTeam
		end
	end)
	self:setList(list)
end

function Act191HeroEditListModel:getHeroIdMap()
	local view = self._scrollViews[1]

	if view then
		local heroInfo = view:getFirstSelect()

		if heroInfo then
			local new = true

			for _, id in pairs(self._index2HeroIdMap) do
				if id == heroInfo.heroId then
					new = false

					break
				end
			end

			if new then
				self._index2HeroIdMap[self.specialIndex] = heroInfo.heroId
			end
		else
			self._index2HeroIdMap[self.specialIndex] = nil
		end
	end

	return self._index2HeroIdMap
end

Act191HeroEditListModel.instance = Act191HeroEditListModel.New()

return Act191HeroEditListModel
