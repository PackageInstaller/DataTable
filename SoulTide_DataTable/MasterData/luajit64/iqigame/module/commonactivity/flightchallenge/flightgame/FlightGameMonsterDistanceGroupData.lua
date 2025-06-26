-- chunkname: @IQIGame\\Module\\CommonActivity\\FlightChallenge\\FlightGame\\FlightGameMonsterDistanceGroupData.lua

local m = {}

function m.New(cid, index)
	local o = Clone(m)

	o:Init(cid, index)

	return o
end

function m:Init(cid, index)
	self.cid = cid
	self.index = index
end

function m:GetConfigData()
	return CfgFlightChallengeMonsterCreateDistanceTable[self.cid]
end

function m:GetRandomMonster()
	local randomMonsters = {}

	for i = 1, self:GetConfigData().MonsterNum do
		local randomNum = math.random(1, #self:GetConfigData().MonsterGroup)
		local id = self:GetConfigData().MonsterGroup[randomNum]

		table.insert(randomMonsters, id)
	end

	return randomMonsters
end

function m:IsCurrentThisGroup(distance)
	if distance >= self:GetConfigData().Distance[1] and distance < self:GetConfigData().Distance[2] then
		return true
	end

	return false
end

return m
