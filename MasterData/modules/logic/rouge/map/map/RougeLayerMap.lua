-- chunkname: @modules/logic/rouge/map/map/RougeLayerMap.lua

module("modules.logic.rouge.map.map.RougeLayerMap", package.seeall)

local RougeLayerMap = class("RougeLayerMap", RougeBaseMap)

function RougeLayerMap:initMap()
	RougeLayerMap.super.initMap(self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onMapPosChange, self.setMapPos, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onNodeEventStatusChange, self.onNodeEventStatusChange, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onFocusNormalLayerActor, self.focusActor, self)

	local cameraSize = self:getCameraSize()

	RougeMapModel.instance:setCameraSize(cameraSize)
	self:updateMapXRange()
	RougeMapModel.instance:setMapPosX(RougeMapModel.instance.maxX)
	self:setMapPos(RougeMapModel.instance:getMapPosX())
end

function RougeLayerMap:updateMapXRange()
	local cameraSize = RougeMapModel.instance:getCameraSize()
	local popTop = RougeMapHelper.getUIRoot()
	local worldcorners = popTop.transform:GetWorldCorners()
	local uiCamera = CameraMgr.instance:getUICamera()
	local uiCameraSize = uiCamera.orthographicSize
	local cameraSizeRate = cameraSize / uiCameraSize
	local posTL = worldcorners[1]
	local posBR = worldcorners[3]
	local viewWidth = (posBR.x - posTL.x) * cameraSizeRate
	local mapSize = RougeMapModel.instance:getMapSize()
	local mapWidth = mapSize.x
	local mapMaxX = -viewWidth / 2 - RougeMapModel.instance:getMapStartOffsetX() + RougeMapEnum.MapStartOffsetX
	local mapMinX

	RougeMapModel.instance:setMapXRange(mapWidth <= viewWidth and mapMaxX or mapMaxX - (mapWidth - viewWidth), mapMaxX)
end

function RougeLayerMap:getCameraSize()
	return RougeMapHelper.getNormalLayerCameraSize()
end

function RougeLayerMap:onScreenSizeChanged()
	RougeLayerMap.super.onScreenSizeChanged(self)

	local curMapPosX = RougeMapModel.instance:getMapPosX()

	self:updateMapXRange()
	RougeMapModel.instance:setMapPosX(curMapPosX)
end

function RougeLayerMap:createMapNodeContainer()
	self.goLayerNodeContainer = gohelper.create3d(self.mapGo, "layerNodeContainer")
	self.goLayerLinePathContainer = gohelper.create3d(self.mapGo, "layerLinePathContainer")

	transformhelper.setLocalPos(self.goLayerNodeContainer.transform, 0, 0, RougeMapEnum.OffsetZ.NodeContainer)
	transformhelper.setLocalPos(self.goLayerLinePathContainer.transform, 0, 0, RougeMapEnum.OffsetZ.PathContainer)

	self.goLayerPiecesContainer = gohelper.findChild(self.mapGo, "layerPiecesContainer")
	self.trLayerPiecesContainer = self.goLayerPiecesContainer.transform

	transformhelper.setLocalPos(self.goLayerPiecesContainer.transform, 0, 0, RougeMapEnum.OffsetZ.PiecesContainer)
end

function RougeLayerMap:handleOtherRes(loader)
	self.linePrefab = loader:getAssetItem(RougeMapEnum.LinePrefabRes):GetResource()
	self.lineIconDict = self:getUserDataTb_()

	for lineIcon, res in pairs(RougeMapEnum.LineIconRes) do
		self.lineIconDict[lineIcon] = loader:getAssetItem(res):GetResource()
	end

	self.iconPrefabDict = self:getUserDataTb_()

	for _, type in pairs(RougeMapEnum.EventType) do
		local name = RougeMapEnum.IconPath[type]

		if not string.nilorempty(name) then
			local path = RougeMapHelper.getScenePath(name)

			self.iconPrefabDict[type] = loader:getAssetItem(path):GetResource()
		end
	end

	self.nodeBgPrefabDict = {}

	for status, resDict in pairs(RougeMapEnum.NodeBgPath) do
		local dict = self:getUserDataTb_()

		self.nodeBgPrefabDict[status] = dict

		for arrive, name in pairs(resDict) do
			local path = RougeMapHelper.getScenePath(name)

			dict[arrive] = loader:getAssetItem(path):GetResource()
		end
	end

	self.startBgPrefab = loader:getAssetItem(RougeMapHelper.getScenePath(RougeMapEnum.StartNodeBgPath)):GetResource()
end

function RougeLayerMap:handleDLCRes(loader, versions)
	if not versions then
		return
	end

	for _, version in ipairs(versions) do
		RougeMapDLCResHelper.handleLoadMapDLCRes(version, loader, self)
	end
end

function RougeLayerMap:createMap()
	local episodeMoList = RougeMapModel.instance:getEpisodeList()

	self.episodeItemList = {}
	self.lineItemList = {}

	for index, episodeMo in ipairs(episodeMoList) do
		local episodeItem = RougeMapEpisodeItem.New()

		episodeItem:init(episodeMo, self)
		table.insert(self.episodeItemList, episodeItem)
		self:addMapItemList(episodeItem:getNodeItemList())
		self:createLinePath(index)
	end

	self.goActor = gohelper.findChild(self.mapGo, "layerPiecesContainer/actor")
	self.actorComp = RougeMapNormalLayerActorComp.New()

	self.actorComp:init(self.goActor, self)
	self:createDLCMap()
	RougeLayerMap.super.createMap(self)
end

function RougeLayerMap:createDLCMap()
	local versions = RougeModel.instance:getVersion()

	for _, version in ipairs(versions) do
		RougeMapDLCResHelper.handleCreateMapDLC(version, self)
	end
end

function RougeLayerMap:getNodeBgPrefab(eventCo, arriveStatus)
	local isSpecial = eventCo and eventCo.specialUI == 1
	local prefabDict

	return (isSpecial and self.nodeBgPrefabDict.Special or self.nodeBgPrefabDict.Normal)[arriveStatus]
end

function RougeLayerMap:getNodeIconPrefab(eventCo)
	local prefab = self.iconPrefabDict[eventCo.type]

	if not prefab then
		logError(string.format("not icon prefab, eventCo.id : %s, type : %s", eventCo.id, eventCo.type))

		return self.iconPrefabDict[RougeMapEnum.EventType.NormalFight]
	end

	return self.iconPrefabDict[eventCo.type]
end

function RougeLayerMap:createLinePath(episodeIndex)
	if episodeIndex == 1 then
		return
	end

	local episodeItem = self.episodeItemList[episodeIndex]
	local episodeMo = episodeItem.episodeMo

	for _, curNodeMo in ipairs(episodeMo:getNodeMoList()) do
		local nodeId = curNodeMo.nodeId

		for _, preNodeId in ipairs(curNodeMo.preNodeList) do
			local nodeMo = RougeMapModel.instance:getNode(preNodeId)
			local nodeItem = self:getMapItem(nodeId)

			nodeItem.lineItem = self:createLineItem(curNodeMo, nodeMo)
		end
	end
end

function RougeLayerMap:createLineItem(curNodeMo, preNodeMo)
	local lineItem = RougeMapLineItem.New()
	local go = gohelper.clone(self.linePrefab, self.goLayerLinePathContainer)

	lineItem:init(go, self)
	lineItem:drawLine(curNodeMo, preNodeMo)
	table.insert(self.lineItemList, lineItem)

	return lineItem
end

function RougeLayerMap:setMapPos(posX)
	local mapSize = RougeMapModel.instance:getMapSize()

	transformhelper.setLocalPos(self.mapTransform, posX, mapSize.y / 2, RougeMapEnum.OffsetZ.Map)
end

function RougeLayerMap:onNodeEventStatusChange(eventId, state)
	if state == RougeMapEnum.EventState.Finish then
		self:focusActor()
	end
end

function RougeLayerMap:focusActor()
	local screenPosX = RougeMapModel.instance:getFocusScreenPosX()
	local actorWorldPos = self.actorComp:getActorWordPos()
	local worldPoxX = recthelper.screenPosToWorldPos3(Vector2(screenPosX, 0), nil, actorWorldPos)
	local offsetX = actorWorldPos.x - worldPoxX
	local curMapPosX = RougeMapModel.instance:getMapPosX()

	curMapPosX = curMapPosX - offsetX

	RougeMapModel.instance:setMapPosX(curMapPosX)
end

function RougeLayerMap:getActorPos()
	local curNodeMo = RougeMapModel.instance:getCurNode()
	local mapItem = self:getMapItem(curNodeMo.nodeId)

	return mapItem:getActorPos()
end

function RougeLayerMap:destroy()
	for _, lineItem in ipairs(self.lineItemList) do
		lineItem:destroy()
	end

	for _, episodeItem in ipairs(self.episodeItemList) do
		episodeItem:destroy()
	end

	RougeLayerMap.super.destroy(self)
end

return RougeLayerMap
