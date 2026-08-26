-- chunkname: @modules/logic/room/utils/RoomBackBlockHelper.lua

module("modules.logic.room.utils.RoomBackBlockHelper", package.seeall)

local RoomBackBlockHelper = {}

RoomBackBlockHelper.State = {
	Near = 2,
	Back = 0,
	Map = 1
}

function RoomBackBlockHelper.isCanBack(blockMOList, backBlockMOList)
	if RoomBackBlockHelper.isHasInitBlock(backBlockMOList) then
		return false
	end

	local tMapDic = RoomBackBlockHelper._createMapDic(blockMOList)

	return RoomBackBlockHelper._isCanBackBlocks(tMapDic, backBlockMOList, true)
end

function RoomBackBlockHelper.resfreshInitBlockEntityEffect()
	local isBackMore = RoomMapBlockModel.instance:isBackMore()
	local initBlockList = RoomConfig.instance:getInitBlockList()
	local backBlockModel = RoomMapBlockModel.instance:getBackBlockModel()
	local scene = GameSceneMgr.instance:getCurScene()

	for i = 1, #initBlockList do
		local initBlockCfg = initBlockList[i]
		local blockMO = RoomMapBlockModel.instance:getFullBlockMOById(initBlockCfg.blockId)

		if blockMO then
			if isBackMore then
				backBlockModel:remove(blockMO)
				blockMO:setOpState(RoomBlockEnum.OpState.Back, false)
			else
				blockMO:setOpState(RoomBlockEnum.OpState.Normal)
			end

			local blockEntity = scene.mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)

			if blockEntity then
				blockEntity:refreshBlock()
			end
		end
	end
end

function RoomBackBlockHelper.sortBackBlockMOList(blockMOList, backBlockMOList)
	if not backBlockMOList or not blockMOList or RoomBackBlockHelper.isHasInitBlock(backBlockMOList) then
		return backBlockMOList
	end

	local tempList = {}
	local tSortList = {}
	local count = #backBlockMOList

	tabletool.addValues(tempList, backBlockMOList)

	local tMapDic = RoomBackBlockHelper._createMapDic(blockMOList)

	for times = 1, count do
		for i = 1, #tempList do
			table.insert(tSortList, tempList[i])

			if RoomBackBlockHelper._isCanBackBlocks(tMapDic, tSortList) then
				table.remove(tempList, i)

				break
			else
				table.remove(tSortList, #tSortList)
			end
		end

		if times > #tSortList then
			break
		end
	end

	tabletool.addValues(tSortList, tempList)

	for i = 1, #tSortList do
		backBlockMOList[i] = tSortList[i]
	end

	return backBlockMOList
end

function RoomBackBlockHelper.isHasInitBlock(backBlockMOList)
	local tRoomConfig = RoomConfig.instance

	for i = 1, #backBlockMOList do
		if tRoomConfig:getInitBlock(backBlockMOList[i].id) then
			return true
		end
	end

	return false
end

function RoomBackBlockHelper._isCanBackBlocks(tMapDic, backBlockMOList, isNotReset)
	if isNotReset == true then
		RoomBackBlockHelper._restMapDic(tMapDic)
	end

	RoomBackBlockHelper._setBackBlockMOList(tMapDic, backBlockMOList)
	RoomBackBlockHelper._findNearCount(tMapDic, 0, 0)

	return RoomBackBlockHelper._sumCountByState(tMapDic, RoomBackBlockHelper.State.Map) == 0
end

function RoomBackBlockHelper._setBackBlockMOList(tMapDic, backBlockMOList)
	local stateBack = RoomBackBlockHelper.State.Back

	for i = 1, #backBlockMOList do
		local hexPoint = backBlockMOList[i].hexPoint
		local yList = hexPoint and tMapDic[hexPoint.x]

		if yList then
			local value = yList[hexPoint.y]

			if value and value ~= stateBack then
				yList[hexPoint.y] = stateBack
			end
		end
	end
end

function RoomBackBlockHelper._sumCountByState(tMapDic, state)
	local count = 0

	for x, yList in pairs(tMapDic) do
		for y, value in pairs(yList) do
			if value == state then
				count = count + 1
			end
		end
	end

	return count
end

function RoomBackBlockHelper._restMapDic(tMapDic)
	local stateMap = RoomBackBlockHelper.State.Map

	for x, yList in pairs(tMapDic) do
		for y, value in pairs(yList) do
			yList[y] = stateMap
		end
	end
end

function RoomBackBlockHelper._createMapDic(blockMOList)
	local tMapDic = {}
	local stateMap = RoomBackBlockHelper.State.Map

	for i = 1, #blockMOList do
		local hexPoint = blockMOList[i].hexPoint
		local yList = tMapDic[hexPoint.x]

		if not yList then
			yList = {}
			tMapDic[hexPoint.x] = yList
		end

		yList[hexPoint.y] = stateMap
	end

	return tMapDic
end

function RoomBackBlockHelper._findNearCount(tMapDic, x, y, count)
	count = count or 0

	if tMapDic[x] then
		local va = tMapDic[x][y]

		if va == RoomBackBlockHelper.State.Map then
			count = count + 1
			tMapDic[x][y] = RoomBackBlockHelper.State.Near

			for i = 1, 6 do
				local nx, ny = RoomBackBlockHelper._getNearXY(x, y, i)

				count = RoomBackBlockHelper._findNearCount(tMapDic, nx, ny, count)
			end
		end

		return count
	end
end

function RoomBackBlockHelper._getNearXY(x, y, index)
	if index == 1 then
		return x - 1, y + 1
	elseif index == 2 then
		return x - 1, y
	elseif index == 3 then
		return x, y - 1
	elseif index == 4 then
		return x + 1, y - 1
	elseif index == 5 then
		return x + 1, y
	elseif index == 6 then
		return x, y + 1
	end
end

return RoomBackBlockHelper
