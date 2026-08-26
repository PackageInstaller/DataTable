-- chunkname: @modules/logic/scene/rouge2/comp/Rouge2_SceneMap.lua

module("modules.logic.scene.rouge2.comp.Rouge2_SceneMap", package.seeall)

local Rouge2_SceneMap = class("Rouge2_SceneMap", BaseSceneComp)

function Rouge2_SceneMap:onSceneStart(chapterId, layerId)
	Rouge2_MapModel.instance:setMapState(Rouge2_MapEnum.MapState.LoadingMap)
	self:loadMap()
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onBeforeChangeMapInfo, self.onBeforeChangeMapInfo, self)
end

function Rouge2_SceneMap:loadMap()
	if self.loader then
		if self.loader.isLoading then
			logError(string.format("exist loading rouge scene, res : %s", self.resPath))

			return
		end

		self:clearLoader()
	end

	local type = Rouge2_MapModel.instance:getMapType()

	self.resPath = Rouge2_MapHelper.getMapResPath(type)

	Rouge2_MapModel.instance:setLoadingMap(true)

	self.loader = MultiAbLoader.New()

	self.loader:addPath(self.resPath)
	Rouge2_MapHelper.addMapOtherRes(type, self.loader)
	self.loader:startLoad(self.onLoadCallback, self)
end

function Rouge2_SceneMap:onLoadCallback()
	self:destroyOldMapGo()

	local sceneGO = self:getCurScene():getSceneContainerGO()
	local assetItem = self.loader:getAssetItem(self.resPath)

	self.mapGo = assetItem and gohelper.clone(assetItem:GetResource(), sceneGO) or gohelper.create3d(sceneGO, "map")

	gohelper.setLayer(self.mapGo, UnityLayer.Scene, true)

	local type = Rouge2_MapModel.instance:getMapType()

	self.mapComp = Rouge2_MapHelper.createMapComp(type)

	self.mapComp:init(self.mapGo)
	self.mapComp:handleOtherRes(self.loader)
	Rouge2_MapModel.instance:setLoadingMap(false)
	logNormal(string.format("load scene success, res : %s", self.resPath))
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onLoadMapDone)
end

function Rouge2_SceneMap:onScenePrepared(chapterId, layerId)
	self.mapComp:createMap()
end

function Rouge2_SceneMap:getMapSceneGo()
	return self.mapGo
end

function Rouge2_SceneMap:getMapComp()
	return self.mapComp
end

function Rouge2_SceneMap:switchMap()
	self:loadMap()
end

function Rouge2_SceneMap:onChangeMapInfo(changeMapEnum)
	self:loadMap()
end

function Rouge2_SceneMap:onBeforeChangeMapInfo()
	self:destroyOldMap()
end

function Rouge2_SceneMap:clearLoader()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end
end

function Rouge2_SceneMap:destroyOldMap()
	if self.mapComp then
		self.mapComp:destroy()

		self.mapComp = nil
	end
end

function Rouge2_SceneMap:destroyOldMapGo()
	if self.mapGo then
		gohelper.destroy(self.mapGo)

		self.mapGo = nil
	end
end

function Rouge2_SceneMap:onSceneClose()
	Rouge2_MapModel.instance:setMapState(Rouge2_MapEnum.MapState.Empty)
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	self:clearLoader()
	self:destroyOldMap()
	self:destroyOldMapGo()
end

return Rouge2_SceneMap
