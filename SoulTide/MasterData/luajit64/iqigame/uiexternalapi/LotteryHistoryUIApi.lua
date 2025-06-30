-- chunkname: @IQIGame\\UIExternalApi\\LotteryHistoryUIApi.lua

LotteryHistoryUIApi = BaseLangApi:Extend()

function LotteryHistoryUIApi:Init()
	self:RegisterApi("TypeText", self.GetTypeText)
	self:RegisterApi("NameText", self.GetNameText)
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TypeLabel", self.GetTypeLabel)
	self:RegisterApi("NameLabel", self.GetNameLabel)
	self:RegisterApi("TimeLabel", self.GetTimeLabel)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("NoRecordViewText", self.GetNoRecordViewText)
end

function LotteryHistoryUIApi:GetTypeText(isSoulItem, itemType)
	if isSoulItem then
		return self:GetCfgText(1317301)
	end

	if itemType == 3 then
		return self:GetCfgText(1317302)
	end

	return self:GetCfgText(1317303)
end

function LotteryHistoryUIApi:GetNameText(name, num, isSoulItem, itemType)
	if not isSoulItem and itemType ~= 3 then
		return string.format("%s x%s", name, num)
	else
		return name
	end
end

function LotteryHistoryUIApi:GetTitleText()
	return self:GetCfgText(1317304)
end

function LotteryHistoryUIApi:GetTypeLabel()
	return self:GetCfgText(1317305)
end

function LotteryHistoryUIApi:GetNameLabel()
	return self:GetCfgText(1317306)
end

function LotteryHistoryUIApi:GetTimeLabel()
	return self:GetCfgText(1317307)
end

function LotteryHistoryUIApi:GetTipText()
	return self:GetCfgText(1317308)
end

function LotteryHistoryUIApi:GetNoRecordViewText()
	return self:GetCfgText(1317309)
end

LotteryHistoryUIApi:Init()
