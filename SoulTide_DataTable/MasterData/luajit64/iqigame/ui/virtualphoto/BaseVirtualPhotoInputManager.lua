-- chunkname: @IQIGame\\UI\\VirtualPhoto\\BaseVirtualPhotoInputManager.lua

local m = {
	HasScaleGestureBefore = false,
	HasPanGestureBefore = false,
	HasDoubleTapBefore = false,
	HasRotateGestureBefore = false,
	LockReasons = {}
}

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	function self.DelegateOnDoubleTapGesture(gesture)
		self:OnDoubleTapGesture(gesture)
	end

	function self.DelegateOnPanGesture(gesture)
		self:OnPanGesture(gesture)
	end

	function self.DelegateOnScaleGesture(gesture)
		self:OnScaleGesture(gesture)
	end

	function self.DelegateOnRotateGesture(gesture)
		self:OnRotateGesture(gesture)
	end

	function self.DelegateOnLockInput(lockSrc, isLock)
		self:OnLockInput(lockSrc, isLock)
	end

	self.HasDoubleTapBefore = GameEntry.Input.IsDoubleTapGestureEnabled
	self.HasPanGestureBefore = GameEntry.Input.IsPanGestureEnabled
	self.HasScaleGestureBefore = GameEntry.Input.IsScaleGestureEnabled
	self.HasRotateGestureBefore = GameEntry.Input.IsRotateGestureEnabled

	if not self.HasDoubleTapBefore then
		GameEntry.Input:InitDoubleTapGesture()
	end

	if not self.HasPanGestureBefore then
		GameEntry.Input:InitPanGesture()
	end

	if not self.HasScaleGestureBefore then
		GameEntry.Input:InitScaleGesture()
	end

	if not self.HasRotateGestureBefore then
		GameEntry.Input:InitRotateGesture()
	end

	GameEntry.Input:SetTapGesturePriorityToTop(2)

	GameEntry.Input.DoubleTapGesture.StateUpdated = GameEntry.Input.DoubleTapGesture.StateUpdated + self.DelegateOnDoubleTapGesture
	GameEntry.Input.PanGesture.StateUpdated = GameEntry.Input.PanGesture.StateUpdated + self.DelegateOnPanGesture
	GameEntry.Input.ScaleGesture.StateUpdated = GameEntry.Input.ScaleGesture.StateUpdated + self.DelegateOnScaleGesture
	GameEntry.Input.RotateGesture.StateUpdated = GameEntry.Input.RotateGesture.StateUpdated + self.DelegateOnRotateGesture

	EventDispatcher.AddEventListener(EventID.LockInput, self.DelegateOnLockInput)
end

function m:OnDoubleTapGesture(gesture)
	if self:IsLock() then
		return
	end

	if gesture.State ~= DigitalRubyShared.GestureRecognizerState.Ended then
		return
	end

	self:OnDoubleTap(gesture.FocusX, gesture.FocusY)
end

function m:OnDoubleTap(mouseX, mouseY)
	return
end

function m:OnPanGesture(gesture)
	if self:IsLock() then
		return
	end

	self:OnDrag(gesture.State, gesture.DeltaX, gesture.DeltaY)
end

function m:OnDrag(state, deltaX, deltaY)
	return
end

function m:OnScaleGesture(gesture)
	if self:IsLock() then
		return
	end

	self:OnScale(gesture.State, gesture.ScaleMultiplier)
end

function m:OnScale(state, scale)
	return
end

function m:OnRotateGesture(gesture)
	if self:IsLock() then
		return
	end

	self:OnRotate(gesture.State, gesture.RotationDegrees)
end

function m:OnRotate(state, angle)
	return
end

function m:OnLockInput(lockReason, isLock)
	local index = table.indexOf(self.LockReasons, lockReason)

	if isLock and index == -1 then
		table.insert(self.LockReasons, lockReason)
	elseif not isLock and index ~= -1 then
		table.remove(self.LockReasons, index)
	end
end

function m:IsLock()
	return #self.LockReasons > 0
end

function m:Dispose()
	GameEntry.Input.DoubleTapGesture.StateUpdated = GameEntry.Input.DoubleTapGesture.StateUpdated - self.DelegateOnDoubleTapGesture
	GameEntry.Input.PanGesture.StateUpdated = GameEntry.Input.PanGesture.StateUpdated - self.DelegateOnPanGesture
	GameEntry.Input.ScaleGesture.StateUpdated = GameEntry.Input.ScaleGesture.StateUpdated - self.DelegateOnScaleGesture
	GameEntry.Input.RotateGesture.StateUpdated = GameEntry.Input.RotateGesture.StateUpdated - self.DelegateOnRotateGesture

	GameEntry.Input:ResetTapGesturesPriority()

	if not self.HasDoubleTapBefore then
		GameEntry.Input:RemoveDoubleTapGesture()
	end

	if not self.HasPanGestureBefore then
		GameEntry.Input:RemovePanGesture()
	end

	if not self.HasScaleGestureBefore then
		GameEntry.Input:RemoveScaleGesture()
	end

	if not self.HasRotateGestureBefore then
		GameEntry.Input:RemoveRotateGesture()
	end

	EventDispatcher.RemoveEventListener(EventID.LockInput, self.DelegateOnLockInput)
end

return m
