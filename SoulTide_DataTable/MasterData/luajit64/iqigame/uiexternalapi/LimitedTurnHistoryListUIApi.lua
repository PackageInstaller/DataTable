-- chunkname: @IQIGame\\UIExternalApi\\LimitedTurnHistoryListUIApi.lua

LimitedTurnHistoryListUIApi = BaseLangApi:Extend()

function LimitedTurnHistoryListUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("NameLabel", self.GetNameLabel)
	self:RegisterApi("TimeLabel", self.GetTimeLabel)
	self:RegisterApi("TextNone", self.GetTextNone)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("NameText", self.GetNameText)
end

function LimitedTurnHistoryListUIApi:GetNameText(name, num)
	return string.format("%s x%s", name, num)
end

function LimitedTurnHistoryListUIApi:GetTipText()
	return self:GetCfgText(1233901)
end

function LimitedTurnHistoryListUIApi:GetTextNone()
	return self:GetCfgText(1233902)
end

function LimitedTurnHistoryListUIApi:GetTimeLabel()
	return self:GetCfgText(1233903)
end

function LimitedTurnHistoryListUIApi:GetNameLabel()
	return self:GetCfgText(1233904)
end

function LimitedTurnHistoryListUIApi:GetTitleText()
	return self:GetCfgText(1233905)
end

LimitedTurnHistoryListUIApi:Init()
