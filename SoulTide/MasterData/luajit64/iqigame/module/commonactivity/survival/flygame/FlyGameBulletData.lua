-- chunkname: @IQIGame\\Module\\CommonActivity\\Survival\\FlyGame\\FlyGameBulletData.lua

local m = {
	launcher = 0,
	hurt = 10,
	bulletPathID = 0,
	cid = 0,
	moveSpeed = Vector2.New(20, 0)
}

function m.New(cid, hurt, launcher, moveSpeed, bulletPathID)
	local obj = Clone(m)

	obj:Init(cid, hurt, launcher, moveSpeed, bulletPathID)

	return obj
end

function m:Init(cid, hurt, launcher, moveSpeed, bulletPathID)
	self.cid = cid
	self.hurt = hurt
	self.launcher = launcher
	self.moveSpeed = moveSpeed
	self.bulletPathID = bulletPathID
end

function m:GetCfgData()
	return CfgSurvivalChallengeBulletPathTable[self.bulletPathID]
end

function m:IsTrackingBullet()
	if self.launcher == FlyGameConstant.ObjectType.FlyGame_Player and (self:GetCfgData().BulletType == FlyGameConstant.BulletType.Bullet_Fast or self:GetCfgData().BulletType == FlyGameConstant.BulletType.Bullet_Slow_Speed) then
		return true
	end

	return false
end

return m
