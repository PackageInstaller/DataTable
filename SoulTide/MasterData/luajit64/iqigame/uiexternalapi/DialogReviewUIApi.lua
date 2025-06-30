-- chunkname: @IQIGame\\UIExternalApi\\DialogReviewUIApi.lua

DialogReviewUIApi = BaseLangApi:Extend()

function DialogReviewUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("SpeakerName", self.GetSpeakerName)
	self:RegisterApi("ContentText", self.GetContentText)
end

function DialogReviewUIApi:GetTitleText()
	return self:GetCfgText(1110023)
end

function DialogReviewUIApi:GetSpeakerName(text)
	return text
end

function DialogReviewUIApi:GetContentText(text)
	return text
end

DialogReviewUIApi:Init()
