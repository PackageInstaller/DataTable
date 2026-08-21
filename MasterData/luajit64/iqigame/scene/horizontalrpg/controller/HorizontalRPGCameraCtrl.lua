-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\Controller\\HorizontalRPGCameraCtrl.lua

local m = {
	isFollowing = false,
	zoomSpeed = 1,
	limitRightPos = 0,
	targetSize = 70,
	limitDownPos = 0,
	horizontalX = 0,
	limitUpPos = 0,
	cameraPosZ = 0,
	horizontalY = 0,
	moveInterpolation = 0.1,
	limitLeftPos = 0
}

function m.New(camera)
	local obj = Clone(m)

	obj:Init(camera)

	return obj
end

function m:Init(camera)
	self.camera = camera
	self.cameraPosZ = self.camera.transform.position.z
end

function m:Refresh(limitLeftPos, limitRightPos, limitUpPos, limitDownPos, orthographicSize, pos)
	self.limitUpPos = limitUpPos
	self.limitLeftPos = limitLeftPos
	self.limitRightPos = limitRightPos
	self.limitDownPos = limitDownPos
	self.camera.orthographicSize = orthographicSize
	self.targetSize = orthographicSize
	self.camera.transform.position = self:__GetRestrictedCameraPosition(Vector3.New(pos.x, pos.y, self.cameraPosZ))
	self.isFollowing = false
end

function m:LookAt(position, interpolation)
	self.isFollowing = false
	self.lookAtPosition = self:__GetRestrictedCameraPosition(Vector3.New(position.x, position.y, self.cameraPosZ))
	self.moveInterpolation = interpolation == nil and 0.1 or interpolation
	self.isFollowing = true
end

function m:MoveToPosition(data, moveEndCallBack)
	self.cameraObsData = data

	self:LookAt(data.pos, data.moveInterpolation)

	self.moveEndCallBack = moveEndCallBack
end

function m:Update()
	self.horizontalX = 0
	self.horizontalY = 0

	local dx = math.abs(self.camera.orthographicSize - self.targetSize)

	if dx > 1 then
		if self.camera.orthographicSize > self.targetSize then
			self.camera.orthographicSize = self.camera.orthographicSize - self.zoomSpeed
		else
			self.camera.orthographicSize = self.camera.orthographicSize + self.zoomSpeed
		end
	else
		self.camera.orthographicSize = self.targetSize
	end

	if not self.isFollowing then
		return
	end

	self:__UpdateCameraPos()
end

function m:__UpdateCameraPos()
	local cameraPos = self.camera.transform.position

	if (self.lookAtPosition - cameraPos).magnitude < 0.1 then
		self.isFollowing = false

		if self.moveEndCallBack then
			self.moveEndCallBack(self.cameraObsData)
		end

		self.moveEndCallBack = nil
		self.camera.transform.position = self.lookAtPosition
	else
		self.horizontalX = self.lookAtPosition.x - cameraPos.x

		local pos = Vector3.Lerp(cameraPos, self.lookAtPosition, self.moveInterpolation)

		self.camera.transform.position = pos
	end

	self.horizontalY = self.camera.transform.position.y
end

function m:__GetRestrictedCameraPosition(position)
	local cameraWidth = self.camera.orthographicSize * self.camera.aspect
	local cameraHeight = self.camera.orthographicSize
	local tempPos = position:Clone()

	tempPos.x = Mathf.Clamp(tempPos.x, self.limitLeftPos.x + cameraWidth, self.limitRightPos.x - cameraWidth)
	tempPos.y = Mathf.Clamp(tempPos.y, self.limitDownPos.y + cameraHeight, self.limitUpPos.y - cameraHeight)

	return tempPos
end

function m:ChangeCameraSize(size)
	self.targetSize = size
end

function m:GetCameraLimitY()
	local cameraHeight = self.camera.orthographicSize

	return self.limitDownPos.y + cameraHeight, self.limitUpPos.y - cameraHeight
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)

	self.moveEndCallBack = nil
	self.cameraObsData = nil
	self.camera = nil
end

return m
