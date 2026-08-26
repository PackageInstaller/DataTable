-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/interacts/Va3ChessInteractPedal.lua

module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractPedal", package.seeall)

local Va3ChessInteractPedal = class("Va3ChessInteractPedal", Va3ChessInteractBase)
local CONST_UP_STATUS = 0
local CONST_DOWN_STATUS = 1
local Anima = {
	Down = "donw",
	Up = "up",
	DownIdle = "down_idle",
	UpIdle = "up_idle"
}

function Va3ChessInteractPedal:refreshPedalStatus()
	local status = self._target.originData:getPedalStatusInDataField() or CONST_UP_STATUS
	local isPress = status == CONST_DOWN_STATUS

	if self._isPress == isPress then
		return
	end

	self._isPress = isPress

	if self._isPress then
		self:playAnima(Anima.Down, 0, 0)
	else
		self:playAnima(Anima.Up, 0, 0)
	end
end

function Va3ChessInteractPedal:onAvatarLoaded()
	Va3ChessInteractPedal.super.onAvatarLoaded(self)

	local loader = self._target.avatar.loader

	if not loader then
		return
	end

	local go = loader:getInstGO()

	if not gohelper.isNil(go) then
		self._animSelf = go:GetComponent(typeof(UnityEngine.Animator))
	end

	self:playAnima(Anima.UpIdle, 0, 1)
end

function Va3ChessInteractPedal:playAnima(name, ...)
	if self._animSelf then
		self._animSelf:Play(name, ...)
	end
end

function Va3ChessInteractPedal:dispose()
	Va3ChessInteractPedal.super.dispose(self)
end

return Va3ChessInteractPedal
