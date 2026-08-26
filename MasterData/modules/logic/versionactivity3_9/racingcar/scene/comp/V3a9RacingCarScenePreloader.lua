-- chunkname: @modules/logic/versionactivity3_9/racingcar/scene/comp/V3a9RacingCarScenePreloader.lua

module("modules.logic.versionactivity3_9.racingcar.scene.comp.V3a9RacingCarScenePreloader", package.seeall)

local V3a9RacingCarScenePreloader = class("V3a9RacingCarScenePreloader", BaseSceneComp)

V3a9RacingCarScenePreloader.OnPreloadFinish = 1
V3a9RacingCarScenePreloader.CameraAnim = "ui/animations/dynamic/v3a9_jingsu_sdx.controller"
V3a9RacingCarScenePreloader.Coin = "scenes/v3a9_m_s21_racing_games/scene/common/prefabs/v3a9_racing_games_props_b.prefab"
V3a9RacingCarScenePreloader.BoostPad = "scenes/v3a9_m_s21_racing_games/scene/common/prefabs/v3a9_racing_games_props_a.prefab"
V3a9RacingCarScenePreloader.GlideBoostPad = "scenes/v3a9_m_s21_racing_games/scene/common/prefabs/v3a9_racing_games_jiasumen_a.prefab"
V3a9RacingCarScenePreloader.GlideAirGuard = "scenes/v3a9_m_s21_racing_games/scene/common/prefabs/v3a9_racing_games_fengdao_a.prefab"
V3a9RacingCarScenePreloader.Obstacle = "scenes/v3a9_m_s21_racing_games/scene/common/prefabs/v3a9_racing_games_zhangai_a.prefab"
V3a9RacingCarScenePreloader.StartLine = "scenes/v3a9_m_s21_racing_games/scene/common/prefabs/v3a9_racing_games_qidian_a.prefab"
V3a9RacingCarScenePreloader.FinishLine = "scenes/v3a9_m_s21_racing_games/scene/common/prefabs/v3a9_racing_games_zhongdian_a.prefab"
V3a9RacingCarScenePreloader.ItemPickup = "scenes/v3a9_m_s21_racing_games/scene/common/prefabs/v3a9_racing_games_props_c.prefab"
V3a9RacingCarScenePreloader.ShortcutJumpPad = "scenes/v3a9_m_s21_racing_games/scene/common/prefabs/v3a9_racing_games_tiaotai_a.prefab"
V3a9RacingCarScenePreloader.WaterJet = "scenes/v3a9_m_s21_racing_games/scene/common/prefabs/v3a9_racing_games_pubu_a.prefab"
V3a9RacingCarScenePreloader.DaojuBig = "effects/prefabs/v3a9_jingsu/daoju_big.prefab"
V3a9RacingCarScenePreloader.DaojuSmall = "effects/prefabs/v3a9_jingsu/daoju_small.prefab"
V3a9RacingCarScenePreloader.HudunLoop = "effects/prefabs/v3a9_jingsu/hudun_loop.prefab"
V3a9RacingCarScenePreloader.ShuipaoLoop = "effects/prefabs/v3a9_jingsu/shuipao_loop.prefab"
V3a9RacingCarScenePreloader.ShuipaoOnce = "effects/prefabs/v3a9_jingsu/shuipao_once.prefab"
V3a9RacingCarScenePreloader.Suduxian = "effects/prefabs/v3a9_jingsu/suduxian.prefab"
V3a9RacingCarScenePreloader.SpecialTrackRecommendation = "effects/prefabs/v3a9_jingsu/paodao.prefab"
V3a9RacingCarScenePreloader.SpecialTrackRecommendationShort = "effects/prefabs/v3a9_jingsu/paodao2.prefab"
V3a9RacingCarScenePreloader.Tuowei = "effects/prefabs/v3a9_jingsu/tuowei.prefab"
V3a9RacingCarScenePreloader.Tuowei1 = "effects/prefabs/v3a9_jingsu/tuowei.prefab"
V3a9RacingCarScenePreloader.Tuowei2 = "effects/prefabs/v3a9_jingsu/tuowei_m.prefab"
V3a9RacingCarScenePreloader.Tuowei3 = "effects/prefabs/v3a9_jingsu/tuowei_l.prefab"
V3a9RacingCarScenePreloader.resList = {
	V3a9RacingCarScenePreloader.CameraAnim,
	V3a9RacingCarScenePreloader.Coin,
	V3a9RacingCarScenePreloader.BoostPad,
	V3a9RacingCarScenePreloader.GlideBoostPad,
	V3a9RacingCarScenePreloader.GlideAirGuard,
	V3a9RacingCarScenePreloader.Obstacle,
	V3a9RacingCarScenePreloader.StartLine,
	V3a9RacingCarScenePreloader.FinishLine,
	V3a9RacingCarScenePreloader.ItemPickup,
	V3a9RacingCarScenePreloader.ShortcutJumpPad,
	V3a9RacingCarScenePreloader.WaterJet,
	V3a9RacingCarScenePreloader.DaojuBig,
	V3a9RacingCarScenePreloader.DaojuSmall,
	V3a9RacingCarScenePreloader.HudunLoop,
	V3a9RacingCarScenePreloader.ShuipaoLoop,
	V3a9RacingCarScenePreloader.ShuipaoOnce,
	V3a9RacingCarScenePreloader.Suduxian,
	V3a9RacingCarScenePreloader.SpecialTrackRecommendation,
	V3a9RacingCarScenePreloader.SpecialTrackRecommendationShort
}

function V3a9RacingCarScenePreloader.getTuoweiPrefab()
	local quality = GameGlobalMgr.instance:getScreenState():getLocalQuality()

	if quality == ModuleEnum.Performance.High then
		return V3a9RacingCarScenePreloader.Tuowei1
	elseif quality == ModuleEnum.Performance.Middle then
		return V3a9RacingCarScenePreloader.Tuowei2
	elseif quality == ModuleEnum.Performance.Low then
		return V3a9RacingCarScenePreloader.Tuowei3
	end

	return V3a9RacingCarScenePreloader.Tuowei2
end

function V3a9RacingCarScenePreloader:onInit()
	self._preloadSequence = FlowSequence.New()

	self._preloadSequence:addWork(V3a9RacingCarScenePreloadGOWork.New())

	self._context = {}
	self._context.callback = self._onPreloadWorkDone
	self._context.callbackObj = self
end

function V3a9RacingCarScenePreloader:init(sceneId, levelId)
	self._assetItemDict = {}

	self._preloadSequence:registerDoneListener(self._onPreloadDone, self)
	self._preloadSequence:start(self._context)
end

function V3a9RacingCarScenePreloader:_onPreloadWorkDone(url, assetItem)
	self:addAssetItem(url, assetItem)
end

function V3a9RacingCarScenePreloader:addAssetItem(url, assetItem)
	if not self._assetItemDict[url] then
		self._assetItemDict[url] = assetItem

		assetItem:Retain()
	end
end

function V3a9RacingCarScenePreloader:_onPreloadDone()
	self:dispatchEvent(V3a9RacingCarScenePreloader.OnPreloadFinish)
end

function V3a9RacingCarScenePreloader:_getAssetItem(url)
	return self._assetItemDict and self._assetItemDict[url]
end

function V3a9RacingCarScenePreloader:onSceneClose()
	self._preloadSequence:unregisterDoneListener(self._onPreloadDone, self)
	self._preloadSequence:stop()

	if self._assetItemDict then
		for _, assetItem in pairs(self._assetItemDict) do
			assetItem:Release()
		end

		self._assetItemDict = nil
	end
end

function V3a9RacingCarScenePreloader:getResource(res)
	local assetItem = self:_getAssetItem((GameResMgr.IsFromEditorDir or nil) and res)

	if not assetItem then
		logError(string.format("V3a9RacingCarScenePreloader getResource 加载失败, res: %s", res))
	end

	if assetItem then
		return assetItem:GetResource(res)
	end
end

return V3a9RacingCarScenePreloader
