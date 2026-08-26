-- chunkname: @modules/logic/handbook/model/EquipFilterModel.lua

module("modules.logic.handbook.model.EquipFilterModel", package.seeall)

local EquipFilterModel = class("EquipFilterModel")

EquipFilterModel.ObtainEnum = {
	Get = 1,
	All = 0,
	NotGet = 2
}

function EquipFilterModel.getAllTagList()
	return lua_equip_tag.configList
end

function EquipFilterModel:generateFilterMo(viewName)
	self.filterMoDict = self.filterMoDict or {}

	local filterMo = EquipFilterMo.New()

	filterMo:init(viewName)

	self.filterMoDict[viewName] = filterMo

	return filterMo
end

function EquipFilterModel:getFilterMo(viewName)
	return self.filterMoDict and self.filterMoDict[viewName]
end

function EquipFilterModel:clear(viewName)
	if self.filterMoDict then
		self.filterMoDict[viewName] = nil
	end
end

function EquipFilterModel:reset(viewName)
	if self.filterMoDict then
		local filterMo = self.filterMoDict[viewName]

		if filterMo then
			filterMo:init(viewName)
		end
	end
end

function EquipFilterModel:applyMo(filterMo)
	local viewName = filterMo.viewName
	local checkFilterMo = self.filterMoDict[viewName]

	if checkFilterMo.obtainShowType ~= filterMo.obtainShowType then
		checkFilterMo:updateMo(filterMo)
		EquipController.instance:dispatchEvent(EquipEvent.OnEquipTypeHasChange, viewName)

		return
	end

	if #filterMo.selectTagList ~= #checkFilterMo.selectTagList then
		checkFilterMo:updateMo(filterMo)
		EquipController.instance:dispatchEvent(EquipEvent.OnEquipTypeHasChange, viewName)

		return
	else
		local existTagDict = {}

		for _, tagId in ipairs(checkFilterMo.selectTagList) do
			existTagDict[tagId] = true
		end

		for _, tagId in ipairs(filterMo.selectTagList) do
			if not existTagDict[tagId] then
				checkFilterMo:updateMo(filterMo)
				EquipController.instance:dispatchEvent(EquipEvent.OnEquipTypeHasChange, viewName)

				return
			end
		end
	end
end

EquipFilterModel.instance = EquipFilterModel.New()

return EquipFilterModel
