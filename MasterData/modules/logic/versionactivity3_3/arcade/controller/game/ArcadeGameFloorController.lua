-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/ArcadeGameFloorController.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.ArcadeGameFloorController", package.seeall)

local ArcadeGameFloorController = class("ArcadeGameFloorController", BaseController)

function ArcadeGameFloorController:onInit()
	return
end

function ArcadeGameFloorController:onInitFinish()
	return
end

function ArcadeGameFloorController:addConstEvents()
	return
end

function ArcadeGameFloorController:reInit()
	return
end

function ArcadeGameFloorController:getFloorMOInGrid(x, y)
	local curRoom = ArcadeGameController.instance:getCurRoom()

	if not curRoom then
		return
	end

	local occupyData = curRoom:getEntityDataInTargetGrid(x, y, ArcadeGameEnum.EntityLayer.Floor)

	if not occupyData then
		return
	end

	return ArcadeGameModel.instance:getMOWithType(ArcadeGameEnum.EntityType.Floor, occupyData.uid)
end

function ArcadeGameFloorController:_checkCanAddFloor(floorId, x, y, sizeX, sizeY)
	local curRoom = ArcadeGameController.instance:getCurRoom()

	if not curRoom then
		return
	end

	local occupyFloorMO = self:getFloorMOInGrid(x, y)

	if occupyFloorMO and occupyFloorMO:getId() == floorId then
		occupyFloorMO:setCdRound(0)

		return
	end

	local priority = ArcadeConfig.instance:getFloorPriority(floorId)
	local needRemoveUids = {}

	for i = x, x + sizeX - 1 do
		for j = y, y + sizeY - 1 do
			occupyFloorMO = self:getFloorMOInGrid(i, j)

			if occupyFloorMO then
				local occupyId = occupyFloorMO:getId()
				local occupyPriority = ArcadeConfig.instance:getFloorPriority(occupyId)

				if priority < occupyPriority then
					return
				end

				needRemoveUids[#needRemoveUids + 1] = occupyFloorMO:getUid()
			end
		end
	end

	return true, needRemoveUids
end

function ArcadeGameFloorController:tryAddFloorByList(dataList)
	if not dataList or #dataList < 1 then
		return
	end

	local removeUidList = {}
	local addFloorEntityDataList = {}

	for _, data in ipairs(dataList) do
		local floorId = data.id
		local x = data.x
		local y = data.y
		local sizeX, sizeY = ArcadeConfig.instance:getFloorSize(floorId)
		local canAdd, needRemoveUids = self:_checkCanAddFloor(floorId, x, y, sizeX, sizeY)

		if canAdd then
			for _, uid in ipairs(needRemoveUids) do
				removeUidList[#removeUidList + 1] = uid
			end

			addFloorEntityDataList[#addFloorEntityDataList + 1] = {
				entityType = ArcadeGameEnum.EntityType.Floor,
				id = floorId,
				x = x,
				y = y,
				sizeX = sizeX,
				sizeY = sizeY
			}
		end
	end

	for _, floorUid in ipairs(removeUidList) do
		ArcadeGameController.instance:removeEntity(ArcadeGameEnum.EntityType.Floor, floorUid)
	end

	return (ArcadeGameController.instance:tryAddEntityList(addFloorEntityDataList, true))
end

ArcadeGameFloorController.instance = ArcadeGameFloorController.New()

return ArcadeGameFloorController
