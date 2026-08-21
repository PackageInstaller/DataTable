-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterdepot/model/HeroDepotModel.lua

module("logic.extensions.characterdepot.model.HeroDepotModel", package.seeall)

local M = class("HeroDepotModel", BaseModel)

function M:ctor()
	M.super.ctor(self)

	self._heroDepotData = HeroDepotData.New()
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._heroDepotData:clearAllData()
	self:clearSortMark()
end

function M:getHeroDepotData()
	return self._heroDepotData
end

function M:clearSortMark()
	CharacterUtil.clearFilterRecord(CommEnum.HeroFilter.HeroDepot)
end

function M:sortDepotList()
	local _tmpHeroList = self:getHeroDepotData():getShowDataList()
	local sortData = CharacterUtil.SortAndFitler(CommEnum.HeroFilter.HeroDepot, _tmpHeroList:getMoList())

	return sortData
end

function M:setShowDataListSort(sortList)
	self._sortList = sortList
end

function M:getShowDataListSort()
	return self._sortList or self._heroDepotData:getShowDataList():getMoList()
end

function M:initHeroData(msg)
	for _, v in ipairs(msg.heros) do
		self:refreshHeroData(v, false)
	end
end

function M:refreshHeroData(hero, noticeEvent)
	local heroData = self._heroDepotData:getHeroDataById(hero.id)

	if heroData then
		heroData:updateHeroData(hero)

		if noticeEvent then
			GlobalDispatcher:dispatchEvent(EventType.REFRESH_HERO_FAVOR_INFO)
		end
	else
		heroData = CharacterData.New(hero)

		self._heroDepotData:addHeroData(heroData)
	end

	HeroFavorStorageModel.instance:updateHeroFavor(heroData)

	if noticeEvent then
		GlobalDispatcher:dispatchEvent(EventType.REFRESH_HERO_DEPOT_DATA, heroData)
	end
end

function M:getHeroInfoByID(heroid)
	return self._heroDepotData:getHeroDataById(heroid)
end

function M:getHeroDataByIndex(index)
	return self._heroDepotData:getHeroDataByIndex(index)
end

function M:getHeroAttrs(attrs, ...)
	local attrvalues = {}
	local args = {
		...
	}

	for gk, gv in ipairs(args) do
		local hasFind = false

		for _, v in pairs(attrs) do
			hasFind = v.attr == gv

			if hasFind then
				attrvalues[gv] = BattleMathUtil.removePrecisionAsInt(v.value)

				break
			end
		end

		if not hasFind then
			attrvalues[gv] = 0
		end
	end

	return attrvalues
end

function M:hasHero(heroId)
	return self:getHeroInfoByID(heroId) ~= false
end

function M:setViewType(viewType)
	self._viewType = viewType
end

function M:getViewType()
	return self._viewType
end

function M:getCurViewPageHeroData()
	local viewPageMo = self:getViewPageMo()

	if viewPageMo and viewPageMo.hero then
		return HeroDepotModel.instance:getHeroInfoByID(viewPageMo.hero:getId())
	end

	return nil
end

function M:getCurViewPageHeroId()
	local heroId
	local heroData = self:getCurViewPageHeroData()

	if heroData then
		heroId = heroData:getId()
	end

	return heroId
end

function M:getCurViewPageHeroTags(isOnlyMain)
	local heroData = self:getCurViewPageHeroData()

	if heroData then
		return heroData:getTags(isOnlyMain)
	end

	return {}
end

function M:getExtraInfo()
	return self._extraInfo
end

function M:setExtraInfo(showExtra, sortType)
	self._extraInfo = {
		show = showExtra,
		sortType = sortType
	}
end

function M:setViewPageMo(modata)
	self._viewPageMo = modata
end

function M:getViewPageMo()
	return self._viewPageMo
end

function M:clearViewPageMo()
	self._viewPageMo = nil
end

M.instance = M.New()

return M
