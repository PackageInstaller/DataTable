-- chunkname: @IQIGame\\UIExternalApi\\UnlockNoticeUIApi.lua

UnlockNoticeUIApi = BaseLangApi:Extend()

function UnlockNoticeUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TypeText", self.GetTypeText)
	self:RegisterApi("NameText", self.GetNameText)
	self:RegisterApi("NameText1", self.GetNameText1)
	self:RegisterApi("TextSound", self.GetTextSound)
	self:RegisterApi("TextDialog", self.GetTextDialog)
end

function UnlockNoticeUIApi:GetTextDialog()
	return self:GetCfgText(2300720)
end

function UnlockNoticeUIApi:GetTextSound()
	return self:GetCfgText(1103003)
end

function UnlockNoticeUIApi:GetTitleText()
	return self:GetCfgText(1220004)
end

function UnlockNoticeUIApi:GetTypeText(text)
	return text
end

function UnlockNoticeUIApi:GetNameText(text)
	return text
end

function UnlockNoticeUIApi:GetNameText1(text)
	return text
end

UnlockNoticeUIApi:Init()
