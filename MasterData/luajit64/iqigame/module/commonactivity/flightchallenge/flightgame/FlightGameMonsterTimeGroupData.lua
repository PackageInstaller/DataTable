-- chunkname: @IQIGame\\Module\\CommonActivity\\FlightChallenge\\FlightGame\\FlightGameMonsterTimeGroupData.lua

local m = {}

function m.New(cid, time)
	local o = Clone(m)

	o:Init(cid, time)

	return o
end

function m:Init(cid, time)
	self.cid = cid
	self.time = time
end

function m:GetConfigData()
	return CfgFlightChallengeMonsterCreateTimeTable[self.cid]
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

return m
