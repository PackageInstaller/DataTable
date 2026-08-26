-- chunkname: @modules/logic/critter/model/CritterIncubateListModel.lua

module("modules.logic.critter.model.CritterIncubateListModel", package.seeall)

local CritterIncubateListModel = class("CritterIncubateListModel", ListScrollModel)

function CritterIncubateListModel:setMoList(filterMO)
	self.moList = self:getMoList(filterMO)

	self:sortMoList(filterMO)

	return #self.moList
end

function CritterIncubateListModel:sortMoList(filterMO)
	self.moList = self.moList or self:getMoList(filterMO)

	local index = CritterIncubateModel.instance:getSortType()
	local sortWay = CritterIncubateModel.instance:getSortWay()
	local sortFun

	if index == CritterEnum.AttributeType.Efficiency then
		sortFun = sortWay and CritterHelper.sortByEfficiencyDescend or CritterHelper.sortByEfficiencyAscend
	elseif index == CritterEnum.AttributeType.Patience then
		sortFun = sortWay and CritterHelper.sortByPatienceDescend or CritterHelper.sortByPatienceAscend
	elseif index == CritterEnum.AttributeType.Lucky then
		sortFun = sortWay and CritterHelper.sortByLuckyDescend or CritterHelper.sortByLuckyAscend
	end

	if sortFun then
		table.sort(self.moList, sortFun)
	end

	self:setList(self.moList)
end

function CritterIncubateListModel:getMoList(filterMO)
	local allCritterList = CritterModel.instance:getCanIncubateCritters()
	local _moList = {}

	for i, critterMO in ipairs(allCritterList) do
		if filterMO and filterMO:isPassedFilter(critterMO) then
			table.insert(_moList, critterMO)
		end
	end

	return _moList
end

function CritterIncubateListModel:getMoIndex(mo)
	local moList = self:getList()
	local index = tabletool.indexOf(moList, mo)

	return index, #moList
end

CritterIncubateListModel.instance = CritterIncubateListModel.New()

return CritterIncubateListModel
