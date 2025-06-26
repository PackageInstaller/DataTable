-- chunkname: @IQIGame\\UIExternalApi\\PlaceGamePlayerUpdateUIApi.lua

PlaceGamePlayerUpdateUIApi = BaseLangApi:Extend()

function PlaceGamePlayerUpdateUIApi:Init()
	self:RegisterApi("AttIconPath", self.GetAttIconPath)
	self:RegisterApi("ExpText", self.GetExpText)
	self:RegisterApi("UnlockFeatureCondition", self.GetUnlockFeatureCondition)
end

function PlaceGamePlayerUpdateUIApi:GetUnlockFeatureCondition(lv)
	return string.format(self:GetCfgText(3820001), lv)
end

function PlaceGamePlayerUpdateUIApi:GetExpText(exp, needExp)
	return string.format("(EXP)%s/%s", exp, needExp)
end

function PlaceGamePlayerUpdateUIApi:GetAttIconPath(attType)
	if attType == 7 then
		return self:GetResUrl(5100100)
	elseif attType == 9 then
		return self:GetResUrl(5100101)
	elseif attType == 10 then
		return self:GetResUrl(5100102)
	elseif attType == 11 then
		return self:GetResUrl(5100103)
	elseif attType == 14 then
		return self:GetResUrl(5100104)
	elseif attType == 21 then
		return self:GetResUrl(2000043)
	elseif attType == 22 then
		return self:GetResUrl(5100105)
	elseif attType == 24 then
		return self:GetResUrl(5100106)
	elseif attType == 26 then
		return self:GetResUrl(5100107)
	end

	return UIGlobalApi.GetImagePath("/Common/ComImage/MainAtt_0" .. tostring(attType) .. ".png")
end

PlaceGamePlayerUpdateUIApi:Init()
