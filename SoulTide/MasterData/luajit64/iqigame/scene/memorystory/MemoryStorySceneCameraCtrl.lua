-- chunkname: @IQIGame\\Scene\\MemoryStory\\MemoryStorySceneCameraCtrl.lua

local m = {
	isFollowing = false,
	cameraPosZ = 0,
	moveInterpolation = 0.1
}

function m.New()
	local obj = Clone(m)

	obj:__Init()

	return obj
end

function m:__Init()
	return
end

function m:Refresh(camera, orthographicSize, top, right, bottom, left, pos)
	self.camera = camera
	self.cameraPosZ = camera.transform.position.z
	self.camera.orthographicSize = orthographicSize

	local cameraSizeX = self.camera.orthographicSize * (UnityEngine.Screen.width / UnityEngine.Screen.height)
	local cameraSizeY = self.camera.orthographicSize

	self.limitTop = top - cameraSizeY
	self.limitRight = right - cameraSizeX
	self.limitBottom = bottom + cameraSizeY
	self.limitLeft = left + cameraSizeX
	self.camera.transform.position = self:__GetRestrictedCameraPosition(Vector3.New(pos.x, pos.y, self.cameraPosZ))
	self.isFollowing = false
end

function m:LookAt(position, interpolation)
	self.isFollowing = false
	self.lookAtPosition = self:__GetRestrictedCameraPosition(Vector3.New(position.x, position.y, self.cameraPosZ))
	self.moveInterpolation = interpolation == nil and 0.1 or interpolation
	self.isFollowing = true
end

function m:Update()
	if not self.isFollowing then
		return
	end

	self:__UpdateCameraPos()
end

function m:__UpdateCameraPos()
	local cameraPos = self.camera.transform.position

	if (self.lookAtPosition - cameraPos).magnitude < 0.1 then
		self.isFollowing = false
	else
		local pos = Vector3.Lerp(cameraPos, self.lookAtPosition, self.moveInterpolation)

		self.camera.transform.position = pos
	end
end

function m:__GetRestrictedCameraPosition(position)
	local result = position:Clone()

	if result.x < self.limitLeft then
		result.x = self.limitLeft
	elseif result.x > self.limitRight then
		result.x = self.limitRight
	end

	if result.y < self.limitBottom then
		result.y = self.limitBottom
	elseif result.y > self.limitTop then
		result.y = self.limitTop
	end

	return result
end

function m:OnDestroy()
	self.camera = nil
end

return m
