-- chunkname: @modules/logic/rouge/map/map/RougeBaseMap.lua

module("modules.logic.rouge.map.map.RougeBaseMap", package.seeall)

local RougeBaseMap = class("RougeBaseMap", UserDataDispose)

function RougeBaseMap:init(mapGo)
	self:__onInit()

	self._createDoneFinish = false
	self._openViewFinish = ViewMgr.instance:isOpenFinish(ViewName.RougeMapView)

	RougeMapTipPopController.instance:init()
	RougeMapVoiceTriggerController.instance:init()

	self.mapGo = mapGo

	self:initMap()
	self:createMapNodeContainer()
	RougeMapController.instance:registerMap(self)

	self.mapItemList = {}
	self.mapItemDict = {}

	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.triggerInteract, self.onTriggerInteract, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onCreateMapDone, self.onCreateMapDone, self)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self.onScreenSizeChanged, self)
end

function RougeBaseMap:onScreenSizeChanged()
	self:updateCameraSize()
end

function RougeBaseMap:updateCameraSize()
	local cameraSize = self:getCameraSize()

	RougeMapModel.instance:setCameraSize(cameraSize)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.focusChangeCameraSize)
end

function RougeBaseMap:getCameraSize()
	return RougeMapModel.instance:getCameraSize()
end

function RougeBaseMap:initMap()
	self.mapTransform = self.mapGo.transform

	local sizeGo = gohelper.findChild(self.mapGo, "root/size")
	local boxCollider = sizeGo:GetComponent(typeof(UnityEngine.BoxCollider))
	local mapSize = boxCollider.size

	RougeMapModel.instance:setMapSize(mapSize)
end

function RougeBaseMap:createMapNodeContainer()
	self.goLayerPiecesContainer = gohelper.create3d(self.mapGo, "layerPiecesContainer")
	self.trLayerPiecesContainer = self.goLayerPiecesContainer.transform

	transformhelper.setLocalPos(self.goLayerPiecesContainer.transform, 0, 0, RougeMapEnum.OffsetZ.PiecesContainer)
end

function RougeBaseMap:handleOtherRes(loader)
	return
end

function RougeBaseMap:handleDLCRes(loader, versions)
	return
end

function RougeBaseMap:createMap()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onCreateMapDone)
end

function RougeBaseMap:onCreateMapDone()
	self._createDoneFinish = true

	self:startCreateMapDoneFlow()
end

function RougeBaseMap:onOpenViewFinish(viewName)
	if viewName == ViewName.RougeMapView then
		self._openViewFinish = true

		self:startCreateMapDoneFlow()
	end
end

function RougeBaseMap:startCreateMapDoneFlow()
	if not self._createDoneFinish or not self._openViewFinish then
		return
	end

	RougeMapModel.instance:setMapState(RougeMapEnum.MapState.WaitFlow)

	self.onCreateMapDoneFlow = FlowSequence.New()

	self:addStoryFlow()
	self.onCreateMapDoneFlow:addWork(WaitPopViewDoneWork.New())
	self.onCreateMapDoneFlow:addWork(WaitRougeInteractDoneWork.New())
	self.onCreateMapDoneFlow:addWork(WaitRougeCollectionEffectDoneWork.New())
	self.onCreateMapDoneFlow:addWork(WaitRougeNodeChangeAnimDoneWork.New())
	self.onCreateMapDoneFlow:addWork(WaitRougeActorMoveToEndDoneWork.New())
	self.onCreateMapDoneFlow:registerDoneListener(self.onCreateMapDoneFlowDone, self)
	self.onCreateMapDoneFlow:start()
end

function RougeBaseMap:addStoryFlow()
	if not RougeMapModel.instance:isNormalLayer() then
		return
	end

	local layerCo = RougeMapModel.instance:getLayerCo()
	local storyId = layerCo.startStoryId

	if storyId == 0 then
		return
	end

	if StoryModel.instance:isStoryFinished(storyId) then
		return
	end

	self.onCreateMapDoneFlow:addWork(WaitRougeStoryDoneWork.New(storyId))
end

function RougeBaseMap:onCreateMapDoneFlowDone()
	self:clearFlow()
	RougeMapModel.instance:setMapState(RougeMapEnum.MapState.Normal)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onCreateMapDoneFlowDone)

	if RougeMapModel.instance:isNormalLayer() then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.OnGuideEnterNormalRougeMap)
	elseif RougeMapModel.instance:isMiddle() then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.OnGuideEnterMiddleRougeMap)
	end
end

function RougeBaseMap:onTriggerInteract()
	RougeMapInteractHelper.triggerInteractive()
end

function RougeBaseMap:getMapItemList()
	return self.mapItemList
end

function RougeBaseMap:addMapItem(mapItem)
	table.insert(self.mapItemList, mapItem)

	self.mapItemDict[mapItem.id] = mapItem
end

function RougeBaseMap:addMapItemList(mapItemList)
	if not mapItemList then
		return
	end

	for _, mapItem in ipairs(mapItemList) do
		self:addMapItem(mapItem)
	end
end

function RougeBaseMap:getMapItem(id)
	return self.mapItemDict[id]
end

function RougeBaseMap:getActorComp()
	return self.actorComp
end

function RougeBaseMap:getActorPos()
	return
end

function RougeBaseMap:clearFlow()
	if self.onCreateMapDoneFlow then
		self.onCreateMapDoneFlow:destroy()
	end

	self.onCreateMapDoneFlow = nil
end

function RougeBaseMap:destroy()
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self.onScreenSizeChanged, self)

	for _, mapItem in ipairs(self.mapItemList) do
		mapItem:destroy()
	end

	self.mapItemList = nil
	self.mapItemDict = nil

	if self.actorComp then
		self.actorComp:destroy()
	end

	self:clearFlow()
	RougeMapController.instance:unregisterMap()
	self:__onDispose()
end

return RougeBaseMap
