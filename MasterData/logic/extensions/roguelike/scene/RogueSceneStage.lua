-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/scene/RogueSceneStage.lua

module("logic.extensions.roguelike.scene.RogueSceneStage", package.seeall)

local M = class("RogueSceneStage", SceneStageBase)
local kJudgeSceneName = "sx-s606_paotuan_judge_run"
local kJudgeScenePath = "sx-s606_paotuan/scene_run/sx-s606_paotuan_judge_run"

function M:onInit()
	self._resLoader = false
	self._sceneName = false
end

function M:load(sceneId)
	local resLoader = self._resLoader

	if not resLoader then
		self._resLoader = MultiResLoader.New()
		resLoader = self._resLoader
	end

	local sceneCO = SceneConfig.instance:getSceneCO(sceneId)

	self._sceneName = SceneCOUtil.getSceneName(sceneCO)
	self._mainSceneName = self._sceneName

	resLoader:addResPath(GameUrl.getSceneUrl(sceneCO.resPath), false)

	if RoguelikeConst.IsPreloadScene then
		local allMapIds = self:getAllPreloadMap(sceneId)

		self._additionSceneNames = {}

		for k, v in pairs(allMapIds) do
			local mapCo = RoguelikeConfig.instance:getMapById(v)

			if mapCo then
				local sceneCO1 = SceneConfig.instance:getSceneCO(mapCo.sceneCode)

				table.insert(self._additionSceneNames, SceneCOUtil.getSceneName(sceneCO1))
				resLoader:addResPath(GameUrl.getSceneUrl(sceneCO1.resPath), false)
			end
		end

		table.insert(self._additionSceneNames, kJudgeSceneName)
		resLoader:addResPath(GameUrl.getSceneUrl(kJudgeScenePath), false)
	end

	resLoader:load(self._onAllResourceLoaded, false, self)
end

function M:getAllPreloadMap(sceneId)
	local mapCo = RoguelikeConfig.instance:getMapBySceneCode(sceneId)
	local allMapIds = {}

	if mapCo then
		if mapCo.preloadMap then
			TableUtil.addRange(allMapIds, mapCo.preloadMap)
		end
	else
		printError("没有场景配置", sceneId)
	end

	return allMapIds
end

function M:_onAllResourceLoaded()
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SWITCH_BG_MUSIC, RoguelikeConst.ROGUE_EXPLORE_TYPE.MOVE)

	local resLoader = self._resLoader

	if not resLoader:isAllSuccess() and enableErrorLog then
		printError("load resource failed!")
	end

	SceneUtil.removeArtTestSceneGameObject(self._sceneName)
	VirtualCameraMgr.instance:setActiveCamera(VirtualCameraName.Rogue)
	VirtualCameraMgr.instance:setFollowConfiner("confiner_roguelike")

	local originFov = VirtualCameraMgr.instance:getFieldOfView()
	local screenWidth = UnityEngine.Screen.width
	local screenHeight = UnityEngine.Screen.height
	local defaultRate = 2.1653333333333333
	local curRate = screenWidth / screenHeight
	local changeRate = 1.6

	if originFov and curRate < defaultRate and curRate < changeRate then
		VirtualCameraMgr.instance:setFieldOfView(originFov + defaultRate / curRate * 1.8)
	end

	SceneLoadUtils.SetActiveScene(self._sceneName)
	self:_onAllLoaded()
	settimer(0.2, self._delayAction, self, false)

	if RoguelikeConst.IsPreloadScene then
		self:activeMainScene()
	end
end

function M:activeMainScene()
	self._activeSceneName = self._mainSceneName

	SceneLoadUtils.SetActiveScene(self._mainSceneName)
	GameObjectUtils.SetSceneActive(self._mainSceneName, true)

	for k, v in pairs(self._additionSceneNames) do
		GameObjectUtils.SetSceneActive(v, false)
	end

	self._isInMainScene = true
end

function M:activeAdditionScene(sceneId)
	GameObjectUtils.SetSceneActive(self._mainSceneName, false)

	local sceneCO1 = SceneConfig.instance:getSceneCO(sceneId)

	if not sceneCO1 then
		printError("找不到场景配置", sceneId)

		sceneCO1 = SceneConfig.instance:getSceneCO(6005)
	end

	local sceneName = SceneCOUtil.getSceneName(sceneCO1)

	self._activeSceneName = sceneName
	self._sceneId = sceneId

	SceneLoadUtils.SetActiveScene(sceneName)

	for k, v in pairs(self._additionSceneNames) do
		GameObjectUtils.SetSceneActive(v, v == sceneName)
	end

	self._isInMainScene = false
end

function M:activeJudgeScene()
	GameObjectUtils.SetSceneActive(self._mainSceneName, false)

	self._activeSceneName = kJudgeSceneName

	SceneLoadUtils.SetActiveScene(kJudgeSceneName)

	for k, v in pairs(self._additionSceneNames) do
		GameObjectUtils.SetSceneActive(v, v == kJudgeSceneName)
	end

	local pos = RogueMgr.instance:getMapMgr():getRealMapRolePos()
	local mapGo = goutil.find("sx-s606_paotuan_judge")

	if mapGo then
		mapGo.transform.position = pos
	end
end

function M:recoverSceneByExitJudgeScene()
	if self._isInMainScene then
		self:activeMainScene()
	else
		self:activeAdditionScene(self._sceneId)
	end
end

function M:_delayAction()
	MainCameraMgr.instance:setCameraVisible(true)
	self:delayChangePolygon()
end

function M:delayChangePolygon()
	local polygon = VirtualCameraMgr.instance:getPolygonColliderPolygon()

	if polygon == nil then
		return
	end

	RoguelikeModel.instance:updateCameraFollowConfiner()
end

function M:unload()
	if self._resLoader then
		self._resLoader:clear()
	end

	removetimer(self._delayAction, self)
end

function M:onLeaveScene(isDeepClean)
	if isDeepClean then
		local mapRoot = RogueMapGenerator.getMapsRoot()
		local roleRoot = RogueMapGenerator.getRoleRoot()

		goutil.setActive(mapRoot, false)
		goutil.setActive(roleRoot, false)
		SceneLoadUtils.SetActiveScene(self._activeSceneName)
		GameObjectUtils.SetSceneActive(self._activeSceneName, false)
		self:onExitScene()

		return
	end
end

function M:onReturnScene(isDeepClean)
	local mapRoot = RogueMapGenerator.getMapsRoot()
	local roleRoot = RogueMapGenerator.getRoleRoot()

	goutil.setActive(mapRoot, true)
	goutil.setActive(roleRoot, true)

	if isDeepClean then
		local sceneId = self._scene:getSceneId()

		self:onEnterScene(sceneId)

		return
	end

	if self._isInMainScene then
		self:activeMainScene()
	else
		self:activeAdditionScene(self._sceneId)
	end
end

function M:onReturnSceneFinished(isDeepClean)
	if isDeepClean then
		local goNear = UnityEngine.GameObject.Find("near")
		local mapParent1 = goutil.findChild(goNear, "xuanrenchangjing")

		goutil.setActive(mapParent1, false)
	end
end

return M
