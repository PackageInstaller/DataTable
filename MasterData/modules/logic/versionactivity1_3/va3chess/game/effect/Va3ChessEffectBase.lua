-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/effect/Va3ChessEffectBase.lua

module("modules.logic.versionactivity1_3.va3chess.game.effect.Va3ChessEffectBase", package.seeall)

local Va3ChessEffectBase = class("Va3ChessEffectBase")

function Va3ChessEffectBase:ctor(interactObj)
	self._target = interactObj
	self._effectCfg = self._target.effectCfg
end

function Va3ChessEffectBase:dispose()
	self:onDispose()

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	gohelper.destroy(self.effectGO)

	self.effectGO = nil
end

function Va3ChessEffectBase:onDispose()
	return
end

function Va3ChessEffectBase:onAvatarFinish()
	if self._effectCfg and not string.nilorempty(self._effectCfg.avatar) then
		self.effectGO = UnityEngine.GameObject.New("effect_" .. self._effectCfg.id)
		self._loader = PrefabInstantiate.Create(self.effectGO)

		gohelper.addChild(self._target.avatar.sceneGo, self.effectGO)

		local pointGO

		if self._target.avatar.loader and not string.nilorempty(self._effectCfg.piontName) then
			pointGO = gohelper.findChild(self._target.avatar.loader:getInstGO(), self._effectCfg.piontName)
		end

		if not gohelper.isNil(pointGO) then
			local posX, posY, posZ = transformhelper.getPos(pointGO.transform)

			transformhelper.setPos(self.effectGO.transform, posX, posY, posZ)
		else
			transformhelper.setLocalPos(self.effectGO.transform, 0, 0, 0)
		end

		local resPath = string.format(Va3ChessEnum.SceneResPath.AvatarItemPath, self._effectCfg.avatar)

		self._loader:startLoad(resPath, self.onSceneObjectLoadFinish, self)
	else
		self.isLoadFinish = true

		self:onAvatarLoaded()
		self:onCheckEffect()
	end
end

function Va3ChessEffectBase:onSceneObjectLoadFinish()
	if self._loader then
		self.isLoadFinish = true

		transformhelper.setLocalPos(self._loader:getInstGO().transform, 0, 0, 0)
		self:onAvatarLoaded()
		self:onCheckEffect()
	end
end

function Va3ChessEffectBase:onSelected()
	return
end

function Va3ChessEffectBase:onCancelSelect()
	return
end

function Va3ChessEffectBase:onAvatarLoaded()
	return
end

function Va3ChessEffectBase:onCheckEffect()
	if self._target then
		local originData = self._target.originData

		if originData and originData.data and originData.data.lostTarget ~= nil then
			self._target.effect:refreshSearchFailed()
			self._target.goToObject:refreshTarget()
		end

		self._target.goToObject:refreshSource()
	end
end

return Va3ChessEffectBase
