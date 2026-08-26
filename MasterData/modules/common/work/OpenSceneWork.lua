-- chunkname: @modules/common/work/OpenSceneWork.lua

module("modules.common.work.OpenSceneWork", package.seeall)

local OpenSceneWork = class("OpenSceneWork", BaseWork)

function OpenSceneWork:ctor(sceneType, sceneId, levelId, forceStarting, forceSceneType)
	self.sceneType = sceneType
	self.sceneId = sceneId
	self.levelId = levelId
	self.forceStarting = forceStarting
	self.forceSceneType = forceSceneType
end

function OpenSceneWork:onStart()
	GameSceneMgr.instance:startScene(self.sceneType, self.sceneId, self.levelId, self.forceStarting, self.forceSceneType)
	GameSceneMgr.instance:registerCallback(self.sceneType, self.onSceneLoadDone, self)
end

function OpenSceneWork:onSceneLoadDone()
	GameSceneMgr.instance:unregisterCallback(self.sceneType, self.onSceneLoadDone, self)
	self:onDone(true)
end

function OpenSceneWork:clearWork()
	GameSceneMgr.instance:unregisterCallback(self.sceneType, self.onSceneLoadDone, self)
end

return OpenSceneWork
