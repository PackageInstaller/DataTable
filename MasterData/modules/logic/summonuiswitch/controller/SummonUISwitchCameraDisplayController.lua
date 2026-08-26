-- chunkname: @modules/logic/summonuiswitch/controller/SummonUISwitchCameraDisplayController.lua

module("modules.logic.summonuiswitch.controller.SummonUISwitchCameraDisplayController", package.seeall)

local SummonUISwitchCameraDisplayController = class("SummonUISwitchCameraDisplayController", SummonUISkinSwitchDisplayController)

SummonUISwitchCameraDisplayController.instance = SummonUISwitchCameraDisplayController.New()

function SummonUISwitchCameraDisplayController:clear()
	if self._loaderMap then
		for k, v in pairs(self._loaderMap) do
			v:dispose()
		end

		tabletool.clear(self._loaderMap)
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

return SummonUISwitchCameraDisplayController
