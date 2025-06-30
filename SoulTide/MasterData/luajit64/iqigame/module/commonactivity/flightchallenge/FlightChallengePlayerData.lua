-- chunkname: @IQIGame\\Module\\CommonActivity\\FlightChallenge\\FlightChallengePlayerData.lua

local m = {}

function m.New(cid, flightChallengeMechaPOD)
	local o = Clone(m)

	o:Init(cid, flightChallengeMechaPOD)

	return o
end

function m:Init(cid, flightChallengeMechaPOD)
	self.cid = cid
	self.flightChallengeMechaPOD = flightChallengeMechaPOD
end

function m:GetConfigData()
	return CfgFlightChallengePlayerTable[self.cid]
end

function m:GetChallengePlayerAttr(attrID)
	if self.flightChallengeMechaPOD and self.flightChallengeMechaPOD.growthAttribute then
		local num = string.format("%.2f", self.flightChallengeMechaPOD.growthAttribute[attrID])

		return tonumber(num)
	end

	local cfgData = self:GetConfigData()

	for i = 1, #cfgData.AttType do
		if cfgData.AttType[i] == attrID then
			return cfgData.AttValue[i]
		end
	end

	return 0
end

function m:CanBeUpgraded()
	local materialIds = FlightChallengeModule.flightPlayerUpdateSpend[self.cid]

	for j = 1, #materialIds do
		local id = materialIds[j]
		local itemID = CfgFlightChallengeElementTable[id].ItemID
		local num = WarehouseModule.GetItemNumByCfgID(itemID)

		if num > 0 then
			return true
		end
	end

	return false
end

function m:GetAddSkillTypeValue(type)
	local value = 0

	if self:GetConfigData().SkillType == type then
		value = self:GetConfigData().SkillNun
	end

	return value
end

return m
