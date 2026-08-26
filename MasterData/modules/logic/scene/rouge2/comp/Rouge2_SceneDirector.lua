-- chunkname: @modules/logic/scene/rouge2/comp/Rouge2_SceneDirector.lua

module("modules.logic.scene.rouge2.comp.Rouge2_SceneDirector", package.seeall)

local Rouge2_SceneDirector = class("Rouge2_SceneDirector", BaseSceneComp)

function Rouge2_SceneDirector:onInit()
	return
end

function Rouge2_SceneDirector:onSceneStart(sceneId, levelId)
	self._scene = self:getCurScene()

	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onLoadMapDone, self.onMapLoadDone, self)
end

function Rouge2_SceneDirector:onMapLoadDone()
	self._scene:onPrepared()
	Rouge2_StatController.instance:statStart()
end

function Rouge2_SceneDirector:onSceneClose()
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onLoadMapDone, self.onMapLoadDone, self)
end

return Rouge2_SceneDirector
