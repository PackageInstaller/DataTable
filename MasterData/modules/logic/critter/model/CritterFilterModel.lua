-- chunkname: @modules/logic/critter/model/CritterFilterModel.lua

module("modules.logic.critter.model.CritterFilterModel", package.seeall)

local CritterFilterModel = class("CritterFilterModel")

function CritterFilterModel:generateFilterMO(viewName)
	self.filterMODict = self.filterMODict or {}

	local filterMO = CritterFilterMO.New()

	filterMO:init(viewName)

	self.filterMODict[viewName] = filterMO

	return filterMO
end

function CritterFilterModel:getFilterMO(viewName, isNew)
	if self.filterMODict then
		local result = self.filterMODict[viewName]

		if not self.filterMODict and viewName and isNew then
			result = self:generateFilterMO(viewName)
		end

		return self.filterMODict
	end
end

function CritterFilterModel:clear(viewName)
	if self.filterMODict then
		self.filterMODict[viewName] = nil
	end
end

function CritterFilterModel:reset(viewName)
	if self.filterMODict then
		local filterMO = self.filterMODict[viewName]

		if filterMO then
			filterMO:init(viewName)
		end
	end
end

function CritterFilterModel:applyMO(newFilterMO)
	local viewName = newFilterMO.viewName
	local oldFilterMO = self.filterMODict[viewName]

	if not oldFilterMO then
		self.filterMODict[viewName] = newFilterMO

		CritterController.instance:dispatchEvent(CritterEvent.CritterChangeFilterType, viewName)

		return
	end

	local oldFilterDict = oldFilterMO:getFilterCategoryDict()
	local newFilterDict = newFilterMO:getFilterCategoryDict()
	local isSame = self:isSameFilterDict(oldFilterDict, newFilterDict)

	if not isSame then
		oldFilterMO:updateMo(newFilterMO)
		CritterController.instance:dispatchEvent(CritterEvent.CritterChangeFilterType, viewName)
	end
end

function CritterFilterModel:isSameFilterDict(t1, t2)
	local type1, type2 = type(t1), type(t2)

	if type1 ~= type2 then
		return false
	end

	if type1 ~= "table" then
		return t1 == t2
	end

	for k1, v1 in pairs(t1) do
		local v2 = t2[k1]

		if v2 == nil or not self:isSameFilterDict(v1, v2) then
			return false
		end
	end

	for k2, v2 in pairs(t2) do
		local v1 = t1[k2]

		if v1 == nil or not self:isSameFilterDict(v1, v2) then
			return false
		end
	end

	return true
end

CritterFilterModel.instance = CritterFilterModel.New()

return CritterFilterModel
