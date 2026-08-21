-- chunkname: @IQIGame\\UIExternalApi\\PassCheckRewardListUIApi.lua

PassCheckRewardListUIApi = BaseLangApi:Extend()

function PassCheckRewardListUIApi:Init()
	self:RegisterApi("title", self.GetTitle)
	self:RegisterApi("baseTitle", self.GetBaseTitle)
	self:RegisterApi("superTitle", self.GetSuperTitle)
end

function PassCheckRewardListUIApi:GetTitle()
	return self:GetCfgText(3501401)
end

function PassCheckRewardListUIApi:GetBaseTitle()
	return self:GetCfgText(3501402)
end

function PassCheckRewardListUIApi:GetSuperTitle()
	return self:GetCfgText(3501403)
end

PassCheckRewardListUIApi:Init()
