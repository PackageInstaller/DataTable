-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/interacts/Va3ChessInteractSentryEnemy.lua

module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractSentryEnemy", package.seeall)

local Va3ChessInteractSentryEnemy = class("Va3ChessInteractSentryEnemy", Va3ChessInteractBase)

function Va3ChessInteractSentryEnemy:init(targetObj)
	Va3ChessInteractSentryEnemy.super.init(self, targetObj)

	self._enableAlarm = true
end

function Va3ChessInteractSentryEnemy:onDrawAlert(map)
	if not self._enableAlarm then
		return
	end

	local alertAreaData

	if self._target and self._target.originData and self._target.originData.data then
		alertAreaData = self._target.originData.data.alertArea
	end

	if alertAreaData then
		local x, y = alertAreaData[1].x, alertAreaData[1].y

		if Va3ChessGameModel.instance:isPosInChessBoard(x, y) and Va3ChessGameModel.instance:getBaseTile(x, y) ~= Va3ChessEnum.TileBaseType.None then
			map[x] = map[x] or {}
			map[x][y] = map[x][y] or {}

			table.insert(map[x][y], true)
		end
	end

	local curX, curY = self._target.originData.posX, self._target.originData.posY
	local isCanFireBallKill = Activity142Helper.isCanFireKill(self._target)

	if isCanFireBallKill then
		map[curX] = map[curX] or {}
		map[curX][curY] = map[curX][curY] or {}

		table.insert(map[curX][curY], {
			showOrangeStyle = isCanFireBallKill
		})
	end
end

local DeleteReason2Show = {
	[Va3ChessEnum.DeleteReason.Arrow] = {
		anim = "die",
		audio = AudioEnum.chess_activity142.Die
	},
	[Va3ChessEnum.DeleteReason.FireBall] = {
		anim = "die",
		audio = AudioEnum.chess_activity142.Die
	},
	[Va3ChessEnum.DeleteReason.MoveKill] = {
		anim = "die",
		audio = AudioEnum.chess_activity142.Die
	}
}

function Va3ChessInteractSentryEnemy:playDeleteObjView(deleteReason)
	if self._animSelf then
		if not DeleteReason2Show[deleteReason] then
			do
				local showData = {}

				if not showData.anim then
					local animName = "close"

					self._animSelf:Play(animName, 0, 0)

					local audioId = showData.audio

					if audioId then
						AudioMgr.instance:trigger(audioId)
					end
				end
			end

			if self._target and self._target.chessEffectObj and self._target.chessEffectObj.isShowEffect then
				self._target.chessEffectObj:isShowEffect(false)
			end
		end
	end
end

function Va3ChessInteractSentryEnemy:moveTo(x, y, callback, callbackObj)
	self._enableAlarm = false

	Va3ChessInteractSentryEnemy.super.moveTo(self, x, y, callback, callbackObj)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function Va3ChessInteractSentryEnemy:onMoveCompleted()
	Va3ChessInteractSentryEnemy.super.onMoveCompleted(self)

	self._enableAlarm = true

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function Va3ChessInteractSentryEnemy:onAvatarLoaded()
	Va3ChessInteractSentryEnemy.super.onAvatarLoaded(self)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)

	if self._target.avatar and self._target.avatar.loader then
		local go = self._target.avatar.loader:getInstGO()

		if not gohelper.isNil(go) then
			self._animSelf = go:GetComponent(typeof(UnityEngine.Animator))

			if self._animSelf then
				self._animSelf:Play("open", 0, 0)
			end
		end
	end
end

function Va3ChessInteractSentryEnemy:dispose()
	self._enableAlarm = false

	Va3ChessInteractSentryEnemy.super.dispose(self)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

return Va3ChessInteractSentryEnemy
