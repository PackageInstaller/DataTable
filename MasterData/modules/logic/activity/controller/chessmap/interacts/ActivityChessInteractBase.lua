-- chunkname: @modules/logic/activity/controller/chessmap/interacts/ActivityChessInteractBase.lua

module("modules.logic.activity.controller.chessmap.interacts.ActivityChessInteractBase", package.seeall)

local ActivityChessInteractBase = class("ActivityChessInteractBase")

function ActivityChessInteractBase:init(targetObj)
	self._target = targetObj
end

function ActivityChessInteractBase:onSelectCall()
	return
end

function ActivityChessInteractBase:onCancelSelect()
	return
end

function ActivityChessInteractBase:onSelectPos(x, y)
	return
end

function ActivityChessInteractBase:moveTo(x, y, callback, callbackObj)
	if self._target.avatar then
		local srcX, srcY = self._target.originData.posX, self._target.originData.posY

		self._target.originData.posX = x
		self._target.originData.posY = y

		local sceneX, sceneY, sceneZ = ActivityChessGameController.instance:calcTilePosInScene(x, y, self._target.avatar.order)
		local avatar = self._target.avatar

		self:killMoveTween()

		self._moveCallback = callback
		self._moveCallbackObj = callbackObj
		self._tweenIdMoveScene = ZProj.TweenHelper.DOLocalMove(avatar.sceneTf, sceneX, sceneY, sceneZ, 0.3, self.onMoveCompleted, self, nil, EaseType.Linear)

		local dir = ActivityChessMapUtils.ToDirection(srcX, srcY, x, y)

		self:faceTo(dir)
	elseif callback then
		callback(callbackObj)
	end
end

function ActivityChessInteractBase:faceTo(dir)
	self._curDir = dir

	if self._target.avatar then
		if not ActivityChessInteractObject.DirectionSet[self._curDir] then
			return
		end

		for i, tmpDir in ipairs(ActivityChessInteractObject.DirectionList) do
			local child = self._target.avatar["goFaceTo" .. tmpDir]

			if not gohelper.isNil(child) then
				gohelper.setActive(child, dir == tmpDir)
			end
		end
	end
end

function ActivityChessInteractBase:onMoveCompleted()
	if self._moveCallback then
		-- block empty
	end
end

function ActivityChessInteractBase:onDrawAlert(map)
	return
end

function ActivityChessInteractBase:onAvatarLoaded()
	if not self._curDir then
		if self._curDir ~= nil and self._curDir ~= 0 then
			self:faceTo(self._curDir)
		end
	end
end

function ActivityChessInteractBase:killMoveTween()
	if self._tweenIdMoveScene then
		ZProj.TweenHelper.KillById(self._tweenIdMoveScene)

		self._tweenIdMoveScene = nil
	end
end

function ActivityChessInteractBase:dispose()
	self:killMoveTween()
end

return ActivityChessInteractBase
