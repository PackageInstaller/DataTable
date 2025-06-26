-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkBirdGame\\AmusementParkBirdBG.lua

local m = {
	BgSpeed = 1,
	StartMove = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetSpeed(speed)
	self.BgSpeed = speed
end

function m:SetStartMove(top)
	self.StartMove = top
end

function m:ResetPos()
	self.StartMove = false
	self.View.transform.localPosition = Vector3.New(0, 0, 0)
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	if not self.StartMove then
		return
	end

	self.View.transform:Translate(Vector3.New(self.BgSpeed * UnityEngine.Time.deltaTime * -1, 0, 0))

	if self.View.transform.localPosition.x < -1353 then
		self.View.transform.localPosition = Vector3.New(0, 0, 0)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
