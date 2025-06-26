-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreReviveUIApi.lua

DualTeamExploreReviveUIApi = BaseLangApi:Extend()

function DualTeamExploreReviveUIApi:Init()
	self:RegisterApi("TitleText1", self.GetTitleText1)
	self:RegisterApi("TitleText2", self.GetTitleText2)
	self:RegisterApi("DescText", self.GetDescText)
	self:RegisterApi("SubDescText", self.GetSubDescText)
	self:RegisterApi("GiveUpBtnText", self.GetGiveUpBtnText)
	self:RegisterApi("ReviveBtnText", self.GetReviveBtnText)
	self:RegisterApi("ReviveItemText", self.GetReviveItemText)
end

function DualTeamExploreReviveUIApi:GetTitleText1()
	return self:GetCfgText(3410351)
end

function DualTeamExploreReviveUIApi:GetTitleText2()
	return self:Blank("FAILED", 2)
end

function DualTeamExploreReviveUIApi:GetDescText()
	return self:GetCfgText(3410352)
end

function DualTeamExploreReviveUIApi:GetSubDescText()
	return self:GetCfgText(3410353)
end

function DualTeamExploreReviveUIApi:GetGiveUpBtnText()
	return self:GetCfgText(3410354)
end

function DualTeamExploreReviveUIApi:GetReviveBtnText()
	return self:GetCfgText(3410355)
end

function DualTeamExploreReviveUIApi:GetReviveItemText(hasNum)
	local color = "#FFFFFF"

	if hasNum == 0 then
		color = "#FF0000"
	end

	return string.format("<color=%s>1/%s</color>", color, hasNum)
end

DualTeamExploreReviveUIApi:Init()
