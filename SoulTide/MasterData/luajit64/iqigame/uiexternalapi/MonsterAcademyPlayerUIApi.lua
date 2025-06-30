-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyPlayerUIApi.lua

MonsterAcademyPlayerUIApi = BaseLangApi:Extend()

function MonsterAcademyPlayerUIApi:Init()
	self:RegisterApi("TextMonster", self.GetTextMonster)
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("FavorBtnLabel", self.GetFavorBtnLabel)
	self:RegisterApi("BtnCloseLabel", self.GetBtnCloseLabel)
	self:RegisterApi("AttributeTitle", self.GetAttributeTitle)
	self:RegisterApi("Attribute", self.GetAttribute)
	self:RegisterApi("TextMonsterTitle", self.GetTextMonsterTitle)
	self:RegisterApi("AttributeLabel", self.GetAttributeLabel)
	self:RegisterApi("AttrState", self.GetAttrState)
	self:RegisterApi("AttrStar", self.GetAttrStar)
end

function MonsterAcademyPlayerUIApi:GetAttrStar(value)
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

function MonsterAcademyPlayerUIApi:GetAttrState(value)
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

function MonsterAcademyPlayerUIApi:GetAttributeLabel(str)
	return str
end

function MonsterAcademyPlayerUIApi:GetTextMonsterTitle()
	return self:GetCfgText(3420151)
end

function MonsterAcademyPlayerUIApi:GetAttribute(attrValue)
	return attrValue
end

function MonsterAcademyPlayerUIApi:GetAttributeTitle()
	return self:GetCfgText(3420152)
end

function MonsterAcademyPlayerUIApi:GetBtnCloseLabel()
	return self:GetCfgText(3420081)
end

function MonsterAcademyPlayerUIApi:GetFavorBtnLabel()
	return self:GetCfgText(3420153)
end

function MonsterAcademyPlayerUIApi:GetTextMonster(value)
	return string.format(self:GetCfgText(3420154), value)
end

function MonsterAcademyPlayerUIApi:GetTextTitle(str)
	return str
end

MonsterAcademyPlayerUIApi:Init()
