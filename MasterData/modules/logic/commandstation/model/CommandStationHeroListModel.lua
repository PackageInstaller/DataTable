-- chunkname: @modules/logic/commandstation/model/CommandStationHeroListModel.lua

module("modules.logic.commandstation.model.CommandStationHeroListModel", package.seeall)

local CommandStationHeroListModel = class("CommandStationHeroListModel", ListScrollModel)

function CommandStationHeroListModel:initHeroList()
	if self:getCount() > 0 then
		return
	end

	local list = HeroModel.instance:getList()
	local normalList = {}
	local topList = {}
	local bottomList = {}

	for i, v in ipairs(list) do
		if self:heroIsUsed(v.heroId) then
			table.insert(bottomList, v)
		elseif self:heroIsSpecial(v.heroId) then
			table.insert(topList, v)
		else
			table.insert(normalList, v)
		end
	end

	tabletool.addValues(normalList, bottomList)
	tabletool.addValues(topList, normalList)
	self:setList(topList)
end

function CommandStationHeroListModel:clearHeroList()
	self:clear()
end

function CommandStationHeroListModel:clearSelectedHeroList()
	self._selectedHero = {}
end

function CommandStationHeroListModel:setSelectedHeroNum(num)
	self._maxSelectedHeroNum = num
	self._selectedHero = {}
end

function CommandStationHeroListModel:getEmptyIndex()
	for i = 1, self._maxSelectedHeroNum do
		if not self._selectedHero[i] then
			return i
		end
	end
end

function CommandStationHeroListModel:setSelectedHero(index, mo)
	self._selectedHero[index] = mo
	self._selectedHero[mo] = index

	CommandStationController.instance:dispatchEvent(CommandStationEvent.DispatchHeroListChange)
end

function CommandStationHeroListModel:cancelSelectedHero(mo)
	if not mo then
		return
	end

	local index = self._selectedHero[mo]

	self._selectedHero[mo] = nil

	if index then
		self._selectedHero[index] = nil
	end

	CommandStationController.instance:dispatchEvent(CommandStationEvent.DispatchHeroListChange)
end

function CommandStationHeroListModel:getHeroSelectedIndex(mo)
	return mo and self._selectedHero[mo]
end

function CommandStationHeroListModel:getHeroByIndex(index)
	return self._selectedHero and self._selectedHero[index]
end

function CommandStationHeroListModel:getSelectedHeroNum()
	for i = 1, self._maxSelectedHeroNum do
		if not self._selectedHero[i] then
			return i - 1
		end
	end

	return self._maxSelectedHeroNum
end

function CommandStationHeroListModel:getSelectedHeroIdList()
	local heroIdList = {}

	for _, heroMo in ipairs(self._selectedHero) do
		table.insert(heroIdList, heroMo.heroId)
	end

	return heroIdList
end

function CommandStationHeroListModel:setSpecialHeroList(list)
	self._specialHeroList = list
end

function CommandStationHeroListModel:heroIsSpecial(heroId)
	return self._specialHeroList and tabletool.indexOf(self._specialHeroList, heroId)
end

function CommandStationHeroListModel:initAllEventSelectedHeroList()
	self._allEventSelectedHeroList = CommandStationModel.instance:getAllEventHeroList()
end

function CommandStationHeroListModel:heroIsUsed(heroId)
	return self._allEventSelectedHeroList and self._allEventSelectedHeroList[heroId] ~= nil
end

CommandStationHeroListModel.instance = CommandStationHeroListModel.New()

return CommandStationHeroListModel
