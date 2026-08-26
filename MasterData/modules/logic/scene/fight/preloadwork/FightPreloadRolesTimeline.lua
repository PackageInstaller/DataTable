-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadRolesTimeline.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadRolesTimeline", package.seeall)

local FightPreloadRolesTimeline = class("FightPreloadRolesTimeline", BaseWork)

function FightPreloadRolesTimeline:onStart(context)
	if not GameResMgr.IsFromEditorDir then
		self._loader = MultiAbLoader.New()

		self._loader:addPath(ResUrl.getRolesTimeline())
		self._loader:startLoad(self._onLoadFinish, self)
	else
		self:onDone(true)
	end
end

function FightPreloadRolesTimeline:_onLoadFinish(roles_time_loader)
	self.context.callback(self.context.callbackObj, roles_time_loader:getFirstAssetItem())
	self:onDone(true)
end

function FightPreloadRolesTimeline:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return FightPreloadRolesTimeline
