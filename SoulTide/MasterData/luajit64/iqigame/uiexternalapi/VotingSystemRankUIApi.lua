-- chunkname: @IQIGame\\UIExternalApi\\VotingSystemRankUIApi.lua

VotingSystemRankUIApi = BaseLangApi:Extend()

function VotingSystemRankUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ToggleTitle", self.GetToggleTitle)
end

function VotingSystemRankUIApi:GetToggleTitle(index)
	if index == 1 then
		return self:GetCfgText(8001031)
	elseif index == 2 then
		return self:GetCfgText(8001032)
	elseif index == 3 then
		return self:GetCfgText(8001033)
	elseif index == 4 then
		return self:GetCfgText(8001034)
	end

	return ""
end

function VotingSystemRankUIApi:GetTitleText()
	return self:GetCfgText(8001035)
end

VotingSystemRankUIApi:Init()
