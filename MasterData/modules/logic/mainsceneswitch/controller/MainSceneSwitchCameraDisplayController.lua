-- chunkname: @modules/logic/mainsceneswitch/controller/MainSceneSwitchCameraDisplayController.lua

module("modules.logic.mainsceneswitch.controller.MainSceneSwitchCameraDisplayController", package.seeall)

local MainSceneSwitchCameraDisplayController = class("MainSceneSwitchCameraDisplayController", MainSceneSwitchDisplayController)

MainSceneSwitchCameraDisplayController.instance = MainSceneSwitchCameraDisplayController.New()

function MainSceneSwitchCameraDisplayController:clear()
	if self._loaderMap then
		for k, v in pairs(self._loaderMap) do
			v:dispose()
		end

		tabletool.clear(self._loaderMap)
	end

	if self._weatherCompMap then
		for k, v in pairs(self._weatherCompMap) do
			for _, comp in ipairs(v) do
				comp:onSceneClose()
			end
		end

		tabletool.clear(self._weatherCompMap)
	end

	if self._sceneNameMap then
		for k, v in pairs(self._sceneNameMap) do
			gohelper.destroy(v)
		end

		tabletool.clear(self._sceneNameMap)
	end

	self._sceneRoot = nil
	self._callback = nil
	self._callbackTarget = nil
end

return MainSceneSwitchCameraDisplayController
