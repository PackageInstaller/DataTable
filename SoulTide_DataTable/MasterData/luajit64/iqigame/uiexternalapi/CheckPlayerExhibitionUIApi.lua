-- chunkname: @IQIGame\\UIExternalApi\\CheckPlayerExhibitionUIApi.lua

CheckPlayerExhibitionUIApi = BaseLangApi:Extend()

function CheckPlayerExhibitionUIApi:Init()
	self:RegisterApi("TextTag1", self.GetTextTag1)
	self:RegisterApi("TextTag2", self.GetTextTag2)
	self:RegisterApi("PanelTitle", self.GetPanelTitle)
	self:RegisterApi("TextBtnCancel", self.GetTextBtnCancel)
end

function CheckPlayerExhibitionUIApi:GetTextBtnCancel()
	return self:GetCfgText(2400503)
end

function CheckPlayerExhibitionUIApi:GetPanelTitle()
	return self:GetCfgText(2400521)
end

function CheckPlayerExhibitionUIApi:GetTextTag2()
	return self:GetCfgText(2400522)
end

function CheckPlayerExhibitionUIApi:GetTextTag1()
	return self:GetCfgText(2400523)
end

CheckPlayerExhibitionUIApi:Init()
