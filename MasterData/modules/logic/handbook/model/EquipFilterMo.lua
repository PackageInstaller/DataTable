-- chunkname: @modules/logic/handbook/model/EquipFilterMo.lua

module("modules.logic.handbook.model.EquipFilterMo", package.seeall)

local EquipFilterMo = pureTable("EquipFilterMo")

function EquipFilterMo:init(viewName)
	self.viewName = viewName

	self:reset()
end

function EquipFilterMo:reset()
	self.obtainShowType = EquipFilterModel.ObtainEnum.All
	self.selectTagList = {}
	self.filtering = false
end

function EquipFilterMo:getObtainType()
	return self.obtainShowType
end

function EquipFilterMo:checkIsIncludeTag(equipConfig)
	if self.selectTagList and not next(self.selectTagList) then
		return true
	end

	local tagList = EquipConfig.instance:getTagList(equipConfig)

	for _, tagId in ipairs(tagList) do
		if tabletool.indexOf(self.selectTagList, tagId) then
			return true
		end
	end

	return false
end

function EquipFilterMo:updateIsFiltering()
	local var_5_0 = self.obtainShowType == EquipFilterModel.ObtainEnum.All and self.selectTagList and next(self.selectTagList) or true

	self.filtering = var_5_0
end

function EquipFilterMo:updateMo(filterMo)
	self.obtainShowType = filterMo.obtainShowType
	self.selectTagList = filterMo.selectTagList

	self:updateIsFiltering()
end

function EquipFilterMo:isFiltering()
	return self.filtering
end

function EquipFilterMo:clone()
	local filterMo = EquipFilterMo.New()

	filterMo:init(self.viewName)

	filterMo.obtainShowType = self.obtainShowType
	filterMo.selectTagList = tabletool.copy(self.selectTagList)
	filterMo.filtering = self.filtering

	return filterMo
end

return EquipFilterMo
