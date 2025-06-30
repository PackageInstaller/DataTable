-- chunkname: @IQIGame\\UIExternalApi\\BattleMonsterInfoUIApi.lua

BattleMonsterInfoUIApi = BaseLangApi:Extend()

function BattleMonsterInfoUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("SkillLabel", self.GetSkillLabel)
	self:RegisterApi("BuffLabel", self.GetBuffLabel)
	self:RegisterApi("SkillNameText", self.GetSkillNameText)
	self:RegisterApi("SkillEffectText", self.GetSkillEffectText)
	self:RegisterApi("ResistantBuffs", self.GetResistantBuffs)
	self:RegisterApi("SkillShowTypes", self.GetSkillShowTypes)
	self:RegisterApi("SkillTypeOrder", self.GetSkillTypeOrder)
	self:RegisterApi("HpText", self.GetHpText)
	self:RegisterApi("ResistantHelperTipIcon", self.GetResistantHelperTipIcon)
	self:RegisterApi("ResistantHelperName", self.GetResistantHelperName)
	self:RegisterApi("ResistantHelperDesc", self.GetResistantHelperDesc)
	self:RegisterApi("ResistantBuffValue", self.GetResistantBuffValue)
end

function BattleMonsterInfoUIApi:GetTitleText()
	return self:GetCfgText(2600001)
end

function BattleMonsterInfoUIApi:GetSkillLabel()
	return self:GetCfgText(2600003)
end

function BattleMonsterInfoUIApi:GetBuffLabel()
	return self:GetCfgText(2600004)
end

function BattleMonsterInfoUIApi:GetSkillNameText(name, showType, releaseType)
	local type = ""

	if showType == 1 then
		type = self:GetCfgText(1210006)
	elseif showType == 2 then
		type = self:GetCfgText(1210007)
	elseif showType == 3 then
		type = self:GetCfgText(1210008)
	elseif showType == 4 then
		type = self:GetCfgText(1210009)
	end

	return type .. "·" .. self.TextColor[12] .. name .. self.TextColor[0]
end

function BattleMonsterInfoUIApi:GetSkillEffectText(desc)
	desc = self:SkillValueColor(desc, 29)

	return desc
end

function BattleMonsterInfoUIApi:GetResistantBuffs()
	return {
		101,
		102,
		103,
		104,
		105,
		106,
		107,
		108
	}
end

function BattleMonsterInfoUIApi:GetSkillShowTypes()
	return {
		1,
		2,
		3,
		4
	}
end

function BattleMonsterInfoUIApi:GetSkillTypeOrder()
	return {
		1,
		2,
		3,
		4
	}
end

function BattleMonsterInfoUIApi:GetHpText(curHp, maxHp)
	return curHp .. "/" .. maxHp
end

function BattleMonsterInfoUIApi:GetResistantHelperTipIcon()
	return self:GetResUrl(2800001)
end

function BattleMonsterInfoUIApi:GetResistantHelperName()
	return self:GetCfgText(2600004)
end

function BattleMonsterInfoUIApi:GetResistantHelperDesc()
	return self:GetCfgText(2600005)
end

function BattleMonsterInfoUIApi:GetResistantBuffValue(stack)
	if stack == 999 then
		return self:GetCfgText(2600006)
	else
		return stack .. "%"
	end
end

BattleMonsterInfoUIApi:Init()
