-- chunkname: @IQIGame\\UIExternalApi\\ConfirmationUIApi.lua

ConfirmationUIApi = BaseLangApi:Extend()

function ConfirmationUIApi:Init()
	self:RegisterApi("TitleText", self.GetViewTitle)
	self:RegisterApi("ContentText", self.GetMainContentTxt)
	self:RegisterApi("SubContentText", self.GetSubContentTxt)
	self:RegisterApi("LeftTxt", self.GetLeftTxt)
	self:RegisterApi("RightTxt", self.GetRightTxt)
	self:RegisterApi("IgnoreTxt", self.GetIgnoreTxt)
	self:RegisterApi("ConfirmBtnTxt", self.GetBtnConfirmTxt)
	self:RegisterApi("CancelBtnTxt", self.GetBtnCancelTxt)
end

function ConfirmationUIApi:GetViewTitle(txt)
	return txt
end

function ConfirmationUIApi:GetMainContentTxt(txt)
	return txt
end

function ConfirmationUIApi:GetSubContentTxt(txt)
	return txt
end

function ConfirmationUIApi:GetLeftTxt(txt)
	return txt
end

function ConfirmationUIApi:GetRightTxt(txt)
	return txt
end

function ConfirmationUIApi:GetIgnoreTxt(txt)
	return self:GetCfgText(1111013)
end

function ConfirmationUIApi:GetBtnConfirmTxt()
	return self:GetCfgText(1111105)
end

function ConfirmationUIApi:GetBtnCancelTxt()
	return self:GetCfgText(1111011)
end

ConfirmationUIApi:Init()
