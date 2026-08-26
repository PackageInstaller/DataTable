-- chunkname: @modules/logic/scene/pushbox/comp/PushBoxSceneViewComp.lua

module("modules.logic.scene.pushbox.comp.PushBoxSceneViewComp", package.seeall)

local PushBoxSceneViewComp = class("PushBoxSceneViewComp", BaseSceneComp)

function PushBoxSceneViewComp:onScenePrepared(sceneId, levelId)
	ViewMgr.instance:openView(ViewName.VersionActivityPushBoxLevelView)
end

function PushBoxSceneViewComp:onSceneClose(sceneId, levelId)
	ViewMgr.instance:closeView(ViewName.PushBoxView)
end

return PushBoxSceneViewComp
