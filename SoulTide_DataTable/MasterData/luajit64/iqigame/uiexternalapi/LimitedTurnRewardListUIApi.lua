-- chunkname: @IQIGame\\UIExternalApi\\LimitedTurnRewardListUIApi.lua

LimitedTurnRewardListUIApi = BaseLangApi:Extend()

function LimitedTurnRewardListUIApi:Init()
	self:RegisterApi("goTitle", self.GetGoTitle)
	self:RegisterApi("TextPerCent", self.GetTextPerCent)
end

function LimitedTurnRewardListUIApi:GetTextPerCent(Probability)
	return string.format("%s%%", Probability)
end

function LimitedTurnRewardListUIApi:GetGoTitle()
	return self:GetCfgText(1233405)
end

LimitedTurnRewardListUIApi:Init()
