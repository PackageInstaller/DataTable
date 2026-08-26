-- chunkname: @modules/logic/gm/view/GMSubViewRoomEditMode.lua

module("modules.logic.gm.view.GMSubViewRoomEditMode", package.seeall)

local GMSubViewRoomEditMode = class("GMSubViewRoomEditMode", GMSubViewBase)

GMSubViewRoomEditMode.useBlockKey = "GMSubViewRoomEditMode.PlaceBlockKey"
GMSubViewRoomEditMode.useBuildingKey = "GMSubViewRoomEditMode.PlaceBuildingKey"

local function createSpiralCoordGenerator()
	local center = HexPoint(0, 0)
	local queue = {
		center
	}

	local function enqueueRing(r)
		if r == 0 then
			queue[1] = center

			return
		end

		local pos = HexPoint.directions[5] * r + center

		for side = 1, 6 do
			for _ = 1, r do
				table.insert(queue, pos)

				pos = pos + HexPoint.directions[side]
			end
		end
	end

	local idx = 1
	local radius = 1

	local function refill()
		queue = {}
		idx = 1

		enqueueRing(radius)

		radius = radius + 1
	end

	return function()
		if idx > #queue then
			refill()
		end

		idx = idx + 1

		return queue[idx]
	end
end

function GMSubViewRoomEditMode:onOpen()
	self._subViewGo = gohelper.clone(self._goSubViewTemplate, self._goSubViews, "荒原编辑模式")
	self._content = gohelper.findChild(self._subViewGo, "viewport/content")

	gohelper.setActive(self._subViewGo, false)
end

function GMSubViewRoomEditMode:showSubView()
	gohelper.setActive(self._subViewGo, true)
	self:initViewContent()
end

function GMSubViewRoomEditMode:initViewContent()
	if self._isInit then
		return
	end

	self:_initL1()
	self:_initL2()
	self:_initL3()

	self._isInit = true
end

function GMSubViewRoomEditMode:_initL1()
	local LStr = "L1"

	self:addLabel(LStr, "摆放地块包")

	self._placePackageInputText = self:addInputText(LStr, nil, "packageId#...")

	self.addButton(self, LStr, "确定", self._onClickPlaceBlockPackageOk, self)
	self:addLabel(LStr, "摆放建筑")

	self._placeBuildingInputText = self:addInputText(LStr, nil, "buildingId#...")

	self.addButton(self, LStr, "确定", self._onClickPlaceBuildingOk, self)
end

function GMSubViewRoomEditMode:_onClickPlaceBlockPackageOk(argsPackageIdStr)
	if not argsPackageIdStr then
		::label_9_0::

		local packageIdStr = self._placePackageInputText:GetText()

		if string.nilorempty(packageIdStr) then
			GameFacade.showToast(ToastEnum.IconId, "请输入地块包id")

			return
		end

		self._waitUseBlockList = {}

		local getNextCoord = createSpiralCoordGenerator()
		local packageList = string.splitToNumber(packageIdStr, "#")

		for _, packageId in ipairs(packageList) do
			local packageMO = RoomInventoryBlockModel.instance:getPackageMOById(packageId)

			if packageMO then
				local unUseMOList = packageMO:getUnUseBlockMOList()

				for _, blockMO in ipairs(unUseMOList) do
					local coord

					repeat
						coord = getNextCoord()

						local occupyBlockMO = RoomMapBlockModel.instance:getBlockMO(coord.x, coord.y)
						local isCanPlace = not occupyBlockMO or occupyBlockMO:canPlace()
					until not coord or isCanPlace

					if not coord or not RoomBlockHelper.isInBoundary(coord) then
						logError(string.format("摆放地块包错误，未找到合法位置，packageId:%s blockId:%s 提前结束", packageId, blockMO.blockId))

						break
					end

					table.insert(self._waitUseBlockList, {
						blockId = blockMO.blockId,
						rotate = blockMO.rotate,
						x = coord.x,
						y = coord.y
					})
				end
			else
				logError(string.format("摆放地块包错误，未拥有地块包:%s", packageId))
			end
		end

		self:_beginRequestUseBlockList()
	end
end

function GMSubViewRoomEditMode:_onClickPlaceBuildingOk(argsBuildingIdStr)
	if not argsBuildingIdStr then
		::label_10_0::

		local buildingIdStr = self._placeBuildingInputText:GetText()

		if string.nilorempty(buildingIdStr) then
			GameFacade.showToast(ToastEnum.IconId, "请输入建筑id")

			return
		end

		local buildingIdDict = {}
		local buildingIdList = string.splitToNumber(buildingIdStr, "#")

		for _, buildingId in ipairs(buildingIdList) do
			buildingIdDict[buildingId] = 0
		end

		self._waitUseBuildingList = {}

		local buildingMOList = RoomInventoryBuildingModel.instance:getBuildingMOList()

		for _, buildingMO in ipairs(buildingMOList) do
			local buildingId = buildingMO.buildingId

			if buildingIdDict[buildingId] then
				table.insert(self._waitUseBuildingList, buildingMO)

				buildingIdDict[buildingId] = buildingIdDict[buildingId] + 1
			end
		end

		for buildingId, count in pairs(buildingIdDict) do
			if count <= 0 then
				logError(string.format("摆放建筑错误，%s 没有可放置建筑", buildingId))
			end
		end

		self:_beginRequestUseBuildingList(true)
	end
end

function GMSubViewRoomEditMode:_initL2()
	local LStr = "L2"
	local themeIdList = {}
	local themeCfgList = RoomConfig.instance:getThemeConfigList()

	for i, themeCfg in ipairs(themeCfgList) do
		themeIdList[i] = themeCfg.id
	end

	table.sort(themeIdList, function(a, b)
		return b < a
	end)

	local strList = {
		"选择主题"
	}

	self._themeCfgList = {}

	for _, themeId in ipairs(themeIdList) do
		local themeCfg = RoomConfig.instance:getThemeConfig(themeId)

		self._themeCfgList[#self._themeCfgList + 1] = themeCfg
		strList[#strList + 1] = themeCfg.name
	end

	self.addDropDown(self, LStr, "摆放主题", strList, self._onBlockThemeSelectChange, self, {
		tempH = 450,
		total_w = 600,
		drop_w = 415
	})
	self.addButton(self, LStr, "确定", self._onClickThemeOk, self)
	self.addButton(self, LStr, "随机摆满地块", self._onClickPlaceFullBlock, self)
	self.addButton(self, LStr, "随机摆满建筑", self._onClickPlaceFullBuilding, self)
end

function GMSubViewRoomEditMode:_onBlockThemeSelectChange(index)
	self._selectedThemeCfg = self._themeCfgList[index]
end

function GMSubViewRoomEditMode:_onClickThemeOk()
	if not self._selectedThemeCfg then
		GameFacade.showToast(ToastEnum.IconId, "未选择主题")

		return
	end

	self._waitThemeBuildingStr = nil

	local buildingList = string.splitToNumber(self._selectedThemeCfg.building, "|")

	if buildingList and #buildingList > 0 then
		self._waitThemeBuildingStr = table.concat(buildingList, "#")
	end

	local packageList = string.splitToNumber(self._selectedThemeCfg.packages, "|")

	if packageList and #packageList > 0 then
		local packageIdStr = table.concat(packageList, "#")

		self:_onClickPlaceBlockPackageOk(packageIdStr)
	end
end

function GMSubViewRoomEditMode:_onClickPlaceFullBlock()
	local curNum = RoomMapBlockModel.instance:getConfirmBlockCount()
	local maxNum = RoomMapBlockModel.instance:getMaxBlockCount()

	if maxNum <= curNum then
		GameFacade.showToast(RoomEnum.Toast.InventoryBlockMax)

		return
	end

	local allBlocks = {}
	local packageMOList = RoomInventoryBlockModel.instance:getInventoryBlockPackageMOList()

	for _, packageMO in ipairs(packageMOList) do
		local unUseList = packageMO:getUnUseBlockMOList() or {}

		for _, blockMO in ipairs(unUseList) do
			table.insert(allBlocks, blockMO)
		end
	end

	local hasBlockCount = #allBlocks

	if hasBlockCount == 0 then
		GameFacade.showToast(ToastEnum.IconId, "没有可用地块")

		return
	end

	local needPlaceCount = maxNum - curNum

	if hasBlockCount < needPlaceCount then
		logError("随机摆满地块错误，地块数量不足，无法摆满")

		needPlaceCount = hasBlockCount
	end

	self._waitUseBlockList = {}

	local getNextCoord = createSpiralCoordGenerator()
	local orderList = ArcadeGameHelper.getUniqueRandomNumbers(1, hasBlockCount, hasBlockCount)

	for i = 1, needPlaceCount do
		local coord

		repeat
			coord = getNextCoord()

			local occupyBlockMO = RoomMapBlockModel.instance:getBlockMO(coord.x, coord.y)
			local isCanPlace = not occupyBlockMO or occupyBlockMO:canPlace()
		until not coord or isCanPlace

		if not coord or not RoomBlockHelper.isInBoundary(coord) then
			logError(string.format("随机摆满地块错误，第%s个地块未找到合法位置，提前结束", i))

			break
		end

		local idx = orderList[i]
		local blockMO = allBlocks[idx]

		self._waitUseBlockList[i] = {
			blockId = blockMO.blockId,
			rotate = blockMO.rotate,
			x = coord.x,
			y = coord.y
		}
	end

	self:_beginRequestUseBlockList()
end

function GMSubViewRoomEditMode:_onClickPlaceFullBuilding()
	local decorList = {}
	local buildingMOList = RoomInventoryBuildingModel.instance:getBuildingMOList()

	if buildingMOList then
		for _, buildingMO in ipairs(buildingMOList) do
			local cfg = RoomConfig.instance:getBuildingConfig(buildingMO.buildingId)

			if cfg and cfg.buildingType == RoomBuildingEnum.BuildingType.Decoration then
				table.insert(decorList, buildingMO)
			end
		end
	end

	if #decorList == 0 then
		GameFacade.showToast(ToastEnum.IconId, "没有可用装饰建筑")

		return
	end

	local hasCount = #decorList
	local orderList = ArcadeGameHelper.getUniqueRandomNumbers(1, hasCount, hasCount)

	self._waitUseBuildingList = {}

	for i = 1, hasCount do
		local idx = orderList[i]

		table.insert(self._waitUseBuildingList, decorList[idx])
	end

	self:_beginRequestUseBuildingList()
end

function GMSubViewRoomEditMode:_initL3()
	local LStr = "L3"

	if GameResMgr.IsFromEditorDir then
		RoomDebugController.instance:getDebugPackageInfo(self._onInitDebugMapPackageInfo, self, LStr)
	end
end

function GMSubViewRoomEditMode:_onInitDebugMapPackageInfo(package, groupId)
	local mapNameList = {
		"选择地图"
	}

	self._blockInfosList = {}

	local tRoomConfig = RoomConfig.instance

	for _, packageMap in ipairs(package) do
		local blockInfos = {}

		for _, info in ipairs(packageMap.infos) do
			local hexPoint = HexPoint(info.x, info.y)
			local isInBound = RoomBlockHelper.isInBoundary(hexPoint)

			if tRoomConfig:getBlock(info.blockId) and not tRoomConfig:getInitBlock(info.blockId) and isInBound then
				table.insert(blockInfos, info)
			end
		end

		if #blockInfos > 1 then
			table.insert(mapNameList, packageMap.packageName)
			table.insert(self._blockInfosList, blockInfos)
		end
	end

	self.addDropDown(self, groupId, "复制地图地块", mapNameList, self._onDropDownMapPackageChanged, self, {
		total_w = 700,
		drop_w = 450
	})
end

function GMSubViewRoomEditMode:_onDropDownMapPackageChanged(index)
	if index >= 1 or index <= #self._blockInfosList then
		if RoomMapBlockModel.instance:getConfirmBlockCount() > 0 then
			GameFacade.showToast(ToastEnum.IconId, "需要先重置荒原")

			return
		end

		self._waitUseBlockList = {}

		tabletool.addValues(self._waitUseBlockList, self._blockInfosList[index])
		self:_beginRequestUseBlockList()
	end
end

function GMSubViewRoomEditMode:_beginRequestUseBlockList()
	TaskDispatcher.cancelTask(self._onWaitUseBlock, self)

	if self._waitUseBlockList then
		if not #self._waitUseBlockList then
			local blockCount = 0

			if string.nilorempty(self._waitThemeBuildingStr) then
				if blockCount > 0 then
					UIBlockMgr.instance:startBlock(GMSubViewRoomEditMode.useBlockKey)
					TaskDispatcher.runRepeat(self._onWaitUseBlock, self, 0.001, #self._waitUseBlockList + 1)
				end
			elseif blockCount > 0 then
				self:_onWaitUseBlock()
			else
				self:_afterUseBlock()
			end
		end
	end
end

function GMSubViewRoomEditMode:_onWaitUseBlock()
	if self._waitUseBlockList then
		if not #self._waitUseBlockList then
			local blockCount = 0

			if blockCount <= 0 then
				if string.nilorempty(self._waitThemeBuildingStr) then
					UIBlockMgr.instance:endBlock(GMSubViewRoomEditMode.useBlockKey)
					RoomController.instance:exitRoom(true)
				end

				return
			end

			local info = table.remove(self._waitUseBlockList, 1)
			local blockId = info.blockId

			if string.nilorempty(self._waitThemeBuildingStr) then
				RoomMapController.instance:useBlockRequest(blockId, info.rotate, info.x, info.y)
			else
				local hexPoint = HexPoint(info.x, info.y)
				local inventoryBlockMO = RoomInventoryBlockModel.instance:getInventoryBlockMOById(blockId)

				RoomMapBlockModel.instance:addTempBlockMO(inventoryBlockMO, hexPoint)
				RoomMapController.instance:useBlockRequest(blockId, info.rotate, info.x, info.y, self._afterUseBlock, self)
			end
		end
	end
end

function GMSubViewRoomEditMode:_afterUseBlock(_, resultCode, _)
	if resultCode ~= 0 then
		RoomMapBlockModel.instance:removeTempBlockMO()

		self._waitUseBlockList = nil
	end

	if self._waitUseBlockList then
		if not #self._waitUseBlockList then
			local blockCount = 0

			if blockCount > 0 then
				self:_onWaitUseBlock()
			else
				UIBlockMgr.instance:endBlock(GMSubViewRoomEditMode.useBlockKey)

				local buildingStr = self._waitThemeBuildingStr

				self._waitThemeBuildingStr = nil

				self:_onClickPlaceBuildingOk(buildingStr)
			end
		end
	end
end

function GMSubViewRoomEditMode:_beginRequestUseBuildingList(logError)
	if self._waitUseBuildingList then
		if not #self._waitUseBuildingList then
			local buildingCount = 0

			if buildingCount <= 0 then
				return
			end

			self._lastPlacedInfo = nil
			self._logPlaceBuildingError = logError

			UIBlockMgr.instance:startBlock(GMSubViewRoomEditMode.useBuildingKey)
			self:_onWaitUseBuilding()
		end
	end
end

function GMSubViewRoomEditMode:_onWaitUseBuilding()
	if self._waitUseBuildingList then
		if not #self._waitUseBuildingList then
			local buildingCount = 0

			if buildingCount <= 0 then
				return
			end

			if not self._cameraNearRotate then
				local scene = GameSceneMgr.instance:getCurScene()
				local camRotate = scene.camera:getCameraRotate()
				local rotation = camRotate * Mathf.Rad2Deg

				self._cameraNearRotate = RoomRotateHelper.getCameraNearRotate(rotation)
			end

			while #self._waitUseBuildingList > 0 do
				local buildingMO = table.remove(self._waitUseBuildingList, 1)
				local buildingId = buildingMO.buildingId
				local buildingConfig = RoomConfig.instance:getBuildingConfig(buildingId)
				local nearRotate = self._cameraNearRotate + buildingConfig.rotate
				local bestPositionParam = self:_getRecommendHexPoint(buildingMO, nearRotate)

				if bestPositionParam then
					local rotate = bestPositionParam.rotate
					local hexPoint = bestPositionParam.hexPoint

					self._lastPlacedInfo = {
						buildingId = buildingId,
						x = hexPoint.x,
						y = hexPoint.y
					}

					RoomMapBuildingModel.instance:addTempBuildingMO(buildingMO, hexPoint)
					RoomRpc.instance:sendUseBuildingRequest(buildingMO.uid, rotate, hexPoint.x, hexPoint.y, self._afterUseBuilding, self)

					return
				elseif self._logPlaceBuildingError then
					logError(string.format("摆放建筑错误，%s 没有可放置区域", buildingId))
				end
			end

			self:_afterUseBuilding()
		end
	end
end

function GMSubViewRoomEditMode:_afterUseBuilding(_, resultCode, _)
	if resultCode ~= 0 then
		RoomMapBuildingModel.instance:removeTempBuildingMO()

		self._waitUseBuildingList = nil
	elseif self._lastPlacedInfo then
		self._placedBuildings = self._placedBuildings or {}

		table.insert(self._placedBuildings, {
			buildingId = self._lastPlacedInfo.buildingId,
			x = self._lastPlacedInfo.x,
			y = self._lastPlacedInfo.y
		})

		self._lastPlacedInfo = nil
	end

	if self._waitUseBuildingList then
		if not #self._waitUseBuildingList then
			local buildingCount = 0

			if buildingCount > 0 then
				self:_onWaitUseBuilding()
			elseif not self._placedBuildings then
				local placed = {}

				self._placedBuildings = nil
				self._cameraNearRotate = nil

				GameFacade.showToast(ToastEnum.IconId, string.format("成功摆放%d个建筑", #placed))
				UIBlockMgr.instance:endBlock(GMSubViewRoomEditMode.useBuildingKey)

				if #placed > 0 then
					for _, rec in ipairs(placed) do
						logNormal(string.format("摆放建筑:%s 坐标(%s,%s)", tostring(rec.buildingId), tostring(rec.x), tostring(rec.y)))
					end
				end

				RoomController.instance:exitRoom(true)
			end
		end
	end
end

function GMSubViewRoomEditMode:_getRecommendHexPoint(buildingMO, nearRotate)
	local config = buildingMO.config
	local bestPositionParam

	return (config.vehicleType ~= 0 or nil) and self:_getVehicleHexPoint(buildingMO, nearRotate) or RoomBuildingHelper.getRecommendHexPoint(buildingMO.buildingId, nil, nil, buildingMO.levels, nearRotate)
end

function GMSubViewRoomEditMode:_getVehicleHexPoint(buildingMO, nearRotate)
	local config = buildingMO.config
	local vehicleCfg = RoomConfig.instance:getVehicleConfig(config.vehicleId)

	if not vehicleCfg then
		return nil
	end

	local resCfg = RoomConfig.instance:getResourceConfig(vehicleCfg.resId)

	if resCfg then
		if not resCfg.numLimit then
			local numLimit = 2
			local dic = RoomResourceHelper.getResourcePointAreaMODict(nil, {
				vehicleCfg.resId
			})
			local mo = dic[vehicleCfg.resId]

			if not mo then
				return nil
			end

			local areaList = mo:findeArea()
			local allResPointList = {}

			for _, resourcePointList in ipairs(areaList) do
				local num = self:_getNumByResourcePointList(resourcePointList)

				if numLimit <= num then
					tabletool.addValues(allResPointList, resourcePointList)
				end
			end

			if #allResPointList > 0 then
				return self:_getHexPointByResourcePoint(buildingMO, nearRotate, allResPointList)
			end
		end
	end
end

function GMSubViewRoomEditMode:_getNumByResourcePointList(resourcePointList)
	local tempDic = {}
	local count = 0
	local tRoomResourceModel = RoomResourceModel.instance

	for _, resourcePoint in ipairs(resourcePointList) do
		local index = tRoomResourceModel:getIndexByXY(resourcePoint.x, resourcePoint.y)

		if not tempDic[index] then
			count = count + 1
			tempDic[index] = true
		end
	end

	return count
end

function GMSubViewRoomEditMode:_getHexPointByResourcePoint(buildingMO, nearRotate, resourcePointList)
	local tempDic = {}
	local mapBlockMODict = RoomMapBlockModel.instance:getBlockMODict()

	for _, resourcePoint in ipairs(resourcePointList) do
		local x = resourcePoint.x
		local y = resourcePoint.y

		tempDic[x] = tempDic[x] or {}
		tempDic[x][y] = mapBlockMODict[x][y]
	end

	return RoomBuildingHelper.getRecommendHexPoint(buildingMO.buildingId, tempDic, nil, buildingMO.levels, nearRotate)
end

function GMSubViewRoomEditMode:closeSubView()
	gohelper.setActive(self._subViewGo, false)
end

function GMSubViewRoomEditMode:onDestroyView()
	TaskDispatcher.cancelTask(self._onWaitUseBlock, self)
end

return GMSubViewRoomEditMode
