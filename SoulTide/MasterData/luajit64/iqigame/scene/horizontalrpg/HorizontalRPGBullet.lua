-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\HorizontalRPGBullet.lua

local m = {
	playEndEffect = true,
	active = false,
	moveSpeed = Vector2.New(20, 0)
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.collider2D = self.View:GetComponent(typeof(UnityEngine.Collider2D))
	self.selfInstanceID = self.View:GetInstanceID()
	self.startPosition = self.View.transform.position
	self.startRotation = self.View.transform.rotation
	self.startLocalScale = self.View.transform.localScale

	self:AddListener()
	self:Reset(false)
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:FrameUpdate()
	if self.active then
		self.View.transform:Translate(Vector3.New(self.moveSpeed.x * UnityEngine.Time.deltaTime, self.moveSpeed.y * UnityEngine.Time.deltaTime, 0))
		self:CheckBulletCollision()
	end
end

function m:SetData(pos, bulletData, callback)
	self.bulletData = bulletData
	self.moveSpeed = bulletData.moveSpeed
	self.View.transform.position = pos

	local scaleX = self.startLocalScale.x * bulletData.dir

	self.View.transform.localScale = Vector3.New(scaleX, self.startLocalScale.y, self.startLocalScale.z)

	self.PlayerBullet:SetActive(self.bulletData.launcher == HorizontalRPGConstant.ObjectType.HorizontalRPG_Player)
	self.EnemyBullet:SetActive(self.bulletData.launcher == HorizontalRPGConstant.ObjectType.HorizontalRPG_Element)
	self.View:SetActive(true)

	self.recycleBulletCallBack = callback
	self.active = true
end

function m:CheckBulletCollision()
	local wordPoint = self.View.transform.position
	local hits = LuaCodeInterface.RaycastAll(wordPoint, Vector2.zero)

	for i = 0, hits.Length - 1 do
		local hit = hits[i]

		if hit and hit.collider.gameObject.tag == HorizontalRPGConstant.ObjectTags.HorizontalRPGPlatform and self.recycleBulletCallBack then
			self.recycleBulletCallBack(self)
		end
	end
end

function m:CheckPlayerBoundsIntersects(collider2Ds)
	for i, collider2D in pairs(collider2Ds) do
		local res = self.collider2D.bounds:Intersects(collider2D.bounds)

		if res then
			return true
		end
	end

	return false
end

function m:Reset(isPlayEffect, callback)
	self.callback = callback

	self.PlayerBulletEffect:SetActive(false)
	self.EnemyBulletEffect:SetActive(false)
	self.BulletObj:SetActive(false)

	if isPlayEffect then
		self.playEndEffect = false

		if self.bulletData.launcher == HorizontalRPGConstant.ObjectType.HorizontalRPG_Element then
			self.EnemyBulletEffect:SetActive(true)
		elseif self.bulletData.launcher == HorizontalRPGConstant.ObjectType.HorizontalRPG_Player then
			self.PlayerBulletEffect:SetActive(true)
		end

		local timer = Timer.New(function()
			self:RecycleReset()
		end, 1)

		timer:Start()
	else
		self:RecycleReset()
	end

	self.active = false
end

function m:RecycleReset()
	self.bulletData = nil
	self.recycleBulletCallBack = nil
	self.playEndEffect = true

	if self.View and not LuaCodeInterface.GameObjIsDestroy(self.View) then
		self.PlayerBulletEffect:SetActive(false)
		self.EnemyBulletEffect:SetActive(false)

		self.View.transform.position = self.startPosition
		self.View.transform.rotation = self.startRotation
		self.View.transform.localScale = self.startLocalScale

		self.BulletObj:SetActive(true)
		self.View:SetActive(false)
	end

	if self.callback then
		self.callback(self)
	end
end

function m:Dispose()
	self.recycleBulletCallBack = nil
	self.collider2D = nil
	self.bulletData = nil
	self.selfInstanceID = nil
	self.callback = nil

	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
