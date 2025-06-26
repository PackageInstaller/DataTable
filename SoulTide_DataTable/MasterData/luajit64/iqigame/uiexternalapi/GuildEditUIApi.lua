-- chunkname: @IQIGame\\UIExternalApi\\GuildEditUIApi.lua

GuildEditUIApi = BaseLangApi:Extend()

function GuildEditUIApi:Init()
	self:RegisterApi("TextPolicy", self.GetTextPolicy)
	self:RegisterApi("TextAuditType", self.GetTextAuditType)
	self:RegisterApi("PolicyTitle", self.GetPolicyTitle)
	self:RegisterApi("AuditTypeTitle", self.GetAuditTypeTitle)
	self:RegisterApi("BtnCancelLabel", self.GetBtnCancelLabel)
	self:RegisterApi("BtnSureLabel", self.GetBtnSureLabel)
	self:RegisterApi("CostNumText", self.GetCostNumText)
	self:RegisterApi("TextPlaceholder", self.GetTextPlaceholder)
	self:RegisterApi("TagText", self.GetTagText)
end

function GuildEditUIApi:GetTagText()
	return self:GetCfgText(9101001)
end

function GuildEditUIApi:GetAuditTypeTitle()
	return self:GetCfgText(9101002)
end

function GuildEditUIApi:GetPolicyTitle()
	return self:GetCfgText(9101003)
end

function GuildEditUIApi:GetTextAuditType(type)
	if type == 1 then
		return self:GetCfgText(9101004)
	end

	return self:GetCfgText(9101005)
end

function GuildEditUIApi:GetTextPolicy(type)
	if type == 1 then
		return self:GetCfgText(9101006)
	end

	return self:GetCfgText(9101007)
end

function GuildEditUIApi:GetTextPlaceholder()
	return self:GetCfgText(9101008)
end

function GuildEditUIApi:GetCostNumText(num)
	return string.format("x%s", num)
end

function GuildEditUIApi:GetBtnSureLabel()
	return self:GetCfgText(9101009)
end

function GuildEditUIApi:GetBtnCancelLabel()
	return self:GetCfgText(9101010)
end

GuildEditUIApi:Init()
