-- chunkname: @modules/logic/scene/room/comp/RoomScenePreloader.lua

module("modules.logic.scene.room.comp.RoomScenePreloader", package.seeall)

local RoomScenePreloader = class("RoomScenePreloader", BaseSceneComp)

RoomScenePreloader.OnPreloadFinish = 1
RoomScenePreloader.ResDebugPackageUI = "ui/viewres/room/debug/roomdebugpackageui.prefab"
RoomScenePreloader.ResEffectB = "scenes/m_s07_xiaowu/prefab/effects/effects_b.prefab"
RoomScenePreloader.ResEffectE = "scenes/m_s07_xiaowu/prefab/effects/effects_e.prefab"
RoomScenePreloader.ResEffectF = "scenes/m_s07_xiaowu/prefab/effects/effects_f.prefab"
RoomScenePreloader.ResEffectD01 = "scenes/m_s07_xiaowu/prefab/effects/effects_d01.prefab"
RoomScenePreloader.ResEffectD02 = "scenes/m_s07_xiaowu/prefab/effects/effects_d02.prefab"
RoomScenePreloader.ResEffectD03 = "scenes/m_s07_xiaowu/prefab/effects/effects_d03.prefab"
RoomScenePreloader.ResEffectD04 = "scenes/m_s07_xiaowu/prefab/effects/effects_d04.prefab"
RoomScenePreloader.ResEffectD05 = "scenes/m_s07_xiaowu/prefab/effects/effects_d05.prefab"
RoomScenePreloader.ResEffectD06 = "scenes/m_s07_xiaowu/prefab/effects/effects_d06.prefab"
RoomScenePreloader.ResEffectBlue01 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_blue_01.prefab"
RoomScenePreloader.ResEffectBlue02 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_blue_02.prefab"
RoomScenePreloader.ResEffectGreen01 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_green_01.prefab"
RoomScenePreloader.ResEffectGreen02 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_green_02.prefab"
RoomScenePreloader.ResEffectYellow01 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_yellow_01.prefab"
RoomScenePreloader.ResEffectYellow02 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_yellow_02.prefab"
RoomScenePreloader.ResEffectRed01 = "scenes/m_s07_xiaowu/prefab/effects/effect_transport_red_01.prefab"
RoomScenePreloader.ResVXPlacingHere = "scenes/m_s07_xiaowu/prefab/vx/vx_placinghere.prefab"
RoomScenePreloader.ResSmoke = "scenes/m_s07_xiaowu/prefab/vx/smoke.prefab"
RoomScenePreloader.ResSmokeSnow = "scenes/m_s07_xiaowu/prefab/vx/v1a8_wl/v1a8_smoke.prefab"
RoomScenePreloader.BlockTypeSmokeDict = {
	[15] = RoomScenePreloader.ResSmokeSnow,
	[16] = RoomScenePreloader.ResSmokeSnow
}
RoomScenePreloader.ResVXXuXian = "scenes/m_s07_xiaowu/prefab/vx/vx_xuxian.prefab"
RoomScenePreloader.ResVXWater = "scenes/m_s07_xiaowu/prefab/vx/vx_water.prefab"
RoomScenePreloader.ResInitBuilding = "scenes/m_s07_xiaowu/prefab/jianzhu/a_rukou/rukou.prefab"
RoomScenePreloader.ResCharacterClickHelper = "scenes/m_s07_xiaowu/prefab/characterclickhelper.prefab"
RoomScenePreloader.DefaultLand = "scenes/m_s07_xiaowu/prefab/ground/floor/01.prefab"
RoomScenePreloader.InitLand = "scenes/m_s07_xiaowu/prefab/ground/floor/02.prefab"
RoomScenePreloader.LandAB = "scenes/m_s07_xiaowu/prefab/ground"
RoomScenePreloader.ReplaceLand = "scenes/m_s07_xiaowu/prefab/ground/floor/01b.prefab"
RoomScenePreloader.ResFogParticle = "scenes/m_s07_xiaowu/a_fufeice/prefab/bxhy_fogparticle.prefab"
RoomScenePreloader.DiffuseGI = "scenes/m_s07_xiaowu/prefab/diffuse_gi.prefab"
RoomScenePreloader.ResEffectWaveList = {
	"scenes/m_s07_xiaowu/prefab/effects/bolang01.prefab",
	"scenes/m_s07_xiaowu/prefab/effects/bolang02.prefab",
	"scenes/m_s07_xiaowu/prefab/effects/bolang03.prefab",
	"scenes/m_s07_xiaowu/prefab/effects/bolang04.prefab",
	"scenes/m_s07_xiaowu/prefab/effects/bolang05.prefab",
	"scenes/m_s07_xiaowu/prefab/effects/bolang06.prefab"
}
RoomScenePreloader.ResEffectWaveWithRiverList = {
	"scenes/m_s07_xiaowu/prefab/ground/floor_water/effects/bolang01.prefab",
	"scenes/m_s07_xiaowu/prefab/ground/floor_water/effects/bolang02.prefab",
	"scenes/m_s07_xiaowu/prefab/ground/floor_water/effects/bolang03.prefab",
	"scenes/m_s07_xiaowu/prefab/ground/floor_water/effects/bolang04.prefab",
	"scenes/m_s07_xiaowu/prefab/ground/floor_water/effects/bolang05.prefab",
	"scenes/m_s07_xiaowu/prefab/ground/floor_water/effects/bolang06.prefab"
}
RoomScenePreloader.ResResourceColorDict = {
	[RoomResourceEnum.ResourceId.Plant] = "scenes/m_s07_xiaowu/prefab/effects/effect_similar_02.prefab",
	[RoomResourceEnum.ResourceId.Building] = "scenes/m_s07_xiaowu/prefab/effects/effect_similar_04.prefab",
	[RoomResourceEnum.ResourceId.Sculpture] = "scenes/m_s07_xiaowu/prefab/effects/effect_similar_03.prefab",
	[RoomResourceEnum.ResourceId.River] = "scenes/m_s07_xiaowu/prefab/effects/effect_similar_01.prefab"
}
RoomScenePreloader.ResResourceVehicleDict = {
	[RoomResourceEnum.ResourceId.River] = "scenes/m_s07_xiaowu/prefab/building/building_xiaochuan.prefab",
	[RoomResourceEnum.ResourceId.Road] = "scenes/m_s07_xiaowu/prefab/building/terrain_dabache_a.prefab",
	[RoomResourceEnum.ResourceId.Railway] = "scenes/m_s07_xiaowu/prefab/building/terrain_dabache_a.prefab"
}
RoomScenePreloader.ResDebugPackageColorOther = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage_other.prefab"
RoomScenePreloader.ResDebugPackageColorDict = {
	[-2] = RoomScenePreloader.ResDebugPackageColorOther,
	[RoomResourceEnum.ResourceId.Empty] = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage.prefab",
	[RoomResourceEnum.ResourceId.None] = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage_0.prefab",
	[RoomResourceEnum.ResourceId.Plant] = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage_2.prefab",
	[RoomResourceEnum.ResourceId.Building] = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage_4.prefab",
	[RoomResourceEnum.ResourceId.Sculpture] = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage_3.prefab",
	[RoomResourceEnum.ResourceId.River] = "scenes/m_s07_xiaowu/prefab/effects/effect_debugpackage_1.prefab"
}
RoomScenePreloader.ResCharacterFaithMax = "scenes/m_s07_xiaowu/prefab/effects/bxhy_effect_icon_a.prefab"
RoomScenePreloader.ResCharacterFaithFull = "scenes/m_s07_xiaowu/prefab/effects/bxhy_effect_icon_b.prefab"
RoomScenePreloader.ResCharacterFaithNormal = "scenes/m_s07_xiaowu/prefab/effects/bxhy_effect_icon_c.prefab"
RoomScenePreloader.ResCharacterChat = "scenes/m_s07_xiaowu/prefab/effects/bxhy_effect_icon_e.prefab"
RoomScenePreloader.ResCommonList = {
	RoomScenePreloader.ResCharacterFaithMax,
	RoomScenePreloader.ResCharacterFaithFull,
	RoomScenePreloader.ResCharacterFaithNormal,
	RoomScenePreloader.ResCharacterChat
}
RoomScenePreloader.ResAnim = {
	Inventory = "scenes/dynamic/m_s07_xiaowu/anim/vx/inventory.controller",
	PlaceCharacter = "scenes/dynamic/m_s07_xiaowu/anim/vx/vx_renwu.controller",
	ContainerUp = "scenes/dynamic/m_s07_xiaowu/anim/vx/container_up.controller",
	ContainerPlay = "scenes/dynamic/m_s07_xiaowu/anim/vx/container_play.controller",
	PressingCharacter = "scenes/dynamic/m_s07_xiaowu/anim/vx/renwutuodong.controller"
}
RoomScenePreloader.ResOcean = "scenes/m_s07_xiaowu/prefab/ground/water/ocean.prefab"
RoomScenePreloader.ResEffectConfirmCharacter = "scenes/m_s07_xiaowu/prefab/vx/renwurukou.prefab"
RoomScenePreloader.ResEffectCharacterShadow = "scenes/m_s07_xiaowu/prefab/character/shadow.prefab"
RoomScenePreloader.ResEffectPressingCharacter = "scenes/m_s07_xiaowu/prefab/vx/temp_tuodongjuese.prefab"
RoomScenePreloader.ResEffectPlaceCharacter = "scenes/m_s07_xiaowu/prefab/vx/vx_men.prefab"
RoomScenePreloader.ResCharacterFaithEffect = "scenes/m_s07_xiaowu/prefab/vx/vx_friend.prefab"
RoomScenePreloader.ResCharacterClickEffect = "scenes/m_s07_xiaowu/prefab/vx/vx_click.prefab"
RoomScenePreloader.ResEquipRoomSkinEffect = "scenes/m_s07_xiaowu/prefab/vx/v1a9_changeskin/v1a9_changeskin1.prefab"
RoomScenePreloader.RecCharacterBirthdayEffect = "scenes/m_s07_xiaowu/prefab/vx/meeting_years_fireworks.prefab"
RoomScenePreloader.CritterBuildingSeatSlot = "scenes/m_s07_xiaowu/prefab/vx/v2a2_lock/v2a2_lock_22101_seat.prefab"
RoomScenePreloader.ResCritterEvent = {
	SurpriseCollect = "scenes/m_s07_xiaowu/prefab/ui/mapbubble4.prefab",
	TrainEventComplete = "scenes/m_s07_xiaowu/prefab/ui/mapbubble2.prefab",
	HasTrainEvent = "scenes/m_s07_xiaowu/prefab/ui/mapbubble1.prefab",
	NoMoodWork = "scenes/m_s07_xiaowu/prefab/ui/mapbubble3.prefab"
}

function RoomScenePreloader:onInit()
	self._preloadSequence = FlowSequence.New()

	if RoomController.instance:isEditorMode() then
		self._preloadSequence:addWork(RoomPreloadMapBlockWork.New())
		self._preloadSequence:addWork(RoomPreloadUIWork.New())
	end

	self._preloadSequence:addWork(RoomPreloadGOWork.New())
	self._preloadSequence:addWork(RoomPreloadAnimWork.New())

	if RoomController.instance:isEditorMode() then
		self._preloadSequence:addWork(RoomPreloadBuildingWork.New())
		self._preloadSequence:addWork(RoomPreloadBlockPackageWork.New())
	end

	self._context = {}
	self._context.callback = self._onPreloadWorkDone
	self._context.callbackObj = self
	self._initialized = false

	GameSceneMgr.instance:registerCallback(SceneEventName.ExitScene, self._onExitScene, self)
end

function RoomScenePreloader:_onExitScene(curSceneType, curSceneId, nextSceneType)
	if not nextSceneType or nextSceneType ~= SceneType.Room then
		self:_releaseAssetItemDict(self._preAssetItemDict)

		self._preAssetItemDict = nil
	end
end

function RoomScenePreloader:init(sceneId, levelId)
	self._initialized = true
	self._context.poolGODict = {}
	self._context.resABDict = {}
	self._context.poolUIDict = {}
	self._assetItemDict = self._assetItemDict or {}
	self._assetItemTimeDict = self._assetItemTimeDict or {}

	self._preloadSequence:registerDoneListener(self._onPreloadDone, self)
	self._preloadSequence:start(self._context)
end

function RoomScenePreloader:_onPreloadWorkDone(url, assetItem)
	self:addAssetItem(url, assetItem)
end

function RoomScenePreloader:_loadAssetsCb(assetItem)
	return
end

function RoomScenePreloader:addAssetItem(url, assetItem)
	if not self._initialized then
		return
	end

	if not self._assetItemDict[url] then
		self._assetItemTimeDict[url] = Time.time

		local tempAsset = RoomAssetItem.New()

		tempAsset:init(assetItem, url)

		self._assetItemDict[url] = tempAsset

		tempAsset:Retain()
	end
end

function RoomScenePreloader:_onPreloadDone()
	self:_releaseAssetItemDict(self._preAssetItemDict)

	self._preAssetItemDict = nil

	self:_initPools()
	self:dispatchEvent(RoomScenePreloader.OnPreloadFinish)
end

function RoomScenePreloader:_getAssetItem(url)
	return self._assetItemDict and self._assetItemDict[url]
end

function RoomScenePreloader:onSceneClose()
	self._initialized = false

	self._preloadSequence:unregisterDoneListener(self._onPreloadDone, self)
	self._preloadSequence:stop()
	self:disposePools()
	self:_releaseAssetItemDict(self._preAssetItemDict)

	self._preAssetItemDict = nil
	self._preAssetItemDict = self._assetItemDict
	self._assetItemDict = nil
end

function RoomScenePreloader:_releaseAssetItemDict(assetItemDict)
	if assetItemDict then
		for url, assetItem in pairs(assetItemDict) do
			assetItem:Release()
		end
	end
end

function RoomScenePreloader:getResource(res, ab)
	local assetItem = self:_getAssetItem((GameResMgr.IsFromEditorDir or nil) and res)

	if not assetItem then
		-- block empty
	end

	if assetItem then
		return assetItem:GetResource(res)
	end
end

function RoomScenePreloader:_initPools()
	if not self._poolInitialized then
		self._poolInitialized = true

		RoomUIPool.init({})
		RoomGOPool.init({}, {})
	end
end

function RoomScenePreloader:disposePools()
	self._poolInitialized = false

	RoomUIPool.dispose()
	RoomGOPool.dispose()
end

function RoomScenePreloader:clearPools()
	if not self._initialized then
		return
	end

	RoomGOPool.clearPool()

	local curTime = Time.time - 1

	for abPath, assetItem in pairs(self._assetItemDict) do
		if not self._assetItemTimeDict[abPath] then
			if self._assetItemTimeDict[abPath] < curTime and assetItem and RoomGOPool.existABPath(abPath) == false then
				self._assetItemDict[abPath] = nil
				self._assetItemTimeDict[abPath] = 0

				assetItem:Release()
			end
		end
	end
end

function RoomScenePreloader:exist(abPath)
	local assetItem = self:_getAssetItem(abPath)

	return not not assetItem
end

return RoomScenePreloader
