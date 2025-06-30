-- chunkname: @IQIGame\\UIExternalApi\\GuildDevelopUpGradeUIApi.lua

GuildDevelopUpGradeUIApi = BaseLangApi:Extend()

function GuildDevelopUpGradeUIApi:Init()
	self:RegisterApi("TextLevel", self.GetTextLevel)
	self:RegisterApi("TextTip", self.GetTextTip)
	self:RegisterApi("UpdateBtnLabel", self.GetUpdateBtnLabel)
	self:RegisterApi("TextCondition", self.GetTextCondition)
	self:RegisterApi("TextCostName", self.GetTextCostName)
	self:RegisterApi("TextCostNum", self.GetTextCostNum)
	self:RegisterApi("TextMax", self.GetTextMax)
end

function GuildDevelopUpGradeUIApi:GetTextMax()
	return self:GetCfgText(9100901)
end

function GuildDevelopUpGradeUIApi:GetTextCostNum(num, haveNum, top)
	if top then
		return string.format(" <color=#5cbcff>%s</color>/%s", num, haveNum)
	end

	return string.format(" <color=#ff5757>%s</color>/%s", num, haveNum)
end

function GuildDevelopUpGradeUIApi:GetTextCostName(str, top)
	if top then
		return str
	end

	return str
end

function GuildDevelopUpGradeUIApi:GetTextCondition(str, top)
	if top then
		return str
	end

	return str
end

function GuildDevelopUpGradeUIApi:GetUpdateBtnLabel()
	return self:GetCfgText(9100902)
end

function GuildDevelopUpGradeUIApi:GetTextTip()
	return self:GetCfgText(9100903)
end

function GuildDevelopUpGradeUIApi:GetTextLevel(lv, maxLv)
	if lv < maxLv then
		return string.format(self:GetCfgText(9100904), lv)
	end

	return self:GetCfgText(9100905)
end

GuildDevelopUpGradeUIApi:Init()
