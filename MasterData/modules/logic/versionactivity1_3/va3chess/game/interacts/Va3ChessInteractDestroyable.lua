-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/interacts/Va3ChessInteractDestroyable.lua

module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractDestroyable", package.seeall)

local Va3ChessInteractDestroyable = class("Va3ChessInteractDestroyable", Va3ChessInteractBase)

function Va3ChessInteractDestroyable:onAvatarLoaded()
	Va3ChessInteractDestroyable.super.onAvatarLoaded(self)

	local loader = self._target.avatar.loader

	if not loader then
		return
	end

	local go = loader:getInstGO()

	if not gohelper.isNil(go) then
		self._animSelf = go:GetComponent(typeof(UnityEngine.Animator))
	end

	self._target.interoperableFlag = gohelper.findChild(go, "icon")
end

local disappearAniName = "switch"

function Va3ChessInteractDestroyable:playDeleteObjView()
	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.BreakBoughs)

	if self._animSelf then
		self._animSelf:Play(disappearAniName)
	end
end

function Va3ChessInteractDestroyable:showStateView(objState, params)
	if objState == Va3ChessEnum.ObjState.Idle then
		self:showIdleStateView()
	elseif objState == Va3ChessEnum.ObjState.Interoperable then
		self:showInteroperableStateView(params)
	end
end

function Va3ChessInteractDestroyable:showIdleStateView()
	gohelper.setActive(self._target.interoperableFlag, false)
end

function Va3ChessInteractDestroyable:showInteroperableStateView(params)
	gohelper.setActive(self._target.interoperableFlag, true)
end

return Va3ChessInteractDestroyable
