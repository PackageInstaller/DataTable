-- chunkname: @IQIGame\\UIExternalApi\\DailyHistoryListUIApi.lua

DailyHistoryListUIApi = BaseLangApi:Extend()

function DailyHistoryListUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("NameLabel", self.GetNameLabel)
	self:RegisterApi("TimeLabel", self.GetTimeLabel)
	self:RegisterApi("TextNone", self.GetTextNone)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("NameText", self.GetNameText)
end

function DailyHistoryListUIApi:GetNameText(name, num)
	return string.format("%s x%s", name, num)
end

function DailyHistoryListUIApi:GetTipText()
	return self:GetCfgText(1233901)
end

function DailyHistoryListUIApi:GetTextNone()
	return self:GetCfgText(1233902)
end

function DailyHistoryListUIApi:GetTimeLabel()
	return self:GetCfgText(1233903)
end

function DailyHistoryListUIApi:GetNameLabel()
	return self:GetCfgText(1233904)
end

function DailyHistoryListUIApi:GetTitleText()
	return self:GetCfgText(1233905)
end

DailyHistoryListUIApi:Init()
