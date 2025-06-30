-- chunkname: @IQIGame\\UIExternalApi\\RuneTipsUIApi.lua

RuneTipsUIApi = BaseLangApi:Extend()

function RuneTipsUIApi:Init()
	self:RegisterApi("FeatureText", self.GetFeatureText)
	self:RegisterApi("DescLabelText", self.GetDescLabelText)
	self:RegisterApi("DetailLabelText", self.GetDetailLabelText)
	self:RegisterApi("GrowProgressText", self.GetGrowProgressText)
	self:RegisterApi("QualityImage", self.GetQualityImage)
	self:RegisterApi("DetailText", self.GetDetailText)
end

function RuneTipsUIApi:GetFeatureText(feature)
	if feature == 0 then
		return ""
	end

	local featureTexts = {
		self:GetCfgText(2300200),
		self:GetCfgText(2300201),
		self:GetCfgText(2300202),
		self:GetCfgText(2300203)
	}

	return featureTexts[feature]
end

function RuneTipsUIApi:GetDescLabelText()
	return self:GetCfgText(2300208)
end

function RuneTipsUIApi:GetDetailLabelText()
	return self:GetCfgText(2300209)
end

function RuneTipsUIApi:GetGrowProgressText(text, finishNum, targetNum)
	return text .. "： " .. finishNum .. "/" .. targetNum
end

function RuneTipsUIApi:GetQualityImage(quality)
	if quality == 1 then
		return self:GetResUrl(1100200)
	elseif quality == 2 then
		return self:GetResUrl(1100201)
	elseif quality == 3 then
		return self:GetResUrl(1100202)
	end
end

function RuneTipsUIApi:GetDetailText(text, level, maxLevel)
	if maxLevel == 0 then
		return text
	end

	return text .. " <color=#3BB7FE>(Lv." .. level .. "/Lv." .. maxLevel .. ")</color>"
end

RuneTipsUIApi:Init()
