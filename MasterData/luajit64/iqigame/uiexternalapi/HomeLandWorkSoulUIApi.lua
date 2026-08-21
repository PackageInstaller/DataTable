-- chunkname: @IQIGame\\UIExternalApi\\HomeLandWorkSoulUIApi.lua

HomeLandWorkSoulUIApi = BaseLangApi:Extend()

function HomeLandWorkSoulUIApi:Init()
	self:RegisterApi("btnWorkTxt", self.GetBtnWorkTxt)
	self:RegisterApi("tagWorkingTxt", self.GetTagWorkingTxt)
	self:RegisterApi("tagExploringTxt", self.GetTagExploringTxt)
	self:RegisterApi("favorLvTxt", self.GetFavorTxt)
	self:RegisterApi("moodTxt", self.GetMoodTxt)
	self:RegisterApi("affairName", self.GetAffairName)
	self:RegisterApi("affairDesc", self.GetAffairDesc)
	self:RegisterApi("tips", self.GetTips)
	self:RegisterApi("needSoulCount", self.GetNeedSoulCountDesc)
	self:RegisterApi("needMood", self.GetNeedMoodDesc)
	self:RegisterApi("needFavorLv", self.GetNeedFavorLvDesc)
	self:RegisterApi("needTime", self.GetNeedTime)
	self:RegisterApi("rewardTitle", self.GetRewardTitle)
	self:RegisterApi("recommendTip", self.GetRecommendTip)
	self:RegisterApi("desc", self.GetDesc)
	self:RegisterApi("perfectSuccessUIDesc", self.GetPerfectSuccessUIDesc)
	self:RegisterApi("perfectSuccessUIDuration", self.GetPerfectSuccessUIDuration)
end

function HomeLandWorkSoulUIApi:GetDesc()
	return self:GetCfgText(1015229)
end

function HomeLandWorkSoulUIApi:GetPerfectSuccessUIDesc()
	return self:GetCfgText(1015220)
end

function HomeLandWorkSoulUIApi:GetPerfectSuccessUIDuration()
	return 2
end

function HomeLandWorkSoulUIApi:GetBtnWorkTxt(isPerfect)
	return self:GetCfgText(1015221)
end

function HomeLandWorkSoulUIApi:GetTagExploringTxt()
	return self:GetCfgText(2000007)
end

function HomeLandWorkSoulUIApi:GetTagWorkingTxt()
	return self:GetCfgText(1015222)
end

function HomeLandWorkSoulUIApi:GetFavorTxt(lv)
	return lv
end

function HomeLandWorkSoulUIApi:GetMoodTxt(value)
	return value
end

function HomeLandWorkSoulUIApi:GetAffairName(name)
	return name
end

function HomeLandWorkSoulUIApi:GetAffairDesc(desc)
	return desc
end

function HomeLandWorkSoulUIApi:GetTips()
	return self:GetCfgText(1015223)
end

function HomeLandWorkSoulUIApi:GetNeedSoulCountDesc(minCount, maxCount)
	return self:GetCfgText(1015224) .. self.TextColor[12] .. tostring(minCount) .. self.TextColor[0] .. "-" .. self.TextColor[12] .. tostring(maxCount) .. self.TextColor[0]
end

function HomeLandWorkSoulUIApi:GetNeedMoodDesc(mood)
	return self:GetCfgText(1015225) .. "    " .. self.TextColor[12] .. tostring(mood) .. self.TextColor[0]
end

function HomeLandWorkSoulUIApi:GetNeedFavorLvDesc(lv)
	return self:GetCfgText(1015226) .. self.TextColor[12] .. "≥ " .. tostring(lv) .. self.TextColor[0]
end

function HomeLandWorkSoulUIApi:GetRewardTitle()
	return self:GetCfgText(1015227)
end

function HomeLandWorkSoulUIApi:GetRecommendTip()
	return self:GetCfgText(1015228)
end

function HomeLandWorkSoulUIApi:GetNeedTime(time, percent)
	return time
end

HomeLandWorkSoulUIApi:Init()
