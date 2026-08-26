-- chunkname: @modules/logic/scene/main/MainScene.lua

module("modules.logic.scene.main.MainScene", package.seeall)

local MainScene = class("MainScene", BaseScene)

function MainScene:_createAllComps()
	self:_addComp("director", MainSceneDirector)
	self:_addComp("level", MainSceneLevelComp)
	self:_addComp("camera", MainSceneCameraComp)
	self:_addComp("view", MainSceneViewComp)
	self:_addComp("gyro", MainSceneGyroComp)
	self:_addComp("bgm", CommonSceneBgmComp)
	self:_addComp("yearAnimation", MainSceneYearAnimationComp)
end

return MainScene
