-- chunkname: @modules/logic/versionactivity3_9/racingcar/scene/V3a9RacingCarScene.lua

module("modules.logic.versionactivity3_9.racingcar.scene.V3a9RacingCarScene", package.seeall)

local V3a9RacingCarScene = class("V3a9RacingCarScene", BaseScene)

function V3a9RacingCarScene:_createAllComps()
	self:_addComp("director", V3a9RacingCarSceneDirector)
	self:_addComp("preloader", V3a9RacingCarScenePreloader)
	self:_addComp("level", V3a9RacingCarSceneLevelComp)
	self:_addComp("camera", V3a9RacingCarSceneCameraComp)
	self:_addComp("graphics", V3a9RacingCarSceneGraphicsComp)
	self:_addComp("playerComp", V3a9RacingCarSceneMainPlayerComp)
	self:_addComp("view", V3a9RacingCarSceneViewComp)
end

return V3a9RacingCarScene
