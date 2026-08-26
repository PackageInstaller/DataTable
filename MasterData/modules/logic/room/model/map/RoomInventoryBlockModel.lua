-- chunkname: @modules/logic/room/model/map/RoomInventoryBlockModel.lua

module("modules.logic.room.model.map.RoomInventoryBlockModel", package.seeall)

local RoomInventoryBlockModel = class("RoomInventoryBlockModel", BaseModel)

function RoomInventoryBlockModel:onInit()
	self._selectPackageIds = {}

	self:_clearData()
end

function RoomInventoryBlockModel:reInit()
	self._selectPackageIds = {}
	self._unUseBlockList = {}

	self:_clearData()
end

function RoomInventoryBlockModel:clear()
	RoomInventoryBlockModel.super.clear(self)
	self:_clearData()
end

function RoomInventoryBlockModel:_clearData()
	if self._blockPackageModel then
		local packageMOList = self._blockPackageModel:getList()

		for _, packageMO in ipairs(packageMOList) do
			packageMO:clear()
		end

		self._blockPackageModel:clear()
	end

	self._blockPackageModel = BaseModel.New()
	self._unUseBlockList = self._unUseBlockList or {}
end

function RoomInventoryBlockModel:initInventory(tPackageIds, blockPackages, useBlockInfos, spercialBlockIds)
	self:_clearData()

	local blockPackageIds = {}

	tabletool.addValues(blockPackageIds, tPackageIds)

	blockPackages = blockPackages or {}

	local tAloneMap = self:_getSpercialMaps(spercialBlockIds)

	for i = 1, #blockPackageIds do
		local packageId = blockPackageIds[i]

		tAloneMap[packageId] = tAloneMap[packageId] or {}
	end

	for blockPackageId, tBlockIds in pairs(tAloneMap) do
		local blockPackageMO = RoomBlockPackageMO.New()

		blockPackageMO:init({
			id = blockPackageId
		}, tBlockIds)
		self._blockPackageModel:addAtLast(blockPackageMO)
	end

	self:addBlockPackageList(blockPackages)

	useBlockInfos = useBlockInfos or {}

	for i = 1, #useBlockInfos do
		self:placeBlock(useBlockInfos[i].blockId)
	end

	if not self:getCurPackageMO() and self._blockPackageModel:getCount() > 0 then
		local packageMO = self:_findHasUnUsePackageMO() or self._blockPackageModel:getByIndex(1)

		self:setSelectBlockPackageIds({
			packageMO.id
		})
		RoomHelper.hideBlockPackageReddot(packageMO.id)
	end
end

function RoomInventoryBlockModel:addSpecialBlockIds(spercialBlockIds)
	local tAloneMap = self:_getSpercialMaps(spercialBlockIds)

	for blockPackageId, tBlockIds in pairs(tAloneMap) do
		local blockPackageMO = self._blockPackageModel:getById(blockPackageId)

		if blockPackageMO then
			blockPackageMO:addBlockIdList(tBlockIds)
		else
			blockPackageMO = RoomBlockPackageMO.New()

			blockPackageMO:init({
				id = blockPackageId
			}, tBlockIds)
			self._blockPackageModel:addAtLast(blockPackageMO)
		end
	end
end

function RoomInventoryBlockModel:_getSpercialMaps(spercialBlockIds)
	local tAloneMap = {}

	spercialBlockIds = spercialBlockIds or {}

	local tRoomConfig = RoomConfig.instance

	for _, blockId in ipairs(spercialBlockIds) do
		local blockCfg = tRoomConfig:getBlock(blockId)

		if blockCfg then
			local tIds = tAloneMap[blockCfg.packageId]

			if not tIds then
				tIds = {}
				tAloneMap[blockCfg.packageId] = tIds
			end

			table.insert(tIds, blockId)
		end
	end

	return tAloneMap
end

function RoomInventoryBlockModel:_findHasUnUsePackageMO()
	local list = self._blockPackageModel:getList()

	for i = 1, #list do
		if list[i]:getUnUseCount() > 0 then
			return list[i]
		end
	end
end

function RoomInventoryBlockModel:addBlockPackageList(blockPackages)
	if not blockPackages then
		return
	end

	for i = 1, #blockPackages do
		local blockPackage = blockPackages[i]
		local blockPackageId = blockPackage.blockPackageId
		local blockPackageMO = self._blockPackageModel:getById(blockPackageId)

		if not blockPackageMO then
			blockPackageMO = RoomBlockPackageMO.New()

			blockPackageMO:init({
				id = blockPackageId
			})
			self._blockPackageModel:addAtLast(blockPackageMO)
		end

		blockPackageMO:reset()
		blockPackageMO:useBlockIds(blockPackage.useBlockIds)
	end
end

function RoomInventoryBlockModel:setSelectBlockPackageIds(packageIds)
	self._selectPackageIds = {}

	for _, packageId in ipairs(packageIds) do
		table.insert(self._selectPackageIds, packageId)
	end
end

function RoomInventoryBlockModel:isSelectBlockPackageById(packageId)
	local index = tabletool.indexOf(self._selectPackageIds, packageId)

	return not not index
end

function RoomInventoryBlockModel:rotateFirst(rotate)
	local firstBlockMO = self:getSelectInventoryBlockMO()

	if firstBlockMO then
		firstBlockMO.rotate = rotate
	end
end

function RoomInventoryBlockModel:placeBlock(blockId)
	if self._selectInventoryBlockId == blockId then
		self._selectInventoryBlockId = nil
	end

	local blockCfg = RoomConfig.instance:getBlock(blockId)

	if blockCfg then
		local packageMO = self._blockPackageModel:getById(blockCfg.packageId)

		if packageMO then
			packageMO:useBlockId(blockId)
		end

		tabletool.removeValue(self._unUseBlockList, blockId)
	else
		logError(string.format("地块配置中找不到地块. can not find blockCfg for BlockConfig : [blockId:%s]", blockId or "nil"))
	end
end

function RoomInventoryBlockModel:blackBlocksByIds(blockIds)
	for _, blockId in ipairs(blockIds) do
		self:blackBlockById(blockId)
	end
end

function RoomInventoryBlockModel:blackBlockById(blockId)
	local blockCfg = RoomConfig.instance:getBlock(blockId)

	if blockCfg then
		local packageMO = self._blockPackageModel:getById(blockCfg.packageId)

		if packageMO then
			packageMO:unUseBlockId(blockId)
			table.insert(self._unUseBlockList, blockId)
		else
			logError("还没获得对应的资源包：" .. blockCfg.packageId)
		end
	end
end

function RoomInventoryBlockModel:findFristUnUseBlockMO(packageId, resId)
	local packageMO = self._blockPackageModel:getById(packageId)

	if not packageMO then
		return nil
	end

	if not self._unUseBlockList then
		local unUseBlockIds = {}

		for _, blockId in ipairs(unUseBlockIds) do
			local blockMO = packageMO:getUnUseBlockMOById(blockId)

			if blockMO and blockMO:getMainRes() == resId then
				return blockMO
			end
		end

		return packageMO:getUnUseBlockMOByResId(resId)
	end
end

function RoomInventoryBlockModel:getCurPackageMO()
	local fristMO
	local list = self._blockPackageModel:getList()

	for _, packageId in ipairs(self._selectPackageIds) do
		local packageMO = self._blockPackageModel:getById(packageId)

		if packageMO and packageMO:getUnUseCount() > 0 then
			return packageMO
		elseif fristMO == nil then
			fristMO = packageMO
		end
	end

	return fristMO
end

function RoomInventoryBlockModel:getPackageMOById(packageId)
	return self._blockPackageModel:getById(packageId)
end

function RoomInventoryBlockModel:openSelectOp()
	return true
end

function RoomInventoryBlockModel:setSelectInventoryBlockId(blockId)
	self._selectInventoryBlockId = blockId
end

function RoomInventoryBlockModel:getSelectInventoryBlockId()
	return self._selectInventoryBlockId
end

function RoomInventoryBlockModel:setSelectResId(resId)
	self._selectResId = resId
end

function RoomInventoryBlockModel:getSelectResId()
	return self._selectResId
end

function RoomInventoryBlockModel:getSelectInventoryBlockMO()
	return self:getInventoryBlockMOById(self._selectInventoryBlockId)
end

function RoomInventoryBlockModel:getInventoryBlockCount()
	return 0
end

function RoomInventoryBlockModel:getInventoryBlockMOById(id)
	local packageList = self._blockPackageModel:getList()
	local blockMO

	for _, packageMO in ipairs(packageList) do
		blockMO = packageMO:getBlockMOById(id)

		if blockMO then
			return blockMO
		end
	end

	return nil
end

function RoomInventoryBlockModel:getInventoryBlockPackageMOList()
	return self._blockPackageModel:getList()
end

function RoomInventoryBlockModel:isMaxNum()
	local tRoomMapBlockModel = RoomMapBlockModel.instance

	return tRoomMapBlockModel:getConfirmBlockCount() >= tRoomMapBlockModel:getMaxBlockCount()
end

function RoomInventoryBlockModel:getBlockSortIndex(packageId, blockId)
	local maxIndex = #self._unUseBlockList + 1
	local index = tabletool.indexOf(self._unUseBlockList, blockId)

	if index then
		return maxIndex - index
	end

	return maxIndex
end

RoomInventoryBlockModel.instance = RoomInventoryBlockModel.New()

return RoomInventoryBlockModel
