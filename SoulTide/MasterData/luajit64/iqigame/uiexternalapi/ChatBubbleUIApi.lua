-- chunkname: @IQIGame\\UIExternalApi\\ChatBubbleUIApi.lua

ChatBubbleUIApi = BaseLangApi:Extend()

function ChatBubbleUIApi:Init()
	self:RegisterApi("TagLockLabel", self.GetTagLockLabel)
	self:RegisterApi("TagUseLabel", self.GetTagUseLabel)
	self:RegisterApi("TagLockText", self.GetTagLockText)
	self:RegisterApi("TextState", self.GetTextState)
	self:RegisterApi("BtnUseLabel", self.GetBtnUseLabel)
end

function ChatBubbleUIApi:GetBtnUseLabel()
	return self:GetCfgText(9101401)
end

function ChatBubbleUIApi:GetTextState()
	return self:GetCfgText(9101402)
end

function ChatBubbleUIApi:GetTagLockText()
	return self:GetCfgText(9101403)
end

function ChatBubbleUIApi:GetTagUseLabel()
	return self:GetCfgText(9101402)
end

function ChatBubbleUIApi:GetTagLockLabel()
	return self:GetCfgText(9101403)
end

ChatBubbleUIApi:Init()
