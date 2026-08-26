-- chunkname: @modules/logic/scene/survival/util/SurvivalSceneFogUtil.lua

module("modules.logic.scene.survival.util.SurvivalSceneFogUtil", package.seeall)

local SurvivalSceneFogUtil = class("SurvivalSceneFogUtil")

function SurvivalSceneFogUtil:loadFog(parent)
	if not self._fogLoader then
		local go = gohelper.create3d(parent, "Fog")

		self._fogLoader = PrefabInstantiate.Create(go)
	end

	self._fogLoader:dispose()
	self._fogLoader:startLoad(SurvivalSceneFogComp.FogResPath, self._onLoadFogEnd, self)
end

function SurvivalSceneFogUtil:unLoadFog()
	if self._fogLoader then
		self._fogLoader:dispose()

		self._fogLoader = nil
	end
end

function SurvivalSceneFogUtil:_onLoadFogEnd()
	TaskDispatcher.runDelay(self._delayDestroyFog, self, 0)
end

function SurvivalSceneFogUtil:_delayDestroyFog()
	self._fogLoader:dispose()
end

SurvivalSceneFogUtil.instance = SurvivalSceneFogUtil.New()

return SurvivalSceneFogUtil
