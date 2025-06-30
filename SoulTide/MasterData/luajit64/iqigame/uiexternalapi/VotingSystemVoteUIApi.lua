-- chunkname: @IQIGame\\UIExternalApi\\VotingSystemVoteUIApi.lua

VotingSystemVoteUIApi = BaseLangApi:Extend()

function VotingSystemVoteUIApi:Init()
	self:RegisterApi("CloseBtnLabel", self.GetCloseBtnLabel)
	self:RegisterApi("SelectNullNodeText", self.GetSelectNullNodeText)
	self:RegisterApi("SelectText", self.GetSelectText)
	self:RegisterApi("BtnVoteLabel", self.GetBtnVoteLabel)
	self:RegisterApi("TextValue", self.GetTextValue)
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("BackBtnLabel", self.GetBackBtnLabel)
	self:RegisterApi("FinalsStageTeamName", self.GetFinalsStageTeamName)
end

function VotingSystemVoteUIApi:GetFinalsStageTeamName()
	return "决赛"
end

function VotingSystemVoteUIApi:GetBackBtnLabel()
	return self:GetCfgText(8001001)
end

function VotingSystemVoteUIApi:GetTitleText(stage, teamName)
	local stageName = ""

	if stage == 0 then
		stageName = self:GetCfgText(8001002)
	elseif stage == 1 then
		stageName = self:GetCfgText(8001003)
	elseif stage == 2 then
		stageName = self:GetCfgText(8001004)
	end

	if stage <= 1 then
		return string.format("%s-%s", stageName, teamName)
	end

	return string.format("%s", stageName)
end

function VotingSystemVoteUIApi:GetTextValue(num)
	return string.format(self:GetCfgText(8001005), num)
end

function VotingSystemVoteUIApi:GetBtnVoteLabel()
	return self:GetCfgText(8001006)
end

function VotingSystemVoteUIApi:GetSelectText(name)
	return string.format(self:GetCfgText(8001007), name)
end

function VotingSystemVoteUIApi:GetCloseBtnLabel()
	return self:GetCfgText(8001008)
end

function VotingSystemVoteUIApi:GetSelectNullNodeText()
	return self:GetCfgText(8001009)
end

VotingSystemVoteUIApi:Init()
