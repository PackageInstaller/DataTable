-- chunkname: @modules/logic/room/controller/RoomWaterReformController.lua

module("modules.logic.room.controller.RoomWaterReformController", package.seeall)

local RoomWaterReformController = class("RoomWaterReformController", BaseController)

function RoomWaterReformController:onInit()
	self:clear()
end

function RoomWaterReformController:reInit()
	self:clear()
end

function RoomWaterReformController:clear()
	return
end

function RoomWaterReformController:getBlockReformPermanentInfo(blockIds, cb, cbObj)
	RoomRpc.instance:sendGetBlockPermanentInfoRequest(blockIds, cb, cbObj)
end

function RoomWaterReformController:onGetBlockReformPermanentInfo(infos)
	RoomWaterReformModel.instance:setBlockPermanentInfo(infos)
	self:dispatchEvent(RoomEvent.OnGetBlockReformPermanentInfo)
end

function RoomWaterReformController:onClickBlock(blockMO, hexPoint)
	if not blockMO or not hexPoint then
		return
	end

	if RoomConfig.instance:getInitBlock(blockMO.blockId) then
		return
	end

	local isInMapBlock = blockMO:isInMapBlock()
	local isWaterReform = RoomWaterReformModel.instance:isWaterReform()

	if not isWaterReform or not isInMapBlock then
		return
	end

	local hasRiver = blockMO:hasRiver()

	if hasRiver then
		self:changeReformMode(RoomEnum.ReformMode.Water)
		self:selectWater(blockMO, hexPoint)
	else
		self:changeReformMode(RoomEnum.ReformMode.Block)
		self:selectBlock(blockMO, hexPoint)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
end

function RoomWaterReformController:changeReformMode(newReformMode)
	local curReformMode = RoomWaterReformModel.instance:getReformMode()

	if newReformMode == curReformMode then
		return
	end

	RoomWaterReformModel.instance:setReformMode(newReformMode)

	if newReformMode ~= RoomEnum.ReformMode.Water then
		self:clearSelectWater()
	end

	if newReformMode ~= RoomEnum.ReformMode.Block then
		self:clearSelectBlock()
	end

	RoomWaterReformListModel.instance:setShowBlockList()
	self:dispatchEvent(RoomEvent.OnChangReformMode)
end

function RoomWaterReformController:saveReform()
	local hasChangeBlockColor = RoomWaterReformModel.instance:hasChangedBlockColor()

	if hasChangeBlockColor then
		local verifyColorDict = {}
		local recordChangeBlockColor = RoomWaterReformModel.instance:getRecordChangeBlockColor()

		for _, blockColor in pairs(recordChangeBlockColor) do
			if not verifyColorDict[blockColor] then
				local isUnlock = RoomWaterReformModel.instance:isUnlockBlockColor(blockColor)

				if not isUnlock then
					GameFacade.showMessageBox(MessageBoxIdDefine.UsedLockedWaterReform, MsgBoxEnum.BoxType.Yes_No, self._resetAndExitReform, nil, nil, self)

					return
				end

				verifyColorDict[blockColor] = true
			end
		end

		local costItem = UnlockVoucherConfig.instance:getRoomColorConst(UnlockVoucherEnum.ConstId.RoomBlockColorReformCostItem, "#", true)
		local hasQuantity = ItemModel.instance:getItemQuantity(costItem[1], costItem[2])
		local changeCount = RoomWaterReformModel.instance:getChangedBlockColorCount(nil, RoomWaterReformModel.InitBlockColor)

		if changeCount <= hasQuantity then
			if changeCount > 0 then
				if not MessageBoxIdDefine.ConfirmChangeBlockColorCost then
					local msg = MessageBoxIdDefine.ConfirmChangeBlockColor

					GameFacade.showMessageBox(msg, MsgBoxEnum.BoxType.Yes_No, self._confirmBlockColorReform, nil, nil, self, nil, nil, changeCount)

					return
				end
			end
		else
			GameFacade.showMessageBox(MessageBoxIdDefine.ChangeBlockColorCostItemNotEnough, MsgBoxEnum.BoxType.Yes_No, self._resetAndExitReform, nil, nil, self)

			return
		end
	else
		self:_saveWaterReform()
	end
end

function RoomWaterReformController:_confirmBlockColorReform()
	local recordChangeBlockColor = RoomWaterReformModel.instance:getRecordChangeBlockColor()

	RoomRpc.instance:sendSetBlockColorRequest(recordChangeBlockColor)
	self:_saveWaterReform()
end

function RoomWaterReformController:_saveWaterReform()
	local hasChangeWaterType = RoomWaterReformModel.instance:hasChangedWaterType()

	if hasChangeWaterType then
		local verifyTypeDict = {}
		local recordChangeWaterType = RoomWaterReformModel.instance:getRecordChangeWaterType()

		for _, waterType in pairs(recordChangeWaterType) do
			if not verifyTypeDict[waterType] then
				local isUnlock = RoomWaterReformModel.instance:isUnlockWaterReform(waterType)

				if not isUnlock then
					GameFacade.showMessageBox(MessageBoxIdDefine.UsedLockedWaterReform, MsgBoxEnum.BoxType.Yes_No, self._resetAndExitReform, nil, nil, self)

					return
				end

				verifyTypeDict[waterType] = true
			end
		end

		RoomRpc.instance:sendSetWaterTypeRequest(recordChangeWaterType)
	end

	RoomMapController.instance:switchWaterReform(false)
end

function RoomWaterReformController:_resetAndExitReform()
	self:resetReform()
	RoomMapController.instance:switchWaterReform(false)
end

function RoomWaterReformController:resetReform()
	local isWaterReform = RoomWaterReformModel.instance:isWaterReform()

	if not isWaterReform then
		return
	end

	RoomWaterReformModel.instance:resetChangeWaterType()

	local allWaterBlockEntityList = self:getAllWaterBlockEntityList()

	RoomBlockHelper.refreshBlockEntity(allWaterBlockEntityList, "refreshBlock")
	RoomWaterReformModel.instance:resetChangeBlockColor()

	local allBlockEntityList, selectBlockDict = self:getAllBlockEntityListWithoutRiver()

	RoomBlockHelper.refreshBlockEntity(allBlockEntityList, "refreshBlock")
	self:refreshSelectedNearBlock(allBlockEntityList, selectBlockDict)

	local curReformMode = RoomWaterReformModel.instance:getReformMode()

	if curReformMode == RoomEnum.ReformMode.Water then
		local defaultSelectWaterType = RoomWaterReformListModel.instance:getDefaultSelectWaterType()

		RoomWaterReformListModel.instance:setSelectWaterType(defaultSelectWaterType)
	elseif curReformMode == RoomEnum.ReformMode.Block then
		local defaultBlockColor = RoomWaterReformListModel.instance:getDefaultSelectBlockColor()

		RoomWaterReformListModel.instance:setSelectBlockColor(defaultBlockColor)
	end

	self:dispatchEvent(RoomEvent.OnRoomBlockReform)
end

function RoomWaterReformController:refreshHighlightWaterBlock()
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomMapController.instance:dispatchEvent(RoomEvent.ResourceLight)
end

function RoomWaterReformController:selectWater(blockMO, hexPoint)
	if not blockMO or not hexPoint then
		return
	end

	local waterDirection

	for direction = 0, 6 do
		local resourceId = blockMO:getResourceId(direction)

		if resourceId == RoomResourceEnum.ResourceId.River then
			waterDirection = direction

			break
		end
	end

	RoomResourceModel.instance:clearLightResourcePoint()

	local newAreaId = RoomWaterReformModel.instance:getWaterAreaId(hexPoint.x, hexPoint.y, waterDirection)
	local selectAreaId = RoomWaterReformModel.instance:getSelectAreaId()

	if newAreaId ~= selectAreaId then
		local oldWaterBlockEntityList = self:getSelectWaterBlockEntityList()

		RoomWaterReformModel.instance:setSelectWaterArea(newAreaId)
		RoomBlockHelper.refreshBlockEntity(oldWaterBlockEntityList, "refreshBlock")
		self:refreshSelectWaterBlockEntity()
		self:dispatchEvent(RoomEvent.OnReformChangeSelectedEntity)
	else
		self:clearSelectWater()
	end
end

function RoomWaterReformController:clearSelectWater()
	local oldWaterBlockEntityList = self:getSelectWaterBlockEntityList()

	RoomWaterReformModel.instance:setSelectWaterArea()
	RoomBlockHelper.refreshBlockEntity(oldWaterBlockEntityList, "refreshBlock")
	self:dispatchEvent(RoomEvent.OnReformChangeSelectedEntity)
end

function RoomWaterReformController:selectWaterType(waterType)
	local blockId = RoomConfig.instance:getWaterReformTypeBlockId(waterType)

	if not blockId then
		return
	end

	local selectWaterBlockEntityList = self:getSelectWaterBlockEntityList()

	for _, blockEntity in ipairs(selectWaterBlockEntityList) do
		local blockMO = blockEntity:getMO()

		if blockMO then
			local tempWaterType = blockMO:getTempWaterType()

			if waterType ~= tempWaterType then
				blockMO:setTempWaterType(waterType)
				RoomWaterReformModel.instance:recordChangeWaterType(blockMO.id, waterType)
			end

			local hasWaterGradient = blockEntity:isHasWaterGradient()
			local checkWaterType = hasWaterGradient and blockMO:getWaterType() or blockMO:getOriginalWaterType()

			if checkWaterType == waterType then
				RoomWaterReformModel.instance:clearChangeWaterRecord(blockMO.id)
			end
		end
	end

	RoomWaterReformListModel.instance:setSelectWaterType(waterType)
	self:refreshSelectWaterBlockEntity()
	self:dispatchEvent(RoomEvent.OnRoomBlockReform)
end

function RoomWaterReformController:refreshSelectWaterBlockEntity()
	local isWaterReform = RoomWaterReformModel.instance:isWaterReform()

	if not isWaterReform then
		return
	end

	local selectWaterBlockEntityList = self:getSelectWaterBlockEntityList()

	RoomBlockHelper.refreshBlockEntity(selectWaterBlockEntityList, "refreshBlock")
end

function RoomWaterReformController:getSelectWaterBlockEntityList()
	local result = {}
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType ~= SceneType.Room then
		return result
	end

	local hasSelect = RoomWaterReformModel.instance:hasSelectWaterArea()

	if not hasSelect then
		return result
	end

	local scene = GameSceneMgr.instance:getCurScene()
	local resourcePointList = RoomWaterReformModel.instance:getSelectWaterResourcePointList()

	if not resourcePointList or not scene then
		return result
	end

	local hasFindDict = {}

	for _, resPoint in ipairs(resourcePointList) do
		local x = resPoint.x
		local y = resPoint.y

		if not hasFindDict[x] or not hasFindDict[x][y] then
			hasFindDict[x] = hasFindDict[x] or {}
			hasFindDict[x][y] = true

			local blockMO = RoomMapBlockModel.instance:getBlockMO(x, y)

			if blockMO then
				::label_18_0::

				result[#result + 1] = scene.mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)
			end
		end
	end

	return result
end

function RoomWaterReformController:getAllWaterBlockEntityList()
	local result = {}
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType ~= SceneType.Room then
		return result
	end

	local scene = GameSceneMgr.instance:getCurScene()

	if not scene then
		return result
	end

	local hasFindDict = {}
	local areaList = RoomWaterReformModel.instance:getWaterAreaList()

	for _, resourcePointList in ipairs(areaList) do
		for _, resPoint in ipairs(resourcePointList) do
			local x = resPoint.x
			local y = resPoint.y

			if not hasFindDict[x] or not hasFindDict[x][y] then
				hasFindDict[x] = hasFindDict[x] or {}
				hasFindDict[x][y] = true

				local blockMO = RoomMapBlockModel.instance:getBlockMO(x, y)

				if blockMO then
					::label_19_0::

					result[#result + 1] = scene.mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)
				end
			end
		end
	end

	return result
end

function RoomWaterReformController:selectBlock(blockMO, hexPoint)
	local selectMode = RoomWaterReformModel.instance:getBlockColorReformSelectMode()
	local isSelected = RoomWaterReformModel.instance:isBlockInSelect(blockMO)

	if not isSelected then
		if selectMode == RoomEnum.BlockColorReformSelectMode.All then
			local blockMOList = RoomMapBlockModel.instance:getFullBlockMOList()

			for _, tempBlockMO in ipairs(blockMOList) do
				local tmpBlockId = tempBlockMO.blockId
				local hasRiver = tempBlockMO:hasRiver()
				local isInitBlock = RoomConfig.instance:getInitBlock(tmpBlockId)

				if not hasRiver and not isInitBlock then
					RoomWaterReformModel.instance:setBlockSelected(tmpBlockId, true)
				end
			end
		elseif selectMode == RoomEnum.BlockColorReformSelectMode.Multiple then
			local repeatDict = {}
			local selectBlockList = {
				blockMO.blockId
			}

			RoomBlockHelper.getNearSameBlockTypeEntity(blockMO, repeatDict, selectBlockList)

			local oldBlockEntityList = self:getSelectBlockEntityList()

			RoomWaterReformModel.instance:setBlockSelectedByList(selectBlockList, true, true)
			RoomBlockHelper.refreshBlockEntity(oldBlockEntityList, "refreshBlock")
		else
			RoomWaterReformModel.instance:setBlockSelected(blockMO.blockId, true)
		end

		self:refreshSelectedBlockEntity()
		self:dispatchEvent(RoomEvent.OnReformChangeSelectedEntity)
	elseif selectMode == RoomEnum.BlockColorReformSelectMode.Single then
		self:clearSelectBlock(blockMO)
	else
		self:clearSelectBlock()
	end
end

function RoomWaterReformController:clearSelectBlock(blockMO)
	local oldBlockEntityList = {}

	if blockMO then
		local blockId = blockMO.blockId

		oldBlockEntityList = self:getSelectBlockEntityList(blockId)

		RoomWaterReformModel.instance:setBlockSelected(blockId, false)
	else
		oldBlockEntityList = self:getSelectBlockEntityList()

		RoomWaterReformModel.instance:setBlockSelectedByList(nil, false, true)
	end

	RoomBlockHelper.refreshBlockEntity(oldBlockEntityList, "refreshBlock")
	self:dispatchEvent(RoomEvent.OnReformChangeSelectedEntity)
end

function RoomWaterReformController:selectBlockColorType(blockColorType)
	if blockColorType ~= RoomWaterReformModel.InitBlockColor then
		local blockId = RoomConfig.instance:getBlockColorReformBlockId(blockColorType)

		if not blockId then
			return
		end
	end

	local hexPointList = {}
	local selectBlockEntityList = self:getSelectBlockEntityList()

	for _, blockEntity in ipairs(selectBlockEntityList) do
		local blockMO = blockEntity:getMO()

		if blockMO then
			local tempColorType = blockMO:getTempBlockColorType()

			if blockColorType ~= tempColorType then
				blockMO:setTempBlockColorType(blockColorType)
				RoomWaterReformModel.instance:recordChangeBlockColor(blockMO.id, blockColorType)
			end

			local checkBlockType = blockMO:getOriginalBlockType()

			if checkBlockType == blockColorType then
				RoomWaterReformModel.instance:clearChangeBlockColorRecord(blockMO.id)
			end

			hexPointList[#hexPointList + 1] = blockMO.hexPoint
		end
	end

	RoomMapBlockModel.instance:refreshNearRiverByHexPointList(hexPointList, 1)
	RoomWaterReformListModel.instance:setSelectBlockColor(blockColorType)
	self:refreshSelectedBlockEntity()
	self:dispatchEvent(RoomEvent.OnRoomBlockReform)
end

function RoomWaterReformController:refreshSelectedBlockEntity()
	local isWaterReform = RoomWaterReformModel.instance:isWaterReform()

	if not isWaterReform then
		return
	end

	local selectBlockEntityList, selectBlockDict = self:getSelectBlockEntityList()

	RoomBlockHelper.refreshBlockEntity(selectBlockEntityList, "refreshBlock")
	self:refreshSelectedNearBlock(selectBlockEntityList, selectBlockDict)
end

function RoomWaterReformController:refreshSelectedNearBlock(selectBlockEntityList, selectBlockDict)
	local nearBlockEntityDict = {}

	for _, blockEntity in ipairs(selectBlockEntityList) do
		local blockMO = blockEntity:getMO()

		if blockMO then
			local nearMapEntityList = RoomBlockHelper.getNearBlockEntity(false, blockMO.hexPoint, 1, true, false)

			for _, nearBlockEntity in ipairs(nearMapEntityList) do
				local nearBlockMO = nearBlockEntity:getMO()
				local nearBlockId = nearBlockMO.blockId

				if nearBlockMO and not selectBlockDict[nearBlockId] and not nearBlockEntityDict[nearBlockId] then
					nearBlockEntityDict[nearBlockId] = nearBlockEntity
				end
			end
		end
	end

	local nearBlockEntityList = {}

	for _, nearBlockEntity in pairs(nearBlockEntityDict) do
		nearBlockEntityList[#nearBlockEntityList + 1] = nearBlockEntity
	end

	RoomBlockHelper.refreshBlockEntity(nearBlockEntityList, "refreshLand")
end

function RoomWaterReformController:getSelectBlockEntityList(blockId)
	local list = {}
	local dict = {}
	local curSceneType = GameSceneMgr.instance:getCurSceneType()
	local scene = GameSceneMgr.instance:getCurScene()

	if curSceneType ~= SceneType.Room or not scene then
		return list, dict
	end

	if blockId then
		list[#list + 1] = scene.mapmgr:getBlockEntity(blockId, SceneTag.RoomMapBlock)
		dict[blockId] = true
	else
		local selectedBlocks = RoomWaterReformModel.instance:getSelectedBlocks()

		if selectedBlocks then
			for selectedBlockId, _ in pairs(selectedBlocks) do
				list[#list + 1] = scene.mapmgr:getBlockEntity(selectedBlockId, SceneTag.RoomMapBlock)
				dict[selectedBlockId] = true
			end
		end
	end

	return list, dict
end

function RoomWaterReformController:getAllBlockEntityListWithoutRiver()
	local list = {}
	local dict = {}
	local scene = GameSceneMgr.instance:getCurScene()
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if not scene or curSceneType ~= SceneType.Room then
		return list, dict
	end

	local blockEntityDict = scene.mapmgr:getMapBlockEntityDict()

	if blockEntityDict then
		for _, blockEntity in pairs(blockEntityDict) do
			local blockMO = blockEntity:getMO()
			local hasRiver = blockMO:hasRiver()

			if not hasRiver then
				list[#list + 1] = blockEntity
				dict[blockMO.blockId] = true
			end
		end
	end

	return list, dict
end

function RoomWaterReformController:changeBlockSelectMode(selectMode)
	local curSelectMode = RoomWaterReformModel.instance:getBlockColorReformSelectMode()

	if not selectMode or curSelectMode == selectMode then
		return
	end

	RoomWaterReformModel.instance:setBlockColorReformSelectMode(selectMode)
end

RoomWaterReformController.instance = RoomWaterReformController.New()

return RoomWaterReformController
