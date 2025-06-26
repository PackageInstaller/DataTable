-- chunkname: @IQIGame\\UIExternalApi\\PlaceGamePlayerFormationUIApi.lua

PlaceGamePlayerFormationUIApi = BaseLangApi:Extend()

function PlaceGamePlayerFormationUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("DefaultFormationName", self.GetDefaultFormationName)
	self:RegisterApi("FormationIndexText", self.GetFormationIndexText)
	self:RegisterApi("InputNameNoticeText", self.GetInputNameNoticeText)
	self:RegisterApi("SoulPositionLabelText", self.GetSoulPositionLabelText)
	self:RegisterApi("SkillGroupIndexText", self.GetSkillGroupIndexText)
	self:RegisterApi("FightAttSort", self.GetFightAttSort)
	self:RegisterApi("SoulInfoAttrValue", self.GetSoulInfoAttrValue)
end

function PlaceGamePlayerFormationUIApi:GetSoulInfoAttrValue(value, addValue, attrId)
	if value == nil then
		return "--"
	end

	if addValue == 0 then
		return value
	elseif addValue > 0 then
		return self.TextColor[207] .. value .. self.TextColor[0]
	elseif addValue < 0 then
		return self.TextColor[203] .. value .. self.TextColor[0]
	end

	return "???"
end

function PlaceGamePlayerFormationUIApi:GetFightAttSort()
	return {
		7,
		9,
		10,
		11,
		14,
		22,
		24,
		26
	}
end

function PlaceGamePlayerFormationUIApi:GetSkillGroupIndexText(index)
	if index == 1 then
		return "Ⅰ"
	elseif index == 2 then
		return "Ⅱ"
	elseif index == 3 then
		return "Ⅲ"
	end

	return "?"
end

function PlaceGamePlayerFormationUIApi:GetSoulPositionLabelText(isFront)
	if isFront then
		return self:GetCfgText(1214061), self:Blank(self:GetCfgText(1214062), 1)
	else
		return self:GetCfgText(1214063), self:Blank(self:GetCfgText(1214064), 1)
	end
end

function PlaceGamePlayerFormationUIApi:GetInputNameNoticeText()
	return self:GetCfgText(1214052)
end

function PlaceGamePlayerFormationUIApi:GetFormationIndexText(index)
	if index < 10 then
		return "0" .. index
	else
		return index
	end
end

function PlaceGamePlayerFormationUIApi:GetDefaultFormationName(index, name)
	if name ~= nil and name ~= "" then
		return name
	end

	return self:GetCfgText(1214051) .. index
end

function PlaceGamePlayerFormationUIApi:GetTitleText()
	return self:GetCfgText(3820008)
end

PlaceGamePlayerFormationUIApi:Init()
