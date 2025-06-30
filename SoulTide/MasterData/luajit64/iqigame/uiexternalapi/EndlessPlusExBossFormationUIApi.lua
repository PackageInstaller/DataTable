-- chunkname: @IQIGame\\UIExternalApi\\EndlessPlusExBossFormationUIApi.lua

EndlessPlusExBossFormationUIApi = BaseLangApi:Extend()

function EndlessPlusExBossFormationUIApi:Init()
	self:RegisterApi("TextNoRune", self.GetTextNoRune)
	self:RegisterApi("TextFormation", self.GetTextFormation)
end

function EndlessPlusExBossFormationUIApi:GetTextNoRune()
	return self:GetCfgText(3410952)
end

function EndlessPlusExBossFormationUIApi:GetTextFormation()
	return self:GetCfgText(1213201)
end

EndlessPlusExBossFormationUIApi:Init()
