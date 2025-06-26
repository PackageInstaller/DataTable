-- chunkname: @IQIGame\\Components\\JoystickControl.lua

local JoystickControl = {}

function JoystickControl.New(holder, useRigdbody)
	local o = Clone(JoystickControl)

	o:Initialize(holder, useRigdbody)

	return o
end

function JoystickControl:Initialize(holder, useRigdbody)
	self.Holder = holder
	self.UseRigdbody = useRigdbody

	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function JoystickControl:InitMembers()
	self.MapNeedModify = {}
	self.IsMapMoveState = false
	self.JoyStickDragSpeedRatio = 1
	self.IsUniformSpeed = false
	self.DyMapMoveDistance = 0
	self.ControlAnimation = false
	self.IsReverseControl = false
	self.EnableRoleFlip = true
	self.joyStickDragSpeed = 0
	self.absMoveX = 0
	self.absMoveZ = 0
	self.DyDirection = Vector2.New(0, 0)
end

function JoystickControl:InitComponent()
	return
end

function JoystickControl:InitDelegate()
	function self.JoyStickMoveStartDelegate()
		self:JoyStickMoveStart()
	end

	function self.JoyStickMoveDelegate(direction)
		self:JoyStickMove(direction)
	end

	function self.JoyStickMoveEndDelegate()
		self:JoyStickMoveEnd()
	end

	function self.ForceShutDownJoystickDelegate()
		self:JoyStickMoveEnd()
	end
end

function JoystickControl:AddListener()
	EventDispatcher.AddEventListener(EventID.JoystickMoveStart, self.JoyStickMoveStartDelegate)
	EventDispatcher.AddEventListener(EventID.JoystickMove, self.JoyStickMoveDelegate)
	EventDispatcher.AddEventListener(EventID.JoystickMoveEnd, self.JoyStickMoveEndDelegate)
	EventDispatcher.AddEventListener(EventID.ForceShutDownJoystickEvent, self.ForceShutDownJoystickDelegate)
end

function JoystickControl:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.JoystickMoveStart, self.JoyStickMoveStartDelegate)
	EventDispatcher.RemoveEventListener(EventID.JoystickMove, self.JoyStickMoveDelegate)
	EventDispatcher.RemoveEventListener(EventID.JoystickMoveEnd, self.JoyStickMoveEndDelegate)
	EventDispatcher.RemoveEventListener(EventID.ForceShutDownJoystickEvent, self.ForceShutDownJoystickDelegate)
end

function JoystickControl:JoyStickMoveStart()
	if not self:CheckHolderIsActive() then
		return
	end

	self.IsControlling = true

	if self.ControlAnimation then
		self.Holder:PlayAnimation(self.EnterAnimation, true)
	else
		self.Holder:ChangeStateByName(StoryMoveState.Name)
	end

	LuaUtility.PlaySoundWithID(22000014)
end

function JoystickControl:JoyStickMove(direction)
	if not self:CheckHolderIsActive() then
		return
	end

	self:_HolderMoving(direction)
end

function JoystickControl:JoyStickMoveEnd()
	if not self:CheckHolderIsActive() then
		return
	end

	self:StopMove()

	if self.ControlAnimation then
		self.Holder:PlayAnimation(self.EndAnimation, true)
	else
		self.Holder:ChangeStateByName(StoryIdleState.Name)
	end

	self.IsControlling = false
end

function JoystickControl:CheckHolderIsActive()
	return self.Holder ~= nil
end

function JoystickControl:StopMove()
	if self.UseRigdbody then
		self.Holder.rigidbody.velocity = UnityEngine.Vector3.zero
	end

	StoryModule.joystickMoveDirection = Vector2.zero
end

function JoystickControl:_HolderMoving(direction)
	self.DyDirection.x = direction.x
	self.DyDirection.y = direction.y

	if self.IsIgnoreX then
		self.DyDirection.x = 0
	end

	if self.IsIgnoreY then
		self.DyDirection.y = 0
	end

	if self.IsReverseControl then
		self.DyDirection.x = -self.DyDirection.x
		self.DyDirection.y = -self.DyDirection.y
	end

	if self.EnableRoleFlip and self.DyDirection.x ~= 0 then
		self.Holder:SetFlipX(self.DyDirection.x > 0)
	end

	if self.IsMapMoveState then
		self:_MapMoving(self.DyDirection)
	else
		self:_NormalMoving(self.DyDirection)
	end
end

function JoystickControl:_MapMoving(direction)
	local posX = direction.x * self.JoyStickDragSpeedRatio
	local posZ = direction.y * self.JoyStickDragSpeedRatio

	self.joyStickDragSpeed = math.abs(posX) > math.abs(posZ) and math.abs(posX) or math.abs(posZ)
	self.DyMapMoveDistance = self.DyMapMoveDistance + direction.x * Time.deltaTime * self.JoyStickDragSpeedRatio

	LuaUtility.SetBehaviorGlobalVariables(Constant.BehaviorGlobalDefine.LoopMapDistance, self.DyMapMoveDistance)

	if self.MapNeedModify then
		for i = 1, #self.MapNeedModify do
			LuaUtility.SetShaderGlobalFloatValue(self.MapNeedModify[i], self.DyMapMoveDistance)
		end
	end
end

local m_Pos = Vector3.New(0, 0, 0)
local newPosition = Vector3.New(0, 0, 0)

function JoystickControl:_NormalMoving(direction)
	local x, y, z = LuaUtility.GetLocalPositionWithGameObject(self.Holder:GetGameObject())

	m_Pos:Set(x, y, z)

	if self.IsUniformSpeed then
		if direction.magnitude <= 1e-05 and direction.magnitude >= -1e-05 then
			direction:Set(0, 0)
		else
			direction = direction / direction.magnitude
		end
	end

	local posX = direction.x * self.JoyStickDragSpeedRatio
	local posZ = direction.y * self.JoyStickDragSpeedRatio

	self.joyStickDragSpeed = math.abs(posX) > math.abs(posZ) and math.abs(posX) or math.abs(posZ)

	local offsetX = posX * Time.fixedDeltaTime
	local offsetZ = posZ * Time.fixedDeltaTime

	newPosition.x = m_Pos.x + offsetX
	newPosition.y = m_Pos.y
	newPosition.z = m_Pos.z + offsetZ

	if self.LimitX_Left then
		newPosition.x = newPosition.x <= self.LimitX_Left and m_Pos.x or newPosition.x
	end

	if self.LimitX_Right then
		newPosition.x = newPosition.x >= self.LimitX_Right and m_Pos.x or newPosition.x
	end

	if self.LimitZ_Left then
		newPosition.z = newPosition.z <= self.LimitZ_Left and m_Pos.z or newPosition.z
	end

	if self.LimitZ_Right then
		newPosition.z = newPosition.z >= self.LimitZ_Right and m_Pos.z or newPosition.z
	end

	if self.UseRigdbody then
		self.Holder.rigidbody:MovePosition(newPosition)
	else
		local o = self.Holder:GetGameObject()

		if LuaUtility.GameObjectIsNullOrEmpty(o) then
			logError(string.format("【剧情】试图移动 npcID = %s的角色，但是角色没有找到实体", self.Holder.npcID))

			return
		end

		LuaUtility.SetTransformWithGameObject(o, newPosition)
	end

	if self.mazeMeetEnemyComponent and offsetX + offsetZ ~= 0 then
		self.absMoveX = self.absMoveX + math.abs(offsetX)
		self.absMoveZ = self.absMoveZ + math.abs(offsetZ)

		self.mazeMeetEnemyComponent:Processing(self.absMoveX + self.absMoveZ)
	end
end

function JoystickControl:SetMapMoveState(state, modifyVariable)
	self.IsMapMoveState = state
	self.MapNeedModify = modifyVariable

	if state == true then
		StoryModule.MapMoveControl = self
	end
end

function JoystickControl:GetIsControl()
	return self.IsControlling
end

function JoystickControl:SetMapMoveDistance(value)
	self.DyMapMoveDistance = value

	LuaUtility.SetBehaviorGlobalVariables(Constant.BehaviorGlobalDefine.LoopMapDistance, self.DyMapMoveDistance)
end

function JoystickControl:AddMazeMeetEnemyComponent()
	if self.mazeMeetEnemyComponent then
		return
	end

	local c = require("IQIGame.Components.MazeMeetEnemyComponent")

	self.mazeMeetEnemyComponent = c.New()
end

function JoystickControl:ClearAbsMove()
	self.absMoveX = 0
	self.absMoveZ = 0
end

function JoystickControl:OnDestroy()
	self:RemoveListener()
end

return JoystickControl
