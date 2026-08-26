-- chunkname: @modules/logic/scene/udimo/scenecomp/UdimoSceneGraphicsComp.lua

module("modules.logic.scene.udimo.scenecomp.UdimoSceneGraphicsComp", package.seeall)

local UdimoSceneGraphicsComp = class("UdimoSceneGraphicsComp", BaseSceneComp)

function UdimoSceneGraphicsComp:onInit()
	return
end

function UdimoSceneGraphicsComp:init(sceneId, levelId)
	self._originalHDownTimes1 = PostProcessingMgr.instance:getUnitPPValue("ShadowMaskTexHDownTimes")
	self._originalHDownTimes2 = PostProcessingMgr.instance:getUnitPPValue("shadowMaskTexHDownTimes")

	PostProcessingMgr.instance:setUnitPPValue("ShadowMaskTexHDownTimes", 1)
	PostProcessingMgr.instance:setUnitPPValue("shadowMaskTexHDownTimes", 1)

	self._originalWDownTimes1 = PostProcessingMgr.instance:getUnitPPValue("ShadowMaskTexWDownTimes")
	self._originalWDownTimes2 = PostProcessingMgr.instance:getUnitPPValue("shadowMaskTexWDownTimes")

	PostProcessingMgr.instance:setUnitPPValue("ShadowMaskTexWDownTimes", 1)
	PostProcessingMgr.instance:setUnitPPValue("shadowMaskTexWDownTimes", 1)

	local mainCameraGO = CameraMgr.instance:getMainCameraGO()
	local mainCustomCameraData = mainCameraGO:GetComponent(PostProcessingMgr.PPCustomCamDataType)
	local unitCameraGO = CameraMgr.instance:getUnitCameraGO()
	local ppVolumeGo = gohelper.findChild(unitCameraGO, "PPVolume")

	if not gohelper.isNil(ppVolumeGo) then
		self._originalMainCameraVolumeTrigger = mainCustomCameraData.volumeTrigger
		mainCustomCameraData.volumeTrigger = ppVolumeGo.transform
	end

	self._originalUsePreProcess = mainCustomCameraData.usePreProcess
	mainCustomCameraData.usePreProcess = true
end

function UdimoSceneGraphicsComp:onSceneClose()
	if self._originalHDownTimes1 then
		PostProcessingMgr.instance:setUnitPPValue("ShadowMaskTexHDownTimes", self._originalHDownTimes1)
	end

	if self._originalHDownTimes2 then
		PostProcessingMgr.instance:setUnitPPValue("shadowMaskTexHDownTimes", self._originalHDownTimes2)
	end

	if self._originalWDownTimes1 then
		PostProcessingMgr.instance:setUnitPPValue("ShadowMaskTexWDownTimes", self._originalWDownTimes1)
	end

	if self._originalHDownTimes2 then
		PostProcessingMgr.instance:setUnitPPValue("shadowMaskTexWDownTimes", self._originalHDownTimes2)
	end

	local mainCameraGO = CameraMgr.instance:getMainCameraGO()
	local mainCustomCameraData = mainCameraGO:GetComponent(PostProcessingMgr.PPCustomCamDataType)

	mainCustomCameraData.volumeTrigger = self._originalMainCameraVolumeTrigger
	self._originalMainCameraVolumeTrigger = nil
	mainCustomCameraData.usePreProcess = self._originalUsePreProcess
	self._originalUsePreProcess = nil
end

return UdimoSceneGraphicsComp
