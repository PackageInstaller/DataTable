-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/effect/Va3ChessMonsterEffect.lua

module("modules.logic.versionactivity1_3.va3chess.game.effect.Va3ChessMonsterEffect", package.seeall)

local Va3ChessMonsterEffect = class("Va3ChessMonsterEffect", Va3ChessEffectBase)

function Va3ChessMonsterEffect:refreshEffect()
	return
end

function Va3ChessMonsterEffect:onDispose()
	return
end

function Va3ChessMonsterEffect:onAvatarLoaded()
	local loader = self._loader

	if not self._loader then
		return
	end

	local go = loader:getInstGO()

	if not gohelper.isNil(go) then
		local goTrack = gohelper.findChild(go, "vx_tracked")
		local goNumber = gohelper.findChild(go, "vx_number")
		local goTanhao = gohelper.findChild(go, "icon_tanhao")

		gohelper.setActive(self._target.avatar.goTrack, false)
		gohelper.setActive(goTrack, false)
		gohelper.setActive(goNumber, false)
		gohelper.setActive(goTanhao, false)

		self._target.avatar.goTrack = goTrack
		self._target.avatar.goNumber = goNumber
	end
end

return Va3ChessMonsterEffect
