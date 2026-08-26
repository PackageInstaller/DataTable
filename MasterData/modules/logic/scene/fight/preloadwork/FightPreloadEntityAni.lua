-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadEntityAni.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadEntityAni", package.seeall)

local FightPreloadEntityAni = class("FightPreloadEntityAni", BaseWork)

function FightPreloadEntityAni:onStart(context)
	if not GameResMgr.IsFromEditorDir then
		self._loader = MultiAbLoader.New()

		self._loader:addPath(ResUrl.getEntityAnimABUrl())
		self._loader:startLoad(self._onLoadFinish, self)
	else
		self:onDone(true)
	end
end

function FightPreloadEntityAni:_onLoadFinish(loader)
	self.context.callback(self.context.callbackObj, loader:getFirstAssetItem())
	self:onDone(true)
end

function FightPreloadEntityAni:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return FightPreloadEntityAni
