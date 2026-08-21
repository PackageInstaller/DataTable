-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/specialtraining/scene/stage/SpecialTrainingStage.lua

module("logic.extensions.specialtraining.scene.stage.SpecialTrainingStage", package.seeall)

local M = class("SpecialTrainingStage", SceneStageBase)

function M:onInit()
	M.super.onInit(self)

	self._resLoader = false
	self._mainSceneName = false
	self._curSceneCO = false
	self._loadFinish = false
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	M.super.onEnterSceneFinished(self, sceneId, bornX, bornZ)
end

function M:onExitScene()
	M.super.onExitScene(self)
end

function M:onLeaveScene(needUnloadRes)
	if not needUnloadRes then
		GameObjectUtils.SetSceneActive(self._mainSceneName, false)

		return
	end

	self:onExitScene()
end

function M:onReturnScene(needUnloadRes)
	if not needUnloadRes then
		GameObjectUtils.SetSceneActive(self._mainSceneName, true)

		return
	end

	self:load(self._scene:getSceneId())
end

function M:load(sceneId)
	self._loadFinish = false

	local resLoader = self._resLoader

	if not resLoader then
		self._resLoader = MultiResLoader.New()
		resLoader = self._resLoader
	end

	local sceneCO = SceneConfig.instance:getSceneCO(sceneId)

	self._mainSceneName = SceneCOUtil.getSceneName(sceneCO)

	resLoader:addResPath(GameUrl.getSceneUrl(sceneCO.resPath), false)
	resLoader:load(self._onAllResourceLoaded, false, self)

	self._curSceneCO = sceneCO
end

function M:_onAllResourceLoaded()
	self._loadFinish = true

	local resLoader = self._resLoader

	if not resLoader:isAllSuccess() then
		printError("load resource failed!")
	end

	SceneLoadUtils.SetActiveScene(self._mainSceneName)
	GameObjectUtils.SetSceneActive(self._mainSceneName, true)
	self:_onAllLoaded()
end

function M:getSceneName()
	return self._mainSceneName
end

function M:getIsLoadFinish()
	return self._loadFinish
end

function M:unload()
	if self._resLoader then
		self._resLoader:clear()
	end

	self._loadFinish = false
end

function M:getGoList(name)
	local goList = {}

	GameObjectUtils.FindChildRecursivelyBySceneName(self._mainSceneName, 100, name, goList)

	return goList
end

return M
