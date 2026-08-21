-- chunkname: @IQIGame\\UIExternalApi\\ChallengeWorldFormationUIApi.lua

ChallengeWorldFormationUIApi = BaseLangApi:Extend()

function ChallengeWorldFormationUIApi:Init()
	self:RegisterApi("TextFormation", self.GetTextFormation)
end

function ChallengeWorldFormationUIApi:GetTextFormation()
	return self:GetCfgText(1213201)
end

ChallengeWorldFormationUIApi:Init()
