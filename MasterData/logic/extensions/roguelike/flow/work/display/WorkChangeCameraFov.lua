-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/display/WorkChangeCameraFov.lua

module("logic.extensions.roguelike.flow.work.display.WorkChangeCameraFov", package.seeall)

local M = class("WorkChangeCameraFov", WorkBase)

function M:onEnter(context)
	local roleMos = RogueMgr.instance:getModel():getAllRoleMos()
	local mapMgr = RogueMgr.instance:getMapMgr()
	local pos = mapMgr:getMapRolePos()

	self._rolePos = pos
	self._isDown = context.isDown

	if context.isDown then
		local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE

		TweenUtil.tweenNumber(function(handle, value, isFinish)
			if isFinish then
				self:onDone(WorkResult.Succeed)
			else
				VirtualCameraMgr.instance:setFieldOfView(value)
			end
		end, self, VirtualCameraMgr.instance:getFieldOfView(), 10, RoguelikeConst.MAP_CHANGE_CAMERA_TIME)
	else
		local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE

		TweenUtil.tweenNumber(function(handle, value, isFinish)
			if isFinish then
				self:onDone(WorkResult.Succeed)
			else
				VirtualCameraMgr.instance:setFieldOfView(value)
			end
		end, self, VirtualCameraMgr.instance:getFieldOfView(), 19.5, RoguelikeConst.MAP_CHANGE_CAMERA_TIME)
	end
end

function M:_onAniFinish()
	if self._isDown then
		self._originFov = VirtualCameraMgr.instance:getFieldOfView()

		TweenUtil.tweenNumber(function(handle, value, isFinish)
			if isFinish then
				self:onDone(WorkResult.Succeed)
			else
				VirtualCameraMgr.instance:setFieldOfView(value)
			end
		end, self, self._originFov, 20, RoguelikeConst.MAP_CHANGE_CAMERA_TIME)
	else
		TweenUtil.tweenNumber(function(handle, value, isFinish)
			if isFinish then
				self:onDone(WorkResult.Succeed)
			else
				VirtualCameraMgr.instance:setFieldOfView(value)
			end
		end, self, VirtualCameraMgr.instance:getFieldOfView(), 48, RoguelikeConst.MAP_CHANGE_CAMERA_TIME)
	end
end

function M:onExit(isInterrupt)
	removetimer(self._onAniFinish, self)
end

return M
