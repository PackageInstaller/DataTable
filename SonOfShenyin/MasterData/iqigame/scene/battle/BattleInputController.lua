-- chunkname: @IQIGame\\Scene\\Battle\\BattleInputController.lua

local Controller = {
	__draggingBattleUnitID = 0,
	__enableInput = false
}

function Controller.New(camera)
	local obj = Clone(Controller)

	obj:__Init(camera)

	return obj
end

function Controller:__Init(camera)
	self.__camera = camera
	self.__enableInput = true
	self.__draggingBattleUnitID = 0

	GameEntry.Input:InitTapGesture()
	GameEntry.Input:InitPanGesture()
	GameEntry.Input:InitLongPressGesture()
	self:__InitEventDelegate()
	self:__AddEventListener()
end

function Controller:__InitEventDelegate()
	function self.__delegateOnTapGesture(_gesture)
		self:__OnTapGesture(_gesture)
	end

	function self.__delegateOnPanGesture(_gesture)
		self:__OnPanGesture(_gesture)
	end

	function self.__delegateOnLongPressGesture(_gesture)
		self:__OnLongPressGesture(_gesture)
	end

	function self.__delegateOnSetBattleGestureInputEnable(_enable)
		self:SetBattleGestureInputEnable(_enable)
	end
end

function Controller:__AddEventListener()
	EventDispatcher.AddEventListener(EventID.SetBattleGestureInputEnable, self.__delegateOnSetBattleGestureInputEnable)

	GameEntry.Input.TapGesture.StateUpdated = GameEntry.Input.TapGesture.StateUpdated + self.__delegateOnTapGesture
end

function Controller:__RemoveEventListener()
	EventDispatcher.RemoveEventListener(EventID.SetBattleGestureInputEnable, self.__delegateOnSetBattleGestureInputEnable)

	GameEntry.Input.TapGesture.StateUpdated = GameEntry.Input.TapGesture.StateUpdated - self.__delegateOnTapGesture
end

function Controller:SetBattleGestureInputEnable(enable)
	self.__enableInput = enable
end

function Controller:Dispose()
	self.__camera = nil

	self:__RemoveEventListener()
end

function Controller:__OnTapGesture(gesture)
	if not self.__enableInput then
		return
	end

	if UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject() then
		return
	end

	if gesture.State ~= DigitalRubyShared.GestureRecognizerState.Ended then
		return
	end

	local transform = self:__RayCastSceneTransform()

	if transform == nil then
		EventDispatcher.Dispatch(EventID.HideBattleSkillTopTipsView)

		return
	end

	if self.BattleUnitTapEvent ~= nil then
		self.BattleUnitTapEvent(transform, gesture)
	end
end

function Controller:__OnLongPressGesture(gesture)
	if not self.__enableInput then
		return
	end

	if gesture.State ~= DigitalRubyShared.GestureRecognizerState.Ended then
		return
	end

	local transform = self:__RayCastSceneTransform()

	if transform == nil then
		return
	end

	if self.BattleUnitLongPressEvent ~= nil then
		self.BattleUnitLongPressEvent(transform, gesture)
	end
end

function Controller:__OnPanGesture(gesture)
	if not self.__enableInput then
		return
	end

	if gesture.State == DigitalRubyShared.GestureRecognizerState.Began then
		self:__OnBeganDrag(gesture)
	elseif gesture.State == DigitalRubyShared.GestureRecognizerState.Executing then
		if self.__draggingBattleUnitID == 0 then
			return
		end

		local transform = self:__RayCastSceneTransform()

		if self.BattleUnitDraggingEvent ~= nil then
			self.BattleUnitDraggingEvent(self.__draggingBattleUnitID, transform, gesture)
		end
	elseif gesture.State == DigitalRubyShared.GestureRecognizerState.Ended then
		if self.__draggingBattleUnitID == 0 then
			return
		end

		local transform = self:__RayCastSceneTransform()

		if self.BattleUnitEndDragEvent ~= nil then
			self.BattleUnitEndDragEvent(self.__draggingBattleUnitID, transform, gesture)
		end

		self.__draggingBattleUnitID = 0
	end
end

function Controller:__OnBeganDrag(gesture)
	self.__draggingBattleUnitID = 0

	local transform = self:__RayCastSceneTransform()

	if transform == nil then
		return
	end

	if self.BattleUnitBeginDragEvent ~= nil then
		self.__draggingBattleUnitID = self.BattleUnitBeginDragEvent(transform, gesture)
	end
end

function Controller:__RayCastSceneTransform()
	local transform = LuaCodeInterface.Raycast3D(self.__camera, "Default")

	return transform
end

return Controller
