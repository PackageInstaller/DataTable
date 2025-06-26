-- chunkname: @IQIGame\\Module\\CommonActivity\\FlightChallenge\\FlightGame\\FlightGameRewardBoxData.lua

local m = {}

function m.New(specialCid, createTime)
	local o = Clone(m)

	o:Init(specialCid, createTime)

	return o
end

function m:Init(specialCid, createTime)
	self.specialCid = specialCid
	self.createTime = createTime
end

function m:GetConfigData()
	return CfgFlightChallengeSpecialItemTable[self.specialCid]
end

function m:GetChallengeRewardBoxAttr(attrID)
	local cfgData = self:GetConfigData()

	for i = 1, #cfgData.AttType do
		if cfgData.AttType[i] == attrID then
			return cfgData.AttValue[i]
		end
	end

	return 1
end

function m:SetStartEffectTime(time)
	self.effectStartTime = time
	self.effectEndTime = self.effectStartTime + self:GetConfigData().Duration
end

function m:IsTakeEffect()
	if self:GetConfigData().Duration > 0 and PlayerModule.GetServerTime() < self.effectEndTime then
		return true
	end

	return false
end

return m
