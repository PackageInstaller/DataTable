-- chunkname: @IQIGame\\UIExternalApi\\PlaceGamePlayerEvolutionInfoUIApi.lua

PlaceGamePlayerEvolutionInfoUIApi = BaseLangApi:Extend()

function PlaceGamePlayerEvolutionInfoUIApi:Init()
	self:RegisterApi("infoViewFeatureDesc", self.GetInfoViewFeatureDesc)
end

function PlaceGamePlayerEvolutionInfoUIApi:GetInfoViewFeatureDesc(desc, isUnlock)
	if isUnlock then
		return self:SkillValueColor(desc, 29)
	else
		return self.TextColor[215] .. self:SkillValueColor(desc, 29) .. self.TextColor[0]
	end
end

PlaceGamePlayerEvolutionInfoUIApi:Init()
