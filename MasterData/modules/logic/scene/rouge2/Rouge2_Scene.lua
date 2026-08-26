-- chunkname: @modules/logic/scene/rouge2/Rouge2_Scene.lua

module("modules.logic.scene.rouge2.Rouge2_Scene", package.seeall)

local Rouge2_Scene = class("Rouge2_Scene", BaseScene)

function Rouge2_Scene:_createAllComps()
	self:_addComp("camera", Rouge2_SceneCameraComp)
	self:_addComp("director", Rouge2_SceneDirector)
	self:_addComp("model", Rouge2_SceneModel)
	self:_addComp("map", Rouge2_SceneMap)
	self:_addComp("view", Rouge2_SceneViewComp)
	self:_addComp("bgm", Rouge2_SceneBgmComp)
end

return Rouge2_Scene
