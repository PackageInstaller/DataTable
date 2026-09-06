-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/camera/CameraAdaptiveMgr.lua

module("logiccommon.common.camera.CameraAdaptiveMgr", package.seeall)

local CameraAdaptiveMgr = class("CameraAdaptiveMgr", BaseController)

function CameraAdaptiveMgr:ctor()
	self._adaptiveResolutionMap = {}
end

function CameraAdaptiveMgr:onInit()
	self:onReset()
end

function CameraAdaptiveMgr:onReset()
	self._adaptiveResolutionMap = {}
end

function CameraAdaptiveMgr:addAdaptiveResolution(camera)
	local insId = camera:GetInstanceID()

	self._adaptiveResolutionMap[insId] = camera
end

function CameraAdaptiveMgr:removeAdaptiveResolution(camera)
	local insId = camera:GetInstanceID()

	self._adaptiveResolutionMap[insId] = nil
end

function CameraAdaptiveMgr:adaptiveResolution()
	for k, camera in pairs(self._adaptiveResolutionMap) do
		CameraRectSetter.CalcRect(camera)
	end
end

CameraAdaptiveMgr.instance = CameraAdaptiveMgr.New()

return CameraAdaptiveMgr
