-- chunkname: @modules/logic/scene/rouge/comp/RougeSceneMap.lua

module("modules.logic.scene.rouge.comp.RougeSceneMap", package.seeall)

local RougeSceneMap = class("RougeSceneMap", BaseSceneComp)

function RougeSceneMap:onSceneStart(chapterId, layerId)
	RougeMapModel.instance:setMapState(RougeMapEnum.MapState.LoadingMap)
	self:loadMap()
	RougeMapController.instance:registerCallback(RougeMapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	RougeMapController.instance:registerCallback(RougeMapEvent.onBeforeChangeMapInfo, self.onBeforeChangeMapInfo, self)
end

function RougeSceneMap:loadMap()
	if self.loader then
		if self.loader.isLoading then
			logError(string.format("exist loading rouge scene, res : %s", self.resPath))

			return
		end

		self:clearLoader()
	end

	local type = RougeMapModel.instance:getMapType()

	self.resPath = RougeMapHelper.getMapResPath(type)

	RougeMapModel.instance:setLoadingMap(true)

	self.loader = MultiAbLoader.New()

	self.loader:addPath(self.resPath)
	RougeMapHelper.addMapOtherRes(type, self.loader)

	self.versions = RougeModel.instance:getVersion()

	RougeMapDLCResHelper.addMapDLCRes(type, self.versions, self.loader)
	self.loader:startLoad(self.onLoadCallback, self)
end

function RougeSceneMap:onLoadCallback()
	self:destroyOldMapGo()

	local sceneGO = self:getCurScene():getSceneContainerGO()
	local assetItem = self.loader:getAssetItem(self.resPath)

	self.mapGo = gohelper.clone(assetItem:GetResource(), sceneGO)

	gohelper.setLayer(self.mapGo, UnityLayer.Scene, true)

	local type = RougeMapModel.instance:getMapType()

	self.mapComp = RougeMapHelper.createMapComp(type)

	self.mapComp:init(self.mapGo)
	self.mapComp:handleOtherRes(self.loader)
	self.mapComp:handleDLCRes(self.loader, self.versions)
	RougeMapModel.instance:setLoadingMap(false)
	logNormal(string.format("load scene success, res : %s", self.resPath))
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onLoadMapDone)
end

function RougeSceneMap:onScenePrepared(chapterId, layerId)
	self.mapComp:createMap()
end

function RougeSceneMap:getMapSceneGo()
	return self.mapGo
end

function RougeSceneMap:switchMap()
	self:loadMap()
end

function RougeSceneMap:onChangeMapInfo(changeMapEnum)
	self:loadMap()
end

function RougeSceneMap:onBeforeChangeMapInfo()
	self:destroyOldMap()
end

function RougeSceneMap:clearLoader()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end
end

function RougeSceneMap:destroyOldMap()
	if self.mapComp then
		self.mapComp:destroy()

		self.mapComp = nil
	end
end

function RougeSceneMap:destroyOldMapGo()
	if self.mapGo then
		gohelper.destroy(self.mapGo)

		self.mapGo = nil
	end
end

function RougeSceneMap:onSceneClose()
	RougeMapModel.instance:setMapState(RougeMapEnum.MapState.Empty)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	self:clearLoader()
	self:destroyOldMap()
	self:destroyOldMapGo()
end

return RougeSceneMap
