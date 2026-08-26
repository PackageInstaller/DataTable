-- chunkname: @modules/logic/scene/explore/comp/ExploreSceneMap.lua

module("modules.logic.scene.explore.comp.ExploreSceneMap", package.seeall)

local ExploreSceneMap = class("ExploreSceneMap", BaseSceneComp)

function ExploreSceneMap:onInit()
	self._scene = self:getCurScene()
end

function ExploreSceneMap:init(sceneId, levelId)
	return
end

function ExploreSceneMap:onSceneStart(sceneId, levelId)
	self._scene.level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
end

function ExploreSceneMap:_onLevelLoaded(sceneId, levelId)
	ExploreController.instance:registerCallback(ExploreEvent.InitMapDone, self.initMapDone, self)

	self._comps = {}

	for typeName, type in pairs(ExploreEnum.MapCompType) do
		local clsName = "ExploreMap"

		if typeName ~= "Map" then
			clsName = clsName .. typeName
		end

		self._comps[type] = _G[clsName].New()

		ExploreController.instance:registerMapComp(type, self._comps[type])
	end

	for type, comp in pairs(self._comps) do
		if comp.loadMap then
			comp:loadMap()
		end
	end
end

function ExploreSceneMap:initMapDone()
	ExploreController.instance:unregisterCallback(ExploreEvent.InitMapDone, self.initMapDone, self)
	self:dispatchEvent(ExploreEvent.InitMapDone)
end

function ExploreSceneMap:onSceneClose(sceneId, levelId)
	self._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.InitMapDone, self.initMapDone, self)

	for type, comp in pairs(self._comps) do
		if comp.unloadMap then
			comp:unloadMap()
		end
	end

	ExploreStepController.instance:clear()

	for type in pairs(self._comps) do
		ExploreController.instance:unRegisterMapComp(type)
	end

	self._comps = {}
end

return ExploreSceneMap
