-- chunkname: @modules/logic/scene/room/RoomScene.lua

module("modules.logic.scene.room.RoomScene", package.seeall)

local RoomScene = class("RoomScene", BaseScene)

function RoomScene:_createAllComps()
	self:_addComp("director", RoomSceneDirector)
	self:_addComp("tween", RoomSceneTweenComp)
	self:_addComp("timer", RoomSceneTimerComp)
	self:_addComp("init", RoomSceneInitComp)
	self:_addComp("level", RoomSceneLevelComp)
	self:_addComp("loader", RoomSceneLoader)
	self:_addComp("preloader", RoomScenePreloader)
	self:_addComp("bloom", RoomSceneBloomComp)
	self:_addComp("go", RoomSceneGOComp)
	self:_addComp("bending", RoomSceneBendingComp)
	self:_addComp("camera", RoomSceneCameraComp)
	self:_addComp("light", RoomSceneLightComp)
	self:_addComp("weather", RoomSceneWeatherComp)
	self:_addComp("ambient", RoomSceneAmbientComp)
	self:_addComp("mapmgr", RoomSceneMapEntityMgr)
	self:_addComp("inventorymgr", RoomSceneInventoryEntitySelectMgr)
	self:_addComp("buildingmgr", RoomSceneBuildingEntityMgr)
	self:_addComp("charactermgr", RoomSceneCharacterEntityMgr)
	self:_addComp("vehiclemgr", RoomSceneVehicleEntityMgr)
	self:_addComp("crittermgr", RoomSceneCritterEntityMgr)
	self:_addComp("buildingcrittermgr", RoomSceneBuildingCritterMgr)
	self:_addComp("sitemgr", RoomSceneTransportSiteEntityMgr)
	self:_addComp("ocean", RoomSceneOceanComp)
	self:_addComp("fog", RoomSceneFogComp)
	self:_addComp("fsm", RoomSceneFSMComp)
	self:_addComp("view", RoomSceneViewComp)
	self:_addComp("touch", RoomSceneTouchComp)
	self:_addComp("graphics", RoomSceneGraphicsComp)
	self:_addComp("character", RoomSceneCharacterComp)
	self:_addComp("fovblock", RoomSceneCameraFOVBlockComp)
	self:_addComp("path", RoomScenePathComp)
	self:_addComp("debug", RoomSceneDebugComp)
	self:_addComp("audio", RoomSceneAudioComp)
	self:_addComp("cameraFollow", RoomSceneCameraFollowComp)
end

RoomScene.UnitCameraKey = "RoomScene_UnitCameraKey"

function RoomScene:onStart(sceneId, levelId)
	RoomHelper.logElapse("RoomScene:onStart")
	GameResMgr:SetMaxFileLoadingCount(128)

	local mainCamera = CameraMgr.instance:getMainCamera()

	self._mainFarClipValue = mainCamera.farClipPlane
	self._mainNearClipValue = mainCamera.nearClipPlane

	CameraMgr.instance:setSceneCameraActive(false, RoomScene.UnitCameraKey)
	RoomScene.super.onStart(self, sceneId, levelId)
	self:initPPVolume()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnQualityChange, self.updatePPLevel, self)
end

function RoomScene:initPPVolume()
	if self._ppVolumeGo then
		return
	end

	self._highProfile = ConstAbCache.instance:getRes(RoomResourceEnum.PPVolume.High)
	self._middleProfile = ConstAbCache.instance:getRes(RoomResourceEnum.PPVolume.Middle)
	self._lowProfile = ConstAbCache.instance:getRes(RoomResourceEnum.PPVolume.Low)
	self._ppVolumeGo = gohelper.create3d(CameraMgr.instance:getMainCameraGO(), "PPVolume")
	self._ppVolumeWrap = gohelper.onceAddComponent(self._ppVolumeGo, PostProcessingMgr.PPVolumeWrapType)

	self:updatePPLevel()
end

function RoomScene:updatePPLevel()
	if not self._ppVolumeWrap then
		return
	end

	local grade = GameGlobalMgr.instance:getScreenState():getLocalQuality()
	local targetProfile = self._highProfile

	if grade == ModuleEnum.Performance.High then
		targetProfile = self._highProfile
	elseif grade == ModuleEnum.Performance.Middle then
		targetProfile = self._middleProfile
	elseif grade == ModuleEnum.Performance.Low then
		targetProfile = self._lowProfile
	end

	self._ppVolumeWrap:SetProfile(targetProfile)
end

function RoomScene:onClose()
	RoomHelper.logElapse("RoomScene:onClose")

	local gameScreenState = GameGlobalMgr.instance:getScreenState()

	gameScreenState:resetMaxFileLoadingCount()
	CameraMgr.instance:setSceneCameraActive(true, RoomScene.UnitCameraKey)
	RoomScene.super.onClose(self)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnQualityChange, self.updatePPLevel, self)
	self:destroyPPVolume()

	if self._mainFarClipValue then
		local mainCamera = CameraMgr.instance:getMainCamera()

		mainCamera.farClipPlane = self._mainFarClipValue
		mainCamera.nearClipPlane = self._mainNearClipValue
		self._mainFarClipValue = nil
		self._mainNearClipValue = nil
	end
end

function RoomScene:destroyPPVolume()
	if not self._ppVolumeGo then
		return
	end

	gohelper.destroy(self._ppVolumeGo)

	self._ppVolumeGo = nil
	self._ppVolumeWrap = nil
	self._highProfile = nil
	self._middleProfile = nil
	self._lowProfile = nil
end

return RoomScene
