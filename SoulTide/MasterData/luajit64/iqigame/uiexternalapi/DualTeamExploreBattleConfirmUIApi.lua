-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreBattleConfirmUIApi.lua

DualTeamExploreBattleConfirmUIApi = BaseLangApi:Extend()

function DualTeamExploreBattleConfirmUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TeamToggleLabel", self.GetTeamToggleLabel)
	self:RegisterApi("SelectTipText", self.GetSelectTipText)
	self:RegisterApi("TeamInactiveFlag", self.GetTeamInactiveFlag)
end

function DualTeamExploreBattleConfirmUIApi:GetTitleText()
	return self:GetCfgText(3410401)
end

function DualTeamExploreBattleConfirmUIApi:GetTeamToggleLabel(teamIndex, labelIndex)
	if labelIndex == 1 then
		return string.format(self:GetCfgText(3410402), teamIndex)
	else
		return "0" .. teamIndex
	end
end

function DualTeamExploreBattleConfirmUIApi:GetSelectTipText()
	return self:GetCfgText(3410403)
end

function DualTeamExploreBattleConfirmUIApi:GetTeamInactiveFlag(isDead)
	if isDead then
		return self:GetCfgText(3410404)
	end

	return self:GetCfgText(3410405)
end

DualTeamExploreBattleConfirmUIApi:Init()
