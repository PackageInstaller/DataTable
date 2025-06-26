-- chunkname: @IQIGame\\Module\\CommonActivity\\FlightChallenge\\FlightGame\\FlightGameEnemyData.lua

local m = {}

function m.New(monsterID)
	local o = Clone(m)

	o:Init(monsterID)

	return o
end

function m:Init(monsterID)
	self.monsterID = monsterID
end

function m:GetConfigData()
	return CfgFlightChallengeMonsterTable[self.monsterID]
end

function m:GetChallengeEnemyAttr(attrID)
	local cfgData = self:GetConfigData()

	for i = 1, #cfgData.AttType do
		if cfgData.AttType[i] == attrID then
			return cfgData.AttValue[i]
		end
	end

	return 1
end

return m
