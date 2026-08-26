-- chunkname: @modules/live2d/controller/Live2dMaskController.lua

module("modules.live2d.controller.Live2dMaskController", package.seeall)

local Live2dMaskController = class("Live2dMaskController", BaseController)

function Live2dMaskController:onInit()
	self:reInit()
end

function Live2dMaskController:reInit()
	self._goList = {}
end

function Live2dMaskController:addConstEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinsh, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Live2dMaskController:_onOpenViewFinsh()
	self:_checkMask()
end

function Live2dMaskController:_onCloseViewFinish()
	self:_checkMask()
end

function Live2dMaskController:addLive2dGo(go)
	if not go then
		return
	end

	if gohelper.isNil(go) then
		return
	end

	self._goList[go] = true

	self:_checkMask()
end

function Live2dMaskController:removeLive2dGo(go)
	if not go then
		return
	end

	self._goList[go] = nil

	self:_checkMask()
end

function Live2dMaskController:_checkMask()
	local needMask = self:_needMask()

	RenderPipelineSetting.SetCubisMaskCommandBufferLateUpdateEnable(needMask)
end

function Live2dMaskController:_needMask()
	for k, v in pairs(self._goList) do
		if not gohelper.isNil(k) then
			return true
		else
			rawset(self._goList, k, nil)
		end
	end

	return false
end

Live2dMaskController.instance = Live2dMaskController.New()

return Live2dMaskController
