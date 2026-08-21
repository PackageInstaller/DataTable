-- chunkname: @IQIGame\\Scene\\FlightChallenge\\FlightGameBullet.lua

local m = {
	active = false,
	rotateSpeed = 2,
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
	self.startPosition = self.View.transform.position
	self.startRotation = self.View.transform.rotation

	self:AddListener()
	self:Reset()
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
	end
end

function m:SetData(pos, bulletData, callback)
	self.bulletData = bulletData
	self.moveSpeed = bulletData.moveSpeed
	self.View.transform.position = pos

	self.PlayerBullet:SetActive(self.bulletData.launcher == FlightGameConstant.ObjectType.FlightGame_Player)
	self.EnemyBullet:SetActive(self.bulletData.launcher == FlightGameConstant.ObjectType.FlightGame_Enemy)

	if self.bulletData.launcher == FlightGameConstant.ObjectType.FlightGame_Enemy then
		local cfgFlightBulletPath = CfgFlightChallengeBulletPathTable[self.bulletData.bulletPathID]

		for i = 1, self.EnemyBullet.transform.childCount do
			self["EnemyBullet" .. i]:SetActive(i == cfgFlightBulletPath.BulletEffect)
		end
	elseif self.bulletData.launcher == FlightGameConstant.ObjectType.FlightGame_Player then
		local cfg = CfgFlightChallengePlayerTable[self.bulletData.cid]

		for i = 1, self.PlayerBullet.transform.childCount do
			self["PlayerBullet" .. i]:SetActive(i == cfg.BulletEffect)
		end
	end

	self.View:SetActive(true)

	self.recycleBulletCallBack = callback
	self.active = true
end

function m:Reset()
	self.bulletData = nil
	self.recycleBulletCallBack = nil
	self.View.transform.position = self.startRotation
	self.View.transform.rotation = self.startRotation
	self.active = false

	self.View:SetActive(false)
end

function m:Dispose()
	self.recycleBulletCallBack = nil
	self.collider2D = nil
	self.bulletData = nil

	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
