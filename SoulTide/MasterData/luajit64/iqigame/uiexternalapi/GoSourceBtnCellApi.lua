-- chunkname: @IQIGame\\UIExternalApi\\GoSourceBtnCellApi.lua

GoSourceBtnCellApi = BaseLangApi:Extend()

function GoSourceBtnCellApi:Init()
	self:RegisterApi("NameText", self.GetNameText)
end

function GoSourceBtnCellApi:GetNameText(text)
	return text
end

GoSourceBtnCellApi:Init()
