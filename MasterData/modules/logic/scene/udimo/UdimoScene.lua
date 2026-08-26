-- chunkname: @modules/logic/scene/udimo/UdimoScene.lua

module("modules.logic.scene.udimo.UdimoScene", package.seeall)

local UdimoScene = class("UdimoScene", BaseScene)

function UdimoScene:_createAllComps()
	self:_addComp("camera", UdimoSceneCameraComp)
	self:_addComp("director", UdimoSceneDirector)
	self:_addComp("level", UdimoSceneLevelComp)
	self:_addComp("loader", UdimoSceneLoader)
	self:_addComp("go", UdimoSceneGOComp)
	self:_addComp("graphics", UdimoSceneGraphicsComp)
	self:_addComp("decoration", UdimoSceneDecorationComp)
	self:_addComp("stayPoint", UdimoSceneStayPointComp)
	self:_addComp("interactPoint", UdimoSceneInteractionPointComp)
	self:_addComp("udimomgr", UdimoEntityMgr)
	self:_addComp("bgm", UdimoSceneBgmComp)
	self:_addComp("timeAnim", UdimoSceneTimeAnimComp)
	self:_addComp("weather", UdimoSceneWeatherComp)
	self:_addComp("view", UdimoSceneViewComp)
end

return UdimoScene
