-- chunkname: @IQIGame\\UIExternalApi\\DailyRewardListUIApi.lua

DailyRewardListUIApi = BaseLangApi:Extend()

function DailyRewardListUIApi:Init()
	self:RegisterApi("goTitle", self.GetGoTitle)
	self:RegisterApi("TextPerCent", self.GetTextPerCent)
end

function DailyRewardListUIApi:GetTextPerCent(Probability)
	return string.format("%s%%", Probability)
end

function DailyRewardListUIApi:GetGoTitle()
	return self:GetCfgText(1233405)
end

DailyRewardListUIApi:Init()
