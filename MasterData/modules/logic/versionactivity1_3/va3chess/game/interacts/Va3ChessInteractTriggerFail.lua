-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/interacts/Va3ChessInteractTriggerFail.lua

module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractTriggerFail", package.seeall)

local Va3ChessInteractTriggerFail = class("Va3ChessInteractTriggerFail", Va3ChessInteractBase)

function Va3ChessInteractTriggerFail:init(targetObj)
	Va3ChessInteractTriggerFail.super.init(self, targetObj)

	self._enableAlarm = false
	self._isAlertActive = true
end

function Va3ChessInteractTriggerFail:onDrawAlert(map)
	if not self._enableAlarm then
		return
	end

	local curX, curY = self._target.originData.posX, self._target.originData.posY

	if self._isAlertActive then
		self:insertToAlertMap(map, curX, curY)
	end

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

function Va3ChessInteractTriggerFail:setAlertActive(isActive)
	self._isAlertActive = isActive
end

function Va3ChessInteractTriggerFail:insertToAlertMap(map, x, y)
	if Va3ChessGameModel.instance:isPosInChessBoard(x, y) and Va3ChessGameModel.instance:getBaseTile(x, y) ~= Va3ChessEnum.TileBaseType.None then
		local isCanFireBallKill = Activity142Helper.isCanFireKill(self._target)

		map[x] = map[x] or {}
		map[x][y] = map[x][y] or {}

		table.insert(map[x][y], {
			showOrangeStyle = isCanFireBallKill
		})
	end
end

function Va3ChessInteractTriggerFail:moveTo(x, y, callback, callbackObj)
	self._enableAlarm = false
	self._moveTargetX = x
	self._moveTargetY = y

	Va3ChessInteractTriggerFail.super.moveTo(self, x, y, callback, callbackObj)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function Va3ChessInteractTriggerFail:onMoveCompleted()
	Va3ChessInteractTriggerFail.super.onMoveCompleted(self)

	self._enableAlarm = true

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function Va3ChessInteractTriggerFail:onAvatarLoaded()
	self._enableAlarm = true

	Va3ChessInteractTriggerFail.super.onAvatarLoaded(self)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)

	if not self._target.avatar or not self._target.avatar.loader then
		return
	end

	local go = self._target.avatar.loader:getInstGO()

	if gohelper.isNil(go) then
		return
	end

	self._animSelf = go:GetComponent(typeof(UnityEngine.Animator))

	if self._animSelf then
		local mo = Va3ChessGameModel.instance:getObjectDataById(self._target.id)

		if mo and mo:getHaveBornEff() then
			self._animSelf:Play(Va3ChessEnum.SWITCH_OPEN_ANIM, 0, 0)
			AudioMgr.instance:trigger(AudioEnum.chess_activity142.SwitchTrackEnemy)
			mo:setHaveBornEff(false)
		end
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

function Va3ChessInteractTriggerFail:playDeleteObjView(deleteReason)
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

function Va3ChessInteractTriggerFail:dispose()
	self._enableAlarm = false

	Va3ChessInteractTriggerFail.super.dispose(self)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

return Va3ChessInteractTriggerFail
