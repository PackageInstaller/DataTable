-- chunkname: @IQIGame\\UIExternalApi\\InputTextUIApi.lua

InputTextUIApi = BaseLangApi:Extend()

function InputTextUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("YesBtnText", self.GetYesBtnText)
	self:RegisterApi("NoBtnText", self.GetNoBtnText)
end

function InputTextUIApi:GetTitleText()
	return self:GetCfgText(1113001)
end

function InputTextUIApi:GetYesBtnText()
	return self:GetCfgText(1113002)
end

function InputTextUIApi:GetNoBtnText()
	return self:GetCfgText(1113003)
end

InputTextUIApi:Init()
