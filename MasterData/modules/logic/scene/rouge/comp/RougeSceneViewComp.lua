-- chunkname: @modules/logic/scene/rouge/comp/RougeSceneViewComp.lua

module("modules.logic.scene.rouge.comp.RougeSceneViewComp", package.seeall)

local RougeSceneViewComp = class("RougeSceneViewComp", BaseSceneComp)

function RougeSceneViewComp:onScenePrepared(sceneId, levelId)
	if not ViewMgr.instance:isOpen(ViewName.RougeMapView) then
		ViewMgr.instance:openView(ViewName.RougeMapView)
	end

	ViewMgr.instance:openView(ViewName.RougeMapTipView)
end

function RougeSceneViewComp:onSceneClose(sceneId, levelId)
	ViewMgr.instance:closeAllPopupViews()
	ViewMgr.instance:closeView(ViewName.RougeMapTipView)
end

return RougeSceneViewComp
