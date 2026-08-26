-- chunkname: @modules/logic/rouge2/map/map/Rouge2_LayerMap.lua

module("modules.logic.rouge2.map.map.Rouge2_LayerMap", package.seeall)

local Rouge2_LayerMap = class("Rouge2_LayerMap", Rouge2_BaseMap)

function Rouge2_LayerMap:initMap()
	Rouge2_LayerMap.super.initMap(self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onMapPosChange, self.setMapPos, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onNodeEventStatusChange, self.onNodeEventStatusChange, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onFocusNormalLayerActor, self.focusActor, self)

	local cameraSize = self:getCameraSize()

	Rouge2_MapModel.instance:setCameraSize(cameraSize)
	self:updateMapXRange()
	Rouge2_MapModel.instance:setMapPosX(Rouge2_MapModel.instance.maxX)
	self:setMapPos(Rouge2_MapModel.instance:getMapPosX())
end

function Rouge2_LayerMap:updateMapXRange()
	local cameraSize = Rouge2_MapModel.instance:getCameraSize()
	local popTop = Rouge2_MapHelper.getUIRoot()
	local worldcorners = popTop.transform:GetWorldCorners()
	local uiCamera = CameraMgr.instance:getUICamera()
	local uiCameraSize = uiCamera.orthographicSize
	local cameraSizeRate = cameraSize / uiCameraSize
	local posTL = worldcorners[1]
	local posBR = worldcorners[3]
	local viewWidth = (posBR.x - posTL.x) * cameraSizeRate
	local mapSize = Rouge2_MapModel.instance:getMapSize()
	local mapWidth = mapSize.x
	local mapMaxX = -viewWidth / 2
	local mapMinX

	Rouge2_MapModel.instance:setMapXRange(mapWidth <= viewWidth and mapMaxX or mapMaxX - (mapWidth - viewWidth), mapMaxX)
end

function Rouge2_LayerMap:getCameraSize()
	return Rouge2_MapHelper.getNormalLayerCameraSize()
end

function Rouge2_LayerMap:onScreenSizeChanged()
	Rouge2_LayerMap.super.onScreenSizeChanged(self)

	local curMapPosX = Rouge2_MapModel.instance:getMapPosX()

	self:updateMapXRange()
	Rouge2_MapModel.instance:setMapPosX(curMapPosX)
end

function Rouge2_LayerMap:createMapNodeContainer()
	self.goLayerNodeContainer = gohelper.create3d(self.mapGo, "layerNodeContainer")
	self.goLayerLinePathContainer = gohelper.create3d(self.mapGo, "layerLinePathContainer")
	self.goLayerIconContainer = gohelper.create3d(self.mapGo, "layerIconContainer")

	transformhelper.setLocalPos(self.goLayerNodeContainer.transform, 0, 0, Rouge2_MapEnum.OffsetZ.NodeContainer)
	transformhelper.setLocalPos(self.goLayerLinePathContainer.transform, 0, 0, Rouge2_MapEnum.OffsetZ.PathContainer)
	transformhelper.setLocalPos(self.goLayerIconContainer.transform, 0, 0, Rouge2_MapEnum.OffsetZ.NodeContainer)

	self.goLayerPiecesContainer = gohelper.create3d(self.mapGo, "layerPiecesContainer")
	self.trLayerPiecesContainer = self.goLayerPiecesContainer.transform

	transformhelper.setLocalPos(self.goLayerPiecesContainer.transform, 0, 0, RougeMapEnum.OffsetZ.PiecesContainer)
end

function Rouge2_LayerMap:handleOtherRes(loader)
	self.linePrefab = loader:getAssetItem(Rouge2_MapEnum.LinePrefabRes):GetResource()
	self.iconCanvasPrefab = loader:getAssetItem(Rouge2_MapEnum.LayerNodeIconCanvas):GetResource()
end

function Rouge2_LayerMap:createMap()
	self:createIconCanvas()

	local episodeMoList = Rouge2_MapModel.instance:getEpisodeList()

	self.episodeItemList = {}
	self.lineItemList = {}

	for index, episodeMo in ipairs(episodeMoList) do
		local episodeItem = Rouge2_MapEpisodeItem.New()

		episodeItem:init(episodeMo, self)
		table.insert(self.episodeItemList, episodeItem)
		self:addMapItemList(episodeItem:getNodeItemList())
		self:createLinePath(index)
	end

	self.goActor = gohelper.findChild(self.mapGo, "role")

	gohelper.addChild(self.goLayerPiecesContainer, self.goActor)

	self.actorComp = Rouge2_MapNormalLayerActorComp.New()

	self.actorComp:init(self.goActor, self)
	Rouge2_StatController.instance:statEnterLayerMap()
	Rouge2_LayerMap.super.createMap(self)
end

function Rouge2_LayerMap:createIconCanvas()
	local goNodeIconCanvas = gohelper.clone(self.iconCanvasPrefab, self.goLayerIconContainer, "nodeIconCanvas")

	self.nodeIconCanvas = MonoHelper.addNoUpdateLuaComOnceToGo(goNodeIconCanvas, Rouge2_LayerMapNodeIconCanvas)
end

function Rouge2_LayerMap:createLinePath(episodeIndex)
	if episodeIndex == 1 then
		return
	end

	local episodeItem = self.episodeItemList[episodeIndex]
	local episodeMo = episodeItem.episodeMo

	for _, curNodeMo in ipairs(episodeMo:getNodeMoList()) do
		local nodeId = curNodeMo.nodeId

		for _, preNodeId in ipairs(curNodeMo.preNodeList) do
			local nodeMo = Rouge2_MapModel.instance:getNode(preNodeId)
			local nodeItem = self:getMapItem(nodeId)

			nodeItem.lineItem = self:createLineItem(curNodeMo, nodeMo)
		end
	end
end

function Rouge2_LayerMap:createLineItem(curNodeMo, preNodeMo)
	local lineItem = Rouge2_MapLineItem.New()
	local go = gohelper.clone(self.linePrefab, self.goLayerLinePathContainer)

	lineItem:init(go, self)
	lineItem:drawLine(curNodeMo, preNodeMo)
	table.insert(self.lineItemList, lineItem)

	return lineItem
end

function Rouge2_LayerMap:setMapPos(posX)
	local mapSize = Rouge2_MapModel.instance:getMapSize()

	transformhelper.setLocalPos(self.mapTransform, posX, mapSize.y / 2, Rouge2_MapEnum.OffsetZ.Map)
end

function Rouge2_LayerMap:onNodeEventStatusChange(eventId, state)
	if state == Rouge2_MapEnum.EventState.Finish then
		self:focusActor()
	end
end

function Rouge2_LayerMap:focusActor()
	local screenPosX = Rouge2_MapModel.instance:getFocusScreenPosX()
	local actorWorldPos = self.actorComp:getActorWordPos()
	local worldPoxX = recthelper.screenPosToWorldPos3(Vector2(screenPosX, 0), nil, actorWorldPos)
	local offsetX = actorWorldPos.x - worldPoxX
	local curMapPosX = Rouge2_MapModel.instance:getMapPosX()

	curMapPosX = curMapPosX - offsetX

	Rouge2_MapModel.instance:setMapPosX(curMapPosX)
end

function Rouge2_LayerMap:getActorPos()
	local curNodeMo = Rouge2_MapModel.instance:getCurNode()
	local mapItem = self:getMapItem(curNodeMo.nodeId)

	return mapItem:getActorPos()
end

function Rouge2_LayerMap:destroy()
	for _, lineItem in ipairs(self.lineItemList) do
		lineItem:destroy()
	end

	for _, episodeItem in ipairs(self.episodeItemList) do
		episodeItem:destroy()
	end

	Rouge2_LayerMap.super.destroy(self)
end

return Rouge2_LayerMap
