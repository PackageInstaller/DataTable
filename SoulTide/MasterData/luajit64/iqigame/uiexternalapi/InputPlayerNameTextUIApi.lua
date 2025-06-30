-- chunkname: @IQIGame\\UIExternalApi\\InputPlayerNameTextUIApi.lua

InputPlayerNameTextUIApi = BaseLangApi:Extend()

function InputPlayerNameTextUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextTitle1", self.GetTextTitle1)
	self:RegisterApi("TextBtnTitle", self.GetTextBtnTitle)
end

function InputPlayerNameTextUIApi:GetTextTitle()
	return self:GetCfgText(1112001)
end

function InputPlayerNameTextUIApi:GetTextTitle1()
	return self:GetCfgText(1112002)
end

function InputPlayerNameTextUIApi:GetTextBtnTitle()
	return self:GetCfgText(1112003)
end

InputPlayerNameTextUIApi:Init()
