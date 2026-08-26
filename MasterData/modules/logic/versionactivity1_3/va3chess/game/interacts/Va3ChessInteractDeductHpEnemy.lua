-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/interacts/Va3ChessInteractDeductHpEnemy.lua

module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractDeductHpEnemy", package.seeall)

local Va3ChessInteractDeductHpEnemy = class("Va3ChessInteractDeductHpEnemy", Va3ChessInteractBase)

function Va3ChessInteractDeductHpEnemy:init(targetObj)
	Va3ChessInteractDeductHpEnemy.super.init(self, targetObj)

	self._enableAlarm = true
end

function Va3ChessInteractDeductHpEnemy:onDrawAlert(map)
	if not self._enableAlarm then
		return
	end

	local curX, curY = self._target.originData.posX, self._target.originData.posY

	if self._target.originData.data and self._target.originData.data.alertArea then
		local alertArea = self._target.originData.data.alertArea
		local needRefreshFace = #alertArea == 1

		if needRefreshFace then
			local tarX, tarY = alertArea[1].x, alertArea[1].y
			local srcX, srcY = self._target.originData.posX, self._target.originData.posY
			local dir = Va3ChessMapUtils.ToDirection(srcX, srcY, tarX, tarY)

			self:faceTo(dir)
		end
	end
end

function Va3ChessInteractDeductHpEnemy:playDeleteObjView()
	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.DeductHp)
end

function Va3ChessInteractDeductHpEnemy:moveTo(x, y, callback, callbackObj)
	self._enableAlarm = false

	Va3ChessInteractDeductHpEnemy.super.moveTo(self, x, y, callback, callbackObj)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function Va3ChessInteractDeductHpEnemy:onMoveCompleted()
	Va3ChessInteractDeductHpEnemy.super.onMoveCompleted(self)

	self._enableAlarm = true

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function Va3ChessInteractDeductHpEnemy:onAvatarLoaded()
	Va3ChessInteractDeductHpEnemy.super.onAvatarLoaded(self)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function Va3ChessInteractDeductHpEnemy:dispose()
	self._enableAlarm = false

	Va3ChessInteractDeductHpEnemy.super.dispose(self)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

return Va3ChessInteractDeductHpEnemy
