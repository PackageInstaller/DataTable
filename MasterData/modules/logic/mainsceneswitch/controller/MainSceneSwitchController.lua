-- chunkname: @modules/logic/mainsceneswitch/controller/MainSceneSwitchController.lua

module("modules.logic.mainsceneswitch.controller.MainSceneSwitchController", package.seeall)

local MainSceneSwitchController = class("MainSceneSwitchController", BaseController)

function MainSceneSwitchController:onInit()
	self:reInit()
end

function MainSceneSwitchController:onInitFinish()
	return
end

function MainSceneSwitchController:addConstEvents()
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._onGetInfoFinish, self)
end

function MainSceneSwitchController:reInit()
	self._startSwitchTime = 0

	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, self._onLevelLoaded, self)
end

function MainSceneSwitchController:_onGetInfoFinish()
	MainSceneSwitchModel.instance:initSceneId()
end

function MainSceneSwitchController:isSwitching()
	return Time.realtimeSinceStartup - self._startSwitchTime <= 10
end

function MainSceneSwitchController:switchScene()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	self:dispatchEvent(MainSceneSwitchEvent.StartSwitchScene)

	self._startSwitchTime = Time.realtimeSinceStartup

	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, self._onLevelLoaded, self)

	local scene = GameSceneMgr.instance:getCurScene()

	scene.level:switchLevel()
end

function MainSceneSwitchController:_onLevelLoaded()
	self._startSwitchTime = 0

	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, self._onLevelLoaded, self)

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	self:dispatchEvent(MainSceneSwitchEvent.SwitchSceneFinish)
end

function MainSceneSwitchController.getLightColor(lightMode, id)
	local sceneId = id
	local settingsConfig = lua_scene_settings.configDict[sceneId]

	return settingsConfig["lightColor" .. lightMode]
end

function MainSceneSwitchController.getPrefabLightStartRotation(lightMode, id)
	local sceneId = id
	local settingsConfig = lua_scene_settings.configDict[sceneId]

	return settingsConfig.prefabLightStartRotation[lightMode]
end

function MainSceneSwitchController.getEffectLightStartRotation(lightMode, id)
	local sceneId = id
	local settingsConfig = lua_scene_settings.configDict[sceneId]

	return settingsConfig.effectLightStartRotation[lightMode]
end

function MainSceneSwitchController.closeReddot()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.MainSceneSwitch, 0) then
		RedDotRpc.instance:sendShowRedDotRequest(RedDotEnum.DotNode.MainSceneSwitch, false)
	end
end

function MainSceneSwitchController.AnySceneHasReddot()
	for i, v in ipairs(lua_scene_switch.configList) do
		if v.defaultUnlock ~= 1 and MainSceneSwitchController.sceneHasReddot(v.id) then
			return true
		end
	end

	return false
end

function MainSceneSwitchController.sceneHasReddot(sceneId)
	return false
end

function MainSceneSwitchController.closeSceneReddot(sceneId)
	return
end

MainSceneSwitchController.instance = MainSceneSwitchController.New()

return MainSceneSwitchController
