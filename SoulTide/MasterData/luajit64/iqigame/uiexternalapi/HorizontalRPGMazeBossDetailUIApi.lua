-- chunkname: @IQIGame\\UIExternalApi\\HorizontalRPGMazeBossDetailUIApi.lua

HorizontalRPGMazeBossDetailUIApi = BaseLangApi:Extend()

function HorizontalRPGMazeBossDetailUIApi:Init()
	self:RegisterApi("NoFormations", self.GetNoFormations)
	self:RegisterApi("TitleName", self.GetTitleName)
	self:RegisterApi("TextMonsterList", self.GetTextMonsterList)
	self:RegisterApi("TextReward", self.GetTextReward)
	self:RegisterApi("UnlockError", self.GetUnlockError)
	self:RegisterApi("OpenEXBoss", self.GetOpenEXBoss)
	self:RegisterApi("RecommendPowerText", self.GetRecommendPowerText)
	self:RegisterApi("TextPower", self.GetTextPower)
	self:RegisterApi("OpenHorizontalRPGEXBoss", self.GetOpenHorizontalRPGEXBoss)
end

function HorizontalRPGMazeBossDetailUIApi:GetOpenHorizontalRPGEXBoss()
	return self:GetCfgText(3430005)
end

function HorizontalRPGMazeBossDetailUIApi:GetTextPower(power, needPower)
	local rate = needPower / power

	if rate >= 1.25 then
		return self.TextColor[203] .. power .. self.TextColor[0]
	elseif rate >= 1.05 then
		return self.TextColor[218] .. power .. self.TextColor[0]
	elseif rate >= 0.95 then
		return self.TextColor[206] .. power .. self.TextColor[0]
	elseif rate >= 0.75 then
		return self.TextColor[201] .. power .. self.TextColor[0]
	else
		return self.TextColor[219] .. power .. self.TextColor[0]
	end
end

function HorizontalRPGMazeBossDetailUIApi:GetRecommendPowerText(recommendPower)
	return self:GetCfgText(2100005) .. "：" .. recommendPower
end

function HorizontalRPGMazeBossDetailUIApi:GetOpenEXBoss()
	return self:GetCfgText(3100501)
end

function HorizontalRPGMazeBossDetailUIApi:GetUnlockError()
	return self:GetCfgText(3100401)
end

function HorizontalRPGMazeBossDetailUIApi:GetTextReward(type)
	if type == 1 then
		return self:GetCfgText(3100502)
	end

	return self:GetCfgText(3100503)
end

function HorizontalRPGMazeBossDetailUIApi:GetTextMonsterList()
	return self:GetCfgText(3100504)
end

function HorizontalRPGMazeBossDetailUIApi:GetTitleName()
	return self:GetCfgText(2000078)
end

function HorizontalRPGMazeBossDetailUIApi:GetNoFormations()
	return self:GetCfgText(1213047)
end

HorizontalRPGMazeBossDetailUIApi:Init()
