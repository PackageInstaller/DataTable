-- chunkname: @IQIGame\\Scene\\Memory\\Role.lua

local Role = {
	entityId = 0,
	walkSpeed = 0.1
}

function Role.New(view)
	local obj = Clone(Role)

	obj:Init(view)

	return obj
end

function Role:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.rigidbody2D = self.View:GetComponent("Rigidbody2D")
	self.collider = self.View:GetComponent(typeof(UnityEngine.Collider2D))

	function self.onShowRoleSuccessDelegate(sender, args)
		self:OnShowRoleSuccess(sender, args)
	end

	function self.onJoystickMoveDelegate(value)
		self:OnJoystickMove(value)
	end

	self:OnAddListener()
end

function Role:Refresh(cfgChapterData, cameraCtrl)
	self.cfgChapterData = cfgChapterData
	self.cameraCtrl = cameraCtrl
	self.enableWalk = false
	self.curAnim = nil

	self:ShowRole()
end

function Role:OnUpdate()
	if self.enableWalk then
		self.rigidbody2D:MovePosition(Vector2.New(self.View.transform.localPosition.x + self.walkSpeed, self.View.transform.localPosition.y))
		self.cameraCtrl:SetCameraPosX(self.View.transform.localPosition.x)
	end
end

function Role:OnDestroy()
	self:OnRemoveListener()
	self:StopWalk()

	if self.entityId ~= 0 then
		GameEntry.Entity:HideEntity(self.entityId)

		self.entityId = 0
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function Role:OnAddListener()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onShowRoleSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.JoystickMove, self.onJoystickMoveDelegate)
end

function Role:OnRemoveListener()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onShowRoleSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.JoystickMove, self.onJoystickMoveDelegate)
end

function Role:OnJoystickMove(value)
	if value.x ~= 0 then
		self:Walk(value)
	else
		self:StopWalk()
	end
end

function Role:ShowRole()
	self.entityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowElement(self.entityId, self.cfgChapterData.SceneEntity, 0, self.goSpineRoot.transform, Vector3.zero)
end

function Role:OnShowRoleSuccess(sender, args)
	if self.entityId ~= args.Entity.Id then
		return
	end

	self.animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

	self:PlayAnim("idle")
end

function Role:Walk(value)
	self.enableWalk = true

	local localScale = self.View.transform.localScale

	if value.x < 0 then
		localScale.x = math.abs(localScale.x)
		self.walkSpeed = -math.abs(self.walkSpeed)
	elseif value.x > 0 then
		localScale.x = -math.abs(localScale.x)
		self.walkSpeed = math.abs(self.walkSpeed)
	end

	self.View.transform.localScale = localScale

	self:PlayAnim("run")
end

function Role:StopWalk()
	self.enableWalk = false

	self:PlayAnim("idle")
end

function Role:PlayAnim(name)
	if self.curAnim == name then
		return
	end

	self.curAnim = name

	self.animation.state:SetAnimation(0, name, true)
end

return Role
