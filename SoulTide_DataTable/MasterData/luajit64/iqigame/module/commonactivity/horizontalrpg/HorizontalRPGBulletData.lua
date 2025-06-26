-- chunkname: @IQIGame\\Module\\CommonActivity\\HorizontalRPG\\HorizontalRPGBulletData.lua

local m = {
	launcher = 0,
	bulletPathID = 0,
	dir = 1,
	firePayerID = 0,
	moveSpeed = Vector2.New(20, 0)
}

function m.New(firePayerID, launcher, bulletPathID, dir)
	local obj = Clone(m)

	obj:Init(firePayerID, launcher, bulletPathID, dir)

	return obj
end

function m:Init(firePayerID, launcher, bulletPathID, dir)
	self.firePayerID = firePayerID
	self.launcher = launcher
	self.bulletPathID = bulletPathID
	self.dir = dir
	self.moveSpeed = Vector2.New(self.dir * self:GetCfgData().ShootSpeed, 0)
end

function m:GetCfgData()
	return CfgHorizontalRPGBulletTable[self.bulletPathID]
end

return m
