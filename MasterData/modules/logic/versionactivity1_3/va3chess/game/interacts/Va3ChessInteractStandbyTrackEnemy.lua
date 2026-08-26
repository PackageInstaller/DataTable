-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/interacts/Va3ChessInteractStandbyTrackEnemy.lua

module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractStandbyTrackEnemy", package.seeall)

local Va3ChessInteractStandbyTrackEnemy = class("Va3ChessInteractStandbyTrackEnemy", Va3ChessInteractBase)
local DeleteReason2Show = {
	[Va3ChessEnum.DeleteReason.Arrow] = {
		anim = "die",
		audio = AudioEnum.chess_activity142.Die
	},
	[Va3ChessEnum.DeleteReason.FireBall] = {
		anim = "die",
		audio = AudioEnum.chess_activity142.Die
	},
	[Va3ChessEnum.DeleteReason.Change] = {
		anim = Activity142Enum.SWITCH_CLOSE_ANIM
	}
}

function Va3ChessInteractStandbyTrackEnemy:playDeleteObjView(deleteReason)
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

function Va3ChessInteractStandbyTrackEnemy:onDrawAlert(map)
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

function Va3ChessInteractStandbyTrackEnemy:onAvatarLoaded()
	Va3ChessInteractStandbyTrackEnemy.super.onAvatarLoaded(self)

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

return Va3ChessInteractStandbyTrackEnemy
