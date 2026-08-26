-- chunkname: @modules/logic/video/view/FullScreenVideoAdapter.lua

module("modules.logic.video.view.FullScreenVideoAdapter", package.seeall)

local FullScreenVideoAdapter = class("FullScreenVideoAdapter", LuaCompBase)
local MaxAspectRatio = 2.4

function FullScreenVideoAdapter:ctor()
	return
end

function FullScreenVideoAdapter:init(go)
	self.tr = go.transform

	local bgAdapter = go:GetComponent(typeof(ZProj.UIBgSelfAdapter))

	if bgAdapter then
		bgAdapter.enabled = false
		bgAdapter = nil
	end

	self:_onScreenResize(UnityEngine.Screen.width, UnityEngine.Screen.height)
end

function FullScreenVideoAdapter:addEventListeners()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function FullScreenVideoAdapter:removeEventListeners()
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function FullScreenVideoAdapter:_onScreenResize(width, height)
	local aspectRatio = width / height

	if aspectRatio > MaxAspectRatio then
		local scale = aspectRatio / MaxAspectRatio

		transformhelper.setLocalScale(self.tr, scale, scale, scale)
	else
		transformhelper.setLocalScale(self.tr, 1, 1, 1)
	end
end

return FullScreenVideoAdapter
