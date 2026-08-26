-- chunkname: @modules/logic/critter/model/CritterFilterMO.lua

module("modules.logic.critter.model.CritterFilterMO", package.seeall)

local CritterFilterMO = pureTable("CritterFilterMO")

function CritterFilterMO:init(viewName)
	self.viewName = viewName

	self:reset()
end

function CritterFilterMO:updateMo(filterMo)
	self._isFiltering = false
	self.filterCategoryDict = filterMo.filterCategoryDict

	for _, selectTagList in pairs(self.filterCategoryDict) do
		if #selectTagList > 0 then
			self._isFiltering = true
		end
	end
end

function CritterFilterMO:isPassedFilter(critterMO)
	local result = false

	if not critterMO then
		return result
	end

	local critterId = critterMO:getDefineId()
	local racePass = self:_checkRace(critterId)
	local skillTags = critterMO:getSkillInfo()
	local skillPass = self:_checkSkill(skillTags)

	result = racePass and skillPass

	return result
end

function CritterFilterMO:_checkRace(critterId)
	local catalogueId = CritterConfig.instance:getCritterCatalogue(critterId)

	return self:checkRaceByCatalogueId(catalogueId)
end

function CritterFilterMO:checkRaceByCatalogueId(catalogueId)
	local filterTabList = self.filterCategoryDict[CritterEnum.FilterType.Race]

	if not filterTabList or #filterTabList <= 0 then
		return true
	end

	local tCritterConfig = CritterConfig.instance

	for _, parentId in ipairs(filterTabList) do
		if parentId == catalogueId or tCritterConfig:isHasCatalogueChildId(parentId, catalogueId) then
			return true
		end
	end

	return false
end

function CritterFilterMO:_checkSkill(skillTags)
	local filterTabList = self.filterCategoryDict[CritterEnum.FilterType.SkillTag]

	if not filterTabList or #filterTabList <= 0 then
		return true
	end

	if not skillTags then
		return false
	end

	local result = false

	for _, skillTag in pairs(skillTags) do
		local skillTagCfg = CritterConfig.instance:getCritterTagCfg(skillTag)
		local skillFilterTagList = string.splitToNumber(skillTagCfg and skillTagCfg.filterTag, "#")

		for _, skillFilterTag in ipairs(skillFilterTagList) do
			if tabletool.indexOf(filterTabList, skillFilterTag) then
				result = true

				break
			end
		end
	end

	return result
end

function CritterFilterMO:isFiltering()
	return self._isFiltering
end

function CritterFilterMO:isSelectedTag(filterType, tagId)
	local selectedTagList = self.filterCategoryDict[filterType]

	return (selectedTagList and #selectedTagList > 0 or nil) and tabletool.indexOf(selectedTagList, tagId)
end

function CritterFilterMO:selectedTag(filterType, tagId)
	self.filterCategoryDict[filterType] = self.filterCategoryDict[filterType] or {}

	table.insert(self.filterCategoryDict[filterType], tagId)
end

function CritterFilterMO:unselectedTag(filterType, tagId)
	if self.filterCategoryDict[filterType] then
		tabletool.removeValue(self.filterCategoryDict[filterType], tagId)
	end
end

function CritterFilterMO:getFilterCategoryDict()
	return self.filterCategoryDict
end

function CritterFilterMO:clone()
	local filterMO = CritterFilterMO.New()

	filterMO:init(self.viewName)

	filterMO.filterCategoryDict = LuaUtil.deepCopySimple(self.filterCategoryDict)
	filterMO._isFiltering = self._isFiltering

	return filterMO
end

function CritterFilterMO:reset()
	self.filterCategoryDict = {}
	self._isFiltering = false
end

return CritterFilterMO
