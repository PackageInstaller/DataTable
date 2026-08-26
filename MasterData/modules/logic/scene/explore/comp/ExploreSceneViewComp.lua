-- chunkname: @modules/logic/scene/explore/comp/ExploreSceneViewComp.lua

module("modules.logic.scene.explore.comp.ExploreSceneViewComp", package.seeall)

local ExploreSceneViewComp = class("ExploreSceneViewComp", BaseSceneComp)

function ExploreSceneViewComp:onScenePrepared(sceneId, levelId)
	ViewMgr.instance:openView(ViewName.ExploreView)

	local popLayer = ViewMgr.instance:getUILayer(UILayerName.PopUpTop)

	self._uiRoot = gohelper.create2d(popLayer, "ExploreUnitUI")
end

function ExploreSceneViewComp:getRoot()
	return self._uiRoot
end

function ExploreSceneViewComp:setActive(isActive)
	gohelper.setActive(self._uiRoot, isActive)
end

function ExploreSceneViewComp:onSceneClose(sceneId, levelId)
	ViewMgr.instance:closeView(ViewName.ExploreView)
	gohelper.destroy(self._uiRoot)

	self._uiRoot = nil
end

return ExploreSceneViewComp
