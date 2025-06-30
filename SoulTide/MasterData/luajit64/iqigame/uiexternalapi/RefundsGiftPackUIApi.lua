-- chunkname: @IQIGame\\UIExternalApi\\RefundsGiftPackUIApi.lua

RefundsGiftPackUIApi = BaseLangApi:Extend()

function RefundsGiftPackUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("BtnBackLabel", self.GetBtnBackLabel)
	self:RegisterApi("BtnReceiveLabel", self.GetBtnReceiveLabel)
	self:RegisterApi("TextTime", self.GetTextTime)
	self:RegisterApi("TextCount", self.GetTextCount)
end

function RefundsGiftPackUIApi:GetTextCount(num, maxNum)
	num = num + 1

	if maxNum == num then
		return string.format(self.TextColor[29] .. "%s/%s" .. self.TextColor[0], num, maxNum)
	else
		return string.format("%s/%s", num, maxNum)
	end
end

function RefundsGiftPackUIApi:GetTextTime(second)
	if second <= 0 then
		return self:GetCfgText(1017001)
	end

	local str = ""

	if second < 60 then
		str = tostring(math.floor(second))
	elseif second < 3600 then
		str = getTimeDurationText(second, 3)
	elseif second >= 3600 and second < 86400 then
		str = getTimeDurationText(second, 2)
	else
		str = getTimeDurationText(second, 1)
	end

	return self:GetCfgText(1017002) .. str
end

function RefundsGiftPackUIApi:GetBtnReceiveLabel()
	return self:GetCfgText(1017003)
end

function RefundsGiftPackUIApi:GetBtnBackLabel()
	return self:GetCfgText(1017004)
end

function RefundsGiftPackUIApi:GetTitleText()
	return self:GetCfgText(1017005)
end

RefundsGiftPackUIApi:Init()
