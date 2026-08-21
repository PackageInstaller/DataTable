-- chunkname: @IQIGame\\UIExternalApi\\FloatNoticeUIApi.lua

FloatNoticeUIApi = BaseLangApi:Extend()

function FloatNoticeUIApi:Init()
	self:RegisterApi("ItemNumText", self.GetItemNumText)
	self:RegisterApi("QualityImage", self.GetQualityImage)
	self:RegisterApi("AddMazeLimitTimeText", self.GetAddMazeLimitTimeText)
end

function FloatNoticeUIApi:GetItemNumText(num, quality)
	return self:Space(1) .. "x" .. num
end

function FloatNoticeUIApi:GetQualityImage(quality)
	if quality == 1 then
		return self:GetResUrl(1302001)
	elseif quality == 2 then
		return self:GetResUrl(1302002)
	elseif quality == 3 then
		return self:GetResUrl(1302003)
	elseif quality == 4 then
		return self:GetResUrl(1302004)
	elseif quality == 5 then
		return self:GetResUrl(1302005)
	end

	return ""
end

function FloatNoticeUIApi:GetAddMazeLimitTimeText(addValue)
	if addValue >= 0 then
		return string.format(self:GetCfgText(2620001), addValue)
	else
		return string.format(self:GetCfgText(2620002), -addValue)
	end
end

FloatNoticeUIApi:Init()
