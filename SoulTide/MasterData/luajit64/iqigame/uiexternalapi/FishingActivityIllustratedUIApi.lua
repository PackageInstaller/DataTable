-- chunkname: @IQIGame\\UIExternalApi\\FishingActivityIllustratedUIApi.lua

FishingActivityIllustratedUIApi = BaseLangApi:Extend()

function FishingActivityIllustratedUIApi:Init()
	self:RegisterApi("SelectQualityLabel", self.GetSelectQualityLabel)
	self:RegisterApi("FishQuality", self.GetFishQuality)
	self:RegisterApi("WeightRange", self.GetWeightRange)
	self:RegisterApi("ArmStrength", self.GetArmStrength)
	self:RegisterApi("FishingPower", self.GetFishingPower)
	self:RegisterApi("Price", self.GetPrice)
	self:RegisterApi("TextMaxWeight", self.GetTextMaxWeight)
end

function FishingActivityIllustratedUIApi:GetTextMaxWeight(num)
	return string.format("%s kg", num)
end

function FishingActivityIllustratedUIApi:GetPrice(num)
	return string.format("%s 钓鱼币/吨", num)
end

function FishingActivityIllustratedUIApi:GetFishingPower(num)
	return string.format("%s kp", num)
end

function FishingActivityIllustratedUIApi:GetArmStrength(num)
	return string.format("%s kp", num)
end

function FishingActivityIllustratedUIApi:GetWeightRange(num1, num2)
	return string.format("%s-%s kg", num1, num2)
end

function FishingActivityIllustratedUIApi:GetFishQuality()
	return {
		0,
		2,
		3,
		4,
		5
	}
end

function FishingActivityIllustratedUIApi:GetSelectQualityLabel(quality)
	if quality == 0 then
		return self:GetCfgText(1015782)
	elseif quality == 2 then
		return self:GetCfgText(1015783)
	elseif quality == 3 then
		return self:GetCfgText(1015784)
	elseif quality == 4 then
		return self:GetCfgText(1015785)
	elseif quality == 5 then
		return self:GetCfgText(1015786)
	end
end

FishingActivityIllustratedUIApi:Init()
