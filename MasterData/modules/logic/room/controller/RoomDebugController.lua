-- chunkname: @modules/logic/room/controller/RoomDebugController.lua

module("modules.logic.room.controller.RoomDebugController", package.seeall)

local RoomDebugController = class("RoomDebugController", BaseController)
local _OWN_TYPE_MAP = {
	[16] = 1
}

function RoomDebugController:onInit()
	self:clear()
end

function RoomDebugController:reInit()
	self:clear()
end

function RoomDebugController:clear()
	self._isDebugPlaceListShow = false
	self._isDebugPackageListShow = false
	self._isDebugBuildingListShow = false
	self._tempInitConfig = nil
	self._tempPackageConfig = nil
	self._editPackageOrder = false
end

function RoomDebugController:addConstEvents()
	return
end

function RoomDebugController:setEditPackageOrder(editPackageOrder)
	self._editPackageOrder = editPackageOrder

	self:dispatchEvent(RoomEvent.DebugPackageOrderChanged)
end

function RoomDebugController:isEditPackageOrder()
	return self._editPackageOrder
end

function RoomDebugController:getTempInitConfig()
	return self._tempInitConfig
end

function RoomDebugController:getTempPackageConfig()
	return self._tempPackageConfig
end

function RoomDebugController:getUseCountByDefineId(defineId)
	local packageMapConfigs = self:getTempPackageConfig()
	local count = 0

	if packageMapConfigs then
		for _, packageMapConfig in ipairs(packageMapConfigs) do
			for _, info in ipairs(packageMapConfig.infos) do
				if info.defineId == defineId then
					count = count + 1
				end
			end
		end
	end

	return count
end

function RoomDebugController:openBuildingAreaView()
	ViewMgr.instance:openView(ViewName.RoomDebugBuildingAreaView)
end

function RoomDebugController:openBuildingCamerView()
	ViewMgr.instance:openView(ViewName.RoomDebugBuildingCameraView)
end

function RoomDebugController:setDebugPlaceListShow(isShow)
	self._isDebugPlaceListShow = isShow

	self:dispatchEvent(RoomEvent.DebugPlaceListShowChanged, isShow)
end

function RoomDebugController:isDebugPlaceListShow()
	return self._isDebugPlaceListShow
end

function RoomDebugController:setDebugPackageListShow(isShow)
	self._isDebugPackageListShow = isShow

	self:dispatchEvent(RoomEvent.DebugPackageListShowChanged, isShow)
end

function RoomDebugController:isDebugPackageListShow()
	return self._isDebugPackageListShow
end

function RoomDebugController:setDebugBuildingListShow(isShow)
	self._isDebugBuildingListShow = isShow

	self:dispatchEvent(RoomEvent.DebugBuildingListShowChanged, isShow)
end

function RoomDebugController:isDebugBuildingListShow()
	return self._isDebugBuildingListShow
end

function RoomDebugController:_getNextPackageOrder(packageId, blockId)
	local maxPackageOrder = 0

	if self._tempPackageConfig then
		for _, packageMapConfig in ipairs(self._tempPackageConfig) do
			for _, info in ipairs(packageMapConfig.infos) do
				if info.packageId == packageId and maxPackageOrder < info.packageOrder and info.blockId ~= blockId then
					maxPackageOrder = info.packageOrder
				end
			end
		end
	end

	return maxPackageOrder + 1
end

function RoomDebugController:_getNextBlockId(isPackageMode, packageMapId)
	local blockId = 0
	local fullBlockMOList = RoomMapBlockModel.instance:getFullBlockMOList()

	if isPackageMode then
		blockId = packageMapId * 1000 + 1

		local usedBlockIdDict = {}

		if self._tempPackageConfig then
			for _, package in ipairs(self._tempPackageConfig) do
				if package.packageMapId ~= packageMapId then
					for _, info in ipairs(package.infos) do
						usedBlockIdDict[info.blockId] = true
					end
				end
			end
		end

		for _, blockMO in ipairs(fullBlockMOList) do
			usedBlockIdDict[blockMO.blockId] = true
		end

		while usedBlockIdDict[blockId] do
			blockId = blockId + 1
		end

		return blockId
	else
		for _, blockMO in ipairs(fullBlockMOList) do
			if blockId > blockMO.blockId then
				blockId = blockMO.blockId
			end
		end

		return blockId - 1
	end
end

function RoomDebugController:_getNextBuildingUid()
	local maxBuildingUid = 0
	local buildingMOList = RoomMapBuildingModel.instance:getBuildingMOList()

	for _, buildingMO in ipairs(buildingMOList) do
		if maxBuildingUid < buildingMO.id then
			maxBuildingUid = buildingMO.id
		end
	end

	return maxBuildingUid + 1
end

function RoomDebugController:debugPlaceBlock(hexPoint)
	local selectDefineId = RoomDebugPlaceListModel.instance:getSelect()

	if not selectDefineId or selectDefineId == 0 then
		return
	end

	self:_debugPlaceBlock(hexPoint, selectDefineId)
end

function RoomDebugController:_debugPlaceBlock(hexPoint, defineId)
	local isPackageMode = RoomController.instance:isDebugPackageMode()
	local debugParam = RoomModel.instance:getDebugParam()
	local blockId = self:_getNextBlockId(isPackageMode, isPackageMode and debugParam and debugParam.packageMapId)
	local resourceList = {}

	for i = 1, 6 do
		table.insert(resourceList, RoomResourceEnum.ResourceId.None)
	end

	local info = {
		rotate = 0,
		blockId = blockId,
		defineId = defineId,
		mainRes = RoomResourceEnum.ResourceId.None,
		blockState = RoomBlockEnum.BlockState.Map,
		x = hexPoint.x,
		y = hexPoint.y
	}
	local blockMO, emptyMO = RoomMapBlockModel.instance:debugConfirmPlaceBlock(hexPoint, info)

	RoomMapBlockModel.instance:refreshNearRiver(hexPoint, 1)
	self:dispatchEvent(RoomEvent.DebugConfirmPlaceBlock, hexPoint, blockMO, emptyMO)
	self:saveDebugMapParam()
	GameFacade.closeInputBox()
end

function RoomDebugController:debugRotateBlock(hexPoint)
	local blockMO = RoomMapBlockModel.instance:getBlockMO(hexPoint.x, hexPoint.y)

	if blockMO.blockState ~= RoomBlockEnum.BlockState.Map then
		return
	end

	blockMO.rotate = RoomRotateHelper.rotateRotate(blockMO.rotate, 1)

	RoomMapBlockModel.instance:refreshNearRiver(hexPoint, 1)
	self:dispatchEvent(RoomEvent.DebugRotateBlock, hexPoint, blockMO)
	self:saveDebugMapParam()
end

function RoomDebugController:debugRootOutBlock(hexPoint)
	if hexPoint.x == 0 and hexPoint.y == 0 then
		return
	end

	local blockMO = RoomMapBlockModel.instance:getBlockMO(hexPoint.x, hexPoint.y)

	if blockMO.blockState ~= RoomBlockEnum.BlockState.Map then
		return
	end

	local emptyMOList = RoomMapBlockModel.instance:debugRootOutBlock(hexPoint)

	RoomMapBlockModel.instance:refreshNearRiver(hexPoint, 1)
	self:dispatchEvent(RoomEvent.DebugRootOutBlock, hexPoint, blockMO, emptyMOList)
	self:saveDebugMapParam()
end

function RoomDebugController:debugReplaceBlock(hexPoint)
	local blockMO = RoomMapBlockModel.instance:getBlockMO(hexPoint.x, hexPoint.y)

	if blockMO.blockState ~= RoomBlockEnum.BlockState.Map then
		return
	end

	local selectDefineId = RoomDebugPlaceListModel.instance:getSelect()

	if not selectDefineId or selectDefineId == 0 then
		return
	end

	if selectDefineId == blockMO.defineId then
		return
	end

	self:_debugReplaceBlock(hexPoint, selectDefineId)
end

function RoomDebugController:_debugReplaceBlock(hexPoint, defineId)
	local blockMO = RoomMapBlockModel.instance:getBlockMO(hexPoint.x, hexPoint.y)

	if blockMO.blockState ~= RoomBlockEnum.BlockState.Map then
		return
	end

	blockMO.defineId = defineId

	self:dispatchEvent(RoomEvent.DebugReplaceBlock, hexPoint, blockMO)
	GameFacade.closeInputBox()
end

function RoomDebugController:debugSetPackage(blockId)
	local selectPackageId = RoomDebugPackageListModel.instance:getFilterPackageId()

	if not selectPackageId or selectPackageId == 0 then
		return
	end

	self:debugSetPackageId(blockId, selectPackageId)
end

function RoomDebugController:debugSetPackageId(blockId, packageId)
	local info = self:getBlockInfoOrBlockMO(blockId)

	if not info then
		return
	end

	local selectMainRes = RoomDebugPackageListModel.instance:getFilterMainRes()

	selectMainRes = selectMainRes or RoomResourceEnum.ResourceId.Empty

	if packageId == 0 then
		info.packageOrder = 0
		info.mainRes = RoomResourceEnum.ResourceId.Empty
	elseif info.packageId == packageId then
		if not info.packageOrder then
			info.packageOrder = self:_getNextPackageOrder(packageId, info.blockId)
			info.mainRes = selectMainRes
		end
	end

	info.packageId = packageId

	self:output(true)
	RoomDebugPackageListModel.instance:setDebugPackageList()

	local blockMO = RoomMapBlockModel.instance:getFullBlockMOById(blockId)

	self:dispatchEvent(RoomEvent.DebugSetPackage, blockMO and blockMO.hexPoint, blockMO)
	GameFacade.closeInputBox()
end

function RoomDebugController:debugSetMainRes(blockId)
	local info = self:getBlockInfoOrBlockMO(blockId)

	if not info then
		return
	end

	local var_29_0 = {
		characterLimit = 100,
		sureBtnName = "确定",
		title = "设置分类",
		cancelBtnName = "取消"
	}

	var_29_0.defaultInput = tostring(info.mainRes or -1)

	function var_29_0.sureCallback(inputStr)
		self:_debugSetMainRes(blockId, tonumber(inputStr))
	end

	GameFacade.openInputBox(var_29_0)
end

function RoomDebugController:_debugSetMainRes(blockId, mainRes)
	local info = self:getBlockInfoOrBlockMO(blockId)

	if not info then
		return
	end

	if not mainRes then
		return
	end

	info.mainRes = mainRes

	RoomDebugController.instance:output(true)
	RoomDebugPackageListModel.instance:setDebugPackageList()
	GameFacade.closeInputBox()
	RoomDebugController.instance:dispatchEvent(RoomEvent.DebugPackageOrderChanged)
end

function RoomDebugController:debugSetPackageOrder(blockId)
	local info = self:getBlockInfoOrBlockMO(blockId)

	if not info then
		return
	end

	local var_32_0 = {
		characterLimit = 100,
		sureBtnName = "确定",
		title = "设置排序",
		cancelBtnName = "取消"
	}

	var_32_0.defaultInput = tostring(info.packageOrder or 0)

	function var_32_0.sureCallback(inputStr)
		self:_debugSetPackageOrder(blockId, tonumber(inputStr))
	end

	GameFacade.openInputBox(var_32_0)
end

function RoomDebugController:debugSetPackageLastOrder(blockId)
	local info = self:getBlockInfoOrBlockMO(blockId)

	if not info then
		return
	end

	if info.packageId == 0 then
		return
	end

	local packageOrder = self:_getNextPackageOrder(info.packageId, blockId)

	self:_debugSetPackageOrder(blockId, packageOrder)
end

function RoomDebugController:_debugSetPackageOrder(blockId, packageOrder)
	local info = self:getBlockInfoOrBlockMO(blockId)

	if not info then
		return
	end

	if not packageOrder then
		return
	end

	info.packageOrder = packageOrder

	RoomDebugController.instance:output(true)
	RoomDebugPackageListModel.instance:setDebugPackageList()
	GameFacade.closeInputBox()
	RoomDebugController.instance:dispatchEvent(RoomEvent.DebugPackageOrderChanged)
end

function RoomDebugController:exchangeOrder(blockIdA, blockIdB)
	local blockInfoA = self:getBlockInfoOrBlockMO(blockIdA)
	local blockInfoB = self:getBlockInfoOrBlockMO(blockIdB)

	blockInfoA.packageOrder, blockInfoB.packageOrder = blockInfoB.packageOrder, blockInfoA.packageOrder

	RoomDebugController.instance:output(true)
	RoomDebugPackageListModel.instance:setDebugPackageList()
	RoomDebugController.instance:dispatchEvent(RoomEvent.DebugPackageOrderChanged)
end

function RoomDebugController:getBlockInfoOrBlockMO(blockId)
	local blockMO = RoomMapBlockModel.instance:getFullBlockMOById(blockId)

	if blockMO then
		return blockMO
	end

	if not self._tempPackageConfig then
		return nil
	end

	for _, packageMapConfig in ipairs(self._tempPackageConfig) do
		for _, info in ipairs(packageMapConfig.infos) do
			if info.blockId == blockId then
				return info
			end
		end
	end
end

function RoomDebugController:debugPlaceBuilding(hexPoint)
	local selectBuildingId = RoomDebugBuildingListModel.instance:getSelect()

	if not selectBuildingId then
		return
	end

	self:_debugPlaceBuilding(hexPoint, selectBuildingId)
end

function RoomDebugController:_debugPlaceBuilding(hexPoint, buildingId)
	local replaceBuildingMO = RoomMapBuildingModel.instance:getBuildingMO(hexPoint.x, hexPoint.y)

	if replaceBuildingMO then
		if replaceBuildingMO.buildingId == buildingId then
			return
		else
			RoomDebugController.instance:debugRootOutBuilding(hexPoint)
		end
	end

	if buildingId then
		::label_39_0::

		local buildingConfig = RoomConfig.instance:getBuildingConfig(buildingId)

		if not buildingConfig then
			return
		end

		GameFacade.closeInputBox()

		local buildingUid = self:_getNextBuildingUid()
		local buildingConfigParam = RoomMapModel.instance:getBuildingConfigParam(buildingId)
		local levelGroups = buildingConfigParam.levelGroups
		local levels = {}

		for i, levelGroup in ipairs(levelGroups) do
			local maxLevel = RoomConfig.instance:getLevelGroupMaxLevel(levelGroup)

			table.insert(levels, maxLevel)
		end

		local info = {
			resAreaDirection = 0,
			rotate = 0,
			uid = buildingUid,
			buildingId = buildingId,
			levels = levels,
			buildingState = RoomBuildingEnum.BuildingState.Map,
			x = hexPoint.x,
			y = hexPoint.y
		}
		local buildingMO = RoomMapBuildingModel.instance:debugPlaceBuilding(hexPoint, info)

		RoomMapBuildingModel.instance:clearAllOccupyDict()
		self:dispatchEvent(RoomEvent.DebugPlaceBuilding, hexPoint, buildingMO)
		self:saveDebugMapParam()
	end
end

function RoomDebugController:debugRotateBuilding(hexPoint)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMO(hexPoint.x, hexPoint.y)

	if not buildingMO then
		return
	end

	local previousRotate = buildingMO.rotate

	buildingMO.rotate = RoomRotateHelper.rotateRotate(buildingMO.rotate, 1)

	RoomMapBuildingModel.instance:clearAllOccupyDict()
	self:dispatchEvent(RoomEvent.DebugRotateBuilding, hexPoint, buildingMO, previousRotate)
	self:saveDebugMapParam()
end

function RoomDebugController:debugRootOutBuilding(hexPoint)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMO(hexPoint.x, hexPoint.y)

	if not buildingMO then
		return
	end

	RoomMapBuildingModel.instance:debugRootOutBuilding(hexPoint)
	RoomMapBuildingModel.instance:clearAllOccupyDict()
	self:dispatchEvent(RoomEvent.DebugRootOutBuilding, hexPoint, buildingMO)
	self:saveDebugMapParam()
end

function RoomDebugController:getEmptyMapInfo(isPackageMode, packageMapId)
	local blockId = self:_getNextBlockId(isPackageMode, packageMapId)

	return {
		infos = {
			{
				packageId = 0,
				rotate = 0,
				packageOrder = 0,
				x = 0,
				y = 0,
				blockId = blockId,
				defineId = RoomResourceEnum.EmptyDefineId,
				mainRes = RoomResourceEnum.ResourceId.Empty
			}
		}
	}
end

function RoomDebugController:getEmptyInitInfo()
	local init = {}
	local emptyMapInfo = self:getEmptyMapInfo()

	init.infos = emptyMapInfo.infos

	return init
end

function RoomDebugController:getEmptyPackageInfo()
	return {}
end

function RoomDebugController:generateMapInfo(fullBlockMOList, mapBuildingMOList)
	fullBlockMOList = fullBlockMOList or RoomMapBlockModel.instance:getFullBlockMOList()
	mapBuildingMOList = mapBuildingMOList or RoomMapBuildingModel.instance:getBuildingMOList()

	local map = {}

	map.infos = {}

	local isPackageMode = RoomController.instance:isDebugPackageMode()

	for i, blockMO in ipairs(fullBlockMOList) do
		if blockMO.blockState == RoomBlockEnum.BlockState.Map then
			local info = {}

			info.blockId = blockMO.blockId
			info.defineId = blockMO.defineId
			info.mainRes = blockMO.mainRes
			info.x, info.y = blockMO.hexPoint.x, blockMO.hexPoint.y
			info.rotate = blockMO.rotate

			if isPackageMode then
				info.packageId = blockMO.packageId or 0
				info.packageOrder = blockMO.packageOrder or blockMO.blockId
			end

			table.insert(map.infos, info)
		end
	end

	map.buildingInfos = {}

	for i, buildingMO in ipairs(mapBuildingMOList) do
		local info = {}

		info.uid = i
		info.defineId = buildingMO.buildingId
		info.use = true
		info.x = buildingMO.hexPoint.x
		info.y = buildingMO.hexPoint.y
		info.rotate = buildingMO.rotate
		info.resAreaDirection = buildingMO.resAreaDirection

		table.insert(map.buildingInfos, info)
	end

	return map
end

function RoomDebugController:getDebugMapInfo()
	local map
	local mapParam = PlayerPrefsHelper.getString(PlayerPrefsKey.RoomDebugMapParam, "")

	map = string.nilorempty(mapParam) and self:getEmptyMapInfo() or cjson.decode(mapParam)
	map.remainBlock = 0

	return map
end

function RoomDebugController:saveDebugMapParam()
	if not RoomController.instance:isDebugNormalMode() then
		return
	end

	local map = self:generateMapInfo()

	if #map.infos > 0 then
		local mapParam = cjson.encode(map)

		PlayerPrefsHelper.setString(PlayerPrefsKey.RoomDebugMapParam, mapParam)
	end
end

function RoomDebugController:getDebugInitInfo(callback, callbackObj)
	if self._tempInitConfig then
		if callback then
			if callbackObj then
				callback(callbackObj, self._tempInitConfig)
			else
				callback(self._tempInitConfig)
			end
		end

		return
	end

	loadAbAsset(RoomEnum.InitMapConfigPathEditor, false, function(assetItem)
		local init

		if assetItem.IsLoadSuccess then
			local textAsset = assetItem:GetResource(RoomEnum.InitMapConfigPathEditor)
			local initParam = textAsset.text

			init = cjson.decode(initParam)
		else
			init = self:getEmptyInitInfo()
		end

		self._tempInitConfig = init

		if callback then
			if callbackObj then
				callback(callbackObj, init)
			else
				callback(init)
			end
		end
	end)
end

function RoomDebugController:getDebugInitMapInfo(param, callback, callbackObj)
	self:getDebugInitInfo(function(init)
		local map = {}

		map.infos = init.infos

		if not map.infos then
			map = self:getEmptyMapInfo()
		end

		if callback then
			if callbackObj then
				callback(callbackObj, map)
			else
				callback(map)
			end
		end
	end)
end

function RoomDebugController:outputInitJson(temp)
	self:getDebugInitInfo(function(init)
		local map = self:generateMapInfo()

		map.buildingInfos = nil
		init.infos = map.infos

		self:saveInitMapParam(init, temp)
	end)
end

function RoomDebugController:resetInitJson()
	self:getDebugInitInfo(function(init)
		local emptyMap = self:getEmptyMapInfo()

		init.infos = emptyMap.infos

		self:saveInitMapParam(init)
	end)
end

function RoomDebugController:saveInitMapParam(init, temp)
	self._tempInitConfig = init

	if temp then
		return
	end

	local initParam = cjson.encode(init)
	local initClientParam = self:_wrapClientConfigParam(init, "block_init")

	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	local pathEditor = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.InitMapConfigPathEditor)
	local pathClient = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.InitMapConfigPath)
	local pathServer = System.IO.Path.Combine(UnityEngine.Application.dataPath, "../../../projm-server/projM-server-config/resources/T_block_init.json")

	SLFramework.FileHelper.WriteTextToPath(pathEditor, initParam)
	SLFramework.FileHelper.WriteTextToPath(pathClient, initClientParam)
	SLFramework.FileHelper.WriteTextToPath(pathServer, initParam)
	self:assetDatabaseRefresh()
	logNormal("导出完成 记得提交前后端配置文件")
end

function RoomDebugController:getDebugPackageInfo(callback, callbackObj, extraParam)
	if self._tempPackageConfig then
		if callback then
			if callbackObj then
				callback(callbackObj, self._tempPackageConfig, extraParam)
			else
				callback(self._tempPackageConfig, extraParam)
			end
		end

		return
	end

	local loader = MultiAbLoader.New()

	loader:addPath(RoomEnum.BlockPackageMapPath)

	if SLFramework.FrameworkSettings.IsEditor then
		loader:addPath(RoomEnum.BlockPackageDataPath)
	end

	loader:startLoad(function()
		local assetItemDict = loader:getAssetItemDict()
		local packageAssetItem = assetItemDict[RoomEnum.BlockPackageMapPath]
		local packageTextAsset = packageAssetItem:GetResource(RoomEnum.BlockPackageMapPath)
		local packageText = packageTextAsset.text
		local package = cjson.decode(packageText)

		if SLFramework.FrameworkSettings.IsEditor then
			local packageDataAssetItem = assetItemDict[RoomEnum.BlockPackageDataPath]
			local packageDataTextAsset = packageDataAssetItem:GetResource(RoomEnum.BlockPackageDataPath)
			local packageDataText = packageDataTextAsset.text
			local packageDatas = cjson.decode(packageDataText)[2]

			self:_injectPackageInfo(package, packageDatas)
		end

		self:_refreshPackageOrder(package)

		self._tempPackageConfig = package

		if callback then
			if callbackObj then
				callback(callbackObj, package, extraParam)
			else
				callback(package, extraParam)
			end
		end

		loader:dispose()
	end)
end

function RoomDebugController:_injectPackageInfo(package, packageDatas)
	local blockId2PackageDict = {}

	for _, packageInfo in ipairs(packageDatas) do
		local packageId = packageInfo.id

		for packageOrder, info in ipairs(packageInfo.infos) do
			blockId2PackageDict[info.blockId] = {
				packageId = packageId,
				packageOrder = packageOrder
			}
		end
	end

	for _, packageMap in ipairs(package) do
		for _, info in ipairs(packageMap.infos) do
			local package = blockId2PackageDict[info.blockId]

			if package then
				info.packageId = package.packageId or 0
			end

			if package then
				info.packageOrder = package.packageOrder or 0
			end
		end
	end
end

function RoomDebugController:getDebugPackageMapInfo(param, callback, callbackObj)
	local packageMapId = param and param.packageMapId

	self:getDebugPackageInfo(function(package)
		local map = {}

		for i, packageMap in ipairs(package) do
			if packageMap.packageMapId == packageMapId then
				map.infos = packageMap.infos
				map.buildingInfos = packageMap.buildingInfos
				map.packageName = packageMap.packageName

				break
			end
		end

		if not map.infos then
			map = self:getEmptyMapInfo(true, packageMapId)
		end

		if callback then
			if callbackObj then
				callback(callbackObj, map)
			else
				callback(map)
			end
		end
	end)
end

function RoomDebugController:outputPackageJson(packageMapId, temp)
	self:getDebugPackageMapInfo({
		packageMapId = packageMapId
	}, function(packageMap)
		local map = self:generateMapInfo()

		packageMap.infos = map.infos
		packageMap.buildingInfos = map.buildingInfos

		self:savePackageMapParam(packageMapId, packageMap, temp)
	end)
end

function RoomDebugController:resetPackageJson(packageMapId, packageName)
	local packageMap = {}
	local emptyMap = self:getEmptyMapInfo(true, packageMapId)

	packageMap.infos = emptyMap.infos
	packageMap.buildingInfos = {}
	packageMap.packageName = packageName

	self:savePackageMapParam(packageMapId, packageMap)
end

function RoomDebugController:copyPackageJson(packageMapId, packageName, copyPackageMapId)
	self:getDebugPackageInfo(function(package)
		local packageMap

		for _, packageMapItem in ipairs(package) do
			if packageMapItem.packageMapId == copyPackageMapId then
				packageMap = LuaUtil.deepCopyNoMeta(packageMapItem)

				break
			end
		end

		if not packageMap then
			return
		end

		packageMap.packageName = packageName

		local blockId = self:_getNextBlockId(true, packageMapId)

		for i, info in ipairs(packageMap.infos) do
			info.mainRes = -1
			info.packageId = 0
			info.packageOrder = 0
			info.blockId = blockId
			blockId = blockId + 1
		end

		self:savePackageMapParam(packageMapId, packageMap)
	end)
end

function RoomDebugController:deletePackageJson(packageMapId)
	self:getDebugPackageInfo(function(package)
		for i, packageMapItem in ipairs(package) do
			if packageMapItem.packageMapId == packageMapId then
				table.remove(package, i)

				break
			end
		end

		self:_refreshPackageOrder(package)

		self._tempPackageConfig = package

		local clientPackage = LuaUtil.deepCopyNoMeta(package)

		self:_clearPackageInfo(clientPackage)

		local allPackageInfo, allPackageBuildingInfo = self:_getAllInfo(clientPackage)
		local clientParam = self:_jsonEncode(clientPackage)

		if not SLFramework.FrameworkSettings.IsEditor then
			return
		end

		clientParam = self:_replaceInfoStr(clientParam, allPackageInfo, allPackageBuildingInfo)

		local pathClient = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.BlockPackageMapPath)

		SLFramework.FileHelper.WriteTextToPath(pathClient, clientParam)
		self:savePackageDataParam(package)
		self:assetDatabaseRefresh()
		logNormal("导出完成 记得提交前后端配置文件")
	end)
end

function RoomDebugController:renamePackageJson(packageMapId, packageName)
	self:getDebugPackageInfo(function(package)
		local packageMap

		for i, packageMapItem in ipairs(package) do
			if packageMapItem.packageMapId == packageMapId then
				packageMapItem.packageName = packageName
				packageMap = packageMapItem

				break
			end
		end

		if packageMap then
			self:savePackageMapParam(packageMapId, packageMap)
		end
	end)
end

function RoomDebugController:changePackageMapIdJson(packageMapId, newPackageMapId)
	self:getDebugPackageInfo(function(package)
		local packageMap

		for i, packageMapItem in ipairs(package) do
			if packageMapItem.packageMapId == packageMapId then
				packageMapItem.packageMapId = newPackageMapId
				packageMap = packageMapItem

				local blockId = self:_getNextBlockId(true, newPackageMapId)

				for _, info in ipairs(packageMap.infos) do
					info.blockId = blockId
					blockId = blockId + 1
				end

				break
			end
		end

		if packageMap then
			self:savePackageMapParam(newPackageMapId, packageMap)
		end
	end)
end

function RoomDebugController:savePackageMapParam(packageMapId, packageMap, temp)
	self:getDebugPackageInfo(function(package)
		local flag = false

		for i, packageMapItem in ipairs(package) do
			if packageMapItem.packageMapId == packageMapId then
				packageMapItem.infos = packageMap.infos
				packageMapItem.buildingInfos = packageMap.buildingInfos
				packageMapItem.packageName = packageMap.packageName
				flag = true

				break
			end
		end

		if not flag then
			table.insert(package, {
				packageMapId = packageMapId,
				infos = packageMap.infos,
				buildingInfos = packageMap.buildingInfos,
				packageName = packageMap.packageName
			})
		end

		self:_refreshPackageOrder(package)

		self._tempPackageConfig = package

		if temp then
			return
		end

		local clientPackage = LuaUtil.deepCopyNoMeta(package)

		self:_clearPackageInfo(clientPackage)

		local allPackageInfo, allPackageBuildingInfo = self:_getAllInfo(clientPackage)
		local clientParam = self:_jsonEncode(clientPackage)

		if not SLFramework.FrameworkSettings.IsEditor then
			return
		end

		clientParam = self:_replaceInfoStr(clientParam, allPackageInfo, allPackageBuildingInfo)

		local pathClient = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.BlockPackageMapPath)

		SLFramework.FileHelper.WriteTextToPath(pathClient, clientParam)
		self:savePackageDataParam(package)
		self:assetDatabaseRefresh()
		logNormal("导出完成 记得提交前后端配置文件")
	end)
end

function RoomDebugController:_getAllInfo(clientPackage)
	local allPackageInfo = {}
	local allPackageBuildingInfo = {}

	for i, clientPackageMapItem in ipairs(clientPackage) do
		local infos = {}

		for j, info in ipairs(clientPackageMapItem.infos) do
			infos[j] = self:_jsonEncodeOrdered(info, {
				"defineId",
				"mainRes",
				"x",
				"y",
				"rotate",
				"blockId"
			})
		end

		allPackageInfo[i] = table.concat(infos, ",\n")

		local buildingInfos = {}

		if clientPackageMapItem.buildingInfos then
			for j, buildingInfo in ipairs(clientPackageMapItem.buildingInfos) do
				buildingInfos[j] = self:_jsonEncodeOrdered(buildingInfo, {
					"uid",
					"defineId",
					"use",
					"x",
					"y",
					"rotate",
					"resAreaDirection"
				})
			end
		end

		allPackageBuildingInfo[i] = table.concat(buildingInfos, ",\n")
	end

	return allPackageInfo, allPackageBuildingInfo
end

function RoomDebugController:_replaceInfoStr(clientParam, allPackageInfo, allPackageBuildingInfo)
	local result = clientParam

	if allPackageInfo then
		local i = 0

		result = result:gsub("\"infos\":%b[]", function()
			i = i + 1

			return "\"infos\":[" .. allPackageInfo[i] .. "]"
		end)
	end

	if allPackageBuildingInfo then
		local j = 0

		result = result:gsub("\"buildingInfos\":%b{}", "\"buildingInfos\":[]")
		result = result:gsub("\"buildingInfos\":%b[]", function()
			j = j + 1

			return "\"buildingInfos\":[" .. allPackageBuildingInfo[j] .. "]"
		end)
		result = result:gsub("\"buildingInfos\":%[%]", "\"buildingInfos\":{}")
	end

	return result
end

function RoomDebugController:_clearPackageInfo(package)
	for _, packageMapItem in ipairs(package) do
		for _, info in ipairs(packageMapItem.infos) do
			info.packageId = nil
			info.packageOrder = nil
		end

		table.sort(packageMapItem.infos, function(a, b)
			if a.blockId ~= b.blockId then
				return a.blockId < b.blockId
			end
		end)
	end

	table.sort(package, function(a, b)
		if a.packageMapId ~= b.packageMapId then
			return a.packageMapId < b.packageMapId
		end
	end)
end

function RoomDebugController:_refreshPackageOrder(package)
	local packageDict = {}

	for _, packageMap in ipairs(package) do
		for _, info in ipairs(packageMap.infos) do
			if info.packageId and info.packageId > 0 then
				packageDict[info.packageId] = packageDict[info.packageId] or {}
				packageDict[info.packageId][info.mainRes] = packageDict[info.packageId][info.mainRes] or {}

				table.insert(packageDict[info.packageId][info.mainRes], info)
			end
		end
	end

	for packageId, dict in pairs(packageDict) do
		for mainRes, infos in pairs(dict) do
			table.sort(infos, function(a, b)
				return a.packageOrder < b.packageOrder
			end)
		end
	end

	for packageId, dict in pairs(packageDict) do
		for mainRes, infos in pairs(dict) do
			for i, info in ipairs(infos) do
				info.packageOrder = i

				local blockMO = RoomMapBlockModel.instance:getFullBlockMOById(info.blockId)

				if blockMO then
					blockMO.packageOrder = info.packageOrder
				end
			end
		end
	end
end

function RoomDebugController:savePackageDataParam(package)
	local packageDatas = {}

	for _, packageMap in ipairs(package) do
		for _, info in ipairs(packageMap.infos) do
			if info.packageId and info.packageId ~= 0 then
				local packageData

				for _, packageDataItem in ipairs(packageDatas) do
					if packageDataItem.id == info.packageId then
						packageData = packageDataItem

						break
					end
				end

				if not packageData then
					packageData = {
						id = info.packageId,
						infos = {}
					}

					JsonUtil.markAsArray(packageData.infos)
					table.insert(packageDatas, packageData)
				end

				if info.mainRes and info.mainRes >= 0 then
					local var_84_0 = {
						blockId = info.blockId,
						defineId = info.defineId,
						mainRes = info.mainRes,
						packageOrder = info.packageOrder
					}

					var_84_0.ownType = _OWN_TYPE_MAP[info.packageId] or 0

					table.insert(packageData.infos, var_84_0)
				end
			end
		end
	end

	for _, packageData in ipairs(packageDatas) do
		table.sort(packageData.infos, function(x, y)
			if x.packageOrder ~= y.packageOrder then
				return x.packageOrder < y.packageOrder
			end

			return x.blockId < y.blockId
		end)

		for _, info in ipairs(packageData.infos) do
			info.packageOrder = nil
		end
	end

	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	JsonUtil.markAsArray(packageDatas)

	local serverParam = self:_jsonEncode(packageDatas)
	local clientParam = self:_wrapClientConfigParam(packageDatas, "block_package_data")
	local pathServer = System.IO.Path.Combine(UnityEngine.Application.dataPath, "../../../projm-server/projM-server-config/resources/T_block_package_data.json")
	local pathClient = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.BlockPackageDataPath)

	SLFramework.FileHelper.WriteTextToPath(pathServer, serverParam)
	SLFramework.FileHelper.WriteTextToPath(pathClient, clientParam)

	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType == SceneType.Room then
		local scene = GameSceneMgr.instance:getCurScene()
		local blockDefinePathServer = System.IO.Path.Combine(UnityEngine.Application.dataPath, "../../../projm-server/projM-server-config/resources/T_block.json")

		loadAbAsset(RoomEnum.BlockPath, false, function(assetItem)
			if assetItem.IsLoadSuccess then
				local textAsset = assetItem:GetResource(RoomEnum.BlockPath)
				local defineBlockList = cjson.decode(textAsset.text)[2]
				local serverBlockList = {}

				for k, info in ipairs(defineBlockList) do
					table.insert(serverBlockList, {
						defineId = info.defineId,
						resourceIds = info.resourceIds,
						category = info.category,
						prefabPath = info.prefabPath
					})
				end

				SLFramework.FileHelper.WriteTextToPath(blockDefinePathServer, self:_jsonEncode(serverBlockList))
			end
		end)
	end

	self:_saveBlockPrefabExcelData(packageDatas)
end

function RoomDebugController:_saveBlockPrefabExcelData(packageDatas)
	local datastr = "blockId resName packageId"

	for _, packageData in ipairs(packageDatas) do
		if _OWN_TYPE_MAP[packageData.id] and packageData.infos then
			for _, info in ipairs(packageData.infos) do
				local cfg = RoomConfig.instance:getBlockDefineConfig(info.defineId)

				if cfg then
					datastr = string.format("%s\n%s %s %s", datastr, info.blockId, RoomHelper.getBlockPrefabName(cfg.prefabPath), packageData.id)
				end
			end
		end
	end

	local pathClient = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, "../../roomTempData/blockPrefabPath.txt")

	SLFramework.FileHelper.WriteTextToPath(pathClient, datastr)
	logNormal("生成excel格式独立地块的id和资源名字的数据,导入excel方式：数据->从文本/CSV。\n文件路径：" .. pathClient)
end

function RoomDebugController:debugMoveAllMap(offsetX, offsetY)
	local scene = RoomCameraController.instance:getRoomScene()

	if not scene or not offsetX or not offsetY then
		return
	end

	RoomMapBuildingModel.instance:debugMoveAllBuilding(offsetX, offsetY)
	scene.buildingmgr:refreshAllBlockEntity()
	RoomMapBlockModel.instance:debugMoveAllBlock(offsetX, offsetY)
	scene.mapmgr:refreshAllBlockEntity(SceneTag.RoomMapBlock)
	scene.mapmgr:refreshAllBlockEntity(SceneTag.RoomEmptyBlock)
end

function RoomDebugController:assetDatabaseRefresh()
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	require("tolua.reflection")
	tolua.loadassembly("UnityEditor")

	local func = tolua.gettypemethod(typeof("UnityEditor.AssetDatabase"), "Refresh", System.Array.CreateInstance(typeof("System.Type"), 0))

	func:Call()
	func:Destroy()
end

function RoomDebugController:output(temp)
	if RoomController.instance:isDebugInitMode() then
		local debugParam = RoomModel.instance:getDebugParam()

		self:outputInitJson(temp)
	elseif RoomController.instance:isDebugPackageMode() then
		local debugParam = RoomModel.instance:getDebugParam()

		self:outputPackageJson(debugParam.packageMapId, temp)
	end
end

function RoomDebugController:outputFishing()
	local mapId = FishingEnum.Const.DefaultMapId
	local blockInfos = {}
	local fullBlockMOList = RoomMapBlockModel.instance:getFullBlockMOList()

	for i, blockMO in ipairs(fullBlockMOList) do
		if blockMO.blockState == RoomBlockEnum.BlockState.Map then
			local info = {
				mapId = mapId,
				fishingBlockId = blockMO.blockId,
				defineId = blockMO.defineId,
				mainRes = blockMO.mainRes,
				x = blockMO.hexPoint.x,
				y = blockMO.hexPoint.y,
				rotate = blockMO.rotate
			}
			local infoStr = self:_jsonEncodeOrdered(info, {
				"mapId",
				"fishingBlockId",
				"defineId",
				"mainRes",
				"x",
				"y",
				"rotate"
			})

			table.insert(blockInfos, infoStr)
		end
	end

	local allBlockInfoStr = table.concat(blockInfos, ",\n")
	local mapBlockContent = "[\"fishing_map_block\",[\n" .. allBlockInfoStr .. "\n]]"
	local pathClient = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.FishingMapBlockPath)

	SLFramework.FileHelper.WriteTextToPath(pathClient, mapBlockContent)

	local buildingInfos = {}
	local mapBuildingMOList = RoomMapBuildingModel.instance:getBuildingMOList()

	for i, buildingMO in ipairs(mapBuildingMOList) do
		if buildingMO.config and buildingMO.config.buildingType ~= RoomBuildingEnum.BuildingType.Fishing then
			local info = {
				use = true,
				mapId = mapId,
				uid = i,
				defineId = buildingMO.buildingId,
				x = buildingMO.hexPoint.x,
				y = buildingMO.hexPoint.y,
				rotate = buildingMO.rotate,
				resAreaDirection = buildingMO.resAreaDirection
			}
			local infoStr = self:_jsonEncodeOrdered(info, {
				"mapId",
				"uid",
				"defineId",
				"use",
				"x",
				"y",
				"rotate",
				"resAreaDirection"
			})

			table.insert(buildingInfos, infoStr)
		end
	end

	local allBuildingInfoStr = table.concat(buildingInfos, ",\n")
	local mapBuildingContent = "[\"fishing_map_building\",[\n" .. allBuildingInfoStr .. "\n]]"

	pathClient = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.FishingMapBuildingPath)

	SLFramework.FileHelper.WriteTextToPath(pathClient, mapBuildingContent)
	self:output()
end

function RoomDebugController:_wrapClientConfigParam(config, name)
	local wrap = {}

	JsonUtil.markAsArray(wrap)
	table.insert(wrap, name)
	table.insert(wrap, config)

	return self:_jsonEncode(wrap)
end

function RoomDebugController:_jsonEncode(obj)
	local str = JsonUtil.encode(obj)

	str = string.gsub(str, "},{", "},\n{")

	return str
end

function RoomDebugController:_jsonEncodeOrdered(obj, order)
	local parts = {}
	local orderKeyDict = {}

	for _, key in ipairs(order) do
		if obj[key] ~= nil then
			table.insert(parts, string.format("%q:%s", key, cjson.encode(obj[key])))
		end

		orderKeyDict[key] = true
	end

	for key, _ in pairs(obj) do
		if not orderKeyDict[key] then
			logError(string.format("RoomDebugController:_jsonEncodeOrdered error, no specific key order, key:%s", key))
		end
	end

	return "{" .. table.concat(parts, ",") .. "}"
end

RoomDebugController.instance = RoomDebugController.New()

return RoomDebugController
