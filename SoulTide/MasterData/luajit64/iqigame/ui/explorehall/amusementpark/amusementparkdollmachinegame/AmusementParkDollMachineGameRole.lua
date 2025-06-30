-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkDollMachineGame\\AmusementParkDollMachineGameRole.lua

local m = {
	IsMoving = false,
	EntityId = 0,
	NextMovieTimer = 0,
	IsCreateRole = false,
	IsCatch = false,
	NextPos = Vector3.New(0, 0, 0)
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.OnShowSpineSuccessDelegate(sender, args)
		self:OnShowSpineSuccess(sender, args)
	end

	self.RoleCollider = self.View:GetComponent(typeof(UnityEngine.Collider2D))

	self:AddListener()
end

function m:AddListener()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.OnShowSpineSuccessDelegate)
end

function m:RemoveListener()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.OnShowSpineSuccessDelegate)
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	if not self.IsCreateRole then
		return
	end

	if self.RoleData == nil then
		return
	end

	if self.IsCatch then
		return
	end

	if not self.IsMoving then
		if PlayerModule.GetServerTime() > self.NextMovieTimer then
			self:StartMove()
		end

		return
	end

	local direction = self.NextPos - self.View.transform.localPosition

	if direction.magnitude > self.RoleData.roleRareSpeed then
		self.View.transform:Translate(direction.normalized * self.RoleData.roleRareSpeed * UnityEngine.Time.deltaTime)
		self:ChangeRoleOrderZ()
	else
		self:StopMove()
	end
end

function m:ChangeOrder()
	if self.RoleObj then
		local canvas = self.View:GetComponentInParent(typeof(UnityEngine.Canvas))

		setGameObjectLayers(self.RoleObj.transform, "UI")

		local renderers = self.RoleObj:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for i = 0, renderers.Length - 1 do
			renderers[i].sortingLayerID = LuaCodeInterface.SortingLayerNameToID("Default")
			renderers[i].sortingOrder = canvas.sortingOrder + 1
		end
	end
end

function m:OnShowSpineSuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		self.RoleObj = args.Entity.gameObject
		self.Animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		self.Animation.state:SetAnimation(0, "idle", true)
		self:StartMove()

		self.IsCreateRole = true

		self:ChangeOrder()
	end
end

function m:GetRandomPos()
	local rx = math.random(-self.View.transform.parent.rect.w / 2, self.View.transform.parent.rect.w / 2)
	local ry = math.random(-self.View.transform.parent.rect.h / 2, self.View.transform.parent.rect.h / 2)

	return Vector3.New(rx, ry, 0)
end

function m:StartMove()
	self.IsMoving = true
	self.NextPos = self:GetRandomPos()

	if self.Animation then
		self.Animation.state:SetEmptyAnimation(0, 0)
		self.Animation.state:SetAnimation(0, "walk", true)
	end

	self:RefreshWalkFaceTo()
end

function m:StopMove()
	self.IsMoving = false
	self.View.transform.localPosition = self.NextPos
	self.NextMovieTimer = math.random(0, 4) + PlayerModule.GetServerTime()

	if self.Animation then
		self.Animation.state:SetAnimation(0, "idle", true)
	end
end

function m:CatchState()
	self.IsMoving = false
	self.IsCatch = true

	if self.Animation then
		self.Animation.AnimationName = nil

		self.Animation.state:SetEmptyAnimation(0, 0)
		self.Animation.state:SetAnimation(0, "drag", true)
	end
end

function m:RefreshWalkFaceTo()
	local checkRet = self.NextPos.x - self.View.transform.localPosition.x
	local localScale = self.View.transform.localScale

	if checkRet > 0 then
		localScale.x = -math.abs(localScale.x)
	else
		localScale.x = math.abs(localScale.x)
	end

	self.View.transform.localScale = localScale
end

function m:SetData(roleData)
	self.RoleData = roleData
	self.IsCreateRole = false
	self.IsCatch = false

	for i = 1, 4 do
		self["Quality" .. i]:SetActive(self.RoleData.roleRare == i)
	end

	self.View.name = self.RoleData.cid

	local pos = self:GetRandomPos()

	self.View.transform.localPosition = pos

	self:ChangeRoleOrderZ()

	self.NextPos = self:GetRandomPos()

	self:ShowSpine()
end

function m:ChangeRoleOrderZ()
	local pos = self.View.transform.localPosition

	self.OrderZ.transform.localPosition = Vector3.New(0, 0, (pos.y + 150) / 100)
end

function m:ShowSpine()
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, self.RoleData:GetCfgData().PlayerSpine, 0, self.SpineRoot.transform, Vector3.zero)
end

function m:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end

	self.RoleObj = nil
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self:HideEntity()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
