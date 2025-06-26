-- chunkname: @IQIGame\\Scene\\Maze\\Animation\\MazeSceneAnimation.lua

local m = {
	StartMoveCameraToSpeNodeTime = 0,
	SpeCameraMoveDuration = 0,
	StartMoveCameraToHeroTime = 0,
	AutoBackToHero = false
}

function m.New(mazeScene)
	local obj = Clone(m)

	obj:Init(mazeScene)

	return obj
end

function m:Init(mazeScene)
	self.MazeScene = mazeScene
end

function m:PlayShowNodeAnimation(node, skipMoveToTarget, callback, delay, duration)
	self.AutoBackToHero = true

	if self.OnShowNodeAnimationComplete ~= nil then
		self:PlayShowNodeAndElement(self.CameraLockNode)
		self.OnShowNodeAnimationComplete()
	end

	self.OnShowNodeAnimationComplete = callback

	node:SetVisible(false)

	local nodeElement

	for i = 1, #self.MazeScene.Elements do
		local element = self.MazeScene.Elements[i]

		if element.NodeData.NodeId == node.NodeData.NodeId then
			nodeElement = element

			nodeElement:SetVisible(false)

			break
		end
	end

	if delay ~= nil and delay > 0 then
		local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Maze, function()
			self:StartShowAnimation(node, skipMoveToTarget, false, duration)
		end, delay)

		timer:Start()
	else
		self:StartShowAnimation(node, skipMoveToTarget, false, duration)
	end
end

function m:PlayMoveCameraAnimation(node, callback, isTeleport, delay, duration)
	self.AutoBackToHero = false
	self.MoveCameraCompleteCallback = callback

	if delay ~= nil and delay ~= 0 then
		local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Maze, function()
			self:StartShowAnimation(node, false, isTeleport, duration)
		end, delay)

		timer:Start()
	else
		self:StartShowAnimation(node, false, isTeleport, duration)
	end
end

function m:MoveBackToHero(callback, isTeleport, delay, duration)
	self.MoveCameraCompleteCallback = callback

	local function moveBackToHero()
		self.StartMoveCameraToSpeNodeTime = 0
		self.SpeCameraMoveTargetPosition = self.MazeScene:GetRestrictedCameraPosition(self.MazeScene.Hero:GetCameraFocusPosition())
		self.SpeCameraMoveAnimStartPos = self.MazeScene.MainCamera.transform.position
		self.StartMoveCameraToHeroTime = UnityEngine.Time.time

		if isTeleport then
			self.SpeCameraMoveDuration = 0
		elseif duration then
			self.SpeCameraMoveDuration = duration
		end
	end

	if delay ~= nil and delay ~= 0 then
		local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Maze, moveBackToHero, delay)

		timer:Start()
	else
		moveBackToHero()
	end
end

function m:StartShowAnimation(node, skipMoveToTarget, isTeleport, duration)
	self.CameraLockNode = node

	if not skipMoveToTarget then
		self.SpeCameraMoveTargetPosition = self.MazeScene:GetRestrictedCameraPosition(node:GetCameraFocusPosition())
		self.SpeCameraMoveAnimStartPos = self.MazeScene:GetRestrictedCameraPosition(self.MazeScene.MainCamera.transform.position)
		self.StartMoveCameraToSpeNodeTime = UnityEngine.Time.time
	else
		self:CameraArriveNodePosition()
		self.MazeScene:RecordBgRollingDragDelta()
		self.MazeScene:MoveCamera(self.SpeCameraMoveAnimStartPos, true, true)
	end

	if not isTeleport then
		if duration == nil then
			self.SpeCameraMoveDuration = (self.SpeCameraMoveTargetPosition - self.SpeCameraMoveAnimStartPos).magnitude * 0.15
		else
			self.SpeCameraMoveDuration = duration
		end
	else
		self.SpeCameraMoveDuration = 0
	end

	MazeModule.CloseMazeManualUI()
end

function m:PlayShowNodeAndElement(node)
	node:PlayShow()

	for i = 1, #self.MazeScene.Elements do
		local element = self.MazeScene.Elements[i]

		if element.NodeData.NodeId == node.NodeData.NodeId then
			element:UpdateByNode(true)

			break
		end
	end
end

function m:Update()
	if self.StartMoveCameraToSpeNodeTime ~= 0 or self.StartMoveCameraToHeroTime ~= 0 then
		self.MazeScene:RecordBgRollingDragDelta()
		self:MoveCameraToSpeTarget()
	end
end

function m:MoveCameraToSpeTarget()
	local startTime = self.StartMoveCameraToSpeNodeTime ~= 0 and self.StartMoveCameraToSpeNodeTime or self.StartMoveCameraToHeroTime
	local lerpValue

	if self.SpeCameraMoveDuration > 0 then
		lerpValue = (UnityEngine.Time.time - startTime) / self.SpeCameraMoveDuration
	else
		lerpValue = 1
	end

	self.MazeScene:MoveCamera(Vector3.Lerp(self.SpeCameraMoveAnimStartPos, self.SpeCameraMoveTargetPosition, lerpValue), true, true)

	if self.StartMoveCameraToSpeNodeTime ~= 0 and lerpValue >= 1 then
		self:CameraArriveNodePosition()

		if not self.AutoBackToHero then
			self.CameraLockNode = nil

			if self.MoveCameraCompleteCallback ~= nil then
				self.MoveCameraCompleteCallback()

				self.MoveCameraCompleteCallback = nil
			end
		end
	end

	if self.StartMoveCameraToHeroTime ~= 0 and lerpValue >= 1 then
		self.StartMoveCameraToHeroTime = 0
		self.CameraLockNode = nil

		if self.OnShowNodeAnimationComplete ~= nil then
			local onShowNodeAnimationComplete = self.OnShowNodeAnimationComplete

			self.OnShowNodeAnimationComplete = nil

			onShowNodeAnimationComplete()
		end

		if self.MoveCameraCompleteCallback ~= nil then
			self.MoveCameraCompleteCallback()

			self.MoveCameraCompleteCallback = nil
		end
	end
end

function m:CameraArriveNodePosition()
	self.StartMoveCameraToSpeNodeTime = 0

	if not self.AutoBackToHero then
		return
	end

	self.SpeCameraMoveTargetPosition = self.MazeScene:GetRestrictedCameraPosition(self.MazeScene.Hero:GetCameraFocusPosition())
	self.SpeCameraMoveAnimStartPos = self.MazeScene:GetRestrictedCameraPosition(self.CameraLockNode:GetCameraFocusPosition())

	local cameraLockNode = self.CameraLockNode
	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Maze, function()
		self:PlayShowNodeAndElement(cameraLockNode)
	end, 0.5)

	timer:Start()

	timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Maze, function()
		self.StartMoveCameraToHeroTime = UnityEngine.Time.time
	end, 1)

	timer:Start()
end

function m:Dispose()
	self.MazeScene = nil
end

return m
