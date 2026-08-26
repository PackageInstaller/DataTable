-- chunkname: @modules/logic/scene/explore/ExploreScene.lua

module("modules.logic.scene.explore.ExploreScene", package.seeall)

local ExploreScene = class("ExploreScene", BaseScene)

function ExploreScene:_createAllComps()
	self:_addComp("camera", ExploreSceneCameraComp)
	self:_addComp("director", ExploreSceneDirector)
	self:_addComp("spineMat", ExploreSceneSpineMat)
	self:_addComp("preloader", ExploreScenePreloader)
	self:_addComp("map", ExploreSceneMap)
	self:_addComp("level", ExploreSceneLevel)
	self:_addComp("view", ExploreSceneViewComp)
	self:_addComp("graphics", ExploreSceneGraphicsComp)
	self:_addComp("volume", ExploreScenePPVolume)
	self:_addComp("stat", ExploreStatComp)
	self:_addComp("audio", ExploreAudioComp)
end

function ExploreScene:onPrepared()
	ExploreScene.super.onPrepared(self)
end

return ExploreScene
