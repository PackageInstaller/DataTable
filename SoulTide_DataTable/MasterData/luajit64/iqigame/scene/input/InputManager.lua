-- chunkname: @IQIGame\\Scene\\Input\\InputManager.lua

local m = {
	LockReasons = {}
}

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	function self.DelegateOnTapGesture(gesture)
		self:OnTapGesture(gesture)
	end

	function self.DelegateOnPanGesture(gesture)
		self:OnPanGesture(gesture)
	end

	function self.DelegateOnLockInput(lockSrc, isLock)
		self:OnLockInput(lockSrc, isLock)
	end

	GameEntry.Input:InitTapGesture()
	GameEntry.Input:InitPanGesture()
	GameEntry.Input:InitLongPressGesture()

	GameEntry.Input.TapGesture.StateUpdated = GameEntry.Input.TapGesture.StateUpdated + self.DelegateOnTapGesture
	GameEntry.Input.PanGesture.StateUpdated = GameEntry.Input.PanGesture.StateUpdated + self.DelegateOnPanGesture

	EventDispatcher.AddEventListener(EventID.LockInput, self.DelegateOnLockInput)
end

function m:OnTapGesture(gesture)
	if self:IsLock() then
		return
	end

	if gesture.State ~= DigitalRubyShared.GestureRecognizerState.Ended then
		return
	end

	self:OnTap(gesture.FocusX, gesture.FocusY)
end

function m:OnTap(mouseX, mouseY)
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
	GameEntry.Input.TapGesture.StateUpdated = GameEntry.Input.TapGesture.StateUpdated - self.DelegateOnTapGesture
	GameEntry.Input.PanGesture.StateUpdated = GameEntry.Input.PanGesture.StateUpdated - self.DelegateOnPanGesture

	GameEntry.Input:RemoveTapGesture()
	GameEntry.Input:RemovePanGesture()
	GameEntry.Input:RemoveLongPressGesture()
	EventDispatcher.RemoveEventListener(EventID.LockInput, self.DelegateOnLockInput)
end

InputManager = m
