-- chunkname: @modules/logic/scene/explore/comp/ExploreScenePreloader.lua

module("modules.logic.scene.explore.comp.ExploreScenePreloader", package.seeall)

local ExploreScenePreloader = class("ExploreScenePreloader", BaseSceneComp)
local Type_Shader_Variant = typeof(UnityEngine.ShaderVariantCollection)
local ShaderPaths = {
	[ModuleEnum.Performance.High] = "modules/explore/shaders/svc_high.shadervariants",
	[ModuleEnum.Performance.Middle] = "modules/explore/shaders/svc_medium.shadervariants",
	[ModuleEnum.Performance.Low] = "modules/explore/shaders/svc_low.shadervariants"
}

function ExploreScenePreloader:init(sceneId, levelId)
	self._loader = SequenceAbLoader.New()

	self._loader:addPath(ResUrl.getExploreEffectPath(ExploreConstValue.ClickEffect))
	self._loader:addPath(ResUrl.getExploreEffectPath(ExploreConstValue.PlaceEffect))
	self._loader:addPath(ResUrl.getExploreEffectPath(ExploreConstValue.MapLightEffect))

	if not GameResMgr.IsFromEditorDir then
		self._loader:addPath(ShaderPaths[ModuleEnum.Performance.High])
	end

	self._loader:setConcurrentCount(10)
	self._loader:startLoad(self._onPreloadFinish, self)
end

function ExploreScenePreloader:getResByPath(path)
	local assetItem = self._loader:getAssetItem(path)

	if not assetItem or not assetItem.IsLoadSuccess then
		logError("资源加载失败 。。。 " .. path)

		return
	end

	return assetItem:GetResource()
end

function ExploreScenePreloader:_onPreloadFinish()
	if not GameResMgr.IsFromEditorDir then
		self:warmupShader()
	end

	self:dispatchEvent(ExploreEvent.OnExplorePreloadFinish)
end

function ExploreScenePreloader:warmupShader()
	if not GameResMgr.IsFromEditorDir then
		local assetItem = self._loader:getAssetItem(ShaderPaths[ModuleEnum.Performance.High])
		local quality = GameGlobalMgr.instance:getScreenState():getLocalQuality()
		local resVersion = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr
		local str = PlayerPrefsHelper.getString(PlayerPrefsKey.ExploreShaderWarmupVersion, "")
		local allPreWarm = {}

		if string.find(str, "^%[") then
			allPreWarm = cjson.decode(str)
		end

		if allPreWarm[1] ~= resVersion then
			allPreWarm = {
				resVersion
			}
		end

		if not tabletool.indexOf(allPreWarm, ShaderPaths[quality]) then
			if isDebugBuild then
				SLFramework.TimeWatch.Instance:Start()
				logWarn("开始密室Shader预热 。。。 ")
			end

			if assetItem and assetItem.IsLoadSuccess then
				local shader = assetItem:GetResource(ShaderPaths[quality], Type_Shader_Variant)

				if shader then
					shader:WarmUp()
				end
			end

			table.insert(allPreWarm, ShaderPaths[quality])
			PlayerPrefsHelper.setString(PlayerPrefsKey.ExploreShaderWarmupVersion, cjson.encode(allPreWarm))

			if isDebugBuild then
				logWarn("密室Shader预热结束 。。。 " .. SLFramework.TimeWatch.Instance:Watch())
			end
		end
	end
end

function ExploreScenePreloader:onSceneClose(sceneId, levelId)
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return ExploreScenePreloader
