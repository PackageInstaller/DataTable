-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyFinalResultUIApi.lua

MonsterAcademyFinalResultUIApi = BaseLangApi:Extend()

function MonsterAcademyFinalResultUIApi:Init()
	self:RegisterApi("CloseBtnLabel", self.GetCloseBtnLabel)
	self:RegisterApi("TextEnding", self.GetTextEnding)
	self:RegisterApi("TextAttributeTitle", self.GetTextAttributeTitle)
	self:RegisterApi("TextFavorTitle", self.GetTextFavorTitle)
	self:RegisterApi("AttrStar", self.GetAttrStar)
	self:RegisterApi("Attribute", self.GetAttribute)
	self:RegisterApi("AttrState", self.GetAttrState)
end

function MonsterAcademyFinalResultUIApi:GetAttrState(value)
	local top = "<color=#ff99cc>" .. self:GetCfgText(3420340) .. "</color>"

	if value < 50 then
		top = self:GetCfgText(3420341)
	elseif value >= 50 and value < 100 then
		top = self:GetCfgText(3420342)
	elseif value >= 100 and value < 150 then
		top = self:GetCfgText(3420343)
	elseif value >= 150 and value < 200 then
		top = self:GetCfgText(3420344)
	elseif value >= 200 and value < 300 then
		top = "<color=#cc99ff>" .. self:GetCfgText(3420345) .. "</color>"
	elseif value >= 300 then
		top = "<color=#ff99cc>" .. self:GetCfgText(3420340) .. "</color>"
	end

	return top
end

function MonsterAcademyFinalResultUIApi:GetAttribute(attrValue)
	return attrValue
end

function MonsterAcademyFinalResultUIApi:GetAttrStar(value)
	local top = 0

	if value < 50 then
		top = 0
	elseif value >= 50 and value < 100 then
		top = 1
	elseif value >= 100 and value < 150 then
		top = 2
	elseif value >= 150 and value < 200 then
		top = 3
	elseif value >= 200 and value < 300 then
		top = 4
	elseif value >= 300 then
		top = 5
	end

	return top
end

function MonsterAcademyFinalResultUIApi:GetTextFavorTitle()
	return self:GetCfgText(3420205)
end

function MonsterAcademyFinalResultUIApi:GetTextAttributeTitle()
	return self:GetCfgText(3420219)
end

function MonsterAcademyFinalResultUIApi:GetTextEnding(strName)
	return string.format(self:GetCfgText(3420220), strName)
end

function MonsterAcademyFinalResultUIApi:GetCloseBtnLabel()
	return self:GetCfgText(3420218)
end

MonsterAcademyFinalResultUIApi:Init()
