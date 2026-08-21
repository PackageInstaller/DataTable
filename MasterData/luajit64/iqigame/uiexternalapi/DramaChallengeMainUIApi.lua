-- chunkname: @IQIGame\\UIExternalApi\\DramaChallengeMainUIApi.lua

DramaChallengeMainUIApi = BaseLangApi:Extend()

function DramaChallengeMainUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
end

function DramaChallengeMainUIApi:GetTitleText(type)
	if type == 1 then
		return self:GetCfgText(9000001)
	end

	return self:GetCfgText(9000002)
end

DramaChallengeMainUIApi:Init()
