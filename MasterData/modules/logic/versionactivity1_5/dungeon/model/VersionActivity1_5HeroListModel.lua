-- chunkname: @modules/logic/versionactivity1_5/dungeon/model/VersionActivity1_5HeroListModel.lua

module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5HeroListModel", package.seeall)

local VersionActivity1_5HeroListModel = class("VersionActivity1_5HeroListModel", ListScrollModel)

function VersionActivity1_5HeroListModel:onInit()
	return
end

function VersionActivity1_5HeroListModel:reInit()
	return
end

function VersionActivity1_5HeroListModel:onOpenDispatchView(dispatchCo)
	self:initHeroList()
	self:initSelectedHeroList(dispatchCo.id)

	self.maxSelectCount = dispatchCo.maxCount
end

function VersionActivity1_5HeroListModel:resetSelectHeroList()
	self.selectedHeroList = {}
	self.selectedHeroIndexDict = {}
end

function VersionActivity1_5HeroListModel:onCloseDispatchView()
	self:clearSelectedHeroList()
end

function VersionActivity1_5HeroListModel:initHeroList()
	if self.heroList then
		return
	end

	self.heroList = {}

	for _, heroMo in ipairs(HeroModel.instance:getList()) do
		local dispatchHeroMo = VersionActivity1_5DispatchHeroMo.New()

		dispatchHeroMo:init(heroMo)
		table.insert(self.heroList, dispatchHeroMo)
	end
end

function VersionActivity1_5HeroListModel:initSelectedHeroList(dispatchId)
	self.selectedHeroList = {}
	self.selectedHeroIndexDict = {}

	if dispatchId then
		local dispatchMo = VersionActivity1_5DungeonModel.instance:getDispatchMo(dispatchId)

		if dispatchMo then
			for index, heroId in ipairs(dispatchMo.heroIdList) do
				local dispatchHeroMo = self:getDispatchHeroMo(heroId)

				if dispatchHeroMo then
					table.insert(self.selectedHeroList, dispatchHeroMo)

					self.selectedHeroIndexDict[dispatchHeroMo] = index
				else
					logError("not found dispatched hero id : " .. tostring(heroId))
				end
			end
		end
	end
end

function VersionActivity1_5HeroListModel:getDispatchHeroMo(heroId)
	for _, heroMo in ipairs(self.heroList) do
		if heroMo.heroId == heroId then
			return heroMo
		end
	end
end

function VersionActivity1_5HeroListModel:refreshHero()
	self:resortHeroList()
	self:setList(self.heroList)
end

function VersionActivity1_5HeroListModel:resortHeroList()
	table.sort(self.heroList, VersionActivity1_5HeroListModel._sortFunc)
end

function VersionActivity1_5HeroListModel._sortFunc(heroMo1, heroMo2)
	local heroMo1Dispatched = heroMo1:isDispatched()
	local heroMo2Dispatched = heroMo2:isDispatched()

	if heroMo1Dispatched ~= heroMo2Dispatched then
		return heroMo2Dispatched
	end

	if heroMo1.level ~= heroMo2.level then
		return heroMo1.level > heroMo2.level
	end

	if heroMo1.rare ~= heroMo2.rare then
		return heroMo1.rare > heroMo2.rare
	end

	return heroMo1.heroId > heroMo2.heroId
end

function VersionActivity1_5HeroListModel:canAddMo()
	return #self.selectedHeroList < self.maxSelectCount
end

function VersionActivity1_5HeroListModel:canChangeHeroMo()
	return self.dispatchViewStatus == VersionActivity1_5DungeonEnum.DispatchStatus.NotDispatch
end

function VersionActivity1_5HeroListModel:selectMo(mo)
	if not mo then
		return
	end

	for _, heroMo in ipairs(self.selectedHeroList) do
		if heroMo.heroId == mo.heroId then
			return
		end
	end

	table.insert(self.selectedHeroList, mo)

	self.selectedHeroIndexDict[mo] = #self.selectedHeroList

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.ChangeSelectedHero)
end

function VersionActivity1_5HeroListModel:deselectMo(mo)
	if not mo then
		return
	end

	local deleteIndex = 0

	for index, heroMo in ipairs(self.selectedHeroList) do
		if heroMo.heroId == mo.heroId then
			deleteIndex = index
		end
	end

	if deleteIndex > 0 then
		table.remove(self.selectedHeroList, deleteIndex)

		self.selectedHeroIndexDict[mo] = nil

		for index, heroMo in ipairs(self.selectedHeroList) do
			self.selectedHeroIndexDict[heroMo] = index
		end

		VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.ChangeSelectedHero)
	end
end

function VersionActivity1_5HeroListModel:getSelectedIndex(mo)
	return self.selectedHeroIndexDict[mo]
end

function VersionActivity1_5HeroListModel:getSelectedMoByIndex(index)
	return self.selectedHeroList[index]
end

function VersionActivity1_5HeroListModel:getSelectedHeroCount()
	return #self.selectedHeroList
end

function VersionActivity1_5HeroListModel:getSelectedHeroList()
	return self.selectedHeroList
end

function VersionActivity1_5HeroListModel:getSelectedHeroIdList()
	local heroIdList = {}

	for _, heroMo in ipairs(self.selectedHeroList) do
		table.insert(heroIdList, heroMo.heroId)
	end

	return heroIdList
end

function VersionActivity1_5HeroListModel:setDispatchViewStatus(status)
	self.dispatchViewStatus = status
end

function VersionActivity1_5HeroListModel:clearSelectedHeroList()
	self.selectedHeroList = nil
	self.selectedHeroIndexDict = nil
	self.dispatchViewStatus = nil
end

function VersionActivity1_5HeroListModel:clear()
	self:clearSelectedHeroList()

	self.heroList = nil
end

VersionActivity1_5HeroListModel.instance = VersionActivity1_5HeroListModel.New()

return VersionActivity1_5HeroListModel
