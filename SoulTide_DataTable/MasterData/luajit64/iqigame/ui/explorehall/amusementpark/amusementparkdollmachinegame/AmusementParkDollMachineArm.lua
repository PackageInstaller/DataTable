-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkDollMachineGame\\AmusementParkDollMachineArm.lua

local m = {
	CatchSpeed = 9,
	MoveSpeed = 6,
	IsCatching = false,
	Dir = 1,
	MaxPosX = 425,
	IsMove = false,
	MinPosX = -425,
	CatchDir = -1,
	CatchEnd = false,
	CatchRoles = {}
}

function m.New(view, rootUI)
	local obj = Clone(m)

	obj:Init(view, rootUI)

	return obj
end

function m:Init(view, rootUI)
	self.View = view
	self.RootUI = rootUI

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ArmCollider2D = self.CollisionNode:GetComponent(typeof(UnityEngine.Collider2D))
	self.HandGrabCollider2D = self.GrabItNode:GetComponent(typeof(UnityEngine.Collider2D))

	self:AddListener()
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.IsCatching then
		self.CollisionNode.transform:Translate(Vector3.New(0, self.CatchSpeed * self.CatchDir * UnityEngine.Time.deltaTime, 0))

		local top = self:CheckCatch()

		if top then
			self.CatchDir = 1

			if not self.CatchEnd then
				self.CatchEnd = true
				self.CatchRoles = self:CheckCatchRoleResult()
			end
		end

		if self.CollisionNode.transform.localPosition.y >= 0 then
			self.CollisionNode.transform.localPosition = Vector3.New(0, 0, 0)
			self.IsCatching = false
			self.CatchEnd = false

			self.RootUI:CleanRoles(self.CatchRoles)
		end
	elseif self.IsMove then
		if self.View.transform.localPosition.x >= self.MaxPosX then
			self.Dir = -1
		elseif self.View.transform.localPosition.x <= self.MinPosX then
			self.Dir = 1
		end

		self.View.transform:Translate(Vector3.New(self.MoveSpeed * self.Dir * UnityEngine.Time.deltaTime, 0, 0))
	end
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:ResetGame()
	self.IsMove = false
	self.Dir = 1
	self.View.transform.localPosition = Vector3.New(self.MinPosX, self.View.transform.localPosition.y, self.View.transform.localPosition.z)
	self.IsCatching = false
	self.CatchEnd = false
	self.CatchDir = -1
	self.CollisionNode.transform.localPosition = Vector3.New(0, 0, 0)
	self.CatchRoles = {}
end

function m:StartMoveArm()
	if self.IsCatching then
		return
	end

	self.IsMove = true

	GameEntry.Sound:PlaySound(10901, Constant.SoundGroup.UI)
end

function m:StopMoveAndStartCatch()
	self.IsMove = false
	self.IsCatching = true
	self.CatchDir = -1
	self.CollisionNode.transform.localPosition = Vector3.New(0, 0, 0)

	GameEntry.Sound:PlaySound(10902, Constant.SoundGroup.UI)
end

function m:CheckCatch()
	local top = false

	for i, v in pairs(self.RootUI.GameRoles) do
		top = self:CheckArmBoundsIntersects(v.RoleCollider)

		if top then
			return top
		end
	end

	top = self:CheckArmBoundsIntersects(self.RootUI.GroundCollider)

	return top
end

function m:CheckCatchRoleResult()
	local roles = {}

	for i, v in pairs(self.RootUI.GameRoles) do
		local top = self.HandGrabCollider2D.bounds:Intersects(v.RoleCollider.bounds)

		if top then
			v.View.transform:SetParent(self.RolesNode.transform, false)

			v.View.transform.localPosition = Vector3.New(0, 0, 0)

			table.insert(roles, v.RoleData)
			v:CatchState()
		end
	end

	return roles
end

function m:CheckArmBoundsIntersects(collider2D)
	return self.ArmCollider2D.bounds:Intersects(collider2D.bounds)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	self.IsMove = false
	self.CatchRoles = {}
	self.IsCatching = false

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
