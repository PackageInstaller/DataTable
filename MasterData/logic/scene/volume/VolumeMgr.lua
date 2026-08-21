-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/volume/VolumeMgr.lua

module("logic.scene.volume.VolumeMgr", package.seeall)

local VolumeMgr = class("VolumeMgr")
local MAX_COUNT = 5
local kUICamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
local kUICameraAdditionalData = goutil.addComponentOnce(kUICamera.gameObject, ComponentType.UniversalAdditionalCameraData)

function VolumeMgr:ctor()
	self._volumeTable = {}

	VolumeUnit:preparePool(MAX_COUNT)
end

function VolumeMgr:turnOn(volumeName, func, funcHandle)
	if string.nilorempty(volumeName) then
		return
	end

	return self:_turnOn(volumeName, func, funcHandle)
end

function VolumeMgr:turnOff(volumeName)
	self:_turnOff(volumeName)
end

function VolumeMgr:turnOnUIPostProcessing(volumeName)
	return self:_turnOn(volumeName)
end

function VolumeMgr:turnOffUIPostProcessing(volumeName)
	self:_turnOff(volumeName)
end

function VolumeMgr:setUICameraPostProcessingEnable(enable)
	kUICameraAdditionalData.renderPostProcessing = enable
end

function VolumeMgr:setPosition(volumeName, x, y, z)
	local volumeUnit = self._volumeTable[volumeName]

	if volumeUnit then
		volumeUnit:setPosition(x, y, z)
	end
end

function VolumeMgr:_turnOn(volumeName, func, funcHandle)
	local volumeUnit = self._volumeTable[volumeName]

	if volumeUnit then
		if enableWarnLog then
			printWarn("VolumeMgr::volume effect already turn on", volumeName)
		end

		if func then
			func(funcHandle, volumeUnit)
		end

		return volumeUnit
	end

	volumeUnit = VolumeUnit:createInstance()

	volumeUnit:setCallBack(func, funcHandle)
	volumeUnit:load(GameUrl.getVolumeUrl(volumeName))

	self._volumeTable[volumeName] = volumeUnit

	return volumeUnit
end

function VolumeMgr:_turnOff(volumeName)
	local volumeUnit = self._volumeTable[volumeName]

	if not volumeUnit then
		return
	end

	volumeUnit:returnSelf()

	self._volumeTable[volumeName] = nil
end

VolumeMgr.instance = VolumeMgr.New()

return VolumeMgr
