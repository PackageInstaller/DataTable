-- chunkname: @modules/logic/scene/room/comp/RoomSceneLightComp.lua

module("modules.logic.scene.room.comp.RoomSceneLightComp", package.seeall)

local RoomSceneLightComp = class("RoomSceneLightComp", BaseSceneComp)

function RoomSceneLightComp:onInit()
	self._lightRangeId = UnityEngine.Shader.PropertyToID("_LightRange")
	self._lightOffsetId = UnityEngine.Shader.PropertyToID("_LightOffset")
	self._linghtMinId = UnityEngine.Shader.PropertyToID("_LightMin")
end

function RoomSceneLightComp:init(sceneId, levelId)
	self._scene = self:getCurScene()
	self._directionalLightGO = self._scene.go.directionalLightGO
	self._directionalLightGOTrs = self._directionalLightGO.transform
	self._directionalLight = self._directionalLightGO:GetComponent(typeof(UnityEngine.Light))
	self._initRotation = self._directionalLightGOTrs.rotation
	self._sceneAmbient = self._scene.go.sceneAmbient
	self._sceneAmbientData = self._scene.go.sceneAmbientData
	self._lightMinValue = self._sceneAmbientData.lightmin
end

function RoomSceneLightComp:_refreshLight()
	local cameraTrs = self._scene.camera.cameraTrs
	local rotationX, rotationY, rotationZ = transformhelper.getLocalRotation(cameraTrs)
	local rotateQuaternion = Quaternion.AngleAxis(rotationY, Vector3.up)

	self._directionalLightGOTrs.rotation = rotateQuaternion * self._initRotation
end

function RoomSceneLightComp:getLightColor()
	return self._directionalLight.color
end

function RoomSceneLightComp:setLightColor(color)
	self._directionalLight.color = color
end

function RoomSceneLightComp:getLightIntensity()
	return self._directionalLight.intensity
end

function RoomSceneLightComp:setLightIntensity(intensity)
	self._directionalLight.intensity = intensity
end

function RoomSceneLightComp:setLocalRotation(x, y, z)
	transformhelper.setLocalRotation(self._directionalLightGOTrs, x, y, z)
end

function RoomSceneLightComp:setLightMin(lightMin)
	if self._lightMinValue and self._lightMinValue ~= lightMin then
		self._lightMinValue = lightMin
		self._scene.go.sceneAmbientData.lightmin = lightMin
		self._sceneAmbient.data = self._scene.go.sceneAmbientData

		RoomHelper.setGlobalFloat(self._linghtMinId, lightMin)
	end
end

function RoomSceneLightComp:setLightRange(lightRange)
	return
end

function RoomSceneLightComp:setLightOffset(lightOffset)
	return
end

function RoomSceneLightComp:onSceneClose()
	self._lightMinValue = nil
	self._sceneAmbientData = nil
	self._sceneAmbient = nil
	self._directionalLightGOTrs = nil

	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, self._refreshLight, self)
end

return RoomSceneLightComp
