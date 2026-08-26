-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/effect/Va3ChessHeroEffect.lua

module("modules.logic.versionactivity1_3.va3chess.game.effect.Va3ChessHeroEffect", package.seeall)

local Va3ChessHeroEffect = class("Va3ChessHeroEffect", Va3ChessEffectBase)

function Va3ChessHeroEffect:refreshEffect()
	return
end

function Va3ChessHeroEffect:onDispose()
	return
end

function Va3ChessHeroEffect:onSelected()
	self._isSelected = true

	self:refreshPlayerSelected()
end

function Va3ChessHeroEffect:onCancelSelect()
	self._isSelected = false

	self:refreshPlayerSelected()
end

function Va3ChessHeroEffect:refreshPlayerSelected()
	if Va3ChessGameController.instance:isTempSelectObj(self._target.id) then
		return
	end

	local showSelectableFlag = not self._isSelected

	gohelper.setActive(self._target.avatar.goSelectable, showSelectableFlag)
end

function Va3ChessHeroEffect:onAvatarLoaded()
	local loader = self._loader

	if not self._loader then
		return
	end

	local go = loader:getInstGO()

	if not gohelper.isNil(go) then
		local goTracked = gohelper.findChild(go, "vx_tracked")
		local goSelectable = gohelper.findChild(go, "select")
		local goInteractEff = gohelper.findChild(go, "vx_daoju")

		gohelper.setActive(self._target.avatar.goTracked, false)
		gohelper.setActive(self._target.avatar.goInteractEff, false)
		gohelper.setActive(goTracked, false)
		gohelper.setActive(goSelectable, false)
		gohelper.setActive(goInteractEff, false)

		self._target.avatar.goTracked = goTracked
		self._target.avatar.goSelectable = goSelectable
		self._target.avatar.goInteractEff = goInteractEff
	end

	self:refreshPlayerSelected()
end

return Va3ChessHeroEffect
