-- chunkname: @modules/logic/scene/room/comp/RoomSceneBloomComp.lua

module("modules.logic.scene.room.comp.RoomSceneBloomComp", package.seeall)

local RoomSceneBloomComp = class("RoomSceneBloomComp", BaseSceneComp)

function RoomSceneBloomComp:onInit()
	self._originalBloomColor = nil
	self._originalBloomActive = nil
	self._originalBloomlocalActive = nil
	self._originalBloomIntensity = nil
	self._originalBloomThreshold = nil
	self._originalBloomDiffusion = nil
	self._originalBloomRTDownTimes = nil
	self._originalBloomPercent = nil
	self._originalMaskActive = nil
	self._originalMainCameraVolumeTrigger = nil
	self._originalMainCameraUsePostProcess = nil
	self._originalMainCameraVolumeMask = nil
end

function RoomSceneBloomComp:init(sceneId, levelId)
	local levelConfig = lua_scene_level.configDict[levelId]
	local screenState = GameGlobalMgr.instance:getScreenState()
	local grade = screenState.grade

	self._unitPPVolume = gohelper.findChildComponent(CameraMgr.instance:getMainCameraGO(), "PPVolume", PostProcessingMgr.PPVolumeWrapType)
	self._originalBloomColor = self:_getUnitPPValue("localBloomColor")

	self:_setUnitPPValue("localBloomColor", Color.New(levelConfig.bloomR, levelConfig.bloomG, levelConfig.bloomB, levelConfig.bloomA))

	self._originalBloomActive = self:_getUnitPPValue("bloomActive")

	self:_setUnitPPValue("bloomActive", levelConfig.useBloom == 1 and grade ~= ModuleEnum.Performance.Low)

	self._originalBloomlocalActive = self:_getUnitPPValue("localBloomActive")

	self:_setUnitPPValue("localBloomActive", false)

	self._originalBloomIntensity = self:_getUnitPPValue("bloomIntensity")

	self:_setUnitPPValue("bloomIntensity", 11)

	self._originalBloomThreshold = self:_getUnitPPValue("bloomThreshold")

	self:_setUnitPPValue("bloomThreshold", 1)

	self._originalBloomDiffusion = self:_getUnitPPValue("bloomDiffusion")

	self:_setUnitPPValue("bloomDiffusion", 4)

	self._originalBloomRTDownTimes = self:_getUnitPPValue("bloomRTDownTimes")

	self:_setUnitPPValue("bloomRTDownTimes", 1)

	self._originalBloomPercent = self:_getUnitPPValue("bloomPercent")

	self:_setUnitPPValue("bloomPercent", 1)

	self._originalMaskActive = self:_getUnitPPValue("localMaskActive")

	self:_setUnitPPValue("localMaskActive", false)
	self:_setUnitPPValue("LocalMaskActive", false)
	self:_setCamera()
end

function RoomSceneBloomComp:_setCamera()
	local mainCameraGO = CameraMgr.instance:getMainCameraGO()
	local mainCustomCameraData = mainCameraGO:GetComponent(PostProcessingMgr.PPCustomCamDataType)

	self._originalMainCameraVolumeTrigger = mainCustomCameraData.volumeTrigger

	if self._unitPPVolume then
		mainCustomCameraData.volumeTrigger = self._unitPPVolume.transform
	end

	self._originalMainCameraUsePostProcess = mainCustomCameraData.usePostProcess
	mainCustomCameraData.usePostProcess = true
	self._originalMainCameraVolumeMask = mainCustomCameraData.volumeMask
	mainCustomCameraData.volumeMask = LayerMask.GetMask("Unit")
end

function RoomSceneBloomComp:_setUnitPPValue(key, value)
	if self._unitPPVolume then
		self._unitPPVolume.refresh = true
		self._unitPPVolume[key] = value
	end
end

function RoomSceneBloomComp:_getUnitPPValue(key, value)
	if self._unitPPVolume then
		return self._unitPPVolume[key]
	end
end

function RoomSceneBloomComp:onSceneClose()
	if self._originalBloomColor ~= nil then
		self:_setUnitPPValue("localBloomColor", self._originalBloomColor)

		self._originalBloomColor = nil
	end

	if self._originalBloomActive ~= nil then
		self:_setUnitPPValue("bloomActive", self._originalBloomActive)

		self._originalBloomActive = nil
	end

	if self._originalBloomlocalActive ~= nil then
		self:_setUnitPPValue("localBloomActive", self._originalBloomlocalActive)

		self._originalBloomlocalActive = nil
	end

	if self._originalBloomIntensity ~= nil then
		self:_setUnitPPValue("bloomIntensity", self._originalBloomIntensity)

		self._originalBloomIntensity = nil
	end

	if self._originalBloomThreshold ~= nil then
		self:_setUnitPPValue("bloomThreshold", self._originalBloomThreshold)

		self._originalBloomThreshold = nil
	end

	if self._originalBloomDiffusion ~= nil then
		self:_setUnitPPValue("bloomDiffusion", self._originalBloomDiffusion)

		self._originalBloomDiffusion = nil
	end

	if self._originalBloomRTDownTimes ~= nil then
		self:_setUnitPPValue("bloomRTDownTimes", self._originalBloomRTDownTimes)

		self._originalBloomRTDownTimes = nil
	end

	if self._originalBloomPercent ~= nil then
		self:_setUnitPPValue("bloomPercent", self._originalBloomPercent)

		self._originalBloomPercent = nil
	end

	if self._originalMaskActive ~= nil then
		self:_setUnitPPValue("localMaskActive", self._originalMaskActive)
		self:_setUnitPPValue("LocalMaskActive", self._originalMaskActive)

		self._originalMaskActive = nil
	end

	self:_resetCamera()

	self._unitPPVolume = nil
end

function RoomSceneBloomComp:_resetCamera()
	local mainCameraGO = CameraMgr.instance:getMainCameraGO()
	local mainCustomCameraData = mainCameraGO:GetComponent(PostProcessingMgr.PPCustomCamDataType)

	mainCustomCameraData.volumeTrigger = self._originalMainCameraVolumeTrigger
	mainCustomCameraData.usePostProcess = self._originalMainCameraUsePostProcess
	mainCustomCameraData.volumeMask = self._originalMainCameraVolumeMask
end

return RoomSceneBloomComp
