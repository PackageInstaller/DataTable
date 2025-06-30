-- chunkname: @IQIGame\\Scene\\TownArea\\CameraCtrl.lua

local CameraCtrl = {
	speedAutoMoveToTarget = 1,
	speedMove = 0.005,
	speedAutoMove = 0.005
}

function CameraCtrl.New()
	local obj = Clone(CameraCtrl)

	obj:Init()

	return obj
end

function CameraCtrl:Init()
	function self.onPanGestureDelegate(gesture)
		self:OnTapGesture(gesture)
	end

	self.uiEdgeCoverComponent = UnityEngine.GameObject.Find("UIEdgeCover"):GetComponent("UIEdgeCoverComponent")
	self.uiAspect = self.uiEdgeCoverComponent.limitedCanvasSize.x / self.uiEdgeCoverComponent.limitedCanvasSize.y
end

function CameraCtrl:Refresh(defaultX, limitLeftPos, limitRightPos, camera, orthographicSize)
	self.camera = camera
	self.transCamera = self.camera.transform

	if orthographicSize then
		self.camera.orthographicSize = orthographicSize
	else
		self.camera.orthographicSize = 3.75
	end

	if self.uiEdgeCoverComponent.basedOnWidth then
		self.camera.orthographicSize = self.camera.orthographicSize * self.uiAspect / self.camera.aspect
	end

	local cameraWidth = self.camera.orthographicSize * self.camera.aspect * 2
	local cameraHeight = self.camera.orthographicSize * 2

	if self.uiEdgeCoverComponent.basedOnWidth then
		cameraHeight = cameraWidth / self.uiAspect
	else
		cameraWidth = cameraHeight * self.uiAspect
	end

	if limitLeftPos.x >= -cameraWidth / 2 and limitRightPos.x <= cameraWidth / 2 then
		self.limitLeftPos = self.transCamera.position
		self.limitRightPos = self.transCamera.position
	else
		self.limitLeftPos = Vector3.New(limitLeftPos.x + cameraWidth / 2, 0, 0)
		self.limitRightPos = Vector3.New(limitRightPos.x - cameraWidth / 2, 0, 0)
	end

	self.cameraPos = self.camera.transform.position
	self.cameraPos.x = math.max(self.limitLeftPos.x, defaultX)
	self.camera.transform.position = self.cameraPos

	self:OnAddListener()
	self:StopAutoMove()
	self:StopAutoMoveToTarget()
end

function CameraCtrl:OnUpdate()
	if self.enableAutoMove then
		if self.autoMoveTime <= 3 then
			self.autoMoveDeltaX = math.lerp(self.autoMoveDeltaX, 0, self.autoMoveTime)
			self.autoMoveTime = self.autoMoveTime + UnityEngine.Time.smoothDeltaTime

			self:ChangeCameraPos(self.autoMoveDeltaX, 0)
		else
			self:StopAutoMove()
		end
	end

	if self.enableAutoMoveToTarget then
		local deltaX = 0
		local deltaY = 0

		if self.autoMoveToTargetDeltaX ~= 0 then
			deltaX = self.speedAutoMoveToTarget * math.sign(self.autoMoveToTargetDeltaX)

			if math.abs(deltaX) > math.abs(self.autoMoveToTargetDeltaX) then
				deltaX = self.autoMoveToTargetDeltaX
			end
		end

		if self.autoMoveToTargetDeltaY ~= 0 then
			deltaY = self.speedAutoMoveToTarget * math.sign(self.autoMoveToTargetDeltaY)

			if math.abs(deltaY) > math.abs(self.autoMoveToTargetDeltaY) then
				deltaY = self.autoMoveToTargetDeltaY
			end
		end

		self.autoMoveToTargetDeltaX = math.sign(self.autoMoveToTargetDeltaX) * (math.abs(self.autoMoveToTargetDeltaX) - math.abs(deltaX))
		self.autoMoveToTargetDeltaY = math.sign(self.autoMoveToTargetDeltaY) * (math.abs(self.autoMoveToTargetDeltaY) - math.abs(deltaY))

		self:ChangeCameraPos(deltaX, deltaY)

		if self.autoMoveToTargetDeltaX == 0 and self.autoMoveToTargetDeltaY == 0 then
			self:StopAutoMoveToTarget()

			if self.onMoveTargetOverDelegate ~= nil then
				self.onMoveTargetOverDelegate()
			end
		end
	end
end

function CameraCtrl:OnClose()
	self:OnRemoveListener()
	self:StopAutoMove()
	self:StopAutoMoveToTarget()
end

function CameraCtrl:OnDestroy()
	self:OnRemoveListener()
	self:StopAutoMove()
	self:StopAutoMoveToTarget()

	self.cameraChangePosCallBack = nil
	self.onMoveTargetOverDelegate = nil
end

function CameraCtrl:OnAddListener()
	self:OnRemoveListener()

	GameEntry.Input.PanGesture.StateUpdated = GameEntry.Input.PanGesture.StateUpdated + self.onPanGestureDelegate
end

function CameraCtrl:OnRemoveListener()
	GameEntry.Input.PanGesture.StateUpdated = GameEntry.Input.PanGesture.StateUpdated - self.onPanGestureDelegate
end

function CameraCtrl:OnTapGesture(gesture)
	if not self.enableDrag then
		return
	end

	if gesture.State == DigitalRubyShared.GestureRecognizerState.Ended then
		self:StartAutoMove(gesture.DeltaX)
	elseif gesture.State == DigitalRubyShared.GestureRecognizerState.Began then
		self:StopAutoMove()
	elseif gesture.State == DigitalRubyShared.GestureRecognizerState.Executing then
		self:ChangeCameraPos(gesture.DeltaX * self.speedMove, 0)
	end
end

function CameraCtrl:StartAutoMove(deltaX)
	if deltaX == 0 then
		return
	end

	self.autoMoveDeltaX = deltaX * self.speedAutoMove
	self.enableAutoMove = true
	self.autoMoveTime = 0
end

function CameraCtrl:StopAutoMove()
	self.enableAutoMove = false
	self.autoMoveTime = 0
end

function CameraCtrl:ChangeCameraPos(deltaX, deltaY)
	local newX = self.transCamera.position.x - deltaX
	local newY = self.transCamera.position.y - deltaY

	newX = math.max(self.limitLeftPos.x, newX)
	newX = math.min(self.limitRightPos.x, newX)
	self.cameraPos.x = newX
	self.cameraPos.y = newY
	self.transCamera.position = self.cameraPos

	if self.cameraChangePosCallBack then
		self.cameraChangePosCallBack()
	end
end

function CameraCtrl:SetCameraPosX(x)
	self:ChangeCameraPos(self.transCamera.position.x - x, 0)
end

function CameraCtrl:StartAutoMoveToTarget(targetPos, limitY)
	if self.enableAutoMoveToTarget then
		return
	end

	if limitY then
		local cameraWidth = self.camera.orthographicSize * self.camera.aspect * 2
		local camearHeigth = self.camera.orthographicSize * 2
		local limitLeftX = self.transCamera.position.x - cameraWidth / 2
		local limitRightX = self.transCamera.position.x + cameraWidth / 2
		local limitTopY = self.transCamera.position.y + camearHeigth / 2
		local limitBottomY = self.transCamera.position.y - camearHeigth / 2

		if limitLeftX <= targetPos.x and limitRightX >= targetPos.x then
			targetPos.x = self.transCamera.position.x
		elseif limitLeftX > targetPos.x then
			targetPos.x = targetPos.x + cameraWidth / 2
		else
			targetPos.x = targetPos.x - cameraWidth / 2
		end

		if limitBottomY <= targetPos.y and limitTopY >= targetPos.y then
			targetPos.y = self.transCamera.position.y
		elseif limitBottomY > targetPos.y then
			targetPos.y = targetPos.y + camearHeigth / 2
		else
			targetPos.y = targetPos.y - camearHeigth / 2
		end
	end

	self.autoMoveToTargetDeltaX = self.transCamera.position.x - targetPos.x
	self.autoMoveToTargetDeltaY = self.transCamera.position.y - targetPos.y

	if self.autoMoveToTargetDeltaX == 0 and self.autoMoveToTargetDeltaY == 0 then
		return
	end

	self.enableAutoMoveToTarget = true

	self:SetDragEnable(false)
	self:StopAutoMove()
end

function CameraCtrl:StopAutoMoveToTarget()
	self.enableAutoMoveToTarget = false

	self:SetDragEnable(true)
end

function CameraCtrl:SetDragEnable(isEnable)
	self.enableDrag = isEnable
end

function CameraCtrl:SetMoseEnable(isEnable)
	self.camera.gameObject:GetComponent("Physics2DRaycaster").enabled = isEnable
end

return CameraCtrl
