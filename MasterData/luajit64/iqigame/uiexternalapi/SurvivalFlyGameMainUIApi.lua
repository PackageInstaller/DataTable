-- chunkname: @IQIGame\\UIExternalApi\\SurvivalFlyGameMainUIApi.lua

SurvivalFlyGameMainUIApi = BaseLangApi:Extend()

function SurvivalFlyGameMainUIApi:Init()
	self:RegisterApi("TextBlood", self.GetTextBlood)
	self:RegisterApi("TextHpTotal", self.GetTextHpTotal)
end

function SurvivalFlyGameMainUIApi:GetTextHpTotal(num)
	return string.format("/%s", num)
end

function SurvivalFlyGameMainUIApi:GetTextBlood(num, residualBlood)
	if residualBlood then
		return BaseLangApi.TextColor[20] .. num .. BaseLangApi.TextColor[0]
	end

	return num
end

SurvivalFlyGameMainUIApi:Init()
