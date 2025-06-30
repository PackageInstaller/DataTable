-- chunkname: @IQIGame\\UIExternalApi\\LoginEntertainmentRatingUIApi.lua

LoginEntertainmentRatingUIApi = BaseLangApi:Extend()

function LoginEntertainmentRatingUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("DescText", self.GetDescText)
end

function LoginEntertainmentRatingUIApi:GetTitleText()
	return self:GetCfgText(7000001)
end

function LoginEntertainmentRatingUIApi:GetDescText()
	return self:GetCfgText(7000002)
end

LoginEntertainmentRatingUIApi:Init()
