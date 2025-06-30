-- chunkname: @IQIGame\\UIExternalApi\\LunaBattleLineAssistantUIApi.lua

LunaBattleLineAssistantUIApi = BaseLangApi:Extend()

function LunaBattleLineAssistantUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("ChangeBtnText", self.GetChangeBtnText)
	self:RegisterApi("SoulInfoPowerLabel", self.GetSoulInfoPowerLabel)
	self:RegisterApi("SoulInfoLevelText", self.GetSoulInfoLevelText)
	self:RegisterApi("SkillGroupIndexText", self.GetSkillGroupIndexText)
	self:RegisterApi("SkillLevelText", self.GetSkillLevelText)
	self:RegisterApi("EquipLabel", self.GetEquipLabel)
	self:RegisterApi("FriendLabel", self.GetFriendLabel)
end

function LunaBattleLineAssistantUIApi:GetTitleText()
	return self:GetCfgText(3600150)
end

function LunaBattleLineAssistantUIApi:GetConfirmBtnText()
	return self:GetCfgText(3600151)
end

function LunaBattleLineAssistantUIApi:GetChangeBtnText(cd)
	if cd == nil or cd <= 0 then
		return self:GetCfgText(3600152)
	end

	return string.format("<color=#808080>%s</color>", cd)
end

function LunaBattleLineAssistantUIApi:GetSoulInfoPowerLabel()
	return self:GetCfgText(1214073)
end

function LunaBattleLineAssistantUIApi:GetSoulInfoLevelText(level)
	return "Lv." .. level
end

function LunaBattleLineAssistantUIApi:GetSkillGroupIndexText(index)
	if index == 1 then
		return "Ⅰ"
	elseif index == 2 then
		return "Ⅱ"
	elseif index == 3 then
		return "Ⅲ"
	end

	return "?"
end

function LunaBattleLineAssistantUIApi:GetSkillLevelText(level)
	if level == 0 then
		return ""
	end

	return "+" .. level
end

function LunaBattleLineAssistantUIApi:GetEquipLabel()
	return self:GetCfgText(3600153)
end

function LunaBattleLineAssistantUIApi:GetFriendLabel(isFriend)
	if isFriend then
		return self:GetCfgText(3600154)
	else
		return self:GetCfgText(3600155)
	end
end

LunaBattleLineAssistantUIApi:Init()
