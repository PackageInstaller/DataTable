-- chunkname: @IQIGame\\UI\\MonsterAcademyGame\\FruitGameFallingObjectItem.lua

local m = {
	diePositionY = 0,
	seconds = 0,
	IsFree = false,
	IsAlive = false
}

function m.New(viewRoot, itemId)
	local obj = Clone(m)

	obj:__Init(viewRoot, itemId)

	return obj
end

function m:__Init(viewRoot, itemId)
	self.IsAlive = false
	self.IsFree = true
	self.ViewRoot = viewRoot
	self.diePositionY = UnityEngine.Screen.height * -1

	LuaCodeInterface.BindOutlet(self.ViewRoot, self)

	self.boxCollider = self.ViewRoot.gameObject:GetComponent(typeof(UnityEngine.Collider2D))
	self.Cfg = CfgGalgameMonsterFruitsListTable[itemId]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.Cfg.Icon), self.Icon.gameObject:GetComponent("UnityEngine.UI.Image"))

	local screenRatio = 750 / UnityEngine.Screen.height

	self.diePositionY = UnityEngine.Screen.height * screenRatio * -1
end

function m:OnActivation(position)
	self.ViewRoot.transform.localPosition = position

	self.ViewRoot.gameObject:SetActive(true)

	self.IsAlive = true
	self.IsFree = false
	self.seconds = 0
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	if not self.IsAlive then
		return
	end

	self.seconds = self.seconds + realElapseSeconds

	local pos = Clone(self.ViewRoot.transform.localPosition)

	pos.y = pos.y - self.Cfg.BaseSpeed - self.Cfg.BaseSpeed * self.Cfg.AddSpeed * self.seconds
	self.ViewRoot.transform.localPosition = pos

	if pos.y < self.diePositionY then
		self:SetFree()
	end
end

function m:SetFree()
	self.ViewRoot.gameObject:SetActive(false)

	self.IsFree = true
	self.IsAlive = false
end

function m:ColliderBoundsIntersects(collider)
	if LuaCodeInterface.GameObjIsDestroy(self.boxCollider) or LuaCodeInterface.GameObjIsDestroy(collider) then
		return false
	end

	if not self.IsAlive then
		return false
	end

	return self.boxCollider.bounds:Intersects(collider.bounds)
end

function m:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.ViewRoot, self)
	UnityEngine.GameObject.Destroy(self.ViewRoot.gameObject)

	self.ViewRoot = nil
	self.boxCollider = nil
end

return m
