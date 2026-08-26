-- chunkname: @modules/logic/activity/controller/chessmap/interacts/ActivityChessInteractTriggerFail.lua

module("modules.logic.activity.controller.chessmap.interacts.ActivityChessInteractTriggerFail", package.seeall)

local ActivityChessInteractTriggerFail = class("ActivityChessInteractTriggerFail", ActivityChessInteractBase)

function ActivityChessInteractTriggerFail:init(targetObj)
	ActivityChessInteractTriggerFail.super.init(self, targetObj)

	self._enableAlarm = true
end

function ActivityChessInteractTriggerFail:onDrawAlert(map)
	if not self._enableAlarm then
		return
	end

	local curX, curY = self._target.originData.posX, self._target.originData.posY

	ActivityChessInteractTriggerFail.insertToAlertMap(map, curX, curY)

	if self._target.originData.data and self._target.originData.data.alertArea then
		local alertArea = self._target.originData.data.alertArea
		local needRefreshFace = #alertArea == 1

		if needRefreshFace then
			local tarX, tarY = alertArea[1].x, alertArea[1].y
			local srcX, srcY = self._target.originData.posX, self._target.originData.posY
			local dir = ActivityChessMapUtils.ToDirection(srcX, srcY, tarX, tarY)

			self:faceTo(dir)
		end
	end
end

function ActivityChessInteractTriggerFail.insertToAlertMap(map, x, y)
	if ActivityChessGameModel.instance:isPosInChessBoard(x, y) and ActivityChessGameModel.instance:getBaseTile(x, y) ~= ActivityChessEnum.TileBaseType.None then
		map[x] = map[x] or {}
		map[x][y] = true
	end
end

function ActivityChessInteractTriggerFail:moveTo(x, y, callback, callbackObj)
	self._enableAlarm = false
	self._moveTargetX = x
	self._moveTargetY = y

	ActivityChessInteractTriggerFail.super.moveTo(self, x, y, callback, callbackObj)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

function ActivityChessInteractTriggerFail:onMoveCompleted()
	ActivityChessInteractTriggerFail.super.onMoveCompleted(self)

	self._enableAlarm = true

	local resultCount = ActivityChessGameController.instance:searchInteractByPos(self._moveTargetX, self._moveTargetY, ActivityChessGameController.filterSelectable)

	if resultCount > 0 then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.SheriffCatch)
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

function ActivityChessInteractTriggerFail:onAvatarLoaded()
	ActivityChessInteractTriggerFail.super.onAvatarLoaded(self)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

function ActivityChessInteractTriggerFail:dispose()
	self._enableAlarm = false

	ActivityChessInteractTriggerFail.super.dispose(self)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

return ActivityChessInteractTriggerFail
