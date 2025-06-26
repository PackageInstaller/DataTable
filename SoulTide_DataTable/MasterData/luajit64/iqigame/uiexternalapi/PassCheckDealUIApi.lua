-- chunkname: @IQIGame\\UIExternalApi\\PassCheckDealUIApi.lua

PassCheckDealUIApi = BaseLangApi:Extend()

function PassCheckDealUIApi:Init()
	self:RegisterApi("baseTitle", self.GetBaseTitle)
	self:RegisterApi("superTitle", self.GetSuperTitle)
	self:RegisterApi("desc", self.GetDesc)
	self:RegisterApi("superDesc", self.GetSuperDesc)
	self:RegisterApi("superDiscount", self.GetSuperDiscount)
end

function PassCheckDealUIApi:GetDesc()
	return self:GetCfgText(3501001)
end

function PassCheckDealUIApi:GetSuperDiscount(originalCost, curCost)
	return string.format(self:GetCfgText(3501005), math.floor(curCost / originalCost))
end

function PassCheckDealUIApi:GetSuperDesc()
	return self:GetCfgText(3501002)
end

function PassCheckDealUIApi:GetBaseTitle()
	return self:GetCfgText(3501003)
end

function PassCheckDealUIApi:GetSuperTitle()
	return self:GetCfgText(3501004)
end

PassCheckDealUIApi:Init()
