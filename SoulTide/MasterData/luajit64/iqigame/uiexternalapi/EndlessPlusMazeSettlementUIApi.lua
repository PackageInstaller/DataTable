-- chunkname: @IQIGame\\UIExternalApi\\EndlessPlusMazeSettlementUIApi.lua

EndlessPlusMazeSettlementUIApi = BaseLangApi:Extend()

function EndlessPlusMazeSettlementUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("CloseBtnText", self.GetCloseBtnText)
	self:RegisterApi("RewardEmptyViewText", self.GetRewardEmptyViewText)
	self:RegisterApi("RuneEmptyViewText", self.GetRuneEmptyViewText)
	self:RegisterApi("RewardCell_NumText", self.GetRewardCell_NumText)
end

function EndlessPlusMazeSettlementUIApi:GetTitleText()
	return self:GetCfgText(2300053), self:GetCfgText(2300054)
end

function EndlessPlusMazeSettlementUIApi:GetCloseBtnText()
	return self:GetCfgText(2209002)
end

function EndlessPlusMazeSettlementUIApi:GetRewardEmptyViewText()
	return self:GetCfgText(3410975)
end

function EndlessPlusMazeSettlementUIApi:GetRuneEmptyViewText()
	return self:GetCfgText(3410976)
end

function EndlessPlusMazeSettlementUIApi:GetRewardCell_NumText(num)
	return "X" .. num
end

EndlessPlusMazeSettlementUIApi:Init()
