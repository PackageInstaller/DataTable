-- chunkname: @IQIGame\\UIExternalApi\\HomeLandFishCollectionUIApi.lua

HomeLandFishCollectionUIApi = BaseLangApi:Extend()

function HomeLandFishCollectionUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("LockNameText", self.GetLockNameText)
	self:RegisterApi("LockInfoPanelTitle", self.GetLockInfoPanelTitle)
	self:RegisterApi("LockDescText", self.GetLockDescText)
	self:RegisterApi("InfoPanelTitle", self.GetInfoPanelTitle)
	self:RegisterApi("DescText", self.GetDescText)
	self:RegisterApi("QualityBackgroundPath", self.GetQualityBackgroundPath)
	self:RegisterApi("SelectQualityLabel", self.GetSelectQualityLabel)
	self:RegisterApi("FishQuality", self.GetFishQuality)
	self:RegisterApi("UnlockNum", self.GetUnlockNum)
	self:RegisterApi("GetCount", self.GetGetCount)
	self:RegisterApi("AttributeDesc", self.GetAttributeDesc)
end

function HomeLandFishCollectionUIApi:GetAttributeDesc(attributeTab)
	local str = ""

	for i, v in pairs(attributeTab) do
		str = str .. string.format("%s\n", string.format("%s +%s", AttributeModule.GetAttName(i), v))
	end

	return str
end

function HomeLandFishCollectionUIApi:GetGetCount(num)
	return string.format(self:GetCfgText(1015780), num)
end

function HomeLandFishCollectionUIApi:GetUnlockNum(openNum, maxNum)
	return string.format(self:GetCfgText(1015781), openNum, maxNum)
end

function HomeLandFishCollectionUIApi:GetFishQuality()
	return {
		0,
		2,
		3,
		4,
		5
	}
end

function HomeLandFishCollectionUIApi:GetSelectQualityLabel(quality)
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

function HomeLandFishCollectionUIApi:GetQualityBackgroundPath(quality)
	if quality == 0 then
		return self:GetResUrl(2400010)
	elseif quality == 1 then
		return self:GetResUrl(2400011)
	elseif quality == 2 then
		return self:GetResUrl(2400012)
	elseif quality == 3 then
		return self:GetResUrl(2400013)
	elseif quality == 4 then
		return self:GetResUrl(2400014)
	elseif quality == 5 then
		return self:GetResUrl(2400015)
	end

	return self:GetResUrl(2400010)
end

function HomeLandFishCollectionUIApi:GetDescText()
	return self:GetCfgText(1015787)
end

function HomeLandFishCollectionUIApi:GetInfoPanelTitle()
	return self:GetCfgText(1015788)
end

function HomeLandFishCollectionUIApi:GetLockDescText()
	return self:GetCfgText(1015789)
end

function HomeLandFishCollectionUIApi:GetLockInfoPanelTitle()
	return self:GetCfgText(1015790)
end

function HomeLandFishCollectionUIApi:GetLockNameText()
	return self:GetCfgText(1015791)
end

function HomeLandFishCollectionUIApi:GetTitleText()
	return self:GetCfgText(1015792)
end

HomeLandFishCollectionUIApi:Init()
