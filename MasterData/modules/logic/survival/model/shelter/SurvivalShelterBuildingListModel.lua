-- chunkname: @modules/logic/survival/model/shelter/SurvivalShelterBuildingListModel.lua

module("modules.logic.survival.model.shelter.SurvivalShelterBuildingListModel", package.seeall)

local SurvivalShelterBuildingListModel = class("SurvivalShelterBuildingListModel", BaseModel)

function SurvivalShelterBuildingListModel:initViewParam()
	self.selectBuildingId = 0
end

function SurvivalShelterBuildingListModel:getSelectBuilding()
	return self.selectBuildingId
end

function SurvivalShelterBuildingListModel:setSelectBuilding(buildingId)
	if self.selectBuildingId == buildingId then
		return
	end

	self.selectBuildingId = buildingId

	return true
end

function SurvivalShelterBuildingListModel:isSelectBuilding(buildingId)
	return self.selectBuildingId == buildingId
end

function SurvivalShelterBuildingListModel:getShowList()
	local baseList = {}
	local tentList = {}
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingDict = weekInfo.buildingDict

	if buildingDict then
		for _, v in pairs(buildingDict) do
			if v:isEqualType(SurvivalEnum.BuildingType.Tent) then
				table.insert(tentList, v)
			else
				table.insert(baseList, v)
			end
		end
	end

	if #baseList > 1 then
		table.sort(baseList, SurvivalShelterBuildingMo.sort)
	end

	if #tentList > 1 then
		table.sort(tentList, SurvivalShelterBuildingMo.sort)
	end

	local dataList = {}
	local lineCount = 2

	for i, v in ipairs(baseList) do
		local index = math.floor((i - 1) / lineCount) + 1
		local item = dataList[index]

		if not item then
			item = {}
			dataList[index] = item
		end

		table.insert(item, v)
	end

	if self.selectBuildingId == nil or self.selectBuildingId == 0 then
		self.selectBuildingId = baseList[1] and baseList[1].id
	end

	return dataList, tentList
end

SurvivalShelterBuildingListModel.instance = SurvivalShelterBuildingListModel.New()

return SurvivalShelterBuildingListModel
