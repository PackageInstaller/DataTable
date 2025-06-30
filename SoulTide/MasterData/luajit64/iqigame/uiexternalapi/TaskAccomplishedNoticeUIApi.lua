-- chunkname: @IQIGame\\UIExternalApi\\TaskAccomplishedNoticeUIApi.lua

TaskAccomplishedNoticeUIApi = BaseLangApi:Extend()

function TaskAccomplishedNoticeUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TypeText", self.GetTypeText)
	self:RegisterApi("NameText", self.GetNameText)
end

function TaskAccomplishedNoticeUIApi:GetTitleText()
	return self:GetCfgText(2400001)
end

function TaskAccomplishedNoticeUIApi:GetTypeText(typeParam)
	local tabIndex = typeParam[#typeParam]

	if tabIndex == 1 then
		return self:GetCfgText(2400002)
	elseif tabIndex == 2 then
		return self:GetCfgText(2400003)
	elseif tabIndex == 3 then
		return self:GetCfgText(2400004)
	elseif tabIndex == 4 then
		return self:GetCfgText(2400005)
	end
end

function TaskAccomplishedNoticeUIApi:GetNameText(text)
	return text
end

TaskAccomplishedNoticeUIApi:Init()
