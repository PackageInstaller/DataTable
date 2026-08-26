-- chunkname: @modules/logic/scene/explore/comp/ExploreScenePPVolume.lua

module("modules.logic.scene.explore.comp.ExploreScenePPVolume", package.seeall)

local ExploreScenePPVolume = class("ExploreScenePPVolume", BaseSceneComp)

ExploreScenePPVolume.ExploreHighProfilePath = "ppassets/profiles/msts_profile_high.asset"
ExploreScenePPVolume.ExploreMiddleProfilePath = "ppassets/profiles/msts_profile_middle.asset"
ExploreScenePPVolume.ExploreLowProfilePath = "ppassets/profiles/msts_profile_low.asset"

function ExploreScenePPVolume:onSceneStart(sceneId, levelId)
	self:initPPVolume()
	self:_setCamera()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnQualityChange, self.updatePPLevel, self)
end

function ExploreScenePPVolume:initPPVolume()
	if self._ppVolumeGo then
		return
	end

	self._highProfile = ConstAbCache.instance:getRes(ExploreScenePPVolume.ExploreHighProfilePath)
	self._middleProfile = ConstAbCache.instance:getRes(ExploreScenePPVolume.ExploreMiddleProfilePath)
	self._lowProfile = ConstAbCache.instance:getRes(ExploreScenePPVolume.ExploreLowProfilePath)

	gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), false)

	self._ppVolumeGo = gohelper.create3d(CameraMgr.instance:getMainCameraGO(), "PPVolume")
	self._ppVolumeWrap = gohelper.onceAddComponent(self._ppVolumeGo, PostProcessingMgr.PPVolumeWrapType)

	self:updatePPLevel()
end

function ExploreScenePPVolume:_setCamera()
	local mainCameraGO = CameraMgr.instance:getMainCameraGO()
	local mainCustomCameraData = mainCameraGO:GetComponent(PostProcessingMgr.PPCustomCamDataType)

	self._originalusePostProcess = mainCustomCameraData.usePostProcess
	self._originalMainCameraVolumeTrigger = mainCustomCameraData.volumeTrigger
	mainCustomCameraData.usePostProcess = true
	mainCustomCameraData.volumeTrigger = self._ppVolumeGo.transform
end

function ExploreScenePPVolume:_resetCamera()
	local mainCameraGO = CameraMgr.instance:getMainCameraGO()
	local mainCustomCameraData = mainCameraGO:GetComponent(PostProcessingMgr.PPCustomCamDataType)

	mainCustomCameraData.usePostProcess = self._originalusePostProcess
	mainCustomCameraData.volumeTrigger = self._originalMainCameraVolumeTrigger
	self._originalusePostProcess = nil
	self._originalMainCameraVolumeTrigger = nil
end

function ExploreScenePPVolume:updatePPLevel()
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

function ExploreScenePPVolume:destoryPPVolume()
	if not self._ppVolumeGo then
		return
	end

	gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), true)
	gohelper.destroy(self._ppVolumeGo)

	self._ppVolumeGo = nil
	self._ppVolumeWrap = nil
	self._highProfile = nil
	self._middleProfile = nil
	self._lowProfile = nil
end

function ExploreScenePPVolume:onSceneClose()
	self:_resetCamera()
	self:destoryPPVolume()
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnQualityChange, self.updatePPLevel, self)
end

return ExploreScenePPVolume
