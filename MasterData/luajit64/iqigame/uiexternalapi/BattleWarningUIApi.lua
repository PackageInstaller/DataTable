-- chunkname: @IQIGame\\UIExternalApi\\BattleWarningUIApi.lua

BattleWarningUIApi = BaseLangApi:Extend()

function BattleWarningUIApi:Init()
	self:RegisterApi("WarningTextPart1", self.GetWarningTextPart1)
	self:RegisterApi("WarningTextPart2", self.GetWarningTextPart2)
end

function BattleWarningUIApi:GetWarningTextPart1()
	return self:GetCfgText(1318091)
end

function BattleWarningUIApi:GetWarningTextPart2()
	return self:GetCfgText(1318092)
end

BattleWarningUIApi:Init()
