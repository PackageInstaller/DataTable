-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/controller/PanTaoFeastGameController.lua

module("logic.extensions.pantaofeast.controller.PanTaoFeastGameController", package.seeall)

local PanTaoFeastGameController = class("PanTaoFeastGameController", BaseController)

function PanTaoFeastGameController:onInit()
	self._elementTypeMap = {}

	self:resetGameData()
end

function PanTaoFeastGameController:onReset()
	table.clear(self._elementTypeMap)
	self:resetGameData()
end

function PanTaoFeastGameController:resetGameData()
	self._curActId = 0
	self._curActCfg = nil
	self._playShowEffGridIdList = {}
	self._lastSyncedGridDataMatrix = {}
	self._curGridDataMatrix = {}
	self._curGridDataList = {}
	self._curElementCountMap = {}
	self._gridRowCount = 0
	self._gridColCount = 0
	self._useEnergyId = 0
end

function PanTaoFeastGameController:initGameData(activityId)
	self:resetGameData()

	local activityCfg = PanTaoFeastConfig.instance:getActivityCfg(activityId)
	local activityInfo = PanTaoFeastModel.instance:getInfo(activityId)

	if not activityCfg then
		printError("PanTaoFeastGameController:initGameData: 活动配置不存在 activityId=" .. tostring(activityId))

		return
	end

	if not activityInfo then
		printError("PanTaoFeastGameController:initGameData: 活动数据不存在 activityId=" .. tostring(activityId))

		return
	end

	self._curActId = activityId

	self:initGameDataByCfg(activityCfg)
	self:initGameDataByInfo(activityInfo)
end

function PanTaoFeastGameController:initGameDataByCfg(activityCfg)
	self._curActCfg = activityCfg
	self._gridRowCount = activityCfg.rowCount or 0
	self._gridColCount = activityCfg.colCount or 0

	if self._gridRowCount <= 0 or self._gridColCount <= 0 then
		printError("PanTaoFeastGameController:initGameData: 活动配置行列数不合法 activityId=" .. tostring(self._curActId))

		return
	end

	for row = 1, self._gridRowCount do
		self._lastSyncedGridDataMatrix[row] = {}
		self._curGridDataMatrix[row] = {}
	end

	self._useEnergyId = activityCfg.energyId or 0
end

function PanTaoFeastGameController:initGameDataByInfo(activityInfo)
	self:syncBoardGridElements(self._curActId)
end

function PanTaoFeastGameController:syncBoardGridElements(activityId)
	if self._curActId ~= activityId then
		print("蟠桃盛宴:syncBoardGridElements: 活动Id不匹配，无法同步数据 activityId=" .. tostring(activityId))

		return
	end

	local activityInfo = PanTaoFeastModel.instance:getInfo(activityId)

	if not activityInfo then
		return
	end

	self._playShowEffGridIdList = {}

	table.clear(self._playShowEffGridIdList)

	local emptyGirdIdMap = {}

	for row = 1, self._gridRowCount do
		for col = 1, self._gridColCount do
			local gridId = self:rowColToGridId(row, col)
			local data = self:getGridElementByGridId(gridId)

			if data and data:isEmpty() then
				emptyGirdIdMap[gridId] = true
			end
		end
	end

	self._curGridDataMatrix = self._curGridDataMatrix or {}

	table.clear(self._curGridDataMatrix)

	self._lastSyncedGridDataMatrix = self._lastSyncedGridDataMatrix or {}

	table.clear(self._lastSyncedGridDataMatrix)

	self._curGridDataList = self._curGridDataList or {}

	table.clear(self._curGridDataList)

	self._curElementCountMap = self._curElementCountMap or {}

	table.clear(self._curElementCountMap)

	for row = 1, self._gridRowCount do
		self._curGridDataMatrix[row] = {}
		self._lastSyncedGridDataMatrix[row] = {}
	end

	if not activityInfo.boardGridMap then
		local boardGridMap = {}

		for gridId, data in pairs(boardGridMap) do
			local row, col = self:gridIdToRowCol(gridId)
			local gridData = PanTaoFeastElementData.New()

			gridData:initByServerData(data)

			self._curGridDataMatrix[row][col] = gridData
			self._lastSyncedGridDataMatrix[row][col] = gridData

			table.insert(self._curGridDataList, gridData)

			if emptyGirdIdMap[gridId] then
				table.insert(self._playShowEffGridIdList, gridId)
			end

			local elementId = gridData:getElementId()

			if elementId > 0 and not gridData:isLock() then
				self._curElementCountMap[elementId] = self._curElementCountMap[elementId] or self._curElementCountMap[elementId] + 1
			end
		end

		GlobalDispatcher:dispatch(GlobalNotify.PM_PanTaoFeastNotifyChangeRes)
	end
end

function PanTaoFeastGameController:getCurActivityId()
	return self._curActId
end

function PanTaoFeastGameController:getCurGridDataList(activityId)
	if self._curActId ~= checknumber(activityId) then
		return {}
	end

	local datalist = {}

	for _, data in ipairs(self._curGridDataList) do
		table.insert(datalist, data)
	end

	return datalist
end

function PanTaoFeastGameController:getPlayShowEffGridIdList()
	local gridIdList = {}

	for _, gridId in ipairs(self._playShowEffGridIdList) do
		table.insert(gridIdList, gridId)
	end

	return gridIdList
end

function PanTaoFeastGameController:getUseEnergyId()
	return self._useEnergyId
end

function PanTaoFeastGameController:getElementDataByRowCol(row, col)
	return self._curGridDataMatrix[row] and self._curGridDataMatrix[row][col]
end

function PanTaoFeastGameController:getGridElementByGridId(gridId)
	local row, col = self:gridIdToRowCol(gridId)

	return self:getElementDataByRowCol(row, col)
end

function PanTaoFeastGameController:getElementIdByRowCol(row, col)
	local data = self:getElementDataByRowCol(row, col)

	if data then
		return checknumber(data:getElementId())
	end

	return 0
end

function PanTaoFeastGameController:getElementIdByGridId(gridId)
	local data = self:getGridElementByGridId(gridId)

	if data then
		return checknumber(data:getElementId())
	end

	return 0
end

function PanTaoFeastGameController:getDiffGridDataList()
	local diffList = {}

	for row = 1, self._gridRowCount do
		for col = 1, self._gridColCount do
			if self._curGridDataMatrix[row] then
				if self._lastSyncedGridDataMatrix[row] then
					local lastData = self._lastSyncedGridDataMatrix[row][col]
					local curElementId = self._curGridDataMatrix[row] and self._curGridDataMatrix[row]:getElementId() or 0
					local lastElementId = lastData and lastData:getElementId() or 0

					if curElementId ~= lastElementId then
						local pb = CommonStructDef_pb.PM_PairInt()

						pb.left = self:rowColToGridId(row, col)
						pb.right = curElementId

						table.insert(diffList, pb)
					end
				end
			end
		end
	end

	return diffList
end

function PanTaoFeastGameController:hasEnoughEnergy()
	local energyId = self._useEnergyId

	if energyId <= 0 then
		return false
	end

	local curCount = MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ENERGY, energyId)

	return curCount > 0
end

function PanTaoFeastGameController:isEmptyGridByRowCol(row, col)
	local data = self:getElementDataByRowCol(row, col)

	if data then
		return data:isEmpty()
	end

	return true
end

function PanTaoFeastGameController:isMovableGridByRowCol(row, col)
	local data = self:getElementDataByRowCol(row, col)

	if data then
		return not data:isLock() and not data:isEmpty()
	end

	return false
end

function PanTaoFeastGameController:hasEnoughEmptyGrid(minCount)
	local emptyCount = 0

	for row = 1, self._gridRowCount do
		for col = 1, self._gridColCount do
			local isEmpty = self:isEmptyGridByRowCol(row, col)

			if isEmpty then
				emptyCount = emptyCount + 1

				if minCount <= emptyCount then
					return true
				end
			end
		end
	end

	return false
end

function PanTaoFeastGameController:hasEmptyGrid()
	return self:hasEnoughEmptyGrid(1)
end

function PanTaoFeastGameController:isValidRowCol(row, col)
	return row >= 1 and row <= self._gridRowCount and col >= 1 and col <= self._gridColCount
end

function PanTaoFeastGameController:isGridMovableToRowCol(gridId, row, col)
	local gridRow, gridCol = self:gridIdToRowCol(gridId)
	local isMoveAble = self:isMovableGridByRowCol(gridRow, gridCol)
	local isSameGrid = gridRow == row and gridCol == col

	return self:isValidRowCol(row, col) and isMoveAble and not isSameGrid
end

function PanTaoFeastGameController:isCanMerge(data1, data2)
	if data1 == data2 then
		return false
	end

	if not data1 or not data2 or data1:isEmpty() or data2:isEmpty() then
		return false
	end

	local elementId1 = data1:getElementId()
	local isExistNext = PanTaoFeastConfig.instance:getNextElementCfgByElementId(self._curActId, elementId1) ~= nil

	if not isExistNext then
		return false
	end

	local elementId2 = data2:getElementId()

	return elementId1 == elementId2
end

function PanTaoFeastGameController:isStashIdUnlocked(stashId)
	local stashCfg = PanTaoFeastConfig.instance:getStashCfg(self._curActId, stashId)

	if not stashCfg then
		return false
	end

	local roundId = PanTaoFeastModel.instance:getCurRoundId(self._curActId)

	if not stashCfg.unlockRound then
		local unlockRound = 0

		return unlockRound <= roundId
	end
end

function PanTaoFeastGameController:isCanMoveToStore(gridId, stashId)
	local tipStr = ""
	local stashCfg = PanTaoFeastConfig.instance:getStashCfg(self._curActId, stashId)

	if not stashCfg then
		tipStr = lang("暂存区配置不存在")

		return false, tipStr
	end

	local roundId = PanTaoFeastModel.instance:getCurRoundId(self._curActId)

	if not stashCfg.unlockRound then
		if roundId < stashCfg.unlockRound then
			tipStr = langPara("{0}在完成第{1}轮订单后解锁", stashCfg.stashName, stashCfg.unlockRound)

			return false, tipStr
		end

		local curStoreIdList = {}
		local storeInfo = PanTaoFeastModel.instance:getStoreElementInfo(self._curActId, stashId)

		if storeInfo then
			if not storeInfo.elementIds then
				local elementIds = {}

				for _, elementId in ipairs(elementIds) do
					table.insert(curStoreIdList, elementId)
				end
			end
		end

		if not stashCfg.capacity then
			local capacity = 0

			if capacity <= #curStoreIdList then
				tipStr = langPara("{0}已满，请先整理后再放入", stashCfg.stashName)

				return false, tipStr
			end

			if stashCfg.dealType == PanTaoFeastEnum.StashType.Tool then
				local row, col = self:gridIdToRowCol(gridId)
				local addElementId = self:getElementIdByRowCol(row, col)

				if addElementId <= 0 then
					tipStr = lang("暂存区放入的元素ID不合法")

					return false, tipStr
				end

				table.insert(curStoreIdList, addElementId)

				local isCanCook, recipeIdOrTip = self:isCanCookByElementIdList(stashId, curStoreIdList)

				return isCanCook, recipeIdOrTip
			end

			return true, tipStr
		end
	end
end

function PanTaoFeastGameController:isCanCookByElementIdList(stashId, elementIdList)
	local stashCfg = PanTaoFeastConfig.instance:getStashCfg(self._curActId, stashId)

	if not stashCfg then
		return false, lang("暂存区配置不存在")
	end

	local recipeCfgs = PanTaoFeastConfig.instance:getRecipeCfgsByTool(self._curActId, stashId)

	if not recipeCfgs or #recipeCfgs <= 0 then
		return false, langParam("{0}没有菜谱配置", stashCfg.stashName)
	end

	local elementIdCountMap = {}

	for _, elementId in ipairs(elementIdList) do
		elementIdCountMap[elementId] = (elementIdCountMap[elementId] or 0) + 1
	end

	for _, recipeCfg in ipairs(recipeCfgs) do
		local recipeId = recipeCfg.recipeId

		if not recipeCfg.materialElementIds then
			local isMatch = true
			local recipeElementIdCountMap = {}

			for _, elementId in ipairs(recipeCfg.materialElementIds) do
				recipeElementIdCountMap[elementId] = (recipeElementIdCountMap[elementId] or 0) + 1
			end

			for elementId, count in pairs(elementIdCountMap) do
				if not recipeElementIdCountMap[elementId] then
					local recipeCount = 0

					if recipeCount < count then
						isMatch = false

						break
					end
				end
			end

			if isMatch then
				return true, recipeId
			end
		end
	end

	return false, lang("没有适用的菜谱")
end

function PanTaoFeastGameController:hasEnoughElement(elementId, minCount)
	if not self._curElementCountMap[elementId] then
		local curCount = 0

		return minCount <= curCount
	end
end

function PanTaoFeastGameController:hasElement(elementId)
	return self:hasEnoughElement(elementId, 1)
end

function PanTaoFeastGameController:rowColToGridId(row, col)
	return (row - 1) * self._gridColCount + col
end

function PanTaoFeastGameController:gridIdToRowCol(gridId)
	local row = math.floor((gridId - 1) / self._gridColCount) + 1
	local col = (gridId - 1) % self._gridColCount + 1

	return row, col
end

function PanTaoFeastGameController:clearPlayShowEffGridIdList()
	table.clear(self._playShowEffGridIdList)
end

function PanTaoFeastGameController:moveGridIdToRowCol(gridId, row, col)
	if not self:isGridMovableToRowCol(gridId, row, col) then
		return
	end

	local isEmpty = self:isEmptyGridByRowCol(row, col)
	local gridRow, gridCol = self:gridIdToRowCol(gridId)
	local targetId = self:rowColToGridId(row, col)

	if isEmpty then
		self:swapGridElementsByRowCol(gridRow, gridCol, row, col)
	else
		local moveData = self:getGridElementByGridId(gridId)
		local targetData = self:getElementDataByRowCol(row, col)

		if moveData and targetData then
			local isCanMerge = self:isCanMerge(moveData, targetData)

			if isCanMerge then
				self:mergeElements(gridId, targetId)
			elseif not targetData:isLock() then
				local type = targetData:getElementType()

				if type == PanTaoFeastEnum.ElementClientType.Backpack then
					local stashId = targetData:getElementId()

					self:moveGridToStore(moveData:getGridId(), stashId)
				else
					self:swapGridElementsByRowCol(gridRow, gridCol, row, col)
				end
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PanTaoFeastChangeElementPos)
end

function PanTaoFeastGameController:swapGridElementsByRowCol(row1, col1, row2, col2)
	local data1 = self:getElementDataByRowCol(row1, col1)
	local data2 = self:getElementDataByRowCol(row2, col2)

	self._curGridDataMatrix[row1][col1], self._curGridDataMatrix[row2][col2] = data2, data1

	if data1 then
		data1:updatePosition(row2, col2)
	end

	if data2 then
		data2:updatePosition(row1, col1)
	end
end

function PanTaoFeastGameController:mergeElements(gridId1, gridId2)
	PanTaoFeastController.instance:mergeElements(self._curActId, gridId1, gridId2)
end

function PanTaoFeastGameController:moveGridToStore(gridId, stashId)
	local isCanMove, tipStr = self:isCanMoveToStore(gridId, stashId)

	if not isCanMove then
		TipsFacade.instance:openCommonTips(tipStr)

		return
	end

	PanTaoFeastController.instance:moveToStore(self._curActId, gridId, stashId)
end

function PanTaoFeastGameController:deleteGridElement(gridId)
	local row, col = self:gridIdToRowCol(gridId)
	local data = self:getElementDataByRowCol(row, col)

	if data then
		data:reset()

		self._curGridDataMatrix[row][col] = data
	end
end

function PanTaoFeastGameController:onDoubleClickGridElement(grid)
	local data = self:getGridElementByGridId(grid)

	if not data or data:isEmpty() then
		return
	end

	local isLock = data:isLock()

	if isLock then
		return
	end

	local type = data:getElementType()
	local elementId = data:getElementId()

	if type == PanTaoFeastEnum.ElementClientType.Backpack then
		UIStateManager.instance:push(ViewName.PanTaoFeastBackpackView, self._curActId, elementId)
	elseif type == PanTaoFeastEnum.ElementClientType.Workshop then
		self:tryProduceElement(grid)
	elseif type == PanTaoFeastEnum.ElementClientType.EnergyItem then
		PanTaoFeastController.instance:useEnergyPack(self._curActId, grid)
	end
end

function PanTaoFeastGameController:tryProduceElement(gridId)
	local data = self:getGridElementByGridId(gridId)

	if not data or data:isEmpty() then
		return
	end

	local type = data:getElementType()

	if type ~= PanTaoFeastEnum.ElementClientType.Workshop then
		return
	end

	if not self:hasEnoughEnergy() then
		local matName = MaterialMgr.getMaterialsName(MatType.ACTIVITY_ENERGY, self:getUseEnergyId())

		TipsFacade.instance:openCommonTips(langPara("%s数量不足，无法生产", matName))

		return
	end

	local isExistEmpty = self:hasEmptyGrid()

	if not isExistEmpty then
		TipsFacade.instance:openCommonTips(langPara("当前无空位，请清理后再来生产"))

		return
	end

	PanTaoFeastController.instance:produceElement(self._curActId, gridId)
end

function PanTaoFeastGameController:getElementClientTypeById(elementId)
	local activityId = self._curActId
	local key = PanTaoFeastController.instance:getKeyStrByActivityIdAndElementId(activityId, elementId)
	local type = self._elementTypeMap[key]

	if not type then
		local isValid = self:checkElementCfgValid(elementId)

		if not isValid then
			return PanTaoFeastEnum.ElementClientType.None
		end

		local cfg = PanTaoFeastConfig.instance:getElementCfgByElementId(activityId, elementId)

		if cfg then
			local elementType = cfg.elementType

			if elementType == PanTaoFeastEnum.ElementType.RawMat then
				local recipeCfg = PanTaoFeastConfig.instance:getRecipeCfgByDishId(activityId, elementId)
				local isDish = recipeCfg ~= nil

				if isDish then
					type = PanTaoFeastEnum.ElementClientType.Dish
				else
					local rootElementId = PanTaoFeastConfig.instance:getRootElementIdByElementId(activityId, elementId)
					local rootRecipeCfg = PanTaoFeastConfig.instance:getRecipeCfgByDishId(activityId, rootElementId)

					type = rootRecipeCfg and PanTaoFeastEnum.ElementClientType.GreatDish or PanTaoFeastEnum.ElementClientType.RawMat
				end
			elseif elementType == PanTaoFeastEnum.ElementType.Workshop then
				type = PanTaoFeastEnum.ElementClientType.Workshop
			elseif elementType == PanTaoFeastEnum.ElementType.EnergyItem then
				type = PanTaoFeastEnum.ElementClientType.EnergyItem
			elseif elementType == PanTaoFeastEnum.ElementType.Backpack then
				type = PanTaoFeastEnum.ElementClientType.Backpack
			end

			self._elementTypeMap[key] = type
		end
	end

	type = type or PanTaoFeastEnum.ElementClientType.None

	return type
end

function PanTaoFeastGameController:checkElementCfgValid(elementId)
	local activityId = self._curActId
	local cfg = PanTaoFeastConfig.instance:getElementCfgByElementId(activityId, elementId)

	if not cfg then
		return false
	end

	local elementType = cfg.elementType

	if elementType == PanTaoFeastEnum.ElementType.RawMat then
		local isDish = false
		local isRawMat = false
		local rootElementId = PanTaoFeastConfig.instance:getRootElementIdByElementId(activityId, elementId)
		local recipeCfg = PanTaoFeastConfig.instance:getRecipeCfgByDishId(activityId, elementId)

		if recipeCfg then
			isDish = true
		end

		if rootElementId then
			local toolIds = PanTaoFeastConfig.instance:getProduceDropToolIdsByElementId(activityId, rootElementId)

			if toolIds and #toolIds > 0 then
				isRawMat = true
			elseif not isDish then
				local rootRecipeCfg = PanTaoFeastConfig.instance:getRecipeCfgByDishId(activityId, rootElementId)

				if rootRecipeCfg then
					isRawMat = true
				end
			end
		end

		if isDish and isRawMat then
			return true
		elseif not isDish and not isRawMat then
			return false
		end

		return true
	elseif elementType == PanTaoFeastEnum.ElementType.Workshop then
		return true
	elseif elementType == PanTaoFeastEnum.ElementType.EnergyItem then
		return true
	elseif elementType == PanTaoFeastEnum.ElementType.Backpack then
		local backpackCfg = PanTaoFeastConfig.instance:getStashCfg(activityId, elementId)

		if backpackCfg then
			return true
		end

		return false
	end

	return false
end

function PanTaoFeastGameController:getCookAreaStateById(stashId)
	local activityId = self._curActId
	local stashCfg = PanTaoFeastConfig.instance:getStashCfg(activityId, stashId)

	if not stashCfg then
		printError("蟠桃盛宴: 烹饪区配置不存在 activityId=" .. tostring(activityId) .. ", stashId=" .. tostring(stashId))

		return PanTaoFeastEnum.CookingState.Locked
	end

	local roundId = PanTaoFeastModel.instance:getCurRoundId(activityId)

	if not stashCfg.unlockRound then
		if roundId < stashCfg.unlockRound then
			return PanTaoFeastEnum.CookingState.Locked
		end

		local stashInfo = PanTaoFeastModel.instance:getStoreElementInfo(activityId, stashId)

		if stashInfo then
			if not stashInfo.elementIds then
				local elementIds = {}

				if #elementIds == 1 then
					local elementId = elementIds[1]
					local type = self:getElementClientTypeById(elementId)

					if type == PanTaoFeastEnum.ElementClientType.Dish or type == PanTaoFeastEnum.ElementClientType.GreatDish then
						return PanTaoFeastEnum.CookingState.Finished
					end
				end
			end
		end

		return PanTaoFeastEnum.CookingState.Waiting
	end
end

function PanTaoFeastGameController:hasRemainRounds()
	local activityId = self._curActId
	local roundId = PanTaoFeastModel.instance:getCurRoundId(activityId)
	local roundCfgs = PanTaoFeastConfig.instance:getRoundCfgs(activityId) or {}

	return roundId < #roundCfgs
end

function PanTaoFeastGameController:getCurRoundRemainOrders()
	local activityId = self._curActId
	local roundId = PanTaoFeastModel.instance:getCurRoundId(activityId)
	local orderCfgs = PanTaoFeastConfig.instance:getOrderCfgsByRound(activityId, roundId) or {}
	local remainOrders = {}

	for _, orderCfg in ipairs(orderCfgs) do
		local orderId = orderCfg.orderId

		if not PanTaoFeastModel.instance:hasGainOrder(activityId, orderId) then
			table.insert(remainOrders, orderCfg)
		end
	end

	return remainOrders
end

function PanTaoFeastGameController:hasAllRoundPrizesGain()
	local activityId = self._curActId
	local roundId = PanTaoFeastModel.instance:getCurRoundId(activityId)
	local roundCfgs = PanTaoFeastConfig.instance:getRoundCfgs(activityId) or {}

	if roundId >= #roundCfgs then
		return PanTaoFeastModel.instance:hasGainRoundPrize(activityId, roundId)
	end

	return false
end

function PanTaoFeastGameController:getGridIdsForOrder(orderId)
	local activityId = self._curActId
	local orderCfg = PanTaoFeastConfig.instance:getOrderCfg(activityId, orderId)

	if not orderCfg then
		return nil
	end

	if not orderCfg.needElementIds then
		local elementIds = {}
		local gridIds = {}

		for _, elementId in ipairs(elementIds) do
			local isExist = false

			for rowId = 1, self._gridRowCount do
				for colId = 1, self._gridColCount do
					local data = self:getElementDataByRowCol(rowId, colId)

					if data and not data:isLock() and data:getElementId() == elementId then
						local gridId = self:rowColToGridId(rowId, colId)

						table.insert(gridIds, gridId)

						isExist = true

						break
					end
				end

				if isExist then
					break
				end
			end

			if not isExist then
				return nil
			end
		end

		return gridIds
	end
end

function PanTaoFeastGameController:tryPopElementCI(...)
	local actId = self._curActId
	local list = {}
	local elementIdList = {
		...
	}

	for _, elementId in ipairs(elementIdList) do
		local cfg = PanTaoFeastConfig.instance:getElementCfgByElementId(actId, elementId)

		if cfg then
			if not cfg.fakeItemId then
				local fakeItemId = 0

				if fakeItemId > 0 then
					local mo = MaterialModel.instance:UpdateMaterial(MatType.Item_Fake, fakeItemId, 1)

					table.insert(list, mo)
				end
			end
		end
	end

	if #list <= 0 then
		return
	end

	local obj = {}

	obj.items = list
	obj.ci = 0

	MaterialController.instance:addInList(MaterialController.TYPE_ITEMSET, obj)
	MaterialController.instance:checkAndOpenDisplay()
end

function PanTaoFeastGameController:tryPopScoreCI(inputScore)
	local score = checknumber(inputScore)

	if score <= 0 then
		return
	end

	if not self._curActCfg then
		return
	end

	if not self._curActCfg.scoreId then
		local fakeItemId = 0
		local mo = MaterialModel.instance:UpdateMaterial(MatType.Item_Fake, fakeItemId, score)
		local obj = {}

		obj.items = {
			mo
		}
		obj.ci = 0

		MaterialController.instance:addInList(MaterialController.TYPE_ITEMSET, obj)
		MaterialController.instance:checkAndOpenDisplay()
	end
end

function PanTaoFeastGameController:getNextShowElementIdByRecipeId(dishId)
	local showElementId = 0
	local activityId = self._curActId
	local recipeCfg = PanTaoFeastConfig.instance:getRecipeCfgByDishId(activityId, dishId)

	if not recipeCfg then
		return showElementId
	end

	if not recipeCfg.materialElementIds then
		local needElementIds = {}
		local cookToolId = recipeCfg.cookToolId

		for _, elementId in ipairs(needElementIds) do
			local isExistInBoard = self:hasElement(elementId)

			if isExistInBoard then
				local stashInfo = PanTaoFeastModel.instance:getStoreElementInfo(activityId, cookToolId)

				if not stashInfo then
					showElementId = elementId

					break
				elseif not stashInfo.elementIds then
					local elementIds = {}
					local isExistInStore = false

					for _, storeElementId in ipairs(elementIds) do
						if storeElementId == elementId then
							isExistInStore = true

							break
						end
					end

					if not isExistInStore then
						showElementId = elementId

						break
					end
				end
			end
		end

		return showElementId
	end
end

PanTaoFeastGameController.instance = PanTaoFeastGameController.New()

return PanTaoFeastGameController
