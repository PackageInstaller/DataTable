-- chunkname: @IQIGame\\Scene\\Survival\\SurvivalFlyGameBullet.lua

local m = {
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
		if self.targetEnemyInstanceID ~= nil then
			local targetMonster = FlyGameModule.survivalFlyGameScene.gameManager:GetEnemyByInstanceID(self.targetEnemyInstanceID)

			if targetMonster then
				local targetPosition = Vector2.New(targetMonster.View.transform.position.x, targetMonster.View.transform.position.y)
				local direction = targetPosition - Vector2.New(self.View.transform.position.x, self.View.transform.position.y)
				local angle = Mathf.Atan2(direction.y, direction.x) * (180 / Mathf.PI)

				self.View.transform.rotation = Quaternion.AngleAxis(angle, Vector3.New(0, 0, 1))
			end
		elseif self.bulletData:IsTrackingBullet() then
			self.targetEnemyInstanceID = self:GetRandomMonster()
		end

		self.View.transform:Translate(Vector3.New(self.moveSpeed.x * UnityEngine.Time.deltaTime, self.moveSpeed.y * UnityEngine.Time.deltaTime, 0))
	end
end

function m:SetData(pos, bulletData, callback)
	self.bulletData = bulletData
	self.moveSpeed = bulletData.moveSpeed
	self.View.transform.position = pos

	self.PlayerBullet:SetActive(self.bulletData.launcher == FlyGameConstant.ObjectType.FlyGame_Player)
	self.EnemyBullet:SetActive(self.bulletData.launcher == FlyGameConstant.ObjectType.FlyGame_Enemy)

	local cfgFlightBulletPath = CfgSurvivalChallengeBulletPathTable[self.bulletData.bulletPathID]

	if self.bulletData.launcher == FlyGameConstant.ObjectType.FlyGame_Enemy then
		for i = 1, self.EnemyBullet.transform.childCount do
			self["EnemyBullet" .. i]:SetActive(i == cfgFlightBulletPath.BulletEffect)
		end
	elseif self.bulletData.launcher == FlyGameConstant.ObjectType.FlyGame_Player then
		for i = 1, self.PlayerBullet.transform.childCount do
			self["PlayerBullet" .. i]:SetActive(i == cfgFlightBulletPath.BulletEffect)
		end
	end

	self.View:SetActive(true)

	self.recycleBulletCallBack = callback
	self.active = true
	self.targetEnemyInstanceID = self:GetRandomMonster()
end

function m:GetRandomMonster()
	local targetID

	if self.bulletData then
		local isTracking = self.bulletData:IsTrackingBullet()

		if isTracking then
			targetID = FlyGameModule.survivalFlyGameScene.gameManager:GetRandomEnemy(self.bulletData:GetCfgData().BulletType)

			if targetID ~= nil then
				local targetMonster = FlyGameModule.survivalFlyGameScene.gameManager:GetEnemyByInstanceID(targetID)

				if targetMonster then
					targetMonster:AddTrackingBullet(self.selfInstanceID)
				end
			end
		end
	end

	return targetID
end

function m:Reset()
	if self.targetEnemyInstanceID then
		local targetMonster = FlyGameModule.survivalFlyGameScene.gameManager:GetEnemyByInstanceID(self.targetEnemyInstanceID)

		if targetMonster then
			targetMonster:RemoveTrackingBullet(self.selfInstanceID)
		end
	end

	self.targetEnemyInstanceID = nil
	self.bulletData = nil
	self.recycleBulletCallBack = nil
	self.View.transform.position = self.startPosition
	self.View.transform.rotation = self.startRotation
	self.active = false

	self.View:SetActive(false)
end

function m:Dispose()
	self.recycleBulletCallBack = nil
	self.collider2D = nil
	self.bulletData = nil
	self.selfInstanceID = nil
	self.targetEnemyInstanceID = nil

	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
