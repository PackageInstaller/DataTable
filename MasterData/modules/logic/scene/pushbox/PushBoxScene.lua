-- chunkname: @modules/logic/scene/pushbox/PushBoxScene.lua

module("modules.logic.scene.pushbox.PushBoxScene", package.seeall)

local PushBoxScene = class("PushBoxScene", BaseScene)

function PushBoxScene:_createAllComps()
	self:_addComp("director", PushBoxSceneDirector)
	self:_addComp("preloader", PushBoxScenePreloader)
	self:_addComp("camera", PushBoxSceneCameraComp)
	self:_addComp("gameMgr", PushBoxGameMgr)
	self:_addComp("view", PushBoxSceneViewComp)
end

return PushBoxScene
