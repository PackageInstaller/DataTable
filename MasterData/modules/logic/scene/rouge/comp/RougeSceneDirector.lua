-- chunkname: @modules/logic/scene/rouge/comp/RougeSceneDirector.lua

module("modules.logic.scene.rouge.comp.RougeSceneDirector", package.seeall)

local RougeSceneDirector = class("RougeSceneDirector", BaseSceneComp)

function RougeSceneDirector:onInit()
	return
end

function RougeSceneDirector:onSceneStart(sceneId, levelId)
	self._scene = self:getCurScene()

	RougeMapController.instance:registerCallback(RougeMapEvent.onLoadMapDone, self.onMapLoadDone, self)
end

function RougeSceneDirector:onMapLoadDone()
	self._scene:onPrepared()
end

function RougeSceneDirector:onSceneClose()
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onLoadMapDone, self.onMapLoadDone, self)
end

return RougeSceneDirector
