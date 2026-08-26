-- chunkname: @modules/logic/scene/cachot/CachotScene.lua

module("modules.logic.scene.cachot.CachotScene", package.seeall)

local CachotScene = class("CachotScene", BaseScene)

function CachotScene:_createAllComps()
	self:_addComp("bgm", CachotBGMComp)
	self:_addComp("player", CachotPlayerComp)
	self:_addComp("camera", CachotSceneCamera)
	self:_addComp("director", CachotSceneDirector)
	self:_addComp("level", CachotSceneLevel)
	self:_addComp("preloader", CachotScenePreloader)
	self:_addComp("view", CachotSceneViewComp)
	self:_addComp("event", CachotEventComp)
	self:_addComp("light", CachotLightComp)
end

return CachotScene
