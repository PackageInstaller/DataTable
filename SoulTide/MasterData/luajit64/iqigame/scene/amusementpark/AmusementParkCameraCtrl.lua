-- chunkname: @IQIGame\\Scene\\AmusementPark\\AmusementParkCameraCtrl.lua

local m = {
	moveSpeed = 8.5,
	zoomSpeed = 2,
	maxSize = 2,
	limitRightPos = 0,
	minSize = 5,
	limitDownPos = 0,
	limitUpPos = 0,
	targetSize = 0,
	limitLeftPos = 0,
	targetPos = Vector3.New(0, 0, 0)
}

function m.New(camera)
	local obj = Clone(m)

	obj:Init(camera)

	return obj
end

function m:Init(camera)
	self.camera = camera

	self:AddListeners()
end

function m:Refresh(limitLeftPos, limitRightPos, limitUpPos, limitDownPos)
	self.limitUpPos = limitUpPos
	self.limitLeftPos = limitLeftPos
	self.limitRightPos = limitRightPos
	self.limitDownPos = limitDownPos
	self.targetSize = 3
	self.camera.orthographicSize = self.targetSize
	self.targetPos = self.camera.transform.position
end

function m:OnUpdate()
	local dx = math.abs(self.camera.orthographicSize - self.targetSize)

	if dx > 0.06 then
		if self.camera.orthographicSize > self.targetSize then
			self.camera.orthographicSize = self.camera.orthographicSize - self.zoomSpeed * UnityEngine.Time.deltaTime
		else
			self.camera.orthographicSize = self.camera.orthographicSize + self.zoomSpeed * UnityEngine.Time.deltaTime
		end

		self.targetPos = self:CheckCameraLimitPos(self.targetPos)
	else
		self.camera.orthographicSize = self.targetSize
	end

	local direction = self.targetPos - self.camera.transform.position

	if direction.magnitude > 0.2 then
		self.camera.transform:Translate(direction.normalized * self.moveSpeed * UnityEngine.Time.deltaTime)
	else
		self.camera.transform.position = self.targetPos
	end
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:ChangeCameraSize(type)
	if type == 1 then
		if self.targetSize > self.maxSize then
			self.targetSize = self.targetSize - 1
		else
			self.targetSize = self.maxSize
		end
	elseif self.targetSize < self.minSize then
		self.targetSize = self.targetSize + 1
	else
		self.targetSize = self.minSize
	end
end

function m:MoveCamera(dx, dy)
	if self.camera == nil or LuaCodeInterface.GameObjIsDestroy(self.camera) then
		return
	end

	local pos = self.camera.transform.position

	self.targetPos = self:CheckCameraLimitPos(pos + Vector3.New(dx, dy, 0))
end

function m:CheckCameraLimitPos(pos)
	local cameraWidth = self.camera.orthographicSize * self.camera.aspect
	local cameraHeight = self.camera.orthographicSize
	local tempPos = pos:Clone()

	tempPos.x = Mathf.Clamp(tempPos.x, self.limitLeftPos.x + cameraWidth, self.limitRightPos.x - cameraWidth)
	tempPos.y = Mathf.Clamp(tempPos.y, self.limitDownPos.y + cameraHeight, self.limitUpPos.y - cameraHeight)

	return tempPos
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()

	self.camera = nil
end

return m
