-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadCameraAni.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadCameraAni", package.seeall)

local FightPreloadCameraAni = class("FightPreloadCameraAni", BaseWork)

function FightPreloadCameraAni:onStart(context)
	if not GameResMgr.IsFromEditorDir then
		self._loader = MultiAbLoader.New()

		self._loader:addPath(ResUrl.getCameraAnimABUrl())
		self._loader:startLoad(self._onLoadFinish, self)
	else
		self:onDone(true)
	end
end

function FightPreloadCameraAni:_onLoadFinish(loader)
	self.context.callback(self.context.callbackObj, loader:getFirstAssetItem())
	self:onDone(true)
end

function FightPreloadCameraAni:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return FightPreloadCameraAni
