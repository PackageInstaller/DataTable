-- chunkname: @IQIGame\\UIExternalApi\\ChangeTitleUIApi.lua

ChangeTitleUIApi = BaseLangApi:Extend()

function ChangeTitleUIApi:Init()
	self:RegisterApi("TextTag", self.GetTextTag)
	self:RegisterApi("PanelTitle", self.GetPanelTitle)
	self:RegisterApi("TextBtnCancel", self.GetTextBtnCancel)
	self:RegisterApi("TextBtnSure", self.GetTextBtnSure)
	self:RegisterApi("TextBtnRemove", self.GetTextBtnRemove)
	self:RegisterApi("TextTitleName", self.GetTextTitleName)
	self:RegisterApi("TextTitleDes", self.GetTextTitleDes)
	self:RegisterApi("TextDate", self.GetTextDate)
end

function ChangeTitleUIApi:GetTextDate(timeTitle)
	return string.format(self:GetCfgText(2400506) .. "\n%s", timeTitle)
end

function ChangeTitleUIApi:GetTextTitleDes(des)
	return des
end

function ChangeTitleUIApi:GetTextTitleName(name)
	return name
end

function ChangeTitleUIApi:GetTextBtnRemove()
	return self:GetCfgText(2400501)
end

function ChangeTitleUIApi:GetTextBtnSure()
	return self:GetCfgText(2400502)
end

function ChangeTitleUIApi:GetTextBtnCancel()
	return self:GetCfgText(2400503)
end

function ChangeTitleUIApi:GetPanelTitle()
	return self:GetCfgText(2400504)
end

function ChangeTitleUIApi:GetTextTag()
	return self:GetCfgText(2400505)
end

ChangeTitleUIApi:Init()
