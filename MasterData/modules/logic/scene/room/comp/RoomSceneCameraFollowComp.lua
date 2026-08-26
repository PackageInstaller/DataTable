-- chunkname: @modules/logic/scene/room/comp/RoomSceneCameraFollowComp.lua

module("modules.logic.scene.room.comp.RoomSceneCameraFollowComp", package.seeall)

local RoomSceneCameraFollowComp = class("RoomSceneCameraFollowComp", BaseSceneComp)

function RoomSceneCameraFollowComp:onInit()
	return
end

function RoomSceneCameraFollowComp:init(sceneId, levelId)
	self._scene = self:getCurScene()
	self._initialized = true
	self._offsetY = 0
end

function RoomSceneCameraFollowComp:onSceneStart(sceneId, levelId)
	return
end

function RoomSceneCameraFollowComp:onSceneClose()
	self._followTarget = nil
	self._initialized = false

	self:_stopFollowTask()
end

function RoomSceneCameraFollowComp:_startFollowTask()
	if not self._isRunningFollowTask then
		self._isRunningFollowTask = true

		TaskDispatcher.runRepeat(self._onUpdateFollow, self, 0)
	end
end

function RoomSceneCameraFollowComp:_stopFollowTask()
	if self._isRunningFollowTask then
		self._isRunningFollowTask = false

		TaskDispatcher.cancelTask(self._onUpdateFollow, self)
	end
end

function RoomSceneCameraFollowComp:_onUpdateFollow()
	if not self._followTarget or self._followTarget:isWillDestory() then
		self._followTarget = nil

		self:_stopFollowTask()

		return
	end

	if self._scene and self._scene.camera and not self._isPass then
		local px, py, pz = self._followTarget:getPositionXYZ()
		local cameraParam = self._scene.camera:getCameraParam()

		if self._isFirstPerson then
			local rx, ry, rz = self._followTarget:getRotateXYZ()

			cameraParam.rotate = RoomRotateHelper.getMod(ry, 360) * Mathf.Deg2Rad
		end

		self._offsetY = py

		self._scene.camera:moveTo(px, pz)
	end
end

function RoomSceneCameraFollowComp:getCameraOffsetY()
	if self._followTarget and not self._followTarget:isWillDestory() then
		return self._offsetY or 0
	end

	return 0
end

function RoomSceneCameraFollowComp:removeFollowTarget(followTarget)
	if followTarget and followTarget == self._followTarget then
		self._followTarget = nil

		self:_stopFollowTask()
	end
end

function RoomSceneCameraFollowComp:setIsPass(isPass, offsetY)
	self._isPass = isPass == true

	if self._isPass and offsetY ~= nil then
		self._offsetY = tonumber(offsetY)
	end
end

function RoomSceneCameraFollowComp:getIsPass()
	return self._isPass
end

function RoomSceneCameraFollowComp:isFollowing()
	return self._isRunningFollowTask
end

function RoomSceneCameraFollowComp:isLockRotate()
	if self._isRunningFollowTask and self._isFirstPerson then
		return true
	end

	return false
end

function RoomSceneCameraFollowComp:setFollowTarget(followTarget, isFirstPerson)
	self._isFirstPerson = isFirstPerson == true

	if self._followTarget == followTarget then
		return
	end

	if self._followTarget then
		self._followTarget:setCameraFollow(nil)
	end

	self._followTarget = followTarget

	if followTarget and not followTarget:isWillDestory() then
		followTarget:setCameraFollow(self)
		self:_startFollowTask()
		self:setIsPass(false)
	else
		self:_stopFollowTask()
	end
end

return RoomSceneCameraFollowComp
