-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkBirdGame\\AmusementParkBirdObstacleCell.lua

local m = {
	Speed = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.TopCollider2D = self.View.transform:Find("Top").gameObject:GetComponent(typeof(UnityEngine.Collider2D))
	self.BottomCollider2D = self.View.transform:Find("Bottom").gameObject:GetComponent(typeof(UnityEngine.Collider2D))

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	self.View.transform:Translate(Vector3.New(self.Speed * UnityEngine.Time.deltaTime * -1, 0, 0))
end

function m:SetData(speed)
	self.Speed = speed
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
