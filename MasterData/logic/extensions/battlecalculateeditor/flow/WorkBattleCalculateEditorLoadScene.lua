-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlecalculateeditor/flow/WorkBattleCalculateEditorLoadScene.lua

module("logic.extensions.battlecalculateeditor.flow.WorkBattleCalculateEditorLoadScene", package.seeall)

local M = class("WorkBattleCalculateEditorLoadScene", WorkBase)

function M:onEnter(context)
	local sceneCode = context.model:getSceneCode()

	if SceneMgr.instance:isInTargetScene(SceneType.BattleCalculateEditor, sceneCode) then
		local scene = SceneMgr.instance:getCurScene()

		scene.audioMgr:playBgmAndEnviroment()
		self:onDone(WorkResult.Succeed)

		return
	end

	self._loadingSceneCode = sceneCode

	GlobalDispatcher:addEventListener(EventType.ON_SCENE_LOADED, self._onSceneLoaded, self)
	SceneMgr.instance:enter(SceneType.BattleCalculateEditor, sceneCode, 0, 0)
end

function M:onExit(isInterrupt)
	GlobalDispatcher:removeEventListener(EventType.ON_SCENE_LOADED, self._onSceneLoaded, self)
end

function M:_onSceneLoaded(_, sceneType, sceneId)
	if sceneType == SceneType.BattleCalculateEditor and self._loadingSceneCode == sceneId then
		self:onDone(WorkResult.Succeed)
	end
end

return M
