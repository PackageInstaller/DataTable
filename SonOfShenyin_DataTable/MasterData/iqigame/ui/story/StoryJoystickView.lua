-- chunkname: @IQIGame\\UI\\Story\\StoryJoystickView.lua

local StoryJoystickView = {}

function StoryJoystickView.New(view)
	local obj = Clone(StoryJoystickView)

	obj:Init(view)

	return obj
end

function StoryJoystickView:Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:InitComponent()
	self:InitDelegate()
	self:AddListeners()
end

function StoryJoystickView:InitComponent()
	self.joystick = self.MyETCJoystick:GetComponent("ETCJoystick")
end

function StoryJoystickView:InitDelegate()
	function self.delegateOnMoveStart()
		EventDispatcher.Dispatch(EventID.JoystickMoveStart)
	end

	function self.delegateOnMove(direction)
		self:OnMove(direction)
	end

	function self.delegateOnMoveEnd()
		EventDispatcher.Dispatch(EventID.JoystickMoveEnd)
	end
end

function StoryJoystickView:AddListeners()
	self.joystick.onMove:AddListener(self.delegateOnMove)
	self.joystick.onMoveStart:AddListener(self.delegateOnMoveStart)
	self.joystick.onMoveEnd:AddListener(self.delegateOnMoveEnd)
end

function StoryJoystickView:RemoveListeners()
	self.joystick.onMove:RemoveListener(self.delegateOnMove)
	self.joystick.onMoveStart:RemoveListener(self.delegateOnMoveStart)
	self.joystick.onMoveEnd:RemoveListener(self.delegateOnMoveEnd)
end

function StoryJoystickView:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.joystick = nil
	self.gameObject = nil
end

function StoryJoystickView:Open()
	LuaUtility.SetCanvasGroupShowWithGameObject(self.gameObject, true)

	self.joystick.activated = true
end

function StoryJoystickView:Close()
	if self.joystick.activated == false then
		return
	end

	self.joystick.activated = false

	LuaUtility.SetCanvasGroupShowWithGameObject(self.gameObject, false)
	EventDispatcher.Dispatch(EventID.ForceShutDownJoystickEvent)
end

local vet = Vector2.New(0, 0)

function StoryJoystickView:OnMove(direction)
	vet.x = direction.x
	vet.y = direction.y

	EventDispatcher.Dispatch(EventID.JoystickMove, vet)
end

function StoryJoystickView:OnSetTargetTransform(transform)
	self.joystick.axisX.directTransform = transform
	self.joystick.axisY.directTransform = transform
end

function StoryJoystickView:OnSetMoveSpeed(speed)
	self.joystick.axisX:SetSpeed(speed)
	self.joystick.axisY:SetSpeed(speed)
end

return StoryJoystickView
