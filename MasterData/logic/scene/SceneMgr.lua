-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/SceneMgr.lua

module("logic.scene.SceneMgr", package.seeall)

local M = class("SceneMgr", SceneMgrBase)

function M:ctor()
	M.super.ctor(self)
end

function M:getSceneRoot()
	return self._root
end

function M:exitCurScene()
	M.super.exitCurScene(self)

	self._isEnetering = false
end

function M:_registerScenes()
	self:_registerScene(SceneType.Battle, BattleScene)
	self:_registerScene(SceneType.House, HouseScene)
	self:_registerScene(SceneType.Room, RoomScene)
	self:_registerScene(SceneType.Team, TeamScene)
	self:_registerScene(SceneType.RunGroup, RogueScene)
	self:_registerScene(SceneType.RunGroupSecondary, RogueSecondaryScene)
	self:_registerScene(SceneType.Profiler, ProfilerScene)
	self:_registerScene(SceneType.AutoRun, AutoRunScene)
	self:_registerScene(SceneType.Story, StoryScene)
	self:_registerScene(SceneType.SpecialTraining, SpecialTrainingScene)
	self:_registerScene(SceneType.AirWorkShop, AirWorkShopScene)
	self:_registerScene(SceneType.ClawDoll, ClawDollScene)
	self:_registerScene(SceneType.BattleCalculateEditor, BattleCalculateEditorScene)
	self:_registerScene(SceneType.CharacterPreview, CharacterPreviewScene)
	self:_registerScene(SceneType.Retrieve, RetrieveScene)
end

function M:enter(sceneType, sceneId, bornX, bornZ)
	if self._isEnetering or self:isInTargetScene(sceneType, sceneId) then
		return
	end

	M.super.enter(self, sceneType, sceneId, bornX, bornZ)
	GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_BEGIN, sceneType, sceneId)
	MemoryMgr.instance:gc()
	CriwareAudioFacade.instance:unloadOldCueSheet()
end

function M:enterDirectly(sceneType, sceneId, bornX, bornZ)
	if self._isEnetering or self:isInTargetScene(sceneType, sceneId) then
		return
	end

	local scene = self:getScene(sceneType)

	if not scene then
		return
	end

	self._isEnetering = true
	self._curSceneType = sceneType
	self._curSceneId = sceneId

	scene:onEnter(sceneId, bornX, bornZ)
	MemoryMgr.instance:gc()
end

function M:returnScene(sceneType, sceneId)
	self._isEnetering = false
	self._curSceneType = sceneType
	self._curSceneId = sceneId

	MemoryMgr.instance:gc()
end

function M:onEnterFinished()
	M.super.onEnterFinished(self)
	GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_LOADED, self._curSceneType, self._curSceneId)
end

function M:getCurSceneName()
	local scene = self:getCurScene()

	return scene and scene.stage:getSceneName()
end

function M:isInTargetScene(sceneType, sceneId)
	return self._curSceneType == sceneType and self._curSceneId == sceneId
end

function M:isInSceneType(sceneType)
	return self._curSceneType == sceneType
end

function M:getCurSceneType()
	return self._curSceneType
end

function M:_showLoading()
	return
end

function M:_hideLoading()
	return
end

M.instance = M.New()

return M
