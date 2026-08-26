-- chunkname: @modules/logic/sp01/assassin2/outside/model/AssassinBuildingLevelUpListModel.lua

module("modules.logic.sp01.assassin2.outside.model.AssassinBuildingLevelUpListModel", package.seeall)

local AssassinBuildingLevelUpListModel = class("AssassinBuildingLevelUpListModel", MixScrollModel)

function AssassinBuildingLevelUpListModel:init(buildingType)
	self.type = buildingType

	local buildingList = {}
	local buildingDict = AssassinConfig.instance:getBuildingTypeDict(buildingType)

	for _, buildingCo in pairs(buildingDict or {}) do
		table.insert(buildingList, buildingCo)
	end

	table.sort(buildingList, self._buildingSortFunc)
	self:setList(buildingList)
end

function AssassinBuildingLevelUpListModel._buildingSortFunc(aBuildingCo, bBuildingCo)
	return aBuildingCo.level < bBuildingCo.level
end

function AssassinBuildingLevelUpListModel:markNeedPlayOpenAnimItemCount(itemCount)
	self._needPlayOpenAnimItemCount = itemCount or 0
end

function AssassinBuildingLevelUpListModel:getNeedPlayOpenAnimItemCount()
	return self._needPlayOpenAnimItemCount or 0
end

function AssassinBuildingLevelUpListModel:onItemPlayOpenAnimDone()
	self._needPlayOpenAnimItemCount = self._needPlayOpenAnimItemCount - 1
end

AssassinBuildingLevelUpListModel.instance = AssassinBuildingLevelUpListModel.New()

return AssassinBuildingLevelUpListModel
