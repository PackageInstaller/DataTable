-- chunkname: @modules/logic/rouge2/map/map/Rouge2_BaseMap.lua

module("modules.logic.rouge2.map.map.Rouge2_BaseMap", package.seeall)

local Rouge2_BaseMap = class("Rouge2_BaseMap", UserDataDispose)

function Rouge2_BaseMap:init(mapGo)
	self:__onInit()

	self._createDoneFinish = false
	self._openViewFinish = ViewMgr.instance:isOpenFinish(ViewName.Rouge2_MapView)

	Rouge2_MapTipPopController.instance:init()
	Rouge2_MapVoiceTriggerController.instance:init()

	self.mapGo = mapGo

	self:initMap()
	self:createMapNodeContainer()
	Rouge2_MapController.instance:registerMap(self)

	self.mapItemList = {}
	self.mapItemDict = {}

	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.triggerInteract, self.onTriggerInteract, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onCreateMapDone, self.onCreateMapDone, self)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self.onScreenSizeChanged, self)
end

function Rouge2_BaseMap:onScreenSizeChanged()
	self:updateCameraSize()
end

function Rouge2_BaseMap:updateCameraSize()
	local cameraSize = self:getCameraSize()

	Rouge2_MapModel.instance:setCameraSize(cameraSize)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.focusChangeCameraSize)
end

function Rouge2_BaseMap:getCameraSize()
	return Rouge2_MapModel.instance:getCameraSize()
end

function Rouge2_BaseMap:initMap()
	self.mapTransform = self.mapGo.transform

	local sizeGo = gohelper.findChild(self.mapGo, "root/size")
	local boxCollider = sizeGo:GetComponent(typeof(UnityEngine.BoxCollider))
	local mapSize = boxCollider.size

	Rouge2_MapModel.instance:setMapSize(mapSize)
end

function Rouge2_BaseMap:createMapNodeContainer()
	self.goLayerPiecesContainer = gohelper.create3d(self.mapGo, "layerPiecesContainer")
	self.trLayerPiecesContainer = self.goLayerPiecesContainer.transform

	transformhelper.setLocalPos(self.goLayerPiecesContainer.transform, 0, 0, Rouge2_MapEnum.OffsetZ.PiecesContainer)
end

function Rouge2_BaseMap:handleOtherRes(loader)
	return
end

function Rouge2_BaseMap:createMap()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onCreateMapDone)
end

function Rouge2_BaseMap:onCreateMapDone()
	self._createDoneFinish = true

	self:startCreateMapDoneFlow()
end

function Rouge2_BaseMap:onOpenViewFinish(viewName)
	if viewName == ViewName.Rouge2_MapView then
		self._openViewFinish = true

		self:startCreateMapDoneFlow()
	end
end

function Rouge2_BaseMap:startCreateMapDoneFlow()
	if not self._createDoneFinish or not self._openViewFinish then
		return
	end

	Rouge2_MapModel.instance:setMapState(Rouge2_MapEnum.MapState.WaitFlow)

	self.onCreateMapDoneFlow = FlowSequence.New()

	self:addStoryFlow()
	self.onCreateMapDoneFlow:addWork(Rouge2_WaitRechangleDoneWork.New())
	self.onCreateMapDoneFlow:addWork(Rouge2_WaitTriggerEndingWork.New())
	self.onCreateMapDoneFlow:addWork(Rouge2_WaitPopViewDoneWork.New())
	self.onCreateMapDoneFlow:addWork(Rouge2_WaitTriggerAttrCheckDoneWork.New())
	self.onCreateMapDoneFlow:addWork(Rouge2_WaitRougeInteractDoneWork.New())
	self.onCreateMapDoneFlow:addWork(Rouge2_WaitGetAttrDropRewardWork.New())
	self.onCreateMapDoneFlow:addWork(Rouge2_WaitRougeNodeChangeAnimDoneWork.New())
	self.onCreateMapDoneFlow:addWork(Rouge2_WaitRougeActorMoveToEndDoneWork.New())
	self.onCreateMapDoneFlow:registerDoneListener(self.onCreateMapDoneFlowDone, self)
	self.onCreateMapDoneFlow:start()
end

function Rouge2_BaseMap:addStoryFlow()
	if not Rouge2_MapModel.instance:isNormalLayer() then
		return
	end

	local layerCo = Rouge2_MapModel.instance:getLayerCo()
	local storyId = layerCo.startStoryId

	if storyId == 0 then
		return
	end

	if StoryModel.instance:isStoryFinished(storyId) then
		return
	end

	self.onCreateMapDoneFlow:addWork(Rouge2_WaitRougeStoryDoneWork.New(storyId))
end

function Rouge2_BaseMap:onCreateMapDoneFlowDone()
	self:clearFlow()
	Rouge2_MapModel.instance:setMapState(Rouge2_MapEnum.MapState.Normal)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onCreateMapDoneFlowDone)

	if Rouge2_MapModel.instance:isNormalLayer() then
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnGuideEnterNormalRougeMap)
	elseif Rouge2_MapModel.instance:isMiddle() then
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnGuideEnterMiddleRougeMap)
	end
end

function Rouge2_BaseMap:onTriggerInteract()
	Rouge2_MapInteractHelper.triggerInteractive()
end

function Rouge2_BaseMap:getMapItemList()
	return self.mapItemList
end

function Rouge2_BaseMap:addMapItem(mapItem)
	table.insert(self.mapItemList, mapItem)

	self.mapItemDict[mapItem.id] = mapItem
end

function Rouge2_BaseMap:addMapItemList(mapItemList)
	if not mapItemList then
		return
	end

	for _, mapItem in ipairs(mapItemList) do
		self:addMapItem(mapItem)
	end
end

function Rouge2_BaseMap:getMapItem(id)
	return self.mapItemDict[id]
end

function Rouge2_BaseMap:getActorComp()
	return self.actorComp
end

function Rouge2_BaseMap:getActorPos()
	return
end

function Rouge2_BaseMap:clearFlow()
	if self.onCreateMapDoneFlow then
		self.onCreateMapDoneFlow:destroy()
	end

	self.onCreateMapDoneFlow = nil
end

function Rouge2_BaseMap:destroy()
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
	Rouge2_MapController.instance:unregisterMap()
	self:__onDispose()
end

return Rouge2_BaseMap
