-- chunkname: @IQIGame\\Module\\CommonActivity\\FlightChallenge\\FlightGame\\FlightGameBulletData.lua

local m = {
	launcher = 0,
	hurt = 10,
	bulletPathID = 0,
	cid = 0,
	moveSpeed = Vector2.New(20, 0)
}

function m.New(cid, hurt, launcher, moveSpeed, bulletPathID)
	local obj = Clone(m)

	obj.cid = cid
	obj.hurt = hurt
	obj.launcher = launcher
	obj.moveSpeed = moveSpeed
	obj.bulletPathID = bulletPathID

	return obj
end

function m:AddHurtByMonsterType(monsterType)
	local value = 0

	if self.launcher == FlightGameConstant.ObjectType.FlightGame_Player then
		local cfgChallengePlayer = CfgFlightChallengePlayerTable[self.cid]

		if cfgChallengePlayer.DamageBonus[1] == monsterType then
			value = cfgChallengePlayer.DamageBonus[2]
		end
	end

	return value
end

return m
