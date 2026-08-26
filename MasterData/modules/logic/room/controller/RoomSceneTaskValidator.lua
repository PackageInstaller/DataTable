-- chunkname: @modules/logic/room/controller/RoomSceneTaskValidator.lua

module("modules.logic.room.controller.RoomSceneTaskValidator", package.seeall)

local RoomSceneTaskValidator = {}

function RoomSceneTaskValidator.getRoomSceneTaskStatus(taskMO)
	local cfg = taskMO.config

	if cfg then
		local taskType = cfg.listenerType
		local func = RoomSceneTaskValidator.handleMap[taskType]

		if func then
			local hasFinished, progress = func(taskMO)

			if progress < 0 then
				progress = 0
			end

			return hasFinished, progress
		end
	end

	return false, 0
end

function RoomSceneTaskValidator.canGetByLocal(taskMO)
	local cfg = taskMO.config

	if cfg then
		local taskType = cfg.listenerType
		local func = RoomSceneTaskValidator.handleMap[taskType]

		if func then
			return true
		end
	end

	return false
end

function RoomSceneTaskValidator.handleTotalBlock(taskMO)
	local list = RoomMapBlockModel.instance:getFullBlockMOList()
	local backModel = RoomMapBlockModel.instance:getBackBlockModel()
	local deleteCount = 0

	for _, mo in ipairs(list) do
		if mo.blockId ~= nil and mo.blockId < 0 and RoomMapBlockModel.instance:getTempBlockMO() ~= mo then
			deleteCount = deleteCount + 1
		end
	end

	if backModel then
		deleteCount = deleteCount + backModel:getCount()
	end

	local cfg = taskMO.config
	local tarCount = cfg.maxProgress
	local curProgress = #list - deleteCount

	if tarCount < curProgress then
		curProgress = tarCount
	end

	return tarCount <= curProgress, curProgress
end

function RoomSceneTaskValidator.handleResBlockCount(taskMO)
	local cfg = taskMO.config
	local tarParam = tonumber(cfg.listenerParam)
	local tarCount = cfg.maxProgress
	local list = RoomMapBlockModel.instance:getFullBlockMOList()
	local count = 0

	for _, mo in ipairs(list) do
		if (mo.blockId ~= nil and mo.blockId >= 0 or RoomMapBlockModel.instance:getTempBlockMO() == mo) and RoomSceneTaskValidator.containBlockMOResID(mo, tarParam) then
			count = count + 1
		end
	end

	local backModel = RoomMapBlockModel.instance:getBackBlockModel()

	if backModel then
		list = backModel:getList()

		for _, mo in ipairs(list) do
			if RoomSceneTaskValidator.containBlockMOResID(mo, tarParam) then
				count = count - 1
			end
		end
	end

	if tarCount < count then
		count = tarCount
	end

	return tarCount <= count, count
end

function RoomSceneTaskValidator.handleSubResBlockCount(taskMO)
	local cfg = taskMO.config
	local tarParam = tonumber(cfg.listenerParam)
	local tarCount = cfg.maxProgress
	local list = RoomMapBlockModel.instance:getFullBlockMOList()
	local count = 0

	for _, mo in ipairs(list) do
		if (mo.blockId ~= nil and mo.blockId >= 0 or RoomMapBlockModel.instance:getTempBlockMO() == mo) and RoomSceneTaskValidator.containSubMOResID(mo, tarParam) then
			count = count + 1
		end
	end

	local backModel = RoomMapBlockModel.instance:getBackBlockModel()

	if backModel then
		list = backModel:getList()

		for _, mo in ipairs(list) do
			if RoomSceneTaskValidator.containSubMOResID(mo, tarParam) then
				count = count - 1
			end
		end
	end

	if tarCount < count then
		count = tarCount
	end

	return tarCount <= count, count
end

function RoomSceneTaskValidator.handleBuildingCount(taskMO)
	local cfg = taskMO.config
	local tarCount = cfg.maxProgress
	local count = 0
	local buildingMap = RoomSceneTaskValidator.getAllBuildingInMap()

	for buildingUid, buildingMO in pairs(buildingMap) do
		count = count + 1
	end

	if tarCount < count then
		count = tarCount
	end

	return tarCount <= count, count
end

function RoomSceneTaskValidator.handleBuildingPower(taskMO)
	local cfg = taskMO.config
	local tarCount = cfg.maxProgress
	local power = 0
	local count = 0
	local buildingMap = RoomSceneTaskValidator.getAllBuildingInMap()

	for buildingUid, buildingMO in pairs(buildingMap) do
		power = power + buildingMO.config.buildDegree
		count = count + 1
	end

	if tarCount < power then
		power = tarCount
	end

	return tarCount <= power, count
end

function RoomSceneTaskValidator.getAllBuildingInMap()
	local buildingMap = {}
	local list = RoomMapBuildingModel.instance:getBuildingMOList()

	for _, buildingMO in pairs(list) do
		local isDelete = buildingMO == RoomMapBuildingModel.instance:getTempBuildingMO() and buildingMO.use

		if not isDelete and buildingMO.config then
			buildingMap[buildingMO.uid] = buildingMO
		end
	end

	local backModel = RoomMapBlockModel.instance:getBackBlockModel()

	if backModel then
		list = backModel:getList()

		for _, mo in ipairs(list) do
			local hexPoint = mo.hexPoint
			local buildingParam = RoomMapBuildingModel.instance:getBuildingParam(hexPoint.x, hexPoint.y)

			if buildingParam and buildingParam.buildingUid ~= nil then
				buildingMap[buildingParam.buildingUid] = nil
			end
		end
	end

	return buildingMap
end

function RoomSceneTaskValidator.containBlockMOResID(blockMO, targetResID)
	return blockMO.mainRes == targetResID
end

function RoomSceneTaskValidator.containSubMOResID(blockMO, targetResID)
	local resList = blockMO:getResourceList()

	for _, resID in pairs(resList) do
		if resID == targetResID then
			return true
		end
	end

	return false
end

RoomSceneTaskValidator.handleMap = {
	[RoomSceneTaskEnum.ListenerType.EditResArea] = RoomSceneTaskValidator.handleTotalBlock,
	[RoomSceneTaskEnum.ListenerType.EditResTypeReach] = RoomSceneTaskValidator.handleResBlockCount,
	[RoomSceneTaskEnum.ListenerType.EditHasResBlockCount] = RoomSceneTaskValidator.handleSubResBlockCount,
	[RoomSceneTaskEnum.ListenerType.BuildingUseCount] = RoomSceneTaskValidator.handleBuildingCount,
	[RoomSceneTaskEnum.ListenerType.BuildingDegree] = RoomSceneTaskValidator.handleBuildingPower
}

return RoomSceneTaskValidator
