-- chunkname: @modules/logic/survival/model/shelter/SurvivalShelterTentListModel.lua

module("modules.logic.survival.model.shelter.SurvivalShelterTentListModel", package.seeall)

local SurvivalShelterTentListModel = class("SurvivalShelterTentListModel", ListScrollModel)

function SurvivalShelterTentListModel:initViewParam(viewParam)
	if viewParam then
		self.selectBuildingId = viewParam.buildingId or 0
	end

	self.selectPos = nil
	self.selectNpcId = 0
	self._isQuickSelect = false
end

function SurvivalShelterTentListModel:isQuickSelect()
	return self._isQuickSelect
end

function SurvivalShelterTentListModel:changeQuickSelect()
	self._isQuickSelect = not self._isQuickSelect
end

function SurvivalShelterTentListModel:setSelectBuildingId(buildingId)
	if self.selectBuildingId == buildingId then
		return
	end

	self.selectBuildingId = buildingId
	self.selectPos = nil

	return true
end

function SurvivalShelterTentListModel:isSelectBuilding(buildingId)
	return self.selectBuildingId == buildingId
end

function SurvivalShelterTentListModel:getSelectBuilding()
	return self.selectBuildingId
end

function SurvivalShelterTentListModel:setSelectPos(pos)
	if self.selectPos == pos then
		return
	end

	self.selectPos = pos

	return true
end

function SurvivalShelterTentListModel:getSelectPos()
	return self.selectPos
end

function SurvivalShelterTentListModel:setSelectNpc(npcId)
	self.selectNpcId = self.selectNpcId == npcId and 0 or npcId

	return true
end

function SurvivalShelterTentListModel:getSelectNpc()
	return self.selectNpcId
end

function SurvivalShelterTentListModel:getShowList()
	local list = {}
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingDict = weekInfo.buildingDict

	if buildingDict then
		for _, v in pairs(buildingDict) do
			if v:isEqualType(SurvivalEnum.BuildingType.Tent) then
				table.insert(list, v)
			end
		end
	end

	if #list > 1 then
		table.sort(list, SurvivalShelterBuildingMo.sort)
	end

	local dataList = {}

	for _, v in ipairs(list) do
		local data = {}

		data.buildingInfo = v
		data.npcCount = v:getAttr(SurvivalEnum.AttrType.BuildNpcCapNum)
		data.npcNum = 0
		data.npcList = {}

		for i = 1, data.npcCount do
			data.npcList[i - 1] = 0
		end

		if v.npcs then
			for npcId, pos in pairs(v.npcs) do
				data.npcList[pos] = npcId
				data.npcNum = data.npcNum + 1
			end
		end

		table.insert(dataList, data)
	end

	return dataList
end

function SurvivalShelterTentListModel:refreshNpcList(filterList)
	local list = {}
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local npcDict = weekInfo.npcDict

	if npcDict then
		for _, v in pairs(npcDict) do
			if SurvivalBagSortHelper.filterNpc(filterList, v) then
				table.insert(list, v)
			end
		end
	end

	if #list > 1 then
		table.sort(list, SurvivalShelterNpcMo.sort)
	end

	self:setList(list)
end

function SurvivalShelterTentListModel:quickSelectNpc(npcId)
	local buildingId = self:getSelectBuilding()

	if not buildingId then
		return
	end

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local building = weekInfo:getBuildingInfo(buildingId)

	if not building then
		return
	end

	local tentBuildingId = weekInfo:getNpcPostion(npcId)

	if tentBuildingId == buildingId then
		if not self:isQuickSelect() then
			self.selectNpcId = 0
		end

		SurvivalWeekRpc.instance:sendSurvivalNpcChangePositionRequest(npcId, buildingId, -1)

		return
	end

	local npcCount = building:getAttr(SurvivalEnum.AttrType.BuildNpcCapNum)
	local dict = {}

	if building.npcs then
		for npcId, pos in pairs(building.npcs) do
			dict[pos] = npcId
		end
	end

	for i = 1, npcCount do
		if not dict[i - 1] then
			if not self:isQuickSelect() then
				self.selectNpcId = 0
			end

			SurvivalWeekRpc.instance:sendSurvivalNpcChangePositionRequest(npcId, buildingId, i - 1)

			return
		end
	end

	GameFacade.showToast(ToastEnum.SurvivalTentFull, building.baseCo.name)
end

SurvivalShelterTentListModel.instance = SurvivalShelterTentListModel.New()

return SurvivalShelterTentListModel
