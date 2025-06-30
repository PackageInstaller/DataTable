-- chunkname: @IQIGame\\UIExternalApi\\ChangeExhibitionUIApi.lua

ChangeExhibitionUIApi = BaseLangApi:Extend()

function ChangeExhibitionUIApi:Init()
	self:RegisterApi("TextTag1", self.GetTextTag1)
	self:RegisterApi("TextTag2", self.GetTextTag2)
	self:RegisterApi("PanelTitle", self.GetPanelTitle)
	self:RegisterApi("TextBtnCancel", self.GetTextBtnCancel)
	self:RegisterApi("TextBtnSure", self.GetTextBtnSure)
	self:RegisterApi("TextBtnRemove", self.GetTextBtnRemove)
end

function ChangeExhibitionUIApi:GetTextBtnRemove()
	return self:GetCfgText(2400501)
end

function ChangeExhibitionUIApi:GetTextBtnSure()
	return self:GetCfgText(2400502)
end

function ChangeExhibitionUIApi:GetTextBtnCancel()
	return self:GetCfgText(2400503)
end

function ChangeExhibitionUIApi:GetPanelTitle()
	return self:GetCfgText(2400521)
end

function ChangeExhibitionUIApi:GetTextTag2()
	return self:GetCfgText(2400522)
end

function ChangeExhibitionUIApi:GetTextTag1()
	return self:GetCfgText(2400523)
end

ChangeExhibitionUIApi:Init()
