-- chunkname: @modules/logic/scene/room/comp/RoomSceneOceanComp.lua

module("modules.logic.scene.room.comp.RoomSceneOceanComp", package.seeall)

local RoomSceneOceanComp = class("RoomSceneOceanComp", BaseSceneComp)

function RoomSceneOceanComp:onInit()
	return
end

function RoomSceneOceanComp:init(sceneId, levelId)
	self._scene = self:getCurScene()

	self._scene.loader:makeSureLoaded({
		RoomScenePreloader.ResOcean
	}, self._OnGetInstance, self)
end

function RoomSceneOceanComp:_OnGetInstance(go)
	self._oceanGO = RoomGOPool.getInstance(RoomScenePreloader.ResOcean, self._scene.go.waterRoot, "ocean")
	self._oceanFogGO = gohelper.findChild(self._oceanGO, "bxhy_ground_water_fog")
	self._fogAngle = nil

	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, self._cameraTransformUpdate, self)
end

function RoomSceneOceanComp:_cameraTransformUpdate()
	self:_refreshPosition()
	self:_refreshFogRotation()
end

function RoomSceneOceanComp:setOceanFog(oceanFog)
	if not self._oceanFogGO then
		return
	end

	local posX, posY, posZ = transformhelper.getLocalPos(self._oceanFogGO.transform)

	transformhelper.setLocalPos(self._oceanFogGO.transform, posX, oceanFog, posZ)
end

function RoomSceneOceanComp:_refreshPosition()
	local cameraPosition = self._scene.camera:getCameraPosition()

	transformhelper.setLocalPos(self._oceanGO.transform, cameraPosition.x, 0, cameraPosition.z)
end

function RoomSceneOceanComp:_refreshFogRotation()
	if not self._oceanFogGO then
		return
	end

	local cameraGO = CameraMgr.instance:getMainCameraGO()
	local cameraRotation = cameraGO.transform.eulerAngles

	if not self._fogAngle then
		self._fogAngle = Vector3(self._fogAngle.x, self._fogAngle.y, cameraRotation.y + 94.4)
		self._oceanFogGO.transform.localEulerAngles = self._fogAngle
	end
end

function RoomSceneOceanComp:onSceneClose()
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, self._cameraTransformUpdate, self)

	self._oceanGO = nil
end

return RoomSceneOceanComp
