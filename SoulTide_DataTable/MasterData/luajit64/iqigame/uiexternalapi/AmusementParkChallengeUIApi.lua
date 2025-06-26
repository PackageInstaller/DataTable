-- chunkname: @IQIGame\\UIExternalApi\\AmusementParkChallengeUIApi.lua

AmusementParkChallengeUIApi = BaseLangApi:Extend()

function AmusementParkChallengeUIApi:Init()
	self:RegisterApi("TextNeedLv", self.GetTextNeedLv)
end

function AmusementParkChallengeUIApi:GetTextNeedLv(lv)
	return string.format(self:GetCfgText(3830030), lv)
end

AmusementParkChallengeUIApi:Init()
