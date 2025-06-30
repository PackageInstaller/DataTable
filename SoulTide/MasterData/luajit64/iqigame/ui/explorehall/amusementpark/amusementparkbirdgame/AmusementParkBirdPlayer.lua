-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkBirdGame\\AmusementParkBirdPlayer.lua

local m = {
	Speed = 0,
	Acceleration = 0,
	StartPos = Vector3.New(0, 0, 0)
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.BirdCollider2D = self.View:GetComponent(typeof(UnityEngine.Collider2D))
	self.Rigidbody2D = self.View:GetComponent("Rigidbody2D")
	self.Rigidbody2D.simulated = false
	self.StartPos = self.View.transform.localPosition
	self.SkeletonAnimationState = self.View:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic)).AnimationState
	self.Acceleration = -AmusementParkBirdGameModule.apBirdGameData:GetCfgData().VerticalDownAcceleration

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Speed = self.Speed + self.Acceleration

	local pos = self.View.transform.localPosition

	pos.y = pos.y + self.Speed * UnityEngine.Time.deltaTime
	self.View.transform.localPosition = pos
end

function m:SetData(acceleration, speed)
	self.Acceleration = acceleration

	if speed then
		self.Speed = speed
	end

	self.SkeletonAnimationState:SetEmptyAnimation(0, 0)
	self.SkeletonAnimationState:SetAnimation(0, "tapup", true)
end

function m:ResetPlayer()
	self.Rigidbody2D.simulated = false
	self.View.transform.localPosition = self.StartPos
	self.View.transform.localRotation = Vector3.New(0, 0, 0)
	self.Speed = 0
	self.Acceleration = -AmusementParkBirdGameModule.apBirdGameData:GetCfgData().VerticalDownAcceleration

	self.SkeletonAnimationState:SetEmptyAnimation(0, 0)
	self.SkeletonAnimationState:SetAnimation(0, "down", true)
end

function m:PlayerDead()
	self.Rigidbody2D.simulated = true

	self.SkeletonAnimationState:SetEmptyAnimation(0, 0)
	self.SkeletonAnimationState:SetAnimation(0, "over", false)
end

function m:CheckBirdBoundsIntersects(collider2D)
	return self.BirdCollider2D.bounds:Intersects(collider2D.bounds)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
