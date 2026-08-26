-- chunkname: @modules/logic/room/model/map/RoomBlockPackageMO.lua

module("modules.logic.room.model.map.RoomBlockPackageMO", package.seeall)

local RoomBlockPackageMO = pureTable("RoomBlockPackageMO")

function RoomBlockPackageMO:init(info, aloneBlockIds)
	self.id = info.id
	self._blockModel = self:_clearOrCreateModel(self._blockModel)
	self._useBlockModel = self:_clearOrCreateModel(self._useBlockModel)
	self._unUseBlockModel = self:_clearOrCreateModel(self._unUseBlockModel)
	self._useCount = 0

	local blockList = RoomConfig.instance:getBlockListByPackageId(self.id) or {}
	local blockMOList = {}

	self._resIdDic = {}
	self._resIdList = {}
	aloneBlockIds = aloneBlockIds or {}

	for _, blockCfg in ipairs(blockList) do
		if blockCfg.ownType ~= RoomBlockEnum.OwnType.Special or tabletool.indexOf(aloneBlockIds, blockCfg.blockId) then
			local blockMO = self:_createBlockMOByCfg(blockCfg)

			table.insert(blockMOList, blockMO)
		end

		if not self._resIdDic[blockCfg.mainRes] then
			self._resIdDic[blockCfg.mainRes] = true

			table.insert(self._resIdList, blockCfg.mainRes)
		end
	end

	self._blockModel:setList(blockMOList)
	self._unUseBlockModel:setList(blockMOList)

	if #self._resIdList > 1 then
		table.sort(self._resIdList, function(a, b)
			if a ~= b then
				return a < b
			end
		end)
	end
end

function RoomBlockPackageMO:_clearModel(model)
	if model then
		model:clear()
	end
end

function RoomBlockPackageMO:_clearOrCreateModel(model)
	if model then
		model:clear()
	else
		model = BaseModel.New()
	end

	return model
end

function RoomBlockPackageMO:_sumCount(model)
	return model:getCount()
end

function RoomBlockPackageMO:_sumCountByResId(model, resType)
	local unUseList = model:getList()
	local count = 0

	for _, blockMO in ipairs(unUseList) do
		if blockMO:getMainRes() == resType then
			count = count + 1
		end
	end

	return count
end

function RoomBlockPackageMO:_getBlockMOByResId(model, resId)
	local blockList = model:getList()

	for i = 1, #blockList do
		local blockMO = blockList[i]

		if blockMO:getMainRes() == resId then
			return blockMO
		end
	end
end

function RoomBlockPackageMO:_createBlockMOByCfg(blockCfg)
	local blockMO = RoomBlockMO.New()

	blockMO.blockState = RoomBlockEnum.BlockState.Inventory

	blockMO:init(blockCfg)

	if blockMO.defineId == RoomBlockEnum.EmptyDefineId then
		blockMO.rotate = math.random(0, 6)
	end

	local blockColor = RoomWaterReformModel.instance:getBlockPermanentInfo(blockCfg.blockId)

	blockMO:setBlockColorType(blockColor)

	return blockMO
end

function RoomBlockPackageMO:getUnUseBlockMOByResId(resId)
	return self:_getBlockMOByResId(self._unUseBlockModel, resId)
end

function RoomBlockPackageMO:getResIdList()
	return self._resIdList
end

function RoomBlockPackageMO:getBlockMOById(blockId)
	return self._blockModel:getById(blockId)
end

function RoomBlockPackageMO:getUnUseBlockMOById(blockId)
	return self._unUseBlockModel:getById(blockId)
end

function RoomBlockPackageMO:getCount()
	return self:_sumCount(self._blockModel)
end

function RoomBlockPackageMO:getUseCount()
	return self:_sumCount(self._uselockModel)
end

function RoomBlockPackageMO:getUnUseCount()
	return self:_sumCount(self._unUseBlockModel)
end

function RoomBlockPackageMO:getCountByResId(resId)
	return self:_sumCountByResId(self._blockModel, resId)
end

function RoomBlockPackageMO:getUseCountByResId(resId)
	return self:_sumCountByResId(self._uselockModel, resId)
end

function RoomBlockPackageMO:getUnUseCountByResId(resId)
	return self:_sumCountByResId(self._unUseBlockModel, resId)
end

function RoomBlockPackageMO:getUseBlockMOById(blockId)
	return self._useBlockModel:getById(blockId)
end

function RoomBlockPackageMO:getBlockMOList()
	return self._blockModel:getList()
end

function RoomBlockPackageMO:getUseBlockMOList()
	return self._useBlockModel:getList()
end

function RoomBlockPackageMO:getUnUseBlockMOList()
	return self._unUseBlockModel:getList()
end

function RoomBlockPackageMO:addBlockIdList(blockIds)
	for i = 1, #blockIds do
		self:addBlockById(blockIds[i])
	end
end

function RoomBlockPackageMO:addBlockById(blockId)
	if self._blockModel:getById(blockId) then
		return
	end

	local blockCfg = RoomConfig.instance:getBlock(blockId)

	if blockCfg and blockCfg.packageId == self.id then
		local blockMO = self:_createBlockMOByCfg(blockCfg)

		self._blockModel:addAtLast(blockMO)
		self._unUseBlockModel:addAtLast(blockMO)
	end
end

function RoomBlockPackageMO:useBlockId(blockId)
	local blockMO = self._unUseBlockModel:getById(blockId)

	if blockMO then
		blockMO.blockState = RoomBlockEnum.BlockState.Map

		self._unUseBlockModel:remove(blockMO)
		self._useBlockModel:addAtLast(blockMO)
	end
end

function RoomBlockPackageMO:useBlockIds(blockIds)
	for _, blockId in ipairs(blockIds) do
		self:useBlockId(blockId)
	end
end

function RoomBlockPackageMO:unUseBlockId(blockId)
	local blockMO = self._useBlockModel:getById(blockId)

	if blockMO then
		blockMO.blockState = RoomBlockEnum.BlockState.Inventory

		self._useBlockModel:remove(blockMO)
		self._unUseBlockModel:addAtLast(blockMO)
	end
end

function RoomBlockPackageMO:unUseBlockIds(blockIds)
	for _, blockId in ipairs(blockIds) do
		self:unUseBlockId(blockId)
	end
end

function RoomBlockPackageMO:reset()
	local list = self._useBlockModel:getList()

	for _, blockMO in ipairs(list) do
		blockMO.blockState = RoomBlockEnum.BlockState.Inventory
	end

	self:_clearModel(self._useBlockModel)
	self:_clearModel(self._unUseBlockModel)
	self._unUseBlockModel:setList(self._blockModel:getList())
end

function RoomBlockPackageMO:clear()
	self:_clearModel(self._blockModel)
	self:_clearModel(self._useBlockModel)
	self:_clearModel(self._unUseBlockModel)
end

function RoomBlockPackageMO.sortBlock(a, b)
	if a.packageOrder ~= b.packageOrder then
		return a.packageOrder > b.packageOrder
	end
end

return RoomBlockPackageMO
