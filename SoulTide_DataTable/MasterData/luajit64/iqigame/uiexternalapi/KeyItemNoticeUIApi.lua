-- chunkname: @IQIGame\\UIExternalApi\\KeyItemNoticeUIApi.lua

KeyItemNoticeUIApi = BaseLangApi:Extend()

function KeyItemNoticeUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ItemNameText", self.GetItemNameText)
	self:RegisterApi("ItemDescText", self.GetItemDescText)
end

function KeyItemNoticeUIApi:GetTitleText()
	return self:GetCfgText(1212000)
end

function KeyItemNoticeUIApi:GetItemNameText(text)
	return text
end

function KeyItemNoticeUIApi:GetItemDescText(text)
	return text
end

KeyItemNoticeUIApi:Init()
