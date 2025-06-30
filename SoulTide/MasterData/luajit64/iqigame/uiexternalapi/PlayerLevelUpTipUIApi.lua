-- chunkname: @IQIGame\\UIExternalApi\\PlayerLevelUpTipUIApi.lua

PlayerLevelUpTipUIApi = BaseLangApi:Extend()

function PlayerLevelUpTipUIApi:Init()
	self:RegisterApi("goLv", self.GetLv)
	self:RegisterApi("goLvTitle", self.GetLvTitle)
	self:RegisterApi("goEnergy", self.GetEnergy)
	self:RegisterApi("goTime", self.GetLevelTime)
	self:RegisterApi("goBtnClose", self.GetBtnCloseTxt)
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("goTitleEng", self.GetTitleEng)
end

function PlayerLevelUpTipUIApi:GetTitle()
	return self:GetCfgText(1130019)
end

function PlayerLevelUpTipUIApi:GetTitleEng()
	return "U  P  G  R  A  D  E"
end

function PlayerLevelUpTipUIApi:GetLv(value)
	return self:GetCfgText(1130011) .. self:FontSize(value, 60)
end

function PlayerLevelUpTipUIApi:GetLvTitle(title)
	return ""
end

function PlayerLevelUpTipUIApi:GetEnergy(value)
	return self:GetCfgText(1130012) .. "： " .. value
end

function PlayerLevelUpTipUIApi:GetLevelTime(value)
	return self:GetCfgText(1130013) .. "： " .. value
end

function PlayerLevelUpTipUIApi:GetBtnCloseTxt()
	return self:GetCfgText(1130018)
end

PlayerLevelUpTipUIApi:Init()
