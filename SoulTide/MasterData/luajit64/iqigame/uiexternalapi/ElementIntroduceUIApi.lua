-- chunkname: @IQIGame\\UIExternalApi\\ElementIntroduceUIApi.lua

ElementIntroduceUIApi = BaseLangApi:Extend()

function ElementIntroduceUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ElementTitleText", self.GetElementTitleText)
	self:RegisterApi("DescText", self.GetDescText)
end

function ElementIntroduceUIApi:GetTitleText()
	return self:Blank(self:GetCfgText(2800001), 1)
end

function ElementIntroduceUIApi:GetElementTitleText(elementTitle)
	return elementTitle
end

function ElementIntroduceUIApi:GetDescText(desc)
	return desc
end

ElementIntroduceUIApi:Init()
