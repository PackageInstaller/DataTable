-- chunkname: @modules/logic/chessgame/game/effect/ChessEffectBase.lua

module("modules.logic.chessgame.game.effect.ChessEffectBase", package.seeall)

local ChessEffectBase = class("ChessEffectBase")

function ChessEffectBase:ctor(interactObj)
	self._target = interactObj
end

function ChessEffectBase:dispose()
	self:onDispose()

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	gohelper.destroy(self.effectGO)

	self.effectGO = nil
end

function ChessEffectBase:onDispose()
	return
end

function ChessEffectBase:onAvatarFinish(effectType)
	if self._isLoading then
		return
	end

	if not self.isLoadFinish then
		self._isLoading = true
		self.effectGO = UnityEngine.GameObject.New("effect_" .. effectType)
		self._loader = PrefabInstantiate.Create(self.effectGO)

		gohelper.addChild(self._target.avatar.effectNode, self.effectGO)
		transformhelper.setLocalPos(self.effectGO.transform, 0, 0, 0)
		transformhelper.setLocalScale(self.effectGO.transform, 0.8, 0.8, 0.8)

		local resPath = ChessGameEnum.ChessGameEnum.EffectPath[effectType]

		self._loader:startLoad(resPath, self.onSceneObjectLoadFinish, self)
	else
		gohelper.setActive(self.effectGO, true)
		ChessGameInteractModel.instance:setShowEffect(self._target.mo.id)
	end
end

function ChessEffectBase:onSceneObjectLoadFinish()
	if self._loader and self._loader:getInstGO() then
		self.isLoadFinish = true
		self._isLoading = false

		transformhelper.setLocalPos(self._loader:getInstGO().transform, 0, 0, 0)
		ChessGameInteractModel.instance:setShowEffect(self._target.mo.id)
		self:onAvatarLoaded()
	end
end

function ChessEffectBase:hideEffect()
	if self.effectGO then
		gohelper.setActive(self.effectGO, false)
		ChessGameInteractModel.instance:setHideEffect(self._target.mo.id)
	end
end

function ChessEffectBase:getIsLoadEffect()
	return self.isLoadFinish
end

function ChessEffectBase:onSelected()
	return
end

function ChessEffectBase:onCancelSelect()
	return
end

function ChessEffectBase:onAvatarLoaded()
	return
end

return ChessEffectBase
