-- chunkname: @IQIGame\\UIExternalApi\\HorizontalRPGChallengeMainUIApi.lua

HorizontalRPGChallengeMainUIApi = BaseLangApi:Extend()

function HorizontalRPGChallengeMainUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
end

function HorizontalRPGChallengeMainUIApi:GetTitleText(type)
	if type == 1 then
		return self:GetCfgText(3430011)
	end

	return self:GetCfgText(3430012)
end

HorizontalRPGChallengeMainUIApi:Init()
