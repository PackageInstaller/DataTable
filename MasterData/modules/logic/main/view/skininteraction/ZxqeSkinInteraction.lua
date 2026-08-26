-- chunkname: @modules/logic/main/view/skininteraction/ZxqeSkinInteraction.lua

module("modules.logic.main.view.skininteraction.ZxqeSkinInteraction", package.seeall)

local ZxqeSkinInteraction = class("ZxqeSkinInteraction", CommonSkinInteraction)
local CubismSortingMode = Live2D.Cubism.Rendering.CubismSortingMode
local b_jiaohu03 = "b_jiaohu03"

function ZxqeSkinInteraction:_onInit()
	ZxqeSkinInteraction.super._onInit(self)

	self._lightSpine = self._view._lightSpine
end

function ZxqeSkinInteraction:_onBodyChange(prevBodyName, curBodyName)
	if curBodyName == b_jiaohu03 then
		self._lightSpine:changeSortingMode(CubismSortingMode.BackToFrontOrder)
	end

	if prevBodyName == b_jiaohu03 then
		self._lightSpine:changeSortingMode(CubismSortingMode.BackToFrontZ)
		TaskDispatcher.cancelTask(self._delayResetCameraPos, self)
		TaskDispatcher.runDelay(self._delayResetCameraPos, self, 0)
	end
end

function ZxqeSkinInteraction:_delayResetCameraPos()
	self:_resetCameraPos()
end

function ZxqeSkinInteraction:_resetCameraPos()
	self._mainRootGo = CameraMgr.instance:getCameraTraceGO()

	transformhelper.setLocalRotation(self._mainRootGo.transform, 0, 0, 0)

	local trace = CameraMgr.instance:getCameraTrace()

	trace.EnableTrace = true
	trace.EnableTrace = false
	trace.enabled = false
end

function ZxqeSkinInteraction:_onDestroy()
	TaskDispatcher.cancelTask(self._delayResetCameraPos, self)
	self:_resetCameraPos()
end

return ZxqeSkinInteraction
