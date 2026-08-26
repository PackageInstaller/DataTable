-- chunkname: @modules/logic/scene/survival/comp/SurvivalScenePPVolume.lua

module("modules.logic.scene.survival.comp.SurvivalScenePPVolume", package.seeall)

local SurvivalScenePPVolume = class("SurvivalScenePPVolume", BaseSceneComp)

SurvivalScenePPVolume.HighProfilePath = RoomResourceEnum.PPVolume.High
SurvivalScenePPVolume.MiddleProfilePath = RoomResourceEnum.PPVolume.Middle
SurvivalScenePPVolume.LowProfilePath = RoomResourceEnum.PPVolume.Low
SurvivalScenePPVolume.UnitCameraKey = "SurvivalScene_UnitCameraKey"

function SurvivalScenePPVolume:onSceneStart(sceneId, levelId)
	self:initPPVolume()
	self:_setCamera()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnQualityChange, self.updatePPLevel, self)
end

function SurvivalScenePPVolume:initPPVolume()
	if self._ppVolumeGo then
		return
	end

	self._highProfile = ConstAbCache.instance:getRes(SurvivalScenePPVolume.HighProfilePath)
	self._middleProfile = ConstAbCache.instance:getRes(SurvivalScenePPVolume.MiddleProfilePath)
	self._lowProfile = ConstAbCache.instance:getRes(SurvivalScenePPVolume.LowProfilePath)

	CameraMgr.instance:setSceneCameraActive(false, SurvivalScenePPVolume.UnitCameraKey)

	self._ppVolumeGo = gohelper.create3d(CameraMgr.instance:getMainCameraGO(), "PPVolume")
	self._ppVolumeWrap = gohelper.onceAddComponent(self._ppVolumeGo, PostProcessingMgr.PPVolumeWrapType)

	self:updatePPLevel()
end

function SurvivalScenePPVolume:_setCamera()
	local mainCameraGO = CameraMgr.instance:getMainCameraGO()
	local mainCustomCameraData = mainCameraGO:GetComponent(PostProcessingMgr.PPCustomCamDataType)

	self._originalusePostProcess = mainCustomCameraData.usePostProcess
	self._originalMainCameraVolumeTrigger = mainCustomCameraData.volumeTrigger
	mainCustomCameraData.usePostProcess = true
	mainCustomCameraData.volumeTrigger = self._ppVolumeGo.transform
end

function SurvivalScenePPVolume:_resetCamera()
	local mainCameraGO = CameraMgr.instance:getMainCameraGO()
	local mainCustomCameraData = mainCameraGO:GetComponent(PostProcessingMgr.PPCustomCamDataType)

	mainCustomCameraData.usePostProcess = self._originalusePostProcess
	mainCustomCameraData.volumeTrigger = self._originalMainCameraVolumeTrigger
	self._originalusePostProcess = nil
	self._originalMainCameraVolumeTrigger = nil
end

function SurvivalScenePPVolume:updatePPLevel()
	if not self._ppVolumeWrap then
		return
	end

	local grade = GameGlobalMgr.instance:getScreenState():getLocalQuality()
	local targetProfile = self._highProfile
	local mainCameraGO = CameraMgr.instance:getMainCameraGO()

	if grade == ModuleEnum.Performance.High then
		targetProfile = self._highProfile
	elseif grade == ModuleEnum.Performance.Middle then
		targetProfile = self._middleProfile
	elseif grade == ModuleEnum.Performance.Low then
		targetProfile = self._lowProfile
	end

	self._ppVolumeWrap:SetProfile(targetProfile)
end

function SurvivalScenePPVolume:destoryPPVolume()
	if not self._ppVolumeGo then
		return
	end

	CameraMgr.instance:setSceneCameraActive(true, SurvivalScenePPVolume.UnitCameraKey)
	gohelper.destroy(self._ppVolumeGo)

	self._ppVolumeGo = nil
	self._ppVolumeWrap = nil
	self._highProfile = nil
	self._middleProfile = nil
	self._lowProfile = nil
end

function SurvivalScenePPVolume:onSceneClose()
	self:_resetCamera()
	self:destoryPPVolume()
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnQualityChange, self.updatePPLevel, self)
end

return SurvivalScenePPVolume
