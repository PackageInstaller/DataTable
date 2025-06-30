-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyGetPanelUIApi.lua

MonsterAcademyGetPanelUIApi = BaseLangApi:Extend()

function MonsterAcademyGetPanelUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("goBtnTxt", self.GetBtnTxt)
	self:RegisterApi("ItemNameText", self.GetItemNameText)
	self:RegisterApi("TextEng", self.GetTextEng)
end

function MonsterAcademyGetPanelUIApi:GetTextEng()
	return self:GetCfgText(2700001)
end

function MonsterAcademyGetPanelUIApi:GetTextTitle()
	return self:GetCfgText(19)
end

function MonsterAcademyGetPanelUIApi:GetBtnTxt()
	return self:GetCfgText(79)
end

function MonsterAcademyGetPanelUIApi:GetItemNameText(text)
	return text
end

MonsterAcademyGetPanelUIApi:Init()
