-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/interacts/Va3ChessInteractBrazier.lua

module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractBrazier", package.seeall)

local Va3ChessInteractBrazier = class("Va3ChessInteractBrazier", Va3ChessInteractBase)

function Va3ChessInteractBrazier:onAvatarLoaded()
	Va3ChessInteractBrazier.super.onAvatarLoaded(self)

	local loader = self._target.avatar.loader

	if not loader then
		return
	end

	local go = loader:getInstGO()

	if not gohelper.isNil(go) then
		self._goFire = gohelper.findChild(go, "huopeng_fire")
	end

	self:refreshBrazier()
end

function Va3ChessInteractBrazier:refreshBrazier()
	if not gohelper.isNil(self._goFire) then
		gohelper.setActive(self._goFire, (self._target.originData or nil) and self._target.originData:getBrazierIsLight())
	end
end

return Va3ChessInteractBrazier
