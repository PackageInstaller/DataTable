-- chunkname: @modules/logic/scene/udimo/scenecomp/UdimoSceneViewComp.lua

module("modules.logic.scene.udimo.scenecomp.UdimoSceneViewComp", package.seeall)

local UdimoSceneViewComp = class("UdimoSceneViewComp", BaseSceneComp)

function UdimoSceneViewComp:onInit()
	return
end

function UdimoSceneViewComp:onSceneStart(sceneId, levelId)
	return
end

function UdimoSceneViewComp:onScenePrepared(sceneId, levelId)
	return
end

function UdimoSceneViewComp:init(sceneId, levelId)
	UdimoController.instance:openMainView()
end

function UdimoSceneViewComp:onSceneClose()
	ViewMgr.instance:closeView(ViewName.UdimoMainView)
end

return UdimoSceneViewComp
