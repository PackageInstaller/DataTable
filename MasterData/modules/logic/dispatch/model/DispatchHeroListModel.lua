-- chunkname: @modules/logic/dispatch/model/DispatchHeroListModel.lua

module("modules.logic.dispatch.model.DispatchHeroListModel", package.seeall)

local DispatchHeroListModel = class("DispatchHeroListModel", ListScrollModel)

local function _sortFunc(heroMo1, heroMo2)
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

function DispatchHeroListModel:onInit()
	return
end

function DispatchHeroListModel:reInit()
	return
end

function DispatchHeroListModel:onOpenDispatchView(dispatchCo, elementId)
	self:initHeroList()
	self:initSelectedHeroList(elementId, dispatchCo and dispatchCo.id)

	if dispatchCo then
		self.maxSelectCount = dispatchCo.maxCount or 0
	end
end

function DispatchHeroListModel:initHeroList()
	if self.heroList then
		return
	end

	self.heroList = {}

	local allHeroList = HeroModel.instance:getList()

	for _, heroMo in ipairs(allHeroList) do
		local dispatchHeroMo = DispatchHeroMo.New()

		dispatchHeroMo:init(heroMo)
		table.insert(self.heroList, dispatchHeroMo)
	end
end

function DispatchHeroListModel:getDispatchHeroMo(heroId)
	if not self.heroList then
		return
	end

	for _, heroMo in ipairs(self.heroList) do
		if heroMo.heroId == heroId then
			return heroMo
		end
	end
end

function DispatchHeroListModel:refreshHero()
	if not self.heroList then
		return
	end

	table.sort(self.heroList, _sortFunc)
	self:setList(self.heroList)
end

function DispatchHeroListModel:resetSelectHeroList()
	self.selectedHeroList = {}
	self.selectedHeroIndexDict = {}
end

function DispatchHeroListModel:initSelectedHeroList(elementId, dispatchId)
	self:resetSelectHeroList()

	if not elementId or not dispatchId then
		return
	end

	local dispatchMo = DispatchModel.instance:getDispatchMo(elementId, dispatchId)

	if not dispatchMo then
		return
	end

	for index, heroId in ipairs(dispatchMo.heroIdList) do
		local dispatchHeroMo = self:getDispatchHeroMo(heroId)

		if dispatchHeroMo then
			table.insert(self.selectedHeroList, dispatchHeroMo)

			self.selectedHeroIndexDict[dispatchHeroMo] = index
		else
			logError(string.format("DispatchHeroListModel:initSelectedHeroList error, not found dispatched hero id: %s ", heroId))
		end
	end
end

function DispatchHeroListModel:canAddMo()
	return #self.selectedHeroList < self.maxSelectCount
end

function DispatchHeroListModel:selectMo(mo)
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

	DispatchController.instance:dispatchEvent(DispatchEvent.ChangeSelectedHero)
end

function DispatchHeroListModel:deselectMo(mo)
	if not mo then
		return
	end

	local deleteIndex = self:getSelectedIndex(mo)

	if deleteIndex and deleteIndex > 0 then
		table.remove(self.selectedHeroList, deleteIndex)

		self.selectedHeroIndexDict[mo] = nil

		for index, heroMo in ipairs(self.selectedHeroList) do
			self.selectedHeroIndexDict[heroMo] = index
		end

		DispatchController.instance:dispatchEvent(DispatchEvent.ChangeSelectedHero)
	end
end

function DispatchHeroListModel:getSelectedIndex(mo)
	return self.selectedHeroIndexDict[mo]
end

function DispatchHeroListModel:getSelectedMoByIndex(index)
	return self.selectedHeroList[index]
end

function DispatchHeroListModel:getSelectedHeroIdList()
	local heroIdList = {}

	for _, heroMo in ipairs(self.selectedHeroList) do
		table.insert(heroIdList, heroMo.heroId)
	end

	return heroIdList
end

function DispatchHeroListModel:getSelectedHeroCount()
	return #self.selectedHeroList
end

function DispatchHeroListModel:getSelectedHeroList()
	return self.selectedHeroList
end

function DispatchHeroListModel:setDispatchViewStatus(status)
	self.dispatchViewStatus = status
end

function DispatchHeroListModel:canChangeHeroMo()
	return self.dispatchViewStatus == DispatchEnum.DispatchStatus.NotDispatch
end

function DispatchHeroListModel:clear()
	DispatchHeroListModel.super.clear(self)
	self:_clearData()
end

function DispatchHeroListModel:_clearData()
	self:resetSelectHeroList()

	self.heroList = nil
	self.dispatchViewStatus = nil
end

DispatchHeroListModel.instance = DispatchHeroListModel.New()

return DispatchHeroListModel
