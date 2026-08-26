-- chunkname: @modules/logic/chessgame/game/effect/ChessHeroEffect.lua

module("modules.logic.chessgame.game.effect.ChessHeroEffect", package.seeall)

local ChessHeroEffect = class("ChessHeroEffect", ChessEffectBase)

function ChessHeroEffect:refreshEffect()
	return
end

function ChessHeroEffect:onDispose()
	return
end

function ChessHeroEffect:onSelected()
	self._isSelected = true

	self:refreshPlayerSelected()
end

function ChessHeroEffect:onCancelSelect()
	self._isSelected = false

	self:refreshPlayerSelected()
end

function ChessHeroEffect:refreshPlayerSelected()
	if ChessGameController.instance:isTempSelectObj(self._target.id) then
		return
	end

	local showSelectableFlag = not self._isSelected

	gohelper.setActive(self._target.avatar.goSelectable, showSelectableFlag)
end

function ChessHeroEffect:onAvatarLoaded()
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

return ChessHeroEffect
