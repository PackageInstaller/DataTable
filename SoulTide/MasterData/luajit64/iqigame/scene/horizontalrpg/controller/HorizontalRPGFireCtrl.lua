-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\Controller\\HorizontalRPGFireCtrl.lua

local m = {
	lastAttackTime = 0,
	downPos = Vector3.New(-10, 4.9, 0),
	flyPos = Vector3.New(-10, 4.5, 0)
}

function m.New(firePos, bulletNode, controller)
	local obj = Clone(m)

	obj:Init(firePos, bulletNode, controller)

	return obj
end

function m:Init(firePos, bulletNode, controller)
	self.firePos = firePos
	self.defaultFirPos = self.firePos.transform.localPosition
	self.bulletNode = bulletNode
	self.controller = controller
end

function m:SetBulletData(bulletData)
	self.bulletData = bulletData
end

function m:FrameUpdate()
	if self.bulletData and self.bulletData:GetCfgData().IsLoop and self.bulletData.launcher == HorizontalRPGConstant.ObjectType.HorizontalRPG_Element and UnityEngine.Time.realtimeSinceStartup - self.lastAttackTime > self.bulletData:GetCfgData().ShootCd then
		self.lastAttackTime = UnityEngine.Time.realtimeSinceStartup

		self:Fire()
	end
end

function m:Fire(state)
	if HorizontalRPGModule.horizontalRPGScene.IsLockInput then
		return
	end

	if state == HorizontalRPGConstant.PlayerState.shoot2 then
		self.firePos.transform.localPosition = self.downPos
	elseif state == HorizontalRPGConstant.PlayerState.shoot3 then
		self.firePos.transform.localPosition = self.flyPos
	else
		self.firePos.transform.localPosition = self.defaultFirPos
	end

	if self.bulletData then
		if self.bulletData:GetCfgData().Shoot == nil or self.bulletData:GetCfgData().Shoot == 0 then
			self:AttackDoubleLine()
		else
			self:AttackRange()
		end

		if self.bulletData.launcher == HorizontalRPGConstant.ObjectType.HorizontalRPG_Element then
			self.controller:ChangeState(HorizontalRPGConstant.ElementState.action)
		end

		if self.bulletData.launcher == HorizontalRPGConstant.ObjectType.HorizontalRPG_Player then
			GameEntry.Sound:PlaySound(HorizontalRPGConstant.Sound.Shot, Constant.SoundGroup.CHARACTER)

			if GameEntry.Base.DevMode then
				log("播放射击音效 " .. HorizontalRPGConstant.Sound.Shot)
			end
		end
	end
end

function m:AttackDoubleLine()
	local num = self.bulletData:GetCfgData().ShootBulletNum
	local offset = 0
	local spacing = 8.6

	if num % 2 == 0 then
		offset = spacing / 2
	end

	for i = 0, num - 1 do
		local pos = self.firePos.transform.position
		local bulletCell = HorizontalRPGModule.horizontalRPGScene.HorizontalSceneObjManager:GetBullet()

		bulletCell.View.transform:SetParent(self.bulletNode.transform, false)

		if self.bulletData:GetCfgData().Angle > 0 then
			bulletCell.View.transform:Rotate(0, 0, self.bulletData:GetCfgData().Angle)
		end

		if i == 0 then
			pos = Vector3.New(pos.x, pos.y + spacing * i - offset, pos.z)
		elseif i % 2 == 1 then
			pos = Vector3.New(pos.x, pos.y + spacing * math.ceil(i / 2) - offset, pos.z)
		else
			pos = Vector3.New(pos.x, pos.y - spacing * math.ceil(i / 2) - offset, pos.z)
		end

		bulletCell:SetData(pos, self.bulletData, function(bullet)
			HorizontalRPGModule.horizontalRPGScene.HorizontalSceneObjManager:RecycleBullet(bullet)
		end)
	end
end

function m:AttackRange()
	local num = self.bulletData:GetCfgData().ShootBulletNum
	local angle = self.bulletData:GetCfgData().Shoot
	local offset = 0

	if self.bulletData:GetCfgData().Angle > 0 then
		offset = self.bulletData:GetCfgData().Angle
	end

	if num % 2 == 0 then
		offset = angle / 2
	end

	for i = 0, num - 1 do
		local pos = self.firePos.transform.position
		local bulletCell = HorizontalRPGModule.horizontalRPGScene.HorizontalSceneObjManager:GetBullet()

		bulletCell.View.transform:SetParent(self.bulletNode.transform, false)

		if i == 0 then
			bulletCell.View.transform:Rotate(0, 0, angle * i - offset)
		elseif i % 2 == 1 then
			bulletCell.View.transform:Rotate(0, 0, angle * math.ceil(i / 2) - offset)
		else
			bulletCell.View.transform:Rotate(0, 0, -angle * math.ceil(i / 2) - offset)
		end

		bulletCell:SetData(Vector3.New(pos.x, pos.y, pos.z), self.bulletData, function(bullet)
			HorizontalRPGModule.horizontalRPGScene.HorizontalSceneObjManager:RecycleBullet(bullet)
		end)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
end

return m
