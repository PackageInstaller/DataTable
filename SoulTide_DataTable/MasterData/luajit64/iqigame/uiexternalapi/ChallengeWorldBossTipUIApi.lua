-- chunkname: @IQIGame\\UIExternalApi\\ChallengeWorldBossTipUIApi.lua

ChallengeWorldBossTipUIApi = BaseLangApi:Extend()

function ChallengeWorldBossTipUIApi:Init()
	self:RegisterApi("TextBossTipTitle1", self.GetTextBossTipTitle1)
	self:RegisterApi("TextBossTipTitle2", self.GetTextBossTipTitle2)
	self:RegisterApi("TextBossTipTitle3", self.GetTextBossTipTitle3)
end

function ChallengeWorldBossTipUIApi:GetTextBossTipTitle3(name)
	return string.format(self:GetCfgText(1213150), name)
end

function ChallengeWorldBossTipUIApi:GetTextBossTipTitle2(name)
	return string.format(self:GetCfgText(1213151), name)
end

function ChallengeWorldBossTipUIApi:GetTextBossTipTitle1()
	return self:GetCfgText(1213152)
end

ChallengeWorldBossTipUIApi:Init()
