-- chunkname: @modules/logic/scene/rouge/RougeScene.lua

module("modules.logic.scene.rouge.RougeScene", package.seeall)

local RougeScene = class("RougeScene", BaseScene)

function RougeScene:_createAllComps()
	self:_addComp("camera", RougeSceneCameraComp)
	self:_addComp("director", RougeSceneDirector)
	self:_addComp("model", RougeSceneModel)
	self:_addComp("map", RougeSceneMap)
	self:_addComp("view", RougeSceneViewComp)
	self:_addComp("bgm", RougeSceneBgmComp)
end

return RougeScene
