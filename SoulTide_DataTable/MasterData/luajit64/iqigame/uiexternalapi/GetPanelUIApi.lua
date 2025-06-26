-- chunkname: @IQIGame\\UIExternalApi\\GetPanelUIApi.lua

GetPanelUIApi = BaseLangApi:Extend()

function GetPanelUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("goBtnTxt", self.GetBtnTxt)
	self:RegisterApi("ItemNameText", self.GetItemNameText)
	self:RegisterApi("TextEng", self.GetTextEng)
end

function GetPanelUIApi:GetTextEng()
	return self:GetCfgText(2700001)
end

function GetPanelUIApi:GetTextTitle()
	return self:GetCfgText(19)
end

function GetPanelUIApi:GetBtnTxt()
	return self:GetCfgText(79)
end

function GetPanelUIApi:GetItemNameText(text)
	return text
end

GetPanelUIApi:Init()
