-- chunkname: @modules/logic/scene/rouge2/comp/Rouge2_SceneViewComp.lua

module("modules.logic.scene.rouge2.comp.Rouge2_SceneViewComp", package.seeall)

local Rouge2_SceneViewComp = class("Rouge2_SceneViewComp", BaseSceneComp)

function Rouge2_SceneViewComp:onScenePrepared(sceneId, levelId)
	if not ViewMgr.instance:isOpen(ViewName.Rouge2_MapView) then
		ViewMgr.instance:openView(ViewName.Rouge2_MapView)
	end

	ViewMgr.instance:openView(ViewName.Rouge2_MapTipView)
end

function Rouge2_SceneViewComp:onSceneClose(sceneId, levelId)
	ViewMgr.instance:closeAllPopupViews()
	ViewMgr.instance:closeView(ViewName.Rouge2_MapTipView)
end

return Rouge2_SceneViewComp
