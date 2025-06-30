-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreSettlementUIApi.lua

DualTeamExploreSettlementUIApi = BaseLangApi:Extend()

function DualTeamExploreSettlementUIApi:Init()
	self:RegisterApi("ExploreLabel", self.GetExploreLabel)
	self:RegisterApi("SuccessViewText", self.GetSuccessViewText)
	self:RegisterApi("FailViewText", self.GetFailViewText)
end

function DualTeamExploreSettlementUIApi:GetExploreLabel()
	return ""
end

function DualTeamExploreSettlementUIApi:GetSuccessViewText()
	return ""
end

function DualTeamExploreSettlementUIApi:GetFailViewText()
	return ""
end

DualTeamExploreSettlementUIApi:Init()
