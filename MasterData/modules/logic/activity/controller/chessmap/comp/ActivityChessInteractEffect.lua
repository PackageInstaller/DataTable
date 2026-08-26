-- chunkname: @modules/logic/activity/controller/chessmap/comp/ActivityChessInteractEffect.lua

module("modules.logic.activity.controller.chessmap.comp.ActivityChessInteractEffect", package.seeall)

local ActivityChessInteractEffect = class("ActivityChessInteractEffect")

function ActivityChessInteractEffect:ctor(interactObj)
	self._target = interactObj
end

function ActivityChessInteractEffect:refreshSearchFailed()
	if self._target.originData and self._target.originData.data and self._target.avatar and self._target.avatar.goLostTarget then
		gohelper.setActive(self._target.avatar.goLostTarget, self._target.originData.data.lostTarget)
	end
end

function ActivityChessInteractEffect:dispose()
	return
end

function ActivityChessInteractEffect:onAvatarLoaded()
	local loader = self._target.avatar.loader

	if not loader then
		return
	end

	self._target.avatar.goLostTarget = gohelper.findChild(loader:getInstGO(), "piecea/vx_vertigo")

	self:refreshSearchFailed()
end

return ActivityChessInteractEffect
