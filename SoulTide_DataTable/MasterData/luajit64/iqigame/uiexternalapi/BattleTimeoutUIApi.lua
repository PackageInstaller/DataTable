-- chunkname: @IQIGame\\UIExternalApi\\BattleTimeoutUIApi.lua

BattleTimeoutUIApi = BaseLangApi:Extend()

function BattleTimeoutUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("Duration", self.GetDuration)
end

function BattleTimeoutUIApi:GetTitleText()
	return self:GetCfgText(1318104)
end

function BattleTimeoutUIApi:GetDuration()
	return 1
end

BattleTimeoutUIApi:Init()
